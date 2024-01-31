Return-Path: <linux-kernel+bounces-46803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E4844486
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923751F2C44D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2413E20A;
	Wed, 31 Jan 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KiZoFa/w"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74613AA3A;
	Wed, 31 Jan 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718449; cv=none; b=Oi+PRXGdh70HwDK9fogs46j+tnmEojwoV2kz4MJ2f4qrIgLcE/q1I9+qceK3Z5vhrklxMjXct7lKqhLu9q4YyNR3erVNS/FoWrH02/Qh9C2xHbyjoyZAtE3L+kfj0cDEE3vGTXmZgs1GrT265IFJDBW5oBeukbzECsDK1GRA7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718449; c=relaxed/simple;
	bh=HqObXiqSC3dEUjyipJUNMEwoy5nZeCsf6HXhXD1lC9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hU8lOy96ll76Qd34qrA96p6ass8tkE91f2wjSJL0fBfzWvrbo2aYR8fwl7NS7dDGjkJVQabgx6M7whdUZaF/Z9OxBvpsKU0Bj0GLk9CW6fb27KEuWy+bs1Tjbh/Wrscjtx9lD3X+HGYX3dRvKY3brC370NkrjrRN9XgStkQOlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KiZoFa/w; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B76040008;
	Wed, 31 Jan 2024 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNC27OFOihTp3bOx750xw7viXyvhaOjsFxRElEISsgo=;
	b=KiZoFa/w/D04u82HpGkBb8RZEodV4mEX2Bt/5L2iETcdN0b2eD0W0ZYV9w/+CpLJMt5J7V
	Gxsnz9cHRFtCXbpip4I+jGyX9W49D4XVycDezDxQZfJj/m5KWkq2j5G9oUT0LCo/hgDJyM
	0aldxCBB1oDKKw8ybtsxWaioz9SCTMaM2stUXvJ5ih9Z9daiSEPO2IHj/nu/c/mgEUKak0
	jHJ6K9MxJHu/ztTHi81xKn3VlRXMtagrdXRc6q6+G72eFNqJHtQdXRJTl1AwSlnmVLpPk5
	UhBr0KoHqoaZITBbxE/ql+U52Ya5MSEWX0iUry/MXWOEBGicznaQ7sKMgLwY7w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:30 +0100
Subject: [PATCH v4 17/18] MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux
 function nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-17-bcd00510d6a0@bootlin.com>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
In-Reply-To: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Pins on this platform have two functions: GPIO or something-else. We
create function nodes for each something-else based on functions.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi | 125 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi      |   6 ++
 2 files changed, 131 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi b/arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi
new file mode 100644
index 000000000000..42acda13e57a
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+/*
+ * Default pin configuration for Mobileye EyeQ5 boards. We mostly create one
+ * pin configuration node per function.
+ */
+
+&pinctrl {
+	timer0_pins: timer0-pins {
+		function = "timer0";
+		pins = "PA0", "PA1";
+	};
+	timer1_pins: timer1-pins {
+		function = "timer1";
+		pins = "PA2", "PA3";
+	};
+	timer2_pins: timer2-pins {
+		function = "timer2";
+		pins = "PA4", "PA5";
+	};
+	pps0_pins: pps0-pin {
+		function = "timer2";
+		pins = "PA4";
+	};
+	pps1_pins: pps1-pin {
+		function = "timer2";
+		pins = "PA5";
+	};
+	timer5_ext_pins: timer5-ext-pins {
+		function = "timer5";
+		pins = "PA6", "PA7", "PA8", "PA9";
+	};
+	timer5_ext_input_pins: timer5-ext-input-pins {
+		function = "timer5";
+		pins = "PA6", "PA7";
+	};
+	timer5_ext_incap_a_pins: timer5-ext-incap-a-pin {
+		function = "timer5";
+		pins = "PA6";
+	};
+	timer5_ext_incap_b_pins: timer5-ext-incap-b-pin {
+		function = "timer5";
+		pins = "PA7";
+	};
+	can0_pins: can0-pins {
+		function = "can0";
+		pins = "PA14", "PA15";
+	};
+	can1_pins: can1-pins {
+		function = "can1";
+		pins = "PA16", "PA17";
+	};
+	uart0_pins: uart0-pins {
+		function = "uart0";
+		pins = "PA10", "PA11";
+	};
+	uart1_pins: uart1-pins {
+		function = "uart1";
+		pins = "PA12", "PA13";
+	};
+	spi0_pins: spi0-pins {
+		function = "spi0";
+		pins = "PA18", "PA19", "PA20", "PA21", "PA22";
+	};
+	spi1_pins: spi1-pins {
+		function = "spi1";
+		pins = "PA23", "PA24", "PA25", "PA26", "PA27";
+	};
+	spi1_slave_pins: spi1-slave-pins {
+		function = "spi1";
+		pins = "PA24", "PA25", "PA26";
+	};
+	refclk0_pins: refclk0-pin {
+		function = "refclk0";
+		pins = "PA28";
+	};
+	timer3_pins: timer3-pins {
+		function = "timer3";
+		pins = "PB0", "PB1";
+	};
+	timer4_pins: timer4-pins {
+		function = "timer4";
+		pins = "PB2", "PB3";
+	};
+	timer6_ext_pins: timer6-ext-pins {
+		function = "timer6";
+		pins = "PB4", "PB5", "PB6", "PB7";
+	};
+	timer6_ext_input_pins: timer6-ext-input-pins {
+		function = "timer6";
+		pins = "PB4", "PB5";
+	};
+	timer6_ext_incap_a_pins: timer6-ext-incap-a-pin {
+		function = "timer6";
+		pins = "PB4";
+	};
+	timer6_ext_incap_b_pins: timer6-ext-incap-b-pin {
+		function = "timer6";
+		pins = "PB5";
+	};
+	can2_pins: can2-pins {
+		function = "can2";
+		pins = "PB10", "PB11";
+	};
+	uart2_pins: uart2-pins {
+		function = "uart2";
+		pins = "PB8", "PB9";
+	};
+	spi2_pins: spi2-pins {
+		function = "spi2";
+		pins = "PB12", "PB13", "PB14", "PB15", "PB16";
+	};
+	spi3_pins: spi3-pins {
+		function = "spi3";
+		pins = "PB17", "PB18", "PB19", "PB20", "PB21";
+	};
+	spi3_slave_pins: spi3-slave-pins {
+		function = "spi3";
+		pins = "PB18", "PB19", "PB20";
+	};
+	mclk0_pins: mclk0-pin {
+		function = "mclk0";
+		pins = "PB22";
+	};
+};
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index ece71cafb6ee..ae13e8299994 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -125,6 +125,11 @@ reset: reset-controller@e00000 {
 				reg-names = "d0", "d1", "d2";
 				#reset-cells = <2>;
 			};
+
+			pinctrl: pinctrl@e000b0 {
+				compatible = "mobileye,eyeq5-pinctrl";
+				reg = <0x0b0 0x30>;
+			};
 		};
 
 		gic: interrupt-controller@140000 {
@@ -150,3 +155,4 @@ timer {
 	};
 };
 
+#include "eyeq5-pins.dtsi"

-- 
2.43.0


