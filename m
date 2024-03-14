Return-Path: <linux-kernel+bounces-103706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46587C337
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEF01C21B10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83D763F8;
	Thu, 14 Mar 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="E6VXw2G7"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827474E31;
	Thu, 14 Mar 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442614; cv=none; b=YQ77WkgX+ViAIAUhsedKPpG/rczAafz9yK9TBgKmSfLPuPUx/JjadCL4a5kgWaOVCt5pQrvlDK9z4VGjcXJ0bf/lXItLwRLdXA3RrjWI1+4eLTQLQ0zfKuv+KxkycuVaOxT+Os/vs3uuBoDO1y/u2ZZTrN/x1geKYpBgh2I65Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442614; c=relaxed/simple;
	bh=GykL1bRFoOjLzZF/kfFllEfOj+zFslIxi5mU+F5gQZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpiyfTiY6OHq14Dey6F5vQ61c7RVwYcET8dVD3UHwVKPMrFN5zjlCNjqNLhP49MO96D0gJ1Pa3wA7pml2axsi0E7OmuptXYVp/G13awLX5zEDzPoeatbOChQjs40hlD70DB0n6yFSIGzemb0YKYLWkRPzSzvz2sxhQXrSxsR/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=E6VXw2G7; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710442604; bh=GykL1bRFoOjLzZF/kfFllEfOj+zFslIxi5mU+F5gQZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E6VXw2G7Uri9QMAwdXQFu+8GpuQvxYtLEtOFgA2QgJDWZkIvyUN6/SWjUkjEdMR0r
	 hclMIpNlMhRFMMd2JDXzYNxTb7W4Lk6nbDB8cAF1/nLPj6j64GZXouAMpSD9OgDwnn
	 +JcigMar04jOp8seWIaKQpyOnSd+YksFJmYNly58=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 14 Mar 2024 19:56:22 +0100
Subject: [PATCH v2 1/3] ARM: dts: qcom: msm8974-sony-castor: Split into
 shinano-common
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-shinano-common-v2-1-a0fce1c72c74@z3ntu.xyz>
References: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
In-Reply-To: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24945; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=GykL1bRFoOjLzZF/kfFllEfOj+zFslIxi5mU+F5gQZI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl80hkg2Y6lzdWAgYIdEBiD8JyW68CzcRBR3/k7
 0zGcnIuyTqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfNIZAAKCRBy2EO4nU3X
 ViHDD/sGrFfcpOCXbhPZZuZCOALnVHFCkEQVukYGX4uM9RYRmor7mHvpA7mEb8jyx0+1VzRSGT+
 B0GEE9uSo5c+Iv/rPT7ZRel9fMO7hBaxY8DQdBtvusWxy9aODU+B6qMBwyKrADBKEreRxLrTgV/
 +nLXWTbhl9efq2X7dsTJVoTg+Abc+dPbmwzzytjbxf8reVJuiy4F1BnkJcX9RZ553ItvoAgKA+c
 QKBS8uVM0d4zPjFGsnZtUakib/iuiiUR+9FjGF2GMBWOGiIi6d/7BirgfXkEOsS2uynU985Kpj/
 QoJ6PZOwIPObAHneLNVW3WOatpFhZBn7Sc7e3NvJV7IY/LgAq9b33ur9sQNa9lpzQnMkSkKOeAX
 KdtQd4oo+SXA/rWeP6l4kK3VTHBLtUUSnvsN+MynCFpmYIMjg86sqCvgGtTe4JKAG8CwsKNcJBQ
 5IKgYovFAVJcK7CwluEkBCG45bBTfCFFr+mK78HituBFIzirwDXu530tRqUEdsGLm+JXh63Ru7M
 hUo92A5rROS/xkmbmEJsmjDbGBlnmy+Nxxub9B4kzZFsT1Oq3pQaRPRUeothCIab34au07erxLQ
 FtlMVp5KNVIFRqcPeprgAie0KXlsz2oO4dGclaZo9eYoQKvMQ09Ineo0Cgr4dQUttxkhvqNpykS
 EtE/jWgMP+GuuNw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

In preparation for adding the Sony Xperia Z3 smartphone, split the
common parts into shinano-common.dtsi.

No functional change intended.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts | 863 +++++----------------
 ...com-msm8974pro-sony-xperia-shinano-common.dtsi} | 155 +---
 2 files changed, 179 insertions(+), 839 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
dissimilarity index 74%
index 20f98a9e49ea..409d1798de34 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -1,686 +1,177 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "qcom-msm8974pro.dtsi"
-#include "pm8841.dtsi"
-#include "pm8941.dtsi"
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-
-/ {
-	model = "Sony Xperia Z2 Tablet";
-	compatible = "sony,xperia-castor", "qcom,msm8974pro", "qcom,msm8974";
-	chassis-type = "tablet";
-
-	aliases {
-		mmc0 = &sdhc_1;
-		mmc1 = &sdhc_2;
-		serial0 = &blsp1_uart2;
-		serial1 = &blsp2_uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		pinctrl-0 = <&gpio_keys_pin_a>;
-		pinctrl-names = "default";
-
-		key-volume-down {
-			label = "volume_down";
-			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			debounce-interval = <15>;
-		};
-
-		key-volume-up {
-			label = "volume_up";
-			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <15>;
-		};
-	};
-
-	vreg_bl_vddio: lcd-backlight-vddio {
-		compatible = "regulator-fixed";
-		regulator-name = "vreg_bl_vddio";
-		regulator-min-microvolt = <3150000>;
-		regulator-max-microvolt = <3150000>;
-
-		gpio = <&tlmm 69 0>;
-		enable-active-high;
-
-		vin-supply = <&pm8941_s3>;
-		startup-delay-us = <70000>;
-
-		pinctrl-0 = <&lcd_backlight_en_pin_a>;
-		pinctrl-names = "default";
-	};
-
-	vreg_vsp: lcd-dcdc-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vreg_vsp";
-		regulator-min-microvolt = <5600000>;
-		regulator-max-microvolt = <5600000>;
-
-		gpio = <&pm8941_gpios 20 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-0 = <&lcd_dcdc_en_pin_a>;
-		pinctrl-names = "default";
-	};
-
-	vreg_boost: vreg-boost {
-		compatible = "regulator-fixed";
-
-		regulator-name = "vreg-boost";
-		regulator-min-microvolt = <3150000>;
-		regulator-max-microvolt = <3150000>;
-
-		regulator-always-on;
-		regulator-boot-on;
-
-		gpio = <&pm8941_gpios 21 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&boost_bypass_n_pin>;
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
-
-	vreg_wlan: wlan-regulator {
-		compatible = "regulator-fixed";
-
-		regulator-name = "wl-reg";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&pm8941_gpios 18 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-0 = <&wlan_regulator_pin>;
-		pinctrl-names = "default";
-	};
-};
-
-&blsp1_uart2 {
-	status = "okay";
-};
-
-&blsp2_i2c2 {
-	clock-frequency = <355000>;
-
-	status = "okay";
-
-	synaptics@2c {
-		compatible = "syna,rmi4-i2c";
-		reg = <0x2c>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <86 IRQ_TYPE_EDGE_FALLING>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd-supply = <&pm8941_l22>;
-		vio-supply = <&pm8941_lvs3>;
-
-		pinctrl-0 = <&ts_int_pin>;
-		pinctrl-names = "default";
-
-		syna,startup-delay-ms = <100>;
-
-		rmi4-f01@1 {
-			reg = <0x1>;
-			syna,nosleep-mode = <1>;
-		};
-
-		rmi4-f11@11 {
-			reg = <0x11>;
-			syna,sensor-type = <1>;
-			touchscreen-inverted-x;
-		};
-	};
-};
-
-&blsp2_i2c5 {
-	clock-frequency = <355000>;
-
-	status = "okay";
-
-	lp8566_wled: backlight@2c {
-		compatible = "ti,lp8556";
-		reg = <0x2c>;
-		power-supply = <&vreg_bl_vddio>;
-
-		bl-name = "backlight";
-		dev-ctrl = /bits/ 8 <0x05>;
-		init-brt = /bits/ 8 <0x3f>;
-
-		rom-a0h {
-			rom-addr = /bits/ 8 <0xa0>;
-			rom-val = /bits/ 8 <0xff>;
-		};
-		rom-a1h {
-			rom-addr = /bits/ 8 <0xa1>;
-			rom-val = /bits/ 8 <0x3f>;
-		};
-		rom-a2h {
-			rom-addr = /bits/ 8 <0xa2>;
-			rom-val = /bits/ 8 <0x20>;
-		};
-		rom-a3h {
-			rom-addr = /bits/ 8 <0xa3>;
-			rom-val = /bits/ 8 <0x5e>;
-		};
-		rom-a4h {
-			rom-addr = /bits/ 8 <0xa4>;
-			rom-val = /bits/ 8 <0x02>;
-		};
-		rom-a5h {
-			rom-addr = /bits/ 8 <0xa5>;
-			rom-val = /bits/ 8 <0x04>;
-		};
-		rom-a6h {
-			rom-addr = /bits/ 8 <0xa6>;
-			rom-val = /bits/ 8 <0x80>;
-		};
-		rom-a7h {
-			rom-addr = /bits/ 8 <0xa7>;
-			rom-val = /bits/ 8 <0xf7>;
-		};
-		rom-a9h {
-			rom-addr = /bits/ 8 <0xa9>;
-			rom-val = /bits/ 8 <0x80>;
-		};
-		rom-aah {
-			rom-addr = /bits/ 8 <0xaa>;
-			rom-val = /bits/ 8 <0x0f>;
-		};
-		rom-aeh {
-			rom-addr = /bits/ 8 <0xae>;
-			rom-val = /bits/ 8 <0x0f>;
-		};
-	};
-};
-
-&blsp2_uart1 {
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <3000000>;
-
-		pinctrl-0 = <&bt_host_wake_pin>, <&bt_dev_wake_pin>, <&bt_reg_on_pin>;
-		pinctrl-names = "default";
-
-		host-wakeup-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&pm8941_gpios 16 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&pm8941_coincell {
-	qcom,rset-ohms = <2100>;
-	qcom,vset-millivolts = <3000>;
-
-	status = "okay";
-};
-
-&pm8941_gpios {
-	gpio_keys_pin_a: gpio-keys-active-state {
-		pins = "gpio2", "gpio5";
-		function = "normal";
-		bias-pull-up;
-		power-source = <PM8941_GPIO_S3>;
-	};
-
-	bt_reg_on_pin: bt-reg-on-state {
-		pins = "gpio16";
-		function = "normal";
-		output-low;
-		power-source = <PM8941_GPIO_S3>;
-	};
-
-	wlan_sleep_clk_pin: wl-sleep-clk-state {
-		pins = "gpio17";
-		function = "func2";
-		output-high;
-		power-source = <PM8941_GPIO_S3>;
-	};
-
-	wlan_regulator_pin: wl-reg-active-state {
-		pins = "gpio18";
-		function = "normal";
-		bias-disable;
-		power-source = <PM8941_GPIO_S3>;
-	};
-
-	lcd_dcdc_en_pin_a: lcd-dcdc-en-active-state {
-		pins = "gpio20";
-		function = "normal";
-		bias-disable;
-		power-source = <PM8941_GPIO_S3>;
-		input-disable;
-		output-low;
-	};
-};
-
-&pm8941_lpg {
-	qcom,power-source = <1>;
-
-	status = "okay";
-
-	multi-led {
-		color = <LED_COLOR_ID_RGB>;
-		function = LED_FUNCTION_STATUS;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		led@5 {
-			reg = <5>;
-			color = <LED_COLOR_ID_BLUE>;
-		};
-
-		led@6 {
-			reg = <6>;
-			color = <LED_COLOR_ID_GREEN>;
-		};
-
-		led@7 {
-			reg = <7>;
-			color = <LED_COLOR_ID_RED>;
-		};
-	};
-};
-
-&remoteproc_adsp {
-	cx-supply = <&pm8841_s2>;
-	status = "okay";
-};
-
-&remoteproc_mss {
-	cx-supply = <&pm8841_s2>;
-	mss-supply = <&pm8841_s3>;
-	mx-supply = <&pm8841_s1>;
-	pll-supply = <&pm8941_l12>;
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators-0 {
-		compatible = "qcom,rpm-pm8841-regulators";
-
-		pm8841_s1: s1 {
-			regulator-min-microvolt = <675000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		pm8841_s2: s2 {
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		pm8841_s3: s3 {
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		pm8841_s4: s4 {
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1050000>;
-		};
-	};
-
-	regulators-1 {
-		compatible = "qcom,rpm-pm8941-regulators";
-
-		vdd_l1_l3-supply = <&pm8941_s1>;
-		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-		vdd_l4_l11-supply = <&pm8941_s1>;
-		vdd_l5_l7-supply = <&pm8941_s2>;
-		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-		vdd_l21-supply = <&vreg_boost>;
-
-		pm8941_s1: s1 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1300000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		pm8941_s2: s2 {
-			regulator-min-microvolt = <2150000>;
-			regulator-max-microvolt = <2150000>;
-			regulator-boot-on;
-		};
-
-		pm8941_s3: s3 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-system-load = <154000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		pm8941_s4: s4 {
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
-
-		pm8941_l1: l1 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1225000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		pm8941_l2: l2 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8941_l3: l3 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8941_l4: l4 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1225000>;
-		};
-
-		pm8941_l5: l5 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8941_l6: l6 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-boot-on;
-		};
-
-		pm8941_l7: l7 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-boot-on;
-		};
-
-		pm8941_l8: l8 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8941_l9: l9 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8941_l11: l11 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1350000>;
-		};
-
-		pm8941_l12: l12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		pm8941_l13: l13 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-boot-on;
-		};
-
-		pm8941_l14: l14 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8941_l15: l15 {
-			regulator-min-microvolt = <2050000>;
-			regulator-max-microvolt = <2050000>;
-		};
-
-		pm8941_l16: l16 {
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-		};
-
-		pm8941_l17: l17 {
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-		};
-
-		pm8941_l18: l18 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <2850000>;
-		};
-
-		pm8941_l19: l19 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <2850000>;
-		};
-
-		pm8941_l20: l20 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-system-load = <500000>;
-			regulator-allow-set-load;
-			regulator-boot-on;
-		};
-
-		pm8941_l21: l21 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-boot-on;
-		};
-
-		pm8941_l22: l22 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		pm8941_l23: l23 {
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-		};
-
-		pm8941_l24: l24 {
-			regulator-min-microvolt = <3075000>;
-			regulator-max-microvolt = <3075000>;
-			regulator-boot-on;
-		};
-
-		pm8941_lvs3: lvs3 {};
-	};
-};
-
-&sdhc_1 {
-	vmmc-supply = <&pm8941_l20>;
-	vqmmc-supply = <&pm8941_s3>;
-
-	pinctrl-0 = <&sdc1_on>;
-	pinctrl-1 = <&sdc1_off>;
-	pinctrl-names = "default", "sleep";
-
-	status = "okay";
-};
-
-&sdhc_2 {
-	vmmc-supply = <&pm8941_l21>;
-	vqmmc-supply = <&pm8941_l13>;
-
-	cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
-
-	pinctrl-0 = <&sdc2_on>;
-	pinctrl-1 = <&sdc2_off>;
-	pinctrl-names = "default", "sleep";
-
-	status = "okay";
-};
-
-&sdhc_3 {
-	max-frequency = <100000000>;
-	vmmc-supply = <&vreg_wlan>;
-	non-removable;
-
-	pinctrl-0 = <&sdc3_on>;
-	pinctrl-names = "default";
-
-	status = "okay";
-
-	wifi@1 {
-		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
-		reg = <1>;
-
-		brcm,drive-strength = <10>;
-
-		pinctrl-0 = <&wlan_sleep_clk_pin>;
-		pinctrl-names = "default";
-	};
-};
-
-&smbb {
-	qcom,fast-charge-safe-current = <1500000>;
-	qcom,fast-charge-current-limit = <1500000>;
-	qcom,dc-current-limit = <1800000>;
-	usb-charge-current-limit = <1800000>;
-	qcom,fast-charge-safe-voltage = <4400000>;
-	qcom,fast-charge-high-threshold-voltage = <4350000>;
-	qcom,fast-charge-low-threshold-voltage = <3400000>;
-	qcom,auto-recharge-threshold-voltage = <4200000>;
-	qcom,minimum-input-voltage = <4300000>;
-
-	status = "okay";
-};
-
-&tlmm {
-	lcd_backlight_en_pin_a: lcd-backlight-vddio-state {
-		pins = "gpio69";
-		function = "gpio";
-		drive-strength = <10>;
-		output-low;
-		bias-disable;
-	};
-
-	sdc1_on: sdc1-on-state {
-		clk-pins {
-			pins = "sdc1_clk";
-			drive-strength = <16>;
-			bias-disable;
-		};
-
-		cmd-data-pins {
-			pins = "sdc1_cmd", "sdc1_data";
-			drive-strength = <10>;
-			bias-pull-up;
-		};
-	};
-
-	sdc2_on: sdc2-on-state {
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
-
-		cd-pins {
-			pins = "gpio62";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	sdc3_on: sdc3-on-state {
-		clk-pins {
-			pins = "gpio40";
-			function = "sdc3";
-			drive-strength = <10>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio39";
-			function = "sdc3";
-			drive-strength = <10>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio35", "gpio36", "gpio37", "gpio38";
-			function = "sdc3";
-			drive-strength = <10>;
-			bias-pull-up;
-		};
-	};
-
-	ts_int_pin: ts-int-pin-state {
-		pins = "gpio86";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	bt_host_wake_pin: bt-host-wake-state {
-		pins = "gpio95";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-		output-low;
-	};
-
-	bt_dev_wake_pin: bt-dev-wake-state {
-		pins = "gpio96";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&usb {
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-	extcon = <&smbb>, <&usb_id>;
-	vbus-supply = <&chg_otg>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	status = "okay";
-};
-
-&usb_hs1_phy {
-	v1p8-supply = <&pm8941_l6>;
-	v3p3-supply = <&pm8941_l24>;
-
-	extcon = <&smbb>;
-	qcom,init-seq = /bits/ 8 <0x1 0x64>;
-
-	status = "okay";
-};
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro-sony-xperia-shinano-common.dtsi"
+
+/ {
+	model = "Sony Xperia Z2 Tablet";
+	compatible = "sony,xperia-castor", "qcom,msm8974pro", "qcom,msm8974";
+	chassis-type = "tablet";
+
+	vreg_bl_vddio: lcd-backlight-vddio {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_bl_vddio";
+		regulator-min-microvolt = <3150000>;
+		regulator-max-microvolt = <3150000>;
+
+		gpio = <&tlmm 69 0>;
+		enable-active-high;
+
+		vin-supply = <&pm8941_s3>;
+		startup-delay-us = <70000>;
+
+		pinctrl-0 = <&lcd_backlight_en_pin_a>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp2_i2c5 {
+	clock-frequency = <355000>;
+
+	status = "okay";
+
+	lp8566_wled: backlight@2c {
+		compatible = "ti,lp8556";
+		reg = <0x2c>;
+		power-supply = <&vreg_bl_vddio>;
+
+		bl-name = "backlight";
+		dev-ctrl = /bits/ 8 <0x05>;
+		init-brt = /bits/ 8 <0x3f>;
+
+		rom-a0h {
+			rom-addr = /bits/ 8 <0xa0>;
+			rom-val = /bits/ 8 <0xff>;
+		};
+
+		rom-a1h {
+			rom-addr = /bits/ 8 <0xa1>;
+			rom-val = /bits/ 8 <0x3f>;
+		};
+
+		rom-a2h {
+			rom-addr = /bits/ 8 <0xa2>;
+			rom-val = /bits/ 8 <0x20>;
+		};
+
+		rom-a3h {
+			rom-addr = /bits/ 8 <0xa3>;
+			rom-val = /bits/ 8 <0x5e>;
+		};
+
+		rom-a4h {
+			rom-addr = /bits/ 8 <0xa4>;
+			rom-val = /bits/ 8 <0x02>;
+		};
+
+		rom-a5h {
+			rom-addr = /bits/ 8 <0xa5>;
+			rom-val = /bits/ 8 <0x04>;
+		};
+
+		rom-a6h {
+			rom-addr = /bits/ 8 <0xa6>;
+			rom-val = /bits/ 8 <0x80>;
+		};
+
+		rom-a7h {
+			rom-addr = /bits/ 8 <0xa7>;
+			rom-val = /bits/ 8 <0xf7>;
+		};
+
+		rom-a9h {
+			rom-addr = /bits/ 8 <0xa9>;
+			rom-val = /bits/ 8 <0x80>;
+		};
+
+		rom-aah {
+			rom-addr = /bits/ 8 <0xaa>;
+			rom-val = /bits/ 8 <0x0f>;
+		};
+
+		rom-aeh {
+			rom-addr = /bits/ 8 <0xae>;
+			rom-val = /bits/ 8 <0x0f>;
+		};
+	};
+};
+
+&blsp2_uart1 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+
+		pinctrl-0 = <&bt_host_wake_pin>, <&bt_dev_wake_pin>, <&bt_reg_on_pin>;
+		pinctrl-names = "default";
+
+		host-wakeup-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&pm8941_gpios 16 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&pm8941_gpios {
+	bt_reg_on_pin: bt-reg-on-state {
+		pins = "gpio16";
+		function = "normal";
+		output-low;
+		power-source = <PM8941_GPIO_S3>;
+	};
+};
+
+&rpm_requests {
+	regulators-1 {
+		pm8941_l11: l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8941_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+	};
+};
+
+&smbb {
+	qcom,fast-charge-safe-current = <1500000>;
+	qcom,fast-charge-current-limit = <1500000>;
+	qcom,dc-current-limit = <1800000>;
+	usb-charge-current-limit = <1800000>;
+	qcom,fast-charge-safe-voltage = <4400000>;
+	qcom,fast-charge-high-threshold-voltage = <4350000>;
+	qcom,fast-charge-low-threshold-voltage = <3400000>;
+	qcom,auto-recharge-threshold-voltage = <4200000>;
+	qcom,minimum-input-voltage = <4300000>;
+
+	status = "okay";
+};
+
+&synaptics_touchscreen {
+	vio-supply = <&pm8941_lvs3>;
+};
+
+&tlmm {
+	bt_dev_wake_pin: bt-dev-wake-state {
+		pins = "gpio96";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	bt_host_wake_pin: bt-host-wake-state {
+		pins = "gpio95";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	lcd_backlight_en_pin_a: lcd-backlight-vddio-state {
+		pins = "gpio69";
+		function = "gpio";
+		drive-strength = <10>;
+		output-low;
+		bias-disable;
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
similarity index 75%
copy from arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
copy to arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
index 20f98a9e49ea..3a0c0035de09 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
@@ -7,10 +7,6 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
-	model = "Sony Xperia Z2 Tablet";
-	compatible = "sony,xperia-castor", "qcom,msm8974pro", "qcom,msm8974";
-	chassis-type = "tablet";
-
 	aliases {
 		mmc0 = &sdhc_1;
 		mmc1 = &sdhc_2;
@@ -43,22 +39,6 @@ key-volume-up {
 		};
 	};
 
-	vreg_bl_vddio: lcd-backlight-vddio {
-		compatible = "regulator-fixed";
-		regulator-name = "vreg_bl_vddio";
-		regulator-min-microvolt = <3150000>;
-		regulator-max-microvolt = <3150000>;
-
-		gpio = <&tlmm 69 0>;
-		enable-active-high;
-
-		vin-supply = <&pm8941_s3>;
-		startup-delay-us = <70000>;
-
-		pinctrl-0 = <&lcd_backlight_en_pin_a>;
-		pinctrl-names = "default";
-	};
-
 	vreg_vsp: lcd-dcdc-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_vsp";
@@ -123,7 +103,7 @@ &blsp2_i2c2 {
 
 	status = "okay";
 
-	synaptics@2c {
+	synaptics_touchscreen: synaptics@2c {
 		compatible = "syna,rmi4-i2c";
 		reg = <0x2c>;
 
@@ -134,7 +114,7 @@ synaptics@2c {
 		#size-cells = <0>;
 
 		vdd-supply = <&pm8941_l22>;
-		vio-supply = <&pm8941_lvs3>;
+		/* vio-supply is set in dts */
 
 		pinctrl-0 = <&ts_int_pin>;
 		pinctrl-names = "default";
@@ -154,83 +134,6 @@ rmi4-f11@11 {
 	};
 };
 
-&blsp2_i2c5 {
-	clock-frequency = <355000>;
-
-	status = "okay";
-
-	lp8566_wled: backlight@2c {
-		compatible = "ti,lp8556";
-		reg = <0x2c>;
-		power-supply = <&vreg_bl_vddio>;
-
-		bl-name = "backlight";
-		dev-ctrl = /bits/ 8 <0x05>;
-		init-brt = /bits/ 8 <0x3f>;
-
-		rom-a0h {
-			rom-addr = /bits/ 8 <0xa0>;
-			rom-val = /bits/ 8 <0xff>;
-		};
-		rom-a1h {
-			rom-addr = /bits/ 8 <0xa1>;
-			rom-val = /bits/ 8 <0x3f>;
-		};
-		rom-a2h {
-			rom-addr = /bits/ 8 <0xa2>;
-			rom-val = /bits/ 8 <0x20>;
-		};
-		rom-a3h {
-			rom-addr = /bits/ 8 <0xa3>;
-			rom-val = /bits/ 8 <0x5e>;
-		};
-		rom-a4h {
-			rom-addr = /bits/ 8 <0xa4>;
-			rom-val = /bits/ 8 <0x02>;
-		};
-		rom-a5h {
-			rom-addr = /bits/ 8 <0xa5>;
-			rom-val = /bits/ 8 <0x04>;
-		};
-		rom-a6h {
-			rom-addr = /bits/ 8 <0xa6>;
-			rom-val = /bits/ 8 <0x80>;
-		};
-		rom-a7h {
-			rom-addr = /bits/ 8 <0xa7>;
-			rom-val = /bits/ 8 <0xf7>;
-		};
-		rom-a9h {
-			rom-addr = /bits/ 8 <0xa9>;
-			rom-val = /bits/ 8 <0x80>;
-		};
-		rom-aah {
-			rom-addr = /bits/ 8 <0xaa>;
-			rom-val = /bits/ 8 <0x0f>;
-		};
-		rom-aeh {
-			rom-addr = /bits/ 8 <0xae>;
-			rom-val = /bits/ 8 <0x0f>;
-		};
-	};
-};
-
-&blsp2_uart1 {
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <3000000>;
-
-		pinctrl-0 = <&bt_host_wake_pin>, <&bt_dev_wake_pin>, <&bt_reg_on_pin>;
-		pinctrl-names = "default";
-
-		host-wakeup-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&pm8941_gpios 16 GPIO_ACTIVE_HIGH>;
-	};
-};
-
 &pm8941_coincell {
 	qcom,rset-ohms = <2100>;
 	qcom,vset-millivolts = <3000>;
@@ -246,13 +149,6 @@ gpio_keys_pin_a: gpio-keys-active-state {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	bt_reg_on_pin: bt-reg-on-state {
-		pins = "gpio16";
-		function = "normal";
-		output-low;
-		power-source = <PM8941_GPIO_S3>;
-	};
-
 	wlan_sleep_clk_pin: wl-sleep-clk-state {
 		pins = "gpio17";
 		function = "func2";
@@ -431,11 +327,6 @@ pm8941_l9: l9 {
 			regulator-max-microvolt = <2950000>;
 		};
 
-		pm8941_l11: l11 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1350000>;
-		};
-
 		pm8941_l12: l12 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -474,11 +365,6 @@ pm8941_l18: l18 {
 			regulator-max-microvolt = <2850000>;
 		};
 
-		pm8941_l19: l19 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <2850000>;
-		};
-
 		pm8941_l20: l20 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
@@ -558,29 +444,7 @@ wifi@1 {
 	};
 };
 
-&smbb {
-	qcom,fast-charge-safe-current = <1500000>;
-	qcom,fast-charge-current-limit = <1500000>;
-	qcom,dc-current-limit = <1800000>;
-	usb-charge-current-limit = <1800000>;
-	qcom,fast-charge-safe-voltage = <4400000>;
-	qcom,fast-charge-high-threshold-voltage = <4350000>;
-	qcom,fast-charge-low-threshold-voltage = <3400000>;
-	qcom,auto-recharge-threshold-voltage = <4200000>;
-	qcom,minimum-input-voltage = <4300000>;
-
-	status = "okay";
-};
-
 &tlmm {
-	lcd_backlight_en_pin_a: lcd-backlight-vddio-state {
-		pins = "gpio69";
-		function = "gpio";
-		drive-strength = <10>;
-		output-low;
-		bias-disable;
-	};
-
 	sdc1_on: sdc1-on-state {
 		clk-pins {
 			pins = "sdc1_clk";
@@ -645,21 +509,6 @@ ts_int_pin: ts-int-pin-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
-
-	bt_host_wake_pin: bt-host-wake-state {
-		pins = "gpio95";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-		output-low;
-	};
-
-	bt_dev_wake_pin: bt-dev-wake-state {
-		pins = "gpio96";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
 };
 
 &usb {

-- 
2.44.0


