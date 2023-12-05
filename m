Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD707805DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbjLESqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjLESqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:46:13 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522E1A2;
        Tue,  5 Dec 2023 10:46:17 -0800 (PST)
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 3D637201F1;
        Tue,  5 Dec 2023 19:46:14 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v3 3/3] arm64: dts: ti: add verdin am62 mallow board
Date:   Tue,  5 Dec 2023 19:46:05 +0100
Message-Id: <20231205184605.35225-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231205184605.35225-1-francesco@dolcini.it>
References: <20231205184605.35225-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add Toradex Verdin AM62 Mallow carrier board support. Mallow is a
low-cost carrier board in the Verdin family with a small form factor and
build for volume production making it ideal for industrial and embedded
applications.

https://www.toradex.com/products/carrier-board/mallow-carrier-board

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: fixed temperature sensor compatible (s/tmp75c/tmp1075)
v3: removed TPM node
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am62-verdin-mallow.dtsi    | 188 ++++++++++++++++++
 .../dts/ti/k3-am625-verdin-nonwifi-mallow.dts |  22 ++
 .../dts/ti/k3-am625-verdin-wifi-mallow.dts    |  22 ++
 4 files changed, 234 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 77a347f9f47d..92ebf001a217 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -16,9 +16,11 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-hdmi-audio.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
new file mode 100644
index 000000000000..17b93534f658
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * Common dtsi for Verdin AM62 SoM on Mallow carrier board
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
+ * https://www.toradex.com/products/carrier-board/mallow-carrier-board
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qspi1_clk_gpio>,
+			    <&pinctrl_qspi1_cs_gpio>,
+			    <&pinctrl_qspi1_io0_gpio>,
+			    <&pinctrl_qspi1_io1_gpio>;
+
+		/* SODIMM 52 - USER_LED_1_RED */
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* SODIMM 54 - USER_LED_1_GREEN */
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&main_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* SODIMM 56 - USER_LED_2_RED */
+		led-2 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* SODIMM 58 - USER_LED_2_GREEN */
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+/* Verdin ETH */
+&cpsw3g {
+	status = "okay";
+};
+
+/* Verdin MDIO */
+&cpsw3g_mdio {
+	status = "okay";
+};
+
+/* Verdin ETH_1*/
+&cpsw_port1 {
+	status = "okay";
+};
+
+/* Verdin PWM_1 and PWM_2*/
+&epwm0 {
+	status = "okay";
+};
+
+/* Verdin PWM_3 DSI */
+&epwm1 {
+	status = "okay";
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>,
+		    <&pinctrl_gpio_1>,
+		    <&pinctrl_gpio_2>,
+		    <&pinctrl_gpio_3>,
+		    <&pinctrl_gpio_4>;
+};
+
+/* Verdin I2C_1 */
+&main_i2c1 {
+	status = "okay";
+
+	/* Temperature sensor */
+	sensor@4f {
+		compatible = "ti,tmp1075";
+		reg = <0x4f>;
+	};
+
+	/* EEPROM */
+	eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+/* Verdin I2C_2 DSI */
+&main_i2c2 {
+	status = "okay";
+};
+
+/* Verdin I2C_4 CSI */
+&main_i2c3 {
+	status = "okay";
+};
+
+/* Verdin CAN_1 */
+&main_mcan0 {
+	status = "okay";
+};
+
+/* Verdin SPI_1 */
+&main_spi1 {
+	pinctrl-0 = <&pinctrl_spi1>,
+		    <&pinctrl_spi1_cs0>,
+		    <&pinctrl_qspi1_cs2_gpio>;
+	cs-gpios = <0>, <&main_gpio0 12 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* Verdin UART_3 */
+&main_uart0 {
+	status = "okay";
+};
+
+/* Verdin UART_1 */
+&main_uart1 {
+	status = "okay";
+};
+
+/* Verdin I2C_3_HDMI */
+&mcu_i2c0 {
+	status = "okay";
+};
+
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
+/* Verdin UART_4 */
+&mcu_uart0 {
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&sdhci1 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usbss0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usbss1 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+/* Verdin CTRL_WAKE1_MICO# */
+&verdin_gpio_keys {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&wkup_uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dts b/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dts
new file mode 100644
index 000000000000..9cae12106e0e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
+ * https://www.toradex.com/products/carrier-board/mallow-carrier-board
+ */
+
+/dts-v1/;
+
+#include "k3-am625.dtsi"
+#include "k3-am62-verdin.dtsi"
+#include "k3-am62-verdin-nonwifi.dtsi"
+#include "k3-am62-verdin-mallow.dtsi"
+
+/ {
+	model = "Toradex Verdin AM62 on Mallow Board";
+	compatible = "toradex,verdin-am62-nonwifi-mallow",
+		     "toradex,verdin-am62-nonwifi",
+		     "toradex,verdin-am62",
+		     "ti,am625";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dts b/arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dts
new file mode 100644
index 000000000000..81d834b22649
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
+ * https://www.toradex.com/products/carrier-board/mallow-carrier-board
+ */
+
+/dts-v1/;
+
+#include "k3-am625.dtsi"
+#include "k3-am62-verdin.dtsi"
+#include "k3-am62-verdin-wifi.dtsi"
+#include "k3-am62-verdin-mallow.dtsi"
+
+/ {
+	model = "Toradex Verdin AM62 WB on Mallow Board";
+	compatible = "toradex,verdin-am62-wifi-mallow",
+		     "toradex,verdin-am62-wifi",
+		     "toradex,verdin-am62",
+		     "ti,am625";
+};
-- 
2.25.1

