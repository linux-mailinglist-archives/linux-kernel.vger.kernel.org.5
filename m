Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56C076C3D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHBEEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjHBEEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:04:06 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65481FEE;
        Tue,  1 Aug 2023 21:04:02 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37243rI8004321;
        Tue, 1 Aug 2023 23:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690949033;
        bh=LtLj/lGP2tAi++udg5DCncfY6MDFxzeQD36/9v9ywUA=;
        h=From:To:CC:Subject:Date;
        b=bhdqcnuLSLu241d+fCJDFhnJ/tG0q6rvICvt9scd/gb0XazkzmO3Y4+BjnRjFvxVK
         0x+RTdSUOIkYGAgInVTylVlhR6qyqX97X3vf2SJqbDayo1cdMgq8L2Te7nPR8jzNtb
         Qo586xDF66XWzVyfVyrYWjNj3r2GyLjW56Z+YOMM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37243r5S022972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 23:03:53 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 23:03:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 23:03:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37243qQk114423;
        Tue, 1 Aug 2023 23:03:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3: Fixup remaining pin group node names for make dtbs checks
Date:   Tue, 1 Aug 2023 23:03:47 -0500
Message-ID: <20230802040347.2264339-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up outstanding pingroup node names to be compliant with the
upcoming pinctrl-single schema.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts           | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi   | 2 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts           | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts | 4 ++--
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts         | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7c1402b0fa2d..e07ddff22e07 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -432,7 +432,7 @@ AM62X_MCU_IOPAD(0x0048, PIN_INPUT, 0) /* (D10) MCU_I2C0_SDA */
 		>;
 	};
 
-	gbe_pmx_obsclk: gbe-pmx-clk-default {
+	gbe_pmx_obsclk: gbe-pmx-obsclk-default-pins {
 		pinctrl-single,pins = <
 			AM62X_MCU_IOPAD(0x0004, PIN_OUTPUT, 1) /* (B8) MCU_SPI0_CS1.MCU_OBSCLK0 */
 		>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
index e73458ca6900..e9419c4fe605 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -10,7 +10,7 @@
  */
 
 &main_pmx0 {
-	cp2102n_reset_pin_default: cp2102n-reset-pin-default {
+	cp2102n_reset_pin_default: cp2102n-reset-default-pins {
 		pinctrl-single,pins = <
 			/* (AF12) GPIO1_24, used as cp2102 reset */
 			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 973a89b04a22..734b051c9700 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -192,7 +192,7 @@ AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
 		>;
 	};
 
-	wkup_pca554_default: wkup-pca554-default {
+	wkup_pca554_default: wkup-pca554-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0034, PIN_INPUT, 7) /* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
 		>;
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index cbe44634914f..774eb14ac907 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -33,7 +33,7 @@ AM65X_IOPAD(0x01c4, PIN_INPUT_PULLUP, 7)  /* (AH13) GPIO1_17 */
 		>;
 	};
 
-	main_bkey_pcie_reset: main-bkey-pcie-reset {
+	main_bkey_pcie_reset: main-bkey-pcie-reset-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01bc, PIN_OUTPUT_PULLUP, 7)  /* (AG13) GPIO1_15 */
 		>;
@@ -46,7 +46,7 @@ AM65X_IOPAD(0x01cc, PIN_INPUT_PULLUP, 7)  /* (AD13) GPIO1_19 */
 		>;
 	};
 
-	main_m2_pcie_mux_control: main-m2-pcie-mux-control {
+	main_m2_pcie_mux_control: main-m2-pcie-mux-control-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0148, PIN_INPUT_PULLUP, 7)  /* (AG22) GPIO0_82 */
 			AM65X_IOPAD(0x0160, PIN_INPUT_PULLUP, 7)  /* (AE20) GPIO0_88 */
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 21ad49cfa7ee..a8172ba55f4b 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -273,7 +273,7 @@ J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
 	};
 
-	mcu_rpi_header_gpio0_pins0_default: mcu-rpi-header-gpio0-pins0-default {
+	mcu_rpi_header_gpio0_pins0_default: mcu-rpi-header-gpio0-default-pins-0 {
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x118, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
 			J721S2_WKUP_IOPAD(0x05C, PIN_INPUT, 7) /* (E24) MCU_SPI1_D0.WKUP_GPIO0_1 */
@@ -289,7 +289,7 @@ J721S2_WKUP_IOPAD(0x064, PIN_INPUT, 7) /* (C27) MCU_SPI1_CS0.WKUP_GPIO0_3 */
 };
 
 &wkup_pmx3 {
-	mcu_rpi_header_gpio0_pins1_default: mcu-rpi-header-gpio0-pins1-default {
+	mcu_rpi_header_gpio0_pins1_default: mcu-rpi-header-gpio0-default-pins-1 {
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x000, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
 		>;
-- 
2.40.0

