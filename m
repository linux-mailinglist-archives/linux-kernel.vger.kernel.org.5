Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A987852AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjHWIbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjHWI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:28:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C77358E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:26:35 -0700 (PDT)
X-UUID: a3a48036418e11ee9cb5633481061a41-20230823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6jPHQ8/ihfSwFIDrR+mTFdxoHGqeLjAmqmbiTOz4wI0=;
        b=q2zF0Ad9Jp2yPa2T8m9TLMmbPs5rVu6Zu/SAXzv1hTYoaHVL8oSnSSkDFc9rC9DfbvjbgdnBTB+qLnLOeatej9W/ZAICFLoJotDAqfmFoAh3UOGvjhnTMDndKqnYpmmBXCsrydPu9WguGJcHM+vsxZC+0rKFGm/2C+61AwGhkiY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:91ff13b9-a71f-43c7-a5c7-a3ae5f334473,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:91ff13b9-a71f-43c7-a5c7-a3ae5f334473,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:37f0a71f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:230823162540Y05U1C5O,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: a3a48036418e11ee9cb5633481061a41-20230823
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 245059849; Wed, 23 Aug 2023 16:25:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Aug 2023 16:25:36 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Aug 2023 16:25:36 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH] drm/mediatek: Support IGT in dp driver
Date:   Wed, 23 Aug 2023 16:25:49 +0800
Message-ID: <20230823082549.24756-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support IGT (Intel GPU Tools) in Mediatek DisplayPort driver

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7d5250351193..a494e04f0ddf 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -806,6 +806,25 @@ static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	mtk_dsi_poweroff(dsi);
 }
 
+static enum drm_mode_status
+mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
+			  const struct drm_display_info *info,
+			  const struct drm_display_mode *mode)
+{
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+	u32 bpp;
+
+	if (dsi->format == MIPI_DSI_FMT_RGB565)
+		bpp = 16;
+	else
+		bpp = 24;
+
+	if (mode->clock * bpp / dsi->lanes > 1500000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.attach = mtk_dsi_bridge_attach,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -815,6 +834,7 @@ static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
 	.atomic_post_disable = mtk_dsi_bridge_atomic_post_disable,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.mode_valid = mtk_dsi_bridge_mode_valid,
 	.mode_set = mtk_dsi_bridge_mode_set,
 };
 
-- 
2.40.1

