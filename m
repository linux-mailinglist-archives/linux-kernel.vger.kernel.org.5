Return-Path: <linux-kernel+bounces-98312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08347877848
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F31F21338
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE73A264;
	Sun, 10 Mar 2024 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="Bd00Tvnk"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959B3B190;
	Sun, 10 Mar 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710098558; cv=none; b=p+6U9MDEX3DFT+azFHZf4PYI3ooGL1Rox+F/XVxltbufzjqeJscnNm5w/1Tq0qMl8E5r32r8Hid/5jLJ5rv92yPewp5i/ckwCGIuD5IA3dEkv+NpgPXAljlPsM6cFrPZVz3Y6AafxJhZ3OkkfXjjgIN3S23EyzOitrNEgaH+U5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710098558; c=relaxed/simple;
	bh=Lc1pMRgsV+StSf5fgFNpvmYafFqXYMKdh+E4JPDHkIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ncj385EFMGKJ8pqnk1a8GHufesFZnny179iqLCSZ27koV0mrsFD9T0qZWxwlV+We7/4gGTjucEECwkgzbdDf//cH1+Zxcpvuvyd7qZcfqQUO278yOYk4bTZHHBt61KkPN1JYYj2CiDZbs/CQcG+yChJT42uDADnaDiFps+vbXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=Bd00Tvnk; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1710098526; x=1710703326; i=j.neuschaefer@gmx.net;
	bh=Lc1pMRgsV+StSf5fgFNpvmYafFqXYMKdh+E4JPDHkIM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Bd00TvnksM/H/dFC7U9XfpC05A/9jT7hukPQ2gkucaZ0ksg0dOFrwv+ho/g8rSS7
	 4MDMbtvRGrIKcfyAzGa1Tp/A+Yj6TwkzaCE6pi1SCHrUERVE9cnDbnSDofxh1al3E
	 rkl4KhTXRv6hwezrAJ/bp/W9twYdNpH07VCqZ5TmWw9RXdzSOPnssaAuefEoDhOXW
	 sBLR2ZC16QYBG0t/eJrzegG0mA6OFBBk4NNba2fEpHMCIB/QH0HcNNrOgDvUBW53u
	 Vwh2K1n3ywZWxNI6WoTKcYhQD1TJTBCmeeLlgyoqoAKDsN4cDvL45LB7LzqrPm5ug
	 My8FLUILVcDCgItSkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.216.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1rBBBJ0KLv-00hvec; Sun, 10
 Mar 2024 20:22:06 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-clk@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v10 4/4] ARM: dts: wpcm450: Switch clocks to clock controller
Date: Sun, 10 Mar 2024 20:21:02 +0100
Message-ID: <20240310192108.2747084-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
References: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CZOP/2JyhuYMjvSoJftgiK/2nFIgRon1+neVh/LZn4z7J6VfK+Y
 phi/XYNwa4bSKC6jy9/3KudhpuaCSWhKSnAvYt0goG/vWKXb0E9SIIDCkWj6VF420nX5Wa6
 Np3/bXESt4ZTzvjlR4m8nFawznti+83B1GljuO5cYG8N+gcWJbGj0tbZN83upD3iWlEP/GK
 ZseouWgpoYKKzhSS+0NvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z1xVzBzNInU=;NDd8KIAFtG7HWYEYhvWCeKkhzkg
 NR4AV0H13INfVrpjhwXC58BnoZ9BO0Pd7rlvVV7zHg6e4zIaFlWNTJdA/A8f4BgdOfJ9ktPP6
 QqK5ejKFY10a+I4iMJJGejcV3a+SrTO9zpsfDVQb0VIxKK86ASPEPp4fwk7/J7mSkdlH0wK9P
 YtHGsxbGZjEke4jWPANODol+gbw9kss6Ss8tyIHuKSZydKmflu2//O1sBnq4T9+y3Tjlio2dm
 jYY6FOQXaRGW9Zk/gmI09EyJibKgH/5zKrgEU8pO4Hu+8fHK6Qh10Vcps0mJb1oeKj6wFv5ZC
 WNJRGcISk2Eh0Ysk4M1uV7yvsarMCM5fR3n2tzoGXsX+1foHqZXS576AZsrSw5ynFAbCxkggm
 emkpnbcHLc+QWDHu50F3Y1oFMi69XHBxNSJCEgZd2Ir4DCFhURDKNQHKuH0WEnyH29wIxt31X
 X/U4/gwnhWu4tyBhu87sCfy0shO0QoZujirC2qGi8QnjTRCSDOdkB2PW61ReZnKsPIF6Dm0Bw
 tjje3eZeo5GugTsLZ5zwXJhYE4QnOUvd5AC/yz3PHyhQqZJsHrUMHVDJ4hlcknbJmNjEKUExq
 XBGIgii743CONhs6aCeaV/BWGaWzabALOrlBqKYSckZEmYMh+IGWpfmquVmgOMI0ocCybdEcJ
 oyr0KReDfa/BxUOmt6nQEFmWm8CAJZASMSVJJ1ihksLBmQizhCmhwQ3BPRmeZaf1EjH6V45sx
 Vh1dfapk8lzU01ai5YOFjUb3zugW3Kykxay3BYEPcFfTaT0TrYn2NCmIKj6ZSV41iWhdCIn8i
 jcqiGnSqb+Fe8nYJnkuSklRF2KYvU7DayUP18+6ecTTXA=

This change is incompatible with older kernels because it requires the
clock controller driver, but I think that's acceptable because WPCM450
support is generally still in an early phase.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

It's probably best to delay merging of this patch until after the driver
is merged; I'm including it here for review, and in case someone want's
to set up a shared branch between the clock and devicetree parts.

v10:
- Reintroducing this patch as part of the clock/reset controller series
=2D--
 .../arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index 9dfdd8f67319d3..7e3ea8b31151b3 100644
=2D-- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
@@ -2,6 +2,7 @@
 // Copyright 2021 Jonathan Neusch=C3=A4fer

 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/nuvoton,wpcm450-clk.h>

 / {
 	compatible =3D "nuvoton,wpcm450";
@@ -30,13 +31,6 @@ cpu@0 {
 		};
 	};

-	clk24m: clock-24mhz {
-		/* 24 MHz dummy clock */
-		compatible =3D "fixed-clock";
-		clock-frequency =3D <24000000>;
-		#clock-cells =3D <0>;
-	};
-
 	refclk: clock-48mhz {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
@@ -70,7 +64,7 @@ serial0: serial@b8000000 {
 			reg =3D <0xb8000000 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART0>;
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&bsp_pins>;
 			status =3D "disabled";
@@ -81,7 +75,7 @@ serial1: serial@b8000100 {
 			reg =3D <0xb8000100 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART1>;
 			status =3D "disabled";
 		};

@@ -89,14 +83,18 @@ timer0: timer@b8001000 {
 			compatible =3D "nuvoton,wpcm450-timer";
 			interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb8001000 0x1c>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_TIMER0>,
+				 <&clk WPCM450_CLK_TIMER1>,
+				 <&clk WPCM450_CLK_TIMER2>,
+				 <&clk WPCM450_CLK_TIMER3>,
+				 <&clk WPCM450_CLK_TIMER4>;
 		};

 		watchdog0: watchdog@b800101c {
 			compatible =3D "nuvoton,wpcm450-wdt";
 			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb800101c 0x4>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_WDT>;
 		};

 		aic: interrupt-controller@b8002000 {
@@ -480,7 +478,7 @@ fiu: spi-controller@c8000000 {
 			#size-cells =3D <0>;
 			reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
 			reg-names =3D "control", "memory";
-			clocks =3D <&clk 0>;
+			clocks =3D <&clk WPCM450_CLK_FIU>;
 			nuvoton,shm =3D <&shm>;
 			status =3D "disabled";
 		};
=2D-
2.43.0


