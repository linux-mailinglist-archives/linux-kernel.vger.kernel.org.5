Return-Path: <linux-kernel+bounces-152099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1212A8AB908
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A01C20EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F4BE65;
	Sat, 20 Apr 2024 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZROEpAtw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC101D52A;
	Sat, 20 Apr 2024 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581515; cv=none; b=YCzVnmSd3cOY3YJ9uNwYJAu8cyZPb2LXW0FvDrMG26QQ9rerYpftMegE3B7EVHH02EQ2BRLPl/H6rQf5FP0h50z8Wn0jQu8hnkvwaxCjxrGe1FmPL4tBrkuIm089alM+l7ZfG/l2Ph6K2bYi7fPPFT4RBYSzhnSWDL5/sicOgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581515; c=relaxed/simple;
	bh=yAv8A8d5HtpFVwFlBGJjw6UsqMUcFN0y1tQgcL0XdkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=neEI2/oBgOpS1O9zT++9Lqjyvv2CAnXly1i+9PEUiYQicX/QjGqf1BmcxK1OizJ2jTFQ2t4Q/FPb8o5brJh2jVKEGrJPd/8g/JHz0Kh9tP1ErJgMRaS0pxDcnQmi4jwX41ocQCgbqpWOK/sUe7D5haug5ECyvceawziBAMdXkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZROEpAtw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43K2p3Xt053265;
	Fri, 19 Apr 2024 21:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713581463;
	bh=n7XyI8Oc0s7LIDFgb+xPry19bu9RJp9Dra9JXiq4Hxs=;
	h=From:To:CC:Subject:Date;
	b=ZROEpAtwaRJDuFWNxSATBgBN4KqMQ8z3BOF/BiB/y+wwqy1V1Lhxiv919p0Ll7aJ+
	 zoPEGpipB6bU+ZgEbY7M4MspBCQ92nBCFgwGdN05UbYK74lcHtGePNhRGnbeCESZQN
	 RlmPSGYWcwBkduh6ZT0gTwWMdK+agvTLiFTy+UUU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43K2p3L8090839
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 21:51:03 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 21:51:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 21:51:02 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43K2ouqR058270;
	Fri, 19 Apr 2024 21:50:57 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <kevin-lu@ti.com>, <baojun.xu@ti.com>, <13916275206@139.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>, <robinchen@ti.com>,
        <linux-kernel@vger.kernel.org>, <mimperial@lenovo.com>,
        <cchen50@lenovo.com>, <soyer@irl.hu>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Add dsp firmware for Thinkpad ICE-1 laptop
Date: Sat, 20 Apr 2024 10:50:50 +0800
Message-ID: <20240420025051.1079-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add tas2781 dsp firmware for Thinkpad ICE-1 laptop.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 WHENCE                     |   2 ++
 ti/tas2781/TAS2XXX2234.bin | Bin 0 -> 35220 bytes
 2 files changed, 2 insertions(+)
 create mode 100644 ti/tas2781/TAS2XXX2234.bin

diff --git a/WHENCE b/WHENCE
index f8760d3d..8e84401d 100644
--- a/WHENCE
+++ b/WHENCE
@@ -7848,6 +7848,7 @@ Originates from https://git.codelinaro.org/linaro/qcomlt/audioreach-topology.git
 --------------------------------------------------------------------------
 
 Driver: ti-tas2781 - tas2781 firmware
+File: ti/tas2781/TAS2XXX2234.bin
 File: ti/tas2781/TAS2XXX387D.bin
 File: ti/tas2781/TAS2XXX387E.bin
 File: ti/tas2781/TAS2XXX387F.bin
@@ -7876,6 +7877,7 @@ File: ti/tas2781/TAS2XXX38DF.bin
 File: ti/tas2781/TAS2XXX38E0.bin
 File: ti/tas2781/TIAS2781RCA2.bin
 File: ti/tas2781/TIAS2781RCA4.bin
+Link: TAS2XXX2234.bin -> ti/tas2781/TAS2XXX2234.bin
 Link: TAS2XXX387D.bin -> ti/tas2781/TAS2XXX387D.bin
 Link: TAS2XXX387E.bin -> ti/tas2781/TAS2XXX387E.bin
 Link: TAS2XXX387F.bin -> ti/tas2781/TAS2XXX387F.bin
diff --git a/ti/tas2781/TAS2XXX2234.bin b/ti/tas2781/TAS2XXX2234.bin
new file mode 100644
index 0000000000000000000000000000000000000000..48d5332b0648743947e3fd6ee670cb6f07d8b16b
GIT binary patch
literal 35220
zcmeHQ33yaRwm!FdNoSKt0wj=-4q^->V8E~ncmoC+L?;A3iHZ;wktMRo9+qyPX%sSS
zu7MF@#zALBa78fz?XZkN!VH6oii7fSlo4F`R1hS|egCO@Z)h+<cq;FE^KO0L>8d)n
z>YS=mr<Sg@Lx&FSi5`4-$)MTKk#Zj?3c)CJ&&S8Y`}fLe({5P%%=THC?b~-@{AHU+
z!~n&ibww0JjfMaU>-rdq8#Hag*a`Q#Z=E>mo>259yA`t8jKFLw$_ix#QPNXz_a;H{
z#fpolMr}z|z|=yn?iQ3;taQeAk$&zQhf_ns*5Ma4saV8tyn&(dL?#K*84w>X<BMPn
z36+wC$KeyXwrtW`O<zvhsbbB!+3!*8{(g3+@Q9<Z6;VNbM34six7&sPEj!1{5+1UN
zTym4vI!5vlG_%;|BEQG(lyN{8woRnbda;kjfrcA2Z2tXr0u2Egoj{|Z$c<bDx^{nS
zy92adVOm0Uy8S&7CM~Q0all`!6Z@Q*%c?<hd&*SMuz`jm)W}sLH%vubL;`<1<f)}s
zGL2%5Hi9QP-B)MS${|%PWcRY_$W;LcJ@0p>L<V-#3xRTaE|5)|{BNa1fquBZXNqf4
zPx8sMRJh1hMeSS^<3@V#k+fQ<Go*YfXe83%q({}+lD`A|xg2X$KikWyDX&-)L4Uaj
z1}aiSU|))@xJE&qsRz<|W?7Z;HGfCA1b<M84GD8C!rW$rK|Y<ENfVQqrs4j*bXSn@
zms4_7cxsB|?{pE;xCOH9?%zYnq$S>`$DusnA)CZ3gGMR*Ztz$^T2dPWcYw6y>!dqK
zs;E%hVxN)*eg}ldMhM#(<-}#DK>h;p?$*O9Wun5VO8#Lee}oZgM7i)Nh@;5x;QNrl
z<8$GG{%IM<rN01W>j`U%GI)e&g;-ud2;T~zgp;P)S=XUIF(`}q{&j-H4vKSCxv%E3
z;P?_+WbgLxrcRQ-i_5CzEXeeEF`g12*GYbVB>Da6B$!uzWU0s%M^Q40zk>OUCFn>H
zvdEFRU^vpxc;vwoxt;Zkv^FWsCsdz6H(BydRjUx+g)-3jhckcsmSQb(jlV##A<lL&
zh2s4K;P*$97(-ChWx^lq3qEL~K-XSC*Gk>uy2N>Ekv$JIb7UG=zflKCb1dU;$b%hq
zASzJNN`d}`ah{e{+s_8_Tj3-0KLYaaXLl8Ajwo>pB?N+sEs(2-K(+&V4c67Ek|*d7
z*6E{OdQi7f2T7xT%)_5+50mkCP=r6<?g~^WVF8cg03Bx_f4G#5OiM3{XFH%OI$h=;
zsp~&<h5UJ}2Vq>to0Ashk#V4x;JroaP)|G8LzD+~gnmqh%u4a?bwl=y&jY>_<BK(>
zqj;8QYG;u@l$kP3(#V4hRK)W*OJ)9}z+X#>mb@y&b`hiwXph2>cZKOLpM>`3TpZ|o
zQXeDiXCmnQ96UQPJtGe1RYCbndW_Taz-f;BhGj1*pyxs8|Gvm0l7BSnA9PIW()(k{
ze-P!|6YbRdNXJ2zN91<Y9Xry)?U#V8oyg<I%c@e&KsQhqKwA~43#^~%;13<C$zCe?
z)+bW~FZo~Pf}Tp5Cqd?UXluTgbkR--kG&c^!$iI#j`b)eVVy4!9ByNM33!GptRI2g
z;Ub_S-FMo<CC|Gkfo)T7iZ%NWOwV6oM@`R2VR}w?Oa^3wjHCP;K>zX)cSQCI=E3z6
z_3;Dfz@4((pvz(;B|y$u@C%fMopn(JBM<tsWj`R>b?7+S4u_94`$@mQ6&ZA9LN9%Y
zAHO`43YS%jb^J}{4}FQ`AA|B|*#&Pw{Ys}rebK)KNue6`uTk#A6x7E~>}NOl>TQC@
zL1eFitU=3zwjh@VL+H96{gAAGv=;twl%F#b@sr8$v&@7_<Det2f`7MSv`m*$Ru`5L
zr%%dR&{Pspq!Q6R&lX?rJ^M<W&))Y7@ArjiKuPn}&Q^46s*~u`f^1P)S!v=`(_z@>
z$8ARTs7^%T1+}4qwJt%8cf@>x^cN8N?<^k?Btl+I)65{DZWTy|S`&mT;YIqO>L4{P
z-%mX7qJ)wX23x-gqz%1_!am){Sc*xyiQB0-vdN*>37{Ab(+xM=z~Aw0CP9^K{RR}a
z85fwC1ymd$9p7VMN0yYVj;O5MtHMo99Od{`+J10+JwuEBY1?KVsCp7a@_T2zc%+Mu
zh-u6jdYf={x^GaAy?eHJYpVMM5viu;sh44q=>77)T(OIWbN*x=nLqmQ$l(t_2yLaj
z3c=4&vYPr!St~w{H>>2Oc8)H6HmGptZR+P>==bki_A&HoaqAj}8;AU6G{X&#4rs@a
zzAvwep=HFNHyILdzI_z~NW1~K3c&d<B=q5Id_JOJ5W+bOAwf!~PeZj(7i((J#2F=n
zAcP<gpe{%Rk!pk>XwCsXKoD>k02&tpf-p}zIp^r*Eocmd#n6m3Th(s!XE$hAb=bc3
zp+6TMUAbvb?~ls9LFn!PH=udd<ALF4U!QP&%@;ibHBa}9uP+YtE*9Yx9U}Lm6q%0h
z7laNo3SQF3$($A!O5A<dW~6Hjx#Ia7MXb;J2i@F0)(*D{U^_6X)vL4C9Ozq|cFH+t
zaO;8@-j7QbWpBN&==EL?Jy2HDd){lawV6v6m6qR8vA@TLPHp#Wwk;pq>CS1l#ICPe
zs2=sr%b8QTu;nSi<vwd~-;cm=CZYdc(0$Bz-bPElo?kKaIsP_#<>QV2Ib>yOlj)fw
zKC4P?&bXwg@IAgMi6!3RtW@8>4!-Cu{^VYU`LPd|&O5&K$bxGtH_rQFd~XIMwbpRl
zT94tV#R+5${dcG_zxj?lpWsbgoIZcY-%7nnzd6cK7tYb3Bm((xQPfPDI9l7bqJ(<M
ze4$@r|Af3d`akJ<=_&JDDDM8HJsK}=+DPib%ukQgZ>N?YQ{pyEHo=T*`q?&dvl{Jk
z299<8fo(IciIe=%FNJ=i>km3iFvFXEwrg>;X-B9$&g7qc`s{%{+!RO?#P6vOGkScV
zGpmT)so$bem_&^ZEG1Fq9JTn%0mSjST+uIun*R}<5CWGIU-C!4#OVowM&qaF9ycL`
zBq;+wxvu8W$+y`q`g%g^2e(Zwy;PhELTGMRQ_SLLW6@To!Ou7tP4ee{NjJ9Xhgu$d
zu*HX|Y)^l1<+zn=myfRtH>=U#8ZG?o#z$BO=iHw+K5(qvaT@s0WE0G|rk`ySH)r1O
z$`;NanZvf^-_S)SjnHo<j-vYIns6~3*Lw!rx1Zm{w)gWM4>R;FEZ@k$jfiYW#y8nW
zK6n_o{9}=Sb}LbbsPP-4sZG&#X*VcYN1K<lRz@~ltCYQ$Qw!fO>EcbC{HAyR+%#`Z
z)Fzfe-p&&}vdf-GGI_AgcoWe16-t=?!2%^~SRZQJV!8z89|!*M&u!D7tN+WvFVh{i
zLnh4ri>r8X&d1Y(pl3qthB@om&9<`O{k9a<xZJCKxteiow6dY!p&i}A6+s2Gj2L{}
z(3Slm`tusQW&Rtv2)gy7Z<m6bH}|^zLGZZHaK10ZDg94%)zs&@u|1|^%GN*M^~AT5
ze`A-F)zZPa-8kN~g;#Z1(YjQVS{dDJGNu1%i1(e_pCViDe-aJ+gzcz7ZC*HCbN6Pk
z@=dobCS`^#`SebmXBTf+m$@0vzaH(SH27*YMI7IDrgXR0ek^Udt<igvozvp_P`@7d
zKbP_~g{>`;{F{K2IC0E&N{d&fT{~Je5`Oa=UruB<LlD677D;Qo%%>sx{f59r!R8(c
zy%Mp!Wp71F29)V3z+n<s_vJWqkBpj+&tykgq;Os2d_@d-Me>iAIW25H>*(5?cjI%L
z4nK2(63P-dy!P46N4;m}z3YoQRID-rZ5Q1aSwyt-@21V^;(Su{h5+}2)b;Hm>32-4
zV*QoiXubs<=PrsIc-r<((SI?ibRW}${v~k!L(*yJDyNmhv8hYHs3h}s<(jvaBTdmk
z8H&8p_O&cyujc(Q$2<Cko90vB8C(xl;A9!8zf0GAlai&I`8NfBSHuxtLazZX*kRwF
zY|in6fQYvTz0B^D8Gq^jcG|9Gk8JqUnEGfbj}04|d3M*W;jo=!*8QI21p#gVjF*3g
z6b=0F4~w3?mhHh)y6lqqZ|0({)h(M}_>FP-H(uYvgiTF-tG9oY{jTX}+r-sXzr5Oj
z?%DCz>~=C^#eXMTY_#Iay+$9=K=MzN<uAY8yZ?(dgmSB1koj2kV^erM)s6dxad#ei
z>ybaU=*ae%1t)_~ubz5GUAU>wxj$KSeBP}r+oHJnFD=deI7xZ$-w`I5aZNw?51}L%
zvETew)G@r_qTQ#yV%wxq7miXE4>Q3GXZqQ$#qroBL*@KMKoHjfUPpmH2|u?HJ5X!#
z&|bYn<V2NnA<y`~RF`30X>(3idTSrK9q|wva}>mG@dP~F{64PZs1e+`fMmcR0FN!%
z4a0FHt{ZGY6ox@PB>@a0zawoT2t<}FtG3La@jOq2KYGOf2QT#FKcD^`-%MU`{ahm`
zjjj*P|4$GUlt@XVLIbg&IDe2&SYJSa%u{n0t$QZM4txiI@Zm?+O<gw4;6(vS!*V73
zk6NqJZIG`X&Irq1Y4rbDQqE@GGi{c=G+wP^rF3waCfDXki4HvMWk52_ax6yq`T!X0
zI~O4i(#R93(#Wa>7pDuf@#j!4U;c~AhHc=*dg(K|{}B8OGXHLqoIX6jcc#l}tpG4>
znQsHf_(=dZ246FLm@2WlVzLuD#dN~PUVvv=GaXE1Apa?nKl=^C`INdB4IA@CQinRh
zX8pau$p1`7jBreY;c6ogm$e(fb%5hH2HXbV{Ba&I$q)W5B!9@6_<wc~Bn~0z>)^gy
z&!Rv*m7+#`E(eyY(+&F`*qpvzM%_VO!Tc>L(5;AaIQAOpQsEBc4}cErG3PHN|7%=y
zrRFiRe7aK9>MZBKrC$EEIHZr$$WUv7a9z$khA!_Rh;_n%+Ifu7`3sqU%<%H~A^O}r
zM#;tIG479B5JdUptJ_`;c3Dv1z1(?>(D@6=Kh;H;$EZ9vkAcL%%ql4<adiGVOZ~%p
z5nNumJ373rrXKCq{$xf?T2bmw{H1D;uq1YHT;GCSn7e6%u~211>x2K`Ig?O$0DhgK
zF^>U{&j&>d!ol*t&h?{t44%tiVB-S>0fzxB%+mn=bXoHl#A^to7-h_DS5uyoko?nJ
z^efC~fQ77^Z!up3HXAm#8?Q<?=f4&7kLNVV{sVBg1AbmV2?Dy|X67gQN9NyJ>OZ#;
zxqzSFPyVPsyh#7Z{L>|WqfgdTeuaK9L5n^$L-KzGJW)<uRNO}@ZrEt&lr-JOFB>dd
z5shAj*?2d6LYb}1hR9egN8pRKW^1k4T5Gn}nk{;C><6&cY^^n0Yt7bLv$fW2tu<Q=
z5Y7KQhY#a_3`UIBnys~FYpvN@YqrMP!Fg-DD%uNc&DL78t!oWd&RJP&wwQgf)@*Cn
zmaR2gxt?pS*;;G1=sK-6TL^*25HP&fV6E9&Yqr*!Ems5#s_Wf*ZmrqYuG?B`wsIkm
z7Xz&|Te-(6WKYxo<uzO0|Bfy(EhU@W;i5JEOJR{biemO-Sy$mQkMZlcSZqnewgZW4
z;)9KFO##hD5G8iR60r&#A|)e^yR9B4i=3}*d`6GcndzbLy%Ad#x?w+L_d|LZl}_<y
z4@viCwz08h2=;p3?IS8kAsXqy?ii%;Ufvr4dmJ^KO-*g|s6bfkp_u~Qw8KO*K%~e`
zN|Opw5KT$L30{O(y3+&rA`SCUa(uwY<3txWu+@EDMyAW2$x%2*ab#C{yznFvaNb!N
z8O{;Mdqwu@ZZ}6^`nlvt`{mEQ@EMOQdEP~yFX8P?Fw&i-kD=Hd;W>wo$k*{uBxSL(
z*joR$&TM0?*E+L}mQED#IaTY-wzd9mo!J&+tTWrjS$5n*V4c}E_dH*zz0MfJ6j*1r
zvA-0@1w!{c^Z51LUT2J7VXQOT)|qYV%(iuATmO@%pEs!Q>^R!hnPi>Ww$5x@XSOx#
z%(iuA+d8vto!Pd|Y?~v83vBDm_99561CG*R-9j3ycSytg5)|vqHp@VQb!J=F3oN>s
zM!$P5%V(Y04xPV{|39oV+t!(F{a%M$)E4W^_NAWLK7akcsa)sf_5W2^%9m^M=dJ(m
z)N$7OKi@GSWo51ZV=sWd{y%c!gwbQ~op%55sbeQj7^dG!pEq&D*a>d)Zu(&%SHus?
z>g>M7Q#5SK4a4MC3)EV<GqVi6Tdm<SQbQ$0Nx>Bmyi24R^bet2xKt$^3L0VTSBWNU
zSMlrL;&4|)<DlF-!h1KuMlmsrDSmX9rgdMYrr$|d*WH+P;jH^It@|>q`!dm*SodY}
zeXG`enbv)oyf4tYFVng&^VhyF(=}=o4+V`e9R9P68pXpw9@j}|!JZJ4t&CU3!=DJ?
ze=$x{I(4P$=xC~TmXnfj*l@p#?>Wj=Wh-oR7qb1lu+>fu6RW(Vyi?B@)cDU7P58?c
zItJZojX@zfnA&>;tvlO)e2=?zXZt1H<E}!Ftn>fY`G4#DzjbH3b!WSEXFK2beueLB
z|EV$PH9Xb{F+DG14BGpr#-JmI7mgia%&cB~5;Y_Rq0ai|R!=G?F|Ortaw5jbS7dHA
zG+DJ{!w}?U<M=-)-XaP$7o*{O@T(Z_{R`fkAGPgE@ARurFf7a(dexlmrPYDkziKyU
z&-!l|E|nhs1FQADMRch&aFCM!OIvRdS#J?RnWXv8e2eIVj<>O{*ZUTc4<Ak7dTqW%
z#P1M=g7J=vvOam=dBATG8SfmiZN7CB`rZ*Yh1@=v@JqZ!q=IG;z;Dm6n{7MtN~ybF
ztn00q7=+<)zvf#+v%xzE9v7Or+D7XwBJ8~S4|<D8Ild^__Dolt-M8K%vfd)n-#x15
zEuxE$Yvmr09^8cd`g5#Xlr8m)MSrz9*3h=Gu6FUVan@MWdKdFz?`wuAob@i|xi>KX
zSKh_6#-iV0P3?-ji)oET|Np*=X^lm#cQMVeXYCu9b-k4-*Yz*5&VOz!dQC_-%FbVO
Mu2sW}@t0!$8{<JnWdHyG

literal 0
HcmV?d00001

-- 
2.34.1


