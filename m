Return-Path: <linux-kernel+bounces-36594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6483A38B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165D028810A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BDE1759F;
	Wed, 24 Jan 2024 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="XQsQbEu7"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32417564;
	Wed, 24 Jan 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082702; cv=none; b=pnwmMViRRMfrEk9jm9HMkzq6BZLrG/ZipZTwfx+LfwYzZ/M0kWMUWXnc/zrKH+LMHVa+sulVrXxFlkk4y9EX6oApBjKxSbjs9CSiMaUBrtvkjc+bKBGq+Ia2UYFrxfyPVmIW3WYxXudYCcafAalpU5jm0G9ABbT96I8npI0nY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082702; c=relaxed/simple;
	bh=Vzf7ArEoGjGxbr9Ykeq9PwJCVGuGoHDphv+4t6S7wt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2LNL1QtEkufVRaOIoJey8j5qdoS+fmxtaSzr95g2eiDobzb8R/ARKdBzCLeTWfriCmQgmS0h5unYnNvfmENPrj87fZ1/9dqkrjbQZQ2tGp2CLcqG7DKLRk5czBaKVJe96RE63bZYuLGbh1lrPWXCWdeDjpT7QTwCiFUbwEep5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=XQsQbEu7; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rSY2r-0004mR-QM; Wed, 24 Jan 2024 02:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=ENvHw+1J9PWgJ89O5TJzizOeXTQ7VV14tJ7WAxGGitM=; b=XQsQbEu7Qn97xpgyM15w
	Iv1BWHNaS6iQcA7P2c0Qn4bg+F8GL5mxqPtHvAxbLg5CeTZ4sfibzsSKu6lfX/JLfSgkgHv1YIlSr
	gtTpyTJA6kRLPVp/5kMTcvO8JSqa9UwVZVQXNppDsPq6D0CLt9qr+3/PgqbNiNjrrBfa7zp9QBPLK
	CKw+04GEm32djYLI/x0kcWpnXe/CWM2bk8pBkWD1LtELd1QnwmrI4S47Np04+J0tiG8Q+t/iRMtxx
	qCcSTsMadTqt6A/2iSBrIw2sK90lflCtZHX+4CQxEa0fGy4dcJ6+DRe9u3AewTtYure01SakyGI1n
	706bmnbsB7l3Pg==;
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
Subject: [PATCH v5 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support
Date: Wed, 24 Jan 2024 08:49:30 +0100
Message-ID: <20240124074930.26101-4-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074930.26101-1-othacehe@gnu.org>
References: <20240124074930.26101-1-othacehe@gnu.org>
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

Tested-by: Primoz Fiser <primoz.fiser@norik.com>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-phyboard-segin.dts    | 117 ++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 126 ++++++++++++++++++
 3 files changed, 244 insertions(+)
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
index 000000000000..85fb188b057f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ * Product homepage:
+ * phyBOARD-Segin carrier board is reused for the i.MX93 design.
+ * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
+ */
+/dts-v1/;
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
index 000000000000..88c2657b50e6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ * Product homepage:
+ * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
+ */
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


