Return-Path: <linux-kernel+bounces-151611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20118AB11B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CDD285A84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBC12FF88;
	Fri, 19 Apr 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="d3imeC/T"
Received: from smtpcmd0872.aruba.it (smtpcmd0872.aruba.it [62.149.156.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830212F391
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538392; cv=none; b=AAG9wBouYgH/StJUUVg/Xh4v/Gb2Q1UDmRImrBb2yswMIULXdXlQUErfrSCiJ7SkP0b+rsXyOoBKa8Q3CAiz/VncHoI1zLich9DzqOfFUUsPNs7b8MslVdXfkSbMnmTwHL8btzMx56ADmE4ldouZukPBka3xfcYCw4V2Uq50WJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538392; c=relaxed/simple;
	bh=9qMIGz9xymy53XjWQbEFGHYETD4tbojKWqztZWVKbBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGjARGPxjtY0MGjuC9ArR1ZseMTVHYBAaTyIiRrHzmBpECEM+6amtGo0cbMs+bvmzV2kUvwWZzi1lsRq7OdHav7uHkHtyXkaeL/uHeZVpOiVXL4xIJzhCU606DJCVj3oxqaa6u+sS6dWjsVwetyt504/G2vTzADlO/uNblBTwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=d3imeC/T; arc=none smtp.client-ip=62.149.156.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.23.200])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xpYprTscuBZCLxpYtrR4uc; Fri, 19 Apr 2024 16:49:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713538199; bh=9qMIGz9xymy53XjWQbEFGHYETD4tbojKWqztZWVKbBE=;
	h=From:To:Subject:Date:MIME-Version;
	b=d3imeC/TmERTlQlfN50TI1jSq5Ufz78ZVGVBozaferjb4OjDtTW76u7aLkNaijWcg
	 pVn7XllSJnZU4FvG/1Sfg6IusspXSCKRA7zN++eAv3KE/W+jrTgdi1ctZnfuE4LI7R
	 Dc/BjDVmneKa+7ZMiZuSNpRqoIERkACfv75liQqOzb8W3aVCLooflL+9b2dM2vWdqf
	 AocIdirXZrZ7cCGCrg/24DYAKXPVi/ZuN60IReoDd6G71vCURTwKj7D6SPBMwN7EYs
	 kOU0pCfyOA8AkgTTa7vJNMtTx4kJISrCYUVKVP5zGgc0BO1QoId0jk+MWmVKyvBwvi
	 sn/E8/+NaDLjA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v3 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Fri, 19 Apr 2024 16:49:53 +0200
Message-Id: <20240419144953.8700-4-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419144953.8700-1-fabio.aiuto@engicam.com>
References: <20240419144953.8700-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBa26f888bMB6OaFgSRx403/nMk9rZTPdIW5C5isNhcUIRQq6sz/3ZUKLctauuf7ZTh3/JsWfjHcpwucEaTbKeJc+nlmFmukd3HuUNCM9+tK6FP8ACh/
 92f6ZR/chJ9V1mfqLz1FOTZEQWa4jOKjE47sVx3SYgJripl++yErxl3Ny3tq/Ji7nscQZmBRjwzHkxfywOfW8FgWmHpzGyZo3GBpxhCrffeDYhgV3tcb5ke2
 NdfYLdlG3R9gDoTvGWAoESdYg1+AXvu7vJfVpUqaSAVMvHesuHYU5GY1cLn7b72fTW+pWlEL9pV3vpYj4qh5MHKbS/o15qfXLQN36iIinUZ+BCC6yabwUHC/
 M8nR5jLuWwIfUzplDiW7+Fo4BmPxNuae29N6vQrvXk8MfiehKymbxa8cn3IixhtQufKSGNXZj2nsXofNPC47tjB68p+QgD3AFuETiLDZCrIjhSyHfCN+tM1u
 Xy+S3lTwe3fMXONyOgnP1/xMFlmwsxpqmtQ9Pg07XOdkUXOTwhEqdC+B9ZAaV9RSAHBsMcGEcfvooskwhY+9yNvFnvoCWzoKVyc8tVAPC+h/OGWXKzeTAnja
 TIjKpFB/8d56p68tZspMicKZ

i.Core MX93 is a NXP i.MX93 based SoM by Enigcam which
needs to be mounted on top of Engicam baseboards.

Add support for EDIMM 2.0 Starter Kit hosting
i.Core MX93.

Starter Kit main features:

2x LVDS interfaces
HDMI output
Audio out
Mic in
Micro SD card slot
USB 3.0 A port
3x USB 2.0 A port
Gb Ethernet
2x CAN bus, 3x UART interfaces
SIM card slot
M.2 KEY_B slot

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 347 ++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 045250d0a040..d26c0a458a44 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -226,6 +226,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-icore-mx93-edimm2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
new file mode 100644
index 000000000000..470e1098d3eb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 NXP
+ * Copyright 2024 Engicam s.r.l.
+ */
+
+/dts-v1/;
+
+#include "imx93-icore-mx93.dtsi"
+
+/ {
+	model = "Engicam i.Core MX93 - EDIMM 2 Starterkit";
+	compatible = "engicam,icore-mx93-edimm2", "engicam,icore-mx93",
+		     "fsl,imx93";
+
+	aliases {
+		rtc1 = &bbnsm_rtc;
+	};
+
+	bt_reg_on: regulator-btregon {
+		compatible = "regulator-gpio";
+		regulator-name = "BT_REG_ON";
+		regulator-min-microvolt = <100000>;
+		regulator-max-microvolt = <3300000>;
+		states = <3300000 0x1>, <100000 0x0>;
+		gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_1v8_sgtl: regulator-1v8-sgtl {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8_sgtl";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3v3_avdd_sgtl: regulator-3v3-avdd-sgtl {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_avdd_sgtl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_3v3_sgtl: regulator-3v3-sgtl {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_sgtl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+
+		rsc_table: rsc-table@2021f000 {
+			reg = <0 0x2021f000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4000000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx93-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		/*simple-audio-card,mclk-fs = <1>;*/
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			clocks = <&clk IMX93_CLK_SAI3_IPG>;
+		};
+	};
+
+	usdhc3_pwrseq: usdhc3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+	};
+
+	wl_reg_on: regulator-wlregon {
+		compatible = "regulator-gpio";
+		regulator-name = "WL_REG_ON";
+		regulator-min-microvolt = <100000>;
+		regulator-max-microvolt = <3300000>;
+		states = <3300000 0x1>, <100000 0x0>;
+		gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&bt_reg_on>;
+	};
+};
+
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	fsl,stop-mode = <&aonmix_ns_gpr 0x10 4>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	fsl,stop-mode = <&aonmix_ns_gpr 0x10 4>;
+	status = "okay";
+};
+
+&lpi2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-1 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	pcf8523: rtc@68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		status = "okay";
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		VDDA-supply = <&reg_3v3_avdd_sgtl>;
+		VDDIO-supply = <&reg_3v3_sgtl>;
+		VDDD-supply = <&reg_1v8_sgtl>;
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&lpuart5 { /* RS485 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&lpuart8 { /* RS232 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart8>;
+	status = "okay";
+};
+
+&micfil {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX93_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&sai1 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clk IMX93_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	#sound-dai-cells = <0>;
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX93_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&usdhc3 { /* WiFi */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
+	pinctrl-1 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
+	pinctrl-2 = <&pinctrl_usdhc3>, <&pinctrl_laird>;
+	vmmc-supply = <&wl_reg_on>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	max-frequency = <25000000>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__CAN1_TX		0x139e
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+
+	pinctrl_laird: lairdgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__GPIO2_IO22		0x31e // WL_REG_ON
+			MX93_PAD_GPIO_IO19__GPIO2_IO19		0x31e // BT_REG_ON
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK		0x31e
+			MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC	0x31e
+			MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00	0x31e
+			MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00	0x31e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO26__SAI3_TX_SYNC	0x31e
+			MX93_PAD_GPIO_IO16__SAI3_TX_BCLK	0x31e
+			MX93_PAD_GPIO_IO17__SAI3_MCLK		0x31e
+			MX93_PAD_GPIO_IO21__SAI3_TX_DATA00	0x31e
+			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00	0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO01__LPUART5_RX		0x31e
+			MX93_PAD_GPIO_IO00__LPUART5_TX		0x31e
+			MX93_PAD_GPIO_IO02__LPUART5_CTS_B	0x31e
+			MX93_PAD_GPIO_IO03__LPUART5_RTS_B	0x31e
+		>;
+	};
+
+	pinctrl_uart8: uart8grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO13__LPUART8_RX		0x31e
+			MX93_PAD_GPIO_IO12__LPUART8_TX		0x31e
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK		0x17fe
+			MX93_PAD_SD3_CMD__USDHC3_CMD		0x13fe
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1        0x13fe
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2        0x13fe
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3        0x13fe
+		>;
+	};
+};
-- 
2.34.1


