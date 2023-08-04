Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BB77090E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjHDT2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjHDT2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:28:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B671BF;
        Fri,  4 Aug 2023 12:27:59 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A9FA66071BC;
        Fri,  4 Aug 2023 20:27:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691177278;
        bh=fEfrE1N2g63pRTvitamxCMKZ1ziXiBr1RyUOiNjvvv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrlbyMJ2oOONQyazsZbz+idXA/jQnnpQ2vzc3MGwfc8h4MPj7AuZUmLZWrd2We7NV
         90Aj9lgMovi5ZP5Sdtn2iqt6Xhkd3pft8ibY6LsTs/Mi4J+xCTwb0/r9iTcYgfS7WL
         0vmOwyJ1bkXMXDw+HCV1dYJaMZNca/oEybE7Vt1Buwj/5j9WIrpA9RhCTytrwo9aNB
         WUY1IVKEKaFV57tSr+peHMiuelVRUoF3Jy8egh/JyDAZKjflBN8Sg6WtqRReDHkJ4O
         4edQWHtYL+NKIeQlqF42NBh0u5pUsHubPYRZsQTBSPu7tvgoxUJuyxf8+1xiT4Bj9P
         Lxv1xnEaft3tA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/5] docs: uapi: media: Add a layout diagram for MT2110T
Date:   Fri,  4 Aug 2023 15:27:36 -0400
Message-Id: <20230804192737.19016-5-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This diagram details the partitioning done in each tiles.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../userspace-api/media/v4l/mt2110t.svg       | 268 ++++++++++++++++++
 1 file changed, 268 insertions(+)
 create mode 100644 Documentation/userspace-api/media/v4l/mt2110t.svg

diff --git a/Documentation/userspace-api/media/v4l/mt2110t.svg b/Documentation/userspace-api/media/v4l/mt2110t.svg
new file mode 100644
index 000000000000..d4fc223f5fde
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/mt2110t.svg
@@ -0,0 +1,268 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!-- SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-no-invariants-or-later -->
+<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
+<svg version="1.2" width="110mm" height="215mm" viewBox="0 0 11000 21500" preserveAspectRatio="xMidYMid" fill-rule="evenodd" stroke-width="28.222" stroke-linejoin="round" xmlns="http://www.w3.org/2000/svg" xmlns:ooo="http://xml.openoffice.org/svg/export" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:presentation="http://sun.com/xmlns/staroffice/presentation" xmlns:smil="http://www.w3.org/2001/SMIL20/" xmlns:anim="urn:oasis:names:tc:opendocument:xmlns:animation:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xml:space="preserve">
+ <defs class="ClipPathGroup">
+  <clipPath id="presentation_clip_path" clipPathUnits="userSpaceOnUse">
+   <rect x="0" y="0" width="11000" height="21500"/>
+  </clipPath>
+  <clipPath id="presentation_clip_path_shrink" clipPathUnits="userSpaceOnUse">
+   <rect x="11" y="21" width="10978" height="21457"/>
+  </clipPath>
+ </defs>
+ <defs>
+  <font id="EmbeddedFont_1" horiz-adv-x="2048">
+   <font-face font-family="Liberation Sans embedded" units-per-em="2048" font-weight="normal" font-style="normal" ascent="1852" descent="423"/>
+   <missing-glyph horiz-adv-x="2048" d="M 0,0 L 2047,0 2047,2047 0,2047 0,0 Z"/>
+   <glyph unicode="x" horiz-adv-x="1006" d="M 801,0 L 510,444 217,0 23,0 408,556 41,1082 240,1082 510,661 778,1082 979,1082 612,558 1002,0 801,0 Z"/>
+   <glyph unicode="t" horiz-adv-x="531" d="M 554,8 C 495,-8 434,-16 372,-16 228,-16 156,66 156,229 L 156,951 31,951 31,1082 163,1082 216,1324 336,1324 336,1082 536,1082 536,951 336,951 336,268 C 336,216 345,180 362,159 379,138 408,127 450,127 474,127 509,132 554,141 L 554,8 Z"/>
+   <glyph unicode="s" horiz-adv-x="901" d="M 950,299 C 950,197 912,118 835,63 758,8 650,-20 511,-20 376,-20 273,2 200,47 127,91 79,160 57,254 L 216,285 C 231,227 263,185 311,158 359,131 426,117 511,117 602,117 669,131 712,159 754,187 775,229 775,285 775,328 760,362 731,389 702,416 654,438 589,455 L 460,489 C 357,516 283,542 240,568 196,593 162,624 137,661 112,698 100,743 100,796 100,895 135,970 206,1022 276,1073 378,1099 513,1099 632,1099 727,1078 798,1036 868,994 912,927 931,834 L 769,814 C 759,862 732,899 689,925 645,950 586,963 513,963 432,963 372,951 333,926 294,901 275,864 275,814 275,783 283,758 299,738 315,718 339,701 370,687 401,673 467,654 568,629 663,605 732,583 774,563 816,542 849,520 874,495 898,470 917,442 930,410 943,377 950,340 950,299 Z"/>
+   <glyph unicode="p" horiz-adv-x="953" d="M 1053,546 C 1053,169 920,-20 655,-20 488,-20 376,43 319,168 L 314,168 C 317,163 318,106 318,-2 L 318,-425 138,-425 138,861 C 138,972 136,1046 132,1082 L 306,1082 C 307,1079 308,1070 309,1054 310,1037 312,1012 314,978 315,944 316,921 316,908 L 320,908 C 352,975 394,1024 447,1055 500,1086 569,1101 655,1101 788,1101 888,1056 954,967 1020,878 1053,737 1053,546 Z M 864,542 C 864,693 844,800 803,865 762,930 698,962 609,962 538,962 482,947 442,917 401,887 371,840 350,777 329,713 318,630 318,528 318,386 341,281 386,214 431,147 505,113 607,113 696,113 762,146 803,212 844,277 864,387 864,542 Z"/>
+   <glyph unicode="i" horiz-adv-x="187" d="M 137,1312 L 137,1484 317,1484 317,1312 137,1312 Z M 137,0 L 137,1082 317,1082 317,0 137,0 Z"/>
+   <glyph unicode="b" horiz-adv-x="953" d="M 1053,546 C 1053,169 920,-20 655,-20 573,-20 505,-5 451,25 396,54 352,102 318,168 L 316,168 C 316,147 315,116 312,74 309,31 307,7 306,0 L 132,0 C 136,36 138,110 138,223 L 138,1484 318,1484 318,1061 C 318,1018 317,967 314,908 L 318,908 C 351,977 396,1027 451,1057 506,1087 574,1102 655,1102 792,1102 892,1056 957,964 1021,872 1053,733 1053,546 Z M 864,540 C 864,691 844,800 804,865 764,930 699,963 609,963 508,963 434,928 388,859 341,790 318,680 318,529 318,387 341,282 386,215 431,147 505,113 607,113 698,113 763,147 804,214 844,281 864,389 864,540 Z"/>
+   <glyph unicode="S" horiz-adv-x="1192" d="M 1272,389 C 1272,259 1221,158 1120,87 1018,16 875,-20 690,-20 347,-20 148,99 93,338 L 278,375 C 299,290 345,228 414,189 483,149 578,129 697,129 820,129 916,150 983,193 1050,235 1083,297 1083,379 1083,425 1073,462 1052,491 1031,520 1001,543 963,562 925,581 880,596 827,609 774,622 716,635 652,650 541,675 456,699 399,724 341,749 295,776 262,807 229,837 203,872 186,913 168,954 159,1000 159,1053 159,1174 205,1267 298,1332 390,1397 522,1430 694,1430 854,1430 976,1406 1061,1357 1146,1308 1205,1224 1239,1106 L 1051,1073 C 1030,1148 991,1202 933,1236 875,1269 795,1286 692,1286 579,1286 493,1267 434,1230 375,1193 345,1137 345,1063 345,1020 357,984 380,956 403,927 436,903 479,884 522,864 609,840 738,811 781,801 825,791 868,781 911,770 952,758 991,744 1030,729 1067,712 1102,693 1136,674 1166,650 1191,622 1216,594 1236,561 1251,523 1265,485 1272,440 1272,389 Z"/>
+   <glyph unicode="M" horiz-adv-x="1377" d="M 1366,0 L 1366,940 C 1366,1044 1369,1144 1375,1240 1342,1121 1313,1027 1287,960 L 923,0 789,0 420,960 364,1130 331,1240 334,1129 338,940 338,0 168,0 168,1409 419,1409 794,432 C 807,393 820,351 833,306 845,261 853,228 857,208 862,235 874,275 891,330 908,384 919,418 925,432 L 1293,1409 1538,1409 1538,0 1366,0 Z"/>
+   <glyph unicode="L" horiz-adv-x="927" d="M 168,0 L 168,1409 359,1409 359,156 1071,156 1071,0 168,0 Z"/>
+   <glyph unicode="B" horiz-adv-x="1112" d="M 1258,397 C 1258,272 1212,174 1121,105 1030,35 903,0 740,0 L 168,0 168,1409 680,1409 C 1011,1409 1176,1295 1176,1067 1176,984 1153,914 1106,857 1059,800 993,762 908,743 1020,730 1106,692 1167,631 1228,569 1258,491 1258,397 Z M 984,1044 C 984,1120 958,1174 906,1207 854,1240 779,1256 680,1256 L 359,1256 359,810 680,810 C 782,810 858,829 909,868 959,906 984,965 984,1044 Z M 1065,412 C 1065,578 948,661 715,661 L 359,661 359,153 730,153 C 847,153 932,175 985,218 1038,261 1065,326 1065,412 Z"/>
+   <glyph unicode="8" horiz-adv-x="980" d="M 1050,393 C 1050,263 1009,162 926,89 843,16 725,-20 570,-20 419,-20 302,16 217,87 132,158 89,260 89,391 89,483 115,560 168,623 221,686 288,724 370,737 L 370,741 C 293,759 233,798 189,858 144,918 122,988 122,1069 122,1176 162,1263 243,1330 323,1397 431,1430 566,1430 705,1430 814,1397 895,1332 975,1267 1015,1178 1015,1067 1015,986 993,916 948,856 903,796 842,758 765,743 L 765,739 C 855,724 925,686 975,625 1025,563 1050,486 1050,393 Z M 828,1057 C 828,1216 741,1296 566,1296 481,1296 417,1276 373,1236 328,1196 306,1136 306,1057 306,976 329,915 375,873 420,830 485,809 568,809 653,809 717,829 762,868 806,907 828,970 828,1057 Z M 863,410 C 863,497 837,563 785,608 733,652 660,674 566,674 475,674 403,650 352,603 301,555 275,489 275,406 275,212 374,115 572,115 670,115 743,139 791,186 839,233 863,307 863,410 Z"/>
+   <glyph unicode="6" horiz-adv-x="980" d="M 1049,461 C 1049,312 1009,195 928,109 847,23 736,-20 594,-20 435,-20 314,39 230,157 146,275 104,447 104,672 104,916 148,1103 235,1234 322,1365 447,1430 608,1430 821,1430 955,1334 1010,1143 L 838,1112 C 803,1227 725,1284 606,1284 503,1284 424,1236 368,1141 311,1045 283,906 283,725 316,786 362,832 421,864 480,895 548,911 625,911 755,911 858,870 935,789 1011,708 1049,598 1049,461 Z M 866,453 C 866,555 841,634 791,689 741,744 671,772 582,772 498,772 430,748 379,699 327,650 301,582 301,496 301,387 328,298 382,229 435,160 504,125 588,125 675,125 743,154 792,213 841,271 866,351 866,453 Z"/>
+   <glyph unicode="3" horiz-adv-x="1006" d="M 1049,389 C 1049,259 1008,158 925,87 842,16 724,-20 571,-20 428,-20 315,12 230,77 145,141 94,236 78,362 L 264,379 C 288,212 390,129 571,129 662,129 733,151 785,196 836,241 862,307 862,395 862,472 833,532 774,575 715,618 629,639 518,639 L 416,639 416,795 514,795 C 613,795 689,817 744,860 798,903 825,962 825,1038 825,1113 803,1173 759,1217 714,1260 648,1282 561,1282 482,1282 418,1262 369,1221 320,1180 291,1123 283,1049 L 102,1063 C 115,1178 163,1268 246,1333 328,1398 434,1430 563,1430 704,1430 814,1397 893,1332 971,1266 1010,1174 1010,1057 1010,967 985,894 935,838 884,781 811,743 715,723 L 715,719 C 820,708 902,672 961,613 1020,554 1049,479 1049,389 Z"/>
+   <glyph unicode="2" horiz-adv-x="954" d="M 103,0 L 103,127 C 137,205 179,274 228,334 277,393 328,447 382,496 436,544 490,589 543,630 596,671 643,713 686,754 729,795 763,839 790,884 816,929 829,981 829,1038 829,1115 806,1175 761,1218 716,1261 653,1282 572,1282 495,1282 432,1261 383,1220 333,1178 304,1119 295,1044 L 111,1061 C 124,1174 172,1263 255,1330 337,1397 443,1430 572,1430 714,1430 823,1397 900,1330 976,1263 1014,1167 1014,1044 1014,989 1002,935 977,881 952,827 914,773 865,719 816,665 721,581 582,468 505,405 444,349 399,299 354,248 321,200 301,153 L 1036,153 1036,0 103,0 Z"/>
+   <glyph unicode="1" horiz-adv-x="927" d="M 156,0 L 156,153 515,153 515,1237 197,1010 197,1180 530,1409 696,1409 696,153 1039,153 1039,0 156,0 Z"/>
+   <glyph unicode=" " horiz-adv-x="556"/>
+  </font>
+ </defs>
+ <defs class="TextShapeIndex">
+  <g ooo:slide="id1" ooo:id-list="id3 id4 id5 id6 id7 id8 id9 id10 id11 id12 id13 id14 id15 id16 id17 id18 id19 id20 id21 id22 id23 id24 id25 id26 id27 id28"/>
+ </defs>
+ <defs class="EmbeddedBulletChars">
+  <g id="bullet-char-template-57356" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 580,1141 L 1163,571 580,0 -4,571 580,1141 Z"/>
+  </g>
+  <g id="bullet-char-template-57354" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 8,1128 L 1137,1128 1137,0 8,0 8,1128 Z"/>
+  </g>
+  <g id="bullet-char-template-10146" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 174,0 L 602,739 174,1481 1456,739 174,0 Z M 1358,739 L 309,1346 659,739 1358,739 Z"/>
+  </g>
+  <g id="bullet-char-template-10132" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 2015,739 L 1276,0 717,0 1260,543 174,543 174,936 1260,936 717,1481 1274,1481 2015,739 Z"/>
+  </g>
+  <g id="bullet-char-template-10007" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 0,-2 C -7,14 -16,27 -25,37 L 356,567 C 262,823 215,952 215,954 215,979 228,992 255,992 264,992 276,990 289,987 310,991 331,999 354,1012 L 381,999 492,748 772,1049 836,1024 860,1049 C 881,1039 901,1025 922,1006 886,937 835,863 770,784 769,783 710,716 594,584 L 774,223 C 774,196 753,168 711,139 L 727,119 C 717,90 699,76 672,76 641,76 570,178 457,381 L 164,-76 C 142,-110 111,-127 72,-127 30,-127 9,-110 8,-76 1,-67 -2,-52 -2,-32 -2,-23 -1,-13 0,-2 Z"/>
+  </g>
+  <g id="bullet-char-template-10004" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 285,-33 C 182,-33 111,30 74,156 52,228 41,333 41,471 41,549 55,616 82,672 116,743 169,778 240,778 293,778 328,747 346,684 L 369,508 C 377,444 397,411 428,410 L 1163,1116 C 1174,1127 1196,1133 1229,1133 1271,1133 1292,1118 1292,1087 L 1292,965 C 1292,929 1282,901 1262,881 L 442,47 C 390,-6 338,-33 285,-33 Z"/>
+  </g>
+  <g id="bullet-char-template-9679" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 813,0 C 632,0 489,54 383,161 276,268 223,411 223,592 223,773 276,916 383,1023 489,1130 632,1184 813,1184 992,1184 1136,1130 1245,1023 1353,916 1407,772 1407,592 1407,412 1353,268 1245,161 1136,54 992,0 813,0 Z"/>
+  </g>
+  <g id="bullet-char-template-8226" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 346,457 C 273,457 209,483 155,535 101,586 74,649 74,723 74,796 101,859 155,911 209,963 273,989 346,989 419,989 480,963 531,910 582,859 608,796 608,723 608,648 583,586 532,535 482,483 420,457 346,457 Z"/>
+  </g>
+  <g id="bullet-char-template-8211" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M -4,459 L 1135,459 1135,606 -4,606 -4,459 Z"/>
+  </g>
+  <g id="bullet-char-template-61548" transform="scale(0.00048828125,-0.00048828125)">
+   <path d="M 173,740 C 173,903 231,1043 346,1159 462,1274 601,1332 765,1332 928,1332 1067,1274 1183,1159 1299,1043 1357,903 1357,740 1357,577 1299,437 1183,322 1067,206 928,148 765,148 601,148 462,206 346,322 231,437 173,577 173,740 Z"/>
+  </g>
+ </defs>
+ <g>
+  <g id="id2" class="Master_Slide">
+   <g id="bg-id2" class="Background"/>
+   <g id="bo-id2" class="BackgroundObjects"/>
+  </g>
+ </g>
+ <g class="SlideGroup">
+  <g>
+   <g id="container-id1">
+    <g id="id1" class="Slide" clip-path="url(#presentation_clip_path)">
+     <g class="Page">
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id3">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="1349" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,3100 L 50,3100 50,1350 10050,1350 10050,3100 5050,3100 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="2445"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id4">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="3099" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,3850 L 50,3850 50,3100 10050,3100 10050,3850 5050,3850 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="3695"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id5">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="3849" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,5600 L 50,5600 50,3850 10050,3850 10050,5600 5050,5600 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="4945"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id6">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="5599" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,6350 L 50,6350 50,5600 10050,5600 10050,6350 5050,6350 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="6195"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id7">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="6349" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,8100 L 50,8100 50,6350 10050,6350 10050,8100 5050,8100 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="7445"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id8">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="8099" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,8850 L 50,8850 50,8100 10050,8100 10050,8850 5050,8850 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="8695"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id9">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="8849" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,10600 L 50,10600 50,8850 10050,8850 10050,10600 5050,10600 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="9945"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id10">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="10599" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,11350 L 50,11350 50,10600 10050,10600 10050,11350 5050,11350 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="11195"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id11">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="11349" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,13100 L 50,13100 50,11350 10050,11350 10050,13100 5050,13100 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="12445"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id12">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="13099" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,13850 L 50,13850 50,13100 10050,13100 10050,13850 5050,13850 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="13695"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id13">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="13849" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,15600 L 50,15600 50,13850 10050,13850 10050,15600 5050,15600 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="14945"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id14">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="15599" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,16350 L 50,16350 50,15600 10050,15600 10050,16350 5050,16350 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="16195"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id15">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="16349" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,18100 L 50,18100 50,16350 10050,16350 10050,18100 5050,18100 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="17445"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id16">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="18099" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,18850 L 50,18850 50,18100 10050,18100 10050,18850 5050,18850 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="18695"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id17">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="18849" width="10003" height="1753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,20600 L 50,20600 50,18850 10050,18850 10050,20600 5050,20600 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3515" y="19945"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">MSB 8 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id18">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="20599" width="10003" height="753"/>
+        <path fill="none" stroke="rgb(52,101,164)" d="M 5050,21350 L 50,21350 50,20600 10050,20600 10050,21350 5050,21350 Z"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="3604" y="21195"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">LSB 2 bits</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.MeasureShape">
+       <g id="id19">
+        <rect class="BoundingBox" stroke="none" fill="none" x="49" y="25" width="10003" height="15477"/>
+        <path fill="none" stroke="rgb(0,0,0)" d="M 337,650 L 9763,650"/>
+        <path fill="rgb(0,0,0)" stroke="none" d="M 50,650 L 350,750 350,550 50,650 Z"/>
+        <path fill="rgb(0,0,0)" stroke="none" d="M 10050,650 L 9750,550 9750,750 10050,650 Z"/>
+        <path fill="none" stroke="rgb(0,0,0)" d="M 50,15500 L 50,450"/>
+        <path fill="none" stroke="rgb(0,0,0)" d="M 10050,1350 L 10050,450"/>
+        <text class="SVGTextShape"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="4253" y="468"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">16 px</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.MeasureShape">
+       <g id="id20">
+        <rect class="BoundingBox" stroke="none" fill="none" x="10049" y="1349" width="903" height="20003"/>
+        <path fill="none" stroke="rgb(0,0,0)" d="M 10750,1637 L 10750,21063"/>
+        <path fill="rgb(0,0,0)" stroke="none" d="M 10750,1350 L 10650,1650 10850,1650 10750,1350 Z"/>
+        <path fill="rgb(0,0,0)" stroke="none" d="M 10750,21350 L 10850,21050 10650,21050 10750,21350 Z"/>
+        <path fill="none" stroke="rgb(0,0,0)" d="M 10050,1350 L 10950,1350"/>
+        <path fill="none" stroke="rgb(0,0,0)" d="M 10050,21350 L 10950,21350"/>
+        <text class="SVGTextShape" transform="rotate(-90 10699 12114)"><tspan class="TextParagraph" font-family="Liberation Sans, sans-serif" font-size="635px" font-weight="400"><tspan class="TextPosition" x="10699" y="12114"><tspan fill="rgb(0,0,0)" stroke="none" style="white-space: pre">32 px</tspan></tspan></tspan></text>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id21">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="1309" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,3850 L 50,3850 50,1350 10050,1350 10050,3850 5050,3850 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id22">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="3809" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,6350 L 50,6350 50,3850 10050,3850 10050,6350 5050,6350 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id23">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="6309" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,8850 L 50,8850 50,6350 10050,6350 10050,8850 5050,8850 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id24">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="8809" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,11350 L 50,11350 50,8850 10050,8850 10050,11350 5050,11350 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id25">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="11309" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,13850 L 50,13850 50,11350 10050,11350 10050,13850 5050,13850 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id26">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="13809" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,16350 L 50,16350 50,13850 10050,13850 10050,16350 5050,16350 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id27">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="16309" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,18850 L 50,18850 50,16350 10050,16350 10050,18850 5050,18850 Z"/>
+       </g>
+      </g>
+      <g class="com.sun.star.drawing.CustomShape">
+       <g id="id28">
+        <rect class="BoundingBox" stroke="none" fill="none" x="9" y="18809" width="10083" height="2583"/>
+        <path fill="none" stroke="rgb(52,101,164)" stroke-width="81" stroke-linejoin="round" d="M 5050,21350 L 50,21350 50,18850 10050,18850 10050,21350 5050,21350 Z"/>
+       </g>
+      </g>
+     </g>
+    </g>
+   </g>
+  </g>
+ </g>
+</svg>
-- 
2.40.1

