Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2181767BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjG2Dlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbjG2Dl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:41:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069B46A9;
        Fri, 28 Jul 2023 20:41:24 -0700 (PDT)
X-UUID: c6d29b8c2dc111ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TPr7sXgdlH3VNKL6uLkPjL/MuPJ8naNc1jeRgaa1pVM=;
        b=SqqfDJ3JFnKTs1lSRXT77dIO4P5S1Cb8JLegmnQB/5fSBFJaGidaP6Baa/TCWOUTjV+qRSx2A+vQWBK01QaHRQwEtTsT0GPVsWsAI1gofrfAXaFATb8Ceu2abup2ZKHSrPHbzyWD+tS3cAOu83SDU5kI1appLTDiZNP4KGhGW40=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:09066f79-40c4-4e18-b200-8b1f8f951ad8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:1fcc6f8,CLOUDID:f3b7a7a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c6d29b8c2dc111ee9cb5633481061a41-20230729
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 80973255; Sat, 29 Jul 2023 11:41:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 11:41:16 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 11:41:15 +0800
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
        "Mingjia Zhang" <mingjia.zhang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,3/3] media: mediatek: vcodec: Add driver to support 10bit
Date:   Sat, 29 Jul 2023 11:41:12 +0800
Message-ID: <20230729034112.16993-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729034112.16993-1-yunfei.dong@mediatek.com>
References: <20230729034112.16993-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingjia Zhang <mingjia.zhang@mediatek.com>

Adding to support capture formats V4L2_PIX_FMT_MT2110T and
V4L2_PIX_FMT_MT2110R for 10bit playback. Need to get the size
of each plane again when user space setting syntax to get 10bit
information.

V4L2_PIX_FMT_MT2110T for AV1/VP9/HEVC.
V4L2_PIX_FMT_MT2110R for H264.

Signed-off-by: Mingjia Zhang <mingjia.zhang@mediatek.com>
Co-developed-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  22 ++-
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   5 +
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 144 +++++++++++++++++-
 3 files changed, 167 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 5acb7dff18f2..91ed576d6821 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -37,7 +37,9 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_dec_ctx *ctx, int format_inde
 {
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
+	struct mtk_q_data *q_data;
 	int num_frame_count = 0, i;
+	bool ret = false;
 
 	fmt = &dec_pdata->vdec_formats[format_index];
 	for (i = 0; i < *dec_pdata->num_formats; i++) {
@@ -47,10 +49,26 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_dec_ctx *ctx, int format_inde
 		num_frame_count++;
 	}
 
-	if (num_frame_count == 1 || fmt->fourcc == V4L2_PIX_FMT_MM21)
+	if (num_frame_count == 1 || (!ctx->is_10bit_bitstream && fmt->fourcc == V4L2_PIX_FMT_MM21))
 		return true;
 
-	return false;
+	q_data = &ctx->q_data[MTK_Q_DATA_SRC];
+	switch (q_data->fmt->fourcc) {
+	case V4L2_PIX_FMT_H264_SLICE:
+		if (ctx->is_10bit_bitstream && fmt->fourcc == V4L2_PIX_FMT_MT2110R)
+			ret = true;
+		break;
+	case V4L2_PIX_FMT_VP9_FRAME:
+	case V4L2_PIX_FMT_AV1_FRAME:
+	case V4L2_PIX_FMT_HEVC_SLICE:
+		if (ctx->is_10bit_bitstream && fmt->fourcc == V4L2_PIX_FMT_MT2110T)
+			ret = true;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
 }
 
 static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx *ctx,
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index aa49969c54c1..6c318de25a55 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -31,6 +31,7 @@ enum mtk_vdec_format_types {
 	MTK_VDEC_FORMAT_AV1_FRAME = 0x800,
 	MTK_VDEC_FORMAT_HEVC_FRAME = 0x1000,
 	MTK_VCODEC_INNER_RACING = 0x20000,
+	MTK_VDEC_IS_SUPPORT_10BIT = 0x40000,
 };
 
 /*
@@ -160,6 +161,8 @@ struct mtk_vcodec_dec_pdata {
  * @hw_id: hardware index used to identify different hardware.
  *
  * @msg_queue: msg queue used to store lat buffer information.
+ *
+ * @is_10bit_bitstream: set to true if it's 10bit bitstream
  */
 struct mtk_vcodec_dec_ctx {
 	enum mtk_instance_type type;
@@ -202,6 +205,8 @@ struct mtk_vcodec_dec_ctx {
 	int hw_id;
 
 	struct vdec_msg_queue msg_queue;
+
+	bool is_10bit_bitstream;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index 99a84c7e1901..e29c9c58f3da 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -200,7 +200,7 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
 
 #define NUM_CTRLS ARRAY_SIZE(mtk_stateless_controls)
 
-static struct mtk_video_fmt mtk_video_formats[7];
+static struct mtk_video_fmt mtk_video_formats[9];
 
 static struct mtk_video_fmt default_out_format;
 static struct mtk_video_fmt default_cap_format;
@@ -387,6 +387,138 @@ static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
 	return vdec_if_decode(ctx, NULL, NULL, &res_chg);
 }
 
+static int mtk_vcodec_get_pic_info(struct mtk_vcodec_dec_ctx *ctx)
+{
+	struct mtk_q_data *q_data;
+	int ret = 0;
+
+	q_data = &ctx->q_data[MTK_Q_DATA_DST];
+	if (q_data->fmt->num_planes == 1) {
+		mtk_v4l2_vdec_err(ctx, "[%d]Error!! 10bit mode not support one plane", ctx->id);
+		return -EINVAL;
+	}
+
+	ctx->capture_fourcc = q_data->fmt->fourcc;
+	ret = vdec_if_get_param(ctx, GET_PARAM_PIC_INFO, &ctx->picinfo);
+	if (ret) {
+		mtk_v4l2_vdec_err(ctx, "[%d]Error!! Get GET_PARAM_PICTURE_INFO Fail", ctx->id);
+		return ret;
+	}
+
+	ctx->last_decoded_picinfo = ctx->picinfo;
+
+	q_data->sizeimage[0] = ctx->picinfo.fb_sz[0];
+	q_data->bytesperline[0] = ctx->picinfo.buf_w * 5 / 4;
+
+	q_data->sizeimage[1] = ctx->picinfo.fb_sz[1];
+	q_data->bytesperline[1] = ctx->picinfo.buf_w * 5 / 4;
+
+	q_data->coded_width = ctx->picinfo.buf_w;
+	q_data->coded_height = ctx->picinfo.buf_h;
+	mtk_v4l2_vdec_dbg(1, ctx, "[%d] wxh=%dx%d pic wxh=%dx%d sz[0]=0x%x sz[1]=0x%x",
+			  ctx->id, ctx->picinfo.buf_w, ctx->picinfo.buf_h,
+			  ctx->picinfo.pic_w, ctx->picinfo.pic_h,
+			  q_data->sizeimage[0], q_data->sizeimage[1]);
+
+	return ret;
+}
+
+static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct mtk_vcodec_dec_ctx *ctx = ctrl_to_dec_ctx(ctrl);
+	struct v4l2_ctrl_h264_sps *h264;
+	struct v4l2_ctrl_hevc_sps *h265;
+	struct v4l2_ctrl_vp9_frame *frame;
+	struct v4l2_ctrl_av1_sequence *seq;
+	struct v4l2_ctrl *hdr_ctrl;
+	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
+	const struct mtk_video_fmt *fmt;
+	int i = 0, ret = 0;
+
+	hdr_ctrl = ctrl;
+	if (!hdr_ctrl || !hdr_ctrl->p_new.p)
+		return -EINVAL;
+
+	switch (hdr_ctrl->id) {
+	case V4L2_CID_STATELESS_H264_SPS:
+		h264 = (struct v4l2_ctrl_h264_sps *)hdr_ctrl->p_new.p;
+
+		if (h264->bit_depth_chroma_minus8 == 2 && h264->bit_depth_luma_minus8 == 2) {
+			ctx->is_10bit_bitstream = true;
+		} else if (h264->bit_depth_chroma_minus8 != 0 &&
+			   h264->bit_depth_luma_minus8 != 0) {
+			mtk_v4l2_vdec_err(ctx, "H264: chroma_minus8:%d, luma_minus8:%d",
+					  h264->bit_depth_chroma_minus8,
+					  h264->bit_depth_luma_minus8);
+			return -EINVAL;
+		}
+		break;
+	case V4L2_CID_STATELESS_HEVC_SPS:
+		h265 = (struct v4l2_ctrl_hevc_sps *)hdr_ctrl->p_new.p;
+
+		if (h265->bit_depth_chroma_minus8 == 2 && h265->bit_depth_luma_minus8 == 2) {
+			ctx->is_10bit_bitstream = true;
+		} else if (h265->bit_depth_chroma_minus8 != 0 &&
+			   h265->bit_depth_luma_minus8 != 0) {
+			mtk_v4l2_vdec_err(ctx, "HEVC: chroma_minus8:%d, luma_minus8:%d",
+					  h265->bit_depth_chroma_minus8,
+					  h265->bit_depth_luma_minus8);
+			return -EINVAL;
+		}
+		break;
+	case V4L2_CID_STATELESS_VP9_FRAME:
+		frame = (struct v4l2_ctrl_vp9_frame *)hdr_ctrl->p_new.p;
+
+		if (frame->bit_depth == 10) {
+			ctx->is_10bit_bitstream = true;
+		} else if (frame->bit_depth != 8) {
+			mtk_v4l2_vdec_err(ctx, "VP9: bit_depth:%d", frame->bit_depth);
+			return -EINVAL;
+		}
+		break;
+	case V4L2_CID_STATELESS_AV1_SEQUENCE:
+		seq = (struct v4l2_ctrl_av1_sequence *)hdr_ctrl->p_new.p;
+
+		if (seq->bit_depth == 10) {
+			ctx->is_10bit_bitstream = true;
+		} else if (seq->bit_depth != 8) {
+			mtk_v4l2_vdec_err(ctx, "AV1: bit_depth:%d", seq->bit_depth);
+			return -EINVAL;
+		}
+		break;
+	default:
+		mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id: 0x%x\n", hdr_ctrl->id);
+		return ret;
+	}
+
+	if (!ctx->is_10bit_bitstream)
+		return ret;
+
+	for (i = 0; i < *dec_pdata->num_formats; i++) {
+		fmt = &dec_pdata->vdec_formats[i];
+		if (fmt->fourcc == V4L2_PIX_FMT_MT2110R &&
+		    hdr_ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
+			ctx->q_data[MTK_Q_DATA_DST].fmt = fmt;
+			break;
+		}
+
+		if (fmt->fourcc == V4L2_PIX_FMT_MT2110T &&
+		    (hdr_ctrl->id == V4L2_CID_STATELESS_HEVC_SPS ||
+		    hdr_ctrl->id == V4L2_CID_STATELESS_VP9_FRAME ||
+		    hdr_ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE)) {
+			ctx->q_data[MTK_Q_DATA_DST].fmt = fmt;
+			break;
+		}
+	}
+	ret = mtk_vcodec_get_pic_info(ctx);
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl_ops = {
+	.s_ctrl = mtk_vdec_s_ctrl,
+};
+
 static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int i;
@@ -399,7 +531,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 
 	for (i = 0; i < NUM_CTRLS; i++) {
 		struct v4l2_ctrl_config cfg = mtk_stateless_controls[i].cfg;
-
+		cfg.ops = &mtk_vcodec_dec_ctrl_ops;
 		v4l2_ctrl_new_custom(&ctx->ctrl_hdl, &cfg, NULL);
 		if (ctx->ctrl_hdl.error) {
 			mtk_v4l2_vdec_err(ctx, "Adding control %d failed %d", i,
@@ -466,6 +598,8 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 		break;
 	case V4L2_PIX_FMT_MM21:
 	case V4L2_PIX_FMT_MT21C:
+	case V4L2_PIX_FMT_MT2110T:
+	case V4L2_PIX_FMT_MT2110R:
 		mtk_video_formats[count_formats].fourcc = fourcc;
 		mtk_video_formats[count_formats].type = MTK_FMT_FRAME;
 		mtk_video_formats[count_formats].num_planes = 2;
@@ -491,6 +625,12 @@ static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_dec_ctx *ctx)
 		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT21C, ctx);
 		cap_format_count++;
 	}
+	if (ctx->dev->dec_capability & MTK_VDEC_IS_SUPPORT_10BIT) {
+		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT2110T, ctx);
+		cap_format_count++;
+		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT2110R, ctx);
+		cap_format_count++;
+	}
 	if (ctx->dev->dec_capability & MTK_VDEC_FORMAT_MM21) {
 		mtk_vcodec_add_formats(V4L2_PIX_FMT_MM21, ctx);
 		cap_format_count++;
-- 
2.18.0

