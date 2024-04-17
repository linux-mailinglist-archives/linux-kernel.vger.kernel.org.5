Return-Path: <linux-kernel+bounces-148434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD748A827F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948DFB26E72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73A1411DA;
	Wed, 17 Apr 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="w72rADFt";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IEXm3b2+"
Received: from c180-14.smtp-out.ap-south-1.amazonses.com (c180-14.smtp-out.ap-south-1.amazonses.com [76.223.180.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19213FD95;
	Wed, 17 Apr 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354605; cv=none; b=RJS7dzbEshd0sabmcME4CwZ/1sKD7iN+3ENHrTgvcrR5F+wbrYMbfuY0Hff6vbnLmDV5VvR82VGrc2GXElOemoQah4eapFF8ZzclqfBVFJWTHnhXTvZKM7xLxDE7L5/KQPshumjFlrCIBiow1rTtFXWbCWOe6ZQfODYTiQIdpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354605; c=relaxed/simple;
	bh=/z6DZH45bLOkfq/gVueWFPb4M8m52qtDKhLklz3wx38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuWFWqo3vX0qdTYQjWIceFyDF5GZPGsvHgKAWjsN6st84HJY0EYXE18gwXC6Klmhj59ly+JxkNmPR/ogJE42Z4+/0xL8S3hWbmfbwAdOFUKs3tDOGurwXRan8cGqjjBJfyfCDLalWTGUEnVrsIYHSXX81NbQ7TkKEm0GEVm0Flo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=w72rADFt; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=IEXm3b2+; arc=none smtp.client-ip=76.223.180.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354601;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/z6DZH45bLOkfq/gVueWFPb4M8m52qtDKhLklz3wx38=;
	b=w72rADFtax6uLMMXytZYMwtpa6xNEWbfNqdU8IxLhsN5fDc1yHGF9rhe9Jj3eVSm
	cC5j2PO4j5+1BtroYHQy88jD1dbtstyVbSH2Pnnv6TsWOjsRYxxjcjIBztTtRm+Mvly
	/VF5s/RYAy+/5CQlcxrhHfzXu2nHGdVQjpkbnrLwRrVhV2CPS91gQbvuVu8dz12pDf6
	OMpq4qOSmZy3+ZqDhLtaaqBPYyVbMzzsdx19od4DcyMmaBZuqGXfUmwx5nSkJk8b2s8
	QAxQ+qsfIMckkDbdspVEVIfLAyZ0A8RutmO/tKcf5Yz9aygoKgJmjRLYHchbdL1GiOx
	XDD+QZbvBA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354601;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=/z6DZH45bLOkfq/gVueWFPb4M8m52qtDKhLklz3wx38=;
	b=IEXm3b2+tR2m53kB7oEtN2JCU4zQHoVrFexE7GvvcY92aZmbo2z9BaWqONI8DkXG
	nJIxMiiAzl0Xhce3INVZHEosMU3kYoXnK97Cgyc0/5Wp8CIRc9leBLznwZkLWBalpfY
	UYtdIetcLy1iTGJo8tnt3KhOt+Xdr3Z7yybVf/wM=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v7 10/10] arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P dts
Date: Wed, 17 Apr 2024 11:50:01 +0000
Message-ID: <0109018eebe4727f-13c86fa9-7650-469a-a1f5-1c0230b82625-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417114934.186248-1-bhargav.r@ltts.com>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.14

Add support for TPS65224 PMIC in device tree of AM62P EVM. Adds regulator
configuration, pinmux configurations and pmic device nodes.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 1773c05f7..5d8e4321b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -112,6 +112,16 @@ vddshv_sdio: regulator-3 {
 		bootph-all;
 	};
 
+	vcc_3v3_main: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_main";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -580,6 +590,12 @@ &main_uart1 {
 &mcu_pmx0 {
 	bootph-all;
 
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (B10) MCU_GPIO0_0 */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM62PX_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
@@ -589,6 +605,13 @@ AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
 		>;
 		bootph-all;
 	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x04c, PIN_INPUT, 0) /* (A13) WKUP_I2C0_SCL */
+			AM62PX_MCU_IOPAD(0x050, PIN_INPUT, 0) /* (C11) WKUP_I2C0_SDA */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -599,6 +622,78 @@ &wkup_uart0 {
 	bootph-all;
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	tps65224: pmic@48 {
+		compatible = "ti,tps65224-q1";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		ti,primary-pmic;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck12-supply = <&vcc_3v3_main>;
+		buck3-supply = <&vcc_3v3_main>;
+		buck4-supply = <&vcc_3v3_main>;
+
+		ldo1-supply = <&vcc_3v3_main>;
+		ldo2-supply = <&vcc_3v3_main>;
+		ldo3-supply = <&vcc1v8_sys>;
+
+		regulators {
+			vcc_core: buck12 {
+				regulator-name = "vcc_core_buck12";
+				regulator-min-microvolt = <715000>;
+				regulator-max-microvolt = <895000>;
+				regulator-always-on;
+			};
+
+			vcc1v8_sys: buck3 {
+				regulator-name = "vcc1v8_sys_buck3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			vcc1v1: buck4 {
+				regulator-name = "vcc1v1_buck4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			vdda1v8: ldo1 {
+				regulator-name = "vdda1v8_ldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			dvdd3v3: ldo2 {
+				regulator-name = "dvdd3v3_ldo2";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vcc_0v85: ldo3 {
+				regulator-name = "vcc_0v85_ldo3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 /* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
-- 
2.25.1


