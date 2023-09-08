Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6C798390
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjIHHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIHHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:53:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE01997;
        Fri,  8 Sep 2023 00:53:01 -0700 (PDT)
X-UUID: b8fa0dc64e1c11eea33bb35ae8d461a2-20230908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3JxP94D/+bV+WcBfTgzOlKtCY2haFLhGxhBTcxKPKB4=;
        b=tNRv8MxMF2jWSUNY6RkXIkhTfxFNQrJKCM1YMcaFYbZU2tfIfHdxh6eWKVPrEyTKeSW3ILFHmFZIhgliNm1dIxXrPxm460UT6LI5eplYyFLLD/jx+dwAH1ZcbqmHh3wqUK+WfW2OuIZIwrwyB5nbQM/5OoXcuh4jmXpfjrrsDpo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8dd31b98-866c-406d-8747-4c43738eabe8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:7c40cbc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b8fa0dc64e1c11eea33bb35ae8d461a2-20230908
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 474986151; Fri, 08 Sep 2023 15:52:56 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Sep 2023 15:52:55 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Sep 2023 15:52:54 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <chunfeng.yun@mediatek.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>
CC:     <linux-phy@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH v3] dt-bindings: phy: Add compatible for Mediatek MT8188
Date:   Fri, 8 Sep 2023 15:53:10 +0800
Message-ID: <20230908075310.17825-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation of dsi-phy for MediaTek MT8188 SoC.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
Changes in v3:
After upstreaming the basic version of mt8188.dtsi, we will add the
following mipi node in mt8188.dtsi:
mipi_tx_config0: mipi_dphy0@11c80000 {
			compatible = "mediatek,mt8188-mipi-tx",
				     "mediatek,mt8183-mipi-tx";
			reg = <0 0x11c80000 0 0x1000>;
			clocks = <&clk26m>;
			#clock-cells = <0>;
			#phy-cells = <0>;
			clock-output-names = "mipi_tx0_pll";
			status = "disabled";
		};
per suggestion from the previous thread:
https://lore.kernel.org/all/0a6d3d14-33f0-92d2-b42f-e4d336c8cd91@linaro.org/
Changes in v2:
Adjust mt8188 position.
---
 Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
index a63b20dfa4a5..6703689fcdbe 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
@@ -30,6 +30,7 @@ properties:
           - const: mediatek,mt8173-mipi-tx
       - items:
           - enum:
+              - mediatek,mt8188-mipi-tx
               - mediatek,mt8365-mipi-tx
           - const: mediatek,mt8183-mipi-tx
       - const: mediatek,mt2701-mipi-tx
-- 
2.40.1

