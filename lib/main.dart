// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:tictactoe/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
  var currentplayer = 'X';

  void drawXO(i) {
    if (grid[i] == '-') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });
      FindWinner(grid[i]);
    }
  }

  void reset() {
    setState(() {
      finalwinner = '';
      grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
    });
  }

  bool CheckMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  var finalwinner = '';
  void FindWinner(currentsign) {
    if (CheckMove(0, 1, 2, currentsign) ||
        CheckMove(3, 4, 5, currentsign) ||
        CheckMove(6, 7, 8, currentsign) ||
        CheckMove(0, 3, 6, currentsign) ||
        CheckMove(1, 4, 7, currentsign) ||
        CheckMove(2, 5, 8, currentsign) ||
        CheckMove(0, 4, 8, currentsign) ||
        CheckMove(2, 4, 6, currentsign)) {
      setState(() {
        finalwinner = currentsign;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primarycolor,
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              child: Text('TIC TAC TOE',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 100),
          if (finalwinner != '')
            Center(
              child: Container(
                // margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text('$finalwinner Won The Match',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w300)),
              ),
            ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            alignment: Alignment.center,
            // margin: EdgeInsets.all(20),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemCount: grid.length,
              itemBuilder: (context, index) => Material(
                borderRadius: BorderRadius.circular(10),
                color: MainColor.secondarycolor,
                child: InkWell(
                  // splashColor: Colors.black,
                  onTap: () => drawXO(index),
                  child: Center(
                    child: Text(
                      grid[index],
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 80),
          Center(
            child: GestureDetector(
              onTap: () => reset(),
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Color(0xFF4169e8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Play Again',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
