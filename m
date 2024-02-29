Return-Path: <linux-kernel+bounces-86284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D486C364
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F0E1C2155C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD124EB3F;
	Thu, 29 Feb 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="dnZstZpg"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDA38397
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195060; cv=none; b=o8lsw9qOraT1yEm/5ItuEQ8W4b5ye3n4R9pvW3bRcG9Dl3zUuCOHK3At604p53XwO9FKrWaMacFhFY/EtJ3j/KV23Cu0R6pE+5eMLon3CsQEdmlqitUuC0MKI7F8ZY4S2aKZ+0Utg5nUzcxtCBlkC8tiQ7PF2Avo7yKABFAFMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195060; c=relaxed/simple;
	bh=I8ofOj9TF7/bLTV+ZrZ+69jH3G85zjtT3fv2OXGLiSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G11HVUD4FU2y+pjqvuZ2H08nUIiqJoNVhe7vQ2Wm+i4ZE30t4LoekqgfQceEwTS00xiAgj6rSmhF0AUTnEBtsRrh85NGAhroBlodXP6SWJzmF2ix7J/LoEb6cOZD71fj76h/bKJdGQdjoNmLP7FsiFZkq6AL/Khi+LOHsNzOKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=dnZstZpg; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id fPRlrbZSGQr4SfbiCrGruS; Thu, 29 Feb 2024 08:24:17 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id fbi9rZ1kOPOmXfbiBrXjtp; Thu, 29 Feb 2024 08:24:16 +0000
X-Authority-Analysis: v=2.4 cv=T+SKTeKQ c=1 sm=1 tr=0 ts=65e03f30
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=k7vzHIieQBIA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=qJizof83pKus7c3T2RoA:9
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OHIb6dVfpRIDTBNkTv1gGv+Uah0fHNJl1TjW+uo97Vk=; b=dnZstZpgtvWwcdhb2DgXBdEpmb
	XL3PRR2XNaofgUsqnrEmlt+S4zUkvQqTqtYKhG/D9Msgy8G3/WXZ9NYqCL12Gfe1RVAg48bjCa29i
	Zslz6ZTwLhg2OEriRPDL9e4XpHWPqhCI+TDCcFfeSSiaQPWW+ercDvNLnKe8uByc4nGO5ikwf4Ev5
	0VXPSfcCdmtWYWNgkox2I9i7Fy54L27jj58E5UOIjoNPd4tl34RUthVxR9wnZeo1RovzsencRVJnv
	DfH2VrjGFckka7QYnMv14MWYjRj/PBJR7DA21nvqZ5Me9uHwr7JoloU3cTMSlU65+BkXCAKKBUQ9h
	Ip8KfITA==;
Received: from [122.165.245.213] (port=55676 helo=kural..)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1rfbi6-0013bQ-0p;
	Thu, 29 Feb 2024 13:54:10 +0530
From: Parthiban Nallathambi <parthiban@linumiz.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH 2/2] ARM: dts: imx6ull: add seeed studio NPi dev board
Date: Thu, 29 Feb 2024 13:53:37 +0530
Message-Id: <20240229082337.3090778-2-parthiban@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229082337.3090778-1-parthiban@linumiz.com>
References: <20240229082337.3090778-1-parthiban@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rfbi6-0013bQ-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (kural..) [122.165.245.213]:55676
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 13
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDzQ4w9KJ0q6oC4FkEVU5L+YyKRBrT1ZLuUzjPevS3uLMHsGgtNn3D0Jiq8uuR2ZaxWP4DUUqTayYFrA7aVnCZtqoESgBI1zyA4PuiyUISUjEirfrPw5
 IzzlDEXpVyGQYIo3Bzz7hGODMBtQD4vEb8eGFF2OU/9DX3Gyo64T6gHpR8M/YKntRdtjB3DEzTwsGtTs+Me8VVg9OZu6oxm+x1k=

Add support for Seed Stuidos NPi i.MX6ULL SoM equipped with
512MB RAM and 8GB eMMC or 512MB NAND flash. Development
board comes with either eMMC or NAND based SoM with peripheral
interfaces like 2 x ethernet, 2 x USB, LCD, CSI and more.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../imx/imx6ull-seeed-npi-dev-board-emmc.dts  |  19 +
 .../imx/imx6ull-seeed-npi-dev-board-nand.dts  |  19 +
 .../nxp/imx/imx6ull-seeed-npi-dev-board.dtsi  | 424 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi   | 155 +++++++
 5 files changed, 619 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index a724d1a7a9a0..31cb895105f5 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -343,6 +343,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-phytec-segin-lc-rdk-nand.dtb \
 	imx6ull-phytec-tauri-emmc.dtb \
 	imx6ull-phytec-tauri-nand.dtb \
+	imx6ull-seeed-npi-dev-board-emmc.dtb \
+	imx6ull-seeed-npi-dev-board-nand.dtb \
 	imx6ull-tarragon-master.dtb \
 	imx6ull-tarragon-micro.dtb \
 	imx6ull-tarragon-slave.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dts
new file mode 100644
index 000000000000..cfcd8783c31d
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Linumiz
+ * Author: Parthiban <parthiban@linumiz.com>
+ */
+
+/dts-v1/;
+#include "imx6ull.dtsi"
+#include "imx6ull-seeed-npi.dtsi"
+#include "imx6ull-seeed-npi-dev-board.dtsi"
+
+/ {
+	model = "Seeed NPi iMX6ULL Dev Board with NAND";
+	compatible = "seeed,imx6ull-seeed-npi-emmc", "seeed,imx6ull-seeed-npi", "fsl,imx6ull";
+};
+
+&usdhc2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dts
new file mode 100644
index 000000000000..87c9434b09c5
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Linumiz
+ * Author: Parthiban <parthiban@linumiz.com>
+ */
+
+/dts-v1/;
+#include "imx6ull.dtsi"
+#include "imx6ull-seeed-npi.dtsi"
+#include "imx6ull-seeed-npi-dev-board.dtsi"
+
+/ {
+	model = "Seeed NPi iMX6ULL Dev Board with NAND";
+	compatible = "seeed,imx6ull-seeed-npi-nand", "seeed,imx6ull-seeed-npi", "fsl,imx6ull";
+};
+
+&gpmi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
new file mode 100644
index 000000000000..6bb12e0bbc7e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Linumiz
+ * Author: Parthiban <parthiban@linumiz.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio_buttons: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_button>;
+
+		button-0 {
+			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+			label = "SW2";
+			linux,code = <KEY_A>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-blue {
+			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+			label = "LED_B";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+
+		led-green {
+			gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
+			label = "LED_G";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+
+		led-red {
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			label = "LED_R";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+
+		led-user {
+			gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
+			label = "User";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+
+	reg_5v_sys: regulator-5v-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_SYS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&reg_5v_sys>;
+	};
+
+	reg_3v3_in: regulator-3v3-in {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3_IN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_5v_sys>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_3v3_in>;
+	};
+
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3_SD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vmmc>;
+		enable-active-high;
+		regulator-always-on;
+		vin-supply = <&reg_3v3>;
+	};
+};
+
+&csi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_csi1>;
+	status = "disabled"; /* LED Blue & Green shared */
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@2 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <2>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&lcdif {
+	pinctrl-0 = <&pinctrl_lcdif>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+&reg_dcdc_3v3 {
+	vin-supply = <&reg_3v3_in>;
+};
+
+&sai2 {
+	assigned-clock-rates = <320000000>;
+	assigned-clocks = <&clks IMX6UL_CLK_PLL3_PFD2>;
+	pinctrl-0 = <&pinctrl_sai2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	dr_mode = "otg";
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_usdhc1_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_usdhc1_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_usdhc1_cd>;
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_button: buttongrp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x0b0b0
+		>;
+	};
+
+	pinctrl_csi1: csi1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__CSI_PIXCLK	0x1b088
+			MX6UL_PAD_CSI_VSYNC__CSI_VSYNC		0x1b088
+			MX6UL_PAD_CSI_HSYNC__CSI_HSYNC		0x1b088
+			MX6UL_PAD_CSI_DATA00__CSI_DATA02	0x1b088
+			MX6UL_PAD_CSI_DATA01__CSI_DATA03	0x1b088
+			MX6UL_PAD_CSI_DATA02__CSI_DATA04	0x1b088
+			MX6UL_PAD_CSI_DATA03__CSI_DATA05	0x1b088
+			MX6UL_PAD_CSI_DATA04__CSI_DATA06	0x1b088
+			MX6UL_PAD_CSI_DATA05__CSI_DATA07	0x1b088
+			MX6UL_PAD_CSI_DATA06__CSI_DATA08	0x1b088
+			MX6UL_PAD_CSI_DATA07__CSI_DATA09	0x1b088
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN      0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER      0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00 0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01 0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN      0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00 0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01 0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1  0x4001b031
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC         0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO        0x1b0b0
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN      0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER      0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00 0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01 0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN      0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00 0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01 0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2  0x4001b031
+		>;
+	};
+
+	pinctrl_gpio_leds: ledgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x0b0b0
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x0b0b0
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x0b0b0
+		>;
+	};
+
+	pinctrl_lcdif: lcdif-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x79
+			MX6UL_PAD_LCD_RESET__LCDIF_RESET	0x79
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01	0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08	0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16	0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x79
+		>;
+	};
+
+	pinctrl_reg_vmmc: usdhc1regvmmc {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x17059
+		>;
+	};
+
+	pinctrl_sai2: sai2-grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x130b0
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x120b0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pin = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pin = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pin = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pin = <
+			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pin = <
+			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usbotg1idgrp {
+		fsl,pin = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc1_cd: usdhc1cd {
+		fsl,pins = <
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
new file mode 100644
index 000000000000..f5ad6b5c1ad0
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Linumiz
+ * Author: Parthiban <parthiban@linumiz.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Seeed NPi-iMX6ULL Dev Board";
+	compatible = "seeed,imx6ull-seeed-npi", "fsl,imx6ull";
+
+	reg_dcdc_3v3: regulator-dcdc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "DCDC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_dram_1v35: regulator-dram-1v35 {
+		compatible = "regulator-fixed";
+		regulator-name = "DRAM_1V35";
+		regulator-min-microvolt = <1350000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+		vin-supply = <&reg_dcdc_3v3>;
+	};
+
+	reg_vdd_arm_soc_in: regulator-vdd-arm-soc-in {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_ARM_SOC_IN";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		vin-supply = <&reg_dcdc_3v3>;
+	};
+
+	reg_dcdc_1v8: regulator-dcdc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "DCDC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&reg_dcdc_3v3>;
+	};
+
+	reg_sd1_vqmmc: regulator-sd1-vqmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "NVCC_SD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vqmmc>;
+		regulator-always-on;
+		vin-supply = <&reg_dcdc_1v8>;
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "disabled";
+};
+
+&usdhc1 {
+	vqmmc-supply = <&reg_sd1_vqmmc>;
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	keep-power-in-suspend;
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DQS__RAWNAND_DQS		0x0b0b1
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0x0b0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0x0b0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0x0b0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x0b000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0x0b0b1
+			MX6UL_PAD_NAND_CE1_B__RAWNAND_CE1_B	0x0b0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0x0b0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0x0b0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x0b0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x0b0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0x0b0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0x0b0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0x0b0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0x0b0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06   0x0b0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x0b0b1
+		>;
+	};
+
+	pinctrl_reg_vqmmc: usdhc1regvqmmc {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
+		>;
+	};
+};
-- 
2.34.1


