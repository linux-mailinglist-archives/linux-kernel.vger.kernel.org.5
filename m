Return-Path: <linux-kernel+bounces-29878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1F78314B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2468BB24BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556C2E859;
	Thu, 18 Jan 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZzb+Ud9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369B2032F;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566180; cv=none; b=DEIAygdJhR6GmZ4XF6nPEr77ODlWsi8yXAaHzbHpPPKUoKGr7K6j1US1OrrhaIvmRcSzaPdr3z2pgIsOrCHqGsYS5poaeWV0i1LBgNXFjNcq44+bddcUO6eKzpHFLYfCAH/K+ScjS2Px8T50DCePLuu+Bm6x9CxgxD6lO7sGPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566180; c=relaxed/simple;
	bh=BxsLiKTEX27UORawY3AEl0fNb8Nhi3xPg5lbcf9bCHU=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=uale3WjaNoM5LG3EkiRHu0TT3rU+Rpe2TIJf1jna1DmJonwg2IolwQ5UnzX+ztSVLR/Hfuo+tOyS1HNd/dxIeJg14CplMxXjdLrY3GE3QPWmH8WA6kd4vOiOCR6HMbrVVpHm1oJJhwFujNVOWpl9QE9jfh2WTsvEpldQYQ8QadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZzb+Ud9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A5EDC4AF7D;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566180;
	bh=BxsLiKTEX27UORawY3AEl0fNb8Nhi3xPg5lbcf9bCHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fZzb+Ud9fAutT1mioNICRTeILNfPEz00pbWjonjGdyLai/t4xoPYi6re3/uDmxSIR
	 tNKz9abUfQw0marGcCtH3wdxt8XMRWKIsq70y+h6ZRwJHevvOn70I3bzovNFIJd0O5
	 Vkc4Vl7hPaSLmuTQcZRSgpX5rFvQTHLV4vHPGD6Q9b3wmkMLPzfFobymwNnV8ODfLD
	 ofOP8JxXQZukO2iNLW8KvnBMjwwkzPphc/WGbAT/d4yiREbjmSEo5rGXuGVfJxE4PI
	 5BzkyT8yiXb3ZaMpogEYU5kW5YXSkRY1w6+D+/D0tr+4Dhd3/DoHYVXSFw4btsuFH/
	 ZuoeuNBoWRhfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D6C47DD6;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:21:13 +0300
Subject: [PATCH v7 30/39] ARM: dts: add Cirrus EP93XX SoC .dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-30-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=11961;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=hsGDTVaNARgHD7dPi/ImN4OlyIJePha9DSNh2dBhSGM=; =?utf-8?q?b=3Dc6htTfWH6qxe?=
 =?utf-8?q?qylUAh3oQe0NXAmqaG34eQDop5r4bPGIJHMVcQMnPCIRq88uHLsozTFS7bCbxG5C?=
 44myZIRTCoUKo4ILTeitdI2dLLn2oETHlkYzdRibi8GbwecwZN7p
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add support for Cirrus Logic EP93XX SoC's family.

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/cirrus/ep93xx.dtsi | 441 +++++++++++++++++++++++++++++++++++
 1 file changed, 441 insertions(+)

diff --git a/arch/arm/boot/dts/cirrus/ep93xx.dtsi b/arch/arm/boot/dts/cirrus/ep93xx.dtsi
new file mode 100644
index 000000000000..e6ced628f570
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx.dtsi
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Cirrus Logic systems EP93XX SoC
+ */
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+/ {
+	soc: soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		syscon: syscon@80930000 {
+			compatible = "cirrus,ep9301-syscon", "syscon";
+			reg = <0x80930000 0x1000>;
+
+			#clock-cells = <1>;
+			clocks = <&xtali>;
+
+			spi_default_pins: pins-spi {
+				function = "spi";
+				groups = "ssp";
+			};
+
+			ac97_default_pins: pins-ac97 {
+				function = "ac97";
+				groups = "ac97";
+			};
+
+			i2s_on_ssp_pins: pins-i2sonssp {
+				function = "i2s";
+				groups = "i2s_on_ssp";
+			};
+
+			i2s_on_ac97_pins: pins-i2sonac97 {
+				function = "i2s";
+				groups = "i2s_on_ac97";
+			};
+
+			gpio1_default_pins: pins-gpio1 {
+				function = "gpio";
+				groups = "gpio1agrp";
+			};
+
+			pwm1_default_pins: pins-pwm1 {
+				function = "pwm";
+				groups = "pwm1";
+			};
+
+			gpio2_default_pins: pins-gpio2 {
+				function = "gpio";
+				groups = "gpio2agrp";
+			};
+
+			gpio3_default_pins: pins-gpio3 {
+				function = "gpio";
+				groups = "gpio3agrp";
+			};
+
+			keypad_default_pins: pins-keypad {
+				function = "keypad";
+				groups = "keypadgrp";
+			};
+
+			gpio4_default_pins: pins-gpio4 {
+				function = "gpio";
+				groups = "gpio4agrp";
+			};
+
+			gpio6_default_pins: pins-gpio6 {
+				function = "gpio";
+				groups = "gpio6agrp";
+			};
+
+			gpio7_default_pins: pins-gpio7 {
+				function = "gpio";
+				groups = "gpio7agrp";
+			};
+
+			ide_default_pins: pins-ide {
+				function = "pata";
+				groups = "idegrp";
+			};
+
+			lcd_on_dram0_pins: pins-rasteronsdram0 {
+				function = "lcd";
+				groups = "rasteronsdram0grp";
+			};
+
+			lcd_on_dram3_pins: pins-rasteronsdram3 {
+				function = "lcd";
+				groups = "rasteronsdram3grp";
+			};
+		};
+
+		adc: adc@80900000 {
+			compatible = "cirrus,ep9301-adc";
+			reg = <0x80900000 0x28>;
+			clocks = <&syscon EP93XX_CLK_ADC>;
+			interrupt-parent = <&vic0>;
+			interrupts = <30>;
+			status = "disabled";
+		};
+
+		/*
+		 * The EP93XX expansion bus is a set of up to 7 each up to 16MB
+		 * windows in the 256MB space from 0x50000000 to 0x5fffffff.
+		 * But since we don't require to setup it in any way, we can
+		 * represent it as a simple-bus.
+		 */
+		ebi: bus@80080000 {
+			compatible = "simple-bus";
+			reg = <0x80080000 0x20>;
+			native-endian;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
+		dma0: dma-controller@80000000 {
+			compatible = "cirrus,ep9301-dma-m2p";
+			reg = <0x80000000 0x0040>,
+			      <0x80000040 0x0040>,
+			      <0x80000080 0x0040>,
+			      <0x800000c0 0x0040>,
+			      <0x80000240 0x0040>,
+			      <0x80000200 0x0040>,
+			      <0x800002c0 0x0040>,
+			      <0x80000280 0x0040>,
+			      <0x80000340 0x0040>,
+			      <0x80000300 0x0040>;
+			clocks = <&syscon EP93XX_CLK_M2P0>,
+				 <&syscon EP93XX_CLK_M2P1>,
+				 <&syscon EP93XX_CLK_M2P2>,
+				 <&syscon EP93XX_CLK_M2P3>,
+				 <&syscon EP93XX_CLK_M2P4>,
+				 <&syscon EP93XX_CLK_M2P5>,
+				 <&syscon EP93XX_CLK_M2P6>,
+				 <&syscon EP93XX_CLK_M2P7>,
+				 <&syscon EP93XX_CLK_M2P8>,
+				 <&syscon EP93XX_CLK_M2P9>;
+			clock-names = "m2p0", "m2p1",
+				      "m2p2", "m2p3",
+				      "m2p4", "m2p5",
+				      "m2p6", "m2p7",
+				      "m2p8", "m2p9";
+			interrupt-parent = <&vic0>;
+			interrupts = <7>, <8>, <9>, <10>, <11>,
+				<12>, <13>, <14>, <15>, <16>;
+			#dma-cells = <2>;
+		};
+
+		dma1: dma-controller@80000100 {
+			compatible = "cirrus,ep9301-dma-m2m";
+			reg = <0x80000100 0x0040>,
+			      <0x80000140 0x0040>;
+			clocks = <&syscon EP93XX_CLK_M2M0>,
+				 <&syscon EP93XX_CLK_M2M1>;
+			clock-names = "m2m0", "m2m1";
+			interrupt-parent = <&vic0>;
+			interrupts = <17>, <18>;
+			#dma-cells = <2>;
+		};
+
+		eth0: ethernet@80010000 {
+			compatible = "cirrus,ep9301-eth";
+			reg = <0x80010000 0x10000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <7>;
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		gpio0: gpio@80840000 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840000 0x04>,
+			      <0x80840010 0x04>,
+			      <0x80840090 0x1c>;
+			reg-names = "data", "dir", "intr";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&vic1>;
+			interrupts = <27>;
+		};
+
+		gpio1: gpio@80840004 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840004 0x04>,
+			      <0x80840014 0x04>,
+			      <0x808400ac 0x1c>;
+			reg-names = "data", "dir", "intr";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&vic1>;
+			interrupts = <27>;
+		};
+
+		gpio2: gpio@80840008 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840008 0x04>,
+			      <0x80840018 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio2_default_pins>;
+		};
+
+		gpio3: gpio@8084000c {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x8084000c 0x04>,
+			      <0x8084001c 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio3_default_pins>;
+		};
+
+		gpio4: gpio@80840020 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840020 0x04>,
+			      <0x80840024 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio4_default_pins>;
+		};
+
+		gpio5: gpio@80840030 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840030 0x04>,
+			      <0x80840034 0x04>,
+			      <0x8084004c 0x1c>;
+			reg-names = "data", "dir", "intr";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts-extended = <&vic0 19>, <&vic0 20>,
+					      <&vic0 21>, <&vic0 22>,
+					      <&vic1 15>, <&vic1 16>,
+					      <&vic1 17>, <&vic1 18>;
+		};
+
+		gpio6: gpio@80840038 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840038 0x04>,
+			      <0x8084003c 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio6_default_pins>;
+		};
+
+		gpio7: gpio@80840040 {
+			compatible = "cirrus,ep9301-gpio";
+			reg = <0x80840040 0x04>,
+			      <0x80840044 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio7_default_pins>;
+		};
+
+		i2s: i2s@80820000 {
+			compatible = "cirrus,ep9301-i2s";
+			reg = <0x80820000 0x100>;
+			#sound-dai-cells = <0>;
+			interrupt-parent = <&vic1>;
+			interrupts = <28>;
+			clocks = <&syscon EP93XX_CLK_I2S_MCLK>,
+				 <&syscon EP93XX_CLK_I2S_SCLK>,
+				 <&syscon EP93XX_CLK_I2S_LRCLK>;
+			clock-names = "mclk", "sclk", "lrclk";
+			dmas = <&dma0 0 1>, <&dma0 0 2>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		ide: ide@800a0000 {
+			compatible = "cirrus,ep9312-pata";
+			reg = <0x800a0000 0x38>;
+			interrupt-parent = <&vic1>;
+			interrupts = <8>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ide_default_pins>;
+			status = "disabled";
+		};
+
+		vic0: interrupt-controller@800b0000 {
+			compatible = "arm,pl192-vic";
+			reg = <0x800b0000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			valid-mask = <0x7ffffffc>;
+			valid-wakeup-mask = <0x0>;
+		};
+
+		vic1: interrupt-controller@800c0000 {
+			compatible = "arm,pl192-vic";
+			reg = <0x800c0000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			valid-mask = <0x1fffffff>;
+			valid-wakeup-mask = <0x0>;
+		};
+
+		keypad: keypad@800f0000 {
+			compatible = "cirrus,ep9307-keypad";
+			reg = <0x800f0000 0x0c>;
+			interrupt-parent = <&vic0>;
+			interrupts = <29>;
+			clocks = <&syscon EP93XX_CLK_KEYPAD>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&keypad_default_pins>;
+			linux,keymap =	<KEY_UP>,
+					<KEY_DOWN>,
+					<KEY_VOLUMEDOWN>,
+					<KEY_HOME>,
+					<KEY_RIGHT>,
+					<KEY_LEFT>,
+					<KEY_ENTER>,
+					<KEY_VOLUMEUP>,
+					<KEY_F6>,
+					<KEY_F8>,
+					<KEY_F9>,
+					<KEY_F10>,
+					<KEY_F1>,
+					<KEY_F2>,
+					<KEY_F3>,
+					<KEY_POWER>;
+		};
+
+		pwm0: pwm@80910000 {
+			compatible = "cirrus,ep9301-pwm";
+			reg = <0x80910000 0x10>;
+			clocks = <&syscon EP93XX_CLK_PWM>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@80910020 {
+			compatible = "cirrus,ep9301-pwm";
+			reg = <0x80910020 0x10>;
+			clocks = <&syscon EP93XX_CLK_PWM>;
+			#pwm-cells = <3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1_default_pins>;
+			status = "disabled";
+		};
+
+		rtc0: rtc@80920000 {
+			compatible = "cirrus,ep9301-rtc";
+			reg = <0x80920000 0x100>;
+		};
+
+		spi0: spi@808a0000 {
+			compatible = "cirrus,ep9301-spi";
+			reg = <0x808a0000 0x18>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&vic1>;
+			interrupts = <21>;
+			clocks = <&syscon EP93XX_CLK_SPI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi_default_pins>;
+			status = "disabled";
+		};
+
+		timer: timer@80810000 {
+			compatible = "cirrus,ep9301-timer";
+			reg = <0x80810000 0x100>;
+			interrupt-parent = <&vic1>;
+			interrupts = <19>;
+		};
+
+		uart0: serial@808c0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x808c0000 0x1000>;
+			arm,primecell-periphid = <0x00041010>;
+			clocks = <&syscon EP93XX_CLK_UART1>, <&syscon EP93XX_CLK_UART>;
+			clock-names = "uartclk", "apb_pclk";
+			interrupt-parent = <&vic1>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+
+		uart1: uart@808d0000 {
+			compatible = "arm,primecell";
+			reg = <0x808d0000 0x1000>;
+			arm,primecell-periphid = <0x00041010>;
+			clocks = <&syscon EP93XX_CLK_UART2>, <&syscon EP93XX_CLK_UART>;
+			clock-names = "apb:uart2", "apb_pclk";
+			interrupt-parent = <&vic1>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+
+		uart2: uart@808b0000 {
+			compatible = "arm,primecell";
+			reg = <0x808b0000 0x1000>;
+			arm,primecell-periphid = <0x00041010>;
+			clocks = <&syscon EP93XX_CLK_UART3>, <&syscon EP93XX_CLK_UART>;
+			clock-names = "apb:uart3", "apb_pclk";
+			interrupt-parent = <&vic1>;
+			interrupts = <23>;
+			status = "disabled";
+		};
+
+		usb0: usb@80020000 {
+			compatible = "generic-ohci";
+			reg = <0x80020000 0x10000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <24>;
+			clocks = <&syscon EP93XX_CLK_USB>;
+			status = "disabled";
+		};
+
+		watchdog0: watchdog@80940000 {
+			compatible = "cirrus,ep9301-wdt";
+			reg = <0x80940000 0x08>;
+		};
+	};
+
+	xtali: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <14745600>;
+		clock-output-names = "xtali";
+	};
+};

-- 
2.41.0


