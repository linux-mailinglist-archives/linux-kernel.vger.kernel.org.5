Return-Path: <linux-kernel+bounces-10699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EF81D8F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AA128230B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93828FBEB;
	Sun, 24 Dec 2023 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmIa1UBa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A2D534
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-554d9e63e46so30196a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418568; x=1704023368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuoZ5gF8FMh++nKHkc2ffIG7u4Pa2qSYGztYC958mos=;
        b=UmIa1UBaNXU5hFgu1f9TZtqPgdpJi6WJH6ibyd4eKnz4c1MIWhQv/MR4jIVsnIRgel
         a70sLfPyMQp5Esu2WpHPyi7KpeX8pS2g7fk9ySA21oBwtGjcfqvYy4TL15in/XLZskXb
         mA6OZKrh0bL89nRoWGwF+v5x128G6Mx8hpRBOYkRCBz/6Gz15z4ASyf9F4sRqx499wxW
         /+hhSAyH5WLeF33pa4Qjk7cZxAMilKw/WxKRI1g1HmEJUhMDX3IYZDk2JZsb2wJdo6Em
         EdyjZM/qwdnjBg/r8xdrNINI8dX5btLOr160+AGKi3erAzQNrWgEkoznd4yE20JrKAx3
         Pk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418568; x=1704023368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuoZ5gF8FMh++nKHkc2ffIG7u4Pa2qSYGztYC958mos=;
        b=fxzWan+/MaPbQ7Jzn1LtQEI8EymVYfDleab3assT2e+X4idbN1If1O78mNZGKFYhgA
         383ItFJ4OZnQuiSISQ1WA5FZMNXoYk0Pq+O6LXGGtuvniNJXf7PpL4CIMJ3yy8RCHwM1
         dTq3qJbCDkXYfE1ct0vouXPqgGXYVrk14UCdoKges8Ve1LGxECnG/JCEcxPtnSDPyowU
         fsi1cZfrHDguYwZJy1MV0D7zJMEtVb7xSua/VMml/y7U1/qQf2w+CCuZmor8zb8SA6uE
         cF2iKW2V1mquA1ax/fdNK8ke8jZ3tPZ3roSaSATIzF5/81AnUU4dXAJyBuhE4t5J2zg4
         ppsA==
X-Gm-Message-State: AOJu0YyNwWPbixl+toHjRTBF/baoeMdjMSwiOtVZSqcuioimdfRwMODP
	POqh0IUsUEMvihW5Niga5ihFtAk9DEOdAg==
X-Google-Smtp-Source: AGHT+IF1PZUwDrd+FUOArIvuE0zcBFVM7f+KrtuRXCNv4NUwQbTbTZZePQoXopjDJ2sCc9kAGjM0sw==
X-Received: by 2002:a50:d6d8:0:b0:554:42ed:d306 with SMTP id l24-20020a50d6d8000000b0055442edd306mr3320956edj.60.1703418567807;
        Sun, 24 Dec 2023 03:49:27 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] media: fimc-is: constify local pointers to fimc_fmt
Date: Sun, 24 Dec 2023 12:49:11 +0100
Message-Id: <20231224114916.111433-7-krzysztof.kozlowski@linaro.org>
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

Constify the local variable pointing to "struct fimc_fmt" to annotate
the function is not modifying pointed data.  This is the easy and
obvious step of constifying all "struct fimc_fmt" instances.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-capture.c | 6 +++---
 drivers/media/platform/samsung/exynos4-is/fimc-m2m.c     | 4 ++--
 drivers/media/platform/samsung/exynos4-is/fimc-reg.c     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index 05cafba1c728..dde36e5be0c7 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -343,7 +343,7 @@ static int queue_setup(struct vb2_queue *vq,
 {
 	struct fimc_ctx *ctx = vq->drv_priv;
 	struct fimc_frame *frame = &ctx->d_frame;
-	struct fimc_fmt *fmt = frame->fmt;
+	const struct fimc_fmt *fmt = frame->fmt;
 	unsigned long wh = frame->f_width * frame->f_height;
 	int i;
 
@@ -722,7 +722,7 @@ static int fimc_cap_querycap(struct file *file, void *priv,
 static int fimc_cap_enum_fmt(struct file *file, void *priv,
 			     struct v4l2_fmtdesc *f)
 {
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
 
 	fmt = fimc_find_format(NULL, NULL, FMT_FLAGS_CAM | FMT_FLAGS_M2M,
 			       f->index);
@@ -1460,7 +1460,7 @@ static int fimc_subdev_enum_mbus_code(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_state *sd_state,
 				      struct v4l2_subdev_mbus_code_enum *code)
 {
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
 
 	fmt = fimc_find_format(NULL, NULL, FMT_FLAGS_CAM, code->index);
 	if (!fmt)
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
index df8e2aa454d8..1918390a2469 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
@@ -237,7 +237,7 @@ static int fimc_m2m_querycap(struct file *file, void *fh,
 static int fimc_m2m_enum_fmt(struct file *file, void *priv,
 			     struct v4l2_fmtdesc *f)
 {
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
 
 	fmt = fimc_find_format(NULL, NULL, get_m2m_fmt_flags(f->type),
 			       f->index);
@@ -266,7 +266,7 @@ static int fimc_try_fmt_mplane(struct fimc_ctx *ctx, struct v4l2_format *f)
 	struct fimc_dev *fimc = ctx->fimc_dev;
 	const struct fimc_variant *variant = fimc->variant;
 	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
-	struct fimc_fmt *fmt;
+	const struct fimc_fmt *fmt;
 	u32 max_w, mod_x, mod_y;
 
 	if (!IS_M2M(f->type))
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
index f20fb74dd0c6..dbc43b703324 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
@@ -168,7 +168,7 @@ void fimc_hw_set_out_dma(struct fimc_ctx *ctx)
 	struct fimc_dev *dev = ctx->fimc_dev;
 	struct fimc_frame *frame = &ctx->d_frame;
 	struct fimc_dma_offset *offset = &frame->dma_offset;
-	struct fimc_fmt *fmt = frame->fmt;
+	const struct fimc_fmt *fmt = frame->fmt;
 	u32 cfg;
 
 	/* Set the input dma offsets. */
-- 
2.34.1


