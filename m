Return-Path: <linux-kernel+bounces-150185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260428A9B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D105128197E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAFC1635CA;
	Thu, 18 Apr 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="far4rUyg"
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CB160790
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447758; cv=none; b=loaFl50gvAb081Jqs7GI7HRFjwFfMv80iALgDCJbMMXW3YsLEC7GZQObk+4mtmDURT5qugVs13PBDwKmGep6ht7PrG1zOqU++UDFOic6XBPTYZJrL1Vn8MpvGuVzkB36J6I5euMBp2vnepLHtYiFrIQBoTCGArEFFNC1fO+9uTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447758; c=relaxed/simple;
	bh=mpFZYKCt93SqfoLhuHIZOZAQ++GU5Ok3udg5m7tT/8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUVzG9U8sUR6yq/KjLkQ2xRL+pzTAPMywFGfwLv4T88QvJtizPhcGGUEGILY38O8uZp1S2qkQh6EAjEuY5gDlocMgEUN21ZveGr9Qsxsqt3VZ47r/g9gNqQ+Z74SJNPUPNL1th4MSOTtaZYFxw9I5pPdb4VqbbPdDcYJgtLRAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=far4rUyg; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.28.123])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xRz2rgYv8wWj2xRz4rpftj; Thu, 18 Apr 2024 15:39:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713447567; bh=mpFZYKCt93SqfoLhuHIZOZAQ++GU5Ok3udg5m7tT/8M=;
	h=From:To:Subject:Date:MIME-Version;
	b=far4rUygRxzJP/Cp9lGz2OV2dSDHFmi/DwbPBahH49WgUET00QyL5VzranbavdHOk
	 wmRuVe1CPFWi3LmMP1SnGlaKPIoAcItzYWwgleRXziHbK/IBWiJh2gWt0X1HDGG/tN
	 NzxoATGs+esk8Jh8k9V4RW4AGheK3zH6giaolt9V0mJJZZUs4nBu9F9+WqFiSAw4qr
	 7D+2zyaKMF3yq7GYtRpk+iYoqOZ3VKp9Mq7zSdpjHoChyFo+B8EgSbyrLdLuXLHbp9
	 sHrgKYKPN1Sjo13hgPsAXglFKB/iGxjmCFouoadcQ+MXfAhpX1i//RcScQsSwR1nlG
	 OdB80tube9Q7Q==
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
Subject: [PATCH v2 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
Date: Thu, 18 Apr 2024 15:39:22 +0200
Message-Id: <20240418133923.3705-3-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418133923.3705-1-fabio.aiuto@engicam.com>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfH0Xu1I2PZhjsA3o4vjTvidBnaRm6j9UVTMgWSASu9RageXyPbhV0dn4aleZWyd/cR5jbpry8cyo2KnOMzSbOtzCHAZJQtNwuceAjFlVc9kwIKPfitUF
 u27oTAwnz2ggk+Ng1v7r8OVJ55XmzydewgJPZVzS1Pi4wSnKchYh8olYFydFI+R1iPpMh85e1GSDoXLfxAbBlEotcaZjGacXua+lGGIZD6nd7CtP4kNIJiIM
 O9fL03X8nycWSa5AL6x2G1drH93R9UFOuXAIVs0HmUdMzSbYK0mL6H+piO0PC7vW1f0HDxyHBdLjb/Ta41lBtVa3Vv3ccXKOxW2F2Ks6RT7OLrCrT0CF20eB
 xTYB0nUrEvad5O8i261CFxVCmS8QcVaVfhhfxiEfVpDNLX+VuobjZttm1hLlexzs7Y15aGjZ2Fm6Bs320P9c6Inah4I5e6hWyFyHNq3Mto3B+BDnmii6gPcT
 7nmBo64P0WeYnxPfElDb89KthTFtFjZEcVovLQBP2rjtqPNITsKgQTqakKK2hM//sRCdlHt88oRYOmKE+dSJ72RKATfWudkgcRKbYG7M0KtDS9WddGK0fm2s
 I0JBpj4qng7F89pieCvP9vKS

i.Core MX93 is a NXP i.MX93 based EDIMM SoM
by Engicam.

Main features:

CPU:   NXP i.MX 93
MEMORY: Up to 2GB LPDDR4
NETWORKING: 2x Gb Ethernet
USB: USB OTG 2.0, USB HOST 2.0
STORAGE: eMMC starting from 4GB
PERIPHERALS: UART, I2C, SPI, CAN, SDIO, GPIO

The i.Core MX93 needs to be mounted on top of
Engicam baseboards to work.

Add devicetree include file.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 270 ++++++++++++++++++
 1 file changed, 270 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
new file mode 100644
index 000000000000..c4bed6da389d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 NXP
+ * Copyright 2024 Engicam s.r.l.
+ */
+
+/dts-v1/;
+
+#include "imx93.dtsi"
+
+/ {
+	model = "Engicam i.Core MX93 SoM";
+	compatible = "engicam,icore-mx93", "fsl,imx93";
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <7>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy2>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy2: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <7>;
+		};
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
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
+&usdhc2 {/*SD Card*/
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	no-1-8-v;
+	max-frequency = <25000000>;
+	status = "okay";
+};
+
+&iomuxc {
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC                        0x53e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x53e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x53e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x53e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x53e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x53e
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK  0x53e
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x53e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x53e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1                  0x53e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x53e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x53e
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x53e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x53e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__ENET1_MDC                   0x57e
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO                 0x57e
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0             0x57e
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1             0x57e
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2             0x57e
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3             0x57e
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC             0x5fe
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL       0x57e
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0             0x57e
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1             0x57e
+			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2             0x57e
+			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3             0x57e
+			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC             0x5fe
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL       0x57e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
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
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x170e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x130e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x130e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x130e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x130e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x130e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+};
-- 
2.34.1


