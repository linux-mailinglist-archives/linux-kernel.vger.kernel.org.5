Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3777F085
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbjHQG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbjHQG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:26:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBE2D5A;
        Wed, 16 Aug 2023 23:26:33 -0700 (PDT)
X-UUID: fe830c7e3cc611ee9cb5633481061a41-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=E/+xSEjeEKXM3yEBEL+rZfRWTcvVBsEN9Ge5xp19tds=;
        b=mNoUsEXrlQf71+silxPB/LOA3iHBJyNGOmMGAJrYMrQSdBEhCVlbD8MHSdHRHJcO319qrOEd4olXsKM+6iVstcBaDwTQvr8IPkTGWsbEQ53Ub/Luw/417USL/eJ47BOZfxkPF0ok46nLgr6Pa7aghJSERYfqQIRcUCsB+EDDOfs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:afd72b4b-7d2f-4599-9643-ad1b1c812be8,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.31,REQID:afd72b4b-7d2f-4599-9643-ad1b1c812be8,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:0ad78a4,CLOUDID:4330de12-4929-4845-9571-38c601e9c3c9,B
        ulkID:230817142629FZGBOGH5,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: fe830c7e3cc611ee9cb5633481061a41-20230817
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2053463488; Thu, 17 Aug 2023 14:26:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 14:26:25 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 14:26:24 +0800
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
Subject: [PATCH v5,2/4] drm/mediatek: dp: Add the audio packet flag to mtk_dp_data struct
Date:   Thu, 17 Aug 2023 14:26:33 +0800
Message-ID: <20230817062635.8786-3-shuijing.li@mediatek.com>
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

The audio packet arrangement function is to only arrange audio
packets into the Hblanking area. In order to align with the HW
default setting of mt8195, this function needs to be turned off.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
Changes in v5:
Separate mt8188 related code into mtk_dp_data structure and mt8188 dp/edp function
per suggestion from the previous thread:
https://lore.kernel.org/lkml/c1c84616f3da83a8a2bc245b0d3c7697153cd81a.camel@mediatek.com/
Changes in v4:
drop mt8188_edp_data and remove unnecessary modification.
per suggestion from the previous thread:
https://lore.kernel.org/all/bddb1a1a445ead85056202c355627698051f12c9.camel@mediatek.com/
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
 drivers/gpu/drm/mediatek/mtk_dp.c     | 17 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 64eee77452c0..be557b6f5854 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -139,6 +139,7 @@ struct mtk_dp_data {
 	unsigned int smc_cmd;
 	const struct mtk_dp_efuse_fmt *efuse_fmt;
 	bool audio_supported;
+	bool audio_pkt_in_hblank_area;
 };
 
 static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
@@ -2616,6 +2617,14 @@ static int mtk_dp_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
 
+static const struct mtk_dp_data mt8188_dp_data = {
+	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
+	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
+	.efuse_fmt = mt8195_dp_efuse_fmt,
+	.audio_supported = true,
+	.audio_pkt_in_hblank_area = true,
+};
+
 static const struct mtk_dp_data mt8195_edp_data = {
 	.bridge_type = DRM_MODE_CONNECTOR_eDP,
 	.smc_cmd = MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE,
@@ -2631,6 +2640,14 @@ static const struct mtk_dp_data mt8195_dp_data = {
 };
 
 static const struct of_device_id mtk_dp_of_match[] = {
+	{
+		.compatible = "mediatek,mt8188-edp-tx",
+		.data = &mt8195_edp_data,
+	},
+	{
+		.compatible = "mediatek,mt8188-dp-tx",
+		.data = &mt8188_dp_data,
+	},
 	{
 		.compatible = "mediatek,mt8195-edp-tx",
 		.data = &mt8195_edp_data,
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 84e38cef03c2..f38d6ff12afe 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -228,6 +228,11 @@
 							 VIDEO_STABLE_CNT_THRD_DP_ENC1_P0 | \
 							 SDP_DP13_EN_DP_ENC1_P0 | \
 							 BS2BS_MODE_DP_ENC1_P0)
+
+#define MTK_DP_ENC1_P0_3374			0x3374
+#define SDP_ASP_INSERT_IN_HBLANK_DP_ENC1_P0_MASK	BIT(12)
+#define SDP_DOWN_ASP_CNT_INIT_DP_ENC1_P0_MASK		GENMASK(11, 0)
+
 #define MTK_DP_ENC1_P0_33F4			0x33f4
 #define DP_ENC_DUMMY_RW_1_AUDIO_RST_EN			BIT(0)
 #define DP_ENC_DUMMY_RW_1				BIT(9)
-- 
2.40.1

