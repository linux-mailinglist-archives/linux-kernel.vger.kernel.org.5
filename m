Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE178DC45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjH3SoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243623AbjH3LPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:15:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545031BB;
        Wed, 30 Aug 2023 04:15:48 -0700 (PDT)
X-UUID: 8fab68cc472611eeb20a276fd37b9834-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n+UbBF/3JQZviCPlK4rdr2SHoBvRwTsrx1RlcHa0xCM=;
        b=a1gkRO1Mfv7CrW9jZunZ2GHTC7NMUgNKY1ru6uXI7hRLfFp8DJ4cIb+mx8iX1KK5UTDtHILJ0464iqW+JrxBTE6fNfjnA3qVqqfJdH8hurl5kQwr0Tf4YId4La+QuoLxkI8EAEzyDQ3sizPLRAmwFWxHK/tBoqmRocv4yyeiIes=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7524d8b5-36e3-44a1-bf55-284c47125a8a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:206c1eef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8fab68cc472611eeb20a276fd37b9834-20230830
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 724027194; Wed, 30 Aug 2023 19:15:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH v2 3/4] arm64: dts: mediatek: mt6360: add PMIC MT6360 related nodes
Date:   Wed, 30 Aug 2023 19:15:31 +0800
Message-ID: <20230830111532.9048-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230830111532.9048-1-macpaul.lin@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230830111532.9048-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6360 is the secondary PMIC for MT8195.
It supports USB Type-C and PD functions.
Add MT6360 related common nodes which is used for MT8195 platform, includes
 - charger
 - ADC
 - LED
 - regulators

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6360.dtsi | 85 ++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6360.dtsi

Change for v2:
 - Remove the following properties according to Chen-Yu Tsai's suggestion
  - regulator-name
  - regulator-min-microvolt
  - regulator-max-microvolt

diff --git a/arch/arm64/boot/dts/mediatek/mt6360.dtsi b/arch/arm64/boot/dts/mediatek/mt6360.dtsi
new file mode 100644
index 000000000000..a89fd43d0f1f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6360.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ */
+
+#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+
+&mt6360 {
+	interrupt-controller;
+	interrupt-parent = <&pio>;
+	interrupt-names = "IRQB";
+
+	charger {
+		compatible = "mediatek,mt6360-chg";
+		richtek,vinovp-microvolt = <14500000>;
+
+		otg_vbus_regulator: usb-otg-vbus-regulator {
+			regulator-compatible = "usb-otg-vbus";
+		};
+	};
+
+	adc {
+		compatible = "mediatek,mt6360-adc";
+		#io-channel-cells = <1>;
+	};
+
+	led {
+		compatible = "mediatek,mt6360-led";
+	};
+
+	regulator {
+		compatible = "mediatek,mt6360-regulator";
+		LDO_VIN3-supply = <&mt6360_emi_vddq_buck2_reg>;
+
+		mt6360_emi_vdd2_buck1_reg: buck1-emi-vdd2 {
+			regulator-compatible = "BUCK1";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP
+						   MT6360_OPMODE_ULP>;
+		};
+
+		mt6360_emi_vddq_buck2_reg: buck2-emi-vddq {
+			regulator-compatible = "BUCK2";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP
+						   MT6360_OPMODE_ULP>;
+		};
+
+		mt6360_tp1_p3v0_ldo1_reg: ldo1-tp1-p3v0 {
+			regulator-compatible = "LDO1";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_panel1_p1v8_ldo2_reg: ldo2-panel1-p1v8 {
+			regulator-compatible = "LDO2";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_vmc_pmu_ldo3_reg: ldo3-vmc-pmu {
+			regulator-compatible = "LDO3";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_vmch_pmu_ldo5_reg: ldo5-vmch-pmu {
+			regulator-compatible = "LDO5";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_ldo6_reg: ldo6-mt6360 {
+			regulator-compatible = "LDO6";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_emi_vmddr_en_ldo7_reg: ldo7-emi-vmddr-en {
+			regulator-compatible = "LDO7";
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+	};
+};
-- 
2.18.0

