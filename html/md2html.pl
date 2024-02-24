#!/usr/bin/env perl
use strict;
use warnings;

my $parameter = '--mathjax'; # 支出数学公式
$parameter = "$parameter --template=mathjax_template.html"; # 支出数学公式
$parameter = "$parameter --from=markdown"; # 设置输入格式
$parameter = "$parameter --css=table-style.css"; #  转换 Markdown 中的表格时显示框线
foreach (glob "../*.md") {
    my (undef, $name) = split m/\//;
    ($name) = split m/\./, $name;
    my $i = 0;
    open (OUT, "> junk.md") or die;
    print OUT "## $name\n";
    open (IN, "< $_") or die;
    foreach (<IN>) {
        if ($_ =~ '数据记录与计算') {
            $i = 1;
            next;
        }
        print OUT $_ if $i == 1;
    }
    close(IN);
    close(OUT);
    system "pandoc junk.md -o $name.html $parameter --metadata title=\"$name\"" if $i == 1;
}
unlink 'junk.md';