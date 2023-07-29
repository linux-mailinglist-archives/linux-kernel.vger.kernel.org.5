Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF7767BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjG2Cz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjG2Czd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:55:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7C649EA;
        Fri, 28 Jul 2023 19:55:28 -0700 (PDT)
X-UUID: 5bf0a40e2dbb11ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YeeacyBhCdDwLmOrR/1PaNk4T3LB4pN97OG779vLTCo=;
        b=kKDnVGOS8psdY+GWz04V/RhPL2bvBhym6gwbsPZkHMn3FYi+b7M6tfIlyewhGFG7/GA8JJLh6e62h16cocxUwb271ro1rUf0WVeZ/Pln84L/kVmq6mw5WwrP5rniHhhvSUyELyf4j4iY/Z67KFQ9OtTAZMm3u9hfw6/472nO5PY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:7a17d9b6-e651-4881-849c-c60cbdee8135,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:7a17d9b6-e651-4881-849c-c60cbdee8135,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:8c84a7a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230729105523ETOKCL5J,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: 5bf0a40e2dbb11ee9cb5633481061a41-20230729
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1683979861; Sat, 29 Jul 2023 10:55:21 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 10:55:20 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 10:55:19 +0800
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
Subject: [PATCH v8,04/11] media: mediatek: vcodec: Removing useless debug log
Date:   Sat, 29 Jul 2023 10:55:07 +0800
Message-ID: <20230729025515.16029-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729025515.16029-1-yunfei.dong@mediatek.com>
References: <20230729025515.16029-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing unresonable and useless debug log enter and leave
in order to simply the log message.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  1 -
 .../mediatek/vcodec/mtk_vcodec_util.h         |  6 -----
 .../mediatek/vcodec/vdec/vdec_h264_if.c       |  4 ----
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  4 ----
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |  2 --
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  2 --
 .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  2 --
 .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  2 --
 .../platform/mediatek/vcodec/vdec_vpu_if.c    |  6 -----
 .../mediatek/vcodec/venc/venc_h264_if.c       | 22 -------------------
 .../mediatek/vcodec/venc/venc_vp8_if.c        | 22 -------------------
 .../platform/mediatek/vcodec/venc_vpu_if.c    | 21 ++++--------------
 12 files changed, 4 insertions(+), 90 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 8a75d28e9692..805f8afbd26a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -459,7 +459,6 @@ static void mtk_vcodec_enc_remove(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dev *dev = platform_get_drvdata(pdev);
 
-	mtk_v4l2_debug_enter();
 	destroy_workqueue(dev->encode_workqueue);
 	if (dev->m2m_dev_enc)
 		v4l2_m2m_release(dev->m2m_dev_enc);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 7f12ba82a5f4..1f24114c5fb0 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -62,12 +62,6 @@ extern int mtk_vcodec_dbg;
 		((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
 #endif
 
-#define mtk_v4l2_debug_enter()  mtk_v4l2_debug(3, "+")
-#define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
-
-#define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
-#define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")
-
 void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx);
 int mtk_vcodec_write_vdecsys(struct mtk_vcodec_ctx *ctx, unsigned int reg, unsigned int val);
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
index 481655bb6016..24312a90afbb 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
@@ -156,8 +156,6 @@ static void free_predication_buf(struct vdec_h264_inst *inst)
 {
 	struct mtk_vcodec_mem *mem = NULL;
 
-	mtk_vcodec_debug_enter(inst);
-
 	inst->vsi->pred_buf_dma = 0;
 	mem = &inst->pred_buf;
 	if (mem->va)
@@ -311,8 +309,6 @@ static void vdec_h264_deinit(void *h_vdec)
 {
 	struct vdec_h264_inst *inst = (struct vdec_h264_inst *)h_vdec;
 
-	mtk_vcodec_debug_enter(inst);
-
 	vpu_dec_deinit(&inst->vpu);
 	free_predication_buf(inst);
 	free_mv_buf(inst);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index 4bc05ab5afea..dc6ee266f232 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -174,8 +174,6 @@ static void free_predication_buf(struct vdec_h264_slice_inst *inst)
 {
 	struct mtk_vcodec_mem *mem = &inst->pred_buf;
 
-	mtk_vcodec_debug_enter(inst);
-
 	inst->vsi_ctx.pred_buf_dma = 0;
 	if (mem->va)
 		mtk_vcodec_mem_free(inst->ctx, mem);
@@ -322,8 +320,6 @@ static void vdec_h264_slice_deinit(void *h_vdec)
 {
 	struct vdec_h264_slice_inst *inst = h_vdec;
 
-	mtk_vcodec_debug_enter(inst);
-
 	vpu_dec_deinit(&inst->vpu);
 	free_predication_buf(inst);
 	free_mv_buf(inst);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index a7e8e3257b7f..3cb5b967f48a 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -444,8 +444,6 @@ static void vdec_h264_slice_deinit(void *h_vdec)
 {
 	struct vdec_h264_slice_inst *inst = h_vdec;
 
-	mtk_vcodec_debug_enter(inst);
-
 	vpu_dec_deinit(&inst->vpu);
 	vdec_h264_slice_free_mv_buf(inst);
 	vdec_msg_queue_deinit(&inst->ctx->msg_queue, inst->ctx);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
index 1e6ab138b0bb..0bb5b54578e9 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
@@ -911,8 +911,6 @@ static void vdec_hevc_slice_deinit(void *h_vdec)
 	struct vdec_hevc_slice_inst *inst = h_vdec;
 	struct mtk_vcodec_mem *mem;
 
-	mtk_vcodec_debug_enter(inst);
-
 	vpu_dec_deinit(&inst->vpu);
 	vdec_hevc_slice_free_mv_buf(inst);
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index 9651f5ee20e4..c3a1fbb2e1b5 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -599,8 +599,6 @@ static void vdec_vp8_deinit(void *h_vdec)
 {
 	struct vdec_vp8_inst *inst = (struct vdec_vp8_inst *)h_vdec;
 
-	mtk_vcodec_debug_enter(inst);
-
 	vpu_dec_deinit(&inst->vpu);
 	free_working_buf(inst);
 	kfree(inst);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index e1fe2603e92e..f7181f4a4d2a 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -421,8 +421,6 @@ static void vdec_vp8_slice_deinit(void *h_vdec)
 {
 	struct vdec_vp8_slice_inst *inst = h_vdec;
 
-	mtk_vcodec_debug_enter(inst);
-
 	vpu_dec_deinit(&inst->vpu);
 	vdec_vp8_slice_free_working_buf(inst);
 	kfree(inst);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index df309e8e9379..60e5b70fa127 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -183,8 +183,6 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
 	struct vdec_ap_ipi_init msg;
 	int err;
 
-	mtk_vcodec_debug_enter(vpu);
-
 	init_waitqueue_head(&vpu->wq);
 	vpu->handler = vpu_dec_ipi_handler;
 
@@ -223,8 +221,6 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t *data, unsigned int len)
 	int i;
 	int err = 0;
 
-	mtk_vcodec_debug_enter(vpu);
-
 	if (len > ARRAY_SIZE(msg.data)) {
 		mtk_vcodec_err(vpu, "invalid len = %d\n", len);
 		return -EINVAL;
@@ -252,8 +248,6 @@ int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint32_t *data,
 	struct vdec_ap_ipi_get_param msg;
 	int err;
 
-	mtk_vcodec_debug_enter(vpu);
-
 	if (len > ARRAY_SIZE(msg.data)) {
 		mtk_vcodec_err(vpu, "invalid len = %d\n", len);
 		return -EINVAL;
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 10365c95ebbe..c821ed427537 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -298,8 +298,6 @@ static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 {
 	int i;
 
-	mtk_vcodec_debug_enter(inst);
-
 	/* Except the SKIP_FRAME buffers,
 	 * other buffers need to be freed by AP.
 	 */
@@ -309,8 +307,6 @@ static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 	}
 
 	mtk_vcodec_mem_free(inst->ctx, &inst->pps_buf);
-
-	mtk_vcodec_debug_leave(inst);
 }
 
 static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
@@ -321,8 +317,6 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
 	u32 vpua, wb_size;
 	int ret = 0;
 
-	mtk_vcodec_debug_enter(inst);
-
 	if (is_34bit)
 		wb_34 = inst->vsi_34->work_bufs;
 	else
@@ -406,8 +400,6 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
 		goto err_alloc;
 	}
 
-	mtk_vcodec_debug_leave(inst);
-
 	return ret;
 
 err_alloc:
@@ -452,8 +444,6 @@ static int h264_encode_sps(struct venc_h264_inst *inst,
 	int ret = 0;
 	unsigned int irq_status;
 
-	mtk_vcodec_debug_enter(inst);
-
 	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL, bs_buf, NULL);
 	if (ret)
 		return ret;
@@ -478,8 +468,6 @@ static int h264_encode_pps(struct venc_h264_inst *inst,
 	int ret = 0;
 	unsigned int irq_status;
 
-	mtk_vcodec_debug_enter(inst);
-
 	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL, bs_buf, NULL);
 	if (ret)
 		return ret;
@@ -531,7 +519,6 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 	struct venc_frame_info frame_info;
 	struct mtk_vcodec_ctx *ctx = inst->ctx;
 
-	mtk_vcodec_debug_enter(inst);
 	mtk_vcodec_debug(inst, "frm_cnt = %d\n ", inst->frm_cnt);
 
 	if (MTK_ENC_IOVA_IS_34BIT(ctx)) {
@@ -614,8 +601,6 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
 
-	mtk_vcodec_debug_enter(inst);
-
 	ret = vpu_enc_init(&inst->vpu_inst);
 
 	if (MTK_ENC_IOVA_IS_34BIT(ctx))
@@ -623,8 +608,6 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	else
 		inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
 
-	mtk_vcodec_debug_leave(inst);
-
 	if (ret)
 		kfree(inst);
 	else
@@ -811,8 +794,6 @@ static int h264_enc_set_param(void *handle,
 		break;
 	}
 
-	mtk_vcodec_debug_leave(inst);
-
 	return ret;
 }
 
@@ -821,14 +802,11 @@ static int h264_enc_deinit(void *handle)
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
 
-	mtk_vcodec_debug_enter(inst);
-
 	ret = vpu_enc_deinit(&inst->vpu_inst);
 
 	if (inst->work_buf_allocated)
 		h264_enc_free_work_buf(inst);
 
-	mtk_vcodec_debug_leave(inst);
 	kfree(inst);
 
 	return ret;
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index 73ebc35d7c99..ddcdb565db17 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -141,16 +141,12 @@ static void vp8_enc_free_work_buf(struct venc_vp8_inst *inst)
 {
 	int i;
 
-	mtk_vcodec_debug_enter(inst);
-
 	/* Buffers need to be freed by AP. */
 	for (i = 0; i < VENC_VP8_VPU_WORK_BUF_MAX; i++) {
 		if (inst->work_bufs[i].size == 0)
 			continue;
 		mtk_vcodec_mem_free(inst->ctx, &inst->work_bufs[i]);
 	}
-
-	mtk_vcodec_debug_leave(inst);
 }
 
 static int vp8_enc_alloc_work_buf(struct venc_vp8_inst *inst)
@@ -159,8 +155,6 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_inst *inst)
 	int ret = 0;
 	struct venc_vp8_vpu_buf *wb = inst->vsi->work_bufs;
 
-	mtk_vcodec_debug_enter(inst);
-
 	for (i = 0; i < VENC_VP8_VPU_WORK_BUF_MAX; i++) {
 		if (wb[i].size == 0)
 			continue;
@@ -206,8 +200,6 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_inst *inst)
 				 inst->work_bufs[i].size);
 	}
 
-	mtk_vcodec_debug_leave(inst);
-
 	return ret;
 
 err_alloc:
@@ -338,14 +330,10 @@ static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->vpu_inst.id = IPI_VENC_VP8;
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_LT_SYS);
 
-	mtk_vcodec_debug_enter(inst);
-
 	ret = vpu_enc_init(&inst->vpu_inst);
 
 	inst->vsi = (struct venc_vp8_vsi *)inst->vpu_inst.vsi;
 
-	mtk_vcodec_debug_leave(inst);
-
 	if (ret)
 		kfree(inst);
 	else
@@ -364,8 +352,6 @@ static int vp8_enc_encode(void *handle,
 	struct venc_vp8_inst *inst = (struct venc_vp8_inst *)handle;
 	struct mtk_vcodec_ctx *ctx = inst->ctx;
 
-	mtk_vcodec_debug_enter(inst);
-
 	enable_irq(ctx->dev->enc_irq);
 
 	switch (opt) {
@@ -386,8 +372,6 @@ static int vp8_enc_encode(void *handle,
 encode_err:
 
 	disable_irq(ctx->dev->enc_irq);
-	mtk_vcodec_debug_leave(inst);
-
 	return ret;
 }
 
@@ -437,8 +421,6 @@ static int vp8_enc_set_param(void *handle,
 		break;
 	}
 
-	mtk_vcodec_debug_leave(inst);
-
 	return ret;
 }
 
@@ -447,16 +429,12 @@ static int vp8_enc_deinit(void *handle)
 	int ret = 0;
 	struct venc_vp8_inst *inst = (struct venc_vp8_inst *)handle;
 
-	mtk_vcodec_debug_enter(inst);
-
 	ret = vpu_enc_deinit(&inst->vpu_inst);
 
 	if (inst->work_buf_allocated)
 		vp8_enc_free_work_buf(inst);
 
-	mtk_vcodec_debug_leave(inst);
 	kfree(inst);
-
 	return ret;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
index 09e7eaa25aab..63ebab28242c 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
@@ -55,8 +55,10 @@ static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv)
 
 	vpu->signaled = 1;
 	vpu->failure = (msg->status != VENC_IPI_MSG_STATUS_OK);
-	if (vpu->failure)
-		goto failure;
+	if (vpu->failure) {
+		mtk_vcodec_err(vpu, "vpu enc status failure %d", vpu->failure);
+		return;
+	}
 
 	switch (msg->msg_id) {
 	case VPU_IPIMSG_ENC_INIT_DONE:
@@ -73,9 +75,6 @@ static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv)
 		mtk_vcodec_err(vpu, "unknown msg id %x", msg->msg_id);
 		break;
 	}
-
-failure:
-	mtk_vcodec_debug_leave(vpu);
 }
 
 static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, void *msg,
@@ -83,8 +82,6 @@ static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, void *msg,
 {
 	int status;
 
-	mtk_vcodec_debug_enter(vpu);
-
 	if (!vpu->ctx->dev->fw_handler) {
 		mtk_vcodec_err(vpu, "inst dev is NULL");
 		return -EINVAL;
@@ -100,8 +97,6 @@ static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, void *msg,
 	if (vpu->failure)
 		return -EINVAL;
 
-	mtk_vcodec_debug_leave(vpu);
-
 	return 0;
 }
 
@@ -110,8 +105,6 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
 	int status;
 	struct venc_ap_ipi_msg_init out;
 
-	mtk_vcodec_debug_enter(vpu);
-
 	init_waitqueue_head(&vpu->wq_hd);
 	vpu->signaled = 0;
 	vpu->failure = 0;
@@ -132,8 +125,6 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
 		return -EINVAL;
 	}
 
-	mtk_vcodec_debug_leave(vpu);
-
 	return 0;
 }
 
@@ -345,8 +336,6 @@ int vpu_enc_deinit(struct venc_vpu_inst *vpu)
 {
 	struct venc_ap_ipi_msg_deinit out;
 
-	mtk_vcodec_debug_enter(vpu);
-
 	memset(&out, 0, sizeof(out));
 	out.msg_id = AP_IPIMSG_ENC_DEINIT;
 	out.vpu_inst_addr = vpu->inst_addr;
@@ -355,7 +344,5 @@ int vpu_enc_deinit(struct venc_vpu_inst *vpu)
 		return -EINVAL;
 	}
 
-	mtk_vcodec_debug_leave(vpu);
-
 	return 0;
 }
-- 
2.18.0

