Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2113078864C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbjHYLrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbjHYLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:46:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6CE1FF7;
        Fri, 25 Aug 2023 04:46:38 -0700 (PDT)
X-UUID: 09545546433d11ee9cb5633481061a41-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oaCx4GPrx89E/9c/EnzITbJJBX/TbYcU6esy3AWOiYI=;
        b=fXLqDKU5DlRNt2ZK7OFjZSYW9wFR42nKV9HmDbkhs2AYHYQe07qOmiF6S0Ad0LesodrWqyntPw+cyzWV2tz+AykQMZvZpfSdb1isJq2KAgai8Pa83ZV2zTEEeyJ+XsisA5FBShDZTevkDR/3iPb5QeHWv39TFhU+AVDLumU6OO4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:02ecd74b-6448-4cc7-a9ed-d94de623140d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:8d353013-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 09545546433d11ee9cb5633481061a41-20230825
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1371122494; Fri, 25 Aug 2023 19:46:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH 3/4] arm64: dts: mediatek: mt6360: add PMIC MT6360 related nodes
Date:   Fri, 25 Aug 2023 19:46:22 +0800
Message-ID: <20230825114623.16884-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230825114623.16884-1-macpaul.lin@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/mediatek/mt6360.dtsi | 112 +++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6360.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6360.dtsi b/arch/arm64/boot/dts/mediatek/mt6360.dtsi
new file mode 100644
index 000000000000..e841f4e5a54b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6360.dtsi
@@ -0,0 +1,112 @@
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
+			regulator-name = "usb-otg-vbus";
+			regulator-min-microvolt = <4425000>;
+			regulator-max-microvolt = <5825000>;
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
+		LDO_VIN3-supply = <&mt6360_buck2>;
+
+		mt6360_buck1: buck1 {
+			regulator-compatible = "BUCK1";
+			regulator-name = "mt6360,buck1";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP
+						   MT6360_OPMODE_ULP>;
+		};
+
+		mt6360_buck2: buck2 {
+			regulator-compatible = "BUCK2";
+			regulator-name = "mt6360,buck2";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP
+						   MT6360_OPMODE_ULP>;
+		};
+
+		mt6360_ldo1: ldo1 {
+			regulator-compatible = "LDO1";
+			regulator-name = "mt6360,ldo1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_ldo2: ldo2 {
+			regulator-compatible = "LDO2";
+			regulator-name = "mt6360,ldo2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_ldo3: ldo3 {
+			regulator-compatible = "LDO3";
+			regulator-name = "mt6360,ldo3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_ldo5: ldo5 {
+			regulator-compatible = "LDO5";
+			regulator-name = "mt6360,ldo5";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_ldo6: ldo6 {
+			regulator-compatible = "LDO6";
+			regulator-name = "mt6360,ldo6";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <2100000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+
+		mt6360_ldo7: ldo7 {
+			regulator-compatible = "LDO7";
+			regulator-name = "mt6360,ldo7";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <2100000>;
+			regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+						   MT6360_OPMODE_LP>;
+		};
+	};
+};
-- 
2.18.0

