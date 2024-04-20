Return-Path: <linux-kernel+bounces-152118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5ED8AB96E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8591F21587
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1D14AB4;
	Sat, 20 Apr 2024 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p44zOEKD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16371D502
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585680; cv=none; b=sjBi/whv/Jw11VzPm2FNGvSbtQy1UpPARxQjLTAJmc+sWqNTZtTWUS5/ZgvY+oMwV1T6g4WcFoNhvXEC0Wo5BAcYRr+xT0+dVEqN2JTRZIT4PGIayZkR58eA6vTLmuAZQ3Dlygum65AQWLCeNmXBHuPcBs+juPpc6Er/eVDwATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585680; c=relaxed/simple;
	bh=MwYVwVMvB5jxr43N4hwVfaTKlXV2S3ABYTdgVmhYE0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECaN1jViITfkRA57VUOmXAgr1bf+wYHqbY8kiufgf4nq4q2usbpyPvDoEy+UsJDWAHwfRRqYtMhTL8gDbp1E03R/gfMt9yHa7fZo9Dk9DW6im7okNKMwlG1KKWWjhHupVavjPPJKaAimud9EzWoXPvllt/uIu4ajG7CIs3frmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p44zOEKD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6c1e238so3345124e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713585675; x=1714190475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxyWG4yYIvf9uPeMWGErWSirlpq06SYD5MK+llU4huY=;
        b=p44zOEKDrj8fkW9Al73BF3TfNp2AvztEHlFKJIuvTBt9rCZShxpP6hJtlBX+7UYiS7
         sxYvsElldnXt01Ro0oMgsZNhM8a1LplneJbB2/ESwzWYJDHvIESOJrvW09Nlx+bxhDsP
         7M1/oFP3v7nqZeBxsEctNPa+tmpQH9O/0G+ozUhN2qIWUlUAjHCj2sLF2GZRxotrxZQ3
         ICHQ9jHJXfdI+bEDOSlYErqP8g/DJwUxplkoevhgpg2+i0ycb2veICu/vEpQ/YF+r1SL
         KS2IxbM48Atx8KLkNrLrKP4giEScWRHhgOMXakfa4JcwvYl3KTq7gSrT8pWMWtJvTTNO
         THfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713585675; x=1714190475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxyWG4yYIvf9uPeMWGErWSirlpq06SYD5MK+llU4huY=;
        b=kRI08ZGa2NSOTc05jBHOKSjIHtn3s+UtGK/cDYj73Sd9ebMZ+AGPelpqZgbcotyFqC
         2DPEoeqNZrjPI1apLPvPKBKHozeXJdVm1JH+moHypgc8Eoauj7pS3JD4+8U0r8UwBz9U
         IQxEbUL72jxmBhgPewkClBn2svvA2Unvz2kPxjzaur6M8CITFOGnlHgHz6r6l/9/Mm9Z
         waLpF3SWELgfLbqLCvKywdhlh5FZeHhS0W77gX7+p0B9UFhsGx47oZbOyABIJ5/PTIOC
         y2agPQUQZzwCq/7gLzsNo+yYaBZLXYQ/MRmPTYzgzOU12Y3Iug0JM00rovj8kv1HsA3x
         fc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDRcAVhlIQMi0qqy2ua6Q2kJBEdGfmZ/AQ1Gn4tvBq9WohxIk79q+Wzdzl83PfmI3EW8XTUi1UlFDa0w3uC9022bEFUF0xaEqMHilH
X-Gm-Message-State: AOJu0YyJ79CsWncXCZxXOO79ZyM9/QJBxGpyWGIFTo+e4Gr6pNzb3p0A
	4UlsEJ6hRbTbnr9RF6WWhvGwHnApmIPUkftIjnLg6dINDcJNymzlRTj15CH5nfQ=
X-Google-Smtp-Source: AGHT+IF/8lCxIIdfZHUuQbvTipjsZy9IfgE2/6GrAwiQq4q2eBrGzCI3k9uRhP0RCJulZofZhR5hVA==
X-Received: by 2002:a05:6512:1321:b0:516:c5b1:1b21 with SMTP id x33-20020a056512132100b00516c5b11b21mr2441809lfu.45.1713585675197;
        Fri, 19 Apr 2024 21:01:15 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n2-20020a0565120ac200b00518c9ccef2esm1003993lfu.22.2024.04.19.21.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 21:01:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 07:00:58 +0300
Subject: [PATCH v2 1/9] drm/msm/dpu: use format-related definitions from
 mdp_common.xml.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dpu-format-v2-1-9e93226cbffd@linaro.org>
References: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
In-Reply-To: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=32734;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MwYVwVMvB5jxr43N4hwVfaTKlXV2S3ABYTdgVmhYE0c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmIz4IsgqvX3cbX8x7fQ3w6bO7F0EvkRnfricdr
 u3czPvfd6qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZiM+CAAKCRCLPIo+Aiko
 1U5ZB/9NN97sf/vSAryOzEUmNLNzfvFnYYUnIr3B8hKZ4e3Z1TSfVY+GAeygRbewB/IYSKO+Wr7
 bNEUGVJ1bpP/RclUqdXHdZ1xwaNdEddxoeCpaw7MxpaJLIxJTl3Qf1mVVjlofzJ5y5gVoolVePi
 WDFhbME+RzWnqjVnSFfTcaHAmvVbICWr7To0UIJpGCCBu5X+meKIAyVJnJYkN6r/NG9vY9Yp7+/
 3tDYnsRPHvu1z+vySCRvsyxr1l7mfGaRPKZV0N55k3z63fzGbT7+aN8Kond2V0op9AjwlCzUq+I
 KsyS1l76q+GMNuW6h4jOpxQsSRKojf7dAyVA6CXgVqt63Evd
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Instead of having DPU-specific defines, switch to the definitions from
the mdp_common.xml.h file. This is the preparation for merged of DPU and
MDP format tables.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   8 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        | 290 ++++++++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c         |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |  64 +----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   4 +-
 8 files changed, 169 insertions(+), 219 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index aa1e68379d9f..43431cb55421 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2223,19 +2223,19 @@ void dpu_encoder_helper_phys_setup_cdm(struct dpu_encoder_phys *phys_enc,
 
 	/* enable 10 bit logic */
 	switch (cdm_cfg->output_fmt->chroma_sample) {
-	case DPU_CHROMA_RGB:
+	case CHROMA_FULL:
 		cdm_cfg->h_cdwn_type = CDM_CDWN_DISABLE;
 		cdm_cfg->v_cdwn_type = CDM_CDWN_DISABLE;
 		break;
-	case DPU_CHROMA_H2V1:
+	case CHROMA_H2V1:
 		cdm_cfg->h_cdwn_type = CDM_CDWN_COSITE;
 		cdm_cfg->v_cdwn_type = CDM_CDWN_DISABLE;
 		break;
-	case DPU_CHROMA_420:
+	case CHROMA_420:
 		cdm_cfg->h_cdwn_type = CDM_CDWN_COSITE;
 		cdm_cfg->v_cdwn_type = CDM_CDWN_OFFSITE;
 		break;
-	case DPU_CHROMA_H1V2:
+	case CHROMA_H1V2:
 	default:
 		DPU_ERROR("[enc:%d] unsupported chroma sampling type\n",
 			  DRMID(phys_enc->parent));
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 9dbb8ddcddec..ff41493147ab 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -594,7 +594,7 @@ static void dpu_encoder_phys_wb_prepare_wb_job(struct dpu_encoder_phys *phys_enc
 	wb_cfg->dest.height = job->fb->height;
 	wb_cfg->dest.num_planes = wb_cfg->dest.format->num_planes;
 
-	if ((wb_cfg->dest.format->fetch_planes == DPU_PLANE_PLANAR) &&
+	if ((wb_cfg->dest.format->fetch_planes == MDP_PLANE_PLANAR) &&
 			(wb_cfg->dest.format->element[0] == C1_B_Cb))
 		swap(wb_cfg->dest.plane_addr[1], wb_cfg->dest.plane_addr[2]);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index 95e6e58b1a21..87fa14fc5dd0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -35,11 +35,11 @@
 bp, flg, fm, np)                                                          \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_INTERLEAVED,                            \
+	.fetch_planes = MDP_PLANE_INTERLEAVED,                            \
 	.alpha_enable = alpha,                                            \
 	.element = { (e0), (e1), (e2), (e3) },                            \
 	.bits = { g, b, r, a },                                           \
-	.chroma_sample = DPU_CHROMA_RGB,                                  \
+	.chroma_sample = CHROMA_FULL,                                     \
 	.unpack_align_msb = 0,                                            \
 	.unpack_tight = 1,                                                \
 	.unpack_count = uc,                                               \
@@ -54,11 +54,11 @@ bp, flg, fm, np)                                                          \
 alpha, bp, flg, fm, np, th)                                               \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_INTERLEAVED,                            \
+	.fetch_planes = MDP_PLANE_INTERLEAVED,                            \
 	.alpha_enable = alpha,                                            \
 	.element = { (e0), (e1), (e2), (e3) },                            \
 	.bits = { g, b, r, a },                                           \
-	.chroma_sample = DPU_CHROMA_RGB,                                  \
+	.chroma_sample = CHROMA_FULL,                                     \
 	.unpack_align_msb = 0,                                            \
 	.unpack_tight = 1,                                                \
 	.unpack_count = uc,                                               \
@@ -74,7 +74,7 @@ alpha, bp, flg, fm, np, th)                                               \
 alpha, chroma, count, bp, flg, fm, np)                                    \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_INTERLEAVED,                            \
+	.fetch_planes = MDP_PLANE_INTERLEAVED,                            \
 	.alpha_enable = alpha,                                            \
 	.element = { (e0), (e1), (e2), (e3)},                             \
 	.bits = { g, b, r, a },                                           \
@@ -92,7 +92,7 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
 #define PSEUDO_YUV_FMT(fmt, a, r, g, b, e0, e1, chroma, flg, fm, np)      \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_PSEUDO_PLANAR,                          \
+	.fetch_planes = MDP_PLANE_PSEUDO_PLANAR,                          \
 	.alpha_enable = false,                                            \
 	.element = { (e0), (e1), 0, 0 },                                  \
 	.bits = { g, b, r, a },                                           \
@@ -111,7 +111,7 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
 flg, fm, np, th)                                                          \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_PSEUDO_PLANAR,                          \
+	.fetch_planes = MDP_PLANE_PSEUDO_PLANAR,                          \
 	.alpha_enable = false,                                            \
 	.element = { (e0), (e1), 0, 0 },                                  \
 	.bits = { g, b, r, a },                                           \
@@ -129,7 +129,7 @@ flg, fm, np, th)                                                          \
 #define PSEUDO_YUV_FMT_LOOSE(fmt, a, r, g, b, e0, e1, chroma, flg, fm, np)\
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_PSEUDO_PLANAR,                          \
+	.fetch_planes = MDP_PLANE_PSEUDO_PLANAR,                          \
 	.alpha_enable = false,                                            \
 	.element = { (e0), (e1), 0, 0 },                                  \
 	.bits = { g, b, r, a },                                           \
@@ -148,7 +148,7 @@ flg, fm, np, th)                                                          \
 flg, fm, np, th)                                                          \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_PSEUDO_PLANAR,                          \
+	.fetch_planes = MDP_PLANE_PSEUDO_PLANAR,                          \
 	.alpha_enable = false,                                            \
 	.element = { (e0), (e1), 0, 0 },                                  \
 	.bits = { g, b, r, a },                                           \
@@ -168,7 +168,7 @@ flg, fm, np, th)                                                          \
 flg, fm, np)                                                      \
 {                                                                         \
 	.base.pixel_format = DRM_FORMAT_ ## fmt,                          \
-	.fetch_planes = DPU_PLANE_PLANAR,                                 \
+	.fetch_planes = MDP_PLANE_PLANAR,                                 \
 	.alpha_enable = alpha,                                            \
 	.element = { (e0), (e1), (e2), 0 },                               \
 	.bits = { g, b, r, a },                                           \
@@ -195,286 +195,286 @@ struct dpu_media_color_map {
 
 static const struct dpu_format dpu_format_map[] = {
 	INTERLEAVED_RGB_FMT(ARGB8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		true, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ABGR8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XBGR8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		false, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBA8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		true, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRA8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		true, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRX8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		false, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XRGB8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		false, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBX8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		false, 4, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGB888,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
 		false, 3, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGR888,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
 		false, 3, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGB565,
-		0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
+		0, BPC5, BPC6, BPC5,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGR565,
-		0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
+		0, BPC5, BPC6, BPC5,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ARGB1555,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ABGR1555,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBA5551,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRA5551,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XRGB1555,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XBGR1555,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBX5551,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRX5551,
-		COLOR_ALPHA_1BIT, COLOR_5BIT, COLOR_5BIT, COLOR_5BIT,
+		BPC1A, BPC5, BPC5, BPC5,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ARGB4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ABGR4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBA4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRA4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		true, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XRGB4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XBGR4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBX4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRX4444,
-		COLOR_ALPHA_4BIT, COLOR_4BIT, COLOR_4BIT, COLOR_4BIT,
+		BPC4A, BPC4, BPC4, BPC4,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		false, 2, 0,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRA1010102,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		true, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBA1010102,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		true, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ABGR2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(ARGB2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XRGB2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C3_ALPHA, 4,
 		false, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGRX1010102,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C2_R_Cr, C0_G_Y, C1_B_Cb, 4,
 		false, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(XBGR2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		false, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBX1010102,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C3_ALPHA, C1_B_Cb, C0_G_Y, C2_R_Cr, 4,
 		false, 4, DPU_FORMAT_FLAG_DX,
-		DPU_FETCH_LINEAR, 1),
+		MDP_FETCH_LINEAR, 1),
 
 	PSEUDO_YUV_FMT(NV12,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		DPU_CHROMA_420, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		CHROMA_420, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	PSEUDO_YUV_FMT(NV21,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C2_R_Cr, C1_B_Cb,
-		DPU_CHROMA_420, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		CHROMA_420, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	PSEUDO_YUV_FMT(NV16,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		DPU_CHROMA_H2V1, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		CHROMA_H2V1, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	PSEUDO_YUV_FMT(NV61,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C2_R_Cr, C1_B_Cb,
-		DPU_CHROMA_H2V1, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		CHROMA_H2V1, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	PSEUDO_YUV_FMT_LOOSE(P010,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		DPU_CHROMA_420, DPU_FORMAT_FLAG_DX | DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		CHROMA_420, DPU_FORMAT_FLAG_DX | DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	INTERLEAVED_YUV_FMT(VYUY,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C0_G_Y,
-		false, DPU_CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		false, CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	INTERLEAVED_YUV_FMT(UYVY,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C0_G_Y,
-		false, DPU_CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		false, CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	INTERLEAVED_YUV_FMT(YUYV,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C0_G_Y, C1_B_Cb, C0_G_Y, C2_R_Cr,
-		false, DPU_CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		false, CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	INTERLEAVED_YUV_FMT(YVYU,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C0_G_Y, C2_R_Cr, C0_G_Y, C1_B_Cb,
-		false, DPU_CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 2),
+		false, CHROMA_H2V1, 4, 2, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 2),
 
 	PLANAR_YUV_FMT(YUV420,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C2_R_Cr, C1_B_Cb, C0_G_Y,
-		false, DPU_CHROMA_420, 1, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 3),
+		false, CHROMA_420, 1, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 3),
 
 	PLANAR_YUV_FMT(YVU420,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr, C0_G_Y,
-		false, DPU_CHROMA_420, 1, DPU_FORMAT_FLAG_YUV,
-		DPU_FETCH_LINEAR, 3),
+		false, CHROMA_420, 1, DPU_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 3),
 };
 
 /*
@@ -485,88 +485,88 @@ static const struct dpu_format dpu_format_map[] = {
  */
 static const struct dpu_format dpu_format_map_ubwc[] = {
 	INTERLEAVED_RGB_FMT_TILED(BGR565,
-		0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
+		0, BPC5, BPC6, BPC5,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
 		false, 2, DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	INTERLEAVED_RGB_FMT_TILED(ABGR8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	/* ARGB8888 and ABGR8888 purposely have the same color
 	 * ordering.  The hardware only supports ABGR8888 UBWC
 	 * natively.
 	 */
 	INTERLEAVED_RGB_FMT_TILED(ARGB8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	INTERLEAVED_RGB_FMT_TILED(XBGR8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		false, 4, DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	INTERLEAVED_RGB_FMT_TILED(XRGB8888,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		false, 4, DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	INTERLEAVED_RGB_FMT_TILED(ABGR2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_DX | DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	INTERLEAVED_RGB_FMT_TILED(XBGR2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_DX | DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	INTERLEAVED_RGB_FMT_TILED(XRGB2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_DX | DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	/* XRGB2101010 and ARGB2101010 purposely have the same color
 	* ordering.  The hardware only supports ARGB2101010 UBWC
 	* natively.
 	*/
 	INTERLEAVED_RGB_FMT_TILED(ARGB2101010,
-		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
 		true, 4, DPU_FORMAT_FLAG_DX | DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 2, DPU_TILE_HEIGHT_UBWC),
 
 	PSEUDO_YUV_FMT_TILED(NV12,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		DPU_CHROMA_420, DPU_FORMAT_FLAG_YUV |
+		CHROMA_420, DPU_FORMAT_FLAG_YUV |
 				DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 4, DPU_TILE_HEIGHT_NV12),
+		MDP_FETCH_UBWC, 4, DPU_TILE_HEIGHT_NV12),
 
 	PSEUDO_YUV_FMT_TILED(P010,
-		0, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
+		0, BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		DPU_CHROMA_420, DPU_FORMAT_FLAG_DX |
+		CHROMA_420, DPU_FORMAT_FLAG_DX |
 				DPU_FORMAT_FLAG_YUV |
 				DPU_FORMAT_FLAG_COMPRESSED,
-		DPU_FETCH_UBWC, 4, DPU_TILE_HEIGHT_UBWC),
+		MDP_FETCH_UBWC, 4, DPU_TILE_HEIGHT_UBWC),
 };
 
 /* _dpu_get_v_h_subsample_rate - Get subsample rates for all formats we support
  *   Note: Not using the drm_format_*_subsampling since we have formats
  */
 static void _dpu_get_v_h_subsample_rate(
-	enum dpu_chroma_samp_type chroma_sample,
+	enum mdp_chroma_samp_type chroma_sample,
 	uint32_t *v_sample,
 	uint32_t *h_sample)
 {
@@ -574,15 +574,15 @@ static void _dpu_get_v_h_subsample_rate(
 		return;
 
 	switch (chroma_sample) {
-	case DPU_CHROMA_H2V1:
+	case CHROMA_H2V1:
 		*v_sample = 1;
 		*h_sample = 2;
 		break;
-	case DPU_CHROMA_H1V2:
+	case CHROMA_H1V2:
 		*v_sample = 2;
 		*h_sample = 1;
 		break;
-	case DPU_CHROMA_420:
+	case CHROMA_420:
 		*v_sample = 2;
 		*h_sample = 2;
 		break;
@@ -724,7 +724,7 @@ static int _dpu_format_get_plane_sizes_linear(
 	layout->num_planes = fmt->num_planes;
 
 	/* Due to memset above, only need to set planes of interest */
-	if (fmt->fetch_planes == DPU_PLANE_INTERLEAVED) {
+	if (fmt->fetch_planes == MDP_PLANE_INTERLEAVED) {
 		layout->num_planes = 1;
 		layout->plane_size[0] = width * height * layout->format->bpp;
 		layout->plane_pitch[0] = width * layout->format->bpp;
@@ -751,7 +751,7 @@ static int _dpu_format_get_plane_sizes_linear(
 		layout->plane_size[1] = layout->plane_pitch[1] *
 				(height / v_subsample);
 
-		if (fmt->fetch_planes == DPU_PLANE_PSEUDO_PLANAR) {
+		if (fmt->fetch_planes == MDP_PLANE_PSEUDO_PLANAR) {
 			layout->num_planes = 2;
 			layout->plane_size[1] *= 2;
 			layout->plane_pitch[1] *= 2;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
index 9016b3ade6bc..3602cbda793e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
@@ -186,7 +186,7 @@ static int dpu_hw_cdm_enable(struct dpu_hw_cdm *ctx, struct dpu_hw_cdm_cfg *cdm)
 	dpu_hw_cdm_setup_cdwn(ctx, cdm);
 
 	if (cdm->output_type == CDM_CDWN_OUTPUT_HDMI) {
-		if (fmt->chroma_sample == DPU_CHROMA_H1V2)
+		if (fmt->chroma_sample == CHROMA_H1V2)
 			return -EINVAL; /*unsupported format */
 		opmode = CDM_HDMI_PACK_OP_MODE_EN;
 		opmode |= (fmt->chroma_sample << 1);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 965692ef7892..55c7e941e163 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -201,9 +201,9 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 				(0x21 << 8));
 	else
 		/* Interface treats all the pixel data in RGB888 format */
-		panel_format = (COLOR_8BIT |
-				(COLOR_8BIT << 2) |
-				(COLOR_8BIT << 4) |
+		panel_format = (BPC8 |
+				(BPC8 << 2) |
+				(BPC8 << 4) |
 				(0x21 << 8));
 
 	DPU_REG_WRITE(c, INTF_HSYNC_CTL, hsync_ctl);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 5df545904057..31f97f535ce9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 
 #include "msm_drv.h"
+#include "mdp_common.xml.h"
 
 #define DPU_DBG_NAME			"dpu"
 
@@ -49,12 +50,12 @@ enum dpu_format_flags {
 	(test_bit(DPU_FORMAT_FLAG_YUV_BIT, (X)->flag))
 #define DPU_FORMAT_IS_DX(X)		\
 	(test_bit(DPU_FORMAT_FLAG_DX_BIT, (X)->flag))
-#define DPU_FORMAT_IS_LINEAR(X)		((X)->fetch_mode == DPU_FETCH_LINEAR)
+#define DPU_FORMAT_IS_LINEAR(X)		((X)->fetch_mode == MDP_FETCH_LINEAR)
 #define DPU_FORMAT_IS_TILE(X) \
-	(((X)->fetch_mode == DPU_FETCH_UBWC) && \
+	(((X)->fetch_mode == MDP_FETCH_UBWC) && \
 			!test_bit(DPU_FORMAT_FLAG_COMPRESSED_BIT, (X)->flag))
 #define DPU_FORMAT_IS_UBWC(X) \
-	(((X)->fetch_mode == DPU_FETCH_UBWC) && \
+	(((X)->fetch_mode == MDP_FETCH_UBWC) && \
 			test_bit(DPU_FORMAT_FLAG_COMPRESSED_BIT, (X)->flag))
 
 #define DPU_BLEND_FG_ALPHA_FG_CONST	(0 << 0)
@@ -300,57 +301,6 @@ enum {
 	C3_ALPHA = 3
 };
 
-/**
- * enum dpu_plane_type - defines how the color component pixel packing
- * @DPU_PLANE_INTERLEAVED   : Color components in single plane
- * @DPU_PLANE_PLANAR        : Color component in separate planes
- * @DPU_PLANE_PSEUDO_PLANAR : Chroma components interleaved in separate plane
- */
-enum dpu_plane_type {
-	DPU_PLANE_INTERLEAVED,
-	DPU_PLANE_PLANAR,
-	DPU_PLANE_PSEUDO_PLANAR,
-};
-
-/**
- * enum dpu_chroma_samp_type - chroma sub-samplng type
- * @DPU_CHROMA_RGB   : No chroma subsampling
- * @DPU_CHROMA_H2V1  : Chroma pixels are horizontally subsampled
- * @DPU_CHROMA_H1V2  : Chroma pixels are vertically subsampled
- * @DPU_CHROMA_420   : 420 subsampling
- */
-enum dpu_chroma_samp_type {
-	DPU_CHROMA_RGB,
-	DPU_CHROMA_H2V1,
-	DPU_CHROMA_H1V2,
-	DPU_CHROMA_420
-};
-
-/**
- * dpu_fetch_type - Defines How DPU HW fetches data
- * @DPU_FETCH_LINEAR   : fetch is line by line
- * @DPU_FETCH_TILE     : fetches data in Z order from a tile
- * @DPU_FETCH_UBWC     : fetch and decompress data
- */
-enum dpu_fetch_type {
-	DPU_FETCH_LINEAR,
-	DPU_FETCH_TILE,
-	DPU_FETCH_UBWC
-};
-
-/**
- * Value of enum chosen to fit the number of bits
- * expected by the HW programming.
- */
-enum {
-	COLOR_ALPHA_1BIT = 0,
-	COLOR_ALPHA_4BIT = 1,
-	COLOR_4BIT = 0,
-	COLOR_5BIT = 1, /* No 5-bit Alpha */
-	COLOR_6BIT = 2, /* 6-Bit Alpha also = 2 */
-	COLOR_8BIT = 3, /* 8-Bit Alpha also = 3 */
-};
-
 /**
  * enum dpu_3d_blend_mode
  * Desribes how the 3d data is blended
@@ -390,17 +340,17 @@ enum dpu_3d_blend_mode {
  */
 struct dpu_format {
 	struct msm_format base;
-	enum dpu_plane_type fetch_planes;
+	enum mdp_fetch_type fetch_planes;
 	u8 element[DPU_MAX_PLANES];
 	u8 bits[DPU_MAX_PLANES];
-	enum dpu_chroma_samp_type chroma_sample;
+	enum mdp_chroma_samp_type chroma_sample;
 	u8 unpack_align_msb;
 	u8 unpack_tight;
 	u8 unpack_count;
 	u8 bpp;
 	u8 alpha_enable;
 	u8 num_planes;
-	enum dpu_fetch_type fetch_mode;
+	enum mdp_fetch_mode fetch_mode;
 	DECLARE_BITMAP(flag, DPU_FORMAT_FLAG_BIT_MAX);
 	u16 tile_width;
 	u16 tile_height;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 0bf8a83e8df3..896fb576f5b5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -241,10 +241,10 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 
 	chroma_samp = fmt->chroma_sample;
 	if (flags & DPU_SSPP_SOURCE_ROTATED_90) {
-		if (chroma_samp == DPU_CHROMA_H2V1)
-			chroma_samp = DPU_CHROMA_H1V2;
-		else if (chroma_samp == DPU_CHROMA_H1V2)
-			chroma_samp = DPU_CHROMA_H2V1;
+		if (chroma_samp == CHROMA_H2V1)
+			chroma_samp = CHROMA_H1V2;
+		else if (chroma_samp == CHROMA_H1V2)
+			chroma_samp = CHROMA_H2V1;
 	}
 
 	src_format = (chroma_samp << 23) | (fmt->fetch_planes << 19) |
@@ -254,7 +254,7 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 	if (flags & DPU_SSPP_ROT_90)
 		src_format |= BIT(11); /* ROT90 */
 
-	if (fmt->alpha_enable && fmt->fetch_planes == DPU_PLANE_INTERLEAVED)
+	if (fmt->alpha_enable && fmt->fetch_planes == MDP_PLANE_INTERLEAVED)
 		src_format |= BIT(8); /* SRCC3_EN */
 
 	if (flags & DPU_SSPP_SOLID_FILL)
@@ -267,7 +267,7 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 		(fmt->unpack_align_msb << 18) |
 		((fmt->bpp - 1) << 9);
 
-	if (fmt->fetch_mode != DPU_FETCH_LINEAR) {
+	if (fmt->fetch_mode != MDP_FETCH_LINEAR) {
 		if (DPU_FORMAT_IS_UBWC(fmt))
 			opmode |= MDSS_MDP_OP_BWC_EN;
 		src_format |= (fmt->fetch_mode & 3) << 30; /*FRAME_FORMAT */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index ff4ac4daaeca..daaf6fe7e904 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -214,8 +214,8 @@ static int _dpu_plane_calc_fill_level(struct drm_plane *plane,
 
 	/* FIXME: in multirect case account for the src_width of all the planes */
 
-	if (fmt->fetch_planes == DPU_PLANE_PSEUDO_PLANAR) {
-		if (fmt->chroma_sample == DPU_CHROMA_420) {
+	if (fmt->fetch_planes == MDP_PLANE_PSEUDO_PLANAR) {
+		if (fmt->chroma_sample == CHROMA_420) {
 			/* NV12 */
 			total_fl = (fixed_buff_size / 2) /
 				((src_width + 32) * fmt->bpp);

-- 
2.39.2


