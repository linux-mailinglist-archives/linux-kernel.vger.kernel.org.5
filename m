Return-Path: <linux-kernel+bounces-59475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC19584F7A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0759BB294E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987DE1272CD;
	Fri,  9 Feb 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BVyi5cQM"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BE84A46;
	Fri,  9 Feb 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489131; cv=none; b=sitbYbjxqRgNupI+9huY3zZvA9gC+hnfIEYuKk2HrpHcicS1sNvvlJ0fBsFXOipWUcML+VgjsQROyni4ntfFYM8LNIyoHVeZi3OqTlGUmIHfbSj1q+12kFODVIJHIaVVcpD611obtN+ztu/A4sq6VgWLpTfgcUM3lZ2x6bkwX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489131; c=relaxed/simple;
	bh=AOujWblAL/Eb3SoFX/DXZmLu4by42Gj1/JOw1DWfuS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOMhxNH1QFXC7WuAnmjHAbA0Ex/hwYk/BRwKPvEByLy6uV3hI5p6gqe8uNKKE3nSpbxpYeGtAxPLG1c9j+EMo7vies8thNfbd5eOYDuBHcyCZPsc3KE8pXiYdrfLa54L53O/JOb7VhLdZth2zkmhlqhfNJGyEn9htIqkGqwIEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BVyi5cQM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6A31240002;
	Fri,  9 Feb 2024 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntwnUlVjSIXSSPhME4Hzl2L0UVU1UFUtEinrPzePqbc=;
	b=BVyi5cQM8O0TM2kfxyarxGfF0hrHr6KZltGw3eEBwcrKXU9/WqYJ09Tl+CqUu58GFJbtD2
	GGsU6trI6kfl2hGk9RcwvgBrchBrog737NFOyYMnx0Ah5WKX5iz+TBi79yA00VqhCY57OV
	OQn/86ESSyoTB2YUJHPL8jHSUALpghn29a6irbPpaKlkY8V6yKfrsV/H2RrQ4D6jOOmZeB
	9pygDXUEiGtaXxzbzVNV30aLbUSBYJM1oKSMM+Q61e4OuLcIKzEyOBDnMKYSXD1EM/Gyb/
	rMSdyZefllO9bm3UuKF6NfSnN1WLTfggrmnnZ0kXS1XLGY0ZeFQ8onSwDerTrA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:49 +0100
Subject: [PATCH v5 13/13] MIPS: mobileye: eyeq5: add pinctrl node & pinmux
 function nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-13-f094ee5e918a@bootlin.com>
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
In-Reply-To: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
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

UART nodes are present in the platform devicetree. Add pinctrl to them
now that the pin controller is supported.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi | 125 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi      |  13 +++
 2 files changed, 138 insertions(+)

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
index 76935f237ab5..8d4f65ec912d 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -79,6 +79,8 @@ uart0: serial@800000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 10>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 		};
 
 		uart1: serial@900000 {
@@ -90,6 +92,8 @@ uart1: serial@900000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 11>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins>;
 		};
 
 		uart2: serial@a00000 {
@@ -101,6 +105,8 @@ uart2: serial@a00000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 12>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
 		};
 
 		olb: system-controller@e00000 {
@@ -125,6 +131,11 @@ clocks: clock-controller@e0002c {
 				clocks = <&xtal>;
 				clock-names = "ref";
 			};
+
+			pinctrl: pinctrl@e000b0 {
+				compatible = "mobileye,eyeq5-pinctrl";
+				reg = <0x0b0 0x30>;
+			};
 		};
 
 		gic: interrupt-controller@140000 {
@@ -149,3 +160,5 @@ timer {
 		};
 	};
 };
+
+#include "eyeq5-pins.dtsi"

-- 
2.43.0


