Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D276638B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjG1FJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjG1FJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:09:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4AE30C2;
        Thu, 27 Jul 2023 22:09:07 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S592TI089293;
        Fri, 28 Jul 2023 00:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690520942;
        bh=X3x6k1zji9d9U6vqr8s1cUu8um3A871vwUjolziuKI8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QTO9XyFUQcZxPZDEsB4HgPzk90kMqLd4If3KoijOUUYDPH6VwL9N4pPWMAWljiff+
         LjqNri/mGAwphNilDoM5EgG+qWDSohGG8UGqUxg4VMvanw8yJg+uTXUJropIBC2Mcd
         WbJ/4Q1pBfV6b3RB0uiJOuuk/lzqxmDacitB6GBc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S591qj008799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 00:09:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 00:09:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 00:09:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S590BC113567;
        Fri, 28 Jul 2023 00:09:01 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v7 1/4] arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane mux
Date:   Fri, 28 Jul 2023 10:38:56 +0530
Message-ID: <20230728050859.7370-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728050859.7370-1-j-choudhary@ti.com>
References: <20230728050859.7370-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index 11f163e5cadf..8a816563706b 100644
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
+			compatible = "mmio-mux";
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

