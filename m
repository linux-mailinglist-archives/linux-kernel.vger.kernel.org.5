Return-Path: <linux-kernel+bounces-164403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26C8B7D41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D83B1C21D11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC2181CFD;
	Tue, 30 Apr 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="H1KQtZz6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="btSmqQl8"
Received: from c180-45.smtp-out.ap-south-1.amazonses.com (c180-45.smtp-out.ap-south-1.amazonses.com [76.223.180.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3268179965;
	Tue, 30 Apr 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494967; cv=none; b=tm8Oo12B0EQamAxO+ivHmqNp3AGijuKMLt3bZLEkqHvbBye0hNldDi/kfzT5+qUQ1XNf77tL1vzEbbxJuN4a0A0cLy+xzUt7FcIP9oMnsNrtfDkBia+pGPPJGZzuDTSWCyPDiIpolFAB/xNClKWDbN0E6KH//SPA4EyMdSstMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494967; c=relaxed/simple;
	bh=/z6DZH45bLOkfq/gVueWFPb4M8m52qtDKhLklz3wx38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPKZOot8oTc91K+pWWRcXCndU5SleCTbCeWtQMlcbsZFEKhXj1HxbtdD56ofxx1vWHz3jhG30TMe6bPhJiA8LE6XtQV0dNaxGHx1fW1mL+LpWGKyFo2cgRJ8q4G8jSfA3+XPwmB8TKrnj5e3h3atDTMHcdZlMXmg5fhL97/5M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=H1KQtZz6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=btSmqQl8; arc=none smtp.client-ip=76.223.180.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714494963;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/z6DZH45bLOkfq/gVueWFPb4M8m52qtDKhLklz3wx38=;
	b=H1KQtZz67/faeWjiZwSpMdixZ/m5qeSJi5VuouLNeQInv2BDTMmsySN1BLKIcXzR
	xtdDu4G1WSG9HDmKtaLrsifAo00dUYv0COtCJQPtF5JSH3H8i1wGBCnvYiVm3du8s5A
	LOCP+FZurlCdsms4hajqj6BpTnygAm+Db9Ql9IMKvvZ/KJyF4YOpFeN8ZnpvG0YByIQ
	53uwPWeo6RwVFBg3Dbw2T6YFMDjACKYRkvbT7ZdK4I0FAFFoepyyyWbEdITRvigM343
	It1mRVvb1dbR9OHnddwAN4bixntbRaqFEBDpFuRMsdLy0Ye7y+IdgWtmax26mtJwbdB
	avTEAS4f1g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714494963;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=/z6DZH45bLOkfq/gVueWFPb4M8m52qtDKhLklz3wx38=;
	b=btSmqQl8DRqgVF1J8k1jhBf/sDbV71Tv9XDJlXxi3oDobNZ3h5V5HB+p5zqQ8wld
	j75/NGskpIB0s5GdAlc56Sch367l9S+hWv4OsVYcMaDZoGQS74uLILz0UYTyuE7EtNH
	rbH5atpe+8iU6YACHRcnTpLPBtJFKEY3oU7Z4jHU=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: bhargav.r@ltts.com, arnd@arndb.de, broonie@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, eblanc@baylibre.com, 
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, 
	lgirdwood@gmail.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	m.nirmaladevi@ltts.com, nm@ti.com, robh+dt@kernel.org, 
	vigneshr@ti.com
Subject: [PATCH v8 10/10] arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P dts
Date: Tue, 30 Apr 2024 16:36:03 +0000
Message-ID: <0109018f2fdcfee6-3cc623b4-2f4e-47aa-adc3-96f071d209f8-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
References: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.30-76.223.180.45

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


