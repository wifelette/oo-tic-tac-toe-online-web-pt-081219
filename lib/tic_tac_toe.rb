require "pry-byebug"

class TicTacToe

  attr_accessor :board

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [6,4,2],
    [0,4,8]
  ]

  def initialize(board = Array.new(9, " "))
    @board = board
    @winner = ""
  end

  def display_board
    counter = 0
    @board.map do |spot|
      if counter == 0
        print "-----------\n "
        print spot, " | "
        counter += 1
      elsif counter == 3 || counter == 6
        print "\n-----------\n "
        print spot, " | "
        counter += 1
      elsif counter == 2 || counter == 5 || counter == 8
        print spot, " "
        counter += 1
      elsif counter == 9
        print "\n-----------\n "
      else
        print spot, " | "
        counter += 1
      end
    end
    @board
  end

  def input_to_index(input)
    if input =~ /^[1-9]$/
      input.to_i - 1
    else
      nil
    end
  end

  def move(index, token = "X")
    @board[index] = token
  end

  # def position_taken?(index)
  #   new = input_to_index(index)
  #   # @board[index].fetch(100, false)
  #   @board[index].empty? ? false : true
  # end

  def position_taken?(index)
    if (@board[index] == " ")
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if (@board[index] == " ")
      return true
    else
      return false
    end
  end

  def turn
    puts "Hi! What spot?"
    raw_input = gets.chomp
    # binding.pry
    input = input_to_index(raw_input)
    if input == nil
      puts "That's not a valid move. Try again?"
      turn
    elsif valid_move?(input) == true
      move(input)
      display_board
    else
      puts "Nope! Taken. Try another spot?"
      turn
    end
    current_player
  end

  def turn_count
    counter = 0
    @board.each do |spot|
      if spot != " "
        counter += 1
      end
    end
    counter
  end

  def current_player
    x_counter = 0
    o_counter = 0
    @board.each do |spot|
      if spot == "X"
        x_counter += 1
      elsif spot == "O"
        o_counter += 1
      elsif spot == " "
      end
    end
    if x_counter == o_counter
      return "X"
    elsif x_counter > o_counter
      return "O"
    end
  end

  def won?
    x_player = []
    o_player = []

    @board.each.with_index do |value, spot|
      if value == "X"
        x_player << spot
      elsif value == "O"
        o_player << spot
      end
    end

    WIN_COMBINATIONS.each do |win_set|
      if (x_player & win_set).length == 3
        @winner = "X"
        return win_set
      elsif (o_player & win_set).length == 3
        @winner = "O"
        return win_set
      end
    end
    false
  end

  def full?
    if @board.include?(" ")
      false
    else
      true
    end
  end

  def draw?
    if full? && !won?
      true
    else
      false
    end
  end

  def over?
    if full? && !won? # a draw
      true
    elsif won?
      true
    else
      false
    end
  end

  def winner
    if won? == false
      nil
    else
      @winner
    end
  end

  def play
    # turn
    # if over? == true
    #   if draw? == true
    #     print "Cat's Game!"
    #   elsif won? == true
    #     if winner == "X"
    #       puts "Congratulations X!"
    #     elsif winner == "O"
    #       puts "Congratulations O!"
    #     end
    #   end
    # else
    #   # play
    # end

    until over?
      turn
    end

    if won?
      if winner == "X"
        puts "Congratulations X!"
      elsif winner == "O"
        puts "Congratulations O!"
      end
    elsif draw?
        print "Cat's Game!"
    end

  end
end
