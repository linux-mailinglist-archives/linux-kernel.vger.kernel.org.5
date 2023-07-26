Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD80762BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGZGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:54:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C4A1BFB;
        Tue, 25 Jul 2023 23:54:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36Q6sGqR125642;
        Wed, 26 Jul 2023 01:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690354457;
        bh=HYvKSPC1lxV1Pgg9D+hvA9yuxZNj88tDZChJC8z98I0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MzFLxiLwX/BY8wc3aN29H1LdMzhPU2ipEw93MwpKbYKPg6d5G0p0PiC9XMVDgLdo9
         2RtNKO6gkj8UK4B5VlLWFFJH0H4FNUj/Af4+F9saxPxsXe5HcHMhrvMW8LNU5I/Muh
         7RmRiD4wi26GmyxgjIGE1LXJdwg8uQPFTJP8ydn4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36Q6sGkG048126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 01:54:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 01:54:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 01:54:16 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36Q6s8Te013490;
        Wed, 26 Jul 2023 01:54:13 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
Date:   Wed, 26 Jul 2023 12:24:06 +0530
Message-ID: <20230726065407.378455-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726065407.378455-1-s-vadapalli@ti.com>
References: <20230726065407.378455-1-s-vadapalli@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

TI's J721S2 SoC has a MAIN CPSW2G instance of the CPSW Ethernet Switch.
Add devicetree node for it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ed79ab3a3271..4d0d27e7ca1b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -51,6 +51,12 @@ usb_serdes_mux: mux-controller@0 {
 			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
 		};
 
+		phy_gmii_sel_cpsw: phy@34 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x34 0x4>;
+			#phy-cells = <1>;
+		};
+
 		serdes_ln_ctrl: mux-controller@80 {
 			compatible = "mmio-mux";
 			reg = <0x80 0x10>;
@@ -1039,6 +1045,69 @@ cpts@310d0000 {
 		};
 	};
 
+	main_cpsw: ethernet@c200000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		reg = <0x00 0xc200000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x0 0x0 0x0 0xc200000 0x0 0x200000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		clocks = <&k3_clks 28 28>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 28 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xc640>,
+		       <&main_udmap 0xc641>,
+		       <&main_udmap 0xc642>,
+		       <&main_udmap 0xc643>,
+		       <&main_udmap 0xc644>,
+		       <&main_udmap 0xc645>,
+		       <&main_udmap 0xc646>,
+		       <&main_udmap 0xc647>,
+		       <&main_udmap 0x4640>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				phys = <&phy_gmii_sel_cpsw 1>;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 28 28>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 28 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	usbss0: cdns-usb@4104000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x04104000 0x00 0x100>;
-- 
2.34.1

