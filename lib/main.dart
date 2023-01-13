import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  int jogadas = 0;
  List<String> marcacoes = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(oScore.toString()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('$xScore'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _inserirMarcacao(index);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Text(
                        marcacoes[index],
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(228, 255, 255, 255),
            ),
            onPressed: _limparPlacar,
            child: Text(
              "Zerar o placar",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _inserirMarcacao(int index) {
    setState(() {
      if (marcacoes[index] == '' && oTurn) {
        marcacoes[index] = 'O';
      } else if (marcacoes[index] == '' && !oTurn) {
        marcacoes[index] = 'X';
      }
      oTurn = !oTurn;
      jogadas++;
      checarVencedor();
    });
  }

  void checarVencedor() {
    if (marcacoes[0] == marcacoes[1] &&
        marcacoes[1] == marcacoes[2] &&
        marcacoes[0] != '') {
      mostrarVencedor(marcacoes[0]);
    }
    if (marcacoes[3] == marcacoes[4] &&
        marcacoes[4] == marcacoes[5] &&
        marcacoes[3] != '') {
      mostrarVencedor(marcacoes[3]);
    }
    if (marcacoes[6] == marcacoes[7] &&
        marcacoes[7] == marcacoes[8] &&
        marcacoes[6] != '') {
      mostrarVencedor(marcacoes[6]);
    }
    if (marcacoes[0] == marcacoes[3] &&
        marcacoes[3] == marcacoes[6] &&
        marcacoes[0] != '') {
      mostrarVencedor(marcacoes[0]);
    }
    if (marcacoes[1] == marcacoes[4] &&
        marcacoes[4] == marcacoes[7] &&
        marcacoes[1] != '') {
      mostrarVencedor(marcacoes[1]);
    }
    if (marcacoes[2] == marcacoes[5] &&
        marcacoes[5] == marcacoes[8] &&
        marcacoes[2] != '') {
      mostrarVencedor(marcacoes[2]);
    }
    if (marcacoes[0] == marcacoes[4] &&
        marcacoes[4] == marcacoes[8] &&
        marcacoes[0] != '') {
      mostrarVencedor(marcacoes[0]);
    }
    if (marcacoes[2] == marcacoes[4] &&
        marcacoes[4] == marcacoes[6] &&
        marcacoes[6] != '') {
      mostrarVencedor(marcacoes[2]);
    } else if (jogadas == 9) {
      mostrarEmpate();
    }
  }

  void mostrarVencedor(String vencedor) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + vencedor + " \" ganhou!!!"),
            actions: [
              ElevatedButton(
                child: Text("Jogar novamente!"),
                onPressed: () {
                  _zerarJogo();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (vencedor == 'O') {
      oScore++;
    } else {
      xScore++;
    }
  }

  void mostrarEmpate() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("O jogo foi empate!"),
            actions: [
              ElevatedButton(
                child: Text("Jogar novamente!"),
                onPressed: () {
                  _zerarJogo();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _zerarJogo() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        marcacoes[i] = '';
      }
    });

    jogadas = 0;
  }

  void _limparPlacar() {
    setState(() {
      xScore = 0;
      oScore = 0;
    });
  }
}
