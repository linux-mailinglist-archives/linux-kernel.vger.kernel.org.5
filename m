Return-Path: <linux-kernel+bounces-139062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5389FE01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA098288BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDB181CE1;
	Wed, 10 Apr 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Db6XtEfI"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C2180A8B;
	Wed, 10 Apr 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769166; cv=none; b=MAUgYuSFZLuTWADLw4SXTEI74LohAP/5L+RLJrNexKhxV9C7YvyQRTAG77aXie5Qpy5UqhlkV539ZEOyaLS02zdi4PMocTjOaZGn4ZADGSMKhAcLYajWyfyjN0fJ4KGWLr/5RXbAkad/9p91cyzaydHR1Vvjsc/wAuUTyBoOXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769166; c=relaxed/simple;
	bh=AAJTdXRM0Re+DCVXVGJxubzVOx467C+c5nb+jYksNi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ua40sB7Ks4Ok3eS96LhiviZlSAJ9j6cxVf3C1qg59OXb0snQ+Ngr/admRQ+2B4GidQmXUFdmgKhisPfPaeeXnE1ZbXxfTlMUpew6bU5K9NE2PXru6bz6hf69o9CUe+8hC1R5ZxpTnL5+8R1Hhbz9OUbEWW3osTWy7AnulbxzWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Db6XtEfI; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A27741C0006;
	Wed, 10 Apr 2024 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqd7RNSKgF1eQYnYzns3slAE3h9undBdrUHi47AKr1g=;
	b=Db6XtEfI1VNXOTKGHX5TiSDo8IpjTBzCnMEDn6OIWcE3KF4w7GjzOQZjgKryUFpQGdcK/U
	5+o9JFuI4e8/SBlrRF0VkrMxLvS1Bq4J86KO9D9+pDDbYuEeJ9qzoU/kLhBubIIbC/vCCc
	NDAfvYP9KSdsLsIGPQYdTze7yCNsvIYaupZNS+doig7rVg7wEw7JW/9qx4qgjDdBBewOSf
	W3O6cqt65iRQa+jh4+Is6eKdFpYdLq4NsP0It8LrAIR9pjD2ErWN5vZHISmwgO7Q7he5OS
	WTk763qWWlyAJhDf+rgUyakXNDQDaDjqbrM4DIDeWwNlb7SQZqggKSIxD3qOLg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 19:12:40 +0200
Subject: [PATCH 11/11] MIPS: mobileye: eyeq5: add pinctrl node & pinmux
 function nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-mbly-olb-v1-11-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
In-Reply-To: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Pins on this platform have two functions: GPIO or something-else. We
create function nodes for each something-else based on functions.

UART nodes are present in the platform devicetree. Add pinctrl to them
now that the pin controller is supported.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
2.44.0


