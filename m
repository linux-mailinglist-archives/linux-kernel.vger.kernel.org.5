Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09FF800E02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379316AbjLAPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379308AbjLAPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:07:36 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B11B9;
        Fri,  1 Dec 2023 07:07:41 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 8F90B21393;
        Fri,  1 Dec 2023 16:07:39 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] arm64: dts: freescale: verdin-imx8mm: add support to mallow board
Date:   Fri,  1 Dec 2023 16:07:33 +0100
Message-Id: <20231201150733.24454-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201150733.24454-1-francesco@dolcini.it>
References: <20231201150733.24454-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add Toradex Verdin IMX8MM Mallow carrier board support. Mallow is a
low-cost carrier board in the Verdin family with a small form factor and
build for volume production making it ideal for industrial and embedded
applications.

https://www.toradex.com/products/carrier-board/mallow-carrier-board

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8mm-verdin-mallow.dtsi   | 173 ++++++++++++++++++
 .../imx8mm-verdin-nonwifi-mallow.dts          |  18 ++
 .../freescale/imx8mm-verdin-wifi-mallow.dts   |  18 ++
 4 files changed, 211 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-mallow.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-mallow.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-mallow.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6d83f84090e1..98fc8171a885 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -84,9 +84,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7904.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7905-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-mallow.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-yavia.dtb
 
 imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33-dtbs += imx8mm-tqma8mqml-mba8mx.dtb imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-mallow.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-mallow.dtsi
new file mode 100644
index 000000000000..4a0799d63446
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-mallow.dtsi
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * Common dtsi for Verdin IMX8MM SoM on Mallow carrier board
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-mini-nano
+ * https://www.toradex.com/products/carrier-board/mallow-carrier-board
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		/* SODIMM 52 - USER_LED_1_RED */
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* SODIMM 54 - USER_LED_1_GREEN */
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* SODIMM 56 - USER_LED_2_RED */
+		led-2 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* SODIMM 58 - USER_LED_2_GREEN */
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+/* Verdin SPI_1 */
+&ecspi2 {
+	pinctrl-0 = <&pinctrl_ecspi2>, <&pinctrl_tpm_cs>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>, <&gpio3 2 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpm_irq>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+/* EEPROM on Mallow */
+&eeprom_carrier_board {
+	status = "okay";
+};
+
+/* Verdin ETH_1 */
+&fec1 {
+	status = "okay";
+};
+
+/* Temperature sensor on Mallow */
+&hwmon_temp {
+	compatible = "ti,tmp1075";
+	status = "okay";
+};
+
+/* Verdin I2C_2_DSI */
+&i2c2 {
+	status = "okay";
+};
+
+/* Verdin I2C_4_CSI */
+&i2c3 {
+	status = "okay";
+};
+
+/* Verdin I2C_1 */
+&i2c4 {
+	status = "okay";
+};
+
+/* Verdin PCIE_1 */
+&pcie0 {
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&pwm1 {
+	status = "okay";
+};
+
+/* Verdin PWM_1 */
+&pwm2 {
+	status = "okay";
+};
+
+/* Verdin PWM_2 */
+&pwm3 {
+	status = "okay";
+};
+
+/* Verdin UART_3 */
+&uart1 {
+	status = "okay";
+};
+
+/* Verdin UART_1 */
+&uart2 {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&uart3 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usbotg1 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usbotg2 {
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&usdhc2 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_leds: ledsgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0	0x106>, /* SODIMM 52 */
+			<MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x106>, /* SODIMM 54 */
+			<MX8MM_IOMUXC_NAND_DATA00_GPIO3_IO6	0x106>, /* SODIMM 56 */
+			<MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7	0x106>; /* SODIMM 58 */
+	};
+
+	pinctrl_tpm_cs: tpmcsgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2	0x146>; /* SODIMM 64 */
+	};
+
+	pinctrl_tpm_irq: tpmirqgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_NAND_DQS_GPIO3_IO14	0x141>; /* SODIMM 66 */
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-mallow.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-mallow.dts
new file mode 100644
index 000000000000..1b1999f3a80e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-mallow.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-nonwifi.dtsi"
+#include "imx8mm-verdin-mallow.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini on Mallow";
+	compatible = "toradex,verdin-imx8mm-nonwifi-mallow",
+		     "toradex,verdin-imx8mm-nonwifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-mallow.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-mallow.dts
new file mode 100644
index 000000000000..2916145f31bb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-mallow.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-wifi.dtsi"
+#include "imx8mm-verdin-mallow.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini WB on Mallow";
+	compatible = "toradex,verdin-imx8mm-wifi-mallow",
+		     "toradex,verdin-imx8mm-wifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
-- 
2.25.1

