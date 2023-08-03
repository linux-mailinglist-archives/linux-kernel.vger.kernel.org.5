Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518576E2EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHCIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjHCIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:24:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE2F7D99;
        Thu,  3 Aug 2023 01:18:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3738I43p112785;
        Thu, 3 Aug 2023 03:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691050684;
        bh=mGTl9vsr+g3bdslJ/fVBdF1Bo2OFJs7c0FPRKliJD5w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZucIrd8/miOHGpWjNOVRNih+XEKXUaqTMcz1bvItb7UlkgnJPWgRRGV75LKzjUsao
         ge4MmmfkBe07UjSGtfrZEG0p6v3FPg3PDKQh55R0jfpOnBTWyTO/Q/GBExg5oIuwPa
         SqUCdfGQqLP0fljG2ELfPTCs97GYoxT0uECU3ayY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3738I4WN080171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 03:18:04 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 03:18:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 03:18:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3738I2Ts008918;
        Thu, 3 Aug 2023 03:18:03 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721s2-main: Add DSS node
Date:   Thu, 3 Aug 2023 13:47:59 +0530
Message-ID: <20230803081800.368582-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803081800.368582-1-j-choudhary@ti.com>
References: <20230803081800.368582-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DSS node for J721S2 SoC. DSS IP in J721S2 is
same as DSS IP in J721E, so same compatible is used.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ed79ab3a3271..3b14b188a6ed 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1507,4 +1507,50 @@ main_spi7: spi@2170000 {
 		clocks = <&k3_clks 346 1>;
 		status = "disabled";
 	};
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
+		      <0x00 0x04aa0000 0x00 0x10000>, /* vp2 */
+		      <0x00 0x04ac0000 0x00 0x10000>, /* vp3 */
+		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
+		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
+		reg-names = "common_m", "common_s0",
+			    "common_s1", "common_s2",
+			    "vidl1", "vidl2","vid1","vid2",
+			    "ovr1", "ovr2", "ovr3", "ovr4",
+			    "vp1", "vp2", "vp3", "vp4",
+			    "wb";
+		clocks = <&k3_clks 158 0>,
+			 <&k3_clks 158 2>,
+			 <&k3_clks 158 5>,
+			 <&k3_clks 158 14>,
+			 <&k3_clks 158 18>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+		status = "disabled";
+
+		dss_ports: ports {
+		};
+	};
 };
-- 
2.25.1

