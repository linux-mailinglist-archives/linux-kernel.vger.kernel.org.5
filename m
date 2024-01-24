Return-Path: <linux-kernel+bounces-37104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD1683AB96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14661F2B6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27EF7CF10;
	Wed, 24 Jan 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaHREU6R"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37547C0A3;
	Wed, 24 Jan 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106079; cv=none; b=akPCyWcXkEJqUzq9VRXBjpuoeycGd35O+LHi9cKrOGbmVP3tSNOzq+rpWp6svU/yhsVrwRenfbwJ5g+AbYFmH1RidXqAyjAM+jy+7BfwcspqZ6jH6yh0/GkaQCKMVCF6nymNJIAo9So1neEUrhhiCAquck1CvKcoH0bPgpjZscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106079; c=relaxed/simple;
	bh=otXJXhMAAt91fyQt9Bs8fzwM3Z7qa4XjqeOx9vOPwjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgjcisnVjQQdkfqi5Vyiv2qpRitnJIfI8weAnTKKBpbpn8Kx2ofUcSeiH7yxqkw1gIoCxP25lsgnZptobNbBwIh8lbFyIKvAnVNdhdhnnaE/4sc4OrxoUyAZhwQmtCshC4HiOJ1766j5UhXJ4jOORNnvl8TXfiuKz/mpYOOsfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaHREU6R; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6daf694b439so3957815b3a.1;
        Wed, 24 Jan 2024 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106077; x=1706710877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6utO0mRDw+h2xWav7x1F8anfATar00nWOKSWXyI+54s=;
        b=IaHREU6Rb01hHKp1PIdSmnPNzgv6RoqLe4pnWFTHL15QVPdEijfKk6iy7qqBgwr8RO
         MsB6Vavtr38T/orLCdVCNPmAH0DnEF+aQVjVVUNJjDw1U4IR7Nr6kQRQ6aVcMwXJn0y1
         t8ty5kwE6hzV0xzPW4u5a/s+tHAA+pQ7x9pVwUUJNFV7rul0QA56uvWRtfEbz8eBt9MP
         K1xklDFvX+lJ2nWGN4ScCPGu3MqpeUf4WIhcdIvbc0nIdmJinGbIPCvfCxYzCPwz+Qxc
         KkJxL19o4XJ2kt9yIfLdqYMkqSQjXzpBTGCJ/2rAV00yOgs6/EkUmbOuGmjUPbWCysd0
         fYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106077; x=1706710877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6utO0mRDw+h2xWav7x1F8anfATar00nWOKSWXyI+54s=;
        b=OMJkLHtbLw+8610t5ZPrgBXQkpdtsoLIprpPRod4vXQSQ3+af6WGN5470ZM7G6wYRZ
         RnjKlxtjb0WkkTwCL9hFXTjTGTmxVvjfLtL2KpFGNUYd+Lpbi4zzRRoDWjBeqxw+Kcm8
         X/7JTNJX8khZ88bRHk3bNEniZpyQHNYa3jLO3t6bjz8obrockAbcIo0q6eLWezbJMVsO
         2gOal9twyzOv9Iwbkc+2/bbbQH9jz95Nmx62dxcsYWpq7br5H4u7Eb6gQnNZO65oYqMo
         xYAde81AK0eepPsi4Yt+rG9RpCh+MtAiuBLOzKUZuwrF18K6OnoM5CN4YKOl97WV91u1
         UvTg==
X-Gm-Message-State: AOJu0Yyjp/b4BzegzKvwXi4YHuLKv7fN+eq+E2g/W5KXQokz5QzPopeG
	ph9O46eDKfjkX6rglLa4ZSNn4Gj+bKWFj5HIjnyK2fQY/k7JsKXj
X-Google-Smtp-Source: AGHT+IGKDUgZKPbNT0v7HqgvYMdzmiKPjJJoYDMFIBaHZPe9DBv4XWKDNRBKQaJEwFeCg7f0Sq8vvg==
X-Received: by 2002:a05:6a00:3926:b0:6db:cd50:a552 with SMTP id fh38-20020a056a00392600b006dbcd50a552mr5591372pfb.12.1706106077013;
        Wed, 24 Jan 2024 06:21:17 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00234200b006ddb77d443asm634848pfj.209.2024.01.24.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:21:16 -0800 (PST)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 2/2] arm: dts: nxp: imx: Add support for Apalis Evaluation Board v1.2
Date: Wed, 24 Jan 2024 11:13:20 -0300
Message-ID: <20240124141849.26254-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124141849.26254-1-hiagofranco@gmail.com>
References: <20240124141849.26254-1-hiagofranco@gmail.com>
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

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v2:
  - Add missing off-on-delay-us property with 100ms to reg_3v3_mmc and
  reg_3v3_sd.
  - Fix startup-delay-us property from 100us (reg_3v3_mmc and reg_3v3_sd)
  and 1ms (reg_can1 and reg_can2) to 10ms.
  - Fix pinctrl mux from 0xb000 to 0x1b0b0.
  - Add Reviewed-by: Francesco Dolcini.
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 .../dts/nxp/imx/imx6q-apalis-eval-v1.2.dts    | 200 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dts    | 108 +---------
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dtsi   | 120 +++++++++++
 4 files changed, 323 insertions(+), 106 deletions(-)
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
index 000000000000..15d4a98ee976
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
@@ -0,0 +1,200 @@
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
+		off-on-delay-us = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_mmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_MMC";
+		startup-delay-us = <10000>;
+	};
+
+	reg_3v3_sd: regulator-3v3-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_sd>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_SD";
+		startup-delay-us = <10000>;
+	};
+
+	reg_can1: regulator-can1 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can1_power>;
+		regulator-name = "5V_SW_CAN1";
+		startup-delay-us = <10000>;
+	};
+
+	reg_can2: regulator-can2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can2_power>;
+		regulator-name = "5V_SW_CAN2";
+		startup-delay-us = <10000>;
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
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x1b0b0
+		>;
+	};
+
+	pinctrl_enable_3v3_sd: enable3v3sdgrp {
+		fsl,pins = <
+			/* SD1_PWR_CTRL */
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x1b0b0
+		>;
+	};
+
+	pinctrl_enable_can1_power: enablecan1powergrp {
+		fsl,pins = <
+			/* CAN1_PWR_EN */
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x1b0b0
+		>;
+	};
+
+	pinctrl_enable_can2_power: enablecan2powergrp {
+		fsl,pins = <
+			/* CAN2_PWR_EN */
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x1b0b0
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


