Return-Path: <linux-kernel+bounces-10704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D76281D900
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355B6B2104F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC0171DD;
	Sun, 24 Dec 2023 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wxpc7lWp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F812E58
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-554dbe1857dso1840a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418574; x=1704023374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hz+LJHTWuf+0lRGoDC5k9tAjKQBt8mGUWlE7LUoWo8w=;
        b=Wxpc7lWpB8cZDkaWloeEyIqtJbRByWtKiwgWNsaMgmhPZZHLcbOOq1qpgNMrNblkjl
         mjDbjhs4C7SkbxHT///d3nZBqWFPyJ6ALH0PXCfkh3ln4vDZRhpCNp8hA+MXb/YfsfG8
         B2xNJ1bhz8eibR9IVgHgAkgWxqk80bR5k++TJh24j1vcgj6UTS2x5mxVMzsOwQ/S3Vxs
         x99p7YHvmwngx53lvGsFy3FDEY9UxioFaJZwrE6g8HKqzHJnTa0pYOaYFy+r+igWQvpR
         wxY/qg1kSrLMAtJo3F7hBxaw6nnQeH0vbzXBlAkKaW1ukV7mKg22Qk5Vp5YGTSJEP6tC
         0nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418574; x=1704023374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz+LJHTWuf+0lRGoDC5k9tAjKQBt8mGUWlE7LUoWo8w=;
        b=Pq9XfR1c1BWYxRErABVqxnKUENr0cId+jGDjpRTqfryEgSMAdpeAaa41UQe2pQCDvB
         K0zCkLMOkoCVHO1SnbCZ2HwKAIFfZRecR244HFn3qEbHagM2uEzq2Y6Z077otJeDhroF
         AErKYyKSWP5Gthsm7ARn8QOqWBP5YP/kzAMmyWYC/VgQtKpWHEp/KPdn8lFnhqgT0wod
         WPo7Yc2Pri7lAtXbVQlw1mXPhbTvIEpIWMqNk4qz7NoFF3Lj0iA/s52qY2y3LdEjcebg
         uF9M24wQgC06fg5mM2PscKUqSsCJYtZigS5rM9K1c0bqHtFC2bwtxFhmuGNiAgJ0BSMs
         rpbw==
X-Gm-Message-State: AOJu0YwYL26ejldExj1GmzJ1byTV7BW7YEJw117/dN7bPKbUFSi3CQmx
	N2xi4hQEuCCei0NykNeW3EEDmYETuYTG+w==
X-Google-Smtp-Source: AGHT+IFYmpROfj/r53Veux3loUiL5y8yPrPsFuQmtNI/+LLEYo0s3ORWN77ziyS9hAj0zByGZj8ipw==
X-Received: by 2002:a50:9b03:0:b0:554:526d:894e with SMTP id o3-20020a509b03000000b00554526d894emr2750369edi.1.1703418573789;
        Sun, 24 Dec 2023 03:49:33 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] media: fimc-is: constify local pointers to fimc_frame
Date: Sun, 24 Dec 2023 12:49:16 +0100
Message-Id: <20231224114916.111433-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
References: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify the local variables pointing to "struct fimc_frame" to annotate
the function is not modifying pointed data.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../platform/samsung/exynos4-is/fimc-capture.c | 18 +++++++++---------
 .../platform/samsung/exynos4-is/fimc-core.c    |  4 ++--
 .../platform/samsung/exynos4-is/fimc-m2m.c     | 10 +++++-----
 .../platform/samsung/exynos4-is/fimc-reg.c     | 18 +++++++++---------
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index 7c2bcd5be933..ffa4ea21387d 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -180,7 +180,7 @@ void fimc_capture_irq_handler(struct fimc_dev *fimc, int deq_buf)
 	struct fimc_vid_cap *cap = &fimc->vid_cap;
 	struct fimc_pipeline *p = to_fimc_pipeline(cap->ve.pipe);
 	struct v4l2_subdev *csis = p->subdevs[IDX_CSIS];
-	struct fimc_frame *f = &cap->ctx->d_frame;
+	const struct fimc_frame *f = &cap->ctx->d_frame;
 	struct fimc_vid_buffer *v_buf;
 
 	if (test_and_clear_bit(ST_CAPT_SHUT, &fimc->state)) {
@@ -342,7 +342,7 @@ static int queue_setup(struct vb2_queue *vq,
 		       unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct fimc_ctx *ctx = vq->drv_priv;
-	struct fimc_frame *frame = &ctx->d_frame;
+	const struct fimc_frame *frame = &ctx->d_frame;
 	const struct fimc_fmt *fmt = frame->fmt;
 	unsigned long wh = frame->f_width * frame->f_height;
 	int i;
@@ -567,7 +567,7 @@ static const struct fimc_fmt *fimc_capture_try_format(struct fimc_ctx *ctx,
 	struct fimc_dev *fimc = ctx->fimc_dev;
 	const struct fimc_variant *var = fimc->variant;
 	const struct fimc_pix_limit *pl = var->pix_limit;
-	struct fimc_frame *dst = &ctx->d_frame;
+	const struct fimc_frame *dst = &ctx->d_frame;
 	u32 depth, min_w, max_w, min_h, align_h = 3;
 	const struct fimc_fmt *ffmt;
 	u32 mask = FMT_FLAGS_CAM;
@@ -644,7 +644,7 @@ static void fimc_capture_try_selection(struct fimc_ctx *ctx,
 	struct fimc_dev *fimc = ctx->fimc_dev;
 	const struct fimc_variant *var = fimc->variant;
 	const struct fimc_pix_limit *pl = var->pix_limit;
-	struct fimc_frame *sink = &ctx->s_frame;
+	const struct fimc_frame *sink = &ctx->s_frame;
 	u32 max_w, max_h, min_w = 0, min_h = 0, min_sz;
 	u32 align_sz = 0, align_h = 4;
 	u32 max_sc_h, max_sc_v;
@@ -1132,7 +1132,7 @@ static int fimc_pipeline_validate(struct fimc_dev *fimc)
 
 		/* Don't call FIMC subdev operation to avoid nested locking */
 		if (sd == &vc->subdev) {
-			struct fimc_frame *ff = &vc->ctx->s_frame;
+			const struct fimc_frame *ff = &vc->ctx->s_frame;
 			sink_fmt.format.width = ff->f_width;
 			sink_fmt.format.height = ff->f_height;
 			sink_fmt.format.code = ff->fmt ? ff->fmt->mbus_code : 0;
@@ -1158,7 +1158,7 @@ static int fimc_pipeline_validate(struct fimc_dev *fimc)
 		if (sd == p->subdevs[IDX_SENSOR] &&
 		    fimc_user_defined_mbus_fmt(src_fmt.format.code)) {
 			struct v4l2_plane_pix_format plane_fmt[FIMC_MAX_PLANES];
-			struct fimc_frame *frame = &vc->ctx->d_frame;
+			const struct fimc_frame *frame = &vc->ctx->d_frame;
 			unsigned int i;
 
 			ret = fimc_get_sensor_frame_desc(sd, plane_fmt,
@@ -1263,7 +1263,7 @@ static int fimc_cap_g_selection(struct file *file, void *fh,
 {
 	struct fimc_dev *fimc = video_drvdata(file);
 	struct fimc_ctx *ctx = fimc->vid_cap.ctx;
-	struct fimc_frame *f = &ctx->s_frame;
+	const struct fimc_frame *f = &ctx->s_frame;
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
@@ -1475,7 +1475,7 @@ static int fimc_subdev_get_fmt(struct v4l2_subdev *sd,
 {
 	struct fimc_dev *fimc = v4l2_get_subdevdata(sd);
 	struct fimc_ctx *ctx = fimc->vid_cap.ctx;
-	struct fimc_frame *ff = &ctx->s_frame;
+	const struct fimc_frame *ff = &ctx->s_frame;
 	struct v4l2_mbus_framefmt *mf;
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
@@ -1582,7 +1582,7 @@ static int fimc_subdev_get_selection(struct v4l2_subdev *sd,
 {
 	struct fimc_dev *fimc = v4l2_get_subdevdata(sd);
 	struct fimc_ctx *ctx = fimc->vid_cap.ctx;
-	struct fimc_frame *f = &ctx->s_frame;
+	const struct fimc_frame *f = &ctx->s_frame;
 	struct v4l2_rect *r = &sel->r;
 	struct v4l2_rect *try_sel;
 
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 37f4952c7a9b..1f627f257359 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -228,8 +228,8 @@ int fimc_set_scaler_info(struct fimc_ctx *ctx)
 	const struct fimc_variant *variant = ctx->fimc_dev->variant;
 	struct device *dev = &ctx->fimc_dev->pdev->dev;
 	struct fimc_scaler *sc = &ctx->scaler;
-	struct fimc_frame *s_frame = &ctx->s_frame;
-	struct fimc_frame *d_frame = &ctx->d_frame;
+	const struct fimc_frame *s_frame = &ctx->s_frame;
+	const struct fimc_frame *d_frame = &ctx->d_frame;
 	int tx, ty, sx, sy;
 	int ret;
 
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
index e5829a457f3d..199997eec1cc 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
@@ -170,7 +170,7 @@ static int fimc_queue_setup(struct vb2_queue *vq,
 			    unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct fimc_ctx *ctx = vb2_get_drv_priv(vq);
-	struct fimc_frame *f;
+	const struct fimc_frame *f;
 	int i;
 
 	f = ctx_get_frame(ctx, vq->type);
@@ -192,7 +192,7 @@ static int fimc_queue_setup(struct vb2_queue *vq,
 static int fimc_buf_prepare(struct vb2_buffer *vb)
 {
 	struct fimc_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
-	struct fimc_frame *frame;
+	const struct fimc_frame *frame;
 	int i;
 
 	frame = ctx_get_frame(ctx, vb->vb2_queue->type);
@@ -252,7 +252,7 @@ static int fimc_m2m_g_fmt_mplane(struct file *file, void *fh,
 				 struct v4l2_format *f)
 {
 	struct fimc_ctx *ctx = fh_to_ctx(fh);
-	struct fimc_frame *frame = ctx_get_frame(ctx, f->type);
+	const struct fimc_frame *frame = ctx_get_frame(ctx, f->type);
 
 	if (IS_ERR(frame))
 		return PTR_ERR(frame);
@@ -379,7 +379,7 @@ static int fimc_m2m_g_selection(struct file *file, void *fh,
 				struct v4l2_selection *s)
 {
 	struct fimc_ctx *ctx = fh_to_ctx(fh);
-	struct fimc_frame *frame;
+	const struct fimc_frame *frame;
 
 	frame = ctx_get_frame(ctx, s->type);
 	if (IS_ERR(frame))
@@ -429,7 +429,7 @@ static int fimc_m2m_try_selection(struct fimc_ctx *ctx,
 				  struct v4l2_selection *s)
 {
 	struct fimc_dev *fimc = ctx->fimc_dev;
-	struct fimc_frame *f;
+	const struct fimc_frame *f;
 	u32 min_size, halign, depth = 0;
 	int i;
 
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
index edff6e5179cf..b4ee39e471e7 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
@@ -105,7 +105,7 @@ void fimc_hw_set_target_format(struct fimc_ctx *ctx)
 {
 	u32 cfg;
 	struct fimc_dev *dev = ctx->fimc_dev;
-	struct fimc_frame *frame = &ctx->d_frame;
+	const struct fimc_frame *frame = &ctx->d_frame;
 
 	dbg("w= %d, h= %d color: %d", frame->width,
 	    frame->height, frame->fmt->color);
@@ -147,7 +147,7 @@ void fimc_hw_set_target_format(struct fimc_ctx *ctx)
 static void fimc_hw_set_out_dma_size(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
-	struct fimc_frame *frame = &ctx->d_frame;
+	const struct fimc_frame *frame = &ctx->d_frame;
 	u32 cfg;
 
 	cfg = (frame->f_height << 16) | frame->f_width;
@@ -166,7 +166,7 @@ static void fimc_hw_set_out_dma_size(struct fimc_ctx *ctx)
 void fimc_hw_set_out_dma(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
-	struct fimc_frame *frame = &ctx->d_frame;
+	const struct fimc_frame *frame = &ctx->d_frame;
 	const struct fimc_dma_offset *offset = &frame->dma_offset;
 	const struct fimc_fmt *fmt = frame->fmt;
 	u32 cfg;
@@ -248,8 +248,8 @@ static void fimc_hw_set_scaler(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
 	struct fimc_scaler *sc = &ctx->scaler;
-	struct fimc_frame *src_frame = &ctx->s_frame;
-	struct fimc_frame *dst_frame = &ctx->d_frame;
+	const struct fimc_frame *src_frame = &ctx->s_frame;
+	const struct fimc_frame *dst_frame = &ctx->d_frame;
 
 	u32 cfg = readl(dev->regs + FIMC_REG_CISCCTRL);
 
@@ -388,7 +388,7 @@ void fimc_hw_set_effect(struct fimc_ctx *ctx)
 void fimc_hw_set_rgb_alpha(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
-	struct fimc_frame *frame = &ctx->d_frame;
+	const struct fimc_frame *frame = &ctx->d_frame;
 	u32 cfg;
 
 	if (!(frame->fmt->flags & FMT_HAS_ALPHA))
@@ -403,7 +403,7 @@ void fimc_hw_set_rgb_alpha(struct fimc_ctx *ctx)
 static void fimc_hw_set_in_dma_size(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
-	struct fimc_frame *frame = &ctx->s_frame;
+	const struct fimc_frame *frame = &ctx->s_frame;
 	u32 cfg_o = 0;
 	u32 cfg_r = 0;
 
@@ -420,7 +420,7 @@ static void fimc_hw_set_in_dma_size(struct fimc_ctx *ctx)
 void fimc_hw_set_in_dma(struct fimc_ctx *ctx)
 {
 	struct fimc_dev *dev = ctx->fimc_dev;
-	struct fimc_frame *frame = &ctx->s_frame;
+	const struct fimc_frame *frame = &ctx->s_frame;
 	const struct fimc_dma_offset *offset = &frame->dma_offset;
 	u32 cfg;
 
@@ -599,7 +599,7 @@ int fimc_hw_set_camera_source(struct fimc_dev *fimc,
 			      struct fimc_source_info *source)
 {
 	const struct fimc_vid_cap *vc = &fimc->vid_cap;
-	struct fimc_frame *f = &vc->ctx->s_frame;
+	const struct fimc_frame *f = &vc->ctx->s_frame;
 	u32 bus_width, cfg = 0;
 	int i;
 
-- 
2.34.1


