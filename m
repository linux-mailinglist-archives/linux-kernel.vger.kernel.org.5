Return-Path: <linux-kernel+bounces-32677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C8835EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911E61F217E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DD33A287;
	Mon, 22 Jan 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="oqpnkX0U"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7439FF9;
	Mon, 22 Jan 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917220; cv=none; b=OVQtGkbPWTepzR0T5kN5bX5a9Ip51qkMrEGlmz/hjAoH8MzUSZqkbumCPRHs49YcAk0Dh177fRGtdE8jkkPQCMwq1yNx4VCNuvRfw4/QVuw38EbdzaipWaNi4d9B9Va5ZG36HI2im8AcveB2YxzHYj87fizpG/sTcYc8KGEYNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917220; c=relaxed/simple;
	bh=/4UYVWoRDV+kEO3U8Y1l39uRpYsiH1KNcPCNJ5mLcgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS54VqD6qsXNtmMasHWCLXXkyilTUHJNecPAhXAdf4/sm12RUjwgkPyKdlx0pO9YzSobTVZAX5iWCb7qlu0NvLQuPwVpjzQqBtuyzEn6aUOg59fVMmqLCYUbYW9KSdeHTCyel/vrpX0a3w5zErRPgOYLFyo9/Fy9rFvCrVaXuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=oqpnkX0U; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rRqzp-00048s-Id; Mon, 22 Jan 2024 04:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=nrund9baS9Vmb7CoYoNskY55PsEFb9lHldK7YlvotBA=; b=oqpnkX0UfNsYYvWB5tXK
	+SQyipP69BPvstoBgNagTLpltYVqgO1LZiYQCRFkl5bazV8A77eiFm+gTOLvdujq2Latp1K6hOj05
	7k3lp2rszUIHqTGUOD7EmZfU52L/Kyqz8RUAgbGk5SIKf4OgipRpjaLvhPJd1uumUcXpP4TLUJ0Fp
	72Ukh1b0XU4dNmKTtH2wDTgPU9YoAu6dhIRb109CJwZh0/lA1XwzqQaTCYI2q7+8UnuyioDc9kGFN
	8p4btZkeHc59gvOkFW1RwJzjdNkIZqGVZwlzgUYGQoofdwcZ6NNaqVp0OJHdTcmws6cMPeI0d1UOA
	sFuhGWpCpe9Ayg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support
Date: Mon, 22 Jan 2024 10:53:06 +0100
Message-ID: <20240122095306.14084-4-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122095306.14084-1-othacehe@gnu.org>
References: <20240122095306.14084-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for phyBOARD-Segin-i.MX93.
Main features are:
* eMMC
* Ethernet
* SD-Card
* UART

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-phyboard-segin.dts    | 141 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 ++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2e027675d7bb..65db918c821c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
new file mode 100644
index 000000000000..5433c33d1322
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ * Product homepage:
+ * phyBOARD-Segin carrier board is reused for the i.MX93 design.
+ * https://www.phytec.de/produkte/single-board-computer/phyboard-segin-imx6ul/
+ */
+
+#include "imx93-phycore-som.dtsi"
+
+/{
+	model = "PHYTEC phyBOARD-Segin-i.MX93";
+	compatible = "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-som",
+		     "fsl,imx93";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SD";
+	};
+};
+
+/* GPIOs */
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1>;
+	gpio-line-names = "X_GPIO1_3";
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	gpio-line-names = "", "", "", "", "", "", "", "X_GPIO5_9";
+};
+
+/* Console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc1 {
+	no-1-8-v;
+};
+
+/* SD-Card */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
+	bus-width = <4>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__GPIO1_IO00		0x10
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX93_PAD_ENET1_TXC__GPIO4_IO07		0x10
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_cd: usdhc2cdgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_default: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x179e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK            0x179e
+			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK            0x178e
+			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
new file mode 100644
index 000000000000..439ea4176f8c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ * Product homepage:
+ * https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/
+ */
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+
+#include "imx93.dtsi"
+
+/{
+	model = "PHYTEC phyCORE-i.MX93";
+	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+/* Ethernet */
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
+			  <&clk IMX93_CLK_ENET_REF>,
+			  <&clk IMX93_CLK_ENET_REF_PHY>;
+	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+	assigned-clock-rates = <100000000>, <50000000>, <50000000>;
+	status = "okay";
+
+	mdio: mdio {
+		clock-frequency = <5000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
+
+/* eMMC */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+/* Watchdog */
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__ENET1_MDC			0x50e
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x502
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
+			MX93_PAD_ENET2_RXC__ENET1_RX_ER			0x5fe
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x50e
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x50e
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x50e
+			MX93_PAD_ENET2_TD2__ENET1_TX_CLK		0x4000050e
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x179e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x1386
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
+		>;
+	};
+};
-- 
2.41.0


