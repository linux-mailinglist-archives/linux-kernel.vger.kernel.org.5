Return-Path: <linux-kernel+bounces-10701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FC81D8F6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE91E1F21979
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203F10A16;
	Sun, 24 Dec 2023 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TL0VEmtJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0999FC01
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55333eb0312so2533303a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418570; x=1704023370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UNgHZjW5MJWbUJfKL9ILAPKHDM87DLcYQJtFHdCq+c=;
        b=TL0VEmtJEetXuE3DFZRYNqR5MxBDNS+5EqDVYejyX5KVBAdpWLyxcfY5dlPuG/IcNB
         IchNHZ37be2QR9UjNGbIVpdt7dF67A1Tn7/I+huVZIk5cyFIfphLuLUnClFB7t8XCI50
         f47Lu+IQCMN+hF47z7rZEWD5OgGUadEeWRWSY89mvaStTePi0SFOnxBX3jOvKYZpwBpQ
         mG5hL2lclOMj3CVlYX1sN8CAogsHdcmasSaBFX1PX+DjyeCIfeNOAi+Hhw7EP3c1aKwl
         q0UPrD8gpW1wKIqxwzL0yWkbN695/i8/UXRXIvicXKaYgx57rHRrFMhhd3wCdHpU9mXg
         aASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418570; x=1704023370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UNgHZjW5MJWbUJfKL9ILAPKHDM87DLcYQJtFHdCq+c=;
        b=rcDXsIXTDDENlpCZfz47uELqBMQpacRe63FMwzb7yjH2+YY+p6S8+D5ch0YveBOx0A
         Cor+NeH48kdyCUMateqExfNQlKQ9nhN+IFFVeAvofhkswnGvFvbIJJlnXu4pUOa2A4mz
         tyBVkGq/PFU+F6bpazwgxCh6amFP3bVurzj11OMZeiNd35sy0eNLO5idv1NNBq1hRkiu
         gvB2CnLAQLqU4XdiMmYeJUtwYMfNDjRyKhmZ5n/bgv2pzXyFWsD4/5DdU2p1FXeIkED5
         OBzmOLUgsEX6nar3uLR8RI/fDGUDurHX/UtHX4fEk20EjYADeUl12YQeGjiMfOy+L4Gv
         3MOg==
X-Gm-Message-State: AOJu0Yytplb7+0T4v9OheZ0IDfBTEM/tqEj2T2zLngxyHEbMHmsQ1Xdh
	8tLCaa2TAFg8OgwA5TFYemsvXosAGauf1g==
X-Google-Smtp-Source: AGHT+IHLmNz0ufeZCyfQfeJmN2RbmCoqg4A6qexF52CsPVGwSCJcP3oK14zXISYHyy1twRPceNVroQ==
X-Received: by 2002:a05:6402:20e:b0:553:4eb4:c231 with SMTP id t14-20020a056402020e00b005534eb4c231mr2492744edv.28.1703418570223;
        Sun, 24 Dec 2023 03:49:30 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] media: fimc-is: constify pointers to v4l2_pix_format_mplane
Date: Sun, 24 Dec 2023 12:49:13 +0100
Message-Id: <20231224114916.111433-9-krzysztof.kozlowski@linaro.org>
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

In few places functions do not modify pointed "struct
v4l2_pix_format_mplane", thus the pointer can point to const data for
additional safety and self-documenting intention of the function.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-capture.c   | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-m2m.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
index a3a677a3065f..7c2bcd5be933 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
@@ -1010,7 +1010,7 @@ static int __fimc_capture_set_format(struct fimc_dev *fimc,
 {
 	struct fimc_vid_cap *vc = &fimc->vid_cap;
 	struct fimc_ctx *ctx = vc->ctx;
-	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
+	const struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
 	struct fimc_frame *ff = &ctx->d_frame;
 	const struct fimc_fmt *inp_fmt = NULL;
 	int ret, i;
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c b/drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c
index 8fa26969c411..06c4352562b3 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c
@@ -40,7 +40,7 @@ static int isp_video_capture_queue_setup(struct vb2_queue *vq,
 			unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct fimc_isp *isp = vb2_get_drv_priv(vq);
-	struct v4l2_pix_format_mplane *vid_fmt = &isp->video_capture.pixfmt;
+	const struct v4l2_pix_format_mplane *vid_fmt = &isp->video_capture.pixfmt;
 	const struct fimc_fmt *fmt = isp->video_capture.format;
 	unsigned int wh, i;
 
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
index e9023f64cfba..e5829a457f3d 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
@@ -316,7 +316,7 @@ static int fimc_m2m_try_fmt_mplane(struct file *file, void *fh,
 
 static void __set_frame_format(struct fimc_frame *frame,
 			       const struct fimc_fmt *fmt,
-			       struct v4l2_pix_format_mplane *pixm)
+			       const struct v4l2_pix_format_mplane *pixm)
 {
 	int i;
 
-- 
2.34.1


