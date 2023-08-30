Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8078DD63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbjH3StM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbjH3LPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:15:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC51BB;
        Wed, 30 Aug 2023 04:15:50 -0700 (PDT)
X-UUID: 8fc5eab2472611ee9cb5633481061a41-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=I46lugSFon7zMqsD/TgIXQzk4siDt3J+v9kCe5jxnAk=;
        b=jKYMQ52XdiVol3AY/nIDO3KwLv2QZmA7YRwJFJEuUNKcNyUUQ7aEafOIvnwaWGoYP96N3+90HdD0tY68EaAn9rgm98hPRp8yI6rSaf0nA7ruwmMX+6ICZ9bXpgFGpuS0jOj1C8N11y/L4z12FGURA5NnPCvRARH9DHVrP/DRn2o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:03fbc534-458b-44a1-a863-82f2d07e0ef2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:4d295c13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8fc5eab2472611ee9cb5633481061a41-20230830
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 21128435; Wed, 30 Aug 2023 19:15:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Aug 2023 19:15:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Aug 2023 19:15:42 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt8195-demo: simplify mt6360 nodes
Date:   Wed, 30 Aug 2023 19:15:32 +0800
Message-ID: <20230830111532.9048-4-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230830111532.9048-1-macpaul.lin@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230830111532.9048-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
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
 - Removal of the common configuration of the MT6360 PMIC since
   the included mt6360.dtsi is used.
 - Add names according to the schematic of mt8195-demo board for
   mt6360 nodes.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 173 ++++++++-----------
 1 file changed, 74 insertions(+), 99 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 8aea6f5d72b3..d082d679dbbe 100644
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
 
@@ -259,8 +164,8 @@
 	cap-sd-highspeed;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
-	vmmc-supply = <&mt6360_ldo5>;
-	vqmmc-supply = <&mt6360_ldo3>;
+	vmmc-supply = <&mt6360_vmch_pmu_ldo5_reg>;
+	vqmmc-supply = <&mt6360_vmc_pmu_ldo3_reg>;
 	status = "okay";
 };
 
@@ -300,6 +205,67 @@
 	regulator-always-on;
 };
 
+#include "mt6360.dtsi"
+
+&otg_vbus_regulator {
+	regulator-name = "usb-otg-vbus";
+	regulator-min-microvolt = <4425000>;
+	regulator-max-microvolt = <5825000>;
+};
+
+&mt6360_emi_vdd2_buck1_reg {
+	regulator-name = "emi_vdd2";
+	regulator-min-microvolt = <300000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-always-on;
+};
+
+&mt6360_emi_vddq_buck2_reg {
+	regulator-name = "emi_vddq";
+	regulator-min-microvolt = <300000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-always-on;
+};
+
+&mt6360_tp1_p3v0_ldo1_reg {
+	regulator-name = "tp1_p3v0";
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
+
+&mt6360_panel1_p1v8_ldo2_reg {
+	regulator-name = "panel1_p1v8";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+&mt6360_vmc_pmu_ldo3_reg {
+	regulator-name = "vmc_pmu";
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <3600000>;
+};
+
+&mt6360_vmch_pmu_ldo5_reg {
+	regulator-name = "vmch_pmu";
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3600000>;
+};
+
+/* measure point on board */
+&mt6360_ldo6_reg {
+	regulator-name = "mt6360_ldo6";
+	regulator-min-microvolt = <500000>;
+	regulator-max-microvolt = <2100000>;
+};
+
+&mt6360_emi_vmddr_en_ldo7_reg {
+	regulator-name = "emi_vmddr_en";
+	regulator-min-microvolt = <500000>;
+	regulator-max-microvolt = <2100000>;
+	regulator-always-on;
+};
+
 &pio {
 	eth_default_pins: eth-default-pins {
 		pins-txd {
@@ -496,6 +462,15 @@
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

