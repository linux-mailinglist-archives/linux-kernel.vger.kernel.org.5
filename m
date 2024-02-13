Return-Path: <linux-kernel+bounces-63390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F76B852EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AB31F2775E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB636B02;
	Tue, 13 Feb 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="yeGc9MOQ"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEB364BF;
	Tue, 13 Feb 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822125; cv=pass; b=TQ0xSh5uucx9YoQKc7nGpb9MQfhJDkPFxfw5u8NRm1hX6NwU0LgjY3cOrebg589xiJ/WJbKZzzziDoUDoJmPnhRdeM5qziactR+OJd/h9bsTVqYPRjhoDw5c47JL6ar54i8RDYxnHW3iSsO6TKoNwuCxfanJRLVsu1QyYz7jmsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822125; c=relaxed/simple;
	bh=q8mANGYdRQROipkF4QinNT0ErBlok38DlBLZyYfa3cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgWFK72XyuEwKYp0dZSEOYr1IClsWvDODcev9my1wXjL8E/UAQh4je8L/W7lqvqGKI9jXdcFpKxrnj7SXQLRZvLUM28RsX/wOzeVeD+zNOiYqPNbOGSfVp9el6/YL96u5fNyZ2Icj+9Iya7wqMoOUMUKPXygOJqtmrOP284IkL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=yeGc9MOQ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1707822116; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XYmNjQWs+vER5ZGWV2VPJExQTWurXudx/YwAU1qQxe+jpHo9Qpvjvu4EJ/fAJ2ahjzLmCD3weiHD1v1hzz6jC/iEr1DwLsmIv+et7wVQoIOdxyMheX2LTm1T5gmp6UmlQyj7cwOVBx+XWEwdp33HYMxfaepcNVbKx5PAhuaUDtU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707822116; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ft+fadpzafcTR18vf2K7pUNzQk4Ri3rihQeat15SmN0=; 
	b=hbn/rTRQ01j8WhMEcV8yVe5+iZe/dZc0bLP6cG9AXOpvf2dVYQX/4sMHF+h0wuTO2VxGUYV9EJs9xotzgzwa/j8myxFALjYVx/QUUklDWr+rAWgq2HKLgR98FEo0s6R3LYDHVX+Si1dDbpOiouZ5U3IuAE451D9YoGTExGKlmE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707822116;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ft+fadpzafcTR18vf2K7pUNzQk4Ri3rihQeat15SmN0=;
	b=yeGc9MOQLBsro4R5BqPBEa9zExrZyF/tVYXJHzNL3C/y5/QhZVh/CuzfM7lvGDI5
	7Qn8ycyw9/p1IaKbBnuzdU119WK5jH94THQ9prndgiEJh1o2JPnZyY4RgX8QHydv1dt
	AsY5gSDtJ+P6S+YXCV0bL8pzzawKw9aLoofXZtFo=
Received: from localhost.localdomain (163.142.242.182 [163.142.242.182]) by mx.zohomail.com
	with SMTPS id 1707822115587118.38457054799937; Tue, 13 Feb 2024 03:01:55 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 1/4] ARM: dts: qcom: msm8974: Split out common part of samsung-klte
Date: Tue, 13 Feb 2024 18:58:36 +0800
Message-ID: <20240213110137.122737-2-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213110137.122737-1-i@rong.moe>
References: <20240213110137.122737-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Samsung Galaxy S5 has many variants. Variants that support LTE use klte*
as their codename. Currently, the only supported one is the one without
any suffix, namely, klte. It is known that other klte* variants have
only minor differences compared to klte and can mostly work with the
klte DTB.

Split the common part into a common DTSI so that it can be imported in
the DTS of klte and other klte* variants.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 ... qcom-msm8974pro-samsung-klte-common.dtsi} |   7 +-
 .../dts/qcom/qcom-msm8974pro-samsung-klte.dts | 833 +-----------------
 2 files changed, 17 insertions(+), 823 deletions(-)
 copy arch/arm/boot/dts/qcom/{qcom-msm8974pro-samsung-klte.dts => qcom-msm8974pro-samsung-klte-common.dtsi} (98%)
 rewrite arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts (99%)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
similarity index 98%
copy from arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
copy to arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
index b93539e2b87e..11e35b34ebd6 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
@@ -6,8 +6,6 @@
 #include <dt-bindings/leds/common.h>
 
 / {
-	model = "Samsung Galaxy S5";
-	compatible = "samsung,klte", "qcom,msm8974pro", "qcom,msm8974";
 	chassis-type = "handset";
 
 	aliases {
@@ -77,12 +75,10 @@ touchkey@20 {
 		};
 	};
 
-	i2c-gpio-led {
+	i2c_led_gpio: i2c-gpio-led {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		scl-gpios = <&tlmm 121 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		sda-gpios = <&tlmm 120 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c_led_gpioex_pins>;
 
@@ -770,7 +766,6 @@ i2c_touchkey_pins: i2c-touchkey-state {
 	};
 
 	i2c_led_gpioex_pins: i2c-led-gpioex-state {
-		pins = "gpio120", "gpio121";
 		function = "gpio";
 		bias-pull-down;
 	};
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
dissimilarity index 99%
index b93539e2b87e..954665f3a9dd 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
@@ -1,817 +1,16 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "qcom-msm8974pro.dtsi"
-#include "pma8084.dtsi"
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include <dt-bindings/leds/common.h>
-
-/ {
-	model = "Samsung Galaxy S5";
-	compatible = "samsung,klte", "qcom,msm8974pro", "qcom,msm8974";
-	chassis-type = "handset";
-
-	aliases {
-		serial0 = &blsp1_uart1;
-		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
-		mmc1 = &sdhc_3; /* SDC2 SD card slot */
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pin_a>;
-
-		key-volume-down {
-			label = "volume_down";
-			gpios = <&pma8084_gpios 2 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			debounce-interval = <15>;
-		};
-
-		key-home {
-			label = "home_key";
-			gpios = <&pma8084_gpios 3 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_HOMEPAGE>;
-			wakeup-source;
-			debounce-interval = <15>;
-		};
-
-		key-volume-up {
-			label = "volume_up";
-			gpios = <&pma8084_gpios 5 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <15>;
-		};
-	};
-
-	i2c-gpio-touchkey {
-		compatible = "i2c-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sda-gpios = <&tlmm 95 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		scl-gpios = <&tlmm 96 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c_touchkey_pins>;
-
-		touchkey@20 {
-			compatible = "cypress,tm2-touchkey";
-			reg = <0x20>;
-
-			interrupt-parent = <&pma8084_gpios>;
-			interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&touchkey_pin>;
-
-			vcc-supply = <&max77826_ldo15>;
-			vdd-supply = <&pma8084_l19>;
-
-			linux,keycodes = <KEY_APPSELECT KEY_BACK>;
-		};
-	};
-
-	i2c-gpio-led {
-		compatible = "i2c-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		scl-gpios = <&tlmm 121 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		sda-gpios = <&tlmm 120 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c_led_gpioex_pins>;
-
-		i2c-gpio,delay-us = <2>;
-
-		gpio_expander: gpio@20 {
-			compatible = "nxp,pcal6416";
-			reg = <0x20>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			vcc-supply = <&pma8084_s4>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&gpioex_pin>;
-
-			reset-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
-		};
-
-		led-controller@30 {
-			compatible = "panasonic,an30259a";
-			reg = <0x30>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			led@1 {
-				reg = <1>;
-				function = LED_FUNCTION_STATUS;
-				color = <LED_COLOR_ID_RED>;
-			};
-
-			led@2 {
-				reg = <2>;
-				function = LED_FUNCTION_STATUS;
-				color = <LED_COLOR_ID_GREEN>;
-			};
-
-			led@3 {
-				reg = <3>;
-				function = LED_FUNCTION_STATUS;
-				color = <LED_COLOR_ID_BLUE>;
-			};
-		};
-	};
-
-	vreg_wlan: wlan-regulator {
-		compatible = "regulator-fixed";
-
-		regulator-name = "wl-reg";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio_expander 8 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vreg_panel: panel-regulator {
-		compatible = "regulator-fixed";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&panel_en_pin>;
-
-		regulator-name = "panel-vddr-reg";
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <1500000>;
-
-		gpio = <&pma8084_gpios 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vreg_vph_pwr: vreg-vph-pwr {
-		compatible = "regulator-fixed";
-		regulator-name = "vph-pwr";
-
-		regulator-min-microvolt = <3600000>;
-		regulator-max-microvolt = <3600000>;
-
-		regulator-always-on;
-	};
-};
-
-&blsp1_i2c2 {
-	status = "okay";
-
-	touchscreen@20 {
-		compatible = "syna,rmi4-i2c";
-		reg = <0x20>;
-
-		interrupt-parent = <&pma8084_gpios>;
-		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
-
-		vdd-supply = <&max77826_ldo13>;
-		vio-supply = <&pma8084_lvs2>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&touch_pin>;
-
-		syna,startup-delay-ms = <100>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		rmi4-f01@1 {
-			reg = <0x1>;
-			syna,nosleep-mode = <1>;
-		};
-
-		rmi4-f12@12 {
-			reg = <0x12>;
-			syna,sensor-type = <1>;
-		};
-	};
-};
-
-&blsp1_i2c6 {
-	status = "okay";
-
-	pmic@60 {
-		reg = <0x60>;
-		compatible = "maxim,max77826";
-
-		regulators {
-			max77826_ldo1: LDO1 {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-			};
-
-			max77826_ldo2: LDO2 {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-			};
-
-			max77826_ldo3: LDO3 {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-			};
-
-			max77826_ldo4: LDO4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			max77826_ldo5: LDO5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			max77826_ldo6: LDO6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			max77826_ldo7: LDO7 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			max77826_ldo8: LDO8 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			max77826_ldo9: LDO9 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			max77826_ldo10: LDO10 {
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2950000>;
-			};
-
-			max77826_ldo11: LDO11 {
-				regulator-min-microvolt = <2700000>;
-				regulator-max-microvolt = <2950000>;
-			};
-
-			max77826_ldo12: LDO12 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			max77826_ldo13: LDO13 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			max77826_ldo14: LDO14 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			max77826_ldo15: LDO15 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			max77826_buck: BUCK {
-				regulator-min-microvolt = <1225000>;
-				regulator-max-microvolt = <1225000>;
-			};
-
-			max77826_buckboost: BUCKBOOST {
-				regulator-min-microvolt = <3400000>;
-				regulator-max-microvolt = <3400000>;
-			};
-		};
-	};
-};
-
-&blsp1_uart2 {
-	status = "okay";
-};
-
-&blsp2_i2c6 {
-	status = "okay";
-
-	fuelgauge@36 {
-		compatible = "maxim,max17048";
-		reg = <0x36>;
-
-		maxim,double-soc;
-		maxim,rcomp = /bits/ 8 <0x56>;
-
-		interrupt-parent = <&pma8084_gpios>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&fuelgauge_pin>;
-	};
-};
-
-&blsp2_uart2 {
-	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&blsp2_uart2_pins_active>;
-	pinctrl-1 = <&blsp2_uart2_pins_sleep>;
-
-	bluetooth {
-		compatible = "brcm,bcm43540-bt";
-		max-speed = <3000000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_pins>;
-		device-wakeup-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpio_expander 9 GPIO_ACTIVE_HIGH>;
-		interrupt-parent = <&tlmm>;
-		interrupts = <75 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wakeup";
-	};
-};
-
-&gpu {
-	status = "okay";
-};
-
-&mdss {
-	status = "okay";
-};
-
-&mdss_dsi0 {
-	status = "okay";
-
-	vdda-supply = <&pma8084_l2>;
-	vdd-supply = <&pma8084_l22>;
-	vddio-supply = <&pma8084_l12>;
-
-	panel: panel@0 {
-		reg = <0>;
-		compatible = "samsung,s6e3fa2";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&panel_te_pin &panel_rst_pin>;
-
-		iovdd-supply = <&pma8084_lvs4>;
-		vddr-supply = <&vreg_panel>;
-
-		reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&mdss_dsi0_out>;
-			};
-		};
-	};
-};
-
-&mdss_dsi0_out {
-	remote-endpoint = <&panel_in>;
-	data-lanes = <0 1 2 3>;
-};
-
-&mdss_dsi0_phy {
-	status = "okay";
-
-	vddio-supply = <&pma8084_l12>;
-};
-
-&pma8084_gpios {
-	gpio_keys_pin_a: gpio-keys-active-state {
-		pins = "gpio2", "gpio3", "gpio5";
-		function = "normal";
-
-		bias-pull-up;
-		power-source = <PMA8084_GPIO_S4>;
-	};
-
-	touchkey_pin: touchkey-int-state {
-		pins = "gpio6";
-		function = "normal";
-		bias-disable;
-		input-enable;
-		power-source = <PMA8084_GPIO_S4>;
-	};
-
-	touch_pin: touchscreen-int-state {
-		pins = "gpio8";
-		function = "normal";
-		bias-disable;
-		input-enable;
-		power-source = <PMA8084_GPIO_S4>;
-	};
-
-	panel_en_pin: panel-en-state {
-		pins = "gpio14";
-		function = "normal";
-		bias-pull-up;
-		power-source = <PMA8084_GPIO_S4>;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-	};
-
-	wlan_sleep_clk_pin: wlan-sleep-clk-state {
-		pins = "gpio16";
-		function = "func2";
-
-		output-high;
-		power-source = <PMA8084_GPIO_S4>;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
-	};
-
-	panel_rst_pin: panel-rst-state {
-		pins = "gpio17";
-		function = "normal";
-		bias-disable;
-		power-source = <PMA8084_GPIO_S4>;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-	};
-
-	fuelgauge_pin: fuelgauge-int-state {
-		pins = "gpio21";
-		function = "normal";
-		bias-disable;
-		input-enable;
-		power-source = <PMA8084_GPIO_S4>;
-	};
-};
-
-&remoteproc_adsp {
-	status = "okay";
-	cx-supply = <&pma8084_s2>;
-};
-
-&remoteproc_mss {
-	status = "okay";
-	cx-supply = <&pma8084_s2>;
-	mss-supply = <&pma8084_s6>;
-	mx-supply = <&pma8084_s1>;
-	pll-supply = <&pma8084_l12>;
-};
-
-&rpm_requests {
-	regulators-0 {
-		compatible = "qcom,rpm-pma8084-regulators";
-
-		pma8084_s1: s1 {
-			regulator-min-microvolt = <675000>;
-			regulator-max-microvolt = <1050000>;
-			regulator-always-on;
-		};
-
-		pma8084_s2: s2 {
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		pma8084_s3: s3 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pma8084_s4: s4 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pma8084_s5: s5 {
-			regulator-min-microvolt = <2150000>;
-			regulator-max-microvolt = <2150000>;
-		};
-
-		pma8084_s6: s6 {
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		pma8084_l1: l1 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1225000>;
-		};
-
-		pma8084_l2: l2 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pma8084_l3: l3 {
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pma8084_l4: l4 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1225000>;
-		};
-
-		pma8084_l5: l5 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pma8084_l6: l6 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pma8084_l7: l7 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pma8084_l8: l8 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pma8084_l9: l9 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pma8084_l10: l10 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pma8084_l11: l11 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pma8084_l12: l12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		pma8084_l13: l13 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pma8084_l14: l14 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pma8084_l15: l15 {
-			regulator-min-microvolt = <2050000>;
-			regulator-max-microvolt = <2050000>;
-		};
-
-		pma8084_l16: l16 {
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-		};
-
-		pma8084_l17: l17 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <2850000>;
-		};
-
-		pma8084_l18: l18 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <2850000>;
-		};
-
-		pma8084_l19: l19 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		pma8084_l20: l20 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-system-load = <200000>;
-			regulator-allow-set-load;
-		};
-
-		pma8084_l21: l21 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-system-load = <200000>;
-			regulator-allow-set-load;
-		};
-
-		pma8084_l22: l22 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		pma8084_l23: l23 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		pma8084_l24: l24 {
-			regulator-min-microvolt = <3075000>;
-			regulator-max-microvolt = <3075000>;
-		};
-
-		pma8084_l25: l25 {
-			regulator-min-microvolt = <2100000>;
-			regulator-max-microvolt = <2100000>;
-		};
-
-		pma8084_l26: l26 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2050000>;
-		};
-
-		pma8084_l27: l27 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1225000>;
-		};
-
-		pma8084_lvs1: lvs1 {};
-		pma8084_lvs2: lvs2 {};
-		pma8084_lvs3: lvs3 {};
-		pma8084_lvs4: lvs4 {};
-
-		pma8084_5vs1: 5vs1 {};
-	};
-};
-
-&sdhc_1 {
-	status = "okay";
-
-	vmmc-supply = <&pma8084_l20>;
-	vqmmc-supply = <&pma8084_s4>;
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_on>;
-	pinctrl-1 = <&sdc1_off>;
-};
-
-&sdhc_2 {
-	status = "okay";
-	max-frequency = <100000000>;
-	vmmc-supply = <&vreg_wlan>;
-	vqmmc-supply = <&pma8084_s4>;
-	non-removable;
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_on>;
-	pinctrl-1 = <&sdc2_off>;
-
-	wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&wlan_sleep_clk_pin &wifi_pin>;
-	};
-};
-
-&sdhc_3 {
-	status = "okay";
-	max-frequency = <100000000>;
-	vmmc-supply = <&pma8084_l21>;
-	vqmmc-supply = <&pma8084_l13>;
-
-	/*
-	 * cd-gpio is intentionally disabled. If enabled, an SD card
-	 * present during boot is not initialized correctly. Without
-	 * cd-gpios the driver resorts to polling, so hotplug works.
-	 */
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdc3_on /* &sdhc3_cd_pin */>;
-	/* cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>; */
-};
-
-&tlmm {
-	/* This seems suspicious, but somebody with this device should look into it. */
-	blsp2_uart2_pins_active: blsp2-uart2-pins-active-state {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "blsp_uart8";
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	blsp2_uart2_pins_sleep: blsp2-uart2-pins-sleep-state {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	bt_pins: bt-pins-state {
-		hostwake-pins {
-			pins = "gpio75";
-			function = "gpio";
-			drive-strength = <16>;
-		};
-
-		devwake-pins {
-			pins = "gpio91";
-			function = "gpio";
-			drive-strength = <2>;
-		};
-	};
-
-	sdc1_on: sdhc1-on-state {
-		clk-pins {
-			pins = "sdc1_clk";
-			drive-strength = <4>;
-			bias-disable;
-		};
-
-		cmd-data-pins {
-			pins = "sdc1_cmd", "sdc1_data";
-			drive-strength = <4>;
-			bias-pull-up;
-		};
-	};
-
-	sdc3_on: sdc3-on-state {
-		pins = "gpio35", "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
-		function = "sdc3";
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	sdhc3_cd_pin: sdc3-cd-on-state {
-		pins = "gpio62";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	sdc2_on: sdhc2-on-state {
-		clk-pins {
-			pins = "sdc2_clk";
-			drive-strength = <6>;
-			bias-disable;
-		};
-
-		cmd-data-pins {
-			pins = "sdc2_cmd", "sdc2_data";
-			drive-strength = <6>;
-			bias-pull-up;
-		};
-	};
-
-	i2c_touchkey_pins: i2c-touchkey-state {
-		pins = "gpio95", "gpio96";
-		function = "gpio";
-		bias-pull-up;
-	};
-
-	i2c_led_gpioex_pins: i2c-led-gpioex-state {
-		pins = "gpio120", "gpio121";
-		function = "gpio";
-		bias-pull-down;
-	};
-
-	gpioex_pin: gpioex-state {
-		pins = "gpio145";
-		function = "gpio";
-		bias-pull-up;
-		drive-strength = <2>;
-	};
-
-	wifi_pin: wifi-state {
-		pins = "gpio92";
-		function = "gpio";
-		bias-pull-down;
-	};
-
-	panel_te_pin: panel-state {
-		pins = "gpio12";
-		function = "mdp_vsync";
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&usb {
-	status = "okay";
-
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-};
-
-&usb_hs1_phy {
-	status = "okay";
-
-	v1p8-supply = <&pma8084_l6>;
-	v3p3-supply = <&pma8084_l24>;
-
-	qcom,init-seq = /bits/ 8 <0x1 0x64>;
-};
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro-samsung-klte-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy S5";
+	compatible = "samsung,klte", "qcom,msm8974pro", "qcom,msm8974";
+};
+
+&i2c_led_gpio {
+	scl-gpios = <&tlmm 121 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&tlmm 120 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c_led_gpioex_pins {
+	pins = "gpio120", "gpio121";
+};
-- 
2.43.0


