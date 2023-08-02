Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE376C713
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjHBHhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjHBHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:50 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA133585;
        Wed,  2 Aug 2023 00:36:43 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 579F920389;
        Wed,  2 Aug 2023 09:36:40 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Hiago De Franco <hiago.franco@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am625-verdin: enable CAN_2
Date:   Wed,  2 Aug 2023 09:36:35 +0200
Message-Id: <20230802073635.11290-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802073635.11290-1-francesco@dolcini.it>
References: <20230802073635.11290-1-francesco@dolcini.it>
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

From: Hiago De Franco <hiago.franco@toradex.com>

Add Verdin CAN_2 (TI AM62 MCU_MCAN0) and enable it on the Yavia,
Dahlia and Verdin Development board.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    |  5 +++++
 .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi |  5 +++++
 .../boot/dts/ti/k3-am62-verdin-yavia.dtsi     |  5 +++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 19 +++++++++++++++++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index 3abd8d1d6761..33c8f6ffaa30 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -115,6 +115,11 @@ &mcu_i2c0 {
 	status = "okay";
 };
 
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
 /* Verdin UART_4 */
 &mcu_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
index 846caee7dfa4..8205081fda33 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
@@ -144,6 +144,11 @@ &mcu_i2c0 {
 	status = "okay";
 };
 
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
 /* Verdin UART_4 */
 &mcu_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
index cb11d6e7f525..c685df7deaee 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
@@ -167,6 +167,11 @@ &mcu_i2c0 {
 	status = "okay";
 };
 
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
 /* Verdin UART_4 */
 &mcu_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 57dd061911ab..12dd1d64eac9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -19,6 +19,8 @@ chosen {
 	};
 
 	aliases {
+		can0 = &main_mcan0;
+		can1 = &mcu_mcan0;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
 		i2c0 = &main_i2c0;
@@ -732,6 +734,14 @@ AM62X_MCU_IOPAD(0x0048, PIN_INPUT, 0) /* (D10) MCU_I2C0_SDA */ /* SODIMM 57 */
 		>;
 	};
 
+	/* Verdin CAN_2 */
+	pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
+			AM62X_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */ /* SODIMM 24 */
+		>;
+	};
+
 	/* Verdin UART_4 - Reserved to Cortex-M4 */
 	pinctrl_mcu_uart0: mcu-uart0-default-pins {
 		pinctrl-single,pins = <
@@ -1238,8 +1248,6 @@ &main_mcan0 {
 	status = "disabled";
 };
 
-/* Verdin CAN_2 - Reserved to Cortex-M4 */
-
 /* Verdin SPI_1 */
 &main_spi1 {
 	pinctrl-names = "default";
@@ -1333,6 +1341,13 @@ &mcu_gpio0 {
 		"";
 };
 
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_mcan0>;
+	status = "disabled";
+};
+
 /* Verdin UART_4 - Cortex-M4 UART */
 &mcu_uart0 {
 	pinctrl-names = "default";
-- 
2.25.1

