Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AB576D5D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHBRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHBRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:46:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D13010C7;
        Wed,  2 Aug 2023 10:45:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372HjOAH057394;
        Wed, 2 Aug 2023 12:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690998324;
        bh=glW8XPVt7oMKxhOeu7i3M3uUMr4N6Y9fptPIL5+joKc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hnCeiSFKYp9VujW8xmGat7eu8mf4tAze74TRTL8F3v4Bx3Ro5xHHpVNfwSabxRr1Z
         DzUUXMbH59CPGpnmF2NRpc2y07ydHKuo/LaiWNouJdMqoWR3uiPWGDSloWx2HpipAJ
         gS2Qb1C3reA1m92pP/2Er7Hiepq/9NTUSwDSiQMY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372HjOGO102357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 12:45:24 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 12:45:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 12:45:24 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372HjN0e027307;
        Wed, 2 Aug 2023 12:45:24 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am64: Merge the two main_conf nodes
Date:   Wed, 2 Aug 2023 12:45:20 -0500
Message-ID: <20230802174521.236255-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802174521.236255-1-afd@ti.com>
References: <20230802174521.236255-1-afd@ti.com>
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

There are two nodes representing the same register space, this looks to
have been created by some merge or copy/paste error. Remove the second
instance of this node and move its children into the first instance.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 42 ++++++++++--------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d3dd8c426dada..e27eb2e585f14 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -44,11 +44,28 @@ main_conf: syscon@43000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x43000000 0x20000>;
 
+		chipid@14 {
+			compatible = "ti,am654-chipid";
+			reg = <0x00000014 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
 		};
+
+		phy_gmii_sel: phy@4044 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4044 0x8>;
+			#phy-cells = <1>;
+		};
+
+		epwm_tbclk: clock@4140 {
+			compatible = "ti,am64-epwm-tbclk";
+			reg = <0x4130 0x4>;
+			#clock-cells = <1>;
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -203,31 +220,6 @@ main_pmx0: pinctrl@f4000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	main_conf: syscon@43000000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x00 0x43000000 0x00 0x20000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x43000000 0x20000>;
-
-		chipid@14 {
-			compatible = "ti,am654-chipid";
-			reg = <0x00000014 0x4>;
-		};
-
-		phy_gmii_sel: phy@4044 {
-			compatible = "ti,am654-phy-gmii-sel";
-			reg = <0x4044 0x8>;
-			#phy-cells = <1>;
-		};
-
-		epwm_tbclk: clock@4140 {
-			compatible = "ti,am64-epwm-tbclk";
-			reg = <0x4130 0x4>;
-			#clock-cells = <1>;
-		};
-	};
-
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
-- 
2.39.2

