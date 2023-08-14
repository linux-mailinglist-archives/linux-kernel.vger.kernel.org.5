Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830BB77B278
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjHNH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjHNH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:28:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28018F;
        Mon, 14 Aug 2023 00:28:45 -0700 (PDT)
X-UUID: 2dbc999c3a7411eeb20a276fd37b9834-20230814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=S7CYYCxauHwUQ9CvWRyvZwgOK8cGZ8/AmAGezFuN4V0=;
        b=PHyHJw1rx7MRn7XHv8Zu9gJaG9KLjRIQGCvTt7bKyFYs3Kg6X94d6I8HOndz4OBU29+67rsunp4Q2nll9fRk/yExkmKW59zhxxkA7GqGujet6NiuOo42caZUYMCFg/7Oyklycfqt2LaFKrbONBz4Jl86csq0iUY3LqEKlrQ2ZLw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:dc217edc-2a0d-4c01-8468-061ce052f523,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:9fdabc12-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2dbc999c3a7411eeb20a276fd37b9834-20230814
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1291675673; Mon, 14 Aug 2023 15:28:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 14 Aug 2023 15:28:33 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 14 Aug 2023 15:28:33 +0800
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
Subject: [PATCH v4,3/3] drm/mediatek: dp: Add the audio divider to mtk_dp_data struct
Date:   Mon, 14 Aug 2023 15:28:42 +0800
Message-ID: <20230814072842.28597-4-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814072842.28597-1-shuijing.li@mediatek.com>
References: <20230814072842.28597-1-shuijing.li@mediatek.com>
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

Due to the difference of HW, different dividers need to be set.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
Changes in v4:
list all configuration for MT8188 and MT8195.
per suggestion from the previous thread:
https://lore.kernel.org/all/a9d1b9b7ef4780f51574d0bbbe28f6dd109a6ab8.camel@mediatek.com/
Changes in v3:
Separate these two things into two different patches.
per suggestion from the previous thread:
https://lore.kernel.org/lkml/e2ad22bcba31797f38a12a488d4246a01bf0cb2e.camel@mediatek.com/
Changes in v2:
- change the variables' name to be more descriptive
- add a comment that describes the function of mtk_dp_audio_sample_arrange
- reduce indentation by doing the inverse check
- add a definition of some bits
- add support for mediatek, mt8188-edp-tx
per suggestion from the previous thread:
https://lore.kernel.org/lkml/ac0fcec9-a2fe-06cc-c727-189ef7babe9c@collabora.com/
---
 drivers/gpu/drm/mediatek/mtk_dp.c     |  6 +++++-
 drivers/gpu/drm/mediatek/mtk_dp_reg.h | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 75af6de7bc42..8f97e6f76639 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -140,6 +140,7 @@ struct mtk_dp_data {
 	const struct mtk_dp_efuse_fmt *efuse_fmt;
 	bool audio_supported;
 	bool audio_pkt_in_hblank_area;
+	u16 audio_m_div2_bit;
 };
 
 static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
@@ -648,7 +649,7 @@ static void mtk_dp_audio_sdp_asp_set_channels(struct mtk_dp *mtk_dp,
 static void mtk_dp_audio_set_divider(struct mtk_dp *mtk_dp)
 {
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_30BC,
-			   AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
+			   mtk_dp->data->audio_m_div2_bit,
 			   AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MASK);
 }
 
@@ -2636,6 +2637,7 @@ static const struct mtk_dp_data mt8188_dp_data = {
 	.efuse_fmt = mt8195_dp_efuse_fmt,
 	.audio_supported = true,
 	.audio_pkt_in_hblank_area = true,
+	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
 };
 
 static const struct mtk_dp_data mt8195_edp_data = {
@@ -2643,6 +2645,7 @@ static const struct mtk_dp_data mt8195_edp_data = {
 	.smc_cmd = MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE,
 	.efuse_fmt = mt8195_edp_efuse_fmt,
 	.audio_supported = false,
+	.audio_m_div2_bit = MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
 };
 
 static const struct mtk_dp_data mt8195_dp_data = {
@@ -2650,6 +2653,7 @@ static const struct mtk_dp_data mt8195_dp_data = {
 	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
 	.efuse_fmt = mt8195_dp_efuse_fmt,
 	.audio_supported = true,
+	.audio_m_div2_bit = MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
 };
 
 static const struct of_device_id mtk_dp_of_match[] = {
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index f38d6ff12afe..709b79480693 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -159,12 +159,18 @@
 #define MTK_DP_ENC0_P0_30BC			0x30bc
 #define ISRC_CONT_DP_ENC0_P0				BIT(0)
 #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MASK	GENMASK(10, 8)
-#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2	(1 << 8)
-#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4	(2 << 8)
-#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8	(3 << 8)
-#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(5 << 8)
-#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(6 << 8)
-#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)
+#define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2	(1 << 8)
+#define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4	(2 << 8)
+#define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8	(3 << 8)
+#define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(5 << 8)
+#define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(6 << 8)
+#define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2	(1 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4	(2 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8	(3 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(4 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(5 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)
 #define MTK_DP_ENC0_P0_30D8			0x30d8
 #define MTK_DP_ENC0_P0_312C			0x312c
 #define ASP_HB2_DP_ENC0_P0_MASK				GENMASK(7, 0)
-- 
2.40.1

