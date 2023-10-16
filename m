Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61A97C9FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjJPGoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjJPGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:44:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB1D9;
        Sun, 15 Oct 2023 23:44:00 -0700 (PDT)
X-UUID: 600c9dc86bef11eea33bb35ae8d461a2-20231016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=izL0i7r4B8b6sMmjWv8zm0n63Yb81PAEZ31NXGW5fxI=;
        b=BBURhn7wTIUwdmtLMP/NeFIuKrWHQA3sC8uDo9zEwPg99BjofWSioJGQ5FDiAyeSnFGOPhjE9TfGVJfYoVJC5sa3Ow8OdRICs0LR71/h97KjX6M619aiV1Hk43t2Ti1O9TJSXSGzFGcomtPwaeqL+NAitlypdIiCucMSluHkVdk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:11ae6b4a-6768-4f78-a178-36515bb80c16,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8e36d6f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 600c9dc86bef11eea33bb35ae8d461a2-20231016
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 76313691; Mon, 16 Oct 2023 14:43:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Oct 2023 14:43:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Oct 2023 14:43:52 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Steve Cho" <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 6/7] media: mediatek: vcodec: Setting the supported vp9 level for each platform
Date:   Mon, 16 Oct 2023 14:43:45 +0800
Message-ID: <20231016064346.31451-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016064346.31451-1-yunfei.dong@mediatek.com>
References: <20231016064346.31451-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.869200-8.000000
X-TMASE-MatchedRID: goirSfhi1invUrWD9LZntwPZZctd3P4B7f6JAS2hKPj82ks92f+GmsjS
        UFX9l+y8BMahfseAGhne6jZdTQ8bvOF/B1jEjV+6syw+ZJnFumSjkoGZwmjMNpsoi2XrUn/Jn6K
        dMrRsL14qtq5d3cxkNcOSTt49JLsli8QTB7bNK8qXeaYMmiHcOgZ/ms/BsbZ2ifE5dxpP0ZupGU
        555tOMdubi8v04IZuQl8YS5Wi7f5gzX049/15Qg1GzJwl/5zA182Gj2QC3yG0smXVK/H8eHzG7s
        r7xobSAsPEFD+rZA81DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.869200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 49F8D77C444AE5B7A90658AC01732F2132199B1FAB5ED67C23492C1E3804DE542000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported resolution and fps of different platforms are not the
same. Need to set the supported level according to the chip name.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index b15ed773374f..02985184fa0f 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -113,6 +113,15 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
 		},
 		.codec_type = V4L2_PIX_FMT_VP9_FRAME,
 	},
+	{
+		.cfg = {
+			.id = V4L2_CID_MPEG_VIDEO_VP9_LEVEL,
+			.min = V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
+			.def = V4L2_MPEG_VIDEO_VP9_LEVEL_4_0,
+			.max = V4L2_MPEG_VIDEO_VP9_LEVEL_4_1,
+		},
+		.codec_type = V4L2_PIX_FMT_VP9_FRAME,
+	},
 	{
 		.cfg = {
 			.id = V4L2_CID_STATELESS_HEVC_SPS,
@@ -601,6 +610,26 @@ static void mtk_vcodec_dec_fill_h265_profile(struct v4l2_ctrl_config *cfg,
 	};
 }
 
+static void mtk_vcodec_dec_fill_vp9_level(struct v4l2_ctrl_config *cfg,
+					  struct mtk_vcodec_dec_ctx *ctx)
+{
+	switch (ctx->dev->chip_name) {
+	case MTK_VDEC_MT8188:
+	case MTK_VDEC_MT8195:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_5_1;
+		break;
+	case MTK_VDEC_MT8192:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_5_0;
+		break;
+	case MTK_VDEC_MT8186:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_4_1;
+		break;
+	default:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_4_0;
+		break;
+	};
+}
+
 static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
 					  struct mtk_vcodec_dec_ctx *ctx)
 {
@@ -613,6 +642,10 @@ static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
 		mtk_vcodec_dec_fill_h265_level(cfg, ctx);
 		mtk_v4l2_vdec_dbg(3, ctx, "h265 supported level: %lld %lld", cfg->max, cfg->def);
 		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
+		mtk_vcodec_dec_fill_vp9_level(cfg, ctx);
+		mtk_v4l2_vdec_dbg(3, ctx, "vp9 supported level: %lld %lld", cfg->max, cfg->def);
+		break;
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 		mtk_vcodec_dec_fill_h264_profile(cfg, ctx);
 		mtk_v4l2_vdec_dbg(3, ctx, "h264 supported profile: %lld %lld", cfg->max,
-- 
2.18.0

