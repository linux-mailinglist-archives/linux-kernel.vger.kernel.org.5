Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21C75FB01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGXPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGXPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:39:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760D10E4;
        Mon, 24 Jul 2023 08:39:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OFdEnT105756;
        Mon, 24 Jul 2023 10:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690213154;
        bh=IwnS8WMnRIgOiB352WjcFBOFkWVWnNv59QMzPWERN4k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CukYjg1PyxRGt6/BG5hdKQHEPPeGDIkcnM4vB0A0mW93f1e7OWa514sC/73aE6Ntq
         u9AtXrHj8j+QZxwHfgvlNCH84KgzipSsKIiP9bKX6vNIPlQuUXLupQN71WxmH5g6EY
         gmJinCRF256FToYSljbJcqXqJR59wU7MGjAIGAHw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OFdEOE049951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 10:39:14 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 10:39:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 10:39:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OFdDLr050297;
        Mon, 24 Jul 2023 10:39:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/5] arm: dts: ti: omap: Fix OPP table node names
Date:   Mon, 24 Jul 2023 10:39:09 -0500
Message-ID: <20230724153911.1376830-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230724153911.1376830-1-nm@ti.com>
References: <20230724153911.1376830-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the opp table node names for opps to be compliant with bindings.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Should probably go via Tony's tree.

 .../arm/boot/dts/ti/omap/am335x-boneblack.dts |  3 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  3 +-
 arch/arm/boot/dts/ti/omap/am33xx.dtsi         | 30 ++++++++++++-------
 arch/arm/boot/dts/ti/omap/am3517.dtsi         |  6 ++--
 arch/arm/boot/dts/ti/omap/am4372.dtsi         | 15 ++++++----
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts  |  6 ++--
 arch/arm/boot/dts/ti/omap/dra7.dtsi           |  9 ++++--
 arch/arm/boot/dts/ti/omap/dra76x.dtsi         |  3 +-
 arch/arm/boot/dts/ti/omap/omap34xx.dtsi       | 12 ++++----
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi       | 12 +++++---
 10 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
index b956e2f60fe0..16b567e3cb47 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
@@ -20,7 +20,8 @@ &cpu0_opp_table {
 	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
 	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
 	 */
-	oppnitro-1000000000 {
+	opp-1000000000 {
+		/* OPP Nitro */
 		opp-supported-hw = <0x06 0x0100>;
 	};
 };
diff --git a/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
index 9863bf499a39..93a3af83feac 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
@@ -28,7 +28,8 @@ &cpu0_opp_table {
 	* the HW OPP table, the silicon looks like it is Revision 1.0 (ie the
 	* EFUSE_SMA register reads as all zeros).
 	*/
-	oppnitro-1000000000 {
+	opp-1000000000 {
+		/* OPP Nitro */
 		opp-supported-hw = <0x06 0x0100>;
 	};
 };
diff --git a/arch/arm/boot/dts/ti/omap/am33xx.dtsi b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
index 32d397b3950b..1a2cd5baf402 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
@@ -80,64 +80,74 @@ cpu0_opp_table: opp-table {
 		 * because the can not be enabled simultaneously on a
 		 * single SoC.
 		 */
-		opp50-300000000 {
+		opp-50-300000000{
+			/* OPP50 */
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <950000 931000 969000>;
 			opp-supported-hw = <0x06 0x0010>;
 			opp-suspend;
 		};
 
-		opp100-275000000 {
+		opp-100-275000000{
+			/* OPP100-1 */
 			opp-hz = /bits/ 64 <275000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x01 0x00FF>;
 			opp-suspend;
 		};
 
-		opp100-300000000 {
+		opp-100-300000000{
+			/* OPP100-2 */
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x06 0x0020>;
 			opp-suspend;
 		};
 
-		opp100-500000000 {
+		opp-100-500000000{
+			/* OPP100-3 */
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x01 0xFFFF>;
 		};
 
-		opp100-600000000 {
+		opp-100-600000000 {
+			/* OPP100-4 */
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x06 0x0040>;
 		};
 
-		opp120-600000000 {
+		opp-120-600000000 {
+			/* OPP120-1 */
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1200000 1176000 1224000>;
 			opp-supported-hw = <0x01 0xFFFF>;
 		};
 
-		opp120-720000000 {
+		opp-120-720000000 {
+			/* OPP120-2 */
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1200000 1176000 1224000>;
 			opp-supported-hw = <0x06 0x0080>;
 		};
 
-		oppturbo-720000000 {
+		opp-720000000 {
+			/* OPP Turbo-1 */
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
 			opp-supported-hw = <0x01 0xFFFF>;
 		};
 
-		oppturbo-800000000 {
+		opp-800000000 {
+			/* OPP Turbo-2 */
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
 			opp-supported-hw = <0x06 0x0100>;
 		};
 
-		oppnitro-1000000000 {
+		opp-1000000000 {
+			/* OPP Nitro */
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1325000 1298500 1351500>;
 			opp-supported-hw = <0x04 0x0200>;
diff --git a/arch/arm/boot/dts/ti/omap/am3517.dtsi b/arch/arm/boot/dts/ti/omap/am3517.dtsi
index 823f63502e9f..fbfc956f4e4d 100644
--- a/arch/arm/boot/dts/ti/omap/am3517.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am3517.dtsi
@@ -34,14 +34,16 @@ cpu0_opp_table: opp-table {
 		 * appear to operate at 300MHz as well. Since AM3517 only
 		 * lists one operating voltage, it will remain fixed at 1.2V
 		 */
-		opp50-300000000 {
+		opp-50-300000000 {
+			/* OPP50 */
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1200000>;
 			opp-supported-hw = <0xffffffff 0xffffffff>;
 			opp-suspend;
 		};
 
-		opp100-600000000 {
+		opp-100-600000000 {
+			/* OPP100 */
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1200000>;
 			opp-supported-hw = <0xffffffff 0xffffffff>;
diff --git a/arch/arm/boot/dts/ti/omap/am4372.dtsi b/arch/arm/boot/dts/ti/omap/am4372.dtsi
index 8613355bbd5e..9d2c064534f7 100644
--- a/arch/arm/boot/dts/ti/omap/am4372.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am4372.dtsi
@@ -70,32 +70,37 @@ cpu0_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		syscon = <&scm_conf>;
 
-		opp50-300000000 {
+		opp-50-300000000 {
+			/* OPP50 */
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <950000 931000 969000>;
 			opp-supported-hw = <0xFF 0x01>;
 			opp-suspend;
 		};
 
-		opp100-600000000 {
+		opp-100-600000000 {
+			/* OPP100 */
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0xFF 0x04>;
 		};
 
-		opp120-720000000 {
+		opp-120-720000000 {
+			/* OPP120 */
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1200000 1176000 1224000>;
 			opp-supported-hw = <0xFF 0x08>;
 		};
 
-		oppturbo-800000000 {
+		opp-800000000{
+			/* OPP Turbo */
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
 			opp-supported-hw = <0xFF 0x10>;
 		};
 
-		oppnitro-1000000000 {
+		opp-1000000000 {
+			/* OPP Nitro */
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1325000 1298500 1351500>;
 			opp-supported-hw = <0xFF 0x20>;
diff --git a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
index 863552393c07..5b2ac88a7e6a 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
@@ -527,11 +527,13 @@ &cpu0_opp_table {
 	 * Supply voltage supervisor on board will not allow opp50 so
 	 * disable it and set opp100 as suspend OPP.
 	 */
-	opp50-300000000 {
+	opp-50-300000000 {
+		/* opp50-300000000 */
 		status = "disabled";
 	};
 
-	opp100-600000000 {
+	opp-100-600000000 {
+		/* opp100-600000000 */
 		opp-suspend;
 	};
 };
diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
index 97ce0c4f1df7..3f3e52e3b375 100644
--- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
@@ -101,7 +101,8 @@ cpu0_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		syscon = <&scm_wkup>;
 
-		opp_nom-1000000000 {
+		opp-1000000000 {
+			/* OPP NOM */
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1060000 850000 1150000>,
 					<1060000 850000 1150000>;
@@ -109,7 +110,8 @@ opp_nom-1000000000 {
 			opp-suspend;
 		};
 
-		opp_od-1176000000 {
+		opp-1176000000 {
+			/* OPP OD */
 			opp-hz = /bits/ 64 <1176000000>;
 			opp-microvolt = <1160000 885000 1160000>,
 					<1160000 885000 1160000>;
@@ -117,7 +119,8 @@ opp_od-1176000000 {
 			opp-supported-hw = <0xFF 0x02>;
 		};
 
-		opp_high@1500000000 {
+		opp-1500000000 {
+			/* OPP High */
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1210000 950000 1250000>,
 					<1210000 950000 1250000>;
diff --git a/arch/arm/boot/dts/ti/omap/dra76x.dtsi b/arch/arm/boot/dts/ti/omap/dra76x.dtsi
index 931db7932c11..1045eb24aa0d 100644
--- a/arch/arm/boot/dts/ti/omap/dra76x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra76x.dtsi
@@ -130,7 +130,8 @@ &mmc3 {
 };
 
 &cpu0_opp_table {
-	opp_plus@1800000000 {
+	opp-1800000000 {
+		/* OPP Plus */
 		opp-hz = /bits/ 64 <1800000000>;
 		opp-microvolt = <1250000 950000 1250000>,
 				<1250000 950000 1250000>;
diff --git a/arch/arm/boot/dts/ti/omap/omap34xx.dtsi b/arch/arm/boot/dts/ti/omap/omap34xx.dtsi
index 9dbf62797f0f..fc7233ac183a 100644
--- a/arch/arm/boot/dts/ti/omap/omap34xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap34xx.dtsi
@@ -25,7 +25,7 @@ cpu0_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		syscon = <&scm_conf>;
 
-		opp1-125000000 {
+		opp-125000000 {
 			opp-hz = /bits/ 64 <125000000>;
 			/*
 			 * we currently only select the max voltage from table
@@ -40,32 +40,32 @@ opp1-125000000 {
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
-		opp2-250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			opp-microvolt = <1075000 1075000 1075000>;
 			opp-supported-hw = <0xffffffff 3>;
 			opp-suspend;
 		};
 
-		opp3-500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <1200000 1200000 1200000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
-		opp4-550000000 {
+		opp-550000000 {
 			opp-hz = /bits/ 64 <550000000>;
 			opp-microvolt = <1275000 1275000 1275000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
-		opp5-600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1350000 1350000 1350000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
-		opp6-720000000 {
+		opp-720000000 {
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1350000 1350000 1350000>;
 			/* only high-speed grade omap3530 devices */
diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
index 50e640a32b5c..e6d8070c1bf8 100644
--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -30,7 +30,8 @@ cpu0_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		syscon = <&scm_conf>;
 
-		opp50-300000000 {
+		opp-50-300000000 {
+			/* OPP50 */
 			opp-hz = /bits/ 64 <300000000>;
 			/*
 			 * we currently only select the max voltage from table
@@ -48,21 +49,24 @@ opp50-300000000 {
 			opp-suspend;
 		};
 
-		opp100-600000000 {
+		opp-100-600000000 {
+			/* OPP100 */
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1200000 1200000 1200000>,
 					 <1200000 1200000 1200000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
-		opp130-800000000 {
+		opp-130-800000000 {
+			/* OPP130 */
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1325000 1325000 1325000>,
 					 <1325000 1325000 1325000>;
 			opp-supported-hw = <0xffffffff 3>;
 		};
 
-		opp1g-1000000000 {
+		opp-1000000000 {
+			/* OPP1G */
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1375000 1375000 1375000>,
 					 <1375000 1375000 1375000>;
-- 
2.40.0

