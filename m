Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08D7BA358
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjJEPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJEPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:53:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39B16AEF;
        Thu,  5 Oct 2023 08:13:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395FDHSP044789;
        Thu, 5 Oct 2023 10:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696518797;
        bh=b1Dvr4R9HnYlFE02nirGE3AGCpjxT5zBa+4cfDfFjyU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aeSA0m5E/o7sAyQ0bustpyp7df/NBIcdVV5C11+79yCbO2hM2CAuwkMlJaNd6ozyP
         wNEQ7Jr56hTSNcK0JE3dCMYPz23eeEQ6gZFXGfVkzkF91IWC/XpAQ+KV1mZzGmquXy
         VoFfZHUwfF13OMeaKD1CE7CUqDrcj9BO6IQfnYxw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395FDHJ5105410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 10:13:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 10:13:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 10:13:17 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395FD7Pd027216;
        Thu, 5 Oct 2023 10:13:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: ti: k3-*: Convert NAVSS to simple-bus
Date:   Thu, 5 Oct 2023 20:43:02 +0530
Message-ID: <20231005151302.1290363-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005151302.1290363-1-vigneshr@ti.com>
References: <20231005151302.1290363-1-vigneshr@ti.com>
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

"simple-mfd" as standalone compatible is frowned upon, so model main and
MCU NAVSS (Navigator SubSystem) nodes as simple-bus as there is really
no need for these nodes to be MFD.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi         | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index bc460033a37a..d0c85eb3bb04 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -600,7 +600,7 @@ intr_main_gpio: interrupt-controller@a00000 {
 	};
 
 	main_navss: bus@30800000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x0 0x30800000 0x0 0x30800000 0x0 0xbc00000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 1e536dc41f61..edd5cfbec40e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -185,7 +185,7 @@ mcu_timer3: timer@40430000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index cdb1d6b2a982..264913f83287 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -91,7 +91,7 @@ main_gpio_intr: interrupt-controller@a00000 {
 	};
 
 	main_navss: bus@30000000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 6ffaf85fa63f..ef13d64961ef 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -318,7 +318,7 @@ wkup_gpio1: gpio@42100000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index f6c7e1614521..746b9f8b1c64 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -181,7 +181,7 @@ main_gpio_intr: interrupt-controller@a00000 {
 	};
 
 	main_navss: bus@30000000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index fa8af20c7818..f7ab7719fc07 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -440,7 +440,7 @@ adc {
 	};
 
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 6d32544c8881..bbb4b7f81039 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -775,7 +775,7 @@ main_sdhci1: mmc@4fb0000 {
 	};
 
 	main_navss: bus@30000000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 56504578c464..20a6a35ad61a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -443,7 +443,7 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
-- 
2.42.0

