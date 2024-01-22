Return-Path: <linux-kernel+bounces-33026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B9683635D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132D31F21FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E739AC1;
	Mon, 22 Jan 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEWbcmnQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD003CF50;
	Mon, 22 Jan 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927051; cv=none; b=Oi3RBPvN5jXp+bkRVnGMKT8MRK1yubaEwnjmlXAEhku2c2/D7vg/mLoDTRlWAzI/naoIG9jr1evPVGdEb5QMGhHOUMx3mg2mzkj5VuFb5csLjVpilBlHUYmJcdsU/VmQQ90EcPe13xy7PNTnyE2RiCO1pGM/JZ1m1cLsZ+c1YVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927051; c=relaxed/simple;
	bh=2V+YBexIdHp/QwN1FpmdpxIaDEdAlqrAt2nwl+lbC2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFg2MDZSijIwPzXitNB8mdyYKHqdLopT6AuS1RCCHnEZyxRq+cvRpWfDEcQn+6Qr6hKJOtuWoBVknyXv8oN/AofwpozPpDTrffTG0k31LarRwASpCOQGFQ6If/AfwXtFVfYGjWqH0G6lP/5a0t3oLbJnjOdV4IyrZEudbmTFvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEWbcmnQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce0efd60ddso1537959a12.0;
        Mon, 22 Jan 2024 04:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705927049; x=1706531849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsRTlx9xbCoqaCvD8LXyePi0QNIMmxANnBnMlPU8zzE=;
        b=QEWbcmnQ3Kf8HPkmGqv7YhJ736ZQ31eYNKY4shwe8eq1G3hKkop8MIQLguBnJh0l74
         ZUkL54qDmO/V5HvuHIOgY6kfMMo316oMtmedqUh9u+3HXVqjCQ6gc1jVAeW/ZSA/vVLw
         mVR2R5B08Dr1wB0Z/1aF7/pGzzrAAI3lwbmMG9ZRWUHKcY7X5dPTH/jBj+sDuwNvxMWT
         G7dV0ZRvPjqaCWfgdbrZtfPMDtfHpU2qVD/EtZi3G0Dd7A2nHXDSK4UVZKyYN2ULTOBD
         yqHbdlUviLS/dM3dhREKoBOmE88FbB3rVKVkrI4BHVytCxOfr1bF/t5w3iul8Qjq939x
         jz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927049; x=1706531849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsRTlx9xbCoqaCvD8LXyePi0QNIMmxANnBnMlPU8zzE=;
        b=FMZ7soRSQxWvshZL3Jq2jozsiWqpiJNNF0WmdcJ7Nr5W13d7QQsygG32Y6GHs1+lTK
         7lupHBjfgH2NxfUPa9xhsmeok91wdhWoSyao39wovPeyliUNc9LEj+NS3e0STLd/z+C9
         EPGdF+6hqDIA29vz+ba1oNgQtxNM9t0pV41HU8lLb5TWswQ5k8F8T4x05N+FeydfY5tH
         cjQo1sUZTNE+AyGn2LoXSjRsjGD7Ex9kuHTowGxROiCBVvaw03UwQJPXv+5cLmps/CGy
         eaTXnWkhJkO8fEL98U+dUoy4N7DYDizlLkbtEnoLWKLQetngA5XDS7Te1Iu6bJLGHCxV
         7XKw==
X-Gm-Message-State: AOJu0YyecYMbBuc3qQJe/mYL0MMK9CqH7G7cgFhkVP0jRmlHbjrjSBzg
	SLabwJlpe19lJSAS2yzEHVpzzHoqt1UEifWz3g9/zzJLvR8A7+31
X-Google-Smtp-Source: AGHT+IFaf2gr60RGOvxF0Pyzhs/WGx+AfLZGSZeFMFLhjwi7AWW26087rmz+hNu4w1deABHBKovGlQ==
X-Received: by 2002:a05:6a20:1611:b0:19a:ef9e:989d with SMTP id l17-20020a056a20161100b0019aef9e989dmr1927897pzj.22.1705927048984;
        Mon, 22 Jan 2024 04:37:28 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm9452933pfj.108.2024.01.22.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:37:28 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v1 2/2] arm: dts: nxp: imx: Add support for Apalis Evaluation Board v1.2
Date: Mon, 22 Jan 2024 09:35:00 -0300
Message-ID: <20240122123526.43400-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122123526.43400-1-hiagofranco@gmail.com>
References: <20240122123526.43400-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Add support for the new Apalis Evaluation Board v1.2. Because
only the imx6q-apalis-eval.dts was available, the imx6q-apalis-eval.dtsi
has been created which has common hardware configurations for v1.0, v1.1
and v1.2. Both imx6q-apalis-eval.dts and imx6q-apalis-eval-v1.2.dts
files include imx6q-apalis-eval.dtsi.

Versions 1.0 and 1.1 are compatible with each other and should
use imx6q-apalis-eval.dts file. Now for v1.2, the new device-tree file
should be used.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 .../dts/nxp/imx/imx6q-apalis-eval-v1.2.dts    | 198 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dts    | 108 +---------
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dtsi   | 120 +++++++++++
 4 files changed, 321 insertions(+), 106 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index a724d1a7a9a0..0473f9b86ec7 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -147,6 +147,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-yapp4-phoenix.dtb \
 	imx6dl-yapp4-ursa.dtb \
 	imx6q-apalis-eval.dtb \
+	imx6q-apalis-eval-v1.2.dtb \
 	imx6q-apalis-ixora.dtb \
 	imx6q-apalis-ixora-v1.1.dtb \
 	imx6q-apalis-ixora-v1.2.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
new file mode 100644
index 000000000000..2fba7ed1061c
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6q-apalis-eval.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX6Q/D Module on Apalis Evaluation Board v1.2";
+	compatible = "toradex,apalis_imx6q-eval-v1.2", "toradex,apalis_imx6q",
+		     "fsl,imx6q";
+
+	reg_3v3_mmc: regulator-3v3-mmc {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_mmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_MMC";
+		startup-delay-us = <100>;
+	};
+
+	reg_3v3_sd: regulator-3v3-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_sd>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_SD";
+		startup-delay-us = <100>;
+	};
+
+	reg_can1: regulator-can1 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can1_power>;
+		regulator-name = "5V_SW_CAN1";
+		startup-delay-us = <1000>;
+	};
+
+	reg_can2: regulator-can2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can2_power>;
+		regulator-name = "5V_SW_CAN2";
+		startup-delay-us = <1000>;
+	};
+
+	sound-carrier {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,name = "apalis-nau8822";
+		simple-audio-card,routing =
+			"Headphones", "LHP",
+			"Headphones", "RHP",
+			"Speaker", "LSPK",
+			"Speaker", "RSPK",
+			"Line Out", "AUXOUT1",
+			"Line Out", "AUXOUT2",
+			"LAUX", "Line In",
+			"RAUX", "Line In",
+			"LMICP", "Mic In",
+			"RMICP", "Mic In";
+		simple-audio-card,widgets =
+			"Headphones", "Headphones",
+			"Line Out", "Line Out",
+			"Speaker", "Speaker",
+			"Microphone", "Mic In",
+			"Line", "Line In";
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&nau8822_1a>;
+			system-clock-frequency = <12288000>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi2>;
+		};
+	};
+};
+
+&can1 {
+	xceiver-supply = <&reg_can1>;
+	status = "okay";
+};
+
+&can2 {
+	xceiver-supply = <&reg_can2>;
+	status = "okay";
+};
+
+/* I2C1_SDA/SCL on MXM3 209/211 */
+&i2c1 {
+	/* Audio Codec */
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_nau8822>;
+		#sound-dai-cells = <0>;
+	};
+
+	/* Current measurement into module VCC */
+	hwmon@40 {
+		compatible = "ti,ina219";
+		reg = <0x40>;
+		shunt-resistor = <5000>;
+	};
+
+	/* Temperature Sensor */
+	temperature-sensor@4f {
+		compatible = "ti,tmp75c";
+		reg = <0x4f>;
+	};
+
+	/* EEPROM */
+	eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+		size = <256>;
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&ssi2 {
+	status = "okay";
+};
+
+/* MMC1 */
+&usdhc1 {
+	bus-width = <4>;
+	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_mmc_cd>;
+	vmmc-supply = <&reg_3v3_mmc>;
+	status = "okay";
+};
+
+/* SD1 */
+&usdhc2 {
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_sd_cd>;
+	vmmc-supply = <&reg_3v3_sd>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enable_3v3_mmc: enable3v3mmcgrp {
+		fsl,pins = <
+			/* MMC1_PWR_CTRL */
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0xb000
+		>;
+	};
+
+	pinctrl_enable_3v3_sd: enable3v3sdgrp {
+		fsl,pins = <
+			/* SD1_PWR_CTRL */
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0xb000
+		>;
+	};
+
+	pinctrl_enable_can1_power: enablecan1powergrp {
+		fsl,pins = <
+			/* CAN1_PWR_EN */
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0xb000
+		>;
+	};
+
+	pinctrl_enable_can2_power: enablecan2powergrp {
+		fsl,pins = <
+			/* CAN2_PWR_EN */
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0xb000
+		>;
+	};
+
+	pinctrl_nau8822: nau8822grp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT16__AUD5_TXC	0x130b0
+			MX6QDL_PAD_DISP0_DAT17__AUD5_TXD	0x130b0
+			MX6QDL_PAD_DISP0_DAT18__AUD5_TXFS	0x130b0
+			MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dts
index 3fc079dfd61e..e1077e2da5f4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dts
@@ -7,29 +7,13 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include "imx6q.dtsi"
-#include "imx6qdl-apalis.dtsi"
+#include "imx6q-apalis-eval.dtsi"
 
 / {
 	model = "Toradex Apalis iMX6Q/D Module on Apalis Evaluation Board";
 	compatible = "toradex,apalis_imx6q-eval", "toradex,apalis_imx6q",
 		     "fsl,imx6q";
 
-	aliases {
-		i2c0 = &i2c1;
-		i2c1 = &i2c3;
-		i2c2 = &i2c2;
-		rtc0 = &rtc_i2c;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	reg_pcie_switch: regulator-pcie-switch {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -40,14 +24,6 @@ reg_pcie_switch: regulator-pcie-switch {
 		startup-delay-us = <100000>;
 		status = "okay";
 	};
-
-	reg_3v3_sw: regulator-3v3-sw {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "3.3V_SW";
-	};
 };
 
 &can1 {
@@ -62,102 +38,22 @@ &can2 {
 
 /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
-	status = "okay";
-
+	/* PCIe Switch */
 	pcie-switch@58 {
 		compatible = "plx,pex8605";
 		reg = <0x58>;
 	};
-
-	/* M41T0M6 real time clock on carrier board */
-	rtc_i2c: rtc@68 {
-		compatible = "st,m41t0";
-		reg = <0x68>;
-	};
-};
-
-/*
- * I2C3_SDA/SCL (CAM) on MXM3 pin 201/203 (e.g. camera sensor on carrier
- * board)
- */
-&i2c3 {
-	status = "okay";
 };
 
 &pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_reset_moci>;
-	/* active-high meaning opposite of regular PERST# active-low polarity */
-	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-	reset-gpio-active-high;
 	vpcie-supply = <&reg_pcie_switch>;
 	status = "okay";
 };
 
-&pwm1 {
-	status = "okay";
-};
-
-&pwm2 {
-	status = "okay";
-};
-
-&pwm3 {
-	status = "okay";
-};
-
-&pwm4 {
-	status = "okay";
-};
-
-&reg_usb_host_vbus {
-	status = "okay";
-};
-
-&reg_usb_otg_vbus {
-	status = "okay";
-};
-
-&sata {
-	status = "okay";
-};
-
 &sound_spdif {
 	status = "okay";
 };
 
-&spdif {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart4 {
-	status = "okay";
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&usbh1 {
-	disable-over-current;
-	vbus-supply = <&reg_usb_host_vbus>;
-	status = "okay";
-};
-
-&usbotg {
-	disable-over-current;
-	vbus-supply = <&reg_usb_otg_vbus>;
-	status = "okay";
-};
-
 /* MMC1 */
 &usdhc1 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dtsi
new file mode 100644
index 000000000000..b6c45ad3f430
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dtsi
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2014-2024 Toradex
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6q.dtsi"
+#include "imx6qdl-apalis.dtsi"
+
+/ {
+	aliases {
+		i2c0 = &i2c1;
+		i2c1 = &i2c3;
+		i2c2 = &i2c2;
+		rtc0 = &rtc_i2c;
+		rtc1 = &snvs_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_3v3_sw: regulator-3v3-sw {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_SW";
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+/*
+ * I2C3_SDA/SCL (CAM) on MXM3 pin 201/203 (e.g. camera sensor on carrier
+ * board)
+ */
+&i2c3 {
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
+	/* active-high meaning opposite of regular PERST# active-low polarity */
+	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	reset-gpio-active-high;
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&reg_usb_host_vbus {
+	status = "okay";
+};
+
+&reg_usb_otg_vbus {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&spdif {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	vbus-supply = <&reg_usb_host_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	disable-over-current;
+	vbus-supply = <&reg_usb_otg_vbus>;
+	status = "okay";
+};
-- 
2.43.0


