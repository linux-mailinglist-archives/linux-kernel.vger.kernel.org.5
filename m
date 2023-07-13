Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30271752A73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjGMSsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGMSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:48:12 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED22D60;
        Thu, 13 Jul 2023 11:48:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIm0vd020271;
        Thu, 13 Jul 2023 13:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274080;
        bh=b2QaefHcNlxOonhFM5a+7hs2oTXj01jZJL4r4YLiLmM=;
        h=From:To:CC:Subject:Date;
        b=xGpUFcCwAoR+lgWoUEz7Ss0kBiSQjUYDHs38x4NI8kutzXSrFBWMFtZe5r6qtgHbA
         stIHG0P/pTVolEddkZjnWv0idNELH2iykIvoV9OOHpgUmoK4z0nbSDPq2aZj5ya21q
         bvB941gIdkI/ff9leTkaHfOSncAesLoahkok/8Os=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIm0gP107148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:48:00 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:48:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:47:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIlxLQ003475;
        Thu, 13 Jul 2023 13:47:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: Fix compatible of ti,*-ehrpwm-tbclk
Date:   Thu, 13 Jul 2023 13:47:59 -0500
Message-ID: <20230713184759.3336536-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

TI EHRPWM compatible is just ti,*-ehrpwm-tbclk without needing a
syscon compatibility.

Fixes the following dtbs_check warnings:
 compatible: [''ti,am654-ehrpwm-tbclk, 'syscon'] is too long
 compatible: ['ti,am64-epwm-tbclk', 'syscon'] is too long
 compatible: ['ti,am62-epwm-tbclk', 'syscon'] is too long

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on next-20230713
Full list of warnings squashed is a bit long.. but
https://gist.github.com/nmenon/5182ac2165297d5b07e2483d5f020e0c is the
delta.

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 4a1dab9e40a0..5cea46be40f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -56,7 +56,7 @@ phy_gmii_sel: phy@4044 {
 		};
 
 		epwm_tbclk: clock@4130 {
-			compatible = "ti,am62-epwm-tbclk", "syscon";
+			compatible = "ti,am62-epwm-tbclk";
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index a57ea7130ca3..d3dd8c426dad 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -222,7 +222,7 @@ phy_gmii_sel: phy@4044 {
 		};
 
 		epwm_tbclk: clock@4140 {
-			compatible = "ti,am64-epwm-tbclk", "syscon";
+			compatible = "ti,am64-epwm-tbclk";
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 791c6b38993d..350beddc3d3c 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -503,7 +503,7 @@ dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
 		};
 
 		ehrpwm_tbclk: clock@4140 {
-			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			compatible = "ti,am654-ehrpwm-tbclk";
 			reg = <0x4140 0x18>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 575435c1a984..6c9fe28b6de7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -76,7 +76,7 @@ usb_serdes_mux: mux-controller@4000 {
 		};
 
 		ehrpwm_tbclk: clock-controller@4140 {
-			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			compatible = "ti,am654-ehrpwm-tbclk";
 			reg = <0x4140 0x18>;
 			#clock-cells = <1>;
 		};
-- 
2.40.0

