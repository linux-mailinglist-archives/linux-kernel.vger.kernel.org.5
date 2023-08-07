Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75807772E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHGS5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjHGS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:57:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAADD172B;
        Mon,  7 Aug 2023 11:57:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377Iuvb7096332;
        Mon, 7 Aug 2023 13:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691434617;
        bh=xTf7ByXT/SyhX5YSoojCsqsftDwf0m9H3lr7P14WUsk=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=EBPycwYn0ouIxyeEJl5PaVUkRJxDOWULqeblRbxFBj5hEOF1rEfbCSsSkLhg12Usx
         kN4dNlOjxEgMvhGVbjoeOZD9/tttZs6GcppHHSg8lcWr8OdeDLl2807G65pYyTTc9E
         L7KKzuHhzBV3QYFlyrTghRuJ/r4BVnD23+wssMfc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377IuvJK111476
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 13:56:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 13:56:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 13:56:57 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Iuj1s013364;
        Mon, 7 Aug 2023 13:56:54 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add bootph-pre-ram property for SPL nodes
Date:   Tue, 8 Aug 2023 00:26:43 +0530
Message-ID: <20230807185645.128751-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807185645.128751-1-a-nandan@ti.com>
References: <20230807185645.128751-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bootph-pre-ram property for all the nodes used in SPL stage,
for syncing it later to u-boot j784s4 dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 657fb1d72512..521d3cfd10c4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -6,7 +6,9 @@
  */
 
 &cbass_mcu_wakeup {
+	bootph-pre-ram;
 	sms: system-controller@44083000 {
+		bootph-pre-ram;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 
@@ -19,22 +21,26 @@ sms: system-controller@44083000 {
 		reg = <0x00 0x44083000 0x00 0x1000>;
 
 		k3_pds: power-controller {
+			bootph-pre-ram;
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
 		};
 
 		k3_clks: clock-controller {
+			bootph-pre-ram;
 			compatible = "ti,k2g-sci-clk";
 			#clock-cells = <2>;
 		};
 
 		k3_reset: reset-controller {
+			bootph-pre-ram;
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
 	};
 
 	chipid@43000014 {
+		bootph-pre-ram;
 		compatible = "ti,am654-chipid";
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
@@ -161,6 +167,7 @@ mcu_timer0: timer@40400000 {
 	};
 
 	mcu_timer1: timer@40410000 {
+		bootph-pre-ram;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x40410000 0x00 0x400>;
 		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
@@ -442,6 +449,7 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000{
+		bootph-pre-ram;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -451,6 +459,7 @@ mcu_navss: bus@28380000{
 		dma-ranges;
 
 		mcu_ringacc: ringacc@2b800000 {
+			bootph-pre-ram;
 			compatible = "ti,am654-navss-ringacc";
 			reg = <0x00 0x2b800000 0x00 0x400000>,
 			      <0x00 0x2b000000 0x00 0x400000>,
@@ -465,6 +474,7 @@ mcu_ringacc: ringacc@2b800000 {
 		};
 
 		mcu_udmap: dma-controller@285c0000 {
+			bootph-pre-ram;
 			compatible = "ti,j721e-navss-mcu-udmap";
 			reg = <0x00 0x285c0000 0x00 0x100>,
 			      <0x00 0x2a800000 0x00 0x40000>,
-- 
2.34.1

