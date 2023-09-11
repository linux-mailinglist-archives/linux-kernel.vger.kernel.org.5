Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E079B730
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349531AbjIKVdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbjIKQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:25:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EFCCA;
        Mon, 11 Sep 2023 09:25:50 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPeKB083440;
        Mon, 11 Sep 2023 11:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694449540;
        bh=xXNNi9ecgv9n4lP0nkXFlMFa2mNAsjzCTU9VoQct/FE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VTI4bWQBA/DjcNP4McbwHGzxW5LB6s8OXC1gJWlvyLhCNldrWAdvJeXgxJybfUWAJ
         jUKC/zTKgXSfRSG3cNpFKXmh37SJV4lfn7uIKjqhXkIjtaCme96iJskcKMbWneIVdU
         TQyy4FKuj3nntkrNwWnIiYhfg4eWru7ktYjnEqdE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BGPeN7022338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 11:25:40 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 11:25:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 11:25:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPeo8012541;
        Mon, 11 Sep 2023 11:25:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vignesh <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
        Praneeth <praneeth@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am625: Add boot phase tags marking
Date:   Mon, 11 Sep 2023 11:25:33 -0500
Message-ID: <20230911162535.1044560-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911162535.1044560-1-nm@ti.com>
References: <20230911162535.1044560-1-nm@ti.com>
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

On TI K3 AM625 SoC, only secure_proxy_sa3 and esm nodes are
exclusively used by R5 bootloader, rest of the dts nodes with bootph-* are
used by later boot stages also.

Add bootph-all for all other nodes that are used in the bootloader on
K3 AM625 SoC, and bootph-pre-ram is not needed specifically for any
other node in kernel dts.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  2 ++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  2 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi        |  3 +++
 4 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 284b90c94da8..ac760d9b831d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -81,6 +81,7 @@ audio_refclk1: clock-controller@82e4 {
 	};
 
 	dmss: bus@48000000 {
+		bootph-all;
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -90,6 +91,7 @@ dmss: bus@48000000 {
 		ti,sci-dev-id = <25>;
 
 		secure_proxy_main: mailbox@4d000000 {
+			bootph-all;
 			compatible = "ti,am654-secure-proxy";
 			#mbox-cells = <1>;
 			reg-names = "target_data", "rt", "scfg";
@@ -165,6 +167,7 @@ main_pktdma: dma-controller@485c0000 {
 	};
 
 	dmsc: system-controller@44043000 {
+		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
@@ -174,16 +177,19 @@ dmsc: system-controller@44043000 {
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
@@ -202,6 +208,7 @@ crypto: crypto@40900000 {
 	};
 
 	secure_proxy_sa3: mailbox@43600000 {
+		bootph-pre-ram;
 		compatible = "ti,am654-secure-proxy";
 		#mbox-cells = <1>;
 		reg-names = "target_data", "rt", "scfg";
@@ -217,6 +224,7 @@ secure_proxy_sa3: mailbox@43600000 {
 	};
 
 	main_pmx0: pinctrl@f4000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2ac>;
 		#pinctrl-cells = <1>;
@@ -225,12 +233,14 @@ main_pmx0: pinctrl@f4000 {
 	};
 
 	main_esm: esm@420000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
 		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
 	};
 
 	main_timer0: timer@2400000 {
+		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 80a3e1db26a9..0e0b234581c6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -7,6 +7,7 @@
 
 &cbass_mcu {
 	mcu_pmx0: pinctrl@4084000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0x04084000 0x00 0x88>;
 		#pinctrl-cells = <1>;
@@ -15,6 +16,7 @@ mcu_pmx0: pinctrl@4084000 {
 	};
 
 	mcu_esm: esm@4100000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
 		ti,esm-pins = <0>, <1>, <2>, <85>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index eae052887186..fef76f52a52e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -7,6 +7,7 @@
 
 &cbass_wakeup {
 	wkup_conf: syscon@43000000 {
+		bootph-all;
 		compatible = "syscon", "simple-mfd";
 		reg = <0x00 0x43000000 0x00 0x20000>;
 		#address-cells = <1>;
@@ -14,6 +15,7 @@ wkup_conf: syscon@43000000 {
 		ranges = <0x0 0x00 0x43000000 0x20000>;
 
 		chipid: chipid@14 {
+			bootph-all;
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 11f14eef2d44..f1e15206e1ce 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -47,6 +47,7 @@ pmu: pmu {
 	};
 
 	cbass_main: bus@f0000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -86,6 +87,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 
 		cbass_mcu: bus@4000000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -93,6 +95,7 @@ cbass_mcu: bus@4000000 {
 		};
 
 		cbass_wakeup: bus@b00000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.40.0

