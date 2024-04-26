Return-Path: <linux-kernel+bounces-159649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721E8B3192
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E01C28890C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596A13C80D;
	Fri, 26 Apr 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="nfTuFYQK"
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4513C3EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117296; cv=none; b=en6Hc+i8JytCBHqggmn+Adxv4hMJchsQARBzgCdQt3kfidulmtpV8OqwLscU52mc7nwf2CjZwl04MOjufiT5ktOrmfIKqSoX7K693GBhaPublfkn+AM1bfxnDNxnkq6lfWUtEO4l3mMPjedlfjSP/whz8LpPWZy+XeBOi7zOBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117296; c=relaxed/simple;
	bh=oLpS1ywFi/E4JcK3AJqe04SGtz0Tg8XK4zh42cLNxpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sgi3SsDM+gq2drSHpEFvnzP9ROwODuTxBvejslNRxGUXOtJjtIgsAxO+b4Znj51IKUcFdyoE0IKbAxiPVIajR6PwB1P3xpueTLw9dXRnVJZdWT2G8a+iFqp5Ys4Qg85OOWojsdnlE0WmUk478LhqzTpAv/xHMt0qkEaqa0H0160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=nfTuFYQK; arc=none smtp.client-ip=62.149.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.21.121])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 0GA2s5OJj7AmW0GA4sQ98j; Fri, 26 Apr 2024 09:38:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714117104; bh=oLpS1ywFi/E4JcK3AJqe04SGtz0Tg8XK4zh42cLNxpE=;
	h=From:To:Subject:Date:MIME-Version;
	b=nfTuFYQKPegRGDQolO2+YJfIORJx+ADc1SoG3c8GdI7dMKa24tM0NIhUiU9o4O2bU
	 DvyDGtXwrih93AYW68Rpxcmc1+lVVv7BIX4X4ii5PvocTj/nSiOxyywBf4QQpwg5Ug
	 HiirvOA2+LQum18HCULy0hR1OeEGsj3it1h387TuIt8cwYKquPh/didR2KayiPqdKd
	 upxlyQpSnkqxECrhA1J3a2QsYjn5wKq/PmcLYFRscfTVB2mbqHNrpWZ6RMn1uUw9dW
	 qYEuXO4e7sABnjzeY1f15FYjqTsiITMQVZeCI/03xRp6eW0WrZDdLWJ5nIGZY07BPp
	 u4rLizqAd+mJA==
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
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
Date: Fri, 26 Apr 2024 09:38:19 +0200
Message-Id: <20240426073820.6466-3-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426073820.6466-1-fabio.aiuto@engicam.com>
References: <20240426073820.6466-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD1XcedmZ1mUcGuYT6SmwH4d5NUx70sNmxpClv0ZEsrpcXJwE5/V5XJ65U4m3Wo5CGVMP57dboTrxa4xIqCoFj+iHOPhd6jve9AP9Gn+bLeOnltCTa9e
 f2GLjaOKvS6cqUOiz7HPzthIjBFVQuWqVc+3lPiulc9QAM8LP7he3+3oDgYfZuZjDmIuEeeTv/vfkPpUVScLWY56BU8jOMY6w3wB7/9sWx8II9cjUV+2swjh
 KCp8LV1uXGFUp8ThXtNqGds0NhRTyj0jhznxFlz16DOskS9YmD9x2zD9T1EyDCTWGbr3HH1401OsoXPps8v+++C7MbHJP77bW61Cgrq+RC5B8mlCZd9IrMBZ
 uVWybR2fnsSdwTqMJhdXltqk8rv1HmLVtZi3NPvagnMHbRJ3Rp3BpwEjjtADXHFIucHEypwr9JGp68xIWqJDFCMHTe5IZYkaue7p1HVFz3dAwMCBh2wr9cw3
 P8nLIrLhlceayj4kDmWnXt1VdnDXnve0nMguNaoCGw+I/7NTUWOVAWzjITr6mE5ZHwGorw9xzsOAraY/8/fr33DlJoZetntGS/zbzSpCJ3X2TPG/lSKyIJCH
 FtRAjh/zy2/jX2ooAKQjdpM76+9w2MX3rzXFden2ZDAGxA==

i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.

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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 269 ++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
new file mode 100644
index 000000000000..9c97b620ccfc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
@@ -0,0 +1,269 @@
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
+		interrupt-parent = <&gpio2>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+		nxp,wdog_b-warm-reset;
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
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL		0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
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
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x170e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x130e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x130e
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


