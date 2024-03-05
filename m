Return-Path: <linux-kernel+bounces-93095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243AB872B05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B530E283BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B212E1F7;
	Tue,  5 Mar 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="sfGqy1Q0"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093712D210;
	Tue,  5 Mar 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681209; cv=none; b=eJvoQ3T2oNzolG+NWVwsYG2arv/rdROPuZw0aVTQWxaDSiT5PZhSBYZPam/fuENojPtsUgdmzTQDs14RgUyHOPpu9lu7Bnzg1Tfs+t0p9BYUqJuvL6w4XyyPq27Sr3SLgzD3Nl/q6/aGOz//Qg22dm4N1IV2Lt2SGjqNzdTlWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681209; c=relaxed/simple;
	bh=jLpcizMG9m6smy+sfVYj6nIGQ7x4GGdWHU14fZkh1G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCP8EIoChKFxIV3hUqP0IJoVI1xR3e0RwhPLpvJ7ZKarM6AHRVHk0JnPwb0Pciahjq2qxxAn3XOZQJUJXF716pxq0r3wq8435zpZ4VkCtefvT23WK4qNOzGMPEHWu3chki6vOGHeOudkDH8pP/6eem0myP3rlw+ZcHe03N0tsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=sfGqy1Q0; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1709680705; bh=jLpcizMG9m6smy+sfVYj6nIGQ7x4GGdWHU14fZkh1G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=sfGqy1Q0pppPv2zTd6+FVgei1xudvu3iM9GSR1l+euUekZ6btrIkh3i+4MrAsZWS0
	 hwTTg0tW1hnY0Jzm/1bXd0asV5+3yGL4xneMxCkNCFJ31fxRs+vG+yRTU54vG/vSor
	 pXwsn/1kg7SjOr8xngNxcXJiUJSutP5CL2O0mThk=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 06 Mar 2024 00:18:04 +0100
Subject: [PATCH 1/5] ARM: dts: qcom: msm8974pro-castor: Clean up formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-castor-changes-v1-1-2286eaf85fff@z3ntu.xyz>
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6482; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=jLpcizMG9m6smy+sfVYj6nIGQ7x4GGdWHU14fZkh1G8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl56g7WwXzYZMJFK3azJXJzROXMz2wgDC78KV3c
 ZIxHm8sQTCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZeeoOwAKCRBy2EO4nU3X
 VkDdD/9CydSEVn4limvreJnnGIlfNI9QiWj00RThUXEGDflqf9FjOcKSFZIO1M979cMiol3T+qz
 9B+Q6N+4whNIV40eJlT+6radviHJ/XWi0OMk/v7BoJuNXAQC4QLgsqUvUqEn0eMi3fDbw0yGI0Z
 zuCUS9UAzj7zcEqknvkf33NXCjszRqzVwycy4fsBTBKPnbOCIxOJq6pTO2vC3u99vZngvTU7MY6
 q0WlK9yGcCGQmCowDBnQ4dtlFEFGQVUGqBwqXZD3eIneG3vq4aFTyHpW/tv3C5GYcGAV0pFhqbk
 4zFdpqUDa1t64Aa0uAPv8oEFkQAN10+kpTC+51I6C5hCflkOBSrZY7f2MvHzUE85O/SW4R8YcKZ
 WH9G9rBwBOO53LAhM1C4TOWetlcUIrB+Ubye6iXA69yvM7ueXRIsXiODjZg0wCGRL1RHnpC3QqY
 7C98C43GELAZhGoDuCsFcKtT0jADt5H8ipzVCszv2aFWhb5Alby5fbzoCIzwIsSiWY/t4/c4ZoC
 5+tMmxv3okIX7izSgQ6gxtCr0XAo2dkn0ehmIfdbOWl9cs2dMjo0THmAiXrkHmSkoDG3liLfuAb
 dL0yKke0bp1QowL1ERRqC6AvN7B8xy4wGZomUhqKydnk3Ts0g2CTEXNfj9GPRb6TUymIun33bZM
 DDZsmInPbSq8skg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Clean up some easy things do prepare the dts for further changes.

* Move pinctrl-names below pinctrl-*
* Move status as last property
* Remove default linux,input-type value

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts | 65 +++++++++-------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index ee94741a26ed..2db2ddf00580 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -23,34 +23,30 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
+		pinctrl-names = "default";
 
 		key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
 		key-camera-snapshot {
 			label = "camera_snapshot";
 			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA>;
 		};
 
 		key-camera-focus {
 			label = "camera_focus";
 			gpios = <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA_FOCUS>;
 		};
 
 		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 	};
@@ -67,8 +63,8 @@ vreg_bl_vddio: lcd-backlight-vddio {
 		vin-supply = <&pm8941_s3>;
 		startup-delay-us = <70000>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_backlight_en_pin_a>;
+		pinctrl-names = "default";
 	};
 
 	vreg_vsp: lcd-dcdc-regulator {
@@ -80,8 +76,8 @@ vreg_vsp: lcd-dcdc-regulator {
 		gpio = <&pm8941_gpios 20 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_dcdc_en_pin_a>;
+		pinctrl-names = "default";
 	};
 
 	vreg_boost: vreg-boost {
@@ -121,8 +117,8 @@ vreg_wlan: wlan-regulator {
 		gpio = <&pm8941_gpios 18 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&wlan_regulator_pin>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -131,9 +127,10 @@ &blsp1_uart2 {
 };
 
 &blsp2_i2c2 {
-	status = "okay";
 	clock-frequency = <355000>;
 
+	status = "okay";
+
 	synaptics@2c {
 		compatible = "syna,rmi4-i2c";
 		reg = <0x2c>;
@@ -147,8 +144,8 @@ synaptics@2c {
 		vdd-supply = <&pm8941_l22>;
 		vio-supply = <&pm8941_lvs3>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&ts_int_pin>;
+		pinctrl-names = "default";
 
 		syna,startup-delay-ms = <100>;
 
@@ -166,9 +163,10 @@ rmi4-f11@11 {
 };
 
 &blsp2_i2c5 {
-	status = "okay";
 	clock-frequency = <355000>;
 
+	status = "okay";
+
 	lp8566_wled: backlight@2c {
 		compatible = "ti,lp8556";
 		reg = <0x2c>;
@@ -232,8 +230,8 @@ bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <3000000>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_pin>, <&bt_dev_wake_pin>, <&bt_reg_on_pin>;
+		pinctrl-names = "default";
 
 		host-wakeup-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
 		device-wakeup-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
@@ -242,17 +240,16 @@ bluetooth {
 };
 
 &pm8941_coincell {
-	status = "okay";
-
 	qcom,rset-ohms = <2100>;
 	qcom,vset-millivolts = <3000>;
+
+	status = "okay";
 };
 
 &pm8941_gpios {
 	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio5";
 		function = "normal";
-
 		bias-pull-up;
 		power-source = <PM8941_GPIO_S3>;
 	};
@@ -260,7 +257,6 @@ gpio_keys_pin_a: gpio-keys-active-state {
 	bt_reg_on_pin: bt-reg-on-state {
 		pins = "gpio16";
 		function = "normal";
-
 		output-low;
 		power-source = <PM8941_GPIO_S3>;
 	};
@@ -268,7 +264,6 @@ bt_reg_on_pin: bt-reg-on-state {
 	wlan_sleep_clk_pin: wl-sleep-clk-state {
 		pins = "gpio17";
 		function = "func2";
-
 		output-high;
 		power-source = <PM8941_GPIO_S3>;
 	};
@@ -276,7 +271,6 @@ wlan_sleep_clk_pin: wl-sleep-clk-state {
 	wlan_regulator_pin: wl-reg-active-state {
 		pins = "gpio18";
 		function = "normal";
-
 		bias-disable;
 		power-source = <PM8941_GPIO_S3>;
 	};
@@ -284,20 +278,18 @@ wlan_regulator_pin: wl-reg-active-state {
 	lcd_dcdc_en_pin_a: lcd-dcdc-en-active-state {
 		pins = "gpio20";
 		function = "normal";
-
 		bias-disable;
 		power-source = <PM8941_GPIO_S3>;
 		input-disable;
 		output-low;
 	};
-
 };
 
 &pm8941_lpg {
-	status = "okay";
-
 	qcom,power-source = <1>;
 
+	status = "okay";
+
 	multi-led {
 		color = <LED_COLOR_ID_RGB>;
 		function = LED_FUNCTION_STATUS;
@@ -530,41 +522,38 @@ pm8941_l24: l24 {
 };
 
 &sdhc_1 {
-	status = "okay";
-
 	vmmc-supply = <&pm8941_l20>;
 	vqmmc-supply = <&pm8941_s3>;
 
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_on>;
 	pinctrl-1 = <&sdc1_off>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
 };
 
 &sdhc_2 {
-	status = "okay";
-
 	vmmc-supply = <&pm8941_l21>;
 	vqmmc-supply = <&pm8941_l13>;
 
 	cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_on>;
 	pinctrl-1 = <&sdc2_off>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
 };
 
 &sdhc_3 {
-	status = "okay";
-
 	max-frequency = <100000000>;
 	vmmc-supply = <&vreg_wlan>;
 	non-removable;
 
-	pinctrl-names = "default";
 	pinctrl-0 = <&sdc3_on>;
+	pinctrl-names = "default";
 
-	#address-cells = <1>;
-	#size-cells = <0>;
+	status = "okay";
 
 	bcrmf@1 {
 		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
@@ -572,8 +561,8 @@ bcrmf@1 {
 
 		brcm,drive-strength = <10>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&wlan_sleep_clk_pin>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -682,8 +671,6 @@ bt_dev_wake_pin: bt-dev-wake-state {
 };
 
 &usb {
-	status = "okay";
-
 	phys = <&usb_hs1_phy>;
 	phy-select = <&tcsr 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
@@ -692,14 +679,16 @@ &usb {
 	hnp-disable;
 	srp-disable;
 	adp-disable;
+
+	status = "okay";
 };
 
 &usb_hs1_phy {
-	status = "okay";
-
 	v1p8-supply = <&pm8941_l6>;
 	v3p3-supply = <&pm8941_l24>;
 
 	extcon = <&smbb>;
 	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+
+	status = "okay";
 };

-- 
2.44.0


