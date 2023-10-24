Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F77D50DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbjJXNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjJXNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:01:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31110D7;
        Tue, 24 Oct 2023 06:01:07 -0700 (PDT)
X-UUID: 5f3fae10726d11eea33bb35ae8d461a2-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yXPKqi+EJx+hFEBjGUNkwptQPNfgosBQdZuUgrEhk/U=;
        b=s5n4Gb+6EGL7lj2wYBFrMUotYkoQhCTcMavyvKUrkGq1UIm3KT4RzZYl7IewTCX6+7GHvcAPNpkik9/xbVU6difWyuTg1gvSXq38gHDx223YJOBzlrKDnCSOREI8VEDXL/E2S+v8SE7XWQ6NMLey3ETEIZGrACCCmAxcPGLUR8s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:12b34fe5-6f5e-4ea2-a35e-4c75994ef601,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:c7c4da28-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5f3fae10726d11eea33bb35ae8d461a2-20231024
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1175345767; Tue, 24 Oct 2023 21:00:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 21:00:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 21:00:55 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 19/23] drm/mediatek: Add Padding to OVL adaptor
Date:   Tue, 24 Oct 2023 21:00:44 +0800
Message-ID: <20231024130048.14749-20-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231024130048.14749-1-shawn.sung@mediatek.com>
References: <20231024130048.14749-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8188 Padding to OVL adaptor to probe the driver.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index df6e6cb0a9ef..10d23e76acaa 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -29,6 +29,7 @@ enum mtk_ovl_adaptor_comp_type {
 	OVL_ADAPTOR_TYPE_ETHDR,
 	OVL_ADAPTOR_TYPE_MDP_RDMA,
 	OVL_ADAPTOR_TYPE_MERGE,
+	OVL_ADAPTOR_TYPE_PADDING,
 	OVL_ADAPTOR_TYPE_NUM,
 };

@@ -46,6 +47,14 @@ enum mtk_ovl_adaptor_comp_id {
 	OVL_ADAPTOR_MERGE1,
 	OVL_ADAPTOR_MERGE2,
 	OVL_ADAPTOR_MERGE3,
+	OVL_ADAPTOR_PADDING0,
+	OVL_ADAPTOR_PADDING1,
+	OVL_ADAPTOR_PADDING2,
+	OVL_ADAPTOR_PADDING3,
+	OVL_ADAPTOR_PADDING4,
+	OVL_ADAPTOR_PADDING5,
+	OVL_ADAPTOR_PADDING6,
+	OVL_ADAPTOR_PADDING7,
 	OVL_ADAPTOR_ID_MAX
 };

@@ -66,6 +75,7 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
 	[OVL_ADAPTOR_TYPE_ETHDR]	= "ethdr",
 	[OVL_ADAPTOR_TYPE_MDP_RDMA]	= "vdo1-rdma",
 	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
+	[OVL_ADAPTOR_TYPE_PADDING]	= "padding",
 };

 static const struct mtk_ddp_comp_funcs ethdr = {
@@ -80,6 +90,13 @@ static const struct mtk_ddp_comp_funcs merge = {
 	.clk_disable = mtk_merge_clk_disable,
 };

+static const struct mtk_ddp_comp_funcs padding = {
+	.clk_enable = mtk_padding_clk_enable,
+	.clk_disable = mtk_padding_clk_disable,
+	.start = mtk_padding_start,
+	.stop = mtk_padding_stop,
+};
+
 static const struct mtk_ddp_comp_funcs rdma = {
 	.power_on = mtk_mdp_rdma_power_on,
 	.power_off = mtk_mdp_rdma_power_off,
@@ -101,6 +118,14 @@ static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
 	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2, &merge },
 	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3, &merge },
 	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4, &merge },
+	[OVL_ADAPTOR_PADDING0] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING0, 0, &padding },
+	[OVL_ADAPTOR_PADDING1] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING1, 1, &padding },
+	[OVL_ADAPTOR_PADDING2] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING2, 2, &padding },
+	[OVL_ADAPTOR_PADDING3] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING3, 3, &padding },
+	[OVL_ADAPTOR_PADDING4] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING4, 4, &padding },
+	[OVL_ADAPTOR_PADDING5] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING5, 5, &padding },
+	[OVL_ADAPTOR_PADDING6] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING6, 6, &padding },
+	[OVL_ADAPTOR_PADDING7] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING7, 7, &padding },
 };

 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
@@ -436,6 +461,7 @@ static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
 }

 static const struct of_device_id mtk_ovl_adaptor_comp_dt_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-padding", .data = (void *)OVL_ADAPTOR_TYPE_PADDING },
 	{ .compatible = "mediatek,mt8195-disp-ethdr", .data = (void *)OVL_ADAPTOR_TYPE_ETHDR },
 	{ .compatible = "mediatek,mt8195-disp-merge", .data = (void *)OVL_ADAPTOR_TYPE_MERGE },
 	{ .compatible = "mediatek,mt8195-vdo1-rdma", .data = (void *)OVL_ADAPTOR_TYPE_MDP_RDMA },
--
2.18.0

