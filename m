Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540C076638F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjG1FJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjG1FJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:09:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB02D76;
        Thu, 27 Jul 2023 22:09:16 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S594i1097489;
        Fri, 28 Jul 2023 00:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690520944;
        bh=egh5GPFfU9rEvZZQyh2CAG1QHOlEyhHWchPte61+9P8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JoXfJVWcduBiIvGYpQ3dCO0sUR6iaWBQqfiJbllfLiYif3aLMGJP7esTmVJgUwPyd
         Emgb0R9XooAx2NwYLJGddbKBYckrXSiPb2TIyeZbsoQt5zkfZycrmvp4sqKdca3Ax5
         Of5hAV5ZotLobfT/9SgVKDB//ugNdIJt4qjHdQ+4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S594YJ008877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 00:09:04 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 00:09:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 00:09:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S593L9128758;
        Fri, 28 Jul 2023 00:09:04 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v7 3/4] arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
Date:   Fri, 28 Jul 2023 10:38:58 +0530
Message-ID: <20230728050859.7370-4-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728050859.7370-1-j-choudhary@ti.com>
References: <20230728050859.7370-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul T R <r-ravikumar@ti.com>

Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
same as DSS IP in J721E, so same compatible is being used.
The DP is Cadence MHDP8546.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
[j-choudhary@ti.com: move dss & mhdp node together in main, fix dss node]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index fbf5ab94d785..975661948755 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1749,4 +1749,77 @@ c71_3: dsp@67800000 {
 		resets = <&k3_reset 40 1>;
 		firmware-name = "j784s4-c71_3-fw";
 	};
+
+	mhdp: dp-bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+
+		reg = <0x0 0xa000000 0x0 0x30a00>,
+		      <0x0 0x4f40000 0x0 0x20>;
+		reg-names = "mhdptx", "j721e-intg";
+
+		clocks = <&k3_clks 217 11>;
+
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
+
+		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+
+		status = "disabled";
+
+		dp0_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	dss: dss@4a00000 {
+		compatible = "ti,j721e-dss";
+		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
+		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
+		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
+		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
+		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
+		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
+		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
+		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
+		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
+		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
+		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
+		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
+		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04aa0000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04ac0000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
+		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
+
+		reg-names = "common_m", "common_s0",
+			    "common_s1", "common_s2",
+			    "vidl1", "vidl2","vid1","vid2",
+			    "ovr1", "ovr2", "ovr3", "ovr4",
+			    "vp1", "vp2", "vp3", "vp4",
+			    "wb";
+
+		clocks = <&k3_clks 218 0>,
+			 <&k3_clks 218 2>,
+			 <&k3_clks 218 5>,
+			 <&k3_clks 218 14>,
+			 <&k3_clks 218 18>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+
+		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+
+		status = "disabled";
+
+		dss_ports: ports {
+		};
+	};
 };
-- 
2.25.1

