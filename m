Return-Path: <linux-kernel+bounces-152116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126EC8AB967
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4417D1C20BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFDFC0A;
	Sat, 20 Apr 2024 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xg33Wtb9"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BFD51D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585679; cv=none; b=sEewZHfdkbyZLv5WOtJz8WONTeVwAKicMAYCUF0rQ8vQpN9+vZ1drdNs2oU5bJ+JnBNrro0ZmXx1yXjdze6PINBvtoocccWzOL5r3L4+HpTAktBfqbyQBowgOpA8b8FfRpyxVH9wyu0B2s6POI2XMNU6ZtM8wGpWIkjVS2rjEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585679; c=relaxed/simple;
	bh=M4pHbBHCTk6OXLrTGfKxg4sxEmwBnn+uAuZwKWxdb8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0a8mTRBKcXGfxbmjlo4Zahr/wkbk2p5xCfNA7m/eksPJBju7zsQHZVaqfqZVd9sf3UOmviFNMJ5543Wg7PMhvivohZnGDdz80JGKwbRs9QjlJh5QvZoObYWZuJxpz/uVSg/pCDGyxoT1kBPugoQBCj/5t8gSEVAC/eZnLUcvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xg33Wtb9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so3822490e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713585676; x=1714190476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP3zMRO9agkYQSw4kCyfx8zOdyuio6KL48narpY5l5w=;
        b=xg33Wtb9u67WeMEvvVysZGLios272l4gWoQMC898DMIiyU0yxzrfXCKB/sIbSRLG+v
         KpPk/s/87PWl8MH6W6YXZDYfrtRIf/g1oVSV7hnH1yO/ledQhS97oqFP4Br89WiaCqqW
         M0Rb1O+N+HCS5KLhoz06GE8EYwAVCauhlxoHuJR670xBoxfKhpSK8e6FtQGWS/ZxRNh+
         r0EsisRTReT3g9srTuOW/MVgsdL3lbNErNjvIDJUMbNNWHHCXGlul0ICEIHf1v2RNDR7
         pm9k6ocxyeJT/H1GO7QuEazNvj3hIKY0anduBzoSqHqwAOly16fxQZRwMbMlmnKpscDF
         mgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713585676; x=1714190476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP3zMRO9agkYQSw4kCyfx8zOdyuio6KL48narpY5l5w=;
        b=tfTrQ5HQlr+XvS4nxEGyU9B7SIMnMAdz+j8ylfj2QcS6J4iZcPiS4WQzhKTcI1t25m
         mdd6iY7aRZO/ifOPrH62v4L2lnFvqG6OpUm949m1Bznftzax8Xu9UTTmTIgTTRDteUCC
         b8FQoc98uCQ8svBc07hai/fz97vgcqBrSxdud3fYojfQHBdtPGC3VofhqGdVVoJurOSg
         IdT6I/aD4hG3Ha1YdFh+sKMl5YFFjdlOaJkKjUwYZzrJfYwh3lJdq9wx3zTeTvs4ltan
         0X0eU87PJNFn5FsPxE6RZZJkE8E9qa+Ze9157FY+u6cOkb9j3NrSmavApw4LD729LL2r
         sjeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVeMC7tu2Z+4lXbczfW0xMnwRI8HGiRcnvPyGu8fH3oNbPEZo60w2DrJYDwmpWdhjEzhfjIrRVKNjj1GNnB5fleRWVf8G9huY52kIM
X-Gm-Message-State: AOJu0Yx0mZ3TQHt5cuqDGR2j+r0WzKLX00qFHw74SGGzpbwLJe5rL215
	LkvI7HG0Kf56gHsS/xu5OsQfDTYWR3+puZH1xlImveK3+28uBL7Iu1+N8l+nu0A=
X-Google-Smtp-Source: AGHT+IE4ZbNZvfmIXd8Qfqya1V9IQzxNnfLjFjzRPEDn5QGw3fOk4aJG2tv8V+m0Mqe+KePCzO9M/g==
X-Received: by 2002:a05:6512:4013:b0:518:758f:2610 with SMTP id br19-20020a056512401300b00518758f2610mr3435518lfb.48.1713585675804;
        Fri, 19 Apr 2024 21:01:15 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n2-20020a0565120ac200b00518c9ccef2esm1003993lfu.22.2024.04.19.21.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 21:01:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 07:00:59 +0300
Subject: [PATCH v2 2/9] drm/msm: add arrays listing formats supported by
 MDP4/MDP5 hardware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dpu-format-v2-2-9e93226cbffd@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6858;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=M4pHbBHCTk6OXLrTGfKxg4sxEmwBnn+uAuZwKWxdb8I=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5qyHcdKpmMbzvsca3WVnvivdHHIp9nW+RbPGyU7qi5UP
 tkrq6zbyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJ8C/jYFiyaYouh1dG2uGq
 YxOahbq/lWoHn+WdYt2+P0Krwf/2+fV3RAuYIyNeq29SUGZRV/k06c6dMAs9dmW7pNTu59+MC9k
 0uWqqa9wTr1UunRvalfJ0zqmO/Kean27tFHt+VrG/UD2S7bDaU6VXG7ov7S6Z3vPjQl67w7N95s
 FqoupBtjuuqF6uspK8vuKyJIObbuH9NT4l6y+9VVz5LTQv20zXWbBK4s9PLWn154azX4Tqq+g4t
 9Sdepz/0nypcOScoraTMq/2fN5x9vZdW+kXdk+cns/8FT53k15UgdA8A67wStadD3PfLRbyrNrQ
 7yP20F/P++q8VAXTfA7+K6bX1Y47SSWsD3n0VCcvW/k3AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

MDP4 and MDP5 drivers enumerate supported formats each time the plane is
created. In preparation to merger of MDP DPU format databases, define
precise formats list, so that changes to the database do not cause the
driver to add unsupported format to the list.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c | 57 +++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 36 ++++++++++++++-----
 drivers/gpu/drm/msm/disp/mdp_format.c      | 28 ---------------
 drivers/gpu/drm/msm/disp/mdp_kms.h         |  1 -
 4 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
index b689b618da78..cebe20c82a54 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
@@ -371,6 +371,47 @@ static const uint64_t supported_format_modifiers[] = {
 	DRM_FORMAT_MOD_INVALID
 };
 
+const uint32_t mdp4_rgb_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+};
+
+const uint32_t mdp4_rgb_yuv_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YVU420,
+};
+
 /* initialize plane */
 struct drm_plane *mdp4_plane_init(struct drm_device *dev,
 		enum mdp4_pipe pipe_id, bool private_plane)
@@ -379,6 +420,8 @@ struct drm_plane *mdp4_plane_init(struct drm_device *dev,
 	struct mdp4_plane *mdp4_plane;
 	int ret;
 	enum drm_plane_type type;
+	const uint32_t *formats;
+	unsigned int nformats;
 
 	mdp4_plane = kzalloc(sizeof(*mdp4_plane), GFP_KERNEL);
 	if (!mdp4_plane) {
@@ -392,13 +435,17 @@ struct drm_plane *mdp4_plane_init(struct drm_device *dev,
 	mdp4_plane->name = pipe_names[pipe_id];
 	mdp4_plane->caps = mdp4_pipe_caps(pipe_id);
 
-	mdp4_plane->nformats = mdp_get_formats(mdp4_plane->formats,
-			ARRAY_SIZE(mdp4_plane->formats),
-			!pipe_supports_yuv(mdp4_plane->caps));
-
 	type = private_plane ? DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
+
+	if (pipe_supports_yuv(mdp4_plane->caps)) {
+		formats = mdp4_rgb_yuv_formats;
+		nformats = ARRAY_SIZE(mdp4_rgb_yuv_formats);
+	} else {
+		formats = mdp4_rgb_formats;
+		nformats = ARRAY_SIZE(mdp4_rgb_formats);
+	}
 	ret = drm_universal_plane_init(dev, plane, 0xff, &mdp4_plane_funcs,
-				 mdp4_plane->formats, mdp4_plane->nformats,
+				 formats, nformats,
 				 supported_format_modifiers, type, NULL);
 	if (ret)
 		goto fail;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 0d5ff03cb091..aa8342d93393 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -17,9 +17,6 @@
 
 struct mdp5_plane {
 	struct drm_plane base;
-
-	uint32_t nformats;
-	uint32_t formats[32];
 };
 #define to_mdp5_plane(x) container_of(x, struct mdp5_plane, base)
 
@@ -1007,6 +1004,32 @@ uint32_t mdp5_plane_get_flush(struct drm_plane *plane)
 	return mask;
 }
 
+const uint32_t mdp5_plane_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YVU420,
+};
+
 /* initialize plane */
 struct drm_plane *mdp5_plane_init(struct drm_device *dev,
 				  enum drm_plane_type type)
@@ -1023,12 +1046,9 @@ struct drm_plane *mdp5_plane_init(struct drm_device *dev,
 
 	plane = &mdp5_plane->base;
 
-	mdp5_plane->nformats = mdp_get_formats(mdp5_plane->formats,
-		ARRAY_SIZE(mdp5_plane->formats), false);
-
 	ret = drm_universal_plane_init(dev, plane, 0xff, &mdp5_plane_funcs,
-			mdp5_plane->formats, mdp5_plane->nformats,
-			NULL, type, NULL);
+				       mdp5_plane_formats, ARRAY_SIZE(mdp5_plane_formats),
+				       NULL, type, NULL);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 025595336f26..69ab5bcff1a9 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -80,10 +80,6 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
 
 #define BPC0A 0
 
-/*
- * Note: Keep RGB formats 1st, followed by YUV formats to avoid breaking
- * mdp_get_rgb_formats()'s implementation.
- */
 static const struct mdp_format formats[] = {
 	/*  name      a  r  g  b   e0 e1 e2 e3  alpha   tight  cpp cnt ... */
 	FMT(ARGB8888, 8, 8, 8, 8,  1, 0, 2, 3,  true,   true,  4,  4,
@@ -138,30 +134,6 @@ static const struct mdp_format formats[] = {
 			MDP_PLANE_PLANAR, CHROMA_420, true),
 };
 
-/*
- * Note:
- * @rgb_only must be set to true, when requesting
- * supported formats for RGB pipes.
- */
-uint32_t mdp_get_formats(uint32_t *pixel_formats, uint32_t max_formats,
-		bool rgb_only)
-{
-	uint32_t i;
-	for (i = 0; i < ARRAY_SIZE(formats); i++) {
-		const struct mdp_format *f = &formats[i];
-
-		if (i == max_formats)
-			break;
-
-		if (rgb_only && MDP_FORMAT_IS_YUV(f))
-			break;
-
-		pixel_formats[i] = f->base.pixel_format;
-	}
-
-	return i;
-}
-
 const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format,
 		uint64_t modifier)
 {
diff --git a/drivers/gpu/drm/msm/disp/mdp_kms.h b/drivers/gpu/drm/msm/disp/mdp_kms.h
index b0286d5d5130..d0718c16de3e 100644
--- a/drivers/gpu/drm/msm/disp/mdp_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp_kms.h
@@ -91,7 +91,6 @@ struct mdp_format {
 #define to_mdp_format(x) container_of(x, struct mdp_format, base)
 #define MDP_FORMAT_IS_YUV(mdp_format) ((mdp_format)->is_yuv)
 
-uint32_t mdp_get_formats(uint32_t *formats, uint32_t max_formats, bool rgb_only);
 const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format, uint64_t modifier);
 
 /* MDP capabilities */

-- 
2.39.2


