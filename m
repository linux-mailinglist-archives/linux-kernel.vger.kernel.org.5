Return-Path: <linux-kernel+bounces-161997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F508B5456
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235A21F21BED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1993771E;
	Mon, 29 Apr 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="cTKYb6Db"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773C241E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383272; cv=none; b=EFPEZ/yu6LihBeO0Vuv6Vaf6I89L7eRtzaSM7xpRQlMg33DIv17q0B1w/yUem2JKPvTY/og0Z/ydcriULx/qR/T7T8w49K4PGgP5InfZW9K9qpfKpKb+mxLN9bIq4MMGjbxiMvKLM+8RsoFMyvzUd8vQYhaOK+VgIdUT7ax0Qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383272; c=relaxed/simple;
	bh=vmszalou0wUHxhm6qeZSejmKLtppZ3O+szMZyEgPAZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/a85we9RFVQ1vKaqxw6om3D2H9kmBhU5ggHEPbrZHB6sSLCQ1icRa/BM7a96X1kCHkqYrYsc7qgXWpjO9g/kYeyarovmKLV2PInQYRcv7V36NYSe740l9sjYgtxLp2WlwgU9nS3eXrC/UGWIkPMaDswLr9lwJsGAPRcAwLyvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=cTKYb6Db; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1NLxsVDmQ8U421NLzsOAiw; Mon, 29 Apr 2024 11:31:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714383079; bh=vmszalou0wUHxhm6qeZSejmKLtppZ3O+szMZyEgPAZU=;
	h=From:To:Subject:Date:MIME-Version;
	b=cTKYb6Db1dk37tONNi6EYLw3rFkUjBCtYcCo7tsT2NTAU5hAPqKyeNUXoqs0rFk2A
	 jY8u1n/48bi6RaO7warLsph5CuHWZGWonzcqJbuZhzXWeST6Mbwj4HR92sORHMopcO
	 a7vLTK8VRPen32CbmeMtXERlzuB9+5cvbZ7I7YkEqEZ6YY2tWwNFL5Nn12LKkMA62n
	 3b0E4nyurZM3dW2xB5xI7xz9E7019VbF/jqxQYRRZBwlphxuKFE4kgfGZK/978LBvS
	 uHaNDS5vnVoLbdIZPcx6h79Zcrp0ryJUpI6y7GBkejTJd3t1qkJu+z0gtHyO54hrIF
	 xZGoyAwIuRMhg==
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
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v8 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Mon, 29 Apr 2024 11:31:16 +0200
Message-Id: <20240429093116.9346-4-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429093116.9346-1-fabio.aiuto@engicam.com>
References: <20240429093116.9346-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHibUBq6QL/vLnREt8AOC318HZbqxhIGukr5XMbZh3ZHrsXMKwRGzAAyj9rh00mb0zQdMEUD5BG5Il89FObojCBQRgmXrKYiIEGiet716fRt6PfX9gWL
 xcShxd9mECBt0jowx5ZL+Mmn/qPZNXfqd16q6/Jgmyw7W5RJUYdTcn6eA5MNG+mGinBs634R5NXawrZuF9uknF3dKyBpiIhnJTzgLYcKFrwSlhqzTOD6y9kX
 wCAeewNpLxiKUd5gwAX2TkM30yA3BxvIUWS5DPYS+L5QiNj8MdaSzlPD90ZnQWkuQME4YMd4xaHh7NiLpNGOuTlVuxPIFGhIMJ68MXHXjayLIha2xUol9MGZ
 79Tx7gAghFkCOTi63iUheQSLUJiTB5vnzj2h4N3GKWjcW4ZpfZcctCxTgwye9p8eJcJFXv5JGGpNLThq/lIo3o9QhF1JtP4wg5ExoYbZWAYgCCJbpqaLJRpb
 wT2mQ9in+lpWaKoOnxqGi4j1yySysJXUvbIss75H2QVrHZMMXD79R/iRK7IYpy1iEDbhkKj9/Q9gjEN9rTyAZYFmKWyloamT6mgNccMr7CJ4emUlxhkJYYYQ
 VDHcjburKm7zy8hi/js28wBjJEHMcVhlHgYvDRbdub2ozspz/5s5fluojgOqLxoQ2uCNkMNvg31Y/bPPhzjM3Mxb

i.Core MX93 is a NXP i.MX93 based SoM by Enigcam which needs to be
mounted on top of Engicam baseboards.

Add support for EDIMM 2.0 Starter Kit hosting i.Core MX93.

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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
v7 ---> v8:
	- no changes
v6 ---> v7:
        - removed max-frequency property in wifi node
        - removed pinctrl-{1,2} in usdhc3 node
v5 ---> v6:
        - added property in lpuart5 node
        - removed unused sai1 node
        - move Cc tag to Reviewed-by tag
v4 ---> v5:
        - done some property reorder, indentation fixes, node rename,
          drop/add new lines
        - added Reviewed-by tag
v3 ---> v4:
        - drop wl_reg_on regulator in favor of mmc-pwrseq-simple
        - add Cc tag
v2 ---> v3:
        - fixed dtschema warnings
        - removed regulator-always-on on bt_reg_on
        - fixed clock rate assignment on sgtl5000 node
        - fixed indentation issue
v1 ---> v2:
        - fixed indentation issue
        - fixed missing space issue
        - improved naming of regulator nodes
        - removed unneeded include

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 321 ++++++++++++++++++
 2 files changed, 322 insertions(+)
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
index 000000000000..c22d71cdf7cb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
@@ -0,0 +1,321 @@
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
+	chosen {
+		stdout-path = &lpuart1;
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
+
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc3_pwrseq>;
+		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
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
+	sgtl5000: audio-codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		VDDA-supply = <&reg_3v3_avdd_sgtl>;
+		VDDIO-supply = <&reg_3v3_sgtl>;
+		VDDD-supply = <&reg_1v8_sgtl>;
+		status = "okay";
+	};
+
+	pcf8523: rtc@68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
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
+	uart-has-rtscts;
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
+&sai3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX93_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&usdhc3 { /* WiFi */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+	};
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_bluetooth: bluetoothgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO19__GPIO2_IO19		0x31e /* BT_REG_ON */
+		>;
+	};
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
+			MX93_PAD_GPIO_IO25__CAN2_TX		0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX		0x139e
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
+
+	pinctrl_usdhc3_pwrseq: usdhc3pwrseqgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__GPIO2_IO22		0x31e /* WL_REG_ON */
+		>;
+	};
+};
-- 
2.34.1


