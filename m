Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425BA7BA2FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjJEPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJEPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:49:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44C7EC7;
        Thu,  5 Oct 2023 08:08:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395DRahZ020813;
        Thu, 5 Oct 2023 08:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696512456;
        bh=57mCXwxyotaHUWw5CpiJYMffjaQKYYAlBsulxLdV9xk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J26fgyARoaXZP8uoeO5UcciIyHvE78oCcBDk0A5u3ESoBFq+bPI0S0WM2llwUKlOa
         8LcUibaPzoi38se22Z3HguKEjOTahvMbqlUCsLWsfdyws7L0fi0g6nhKWG0m1Kgmgi
         oAWZwPnPYD+U69MWJsXDCc6uPQVD8I+K08FPBxrQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395DRa8i050431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 08:27:36 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 08:27:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 08:27:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395DRYTb126658;
        Thu, 5 Oct 2023 08:27:35 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>
CC:     <afd@ti.com>, <rogerq@kernel.org>, <s-vadapalli@ti.com>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH RESEND v11 1/5] arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane mux
Date:   Thu, 5 Oct 2023 18:57:28 +0530
Message-ID: <20231005132732.7462-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005132732.7462-1-j-choudhary@ti.com>
References: <20231005132732.7462-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddharth Vadapalli <s-vadapalli@ti.com>

The system controller node manages the CTRL_MMR0 region.
Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[j-choudhary@ti.com: Fix serdes_ln_ctrl node]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index efed2d683f63..6d9a5a91fa75 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -5,6 +5,10 @@
  * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/mux/mux.h>
+
+#include "k3-serdes.h"
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -26,6 +30,42 @@ l3cache-sram@200000 {
 		};
 	};
 
+	scm_conf: bus@100000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x00100000 0x00 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00100000 0x1c000>;
+
+		serdes_ln_ctrl: mux-controller@4080 {
+			compatible = "reg-mux";
+			reg = <0x00004080 0x30>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
+					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
+					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
+					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
+					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
+			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
+				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
+				      <J784S4_SERDES0_LANE3_USB>,
+				      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,
+				      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+				      <J784S4_SERDES1_LANE2_PCIE0_LANE2>,
+				      <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+				      <J784S4_SERDES2_LANE0_IP2_UNUSED>,
+				      <J784S4_SERDES2_LANE1_IP2_UNUSED>,
+				      <J784S4_SERDES2_LANE2_QSGMII_LANE1>,
+				      <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
+				      <J784S4_SERDES4_LANE0_EDP_LANE0>,
+				      <J784S4_SERDES4_LANE1_EDP_LANE1>,
+				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
+				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
-- 
2.25.1

