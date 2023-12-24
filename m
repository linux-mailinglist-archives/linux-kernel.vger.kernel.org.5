Return-Path: <linux-kernel+bounces-10700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60881D8F3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE161C20936
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25064107A4;
	Sun, 24 Dec 2023 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9LpRJZA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA856EAD9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1915034144so386074666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418569; x=1704023369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjqFsq9sE2uptvTEqYo0bWh4e8oH89aUsUBRl1B+TSU=;
        b=f9LpRJZAgDsu9E0naEdeM0nrCx5w+40li/wNDtrwc6pKUBoxyKxfE9aXp9elpLI5vL
         355SCipPJ8ZAy8HvTXPQ40Jc7u1GEct1shZPVjcLthslUJadPS42daT7Gp5ohc2VJE/k
         MPajUMeU4InHwEHe6kuktX0zySim/LkRGRxNsIO1YMd0NvU/S2ItessP+IU6STD/8/ni
         my4FVyWZaP1cRoD7PyWjG1k0gNsZ3Nx1yQ4gxIpLRcccpuBfzSiRbb8hADPKvJYUeKmj
         TIj2syXh6meOIu3LPRaq11Dwm7bydtDmzGToT87Ky3mUg47UhLYTKUhQDkd3lT8ziP4p
         qOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418569; x=1704023369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjqFsq9sE2uptvTEqYo0bWh4e8oH89aUsUBRl1B+TSU=;
        b=Wmf0Frb8x9/dX1QLbt8Ir2e/kTe+QwQ2ep1/hIIOVXNRlR8PTC7zskLt+Rt82PuKbc
         YhqLFHkir98GI2pd5tpC1EsapmOdN87/eyu7+SOt7DLdjByjGuVgWbm/lGtajUTANv0Q
         7NONIHyupmzR14f1ZYE3Mn6Q1OVdKYZE3obP03LRb9hmYmzs/WXbRkHJWHY717gqaaVe
         aL9g6HMTcAFaphDcTip84gTMBH8uQpNRTw3oTrM2Md+6EtB8Ica1yAvhNM13vJcMrttS
         CQbseuFVNbrUnYCyPyrNG5rDoikbv9tqLa1+CzTDgLP9B4YeVo+BYQAxjY4jKNx7N3WO
         Ux8Q==
X-Gm-Message-State: AOJu0Yxh37Eyl5GJGxdwlC+i12U5M+5AXJ8+QaTOjPHCYP7XCNaAaddd
	nsqWauoBLVW3LdU1r4j75u6HQJx6jGBXJQ==
X-Google-Smtp-Source: AGHT+IGHO42farDQMTRagvGSLuEB1stb0yhTKkasW6T/LvWZa2Up2FnOSGz0V3v5sr5PaSWTsykARg==
X-Received: by 2002:a05:6402:377:b0:553:9e98:517b with SMTP id s23-20020a056402037700b005539e98517bmr2753755edw.78.1703418569051;
        Sun, 24 Dec 2023 03:49:29 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] media: fimc-is: constify fimc_formats array
Date: Sun, 24 Dec 2023 12:49:12 +0100
Message-Id: <20231224114916.111433-8-krzysztof.kozlowski@linaro.org>
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

Pointers to elements of the static array "fimc_formats" with "struct
fimc_fmt" are passed all around to various calls, but all of them do not
modify pointed data.  Constify the pointers everywhere which at the end
allows to make static array "fimc_formats" const itself.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../samsung/exynos4-is/fimc-capture.c         | 26 +++++++++----------
 .../platform/samsung/exynos4-is/fimc-core.c   | 11 ++++----
 .../platform/samsung/exynos4-is/fimc-core.h   |  9 ++++---
 .../platform/samsung/exynos4-is/fimc-m2m.c    |  7 ++---
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index dde36e5be0c7..a3a677a3065f 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -559,9 +559,9 @@ static const struct v4l2_file_operations fimc_capture_fops = {
  * Format and crop negotiation helpers
  */
 
-static struct fimc_fmt *fimc_capture_try_format(struct fimc_ctx *ctx,
-						u32 *width, u32 *height,
-						u32 *code, u32 *fourcc, int pad)
+static const struct fimc_fmt *fimc_capture_try_format(struct fimc_ctx *ctx,
+						      u32 *width, u32 *height,
+						      u32 *code, u32 *fourcc, int pad)
 {
 	bool rotation = ctx->rotation == 90 || ctx->rotation == 270;
 	struct fimc_dev *fimc = ctx->fimc_dev;
@@ -569,8 +569,8 @@ static struct fimc_fmt *fimc_capture_try_format(struct fimc_ctx *ctx,
 	const struct fimc_pix_limit *pl = var->pix_limit;
 	struct fimc_frame *dst = &ctx->d_frame;
 	u32 depth, min_w, max_w, min_h, align_h = 3;
+	const struct fimc_fmt *ffmt;
 	u32 mask = FMT_FLAGS_CAM;
-	struct fimc_fmt *ffmt;
 
 	/* Conversion from/to JPEG or User Defined format is not supported */
 	if (code && ctx->s_frame.fmt && pad == FIMC_SD_PAD_SOURCE &&
@@ -757,7 +757,7 @@ static struct media_entity *fimc_pipeline_get_head(struct media_entity *me)
  */
 static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 				    struct v4l2_mbus_framefmt *tfmt,
-				    struct fimc_fmt **fmt_id,
+				    const struct fimc_fmt **fmt_id,
 				    bool set)
 {
 	struct fimc_dev *fimc = ctx->fimc_dev;
@@ -768,8 +768,8 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 		       : V4L2_SUBDEV_FORMAT_TRY,
 	};
 	struct v4l2_mbus_framefmt *mf = &sfmt.format;
+	const struct fimc_fmt *ffmt;
 	struct media_entity *me;
-	struct fimc_fmt *ffmt;
 	struct media_pad *pad;
 	int ret, i = 1;
 	u32 fcc;
@@ -903,8 +903,8 @@ static int fimc_cap_g_fmt_mplane(struct file *file, void *fh,
  */
 static int __video_try_or_set_format(struct fimc_dev *fimc,
 				     struct v4l2_format *f, bool try,
-				     struct fimc_fmt **inp_fmt,
-				     struct fimc_fmt **out_fmt)
+				     const struct fimc_fmt **inp_fmt,
+				     const struct fimc_fmt **out_fmt)
 {
 	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
 	struct fimc_vid_cap *vc = &fimc->vid_cap;
@@ -986,7 +986,7 @@ static int fimc_cap_try_fmt_mplane(struct file *file, void *fh,
 				   struct v4l2_format *f)
 {
 	struct fimc_dev *fimc = video_drvdata(file);
-	struct fimc_fmt *out_fmt = NULL, *inp_fmt = NULL;
+	const struct fimc_fmt *out_fmt = NULL, *inp_fmt = NULL;
 
 	return __video_try_or_set_format(fimc, f, true, &inp_fmt, &out_fmt);
 }
@@ -1012,7 +1012,7 @@ static int __fimc_capture_set_format(struct fimc_dev *fimc,
 	struct fimc_ctx *ctx = vc->ctx;
 	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
 	struct fimc_frame *ff = &ctx->d_frame;
-	struct fimc_fmt *inp_fmt = NULL;
+	const struct fimc_fmt *inp_fmt = NULL;
 	int ret, i;
 
 	if (vb2_is_busy(&fimc->vid_cap.vbq))
@@ -1519,7 +1519,7 @@ static int fimc_subdev_set_fmt(struct v4l2_subdev *sd,
 	struct fimc_vid_cap *vc = &fimc->vid_cap;
 	struct fimc_ctx *ctx = vc->ctx;
 	struct fimc_frame *ff;
-	struct fimc_fmt *ffmt;
+	const struct fimc_fmt *ffmt;
 
 	dbg("pad%d: code: 0x%x, %dx%d",
 	    fmt->pad, mf->code, mf->width, mf->height);
@@ -1715,9 +1715,9 @@ static int fimc_register_capture_device(struct fimc_dev *fimc,
 {
 	struct video_device *vfd = &fimc->vid_cap.ve.vdev;
 	struct vb2_queue *q = &fimc->vid_cap.vbq;
-	struct fimc_ctx *ctx;
 	struct fimc_vid_cap *vid_cap;
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
+	struct fimc_ctx *ctx;
 	int ret = -ENOMEM;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 13b04fda8716..37f4952c7a9b 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -33,7 +33,7 @@ static const char *fimc_clocks[MAX_FIMC_CLOCKS] = {
 	"sclk_fimc", "fimc"
 };
 
-static struct fimc_fmt fimc_formats[] = {
+static const struct fimc_fmt fimc_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_RGB565,
 		.depth		= { 16 },
@@ -180,7 +180,7 @@ static struct fimc_fmt fimc_formats[] = {
 	},
 };
 
-struct fimc_fmt *fimc_get_format(unsigned int index)
+const struct fimc_fmt *fimc_get_format(unsigned int index)
 {
 	if (index >= ARRAY_SIZE(fimc_formats))
 		return NULL;
@@ -752,10 +752,11 @@ void fimc_adjust_mplane_format(const struct fimc_fmt *fmt, u32 width, u32 height
  * @mask: the color flags to match
  * @index: offset in the fimc_formats array, ignored if negative
  */
-struct fimc_fmt *fimc_find_format(const u32 *pixelformat, const u32 *mbus_code,
-				  unsigned int mask, int index)
+const struct fimc_fmt *fimc_find_format(const u32 *pixelformat,
+					const u32 *mbus_code,
+					unsigned int mask, int index)
 {
-	struct fimc_fmt *fmt, *def_fmt = NULL;
+	const struct fimc_fmt *fmt, *def_fmt = NULL;
 	unsigned int i;
 	int id = 0;
 
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.h b/drivers/media/platform/samsung/exynos4-is/fimc-core.h
index 261c9aac2f7f..63385152a2ff 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.h
@@ -257,7 +257,7 @@ struct fimc_frame {
 	unsigned int		bytesperline[VIDEO_MAX_PLANES];
 	struct fimc_addr	addr;
 	struct fimc_dma_offset	dma_offset;
-	struct fimc_fmt		*fmt;
+	const struct fimc_fmt	*fmt;
 	u8			alpha;
 };
 
@@ -617,9 +617,10 @@ void fimc_alpha_ctrl_update(struct fimc_ctx *ctx);
 void __fimc_get_format(const struct fimc_frame *frame, struct v4l2_format *f);
 void fimc_adjust_mplane_format(const struct fimc_fmt *fmt, u32 width, u32 height,
 			       struct v4l2_pix_format_mplane *pix);
-struct fimc_fmt *fimc_find_format(const u32 *pixelformat, const u32 *mbus_code,
-				  unsigned int mask, int index);
-struct fimc_fmt *fimc_get_format(unsigned int index);
+const struct fimc_fmt *fimc_find_format(const u32 *pixelformat,
+					const u32 *mbus_code,
+					unsigned int mask, int index);
+const struct fimc_fmt *fimc_get_format(unsigned int index);
 
 int fimc_check_scaler_ratio(struct fimc_ctx *ctx, int sw, int sh,
 			    int dw, int dh, int rotation);
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
index 1918390a2469..e9023f64cfba 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
@@ -314,7 +314,8 @@ static int fimc_m2m_try_fmt_mplane(struct file *file, void *fh,
 	return fimc_try_fmt_mplane(ctx, f);
 }
 
-static void __set_frame_format(struct fimc_frame *frame, struct fimc_fmt *fmt,
+static void __set_frame_format(struct fimc_frame *frame,
+			       const struct fimc_fmt *fmt,
 			       struct v4l2_pix_format_mplane *pixm)
 {
 	int i;
@@ -340,7 +341,7 @@ static int fimc_m2m_s_fmt_mplane(struct file *file, void *fh,
 {
 	struct fimc_ctx *ctx = fh_to_ctx(fh);
 	struct fimc_dev *fimc = ctx->fimc_dev;
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
 	struct vb2_queue *vq;
 	struct fimc_frame *frame;
 	int ret;
@@ -588,7 +589,7 @@ static int fimc_m2m_set_default_format(struct fimc_ctx *ctx)
 			.sizeimage = 800 * 4 * 600,
 		},
 	};
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
 
 	fmt = fimc_find_format(&pixm.pixelformat, NULL, FMT_FLAGS_M2M, 0);
 	if (!fmt)
-- 
2.34.1


