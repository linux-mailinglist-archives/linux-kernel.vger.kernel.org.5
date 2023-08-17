Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBD77F086
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbjHQG04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348204AbjHQG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:26:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B712D58;
        Wed, 16 Aug 2023 23:26:32 -0700 (PDT)
X-UUID: fe856ef63cc611ee9cb5633481061a41-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nNyATG8ElIZ3PwkjBirLYdtitgmj23VBilUDLfgcBuU=;
        b=tHyzgOcVtKkrauPWh46ScjhrOsM/aSW/oZSqkcceButAfw3x//bfceF9aO5ezfu5FEQUthNQbE4+WgI1DhnQrOUfgFwJD/FYCZnS8iEzCuhE0qsjZ4o5wkeGSWvgzwtlMc0FoB8yc8MRwpdWF/8yx2HRXXHaBA/k/8QUHbrjiMM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:45f254bb-1136-4dca-99e7-14880372df2d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.31,REQID:45f254bb-1136-4dca-99e7-14880372df2d,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:0ad78a4,CLOUDID:281a6e1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:230817142629OET2U3EU,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: fe856ef63cc611ee9cb5633481061a41-20230817
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 108893706; Thu, 17 Aug 2023 14:26:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 14:26:26 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 14:26:25 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH v5,4/4] drm/mediatek: dp: Add support MT8188 dp/edp function
Date:   Thu, 17 Aug 2023 14:26:35 +0800
Message-ID: <20230817062635.8786-5-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230817062635.8786-1-shuijing.li@mediatek.com>
References: <20230817062635.8786-1-shuijing.li@mediatek.com>
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

Add mtk_dp_audio_sample_arrange_disable function for MT8188.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
Changes in v5:
Separate mt8188 related code into mtk_dp_data structure and mt8188 dp/edp function
per suggestion from the previous thread:
https://lore.kernel.org/lkml/c1c84616f3da83a8a2bc245b0d3c7697153cd81a.camel@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index fb110374ad1f..67986dd7c9d7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1364,6 +1364,18 @@ static void mtk_dp_sdp_set_down_cnt_init_in_hblank(struct mtk_dp *mtk_dp)
 			   SDP_DOWN_CNT_INIT_IN_HBLANK_DP_ENC1_P0_MASK);
 }
 
+static void mtk_dp_audio_sample_arrange_disable(struct mtk_dp *mtk_dp)
+{
+	/* arrange audio packets into the Hblanking and Vblanking area */
+	if (!mtk_dp->data->audio_pkt_in_hblank_area)
+		return;
+
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3374, 0,
+			   SDP_ASP_INSERT_IN_HBLANK_DP_ENC1_P0_MASK);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3374, 0,
+			   SDP_DOWN_ASP_CNT_INIT_DP_ENC1_P0_MASK);
+}
+
 static void mtk_dp_setup_tu(struct mtk_dp *mtk_dp)
 {
 	u32 sram_read_start = min_t(u32, MTK_DP_TBC_BUF_READ_START_ADDR,
@@ -1373,6 +1385,7 @@ static void mtk_dp_setup_tu(struct mtk_dp *mtk_dp)
 				    MTK_DP_PIX_PER_ADDR);
 	mtk_dp_set_sram_read_start(mtk_dp, sram_read_start);
 	mtk_dp_setup_encoder(mtk_dp);
+	mtk_dp_audio_sample_arrange_disable(mtk_dp);
 	mtk_dp_sdp_set_down_cnt_init_in_hblank(mtk_dp);
 	mtk_dp_sdp_set_down_cnt_init(mtk_dp, sram_read_start);
 }
-- 
2.40.1

