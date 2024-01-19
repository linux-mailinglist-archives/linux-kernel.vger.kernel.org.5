Return-Path: <linux-kernel+bounces-30954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1318326B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596A328498C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B113C481;
	Fri, 19 Jan 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="FSZSFAbr"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E893BB5E;
	Fri, 19 Jan 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656534; cv=none; b=gZ8Hkbv0hoELTXweXrZKFQvDExQRe6rDxVBQ50DmUMlNMoZz5SvYZn/Qnp+fWIuTjY5hMCqSh5NflQkAtwCtITbWA9hpbSWqG+5CpxQrc1BUjPT46d9TxVFxTVHPDp63b9pBbGuwPhkGTl2OtY3VsMxZJw+k104f4Uk81v9ctzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656534; c=relaxed/simple;
	bh=YkaP077GmD4GIUs460f811gXXKlzJnSxQxa0nsPDn0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+V+ga4Hh0Ezu4WspYfzYiyDtlo8fHQUDIk+NLhFE1XE/mJfx47pI8I8nGGgRxUk1FUTo6JT17PXa9wGB4imEomMk9BbKt7j4aET8NZG3gdL4HYc40vCn/5E4AM4LkPnsGJm9NmGMmVG7iF5Rdg4VRpQ52V+eFsDdjsf3ZN6koc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=FSZSFAbr; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQlBA-0000vf-Li; Fri, 19 Jan 2024 04:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=Gg4gNL/R5oaXzD0eERS1n094ytrzu7MWYEmEsMNQ8nw=; b=FSZSFAbrISI47GQ3nMlJ
	LYDzSxRNK97Viwta2YcnSeCojWsLJWpg3FYru/wQIfPU/4ekSxMkqUDx5ct+LEZ5RaPaXC5L8S35w
	w0uh6lnXRB/aexCcEzRla5lDYQo19o5pygjQyIvchmDdIN9pwhCf5yK+vL9+i3PJW008AZO9NokRf
	0o6zHtdUQWvXdhvjs7aUBa7ESr8StG6Fc3dGxUVOj+U73c3z3sv/mqQ7BriuM3VkRK7f935ONudlK
	EH4u4yzuWSOED4rdrOnFevxyUtmHYdfK+iU0fH9jCD2VimisLRBtfbWWI3IJMkVV0eXToXVuBmVn/
	cD3bYS4tD+E6BA==;
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
	upstream@list.phytec.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v3 2/2] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support
Date: Fri, 19 Jan 2024 10:28:35 +0100
Message-ID: <20240119092835.21462-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119092835.21462-1-othacehe@gnu.org>
References: <20240119092835.21462-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for phyBOARD-Segin-i.MX93.
Main features are:
* SD-Card
* UART
* I2C
* eMMC

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-phyboard-segin.dts    | 119 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |  56 +++++++++
 3 files changed, 176 insertions(+)
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
index 000000000000..b256c5e42550
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -0,0 +1,119 @@
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
+		regulator-name = "VSD_3V3";
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
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+/* Watchdog */
+&wdog3 {
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
index 000000000000..0cc156b3c24e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
@@ -0,0 +1,56 @@
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
+&iomuxc {
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


