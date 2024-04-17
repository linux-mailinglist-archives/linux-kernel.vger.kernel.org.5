Return-Path: <linux-kernel+bounces-148826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC618A87D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F203D1F26555
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B06F148FEE;
	Wed, 17 Apr 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lH/Ib74T"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253B1482F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368147; cv=none; b=c/V3vjGOXRyXKmv9wDGKiAsUuPUmZQC5D4SmpZLbvrZA3ZFmXYqEVT69Fi+eg9UjUypLZLBjLXTdHFFbTv9ZZnGBnT4hI6TcoD2l2iCR42vqtTLEGhif9WVgoztzy0KTe7bHhACIL8M6l5YSYXUTJfoa3u6M6n0uR/iLfUiI1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368147; c=relaxed/simple;
	bh=3WdPb55kxtbLuvTnzw39RxHrxBf21qrRKLhUgwhA2oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFEadGPqfkL66KWcoWWFbKDWGHUwGzRP93wAWLzojpKYTnKV1vWUwJlDyoM5CBsAEEX/CupTeHLabJsx1kEetxbPILwHFzwRJeGiEZF4aKaQa5fPesPDT9pXBa/uURVUFDwU2iBExtxjalpx6Zlulgha87RCnCZAb6IcxsS+4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=lH/Ib74T; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.9.15])
	by Aruba Outgoing Smtp  with ESMTPSA
	id x7JrrIqgbiznzx7JvrXawt; Wed, 17 Apr 2024 17:35:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713368135; bh=3WdPb55kxtbLuvTnzw39RxHrxBf21qrRKLhUgwhA2oU=;
	h=From:To:Subject:Date:MIME-Version;
	b=lH/Ib74TLVixczaKgb4sgz7wzGY5rwfoMmD6ladwDyM7ufxiP3Ttpily63EdmwFX7
	 2KoLyv9+UHHPYIpCMsHSxK/fI5h6UyoyU4KdGlAZIBgEQu9es91LmXcgpI4XhpEqDS
	 N3P+wtJWUsavWoe1LOsXeZiOEew8NKalY+4PyM9sKzgm6LlI7Rnf237Vehmjmiv3M2
	 NimI3gXHpDK5L21mDIF7UulmFbyBTNNJVc1QHSkhKCTBXJRI0L+hv7Wtu0AUWYyG/g
	 TRhrFmDKu8R+c1PhJdiZJjZ0BVZXW69j+I4LRwQoyswNSbpBILjs6R+kVBy5EC2e0x
	 X9D/02YXii7nQ==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH 4/4] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
Date: Wed, 17 Apr 2024 17:35:28 +0200
Message-Id: <20240417153528.7838-5-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417153528.7838-1-fabio.aiuto@engicam.com>
References: <20240417153528.7838-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLSIkSHVmK5WbucNRItkLZTPk0XCz1Y/ut7Uz2onWVlfG1XT0EDbMNhuKCdHP05au5A/xz5cioc1GRkRixcLN6rnb6EewZM/ZbJ6raMaBFAQZbY71luj
 1XXtSzfNVJtc6JQ/q1cD6pV7wv16iYLvK/tpthq1YAiB5MqtkS5Se+76co0NjtPUVCHg5Sn0sYnvME65fXTwy4zT3x5+mQBFpIasfzpnakKJpvolzFx4D955
 q0BGCLd/TK5oZikyo9H+nF40OVQ1IYKYcOuK9BJzCmp0uZpBto5I7etQZwpHcYkDWE5uMRjJJTYRnAdM+oLkNJAFUQ6uAOYb5RgmStEjAsCyQILYcMHJbjbi
 P7taF2pjsaSt6pHLgQdlVtfQVX0YNPzXkL2LNWjSFZpERgsW6tNYWn0v1l/8pI8YO93aeZXlVYBoNryqaNPzOWO5cTh9XbODoEOxwEBdj87uOUWEmsV/YjHb
 gsIAjZvlffTFrcPvLpBWugbeVv/K5WxT/ARpB+MsFHcfgxUCfPz1YzJdYOD0li+D8OLVvYyua/E65Xsh+/lsAq+O/lttXTPaGXGkKE9CYD9QC+GEzm2vc449
 2KfsCSHEj34Fhllb0bow53o3DxFTX/Zu8ZYKVg45Jl8WQw==

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
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 356 ++++++++++++++++++
 2 files changed, 357 insertions(+)
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
index 000000000000..75cac97d919c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 NXP
+ * Copyright 2024 Engicam s.r.l.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx93-icore-mx93.dtsi"
+
+/ {
+	model = "Engicam i.Core MX93 - EDIMM 2 Starterkit";
+	compatible = "engicam,icore-mx93-edimm2", "engicam,icore-mx93",
+		     "fsl,imx93";
+
+	aliases {
+		rtc1= &bbnsm_rtc;
+	};
+
+	bt_reg_on: regulator-btregon {
+		compatible = "regulator-gpio";
+		regulator-name = "BT_REG_ON";
+		pinctrl-names = "default";
+		regulator-min-microvolt = <100000>;
+		regulator-max-microvolt = <3300000>;
+		states = <3300000 0x1>,
+				 <100000 0x0>;
+		gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_1v8_sgtl: reg_1v8_sgtl_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8_sgtl";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		always-on;
+	};
+
+	reg_3v3_avdd_sgtl: reg_3v3_avdd_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_avdd_sgtl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		always-on;
+	};
+
+	reg_3v3_sgtl: reg_3v3_sgtl_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_sgtl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		always-on;
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
+	usdhc3_pwrseq: usdhc3_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+	};
+
+	wl_reg_on: regulator-wlregon {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		regulator-name = "WL_REG_ON";
+		regulator-min-microvolt = <100000>;
+		regulator-max-microvolt = <3300000>;
+		states = <3300000 0x1>,
+				 <100000 0x0>;
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
+		clock-names = "mclk";
+		assigned-clock-rates = <12000000>, <12000000>;
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
+	pinctrl-names = "default";
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


