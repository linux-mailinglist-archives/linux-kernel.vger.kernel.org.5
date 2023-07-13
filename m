Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B7752691
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjGMPSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjGMPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:17:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05B35A5;
        Thu, 13 Jul 2023 08:17:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DFHBcx105234;
        Thu, 13 Jul 2023 10:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689261431;
        bh=LFqEsIGBpg4tR5ocmjWcKoK2qr9aGBu2VLzDfOK83s0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=M7/pae6hJ1o6fzNMOt9cQvy13LNWwEy8sgHbkk9PmaewlwDG0SuN6dGdfp8hDC4sG
         KbXXVrUia44pVT9evbRHv979WgsgKxfhzTkcABIllT1qmvVDROQ69oemEOA4T1gndC
         P2wBvW2PPVy50TX34G/0hPwaXIwjmvadm0xGB/g8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DFHB0s054640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 10:17:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 10:17:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 10:17:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DFH9pl021400;
        Thu, 13 Jul 2023 10:17:10 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peda@axentia.se>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: Use local header for SERDES MUX idle-state values
Date:   Thu, 13 Jul 2023 20:47:06 +0530
Message-ID: <20230713151707.8109-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713151707.8109-1-j-choudhary@ti.com>
References: <20230713151707.8109-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS uses constants for SERDES MUX idle state values which were earlier
provided as bindings header. But they are unsuitable for bindings.
So move these constants in a header next to DTS.

Also add J784S4 SERDES4 lane definitons which were missed earlier.

Suggested-by: Nishanth Menon <nm@ti.com>
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Suggested-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/linux-arm-kernel/b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org/
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   3 +-
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |   3 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   3 +-
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |   3 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |   3 +-
 .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    |   2 +-
 .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    |   2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   3 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |   3 +-
 arch/arm64/boot/dts/ti/k3-serdes.h            | 204 ++++++++++++++++++
 10 files changed, 220 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-serdes.h

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 15c282c93467..d84e7ee16032 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -6,12 +6,13 @@
 /dts-v1/;
 
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "ti,am642-evm", "ti,am642";
 	model = "Texas Instruments AM642 EVM";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 9c418abd29d8..9175e96842d8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -16,11 +16,12 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include "k3-am642.dtsi"
 #include "k3-am64-phycore-som.dtsi"
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "phytec,am642-phyboard-electra-rdk",
 		     "phytec,am64-phycore-som", "ti,am642";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index cbce43dbe3f9..963d796a3a97 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -5,13 +5,14 @@
 
 /dts-v1/;
 
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/leds/common.h>
 #include "k3-am642.dtsi"
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "ti,am642-sk", "ti,am642";
 	model = "Texas Instruments AM642 SK";
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d5889ba3fa46..21ad49cfa7ee 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -11,7 +11,8 @@
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/phy/phy-cadence.h>
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/mux/ti-serdes.h>
+
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,am68-sk", "ti,j721s2";
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 3cf288128c3f..92a541491172 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -8,9 +8,10 @@
 #include "k3-j7200-som-p0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "ti,j7200-evm", "ti,j7200";
 	model = "Texas Instruments J7200 EVM";
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
index 34a0747cbe69..32d905235ed7 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
@@ -10,9 +10,9 @@
 /plugin/;
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/mux/ti-serdes.h>
 
 #include "k3-pinctrl.h"
+#include "k3-serdes.h"
 
 &{/} {
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
index 6f0adf591b98..d4c51ffc3d6b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
@@ -10,11 +10,11 @@
 /plugin/;
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-cadence.h>
 
 #include "k3-pinctrl.h"
+#include "k3-serdes.h"
 
 &{/} {
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 575435c1a984..88a610638d04 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -7,7 +7,8 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-ti.h>
 #include <dt-bindings/mux/mux.h>
-#include <dt-bindings/mux/ti-serdes.h>
+
+#include "k3-serdes.h"
 
 / {
 	cmn_refclk: clock-cmnrefclk {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 092ab1e14ba5..02b7a559bdf2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -11,7 +11,8 @@
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/phy/phy-cadence.h>
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/mux/ti-serdes.h>
+
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,j721s2-evm", "ti,j721s2";
diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
new file mode 100644
index 000000000000..29167f85c1f6
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-serdes.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for SERDES MUX for TI SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef DTS_ARM64_TI_K3_SERDES_H
+#define DTS_ARM64_TI_K3_SERDES_H
+
+/* J721E */
+
+#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
+#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
+#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
+#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
+#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
+#define J721E_SERDES0_LANE1_USB3_0		0x2
+#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
+#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
+#define J721E_SERDES1_LANE1_USB3_1		0x2
+#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
+#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
+#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
+#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
+#define J721E_SERDES2_LANE1_USB3_1		0x2
+#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
+#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
+#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
+#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
+#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
+#define J721E_SERDES3_LANE1_USB3_0		0x2
+#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
+#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
+#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
+#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
+#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
+#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
+#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
+#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
+#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
+
+/* J7200 */
+
+#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
+#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
+#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
+#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
+#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
+#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
+#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
+#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
+#define J7200_SERDES0_LANE3_USB			0x2
+#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
+
+/* AM64 */
+
+#define AM64_SERDES0_LANE0_PCIE0		0x0
+#define AM64_SERDES0_LANE0_USB			0x1
+
+/* J721S2 */
+
+#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
+#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
+#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J721S2_SERDES0_LANE1_USB		0x2
+#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
+#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
+#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J721S2_SERDES0_LANE3_USB		0x2
+#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
+
+/* J784S4 */
+
+#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
+#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
+#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J784S4_SERDES0_LANE3_USB		0x2
+#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
+#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
+#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
+#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
+#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
+#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
+#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
+#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
+#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
+#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
+#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
+#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
+#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
+#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
+#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE0_EDP_LANE0		0x0
+#define J784S4_SERDES4_LANE0_QSGMII_LANE5	0x1
+#define J784S4_SERDES4_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE1_EDP_LANE1		0x0
+#define J784S4_SERDES4_LANE1_QSGMII_LANE6	0x1
+#define J784S4_SERDES4_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE2_EDP_LANE2		0x0
+#define J784S4_SERDES4_LANE2_QSGMII_LANE7	0x1
+#define J784S4_SERDES4_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE3_EDP_LANE3		0x0
+#define J784S4_SERDES4_LANE3_QSGMII_LANE8	0x1
+#define J784S4_SERDES4_LANE3_USB		0x2
+#define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
+
+#endif /* DTS_ARM64_TI_K3_SERDES_H */
-- 
2.25.1

