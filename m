Return-Path: <linux-kernel+bounces-28615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EF98300BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89290283C37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFA1170A;
	Wed, 17 Jan 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="ocI2FDe3"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F84BE4C;
	Wed, 17 Jan 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477764; cv=none; b=nKc4uue/Q6+z5gUp7XH/fpfF1wMqxKA4+r5mbmBLZ5/0rCvS3QjG7wLyTHKUBpH0/2nsB4pZvMxILDNHBAvnfrWmcgQkHVkp4WQsnBRHKhth1Nq1qHKPkYDDBC7ACM17j1YPVZTim7+2qmKl7bANQgC59QnFMzjxXC1x+8rHQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477764; c=relaxed/simple;
	bh=PxrFLwWzmbu6edWXOm6DVsQOEXXm4tMsOq0hHLoCOFk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=rsys3LqBigpHXUPKNTvR4HiMYnVuZnnfwXKUDkCwR8bleEhhNEphrkA/KAvyZ6UZuPFTXD68TYs056eADHKW3wMfmUyA9MBV4MLTTY1oUgsJvA8VhLSy0G2EgvuoAsUsb56jgcxMKfdpaQRZVoxgpvvXAPJJPnZ5Wg/jvMdbHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=ocI2FDe3; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQ0fp-0000gw-Mr; Wed, 17 Jan 2024 02:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=36xknjqsMnWATQ7WxAV9OaWpPCPeju9HhmSYakGXE+U=; b=ocI2FDe3nVnaeTYll8sc
	nG5jR9XRv1n+wCYblQnnt9iHQPFJSeNqLDBzpDkV33mi2vkaTXzQeEPCKwzZIUz9whows0HaTEQFb
	gx3GBbaatvu3LJBAjaWlDh4RYQ5JB6Q71eK0pPikRK91xxtz8XCVpdGTE7FOKAqWovX+gI625rKnb
	pqjlu39FjV5q37WVgVCie/rGyWXawLYYzQn1NfhdMvEn00hb+Q9sgiH2o3h56D9LXHIRXKSV2035Z
	ckdW4EMSopTD6eG4sGBighp8L0IGFVPmHgKEqxFFQJQZKkQ0EOFw9Fy9x8o/DVwhCaTF2e0QhvhUB
	A7MaHWHrrZU/Xg==;
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
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 2/2] arm64: dts: imx93-phycore-segin: Add Phytec i.MX93 Segin
Date: Wed, 17 Jan 2024 08:49:11 +0100
Message-ID: <20240117074911.7425-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117074911.7425-1-othacehe@gnu.org>
References: <20240117074911.7425-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DTSI for Phytec i.MX93 System on Module and DTS for Phytec
i.MX93 on Segin evaluation board.

This version comes with:
 - 1GB LPDDR4 RAM
 - external SD
 - debug UART
 - 1x 100Mbit Ethernet

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx93-phycore-segin.dts     | 93 +++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 64 +++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2e027675d7bb..f078d6ef75f7 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 
diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
new file mode 100644
index 000000000000..748b779a9dc1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ */
+/dts-v1/;
+
+#include "imx93-phycore-som.dtsi"
+
+/{
+	model = "PHYTEC phyBOARD-Segin-i.MX93";
+	compatible = "phytec,imx93-phycore-segin", "phytec,imx93-phycore-som",
+		     "fsl,imx93";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
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
+/* SD-Card */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-sdio;
+	no-mmc;
+};
+
+/* Watchdog */
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	status = "okay";
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00			0x31e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x178e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
new file mode 100644
index 000000000000..4edff4a50b2b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ * Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ */
+/dts-v1/;
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
+
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+};
+
+/* eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+};
-- 
2.41.0


