Return-Path: <linux-kernel+bounces-10748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06881DB3A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DBB1F2197D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41DB171DD;
	Sun, 24 Dec 2023 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxJNvvlT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478F12E50
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a234dc0984fso341701666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432681; x=1704037481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gi2Xm/eE2/ZQOvGSk2NfHanEe6jP94JeNwcl+2gllIE=;
        b=XxJNvvlTznUEIbyvVDeCvueWRC5rDTAWOSstNej5x/ZlVTfBfq2MAW6EwCH0VidEZH
         xYfRoR/6DDjEAyJ1KgSDmggAWu5RAT8P2zVxfXfHnhhQo2u2/3qvICKe4fDA3nn7Y6+a
         9f36z1k1Xs4p1Q3HvEM0P1EP1PE7cpQMemvoDEX8TSf0ysKb4zT6uVddD56dn1gPoiLM
         uBbwMUx0J/rjfbvkGWb0Ji7cFiMRMxKDzGJPKastXtleJcAXrjAnlGUUAppyy+OtllYO
         f6FEHiEgVbjjo5pe0Bd1uFe4S8tQQu5skoAnYKOUDAvmVtlhUyec/khRocBged/vcFHq
         M51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432681; x=1704037481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi2Xm/eE2/ZQOvGSk2NfHanEe6jP94JeNwcl+2gllIE=;
        b=XkDjl4x8B12YXE5o562RlUF3PkmAl+ISdNrWvJDvpYKTS4dEPJcajCydEV63hDHXs+
         eyfKx1U4D3SlE+EGgIvrj6zzOpf5O8bqqS4Pyl9g/MajGEkTa2t8RgsO9Q6uJeNXrCYc
         8ntwP47YlBQtEiBhn0ct/iST4UQk9tN/UVW0c3pI2A5H7tY1cfOjKAHxJ0z2AyB7VQuJ
         AQ9Rr8/1FeIiJOqd7y7F5afXoha0v3El6XpArNh8xq5zk6C8CkmLDmnB3mnMdVRS6xyW
         ysRABecTIQ1GlZqtZ8fjP67CZdWiatiz2gS6PMJPiI9E+IoH2H+S5WILNod/My8uQVCX
         R7Wg==
X-Gm-Message-State: AOJu0YyWquEeKNH8mpM4WIy+sZx+5jzjo5nKBWd4M63bq6k2/UZLy+lx
	8fkHgJGqPX9S9W6Ew+flY7WTx6HlQWx8yQ==
X-Google-Smtp-Source: AGHT+IHMDDehuEau4qfcvjut+X+7u9CsTSccuO5YA9mSNeGnSng6cgw9DjkcaCJG7uG9ydKVmkyWPA==
X-Received: by 2002:a17:906:2086:b0:a26:a877:56d3 with SMTP id 6-20020a170906208600b00a26a87756d3mr2137218ejq.97.1703432680961;
        Sun, 24 Dec 2023 07:44:40 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:08 +0100
Subject: [PATCH 09/15] media: s5p-mfc: constify s5p_mfc_fmt structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-9-a3b246470fe4@linaro.org>
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Aakarsh Jain <aakarsh.jain@samsung.com>, linux-fsd@tesla.coma, 
 linux-samsung-soc@vger.kernel.org, 
 Smitha T Murthy <smithatmurthy@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3940;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tB2ac04nPKzrFa9IRHC0cXKAVzSO8LhOTzEBJ8HJcxg=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHVATVXyMu07594D9rqQjKQnrcEStL4LxrAw
 iMoXF5v3SyJAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhR1RAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PX8yAP/1imoS7jQDgNuj4O93hilddy2HnZT8ESS0zJk90vwAgMs/R
 43B7OA7tQDVeYZ4LRZ2RI/jzReEAy6U6+pC9TObMzkMMNCAbQogZ59fG6VIv+cCFBQYVj1jLr5J
 PrVx0Ww+mpnKcvmvlzhb+Ns8Ir4LkM8RlirMC4Z2bHpbFtmXDzwP7D3EETEIsG0p58lpXRPRz34
 XWHpDJFeFNZTEiKXsBm2CQJh+WrQ7vxvCY5X2cPz5HNfsWYaXmHKaYKZgoNL4rK2DXbGx0Uta69
 tdT7oJB7CAtID6b7DxwcjXeYZUEA4cE9UnIbD4INDktJPzlSfND0Z/xtCFNrjqUXDXcZufk4WZv
 k10OrfxXkRweFTiicdJleOfTCNLL7uRA+ahBYLlgzIwfaHBqFtKPdglRO6S51E+6DXkBt9BRfq9
 Zuz1ATUxGWR1qyr/JHoaVXy0wRqv+JoECurS+yh75rZHKn3Q0gRAO2+y7HPN2/H2bJekIXKI9pW
 gCCJsbcd6qupIZZShoVNCDZ+0aRgA3gSUKlFvwXul8doirZIXJbV70Il5IdKmEZnAibc02rNvH3
 HZgdaOqD9G6yqQNxcyFdE6B3GKcGh9uSyNRBacw0CByvrXZ21t7HP7A0a5LC8RnuyrEWrCpvIlB
 0EypxJRUFcDpUDxNjlBg3Ur1n2lj03ERS/H9n
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static "s5p_mfc_fmt" structures are not modified by the driver, so
they can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 4 ++--
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c    | 6 +++---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index fa556f27fa06..e9283020070e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -633,8 +633,8 @@ struct s5p_mfc_ctx {
 	unsigned int int_err;
 	wait_queue_head_t queue;
 
-	struct s5p_mfc_fmt *src_fmt;
-	struct s5p_mfc_fmt *dst_fmt;
+	const struct s5p_mfc_fmt *src_fmt;
+	const struct s5p_mfc_fmt *dst_fmt;
 
 	struct vb2_queue vq_src;
 	struct vb2_queue vq_dst;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 4dbe8792ac3d..2f664c7e9e4c 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -27,7 +27,7 @@
 #include "s5p_mfc_opr.h"
 #include "s5p_mfc_pm.h"
 
-static struct s5p_mfc_fmt formats[] = {
+static const struct s5p_mfc_fmt formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_NV12MT_16X16,
 		.codec_mode	= S5P_MFC_CODEC_NONE,
@@ -163,7 +163,7 @@ static struct s5p_mfc_fmt formats[] = {
 #define NUM_FORMATS ARRAY_SIZE(formats)
 
 /* Find selected format description */
-static struct s5p_mfc_fmt *find_format(struct v4l2_format *f, unsigned int t)
+static const struct s5p_mfc_fmt *find_format(struct v4l2_format *f, unsigned int t)
 {
 	unsigned int i;
 
@@ -387,7 +387,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct s5p_mfc_dev *dev = video_drvdata(file);
-	struct s5p_mfc_fmt *fmt;
+	const struct s5p_mfc_fmt *fmt;
 
 	mfc_debug(2, "Type is %d\n", f->type);
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 4b4c129c09e7..d6a4b9c701eb 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -30,7 +30,7 @@
 #define DEF_SRC_FMT_ENC	V4L2_PIX_FMT_NV12M
 #define DEF_DST_FMT_ENC	V4L2_PIX_FMT_H264
 
-static struct s5p_mfc_fmt formats[] = {
+static const struct s5p_mfc_fmt formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_NV12MT_16X16,
 		.codec_mode	= S5P_MFC_CODEC_NONE,
@@ -97,7 +97,7 @@ static struct s5p_mfc_fmt formats[] = {
 };
 
 #define NUM_FORMATS ARRAY_SIZE(formats)
-static struct s5p_mfc_fmt *find_format(struct v4l2_format *f, unsigned int t)
+static const struct s5p_mfc_fmt *find_format(struct v4l2_format *f, unsigned int t)
 {
 	unsigned int i;
 
@@ -1394,7 +1394,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct s5p_mfc_dev *dev = video_drvdata(file);
-	struct s5p_mfc_fmt *fmt;
+	const struct s5p_mfc_fmt *fmt;
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
@@ -2355,7 +2355,7 @@ static const struct v4l2_ioctl_ops s5p_mfc_enc_ioctl_ops = {
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 };
 
-static int check_vb_with_fmt(struct s5p_mfc_fmt *fmt, struct vb2_buffer *vb)
+static int check_vb_with_fmt(const struct s5p_mfc_fmt *fmt, struct vb2_buffer *vb)
 {
 	int i;
 

-- 
2.34.1


