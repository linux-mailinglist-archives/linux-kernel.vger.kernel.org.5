Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7A76638C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjG1FJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjG1FJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:09:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562083A8C;
        Thu, 27 Jul 2023 22:09:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S5931u052033;
        Fri, 28 Jul 2023 00:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690520943;
        bh=AIafqKU7Y2RBOehnuNYdV1lQFlNou13dfBQq2fo4yek=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ttfA6bASxO+yDSBVfT1NMbnHoNDvvGuZE56/PDr76mSVbCjF5LHYhU3oD2CMgwXF+
         yd4HMg9GxCkaz1Sn1y8wAwreybVaapjM8dCI7dRelY1gvk43gg1gnmH0QJm5JUHIEc
         M2svM+qqgDujI0yXMCSNlkUk6lFR0wbJLj6FbgIg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S593Za124452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 00:09:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 00:09:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 00:09:03 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S592lp017215;
        Fri, 28 Jul 2023 00:09:02 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v7 2/4] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY nodes
Date:   Fri, 28 Jul 2023 10:38:57 +0530
Message-ID: <20230728050859.7370-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728050859.7370-1-j-choudhary@ti.com>
References: <20230728050859.7370-1-j-choudhary@ti.com>
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

From: Siddharth Vadapalli <s-vadapalli@ti.com>

J784S4 SoC has 4 Serdes instances along with their respective WIZ
instances. Add device-tree nodes for them and disable them by default.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[j-choudhary@ti.com: fix serdes_wiz clock order & disable serdes refclk]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 172 +++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 8a816563706b..fbf5ab94d785 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -6,9 +6,19 @@
  */
 
 #include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
 
 #include "k3-serdes.h"
 
+/ {
+	serdes_refclk: serdes-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		status = "disabled";
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -709,6 +719,168 @@ main_sdhci1: mmc@4fb0000 {
 		status = "disabled";
 	};
 
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 404 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 404 2>, <&k3_clks 404 6>, <&serdes_refclk>, <&k3_clks 404 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 404 6>;
+		assigned-clock-parents = <&k3_clks 404 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x5060000 0x00 0x5060000 0x10000>;
+
+		status = "disabled";
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 404 6>,
+						 <&k3_clks 404 6>,
+						 <&k3_clks 404 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz1: wiz@5070000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 405 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 405 2>, <&k3_clks 405 6>, <&serdes_refclk>, <&k3_clks 405 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 405 6>;
+		assigned-clock-parents = <&k3_clks 405 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05070000 0x00 0x05070000 0x10000>;
+
+		status = "disabled";
+
+		serdes1: serdes@5070000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05070000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz1 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 405 6>,
+						 <&k3_clks 405 6>,
+						 <&k3_clks 405 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz2: wiz@5020000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 406 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 406 2>, <&k3_clks 406 6>, <&serdes_refclk>, <&k3_clks 406 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 406 6>;
+		assigned-clock-parents = <&k3_clks 406 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05020000 0x00 0x05020000 0x10000>;
+
+		status = "disabled";
+
+		serdes2: serdes@5020000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05020000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz2 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz2 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz2 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz2 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 406 6>,
+						 <&k3_clks 406 6>,
+						 <&k3_clks 406 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz4: wiz@5050000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 407 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 407 2>, <&k3_clks 407 6>, <&serdes_refclk>, <&k3_clks 407 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 407 6>;
+		assigned-clock-parents = <&k3_clks 407 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05050000 0x00 0x05050000 0x10000>,
+			 <0xa030a00 0x00 0xa030a00 0x40>; /* DPTX PHY */
+
+		status = "disabled";
+
+		serdes4: serdes@5050000 {
+			/*
+			 * Note: we also map DPTX PHY registers as the Torrent
+			 * needs to manage those.
+			 */
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05050000 0x010000>,
+			      <0x0a030a00 0x40>; /* DPTX PHY */
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz4 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz4 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 407 6>,
+						 <&k3_clks 407 6>,
+						 <&k3_clks 407 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled";
+		};
+	};
+
 	main_navss: bus@30000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.25.1

