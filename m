Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7775778864D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbjHYLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243641AbjHYLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:46:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745F2102;
        Fri, 25 Aug 2023 04:46:38 -0700 (PDT)
X-UUID: 09677b80433d11eeb20a276fd37b9834-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=S/1sRclz0BosO59FgdkGptOsoG5Sgf9pSQyWZXQ1KLw=;
        b=MWMPJY1IruKojGRrvMNPAqsyzYxbIfVIynxtIdouRwK4agT+yBi2q+GrUcq12A5vQBr6Dq16yRhWu2y/wAgn3Okocp3L5zOSnlJAFRnMWu2tob6aDVsuFbMczoM16mVNwVQK6VW5oeXO+cd3xABITaGmChzuS7X+X+KckgRItGo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:762306ec-b73c-457d-92d0-bd093d83466a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:762306ec-b73c-457d-92d0-bd093d83466a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:0f11c01f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:230825194634T30A44GU,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 09677b80433d11eeb20a276fd37b9834-20230825
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 633622712; Fri, 25 Aug 2023 19:46:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Aug 2023 19:46:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Aug 2023 19:46:31 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 4/4] arm64: dts: mediatek: mt8195-demo: simplify mt6360 nodes
Date:   Fri, 25 Aug 2023 19:46:23 +0800
Message-ID: <20230825114623.16884-4-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230825114623.16884-1-macpaul.lin@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dts file for the MediaTek MT8195 demo board has been refactored
to improve the configuration of the MT6360 multi-function PMIC.

The changes include:
 - Addition of the mt6360.dtsi include file, which contains the common
   configuration of the MT6360 for all mt8195 boards.
 - Removal of the direct inclusion of the mt6360-regulator.h file.
 - Removal of the detailed configuration of the MT6360 PMIC since
   the included mt6360.dtsi is used.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 136 ++++++-------------
 1 file changed, 39 insertions(+), 97 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 8aea6f5d72b3..da1c077c3d9e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -11,7 +11,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
-#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
 
 / {
 	model = "MediaTek MT8195 demo board";
@@ -130,103 +129,9 @@
 	mt6360: pmic@34 {
 		compatible = "mediatek,mt6360";
 		reg = <0x34>;
-		interrupt-controller;
+		pinctrl-0 = <&mt6360_pins>;
+		pinctrl-names = "default";
 		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-names = "IRQB";
-
-		charger {
-			compatible = "mediatek,mt6360-chg";
-			richtek,vinovp-microvolt = <14500000>;
-
-			otg_vbus_regulator: usb-otg-vbus-regulator {
-				regulator-compatible = "usb-otg-vbus";
-				regulator-name = "usb-otg-vbus";
-				regulator-min-microvolt = <4425000>;
-				regulator-max-microvolt = <5825000>;
-			};
-		};
-
-		regulator {
-			compatible = "mediatek,mt6360-regulator";
-			LDO_VIN3-supply = <&mt6360_buck2>;
-
-			mt6360_buck1: buck1 {
-				regulator-compatible = "BUCK1";
-				regulator-name = "mt6360,buck1";
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP
-							   MT6360_OPMODE_ULP>;
-				regulator-always-on;
-			};
-
-			mt6360_buck2: buck2 {
-				regulator-compatible = "BUCK2";
-				regulator-name = "mt6360,buck2";
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP
-							   MT6360_OPMODE_ULP>;
-				regulator-always-on;
-			};
-
-			mt6360_ldo1: ldo1 {
-				regulator-compatible = "LDO1";
-				regulator-name = "mt6360,ldo1";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP>;
-			};
-
-			mt6360_ldo2: ldo2 {
-				regulator-compatible = "LDO2";
-				regulator-name = "mt6360,ldo2";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP>;
-			};
-
-			mt6360_ldo3: ldo3 {
-				regulator-compatible = "LDO3";
-				regulator-name = "mt6360,ldo3";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP>;
-			};
-
-			mt6360_ldo5: ldo5 {
-				regulator-compatible = "LDO5";
-				regulator-name = "mt6360,ldo5";
-				regulator-min-microvolt = <2700000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP>;
-			};
-
-			mt6360_ldo6: ldo6 {
-				regulator-compatible = "LDO6";
-				regulator-name = "mt6360,ldo6";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <2100000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP>;
-			};
-
-			mt6360_ldo7: ldo7 {
-				regulator-compatible = "LDO7";
-				regulator-name = "mt6360,ldo7";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <2100000>;
-				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
-							   MT6360_OPMODE_LP>;
-				regulator-always-on;
-			};
-		};
 	};
 };
 
@@ -300,6 +205,34 @@
 	regulator-always-on;
 };
 
+#include "mt6360.dtsi"
+
+/* For EMI_VDD2 */
+&mt6360_buck1 {
+	regulator-always-on;
+};
+
+/* For EMI_VDDQ */
+&mt6360_buck2 {
+	regulator-always-on;
+};
+
+&mt6360_ldo1 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
+
+&mt6360_ldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+/* For EMI_VMDDR_EN */
+&mt6360_ldo7 {
+	regulator-always-on;
+};
+
 &pio {
 	eth_default_pins: eth-default-pins {
 		pins-txd {
@@ -496,6 +429,15 @@
 				 <PINMUX_GPIO103__FUNC_URXD1>;
 		};
 	};
+
+	mt6360_pins: mt6360-pins {
+		pins {
+			pinmux = <PINMUX_GPIO100__FUNC_GPIO100>,
+				 <PINMUX_GPIO101__FUNC_GPIO101>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
 };
 
 
-- 
2.18.0

