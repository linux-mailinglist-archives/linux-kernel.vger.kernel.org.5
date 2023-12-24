Return-Path: <linux-kernel+bounces-10698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1679281D8EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26D02822EA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE3F512;
	Sun, 24 Dec 2023 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu0x0hRG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D4D282
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5534abbc637so3459608a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418566; x=1704023366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP3ZUYJrc19Cv/IjV/mAOUbO0abZ7npMLo6H/Ze3L60=;
        b=Cu0x0hRG6sWYVmLCOgFaCgN6Eh7NlhBLbY8oGVgFxBUIi+IDNQMrRkF305OK8yShRQ
         gXiAqFvMHpjU9qZ9Quh0ZDxxQApyX7ZhIGX8MYwmHSVgMC2pzMqn0hcKkziFcGVGawjt
         JwZhjGUT0+/yYkgVK9SQz/3ojwOHmvlvc9byhEpLPGepOOGcs2vfcGxuttncNWK89oLz
         L3LN5dtO+zhb0kZqtV/G8MdOyHokdDRM1euZSX24uqr7CW+Z9eEn+tIamoKl5OQo+mtB
         3iMgIHOlRS7vMTYphdTqKwPKnAdpTYfHiRjAHgHlcQiLpV8ZtHDKt6BkJeDhvd0zDvrw
         aNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418566; x=1704023366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP3ZUYJrc19Cv/IjV/mAOUbO0abZ7npMLo6H/Ze3L60=;
        b=XaeC/E5vr2FmvKapNnZT2IGJsosIoZkWkLmHai9esQTmd22r0431U/qpyIreXeIRv+
         uFbHciTnT8xMJKU5SD+quOkE2QrLLqzflyW0AiSbOzPfhl8cNO7y9Bpt0DVG+i7B9gZh
         xzApD30DeU98Mv+VHiDHN+KeFfgwZBxkuGWrylxthy5q8xqbtjLnPlQpn1M23uWQfHrj
         Lfh5dN8u+y6nPl3S9nGmgBFTFdr8hWLbM54pPmTuF8gie1fnepfMUxRro1BokUc/jqvW
         tX+PPP4I4RLMxA53gSJD9w9sUe5HWhp8tB6NpKpHDTtFP+hCu407j9980KC1LQzhSKBQ
         d/bA==
X-Gm-Message-State: AOJu0Yypum/bhq2wLZz8prgYWVuM+O//3sE0rXHrqVcKkg9KFpIB/4eT
	Z9/5u7gaaGTISAgoyaup3oZt+k/uyIKy6Q==
X-Google-Smtp-Source: AGHT+IHe8kTD/Qr8Nzk0Mz729hoTUFVHp/4Or11HPyHwM4M882YsNptv9K5BnmS3VTQpDX92+8bsJg==
X-Received: by 2002:aa7:d64d:0:b0:553:ac86:3a4c with SMTP id v13-20020aa7d64d000000b00553ac863a4cmr3160883edr.51.1703418566479;
        Sun, 24 Dec 2023 03:49:26 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] media: fimc-is: constify several pointers in function arguments
Date: Sun, 24 Dec 2023 12:49:10 +0100
Message-Id: <20231224114916.111433-6-krzysztof.kozlowski@linaro.org>
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

Several functions do not modify pointed structure, thus the pointer can
point to const data for additional safety and self-documenting intention
of the function.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../media/platform/samsung/exynos4-is/fimc-core.c    |  6 +++---
 .../media/platform/samsung/exynos4-is/fimc-core.h    | 12 ++++++------
 drivers/media/platform/samsung/exynos4-is/fimc-reg.c | 10 +++++-----
 drivers/media/platform/samsung/exynos4-is/fimc-reg.h | 10 +++++-----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index ad72cc31dc45..13b04fda8716 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -326,7 +326,7 @@ static irqreturn_t fimc_irq_handler(int irq, void *priv)
 
 /* The color format (colplanes, memplanes) must be already configured. */
 int fimc_prepare_addr(struct fimc_ctx *ctx, struct vb2_buffer *vb,
-		      struct fimc_frame *frame, struct fimc_addr *addr)
+		      const struct fimc_frame *frame, struct fimc_addr *addr)
 {
 	int ret = 0;
 	u32 pix_size;
@@ -670,7 +670,7 @@ void fimc_alpha_ctrl_update(struct fimc_ctx *ctx)
 	v4l2_ctrl_unlock(ctrl);
 }
 
-void __fimc_get_format(struct fimc_frame *frame, struct v4l2_format *f)
+void __fimc_get_format(const struct fimc_frame *frame, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pixm = &f->fmt.pix_mp;
 	int i;
@@ -695,7 +695,7 @@ void __fimc_get_format(struct fimc_frame *frame, struct v4l2_format *f)
  * @height: requested pixel height
  * @pix: multi-plane format to adjust
  */
-void fimc_adjust_mplane_format(struct fimc_fmt *fmt, u32 width, u32 height,
+void fimc_adjust_mplane_format(const struct fimc_fmt *fmt, u32 width, u32 height,
 			       struct v4l2_pix_format_mplane *pix)
 {
 	u32 bytesperline = 0;
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.h b/drivers/media/platform/samsung/exynos4-is/fimc-core.h
index cc840e6e07a9..261c9aac2f7f 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.h
@@ -515,7 +515,7 @@ static inline void set_frame_crop(struct fimc_frame *f,
 	f->height = height;
 }
 
-static inline u32 fimc_get_format_depth(struct fimc_fmt *ff)
+static inline u32 fimc_get_format_depth(const struct fimc_fmt *ff)
 {
 	u32 i, depth = 0;
 
@@ -557,7 +557,7 @@ static inline bool fimc_ctx_state_is_set(u32 mask, struct fimc_ctx *ctx)
 	return ret;
 }
 
-static inline int tiled_fmt(struct fimc_fmt *fmt)
+static inline int tiled_fmt(const struct fimc_fmt *fmt)
 {
 	return fmt->fourcc == V4L2_PIX_FMT_NV12MT;
 }
@@ -575,7 +575,7 @@ static inline bool fimc_user_defined_mbus_fmt(u32 code)
 }
 
 /* Return the alpha component bit mask */
-static inline int fimc_get_alpha_mask(struct fimc_fmt *fmt)
+static inline int fimc_get_alpha_mask(const struct fimc_fmt *fmt)
 {
 	switch (fmt->color) {
 	case FIMC_FMT_RGB444:	return 0x0f;
@@ -614,8 +614,8 @@ int fimc_ctrls_create(struct fimc_ctx *ctx);
 void fimc_ctrls_delete(struct fimc_ctx *ctx);
 void fimc_ctrls_activate(struct fimc_ctx *ctx, bool active);
 void fimc_alpha_ctrl_update(struct fimc_ctx *ctx);
-void __fimc_get_format(struct fimc_frame *frame, struct v4l2_format *f);
-void fimc_adjust_mplane_format(struct fimc_fmt *fmt, u32 width, u32 height,
+void __fimc_get_format(const struct fimc_frame *frame, struct v4l2_format *f);
+void fimc_adjust_mplane_format(const struct fimc_fmt *fmt, u32 width, u32 height,
 			       struct v4l2_pix_format_mplane *pix);
 struct fimc_fmt *fimc_find_format(const u32 *pixelformat, const u32 *mbus_code,
 				  unsigned int mask, int index);
@@ -626,7 +626,7 @@ int fimc_check_scaler_ratio(struct fimc_ctx *ctx, int sw, int sh,
 int fimc_set_scaler_info(struct fimc_ctx *ctx);
 int fimc_prepare_config(struct fimc_ctx *ctx, u32 flags);
 int fimc_prepare_addr(struct fimc_ctx *ctx, struct vb2_buffer *vb,
-		      struct fimc_frame *frame, struct fimc_addr *addr);
+		      const struct fimc_frame *frame, struct fimc_addr *addr);
 void fimc_prepare_dma_offset(struct fimc_ctx *ctx, struct fimc_frame *f);
 void fimc_set_yuv_order(struct fimc_ctx *ctx);
 void fimc_capture_irq_handler(struct fimc_dev *fimc, int deq_buf);
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
index 95165a2cc7d1..f20fb74dd0c6 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
@@ -526,7 +526,7 @@ void fimc_hw_set_output_path(struct fimc_ctx *ctx)
 	writel(cfg, dev->regs + FIMC_REG_CISCCTRL);
 }
 
-void fimc_hw_set_input_addr(struct fimc_dev *dev, struct fimc_addr *addr)
+void fimc_hw_set_input_addr(struct fimc_dev *dev, const struct fimc_addr *addr)
 {
 	u32 cfg = readl(dev->regs + FIMC_REG_CIREAL_ISIZE);
 	cfg |= FIMC_REG_CIREAL_ISIZE_ADDR_CH_DIS;
@@ -541,7 +541,7 @@ void fimc_hw_set_input_addr(struct fimc_dev *dev, struct fimc_addr *addr)
 }
 
 void fimc_hw_set_output_addr(struct fimc_dev *dev,
-			     struct fimc_addr *addr, int index)
+			     const struct fimc_addr *addr, int index)
 {
 	int i = (index == -1) ? 0 : index;
 	do {
@@ -554,7 +554,7 @@ void fimc_hw_set_output_addr(struct fimc_dev *dev,
 }
 
 int fimc_hw_set_camera_polarity(struct fimc_dev *fimc,
-				struct fimc_source_info *cam)
+				const struct fimc_source_info *cam)
 {
 	u32 cfg = readl(fimc->regs + FIMC_REG_CIGCTRL);
 
@@ -648,7 +648,7 @@ int fimc_hw_set_camera_source(struct fimc_dev *fimc,
 	return 0;
 }
 
-void fimc_hw_set_camera_offset(struct fimc_dev *fimc, struct fimc_frame *f)
+void fimc_hw_set_camera_offset(struct fimc_dev *fimc, const struct fimc_frame *f)
 {
 	u32 hoff2, voff2;
 
@@ -668,7 +668,7 @@ void fimc_hw_set_camera_offset(struct fimc_dev *fimc, struct fimc_frame *f)
 }
 
 int fimc_hw_set_camera_type(struct fimc_dev *fimc,
-			    struct fimc_source_info *source)
+			    const struct fimc_source_info *source)
 {
 	struct fimc_vid_cap *vid_cap = &fimc->vid_cap;
 	u32 csis_data_alignment = 32;
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-reg.h b/drivers/media/platform/samsung/exynos4-is/fimc-reg.h
index b9b33aa1f12f..9714f4309655 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-reg.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-reg.h
@@ -302,16 +302,16 @@ void fimc_hw_set_rgb_alpha(struct fimc_ctx *ctx);
 void fimc_hw_set_in_dma(struct fimc_ctx *ctx);
 void fimc_hw_set_input_path(struct fimc_ctx *ctx);
 void fimc_hw_set_output_path(struct fimc_ctx *ctx);
-void fimc_hw_set_input_addr(struct fimc_dev *fimc, struct fimc_addr *addr);
-void fimc_hw_set_output_addr(struct fimc_dev *fimc, struct fimc_addr *addr,
+void fimc_hw_set_input_addr(struct fimc_dev *fimc, const struct fimc_addr *addr);
+void fimc_hw_set_output_addr(struct fimc_dev *fimc, const struct fimc_addr *addr,
 			     int index);
 int fimc_hw_set_camera_source(struct fimc_dev *fimc,
 			      struct fimc_source_info *cam);
-void fimc_hw_set_camera_offset(struct fimc_dev *fimc, struct fimc_frame *f);
+void fimc_hw_set_camera_offset(struct fimc_dev *fimc, const struct fimc_frame *f);
 int fimc_hw_set_camera_polarity(struct fimc_dev *fimc,
-				struct fimc_source_info *cam);
+				const struct fimc_source_info *cam);
 int fimc_hw_set_camera_type(struct fimc_dev *fimc,
-			    struct fimc_source_info *cam);
+			    const struct fimc_source_info *cam);
 void fimc_hw_clear_irq(struct fimc_dev *dev);
 void fimc_hw_enable_scaler(struct fimc_dev *dev, bool on);
 void fimc_hw_activate_input_dma(struct fimc_dev *dev, bool on);
-- 
2.34.1


