Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED5760BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjGYHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjGYHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:33:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B312D;
        Tue, 25 Jul 2023 00:31:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P7V1VG076670;
        Tue, 25 Jul 2023 02:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690270261;
        bh=sN4djLHKQJOKon9P3vbexqpa/e55Zh/aCtkLXgHJMao=;
        h=From:To:CC:Subject:Date;
        b=d6bGUsSBPlSEYDUuPojq01MLsi0xBEvwkigvoO79UgdRAeZmxiV554U2KyGYqxXLF
         1CWeENaEJRIONERMxGh7jrtm49CreegUFvgtJTq/wsxYg7M+afwMkQ8CrtD++s2plj
         LdRlwCfmUjdgURmRXJvngO+Cq2W71s6U4HsEGRkM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P7V1dO032520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 02:31:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 02:31:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 02:31:01 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P7UvdT034074;
        Tue, 25 Jul 2023 02:30:58 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports with GESI
Date:   Tue, 25 Jul 2023 13:00:57 +0530
Message-ID: <20230725073057.96705-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
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

The J7 GESI EXP board for J721E Common-Proc-Board supports RGMII mode.
Use the overlay to configure CPSW9G ports in RGMII-RXID mode.

Add aliases for CPSW9G ports to enable kernel to fetch MAC addresses
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---

NOTE: This patch is based on linux-next tagged next-20230725.

v2:
https://lore.kernel.org/r/20230710075551.1109024-1-s-vadapalli@ti.com/
Changes since v2:
- Collect Reviewed-by tag from Ravi Gunasekaran <r-gunasekaran@ti.com>
- Rename rgmii1_pins_default, rgmii2_pins_default, rgmii3_pins_default,
  rgmii4_pins_default and mdio0_pins_default to:
  rgmii1_default_pins, rgmii2_default_pins, rgmii3_default_pins,
  rgmii4_default_pins and mdio0_default_pins respectively.
- Rename rgmii1-pins-default, rgmii2-pins-default, rgmii3-pins-default,
  rgmii4-pins-default and mdio0-pins-default to:
  rgmii1-default-pins, rgmii2-default-pins, rgmii3-default-pins,
  rgmii4-default-pins and mdio0-default-pins respectively.
- The above changes are performed to follow the updated json-schema
  patch at:
  https://lore.kernel.org/all/169021456020.3622493.10284534202541859578.robh@kernel.org/ 

v1:
https://lore.kernel.org/r/20230529094222.512675-1-s-vadapalli@ti.com/
Changes since v1:
- Rebase on linux-next tagged next-20230710.

 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j721e-evm-gesi-exp-board.dtso   | 196 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 6dd7b6f1d6ab..01d58aa8b06e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm.dtb
 k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-exp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 
 # Boards with J721s2 SoC
@@ -58,3 +59,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-j721e-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
new file mode 100644
index 000000000000..6a7d37575da1
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for CPSW9G in RGMII mode using J7 GESI EXP BRD board with
+ * J721E board.
+ *
+ * GESI Board Product Link: https://www.ti.com/tool/J7EXPCXEVM
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@1";
+		ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@2";
+		ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@3";
+		ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@4";
+	};
+};
+
+&cpsw0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_default_pins
+		     &rgmii2_default_pins
+		     &rgmii3_default_pins
+		     &rgmii4_default_pins>;
+};
+
+&cpsw0_port1 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy12>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>;
+};
+
+&cpsw0_port2 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy15>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>;
+};
+
+&cpsw0_port3 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy0>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 3>;
+};
+
+&cpsw0_port4 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy3>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 4>;
+};
+
+&cpsw9g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_default_pins>;
+	bus_freq = <1000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpsw9g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+	cpsw9g_phy3: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+	cpsw9g_phy12: ethernet-phy@12 {
+		reg = <12>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+	cpsw9g_phy15: ethernet-phy@15 {
+		reg = <15>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&exp1 {
+	p15-hog {
+		/* P15 - EXP_MUX2 */
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "EXP_MUX2";
+	};
+
+	p16-hog {
+		/* P16 - EXP_MUX3 */
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "EXP_MUX3";
+	};
+};
+
+&main_pmx0 {
+	mdio0_default_pins: mdio0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1bc, PIN_OUTPUT, 0) /* (V24) MDIO0_MDC */
+			J721E_IOPAD(0x1b8, PIN_INPUT, 0) /* (V26) MDIO0_MDIO */
+		>;
+	};
+
+	rgmii1_default_pins: rgmii1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x4, PIN_INPUT, 4) /* (AC23) PRG1_PRU0_GPO0.RGMII1_RD0 */
+			J721E_IOPAD(0x8, PIN_INPUT, 4) /* (AG22) PRG1_PRU0_GPO1.RGMII1_RD1 */
+			J721E_IOPAD(0xc, PIN_INPUT, 4) /* (AF22) PRG1_PRU0_GPO2.RGMII1_RD2 */
+			J721E_IOPAD(0x10, PIN_INPUT, 4) /* (AJ23) PRG1_PRU0_GPO3.RGMII1_RD3 */
+			J721E_IOPAD(0x1c, PIN_INPUT, 4) /* (AD22) PRG1_PRU0_GPO6.RGMII1_RXC */
+			J721E_IOPAD(0x14, PIN_INPUT, 4) /* (AH23) PRG1_PRU0_GPO4.RGMII1_RX_CTL */
+			J721E_IOPAD(0x30, PIN_OUTPUT, 4) /* (AF24) PRG1_PRU0_GPO11.RGMII1_TD0 */
+			J721E_IOPAD(0x34, PIN_OUTPUT, 4) /* (AJ24) PRG1_PRU0_GPO12.RGMII1_TD1 */
+			J721E_IOPAD(0x38, PIN_OUTPUT, 4) /* (AG24) PRG1_PRU0_GPO13.RGMII1_TD2 */
+			J721E_IOPAD(0x3c, PIN_OUTPUT, 4) /* (AD24) PRG1_PRU0_GPO14.RGMII1_TD3 */
+			J721E_IOPAD(0x44, PIN_OUTPUT, 4) /* (AE24) PRG1_PRU0_GPO16.RGMII1_TXC */
+			J721E_IOPAD(0x40, PIN_OUTPUT, 4) /* (AC24) PRG1_PRU0_GPO15.RGMII1_TX_CTL */
+		>;
+	};
+
+	rgmii2_default_pins: rgmii2-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x58, PIN_INPUT, 4) /* (AE22) PRG1_PRU1_GPO0.RGMII2_RD0 */
+			J721E_IOPAD(0x5c, PIN_INPUT, 4) /* (AG23) PRG1_PRU1_GPO1.RGMII2_RD1 */
+			J721E_IOPAD(0x60, PIN_INPUT, 4) /* (AF23) PRG1_PRU1_GPO2.RGMII2_RD2 */
+			J721E_IOPAD(0x64, PIN_INPUT, 4) /* (AD23) PRG1_PRU1_GPO3.RGMII2_RD3 */
+			J721E_IOPAD(0x70, PIN_INPUT, 4) /* (AE23) PRG1_PRU1_GPO6.RGMII2_RXC */
+			J721E_IOPAD(0x68, PIN_INPUT, 4) /* (AH24) PRG1_PRU1_GPO4.RGMII2_RX_CTL */
+			J721E_IOPAD(0x84, PIN_OUTPUT, 4) /* (AJ25) PRG1_PRU1_GPO11.RGMII2_TD0 */
+			J721E_IOPAD(0x88, PIN_OUTPUT, 4) /* (AH25) PRG1_PRU1_GPO12.RGMII2_TD1 */
+			J721E_IOPAD(0x8c, PIN_OUTPUT, 4) /* (AG25) PRG1_PRU1_GPO13.RGMII2_TD2 */
+			J721E_IOPAD(0x90, PIN_OUTPUT, 4) /* (AH26) PRG1_PRU1_GPO14.RGMII2_TD3 */
+			J721E_IOPAD(0x98, PIN_OUTPUT, 4) /* (AJ26) PRG1_PRU1_GPO16.RGMII2_TXC */
+			J721E_IOPAD(0x94, PIN_OUTPUT, 4) /* (AJ27) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
+		>;
+	};
+
+	rgmii3_default_pins: rgmii3-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xb0, PIN_INPUT, 4) /* (AF28) PRG0_PRU0_GPO0.RGMII3_RD0 */
+			J721E_IOPAD(0xb4, PIN_INPUT, 4) /* (AE28) PRG0_PRU0_GPO1.RGMII3_RD1 */
+			J721E_IOPAD(0xb8, PIN_INPUT, 4) /* (AE27) PRG0_PRU0_GPO2.RGMII3_RD2 */
+			J721E_IOPAD(0xbc, PIN_INPUT, 4) /* (AD26) PRG0_PRU0_GPO3.RGMII3_RD3 */
+			J721E_IOPAD(0xc8, PIN_INPUT, 4) /* (AE26) PRG0_PRU0_GPO6.RGMII3_RXC */
+			J721E_IOPAD(0xc0, PIN_INPUT, 4) /* (AD25) PRG0_PRU0_GPO4.RGMII3_RX_CTL */
+			J721E_IOPAD(0xdc, PIN_OUTPUT, 4) /* (AJ28) PRG0_PRU0_GPO11.RGMII3_TD0 */
+			J721E_IOPAD(0xe0, PIN_OUTPUT, 4) /* (AH27) PRG0_PRU0_GPO12.RGMII3_TD1 */
+			J721E_IOPAD(0xe4, PIN_OUTPUT, 4) /* (AH29) PRG0_PRU0_GPO13.RGMII3_TD2 */
+			J721E_IOPAD(0xe8, PIN_OUTPUT, 4) /* (AG28) PRG0_PRU0_GPO14.RGMII3_TD3 */
+			J721E_IOPAD(0xf0, PIN_OUTPUT, 4) /* (AH28) PRG0_PRU0_GPO16.RGMII3_TXC */
+			J721E_IOPAD(0xec, PIN_OUTPUT, 4) /* (AG27) PRG0_PRU0_GPO15.RGMII3_TX_CTL */
+		>;
+	};
+
+	rgmii4_default_pins: rgmii4-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x100, PIN_INPUT, 4) /* (AE29) PRG0_PRU1_GPO0.RGMII4_RD0 */
+			J721E_IOPAD(0x104, PIN_INPUT, 4) /* (AD28) PRG0_PRU1_GPO1.RGMII4_RD1 */
+			J721E_IOPAD(0x108, PIN_INPUT, 4) /* (AD27) PRG0_PRU1_GPO2.RGMII4_RD2 */
+			J721E_IOPAD(0x10c, PIN_INPUT, 4) /* (AC25) PRG0_PRU1_GPO3.RGMII4_RD3 */
+			J721E_IOPAD(0x118, PIN_INPUT, 4) /* (AC26) PRG0_PRU1_GPO6.RGMII4_RXC */
+			J721E_IOPAD(0x110, PIN_INPUT, 4) /* (AD29) PRG0_PRU1_GPO4.RGMII4_RX_CTL */
+			J721E_IOPAD(0x12c, PIN_OUTPUT, 4) /* (AG26) PRG0_PRU1_GPO11.RGMII4_TD0 */
+			J721E_IOPAD(0x130, PIN_OUTPUT, 4) /* (AF27) PRG0_PRU1_GPO12.RGMII4_TD1 */
+			J721E_IOPAD(0x134, PIN_OUTPUT, 4) /* (AF26) PRG0_PRU1_GPO13.RGMII4_TD2 */
+			J721E_IOPAD(0x138, PIN_OUTPUT, 4) /* (AE25) PRG0_PRU1_GPO14.RGMII4_TD3 */
+			J721E_IOPAD(0x140, PIN_OUTPUT, 4) /* (AG29) PRG0_PRU1_GPO16.RGMII4_TXC */
+			J721E_IOPAD(0x13c, PIN_OUTPUT, 4) /* (AF29) PRG0_PRU1_GPO15.RGMII4_TX_CTL */
+		>;
+	};
+};
-- 
2.34.1

