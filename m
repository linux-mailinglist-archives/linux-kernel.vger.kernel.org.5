Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5F7B039B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjI0MM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjI0MMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:12:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AB199;
        Wed, 27 Sep 2023 05:12:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RCC2gQ039534;
        Wed, 27 Sep 2023 07:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695816722;
        bh=2ImYg/2cnk2Aq3YIlI4IFNsYLNa+w/i20izESfSt05g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G0NMYqZUKa2vIt3dz2mV1Vo2+eSlVjp8j4Yz6f3Knv8Oz8UqJtV2XVK3fOdYxPMMq
         7ky/kyDFBNSAcLvFZNZziW3DdxlSWcowRRsFx19somqInv34Fxzo+aMqhGkMuwaLRw
         9Cl1tih1lRAfVHe6kBrOpVQkC5LSahE79J/eHXJk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RCC1oP023664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 07:12:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 07:12:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 07:12:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RCC0ce039453;
        Wed, 27 Sep 2023 07:12:01 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>
CC:     <afd@ti.com>, <rogerq@kernel.org>, <s-vadapalli@ti.com>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v10 2/5] arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES PHY nodes
Date:   Wed, 27 Sep 2023 17:41:54 +0530
Message-ID: <20230927121157.278592-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927121157.278592-1-j-choudhary@ti.com>
References: <20230927121157.278592-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6d9a5a91fa75..a0e4d8808693 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -6,9 +6,19 @@
  */
 
 #include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
 
 #include "k3-serdes.h"
 
+/ {
+	serdes_refclk: clock-serdes {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		status = "disabled";
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -709,6 +719,160 @@ main_sdhci1: mmc@4fb0000 {
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
+			status = "disabled";
+		};
+	};
+
 	main_navss: bus@30000000 {
 		bootph-all;
 		compatible = "simple-bus";
-- 
2.25.1

