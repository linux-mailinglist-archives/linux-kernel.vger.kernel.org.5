Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCA79B44A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjIKWWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbjIKR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:29:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B24189;
        Mon, 11 Sep 2023 10:29:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3PV082643;
        Mon, 11 Sep 2023 12:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694453343;
        bh=PVQPaRp5IlzLcS2dTVXIMLqYtvoC7+GRQ7NX6AOEpAw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Yee2TpbU3ox5yEBjLBgZPoDZS2NNJWrvxLZOAN25pHxycm6ndEJBnlvdEPDctXP8j
         zuGoYp/twkC1DKvuNaYvPJkVHoOnzDh8piBPMdTdDgLsNnGSjTABq8nlhlEhtkbyEm
         IyiMrCBQkMMW/T5KQojwa4YNA45/T33vJyVeyJaQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BHT3Tp065690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 12:29:03 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 12:29:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 12:29:03 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3aN109063;
        Mon, 11 Sep 2023 12:29:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vignesh <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
        Praneeth <praneeth@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am64: Add phase tags marking
Date:   Mon, 11 Sep 2023 12:29:00 -0500
Message-ID: <20230911172902.1057417-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911172902.1057417-1-nm@ti.com>
References: <20230911172902.1057417-1-nm@ti.com>
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

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to describe various node usage during
boot phases with DT.

On TI K3 AM642 SoC, only esm nodes are exclusively used by R5
bootloader, rest of the dts nodes with bootph-* are used by later boot
stages also.

Add bootph-all for all other nodes that are used in the bootloader on
K3 AM642 SoC, and bootph-pre-ram is not needed specifically for any
other node in kernel dts.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  2 ++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0df54a741824..1933c9dd1d9f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -38,6 +38,7 @@ sproxy-sram@1fc000 {
 	};
 
 	main_conf: syscon@43000000 {
+		bootph-all;
 		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
 		reg = <0x0 0x43000000 0x0 0x20000>;
 		#address-cells = <1>;
@@ -45,6 +46,7 @@ main_conf: syscon@43000000 {
 		ranges = <0x0 0x0 0x43000000 0x20000>;
 
 		chipid@14 {
+			bootph-all;
 			compatible = "ti,am654-chipid";
 			reg = <0x00000014 0x4>;
 		};
@@ -96,6 +98,7 @@ gic_its: msi-controller@1820000 {
 	};
 
 	dmss: bus@48000000 {
+		bootph-all;
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -105,6 +108,7 @@ dmss: bus@48000000 {
 		ti,sci-dev-id = <25>;
 
 		secure_proxy_main: mailbox@4d000000 {
+			bootph-all;
 			compatible = "ti,am654-secure-proxy";
 			#mbox-cells = <1>;
 			reg-names = "target_data", "rt", "scfg";
@@ -188,6 +192,7 @@ main_pktdma: dma-controller@485c0000 {
 	};
 
 	dmsc: system-controller@44043000 {
+		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
@@ -197,22 +202,26 @@ dmsc: system-controller@44043000 {
 		reg = <0x00 0x44043000 0x00 0xfe0>;
 
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
 
 	main_pmx0: pinctrl@f4000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2d0>;
 		#pinctrl-cells = <1>;
@@ -221,6 +230,7 @@ main_pmx0: pinctrl@f4000 {
 	};
 
 	main_timer0: timer@2400000 {
+		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -365,6 +375,7 @@ main_timer11: timer@24b0000 {
 	};
 
 	main_esm: esm@420000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
 		ti,esm-pins = <160>, <161>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 686d49790721..b9508072bebb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -146,6 +146,7 @@ mcu_gpio0: gpio@4201000 {
 	};
 
 	mcu_pmx0: pinctrl@4084000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0x4084000 0x00 0x84>;
 		#pinctrl-cells = <1>;
@@ -154,6 +155,7 @@ mcu_pmx0: pinctrl@4084000 {
 	};
 
 	mcu_esm: esm@4100000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
 		ti,esm-pins = <0>, <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 8e9c2bc70f4d..0187c42aed4f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -47,6 +47,7 @@ pmu: pmu {
 	};
 
 	cbass_main: bus@f4000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -85,6 +86,7 @@ cbass_main: bus@f4000 {
 			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
 
 		cbass_mcu: bus@4000000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.40.0

