Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E007792A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjHKPRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:17:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A082D7F;
        Fri, 11 Aug 2023 08:17:02 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BFGqIm023118;
        Fri, 11 Aug 2023 10:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691767012;
        bh=zaVqdZ0PN88/N4qBEFQ/am+8JFRVJ1v/TxbIXRAGn7I=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=lEQWlvQ6y+zKXWGao58ojhZxveMllgYM/7p/2JSITgQ76T9Yj1BqZbkXsT/TtYeDw
         4dnqRpbi81v62KxePCNFgfTq+1Tyv27ThWi0wij88iQ1jYp4lxvFoeivTXoLv+UwKy
         HWipzPB+1fj9Geazj/kYIbfxc/td2ry/cQIOVIPo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BFGqWJ007482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 10:16:52 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 10:16:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 10:16:52 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BFGicd121323;
        Fri, 11 Aug 2023 10:16:49 -0500
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
Subject: [PATCH v4 1/3] arm64: dts: ti: k3-j784s4: Add phase tags marking
Date:   Fri, 11 Aug 2023 20:46:42 +0530
Message-ID: <20230811151644.3216621-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811151644.3216621-1-a-nandan@ti.com>
References: <20230811151644.3216621-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
That's why add it also to Linux to be aligned with bootloader requirement.

On TI K3 J784S4 SoC, only secure_proxy_mcu and secure_proxy_sa3 nodes are
exclusively used by R5 bootloader, rest of the dts nodes with bootph-* are
used by later boot stages also.

And secure_proxy_mcu and secure_proxy_sa3 are disabled in kernel device
tree, and will be only enabled in R5 bootloader device tree.
So, bootph-pre-ram for secure_proxy_mcu and secure_proxy_sa3 will be
added in R5 bootloader device tree only.

Add bootph-all for all other nodes that are used in the bootloader on
K3 J784S4 SoC, and bootph-pre-ram is not needed specifically for any node
in kernel dts.

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

