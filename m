Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE679B085
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358620AbjIKWMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbjIKNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:00:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831BE50;
        Mon, 11 Sep 2023 05:59:56 -0700 (PDT)
X-UUID: 1874652a50a311eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tKlHvN5/G1frDG7GgPVmMjQ8CSmun7vd2dASfS/alS8=;
        b=dk8fw5oO/YP3nRzbXwRHpyZ3/YKIqkP34FMaqSifFZVMoM2UYsEQWijB99WPXFPOxpWSwDmbYXRKjzEiiJcyP+SqatFks4xukSpwCyq1d6Z2sIM3mhcuZfyMo1UAcETMOgYVz8rQ8jqLaKvsyZo5x0AYOo3N4YDP0nyartiyolQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:da9cb164-9104-4aa8-8c15-a737d2620425,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:dc17b4be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1874652a50a311eea33bb35ae8d461a2-20230911
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1580286477; Mon, 11 Sep 2023 20:59:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 20:59:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 20:59:49 +0800
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
        Steve Cho <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder driver
Date:   Mon, 11 Sep 2023 20:59:34 +0800
Message-ID: <20230911125936.10648-13-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911125936.10648-1-yunfei.dong@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
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

Setting secure mode flag to kernel when trying to play secure video,
then decoder driver will initialize tee related interface to support
svp.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15 ++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
 include/uapi/linux/v4l2-controls.h                |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index d2b09ce9f1cf..a981178c25d9 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
 		ctrl->val = mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
 		mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d => 0x%x", sec_fd, ctrl->val);
 		break;
+	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
+		ctx->is_svp_mode = ctrl->val;
+
+		if (ctx->is_svp_mode) {
+			ret = mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
+			if (ret)
+				mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
+			else
+				mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl->val);
+		}
+		break;
 	default:
 		mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id: 0x%x\n", hdr_ctrl->id);
 		return ret;
@@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 	unsigned int i;
 	struct v4l2_ctrl *ctrl;
 
-	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
+	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
 	if (ctx->ctrl_hdl.error) {
 		mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
 		return ctx->ctrl_hdl.error;
@@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 
 	ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl, &mtk_vcodec_dec_ctrl_ops,
 				 V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
+	ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl, &mtk_vcodec_dec_ctrl_ops,
+				 V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
 
 	v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
 
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index d8cf01f76aab..a507045a3f30 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return "Reference Frames for a P-Frame";
 	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		return "Prepend SPS and PPS to IDR";
 	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:		return "MediaTek Decoder get secure handle";
+	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:			return "MediaTek Decoder set secure mode";
 
 	/* AV1 controls */
 	case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:			return "AV1 Profile";
@@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*type = V4L2_CTRL_TYPE_INTEGER;
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
 		break;
+	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
+		*type = V4L2_CTRL_TYPE_INTEGER;
+		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
+		break;
 	case V4L2_CID_USER_CLASS:
 	case V4L2_CID_CAMERA_CLASS:
 	case V4L2_CID_CODEC_CLASS:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 7b3694985366..88e90d943e38 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
 /*  MPEG-class control IDs specific to the MediaTek Decoder driver as defined by V4L2 */
 #define V4L2_CID_MPEG_MTK_BASE			(V4L2_CTRL_CLASS_CODEC | 0x2000)
 #define V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE	(V4L2_CID_MPEG_MTK_BASE+8)
+#define V4L2_CID_MPEG_MTK_SET_SECURE_MODE	(V4L2_CID_MPEG_MTK_BASE+9)
 
 /*  Camera class control IDs */
 
-- 
2.18.0

