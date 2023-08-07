Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A583773129
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHGVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:24:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93160E6A;
        Mon,  7 Aug 2023 14:24:19 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1024066071DC;
        Mon,  7 Aug 2023 22:24:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691443458;
        bh=2uRACLUgOPi/Ps4I+8wopxV7zSDiO02U4+fu8x6OmQw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JLpxJaIuO5qIfUO7YoSxgJsFRziGAJK3Ta6EcbgsdFZQX919hXwWsIm11iredXmzU
         efFO97p5KeIZblbnRleCVq6bx44XSszncbcUOAIDkKaaR4pm6gVRBCcFVzflGLm4e3
         k2Ns6DVawtnSX2+EA/q8+/Y3wP/wudgYx8wC8IfmSYYqtSrO4J3qzQNn/dWHIlqZat
         Y1qqPfAYDGHJPkzChFYOp0BXuQc/X/kNWwWrwbZ8g/Hkc3HPEG5IykhaT7mwvvn8Hf
         idIOnz48ybbz6xCR1csyIYHjl16yzqWhZUxE6o4HQV4RA8MAAkd5VqN64h+2ZbxH2M
         FVJDBLHM5Acyw==
Message-ID: <412d37d5b55d8a17ab0b840ce307281178946b87.camel@collabora.com>
Subject: Re: [PATCH 4/5] docs: uapi: media: Add a layout diagram for MT2110T
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Mon, 07 Aug 2023 17:24:08 -0400
In-Reply-To: <cb78eb426c1008690fabbba37020d7828a6e11b1.camel@collabora.com>
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
         <20230804192737.19016-5-nicolas.dufresne@collabora.com>
         <2e08b843-d1f3-a095-8e5c-cc4997773040@collabora.com>
         <cb78eb426c1008690fabbba37020d7828a6e11b1.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 07 ao=C3=BBt 2023 =C3=A0 15:29 -0400, Nicolas Dufresne a =C3=A9cri=
t=C2=A0:
> Le lundi 07 ao=C3=BBt 2023 =C3=A0 20:40 +0200, Andrzej Pietrasiewicz a =
=C3=A9crit=C2=A0:
> > Hi Nicolas,
> >=20
> > W dniu 4.08.2023 o=C2=A021:27, Nicolas Dufresne pisze:
> > > This diagram details the partitioning done in each tiles.
> >=20
> > If I understand correctly there are 8 partitions in the diagram, each p=
artition=20
> > consists of 80 bytes, 64 bytes containing MSB data and 16 bytes contain=
ing LSB
> > data. The diagram says "MSB 8 bits" and "LSB 2 bits" which might be con=
fusing
> > because it suggests that the length of the partitions is maybe 8 bits p=
lus 2
> > bits. IOW it is not clear that the numbers (8 and 2) refer to the kind =
of=20
> > contents rather than lengths. Maybe to the left of the diagram should b=
e some=20
> > arrows/curly braces describing the partitions' lengths?
>=20
> You mean you'd add the partition height (4) in pixels ? Note, I'm thinkin=
g of
> using "8 MSB of pixel data", as it seem to translate to a better english =
"8 most
> significant bits of pixel data". I'm trying to avoid replacing the text, =
it only
> meant to be a visual support. An alternative, is really to leave the deta=
ils in
> the text, and label it "MSB of pixel data" and "LSB of pixel data". Any
> preference ?

Turns out I have also versed the low and high bit order in the doc, will fi=
x
that in next revision. The low bits partition come first.

>=20
> Nicolas
>=20
> >=20
> > Regards,
> >=20
> > Andrzej
> >=20
> > >=20
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > ---
> > >   .../userspace-api/media/v4l/mt2110t.svg       | 268 +++++++++++++++=
+++
> > >   1 file changed, 268 insertions(+)
> > >   create mode 100644 Documentation/userspace-api/media/v4l/mt2110t.sv=
g
> > >=20
> > > diff --git a/Documentation/userspace-api/media/v4l/mt2110t.svg b/Docu=
mentation/userspace-api/media/v4l/mt2110t.svg
> > > new file mode 100644
> > > index 000000000000..d4fc223f5fde
> > > --- /dev/null
> > > +++ b/Documentation/userspace-api/media/v4l/mt2110t.svg
> > > @@ -0,0 +1,268 @@
> > > +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > > +<!-- SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-no-invariants-or-l=
ater -->
> > > +<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Gr=
aphics/SVG/1.1/DTD/svg11.dtd">
> > > +<svg version=3D"1.2" width=3D"110mm" height=3D"215mm" viewBox=3D"0 0=
 11000 21500" preserveAspectRatio=3D"xMidYMid" fill-rule=3D"evenodd" stroke=
-width=3D"28.222" stroke-linejoin=3D"round" xmlns=3D"http://www.w3.org/2000=
/svg" xmlns:ooo=3D"http://xml.openoffice.org/svg/export" xmlns:xlink=3D"htt=
p://www.w3.org/1999/xlink" xmlns:presentation=3D"http://sun.com/xmlns/staro=
ffice/presentation" xmlns:smil=3D"http://www.w3.org/2001/SMIL20/" xmlns:ani=
m=3D"urn:oasis:names:tc:opendocument:xmlns:animation:1.0" xmlns:svg=3D"urn:=
oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xml:space=3D"preserve=
">
> > > + <defs class=3D"ClipPathGroup">
> > > +  <clipPath id=3D"presentation_clip_path" clipPathUnits=3D"userSpace=
OnUse">
> > > +   <rect x=3D"0" y=3D"0" width=3D"11000" height=3D"21500"/>
> > > +  </clipPath>
> > > +  <clipPath id=3D"presentation_clip_path_shrink" clipPathUnits=3D"us=
erSpaceOnUse">
> > > +   <rect x=3D"11" y=3D"21" width=3D"10978" height=3D"21457"/>
> > > +  </clipPath>
> > > + </defs>
> > > + <defs>
> > > +  <font id=3D"EmbeddedFont_1" horiz-adv-x=3D"2048">
> > > +   <font-face font-family=3D"Liberation Sans embedded" units-per-em=
=3D"2048" font-weight=3D"normal" font-style=3D"normal" ascent=3D"1852" desc=
ent=3D"423"/>
> > > +   <missing-glyph horiz-adv-x=3D"2048" d=3D"M 0,0 L 2047,0 2047,2047=
 0,2047 0,0 Z"/>
> > > +   <glyph unicode=3D"x" horiz-adv-x=3D"1006" d=3D"M 801,0 L 510,444 =
217,0 23,0 408,556 41,1082 240,1082 510,661 778,1082 979,1082 612,558 1002,=
0 801,0 Z"/>
> > > +   <glyph unicode=3D"t" horiz-adv-x=3D"531" d=3D"M 554,8 C 495,-8 43=
4,-16 372,-16 228,-16 156,66 156,229 L 156,951 31,951 31,1082 163,1082 216,=
1324 336,1324 336,1082 536,1082 536,951 336,951 336,268 C 336,216 345,180 3=
62,159 379,138 408,127 450,127 474,127 509,132 554,141 L 554,8 Z"/>
> > > +   <glyph unicode=3D"s" horiz-adv-x=3D"901" d=3D"M 950,299 C 950,197=
 912,118 835,63 758,8 650,-20 511,-20 376,-20 273,2 200,47 127,91 79,160 57=
,254 L 216,285 C 231,227 263,185 311,158 359,131 426,117 511,117 602,117 66=
9,131 712,159 754,187 775,229 775,285 775,328 760,362 731,389 702,416 654,4=
38 589,455 L 460,489 C 357,516 283,542 240,568 196,593 162,624 137,661 112,=
698 100,743 100,796 100,895 135,970 206,1022 276,1073 378,1099 513,1099 632=
,1099 727,1078 798,1036 868,994 912,927 931,834 L 769,814 C 759,862 732,899=
 689,925 645,950 586,963 513,963 432,963 372,951 333,926 294,901 275,864 27=
5,814 275,783 283,758 299,738 315,718 339,701 370,687 401,673 467,654 568,6=
29 663,605 732,583 774,563 816,542 849,520 874,495 898,470 917,442 930,410 =
943,377 950,340 950,299 Z"/>
> > > +   <glyph unicode=3D"p" horiz-adv-x=3D"953" d=3D"M 1053,546 C 1053,1=
69 920,-20 655,-20 488,-20 376,43 319,168 L 314,168 C 317,163 318,106 318,-=
2 L 318,-425 138,-425 138,861 C 138,972 136,1046 132,1082 L 306,1082 C 307,=
1079 308,1070 309,1054 310,1037 312,1012 314,978 315,944 316,921 316,908 L =
320,908 C 352,975 394,1024 447,1055 500,1086 569,1101 655,1101 788,1101 888=
,1056 954,967 1020,878 1053,737 1053,546 Z M 864,542 C 864,693 844,800 803,=
865 762,930 698,962 609,962 538,962 482,947 442,917 401,887 371,840 350,777=
 329,713 318,630 318,528 318,386 341,281 386,214 431,147 505,113 607,113 69=
6,113 762,146 803,212 844,277 864,387 864,542 Z"/>
> > > +   <glyph unicode=3D"i" horiz-adv-x=3D"187" d=3D"M 137,1312 L 137,14=
84 317,1484 317,1312 137,1312 Z M 137,0 L 137,1082 317,1082 317,0 137,0 Z"/=
>
> > > +   <glyph unicode=3D"b" horiz-adv-x=3D"953" d=3D"M 1053,546 C 1053,1=
69 920,-20 655,-20 573,-20 505,-5 451,25 396,54 352,102 318,168 L 316,168 C=
 316,147 315,116 312,74 309,31 307,7 306,0 L 132,0 C 136,36 138,110 138,223=
 L 138,1484 318,1484 318,1061 C 318,1018 317,967 314,908 L 318,908 C 351,97=
7 396,1027 451,1057 506,1087 574,1102 655,1102 792,1102 892,1056 957,964 10=
21,872 1053,733 1053,546 Z M 864,540 C 864,691 844,800 804,865 764,930 699,=
963 609,963 508,963 434,928 388,859 341,790 318,680 318,529 318,387 341,282=
 386,215 431,147 505,113 607,113 698,113 763,147 804,214 844,281 864,389 86=
4,540 Z"/>
> > > +   <glyph unicode=3D"S" horiz-adv-x=3D"1192" d=3D"M 1272,389 C 1272,=
259 1221,158 1120,87 1018,16 875,-20 690,-20 347,-20 148,99 93,338 L 278,37=
5 C 299,290 345,228 414,189 483,149 578,129 697,129 820,129 916,150 983,193=
 1050,235 1083,297 1083,379 1083,425 1073,462 1052,491 1031,520 1001,543 96=
3,562 925,581 880,596 827,609 774,622 716,635 652,650 541,675 456,699 399,7=
24 341,749 295,776 262,807 229,837 203,872 186,913 168,954 159,1000 159,105=
3 159,1174 205,1267 298,1332 390,1397 522,1430 694,1430 854,1430 976,1406 1=
061,1357 1146,1308 1205,1224 1239,1106 L 1051,1073 C 1030,1148 991,1202 933=
,1236 875,1269 795,1286 692,1286 579,1286 493,1267 434,1230 375,1193 345,11=
37 345,1063 345,1020 357,984 380,956 403,927 436,903 479,884 522,864 609,84=
0 738,811 781,801 825,791 868,781 911,770 952,758 991,744 1030,729 1067,712=
 1102,693 1136,674 1166,650 1191,622 1216,594 1236,561 1251,523 1265,485 12=
72,440 1272,389 Z"/>
> > > +   <glyph unicode=3D"M" horiz-adv-x=3D"1377" d=3D"M 1366,0 L 1366,94=
0 C 1366,1044 1369,1144 1375,1240 1342,1121 1313,1027 1287,960 L 923,0 789,=
0 420,960 364,1130 331,1240 334,1129 338,940 338,0 168,0 168,1409 419,1409 =
794,432 C 807,393 820,351 833,306 845,261 853,228 857,208 862,235 874,275 8=
91,330 908,384 919,418 925,432 L 1293,1409 1538,1409 1538,0 1366,0 Z"/>
> > > +   <glyph unicode=3D"L" horiz-adv-x=3D"927" d=3D"M 168,0 L 168,1409 =
359,1409 359,156 1071,156 1071,0 168,0 Z"/>
> > > +   <glyph unicode=3D"B" horiz-adv-x=3D"1112" d=3D"M 1258,397 C 1258,=
272 1212,174 1121,105 1030,35 903,0 740,0 L 168,0 168,1409 680,1409 C 1011,=
1409 1176,1295 1176,1067 1176,984 1153,914 1106,857 1059,800 993,762 908,74=
3 1020,730 1106,692 1167,631 1228,569 1258,491 1258,397 Z M 984,1044 C 984,=
1120 958,1174 906,1207 854,1240 779,1256 680,1256 L 359,1256 359,810 680,81=
0 C 782,810 858,829 909,868 959,906 984,965 984,1044 Z M 1065,412 C 1065,57=
8 948,661 715,661 L 359,661 359,153 730,153 C 847,153 932,175 985,218 1038,=
261 1065,326 1065,412 Z"/>
> > > +   <glyph unicode=3D"8" horiz-adv-x=3D"980" d=3D"M 1050,393 C 1050,2=
63 1009,162 926,89 843,16 725,-20 570,-20 419,-20 302,16 217,87 132,158 89,=
260 89,391 89,483 115,560 168,623 221,686 288,724 370,737 L 370,741 C 293,7=
59 233,798 189,858 144,918 122,988 122,1069 122,1176 162,1263 243,1330 323,=
1397 431,1430 566,1430 705,1430 814,1397 895,1332 975,1267 1015,1178 1015,1=
067 1015,986 993,916 948,856 903,796 842,758 765,743 L 765,739 C 855,724 92=
5,686 975,625 1025,563 1050,486 1050,393 Z M 828,1057 C 828,1216 741,1296 5=
66,1296 481,1296 417,1276 373,1236 328,1196 306,1136 306,1057 306,976 329,9=
15 375,873 420,830 485,809 568,809 653,809 717,829 762,868 806,907 828,970 =
828,1057 Z M 863,410 C 863,497 837,563 785,608 733,652 660,674 566,674 475,=
674 403,650 352,603 301,555 275,489 275,406 275,212 374,115 572,115 670,115=
 743,139 791,186 839,233 863,307 863,410 Z"/>
> > > +   <glyph unicode=3D"6" horiz-adv-x=3D"980" d=3D"M 1049,461 C 1049,3=
12 1009,195 928,109 847,23 736,-20 594,-20 435,-20 314,39 230,157 146,275 1=
04,447 104,672 104,916 148,1103 235,1234 322,1365 447,1430 608,1430 821,143=
0 955,1334 1010,1143 L 838,1112 C 803,1227 725,1284 606,1284 503,1284 424,1=
236 368,1141 311,1045 283,906 283,725 316,786 362,832 421,864 480,895 548,9=
11 625,911 755,911 858,870 935,789 1011,708 1049,598 1049,461 Z M 866,453 C=
 866,555 841,634 791,689 741,744 671,772 582,772 498,772 430,748 379,699 32=
7,650 301,582 301,496 301,387 328,298 382,229 435,160 504,125 588,125 675,1=
25 743,154 792,213 841,271 866,351 866,453 Z"/>
> > > +   <glyph unicode=3D"3" horiz-adv-x=3D"1006" d=3D"M 1049,389 C 1049,=
259 1008,158 925,87 842,16 724,-20 571,-20 428,-20 315,12 230,77 145,141 94=
,236 78,362 L 264,379 C 288,212 390,129 571,129 662,129 733,151 785,196 836=
,241 862,307 862,395 862,472 833,532 774,575 715,618 629,639 518,639 L 416,=
639 416,795 514,795 C 613,795 689,817 744,860 798,903 825,962 825,1038 825,=
1113 803,1173 759,1217 714,1260 648,1282 561,1282 482,1282 418,1262 369,122=
1 320,1180 291,1123 283,1049 L 102,1063 C 115,1178 163,1268 246,1333 328,13=
98 434,1430 563,1430 704,1430 814,1397 893,1332 971,1266 1010,1174 1010,105=
7 1010,967 985,894 935,838 884,781 811,743 715,723 L 715,719 C 820,708 902,=
672 961,613 1020,554 1049,479 1049,389 Z"/>
> > > +   <glyph unicode=3D"2" horiz-adv-x=3D"954" d=3D"M 103,0 L 103,127 C=
 137,205 179,274 228,334 277,393 328,447 382,496 436,544 490,589 543,630 59=
6,671 643,713 686,754 729,795 763,839 790,884 816,929 829,981 829,1038 829,=
1115 806,1175 761,1218 716,1261 653,1282 572,1282 495,1282 432,1261 383,122=
0 333,1178 304,1119 295,1044 L 111,1061 C 124,1174 172,1263 255,1330 337,13=
97 443,1430 572,1430 714,1430 823,1397 900,1330 976,1263 1014,1167 1014,104=
4 1014,989 1002,935 977,881 952,827 914,773 865,719 816,665 721,581 582,468=
 505,405 444,349 399,299 354,248 321,200 301,153 L 1036,153 1036,0 103,0 Z"=
/>
> > > +   <glyph unicode=3D"1" horiz-adv-x=3D"927" d=3D"M 156,0 L 156,153 5=
15,153 515,1237 197,1010 197,1180 530,1409 696,1409 696,153 1039,153 1039,0=
 156,0 Z"/>
> > > +   <glyph unicode=3D" " horiz-adv-x=3D"556"/>
> > > +  </font>
> > > + </defs>
> > > + <defs class=3D"TextShapeIndex">
> > > +  <g ooo:slide=3D"id1" ooo:id-list=3D"id3 id4 id5 id6 id7 id8 id9 id=
10 id11 id12 id13 id14 id15 id16 id17 id18 id19 id20 id21 id22 id23 id24 id=
25 id26 id27 id28"/>
> > > + </defs>
> > > + <defs class=3D"EmbeddedBulletChars">
> > > +  <g id=3D"bullet-char-template-57356" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 580,1141 L 1163,571 580,0 -4,571 580,1141 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-57354" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 8,1128 L 1137,1128 1137,0 8,0 8,1128 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-10146" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 174,0 L 602,739 174,1481 1456,739 174,0 Z M 1358,739=
 L 309,1346 659,739 1358,739 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-10132" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 2015,739 L 1276,0 717,0 1260,543 174,543 174,936 126=
0,936 717,1481 1274,1481 2015,739 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-10007" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 0,-2 C -7,14 -16,27 -25,37 L 356,567 C 262,823 215,9=
52 215,954 215,979 228,992 255,992 264,992 276,990 289,987 310,991 331,999 =
354,1012 L 381,999 492,748 772,1049 836,1024 860,1049 C 881,1039 901,1025 9=
22,1006 886,937 835,863 770,784 769,783 710,716 594,584 L 774,223 C 774,196=
 753,168 711,139 L 727,119 C 717,90 699,76 672,76 641,76 570,178 457,381 L =
164,-76 C 142,-110 111,-127 72,-127 30,-127 9,-110 8,-76 1,-67 -2,-52 -2,-3=
2 -2,-23 -1,-13 0,-2 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-10004" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 285,-33 C 182,-33 111,30 74,156 52,228 41,333 41,471=
 41,549 55,616 82,672 116,743 169,778 240,778 293,778 328,747 346,684 L 369=
,508 C 377,444 397,411 428,410 L 1163,1116 C 1174,1127 1196,1133 1229,1133 =
1271,1133 1292,1118 1292,1087 L 1292,965 C 1292,929 1282,901 1262,881 L 442=
,47 C 390,-6 338,-33 285,-33 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-9679" transform=3D"scale(0.000488281=
25,-0.00048828125)">
> > > +   <path d=3D"M 813,0 C 632,0 489,54 383,161 276,268 223,411 223,592=
 223,773 276,916 383,1023 489,1130 632,1184 813,1184 992,1184 1136,1130 124=
5,1023 1353,916 1407,772 1407,592 1407,412 1353,268 1245,161 1136,54 992,0 =
813,0 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-8226" transform=3D"scale(0.000488281=
25,-0.00048828125)">
> > > +   <path d=3D"M 346,457 C 273,457 209,483 155,535 101,586 74,649 74,=
723 74,796 101,859 155,911 209,963 273,989 346,989 419,989 480,963 531,910 =
582,859 608,796 608,723 608,648 583,586 532,535 482,483 420,457 346,457 Z"/=
>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-8211" transform=3D"scale(0.000488281=
25,-0.00048828125)">
> > > +   <path d=3D"M -4,459 L 1135,459 1135,606 -4,606 -4,459 Z"/>
> > > +  </g>
> > > +  <g id=3D"bullet-char-template-61548" transform=3D"scale(0.00048828=
125,-0.00048828125)">
> > > +   <path d=3D"M 173,740 C 173,903 231,1043 346,1159 462,1274 601,133=
2 765,1332 928,1332 1067,1274 1183,1159 1299,1043 1357,903 1357,740 1357,57=
7 1299,437 1183,322 1067,206 928,148 765,148 601,148 462,206 346,322 231,43=
7 173,577 173,740 Z"/>
> > > +  </g>
> > > + </defs>
> > > + <g>
> > > +  <g id=3D"id2" class=3D"Master_Slide">
> > > +   <g id=3D"bg-id2" class=3D"Background"/>
> > > +   <g id=3D"bo-id2" class=3D"BackgroundObjects"/>
> > > +  </g>
> > > + </g>
> > > + <g class=3D"SlideGroup">
> > > +  <g>
> > > +   <g id=3D"container-id1">
> > > +    <g id=3D"id1" class=3D"Slide" clip-path=3D"url(#presentation_cli=
p_path)">
> > > +     <g class=3D"Page">
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id3">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"1349" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,3=
100 L 50,3100 50,1350 10050,1350 10050,3100 5050,3100 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"2445"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id4">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"3099" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,3=
850 L 50,3850 50,3100 10050,3100 10050,3850 5050,3850 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"3695"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id5">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"3849" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,5=
600 L 50,5600 50,3850 10050,3850 10050,5600 5050,5600 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"4945"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id6">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"5599" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,6=
350 L 50,6350 50,5600 10050,5600 10050,6350 5050,6350 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"6195"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id7">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"6349" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,8=
100 L 50,8100 50,6350 10050,6350 10050,8100 5050,8100 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"7445"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id8">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"8099" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,8=
850 L 50,8850 50,8100 10050,8100 10050,8850 5050,8850 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"8695"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id9">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"8849" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
0600 L 50,10600 50,8850 10050,8850 10050,10600 5050,10600 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"9945"><tspan fill=3D=
"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspan><=
/tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id10">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"10599" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
1350 L 50,11350 50,10600 10050,10600 10050,11350 5050,11350 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"11195"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id11">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"11349" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
3100 L 50,13100 50,11350 10050,11350 10050,13100 5050,13100 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"12445"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id12">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"13099" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
3850 L 50,13850 50,13100 10050,13100 10050,13850 5050,13850 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"13695"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id13">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"13849" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
5600 L 50,15600 50,13850 10050,13850 10050,15600 5050,15600 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"14945"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id14">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"15599" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
6350 L 50,16350 50,15600 10050,15600 10050,16350 5050,16350 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"16195"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id15">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"16349" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
8100 L 50,18100 50,16350 10050,16350 10050,18100 5050,18100 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"17445"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id16">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"18099" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,1=
8850 L 50,18850 50,18100 10050,18100 10050,18850 5050,18850 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"18695"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id17">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"18849" width=3D"10003" height=3D"1753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,2=
0600 L 50,20600 50,18850 10050,18850 10050,20600 5050,20600 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3515" y=3D"19945"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">MSB 8 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id18">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"20599" width=3D"10003" height=3D"753"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" d=3D"M 5050,2=
1350 L 50,21350 50,20600 10050,20600 10050,21350 5050,21350 Z"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"3604" y=3D"21195"><tspan fill=
=3D"rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">LSB 2 bits</tspa=
n></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.MeasureShape">
> > > +       <g id=3D"id19">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"49" y=3D"25" width=3D"10003" height=3D"15477"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(0,0,0)" d=3D"M 337,650 L 9=
763,650"/>
> > > +        <path fill=3D"rgb(0,0,0)" stroke=3D"none" d=3D"M 50,650 L 35=
0,750 350,550 50,650 Z"/>
> > > +        <path fill=3D"rgb(0,0,0)" stroke=3D"none" d=3D"M 10050,650 L=
 9750,550 9750,750 10050,650 Z"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(0,0,0)" d=3D"M 50,15500 L =
50,450"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(0,0,0)" d=3D"M 10050,1350 =
L 10050,450"/>
> > > +        <text class=3D"SVGTextShape"><tspan class=3D"TextParagraph" =
font-family=3D"Liberation Sans, sans-serif" font-size=3D"635px" font-weight=
=3D"400"><tspan class=3D"TextPosition" x=3D"4253" y=3D"468"><tspan fill=3D"=
rgb(0,0,0)" stroke=3D"none" style=3D"white-space: pre">16 px</tspan></tspan=
></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.MeasureShape">
> > > +       <g id=3D"id20">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"10049" y=3D"1349" width=3D"903" height=3D"20003"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(0,0,0)" d=3D"M 10750,1637 =
L 10750,21063"/>
> > > +        <path fill=3D"rgb(0,0,0)" stroke=3D"none" d=3D"M 10750,1350 =
L 10650,1650 10850,1650 10750,1350 Z"/>
> > > +        <path fill=3D"rgb(0,0,0)" stroke=3D"none" d=3D"M 10750,21350=
 L 10850,21050 10650,21050 10750,21350 Z"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(0,0,0)" d=3D"M 10050,1350 =
L 10950,1350"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(0,0,0)" d=3D"M 10050,21350=
 L 10950,21350"/>
> > > +        <text class=3D"SVGTextShape" transform=3D"rotate(-90 10699 1=
2114)"><tspan class=3D"TextParagraph" font-family=3D"Liberation Sans, sans-=
serif" font-size=3D"635px" font-weight=3D"400"><tspan class=3D"TextPosition=
" x=3D"10699" y=3D"12114"><tspan fill=3D"rgb(0,0,0)" stroke=3D"none" style=
=3D"white-space: pre">32 px</tspan></tspan></tspan></text>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id21">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"1309" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,3850 L 50,3850 50,1350 10050,=
1350 10050,3850 5050,3850 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id22">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"3809" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,6350 L 50,6350 50,3850 10050,=
3850 10050,6350 5050,6350 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id23">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"6309" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,8850 L 50,8850 50,6350 10050,=
6350 10050,8850 5050,8850 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id24">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"8809" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,11350 L 50,11350 50,8850 1005=
0,8850 10050,11350 5050,11350 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id25">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"11309" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,13850 L 50,13850 50,11350 100=
50,11350 10050,13850 5050,13850 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id26">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"13809" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,16350 L 50,16350 50,13850 100=
50,13850 10050,16350 5050,16350 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id27">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"16309" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,18850 L 50,18850 50,16350 100=
50,16350 10050,18850 5050,18850 Z"/>
> > > +       </g>
> > > +      </g>
> > > +      <g class=3D"com.sun.star.drawing.CustomShape">
> > > +       <g id=3D"id28">
> > > +        <rect class=3D"BoundingBox" stroke=3D"none" fill=3D"none" x=
=3D"9" y=3D"18809" width=3D"10083" height=3D"2583"/>
> > > +        <path fill=3D"none" stroke=3D"rgb(52,101,164)" stroke-width=
=3D"81" stroke-linejoin=3D"round" d=3D"M 5050,21350 L 50,21350 50,18850 100=
50,18850 10050,21350 5050,21350 Z"/>
> > > +       </g>
> > > +      </g>
> > > +     </g>
> > > +    </g>
> > > +   </g>
> > > +  </g>
> > > + </g>
> > > +</svg>
> >=20
>=20

