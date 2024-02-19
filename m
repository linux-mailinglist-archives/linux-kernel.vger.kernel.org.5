Return-Path: <linux-kernel+bounces-72026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718CE85ADFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD87F1F22D30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5C56450;
	Mon, 19 Feb 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b="gcCykrDY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdBvP9UO"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCE54BEA;
	Mon, 19 Feb 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379213; cv=none; b=hTTRDYnE5NpJ5lw4cGLAnquKFL/28jL+eNk6er2O+PKjHpSWYzt01UriKmwtfkpvGaMbSyhYHf0FCwW5T4/oigqVms3D6mlidRVqKMCar4gwbSIovHh+qdaYWTOnHsvTVucvnYeqmQg4NnwuweNmqR5j+uqbUgsyUmvrcEEzT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379213; c=relaxed/simple;
	bh=sU39YbKku8mXE/aY0ZWiraR7QZzuNLbAQA9J2rJXQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km+MOrkdIioXWLvLmK85ZD+yCeBU6axeESd01qG3zGpx5AWgpnrhp4Flg9bPUYahcobhEbEHU9aeem0kF9fCdu4rb0XY3Na2nYZT7iUtQyeYG72Vno3L5eb++TVuxQ3RObFpa9uA1fTTlhQrNSA6g3TE+KX3cqK2NLU+QK5D45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs; spf=pass smtp.mailfrom=mai.rs; dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b=gcCykrDY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdBvP9UO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mai.rs
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2B52811400B9;
	Mon, 19 Feb 2024 16:46:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 19 Feb 2024 16:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708379210;
	 x=1708465610; bh=FJGJ+B62/Wk2fu6tcgjJYzyMNA6lL8H9GH01boCnbf8=; b=
	gcCykrDYtPsrwHsbmnWk2p8PWpsSYCPo1sxEN1j20wxomdPPsiDNBwjFXfaPBI1Y
	4iN6CxrTDm2L9PBjcQeELLrmsPrSxpXjiWNs8gMAsbx6LSYiHyBw4pk20rW79y0S
	yBFlxuEHmgFWj9Q1pvmt4gjYCrkKDZC7geYuWLzvLEOrOidEXvdFKX60KKmgaofT
	iQHjfLko0dV3gOt2Gv+8FSsUv3gz+AiiPU+vxi8zWRS5uMu8aIgnlLd8GC//I97T
	sj2qO6sql28DXcsOpwrBnZ+2b40g86I4+6W5Ffb/hu5xa5602HTx4lFEkLkYh97L
	MY1XrJ/6rTCnzSEY2jfooQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708379210; x=
	1708465610; bh=FJGJ+B62/Wk2fu6tcgjJYzyMNA6lL8H9GH01boCnbf8=; b=V
	dBvP9UOzVLlcBswhG8cC/EKrogBbr1lO+TWHaF7ZIK3/Ob4qQqQAAaUlFxO2Qrlb
	RGSNOCnP0oi2cbB6mQ+eROD+TsJWnBPsDrY05kX+gFF3Asyf0sagFGKYKT4jk1Hr
	Qq5RBivltTp+ItAc3NriTKZUjVR11Lwr93j9gvMRsC0N78prflpmqqNYI+iRj1re
	fmmCWpZJJT0PEZH5ihGeePc/gOMKCELYKAhHowjLRrqZSenLVbxxEoDD1LHV92mh
	zuh712As/XwNhOXrd1rqnD7oa+8Xyx9JBxKuOFWODBRofNcf5reMfdR3xAdWVJeJ
	/Bg5bdHmxOLDNu8wrFzkw==
X-ME-Sender: <xms:SczTZYDhj_d8zOuqdffJ2vZ9yy1S-MJ45LqrSC7FYO-u1dQ3jbWn1w>
    <xme:SczTZagf0tY-58kdaI7aeUuH-u_zfzQRl_W170gRScyHguAPa32iD3qG5j3NHNyol
    xW4A3z-ohgoE6mcmQ>
X-ME-Received: <xmr:SczTZbnCKBaaG4NKUmvjIA2C_TOTXTIIlEzWKKbEih_HBgZ4ClhM-omnvVSjWbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludejmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredt
    redtjeenucfhrhhomhepuehrhigrnhhtucforghirhhsuceosghrhigrnhhtsehmrghird
    hrsheqnecuggftrfgrthhtvghrnhepuefhvdevheeitdelveehhfffhedvgfetkeevtdfg
    ieefgedtgedukeelkeffteffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghrhigrnhhtsehmrghirdhrsh
X-ME-Proxy: <xmx:SszTZeyKvENTj9pa5-x744m_1CLFMCVEZghpm3ISiOKGpDMFLaf1AQ>
    <xmx:SszTZdTy6jEKl33JN20LOrrduklo7IWF7IC9ZN7dfRbYwfmwAXAT3g>
    <xmx:SszTZZZ4iouSxp9SL--NcFNXHJB6sG2twx815qMC7OPwK7glBGhdmg>
    <xmx:SszTZcLO82piEosyu9k6h8RbP1ChFBhmFT-VTgHOv74B-3Tlqo8oHg>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 16:46:48 -0500 (EST)
From: Bryant Mairs <bryant@mai.rs>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luca@z3ntu.xyz
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 2/2] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 8.0 Wi-Fi
Date: Mon, 19 Feb 2024 22:43:17 +0100
Message-ID: <20240219214643.197116-3-bryant@mai.rs>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219214643.197116-1-bryant@mai.rs>
References: <20240219214643.197116-1-bryant@mai.rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for this tablet based on the MSM8226 SoC, codenamed
"milletwifi".

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../qcom/qcom-apq8026-samsung-milletwifi.dts  | 573 ++++++++++++++++++
 2 files changed, 574 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 9cc1e14e6cd0..730d98c2c715 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8026-huawei-sturgeon.dtb \
 	qcom-apq8026-lg-lenok.dtb \
 	qcom-apq8026-samsung-matisse-wifi.dtb \
+	qcom-apq8026-samsung-milletwifi.dtb \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
new file mode 100644
index 000000000000..7d519156d91d
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
+ * Copyright (c) 2023, Bryant Mairs <bryant@mai.rs>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
+#include "qcom-msm8226.dtsi"
+#include "pm8226.dtsi"
+
+/delete-node/ &adsp_region;
+/delete-node/ &smem_region;
+
+/ {
+	model = "Samsung Galaxy Tab 4 8.0 Wi-Fi";
+	compatible = "samsung,milletwifi", "qcom,apq8026";
+	chassis-type = "tablet";
+
+	aliases {
+		display0 = &framebuffer0;
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		stdout-path = "display0";
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x03200000 0x800000>;
+			width = <800>;
+			height = <1280>;
+			stride = <(800 * 3)>;
+			format = "r8g8b8";
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		event-hall-sensor {
+			label = "Cover";
+			gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		key-home {
+			label = "Home";
+			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	i2c-backlight {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-0 = <&backlight_i2c_default_state>;
+		pinctrl-names = "default";
+
+		i2c-gpio,delay-us = <4>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+			enable-supply = <&reg_backlight_vddio>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x3f>;
+
+			/*
+			 * Change transition duration: 200ms, Change
+			 * transition strength: heavy, PWM hysteresis:
+			 * 1-bit w/ 8-bit resolution
+			 */
+			rom-a3h {
+				rom-addr = /bits/ 8 <0xa3>;
+				rom-val = /bits/ 8 <0x5e>;
+			};
+
+			/*
+			 * PWM phase configuration: 3-phase/3 drivers
+			 * (0, 120deg, 240deg, -, -, -),
+			 * PWM frequency: 9616Hz (10-bit)
+			 */
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x34>;
+			};
+
+			/*
+			 * Enable LED drivers 2 & 3, Boot inductor
+			 * current limit: 1.5A/2.6A
+			 */
+			rom-a7h {
+				rom-addr = /bits/ 8 <0xa7>;
+				rom-val = /bits/ 8 <0xfa>;
+			};
+		};
+	};
+
+	reg_backlight_vddio: regulator-backlight-vddio {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight_vddio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&backlight_vddio_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 114 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en1_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x03200000 0x800000>;
+			no-map;
+		};
+
+		mpss_region: mpss@8400000 {
+			reg = <0x08400000 0x1f00000>;
+			no-map;
+		};
+
+		mba_region: mba@a300000 {
+			reg = <0x0a300000 0x100000>;
+			no-map;
+		};
+
+		reserved@cb00000 {
+			reg = <0x0cb00000 0x700000>;
+			no-map;
+		};
+
+		wcnss_region: wcnss@d200000 {
+			reg = <0x0d200000 0x700000>;
+			no-map;
+		};
+
+		adsp_region: adsp@d900000 {
+			reg = <0x0d900000 0x1800000>;
+			no-map;
+		};
+
+		venus@f100000 {
+			reg = <0x0f100000 0x500000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+
+		reserved@fb00000 {
+			reg = <0x0fb00000 0x260000>;
+			no-map;
+		};
+
+		rfsa@fd60000 {
+			reg = <0x0fd60000 0x20000>;
+			no-map;
+		};
+
+		rmtfs@fd80000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0fd80000 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	accelerometer@1d {
+		compatible = "st,lis2hh12";
+		reg = <0x1d>;
+
+		interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-0 = <&accel_int_default_state>;
+		pinctrl-names = "default";
+
+		vdd-supply = <&pm8226_l19>;
+		vddio-supply = <&pm8226_lvs1>;
+
+		mount-matrix = "0", "1", "0",
+			       "-1", "0", "0",
+			       "0", "0", "1";
+
+		st,drdy-int-pin = <1>;
+	};
+};
+
+&blsp1_i2c3 {
+	status = "okay";
+
+	charger@6a {
+		compatible = "summit,smb358";
+		reg = <0x6a>;
+
+		interrupts-extended = <&tlmm 115 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&charger_int_default_state>;
+		pinctrl-names = "default";
+
+		summit,enable-usb-charging;
+		summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+		summit,fast-voltage-threshold-microvolt = <3000000>;
+		summit,chip-temperature-threshold-celsius = <130>;
+		summit,usb-current-limit-microamp = <1500000>;
+	};
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	muic: usb-switch@25 {
+		compatible = "siliconmitus,sm5502-muic";
+		reg = <0x25>;
+
+		interrupts-extended = <&tlmm 67 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&muic_int_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp1_i2c5 {
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "melfas,mms252", "melfas,mms114";
+		reg = <0x48>;
+		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <1280>;
+		avdd-supply = <&reg_tsp_3p3v>;
+		vdd-supply = <&reg_tsp_1p8v>;
+		linux,keycodes = <KEY_APPSELECT KEY_BACK>;
+
+		pinctrl-0 = <&tsp_int_rst_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+			regulator-always-on;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&sdhc2_default_state>, <&sdc2_cd_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&tlmm {
+	accel_int_default_state: accel-int-default-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_i2c_default_state: backlight-i2c-default-state {
+		pins = "gpio20", "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_vddio_default_state: backlight-vddio-default-state {
+		pins = "gpio74";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	charger_int_default_state: charger-int-default-state {
+		pins = "gpio115";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	muic_int_default_state: muic-int-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sdc2_cd_default_state: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en_default_state: tsp-en-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en1_default_state: tsp-en1-default-state {
+		pins = "gpio114";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default_state: tsp-int-rst-default-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	extcon = <&muic>, <&muic>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&muic>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.43.0


