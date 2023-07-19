Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46D759A81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGSQMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGSQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:12:30 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96210B;
        Wed, 19 Jul 2023 09:12:28 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1qM9mr-007FfI-3o; Wed, 19 Jul 2023 16:12:25 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 2/2] arm64: dts: freescale: Add imx8mm-venice-gw7905-0x
Date:   Wed, 19 Jul 2023 09:12:21 -0700
Message-Id: <20230719161221.7005-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719161221.7005-1-tharvey@gateworks.com>
References: <20230719161221.7005-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks imx8mm-venice-gw7905-0x consists of a SOM + baseboard.

The GW700x SOM contains the following:
 - i.MX8M Mini SoC
 - LPDDR4 memory
 - eMMC Boot device
 - Gateworks System Controller (GSC) with integrated EEPROM, button
   controller, and ADC's
 - PMIC
 - SOM connector providing:
  - FEC GbE MII
  - 1x SPI
  - 2x I2C
  - 4x UART
  - 2x USB 2.0
  - 1x PCI
  - 1x SDIO (4-bit 3.3V)
  - 1x SDIO (4-bit 3.3V/1.8V)
  - GPIO

The GW7905 Baseboard contains the following:
 - GPS
 - microSD
 - off-board I/O connector with I2C, SPI, GPIO
 - EERPOM
 - PCIe clock generator
 - 1x full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
 - 1x half-length miniPCIe socket with USB2.0 and USB3.0
 - USB 3.0 HUB
 - USB Type-C with USB PD Sink capability and peripheral support
 - USB Type-C with USB 3.0 host support

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - change clock name from pcie0-refclk to clock-pcie0
 - start properties with compatible then reg with pinctrl following

v2:
 - no changes
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-venice-gw7905-0x.dts |  28 ++
 .../dts/freescale/imx8mm-venice-gw7905.dtsi   | 303 ++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 324ecf17440a..ea63d8f65385 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7903.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7904.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7905-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-yavia.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
new file mode 100644
index 000000000000..914753f062cd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mm.dtsi"
+#include "imx8mm-venice-gw700x.dtsi"
+#include "imx8mm-venice-gw7905.dtsi"
+
+/ {
+	model = "Gateworks Venice GW7905-0x i.MX8MM Development Kit";
+	compatible = "gateworks,imx8mm-gw7905-0x", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
+/* Disable SOM interfaces not used on baseboard */
+&fec1 {
+	status = "disabled";
+};
+
+&usdhc1 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi
new file mode 100644
index 000000000000..5eb92005195c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+/ {
+	led-controller {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio4 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	pcie0_refclk: clock-pcie0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		regulator-name = "usb2_vbus";
+		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "SD2_3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+/* off-board header */
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "gpioa", "gpiob", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "pci_usb_sel",
+		"", "", "", "pci_wdis#",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"", "", "", "",
+		"gpioc", "gpiod", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom@52 {
+		compatible = "atmel,24c32";
+		reg = <0x52>;
+		pagesize = <32>;
+	};
+};
+
+/* off-board header */
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* GPS */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* USB1 - Type C front panel SINK port J14 */
+&usbotg1 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+/* USB2 4-port USB3.0 HUB:
+ *  P1 - USBC connector (host only)
+ *  P2 - USB2 test connector
+ *  P3 - miniPCIe full card
+ *  P4 - miniPCIe half card
+ */
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
+
+/* microSD */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000040 /* GPIOA */
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x40000040 /* GPIOB */
+			MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3	0x40000106 /* PCI_USBSEL */
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000106 /* PCIE_WDIS# */
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x40000040 /* GPIOD */
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x40000040 /* GPIOC */
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0	0x6	/* LEDG */
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2	0x6	/* LEDR */
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c2
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c2
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_pcie0: pciegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x106
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x106
+		>;
+	};
+
+	pinctrl_reg_usb2_en: regusb2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x6	/* USBHUB_RST# (ext p/u) */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x40
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x140
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x140
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x140
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x140
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x1c4
+		>;
+	};
+};
-- 
2.25.1

