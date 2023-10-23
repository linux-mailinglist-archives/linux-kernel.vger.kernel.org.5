Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8C7D28D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjJWDHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjJWDHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:07:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA95D5B;
        Sun, 22 Oct 2023 20:06:58 -0700 (PDT)
X-UUID: 35efed30715111eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zVpmT6FxDwJsrBSbvJyTCp9xIHxx5/4HOLtvJV6levk=;
        b=XwBl793NEG3dBHQGHDmz3S6Goy+bAyVp0ynkZUqJGCepPei6ijE2BfJ71ix3D8YDeHdhzC09jRK6CacQpt4tmKDhBlUv93BIV9x5tK8czYAp13LmgyD0LMvCkSX/f2YwD6BqcAz2Q25swNS/96y6aK2Axt/01WRGWtN/Itmj/1s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ad485b6c-6f92-4f01-bc70-db922bc15888,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8e6230d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 35efed30715111eea33bb35ae8d461a2-20231023
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 96432555; Mon, 23 Oct 2023 11:06:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 11:06:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 11:06:47 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
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
Subject: [PATCH v2,6/7] media: mediatek: vcodec: Set the supported vp9 level for each platform
Date:   Mon, 23 Oct 2023 11:06:39 +0800
Message-ID: <20231023030640.16393-7-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023030640.16393-1-yunfei.dong@mediatek.com>
References: <20231023030640.16393-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.983200-8.000000
X-TMASE-MatchedRID: iCbNFKe75FjnWmH8Qoh70pyBsp6+TmyGjiWciALpTNMx3z93vsEFGtvM
        SB0gigG5ThbvLLI8RvNELJsmoli+adAjTMr/wDJyFp8tduyF+iC2McZY43zJ423D6f6IpbLI2ug
        QZCK503JPN9Ds5e3i44Ay6p60ZV62fJ5/bZ6npdiujVRFkkVsmyMHa3Cnrmnvr9Qtj+WbdnoExP
        333s+6T59oJbLvgyEgl5rvPYMic2rKKOiar1G+1/VY2XWHPqpnLxQDRLNsvk2n4W5Hf9z78m1Rj
        oup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnoxXsgQSqx49gY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.983200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D7E391B8B2E2864A25DD15FB509BE6CF248AB038746AD37B7F694E7069E1CDDD2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the maximum VP9 codec level for each platform.
The various mediatek platforms support different levels for decoding, the
level of the codec limits among others the maximum resolution, bit rate,
frame rate and compression rate for the decoder.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index 816709fe0f18..eb8590edb579 100644
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
@@ -603,6 +612,26 @@ static void mtk_vcodec_dec_fill_h265_profile(struct v4l2_ctrl_config *cfg,
 	};
 }
 
+static void mtk_vcodec_dec_fill_vp9_level(struct v4l2_ctrl_config *cfg,
+					  struct mtk_vcodec_dec_ctx *ctx)
+{
+	switch (ctx->dev->chip_name) {
+	case MTK_VDEC_MT8192:
+	case MTK_VDEC_MT8188:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_5_1;
+		break;
+	case MTK_VDEC_MT8195:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_LEVEL_5_2;
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
@@ -615,6 +644,10 @@ static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
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

