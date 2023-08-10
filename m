Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D877808C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjHJSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjHJSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:43:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC732719;
        Thu, 10 Aug 2023 11:43:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIhAlL130401;
        Thu, 10 Aug 2023 13:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691692990;
        bh=G/Ilz1BwP64dns4t4KrEEVpriH9lFWJB8XpQO40AeS4=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=gXzIhtIouURysfiD0q4yiNca/yZEDN963kaFMseijbN+HWGKPjV2vl1J/TZbWl54y
         teEbeRodf6+mwl6abJZ0IKnSas2h6qQq7P/TEKEy0GDxXtNejx+5SXgt3rHTyIkRxD
         eKsRt7hqihTl+Z/Ys7PtK0LsdhdiL8CFv1tIRPak=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIhAvt031723
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:43:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:43:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:43:09 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIh2P0025724;
        Thu, 10 Aug 2023 13:43:06 -0500
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
Subject: [PATCH v3 1/3] arm64: dts: ti: k3-j784s4: Add bootph-all property
Date:   Fri, 11 Aug 2023 00:13:00 +0530
Message-ID: <20230810184302.3097829-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810184302.3097829-1-a-nandan@ti.com>
References: <20230810184302.3097829-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all phase tag was added to dt-schema (dtschema/schemas/bootph.yaml)
to overcome u-boot dts challenges.

Add bootph-all property for all the nodes that are also used in SPL stage
along with later boot stages.

These bootph-all properties will be synced later to u-boot j784s4 dts.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 2 ++
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 9 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi            | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a04c44708a09..65eca0990300 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -670,6 +670,7 @@ main_sdhci1: mmc@4fb0000 {
 	};
 
 	main_navss: bus@30000000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -705,6 +706,7 @@ main_udmass_inta: msi-controller@33d00000 {
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
+			bootph-all;
 			compatible = "ti,am654-secure-proxy";
 			#mbox-cells = <1>;
 			reg-names = "target_data", "rt", "scfg";
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 740ee794d7b9..a394bef093b6 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -7,6 +7,7 @@
 
 &cbass_mcu_wakeup {
 	sms: system-controller@44083000 {
+		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 
@@ -19,22 +20,26 @@ sms: system-controller@44083000 {
 		reg = <0x00 0x44083000 0x00 0x1000>;
 
 		k3_pds: power-controller {
+			bootph-all;
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
 		};
 
 		k3_clks: clock-controller {
+			bootph-all;
 			compatible = "ti,k2g-sci-clk";
 			#clock-cells = <2>;
 		};
 
 		k3_reset: reset-controller {
+			bootph-all;
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
 	};
 
 	chipid@43000014 {
+		bootph-all;
 		compatible = "ti,am654-chipid";
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
@@ -161,6 +166,7 @@ mcu_timer0: timer@40400000 {
 	};
 
 	mcu_timer1: timer@40410000 {
+		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x40410000 0x00 0x400>;
 		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
@@ -442,6 +448,7 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -451,6 +458,7 @@ mcu_navss: bus@28380000 {
 		dma-ranges;
 
 		mcu_ringacc: ringacc@2b800000 {
+			bootph-all;
 			compatible = "ti,am654-navss-ringacc";
 			reg = <0x00 0x2b800000 0x00 0x400000>,
 			      <0x00 0x2b000000 0x00 0x400000>,
@@ -465,6 +473,7 @@ mcu_ringacc: ringacc@2b800000 {
 		};
 
 		mcu_udmap: dma-controller@285c0000 {
+			bootph-all;
 			compatible = "ti,j721e-navss-mcu-udmap";
 			reg = <0x00 0x285c0000 0x00 0x100>,
 			      <0x00 0x2a800000 0x00 0x40000>,
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 8b5974d92e33..4398c3a463e1 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -228,6 +228,7 @@ pmu: pmu {
 	};
 
 	cbass_main: bus@100000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -263,6 +264,7 @@ cbass_main: bus@100000 {
 			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
 
 		cbass_mcu_wakeup: bus@28380000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.34.1

