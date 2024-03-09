Return-Path: <linux-kernel+bounces-97929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879E8771D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2ED6B20FFC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74B44C89;
	Sat,  9 Mar 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ea+O0HwE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407528DDC;
	Sat,  9 Mar 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996932; cv=none; b=k37dtgxXbmCNENKrT0W1ip6mKkYnOeYeXGYDetZ4Oa4HSDsqlodA3K7MyQB6P0eRh71j7AS1XwzbiQiZORpH1IfqPfIfSHJs647aBqY0RHgYQUXEkHJhPHmvDOlFchKm6pkan7Fp9gNKQLIqO0nWqrkM+R0mq6/8uVcNTQGpacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996932; c=relaxed/simple;
	bh=uU7ao7rV1FBzwX0cWf6YTN56+z6N6VTsDO+CnAPAi/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUkAuaXmAywglAoI4AM0ABYvu71Um4AsANqRsC42Fsnov1UQKArYAjY4LqcOtmA0GDSmAt0GSQMrY9Nq6cMblq8myedVKCEPWlQ/M1SiUuv6HJCo4Vs0ras6WRryddEkN+pTlQdzVL76PNOElli7D28z4h2eL8lRr5Gse0JLfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ea+O0HwE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709996921;
	bh=uU7ao7rV1FBzwX0cWf6YTN56+z6N6VTsDO+CnAPAi/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ea+O0HwEs+b1Vw7hzcVTkQStwqThUc00zBz9JHKTdMER+netITxpEYjqNh3/8QSFJ
	 CvRm0WFm45QdFETNoeFaBqS/s40qPiQT2+oLJ6yAZm4yXG1IV2wHafKD59cEXTTKrj
	 YYfuUtCyiv1yTHtRxC007mYoHiwwUFSgTclkemWaA3IdFsDkLyjkR0XszASuXt7rQR
	 Sk2eW182i34yA38KlvoE4O54QaaGQ4B4n9htGtC7bodD1qfrDHZS5axSUO9K10TOBt
	 fOs6vYveb9SZvfFx9zg6D5Vz7rkdIknHhWHBYtE27tlCDsqEYmctzYFXXWGiIshba9
	 8+jtgUN4dDbBg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AAF45378203F;
	Sat,  9 Mar 2024 15:08:41 +0000 (UTC)
From: Sebastian Fricke <sebastian.fricke@collabora.com>
Date: Sat, 09 Mar 2024 16:08:37 +0100
Subject: [PATCH 1/3] media: mediatek: vcodec: Fix multiple typos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-mediatek-typos-v1-1-fa4aeb59306c@collabora.com>
References: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709996919; l=20587;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=uU7ao7rV1FBzwX0cWf6YTN56+z6N6VTsDO+CnAPAi/U=;
 b=NxzYY+leQto7/UmJSwZ/r3fNynISwDVy/UBGeLahkBTNFK85+eWlZG6xuYBoo11IzFh04wBBrK8P
 hnb4E+NPAg81saPD5Q1Xl0FCZsY17SyBgvDtqtvnmjPXSxYy8uaB
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=

Correct multiple different typos found in comments or function names.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c         |  2 +-
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c        | 20 ++++++++++----------
 .../mediatek/vcodec/decoder/vdec/vdec_h264_if.c      | 12 ++++++------
 .../vcodec/decoder/vdec/vdec_h264_req_common.h       |  4 ++--
 .../mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c  | 14 +++++++-------
 .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c     |  4 ++--
 .../vcodec/decoder/vdec/vdec_hevc_req_multi_if.c     |  2 +-
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_if.c       |  4 ++--
 .../mediatek/vcodec/decoder/vdec_msg_queue.h         |  4 ++--
 .../platform/mediatek/vcodec/decoder/vdec_vpu_if.h   |  4 ++--
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.c         |  2 +-
 .../platform/mediatek/vcodec/encoder/venc_drv_if.h   |  2 +-
 13 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index ba742f0e391d..9107707de6c4 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -262,7 +262,7 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
 		int tmp_w, tmp_h;
 
 		/*
-		 * Find next closer width align 64, heign align 64, size align
+		 * Find next closer width align 64, height align 64, size align
 		 * 64 rectangle
 		 * Note: This only get default value, the real HW needed value
 		 *       only available when ctx in MTK_STATE_HEADER state
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index 849b89dd205c..a0451116f2e4 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -67,7 +67,7 @@ enum mtk_vdec_hw_arch {
  * @pic_w: picture width
  * @pic_h: picture height
  * @buf_w: picture buffer width (64 aligned up from pic_w)
- * @buf_h: picture buffer heiht (64 aligned up from pic_h)
+ * @buf_h: picture buffer height (64 aligned up from pic_h)
  * @fb_sz: bitstream size of each plane
  * E.g. suppose picture size is 176x144,
  *      buffer size will be aligned to 176x160.
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
index 2b6a5adbc419..a081e12d67d6 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
@@ -326,7 +326,7 @@ struct vdec_av1_slice_quantization {
  * @use_lr:                     whether to use loop restoration
  * @use_chroma_lr:              whether to use chroma loop restoration
  * @frame_restoration_type:     specifies the type of restoration used for each plane
- * @loop_restoration_size:      pecifies the size of loop restoration units in units
+ * @loop_restoration_size:      specifies the size of loop restoration units in units
  *                              of samples in the current plane
  */
 struct vdec_av1_slice_lr {
@@ -347,7 +347,7 @@ struct vdec_av1_slice_lr {
  *                              and loop_filter_sharpness together determine when
  *                              a block edge is filtered, and by how much the
  *                              filtering can change the sample values
- * @loop_filter_delta_enabled:  filetr level depends on the mode and reference
+ * @loop_filter_delta_enabled:  filter level depends on the mode and reference
  *                              frame used to predict a block
  */
 struct vdec_av1_slice_loop_filter {
@@ -392,7 +392,7 @@ struct vdec_av1_slice_mfmv {
 /**
  * struct vdec_av1_slice_tile - AV1 Tile info
  * @tile_cols:                  specifies the number of tiles across the frame
- * @tile_rows:                  pecifies the number of tiles down the frame
+ * @tile_rows:                  specifies the number of tiles down the frame
  * @mi_col_starts:              an array specifying the start column
  * @mi_row_starts:              an array specifying the start row
  * @context_update_tile_id:     specifies which tile to use for the CDF update
@@ -423,15 +423,15 @@ struct vdec_av1_slice_tile {
  *                              or the tile sizes are coded
  * @interpolation_filter:       specifies the filter selection used for performing inter prediction
  * @allow_warped_motion:        motion_mode may be present or not
- * @is_motion_mode_switchable : euqlt to 0 specifies that only the SIMPLE motion mode will be used
+ * @is_motion_mode_switchable : equal to 0 specifies that only the SIMPLE motion mode will be used
  * @reference_mode :            frame reference mode selected
  * @allow_high_precision_mv:    specifies that motion vectors are specified to
  *                              quarter pel precision or to eighth pel precision
- * @allow_intra_bc:             ubducates that intra block copy may be used in this frame
+ * @allow_intra_bc:             allows that intra block copy may be used in this frame
  * @force_integer_mv:           specifies motion vectors will always be integers or
  *                              can contain fractional bits
  * @allow_screen_content_tools: intra blocks may use palette encoding
- * @error_resilient_mode:       error resislent mode is enable/disable
+ * @error_resilient_mode:       error resilient mode is enable/disable
  * @frame_type:                 specifies the AV1 frame type
  * @primary_ref_frame:          specifies which reference frame contains the CDF values
  *                              and other state that should be loaded at the start of the frame
@@ -440,8 +440,8 @@ struct vdec_av1_slice_tile {
  * @disable_cdf_update:         specified whether the CDF update in the symbol
  *                              decoding process should be disables
  * @skip_mode:                  av1 skip mode parameters
- * @seg:                        av1 segmentaon parameters
- * @delta_q_lf:                 av1 delta loop fileter
+ * @seg:                        av1 segmentation parameters
+ * @delta_q_lf:                 av1 delta loop filter
  * @quant:                      av1 Quantization params
  * @lr:                         av1 Loop Restauration parameters
  * @superres_denom:             the denominator for the upscaling ratio
@@ -450,8 +450,8 @@ struct vdec_av1_slice_tile {
  * @mfmv:                       av1 mfmv parameters
  * @tile:                       av1 Tile info
  * @frame_is_intra:             intra frame
- * @loss_less_array:            loss less array
- * @coded_loss_less:            coded lsss less
+ * @loss_less_array:            lossless array
+ * @coded_loss_less:            coded lossless
  * @mi_rows:                    size of mi unit in rows
  * @mi_cols:                    size of mi unit in cols
  */
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
index bf7dffe60d07..795cb19b075d 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
@@ -94,7 +94,7 @@ struct vdec_h264_dec_info {
  *                        AP-W/R : AP is writer/reader on this item
  *                        VPU-W/R: VPU is write/reader on this item
  * @hdr_buf      : Header parsing buffer (AP-W, VPU-R)
- * @pred_buf_dma : HW working predication buffer dma address (AP-W, VPU-R)
+ * @pred_buf_dma : HW working prediction buffer dma address (AP-W, VPU-R)
  * @mv_buf_dma   : HW working motion vector buffer dma address (AP-W, VPU-R)
  * @list_free    : free frame buffer ring list (AP-W/R, VPU-W)
  * @list_disp    : display frame buffer ring list (AP-R, VPU-W)
@@ -117,7 +117,7 @@ struct vdec_h264_vsi {
  * struct vdec_h264_inst - h264 decoder instance
  * @num_nalu : how many nalus be decoded
  * @ctx      : point to mtk_vcodec_dec_ctx
- * @pred_buf : HW working predication buffer
+ * @pred_buf : HW working prediction buffer
  * @mv_buf   : HW working motion vector buffer
  * @vpu      : VPU instance
  * @vsi      : VPU shared information
@@ -136,7 +136,7 @@ static unsigned int get_mv_buf_size(unsigned int width, unsigned int height)
 	return HW_MB_STORE_SZ * (width/MB_UNIT_LEN) * (height/MB_UNIT_LEN);
 }
 
-static int allocate_predication_buf(struct vdec_h264_inst *inst)
+static int allocate_prediction_buf(struct vdec_h264_inst *inst)
 {
 	int err = 0;
 
@@ -151,7 +151,7 @@ static int allocate_predication_buf(struct vdec_h264_inst *inst)
 	return 0;
 }
 
-static void free_predication_buf(struct vdec_h264_inst *inst)
+static void free_prediction_buf(struct vdec_h264_inst *inst)
 {
 	struct mtk_vcodec_mem *mem = NULL;
 
@@ -286,7 +286,7 @@ static int vdec_h264_init(struct mtk_vcodec_dec_ctx *ctx)
 	}
 
 	inst->vsi = (struct vdec_h264_vsi *)inst->vpu.vsi;
-	err = allocate_predication_buf(inst);
+	err = allocate_prediction_buf(inst);
 	if (err)
 		goto error_deinit;
 
@@ -308,7 +308,7 @@ static void vdec_h264_deinit(void *h_vdec)
 	struct vdec_h264_inst *inst = (struct vdec_h264_inst *)h_vdec;
 
 	vpu_dec_deinit(&inst->vpu);
-	free_predication_buf(inst);
+	free_prediction_buf(inst);
 	free_mv_buf(inst);
 
 	kfree(inst);
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
index ac82be336055..6f624c266246 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
@@ -175,7 +175,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
 				int num_valid);
 
 /**
- * mtk_vdec_h264_get_ctrl_ptr - get each CID contrl address.
+ * mtk_vdec_h264_get_ctrl_ptr - get each CID control address.
  *
  * @ctx:	v4l2 ctx
  * @id:	CID control ID
@@ -246,7 +246,7 @@ mtk_vdec_h264_copy_decode_params(struct slice_api_h264_decode_param *dst_params,
 				 const struct v4l2_h264_dpb_entry dpb[V4L2_H264_NUM_DPB_ENTRIES]);
 
 /**
- * mtk_vdec_h264_update_dpb - updata dpb list.
+ * mtk_vdec_h264_update_dpb - update dpb list.
  *
  * @dec_param:	v4l2 control decode params
  * @dpb:	dpb entry informaton
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
index 5600f1df653d..37c41b673876 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
@@ -27,7 +27,7 @@ struct mtk_h264_dec_slice_param {
 /**
  * struct vdec_h264_dec_info - decode information
  * @dpb_sz		: decoding picture buffer size
- * @resolution_changed  : resoltion change happen
+ * @resolution_changed  : resolution change happend
  * @realloc_mv_buf	: flag to notify driver to re-allocate mv buffer
  * @cap_num_planes	: number planes of capture buffer
  * @bs_dma		: Input bit-stream buffer dma address
@@ -54,7 +54,7 @@ struct vdec_h264_dec_info {
  *                        by VPU.
  *                        AP-W/R : AP is writer/reader on this item
  *                        VPU-W/R: VPU is write/reader on this item
- * @pred_buf_dma : HW working predication buffer dma address (AP-W, VPU-R)
+ * @pred_buf_dma : HW working prediction buffer dma address (AP-W, VPU-R)
  * @mv_buf_dma   : HW working motion vector buffer dma address (AP-W, VPU-R)
  * @dec          : decode information (AP-R, VPU-W)
  * @pic          : picture information (AP-R, VPU-W)
@@ -74,7 +74,7 @@ struct vdec_h264_vsi {
  * struct vdec_h264_slice_inst - h264 decoder instance
  * @num_nalu : how many nalus be decoded
  * @ctx      : point to mtk_vcodec_dec_ctx
- * @pred_buf : HW working predication buffer
+ * @pred_buf : HW working prediction buffer
  * @mv_buf   : HW working motion vector buffer
  * @vpu      : VPU instance
  * @vsi_ctx  : Local VSI data for this decoding context
@@ -154,7 +154,7 @@ static int get_vdec_decode_parameters(struct vdec_h264_slice_inst *inst)
 	return 0;
 }
 
-static int allocate_predication_buf(struct vdec_h264_slice_inst *inst)
+static int allocate_prediction_buf(struct vdec_h264_slice_inst *inst)
 {
 	int err;
 
@@ -169,7 +169,7 @@ static int allocate_predication_buf(struct vdec_h264_slice_inst *inst)
 	return 0;
 }
 
-static void free_predication_buf(struct vdec_h264_slice_inst *inst)
+static void free_prediction_buf(struct vdec_h264_slice_inst *inst)
 {
 	struct mtk_vcodec_mem *mem = &inst->pred_buf;
 
@@ -292,7 +292,7 @@ static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 	inst->vsi_ctx.dec.resolution_changed = true;
 	inst->vsi_ctx.dec.realloc_mv_buf = true;
 
-	err = allocate_predication_buf(inst);
+	err = allocate_prediction_buf(inst);
 	if (err)
 		goto error_deinit;
 
@@ -320,7 +320,7 @@ static void vdec_h264_slice_deinit(void *h_vdec)
 	struct vdec_h264_slice_inst *inst = h_vdec;
 
 	vpu_dec_deinit(&inst->vpu);
-	free_predication_buf(inst);
+	free_prediction_buf(inst);
 	free_mv_buf(inst);
 
 	kfree(inst);
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
index 0e741e0dc8ba..d5224c9584b6 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
@@ -51,7 +51,7 @@ struct vdec_h264_slice_lat_dec_param {
  * struct vdec_h264_slice_info - decode information
  *
  * @nal_info:		nal info of current picture
- * @timeout:		Decode timeout: 1 timeout, 0 no timeount
+ * @timeout:		Decode timeout: 1 timeout, 0 no timeout
  * @bs_buf_size:	bitstream size
  * @bs_buf_addr:	bitstream buffer dma address
  * @y_fb_dma:		Y frame buffer dma address
@@ -133,7 +133,7 @@ struct vdec_h264_slice_share_info {
  *
  * @slice_dec_num:	how many picture be decoded
  * @ctx:		point to mtk_vcodec_dec_ctx
- * @pred_buf:		HW working predication buffer
+ * @pred_buf:		HW working prediction buffer
  * @mv_buf:		HW working motion vector buffer
  * @vpu:		VPU instance
  * @vsi:		vsi used for lat
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
index 06ed47df693b..a44db6139ff2 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
@@ -254,7 +254,7 @@ struct vdec_hevc_slice_lat_dec_param {
  * struct vdec_hevc_slice_info - decode information
  *
  * @wdma_end_addr_offset: wdma end address offset
- * @timeout:              Decode timeout: 1 timeout, 0 no timeount
+ * @timeout:              Decode timeout: 1 timeout, 0 no timeout
  * @vdec_fb_va:           VDEC frame buffer struct virtual address
  * @crc:                  Used to check whether hardware's status is right
  */
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
index 55355fa70090..3cd542242b1d 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
@@ -41,7 +41,7 @@ struct vp9_dram_buf {
 
 /**
  * struct vp9_fb_info - contains frame buffer info
- * @fb : frmae buffer
+ * @fb : frame buffer
  * @reserved : reserved field used by vpu
  */
 struct vp9_fb_info {
@@ -89,7 +89,7 @@ struct vp9_sf_ref_fb {
  *	AP-W/R : AP is writer/reader on this item
  *	VPU-W/R: VPU is write/reader on this item
  * @sf_bs_buf : super frame backup buffer (AP-W, VPU-R)
- * @sf_ref_fb : record supoer frame reference buffer information
+ * @sf_ref_fb : record super frame reference buffer information
  *	(AP-R/W, VPU-R/W)
  * @sf_next_ref_fb_idx : next available super frame (AP-W, VPU-R)
  * @sf_frm_cnt : super frame count, filled by vpu (AP-R, VPU-W)
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
index 1d9beb9e4a14..b0f576867f4b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
@@ -158,14 +158,14 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *ctx, struct vdec_lat_buf *buf
 struct vdec_lat_buf *vdec_msg_queue_dqbuf(struct vdec_msg_queue_ctx *ctx);
 
 /**
- * vdec_msg_queue_update_ube_rptr - used to updata the ube read point.
+ * vdec_msg_queue_update_ube_rptr - used to update the ube read point.
  * @msg_queue: used to store the lat buffer information
  * @ube_rptr: current ube read point
  */
 void vdec_msg_queue_update_ube_rptr(struct vdec_msg_queue *msg_queue, uint64_t ube_rptr);
 
 /**
- * vdec_msg_queue_update_ube_wptr - used to updata the ube write point.
+ * vdec_msg_queue_update_ube_wptr - used to update the ube write point.
  * @msg_queue: used to store the lat buffer information
  * @ube_wptr: current ube write point
  */
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
index aa7d08afc2f4..57ed9b1f5eaa 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
@@ -81,7 +81,7 @@ int vpu_dec_deinit(struct vdec_vpu_inst *vpu);
 
 /**
  * vpu_dec_reset - reset decoder, use for flush decoder when end of stream or
- *                 seek. Remainig non displayed frame will be pushed to display.
+ *                 seek. Remaining non displayed frame will be pushed to display.
  *
  * @vpu: instance for vdec_vpu_inst
  */
@@ -98,7 +98,7 @@ int vpu_dec_core(struct vdec_vpu_inst *vpu);
 /**
  * vpu_dec_core_end - core end decoding, basically the function will be invoked once
  *               when core HW decoding done and receive interrupt successfully. The
- *               decoder in VPU will updata hardware information and deinit hardware
+ *               decoder in VPU will update hardware information and deinit hardware
  *               and check if there is a new decoded frame available to display.
  *
  * @vpu : instance for vdec_vpu_inst
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
index 181884e798fd..7eaf0e24c9fc 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
@@ -311,7 +311,7 @@ static int vidioc_try_fmt_out(struct mtk_vcodec_enc_ctx *ctx, struct v4l2_format
 	pix_fmt_mp->height = clamp(pix_fmt_mp->height, MTK_VENC_MIN_H, max_height);
 	pix_fmt_mp->width = clamp(pix_fmt_mp->width, MTK_VENC_MIN_W, max_width);
 
-	/* find next closer width align 16, heign align 32, size align
+	/* find next closer width align 16, height align 32, size align
 	 * 64 rectangle
 	 */
 	tmp_w = pix_fmt_mp->width;
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
index d00fb68b8235..889440a436b6 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
@@ -156,7 +156,7 @@ int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
  * @ctx: device context
  * @opt: encode frame option
  * @frm_buf: input frame buffer information
- * @bs_buf: output bitstream buffer infomraiton
+ * @bs_buf: output bitstream buffer information
  * @result: encode result
  * Return: 0 if encoding frame successfully, otherwise it is failed.
  */

-- 
2.25.1

