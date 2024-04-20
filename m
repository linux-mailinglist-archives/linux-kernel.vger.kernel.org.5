Return-Path: <linux-kernel+bounces-152122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6288AB977
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4071C20BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D0D530;
	Sat, 20 Apr 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwhsq/Tw"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1014012
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585684; cv=none; b=PzTCrgEsPpuwYQxQCR/RuAMRVKrXQHIrij33OXyOlzcCDnOkZgO/hWbUgzXOn1TlIuivUMKVuxsxW67a9SoLinvGUVGufZjXZludht39waTEAoZtSBmOm8wdMLp3AKiBaIvZQIQiUc1MPY0TjkNsQUdopFfiDwAeZLExvaJntXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585684; c=relaxed/simple;
	bh=AuQCRrUqnRgpA+wocS6SRQv47Exck7/IT0ZD+APsLPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py2G8VP1ZC5GVd52ea9drUlq4D0O708JDTVcRx4xTZ7MKk9F+KpMcNzXZIjNwXn3HjPBqZj2SpxsEfGfd1CVfh9lpoZ83nEOrwUvMs0NDZ9oTN1y+/SvPI2qcXPAKFGsdR+b4Jolay3YE1yOQc9JavhD7VM/f5PKyamabwi15+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwhsq/Tw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5196fe87775so2953713e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713585680; x=1714190480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/VxGMXcUC7972zZCvX/pqSyv12NV0CZxNoZzzTE6kI=;
        b=zwhsq/Tw+L39we1Xcfko9l7N0PuBBb1AOn/oniYuisxQSyYC9/sCXgz8QhSvBCVPGb
         tUEUX2OPDW5xUUR0zowcLK6gi1mzI8uxjCSDYK52aWu3QasdjuVVdJBPOKS+PteWm8EX
         I5wUPckHI83y8FhQvut+SFmUF7IAdMhSDiijxEIn0geF21lFboCRmyk0J5jSBB7GcPVS
         OMmMfA5Woocti2fNSN/ITtcMSiu0RTt/JujMtbJnuz0uKiKMTSt73VEg+P4jlVWmqlyR
         +Rc5/Dr4+4PrkJmrQQVHWLJGx6/tjqsXRaOZB505IjC/A1AP/5i4SlgdWrVXNlrYIkTm
         FApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713585680; x=1714190480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/VxGMXcUC7972zZCvX/pqSyv12NV0CZxNoZzzTE6kI=;
        b=th114QMVAakPveu0siyNH3GDZ0u+6b1dg+rcq3RYjjCZl6QYdRxCjZZn4H6O9/QY5U
         zjePYnyJVsdPW10xNK/i/s8pLZdmkd3JKXqRjcW0lKSfQBf67V1CgcSROHCqsKzj2bYf
         VUk90bhoo8sZmmRsdmfUW1ZkGViSuACfrAwzcik0HxdEOj37BXcHbH08gMEF39IifBDe
         O0qWz87eF5oPOmJ3kGbt+g97c60RjnsvVvt0IcxebpAgFLC4s0nduDY7XKs6wiBNTP5h
         MhbmEYfMQDoTCYMUCF8/aYyWfCgkgMhQN4AbDXgL0DIm4mxs11r57uaeTle0YipAB+ML
         dHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+MJMTCRlfinCDmzCzKAuwtIwOFdf3MlZxLad6g5FvOUQlWcBUBQ1sXRkW+nd+j+wx5jCsPcZ5dE2X7UbL6b8v3/p+/RYeubtrc/hX
X-Gm-Message-State: AOJu0YzjLELCbqwAwgd2R5Bzr8OMJCTEyNizOKKgF18eDAn74jGZweGt
	7mf2X4D2seJnwSyA1yvIKc/FwqW6UZ4GDnNFKKM2Q3esG3dh+Acyxp++iOrdu2o=
X-Google-Smtp-Source: AGHT+IExfEx8mtIjS5cmRBdCMsJal/rOeQBcMIzLPL1KlsMhscz6HdMjaPI7HsEUj9jEqYhbV7LABQ==
X-Received: by 2002:a05:6512:20c6:b0:519:5fdb:82b4 with SMTP id u6-20020a05651220c600b005195fdb82b4mr2619745lfr.53.1713585680688;
        Fri, 19 Apr 2024 21:01:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n2-20020a0565120ac200b00518c9ccef2esm1003993lfu.22.2024.04.19.21.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 21:01:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 07:01:06 +0300
Subject: [PATCH v2 9/9] drm/msm: drop msm_kms_funcs::get_format() callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dpu-format-v2-9-9e93226cbffd@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6653;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AuQCRrUqnRgpA+wocS6SRQv47Exck7/IT0ZD+APsLPs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmIz4JalQ/C4huecCuIwaBnq4a41g+VFrXEY/0k
 5kyuo/oA6SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZiM+CQAKCRCLPIo+Aiko
 1d7gB/95fNnDzI2OUr6Gjh7izMHsbdDyeuAtsuUWPCMo5pm+tRuaZ+l2n9RhkqrOourPY7ME1uH
 hwUzKuoFxQgX57jLZxS/xbwAbaOtD+u/cxNWxnD+9W9fpgqKlwtuyfvVEuVGJ1KoYNKjHSI8vOt
 MMUvV70iQ962b/z0W82zpmvIbAycbedL8/RgpEsfZndaL5L887ojD5dUztpVwn4Zz4/s9OyTm4s
 ECiQO/JghIJGsDgRJSVd4DS+6o0Kj+EhNiuFkeDRf+7xwlshH0T/23JmLB9+4VXzE3V/g/oVPpV
 74zvI9peLb5aH9Q0pYEelC0vfUquaEO0Up8zi6WCdicyHGBV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Now as all subdrivers were converted to use common database of formats,
drop the get_format() callback and use mdp_get_format() directly.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 4 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c  | 5 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c              | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c            | 2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c             | 1 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c             | 1 -
 drivers/gpu/drm/msm/msm_fb.c                         | 2 +-
 drivers/gpu/drm/msm/msm_kms.h                        | 4 ----
 8 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index b966c44ec835..ef69c2f408c3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -274,7 +274,7 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 
 	drm_mode_to_intf_timing_params(phys_enc, &mode, &timing_params);
 
-	fmt = phys_enc->dpu_kms->base.funcs->get_format(&phys_enc->dpu_kms->base, fmt_fourcc, 0);
+	fmt = mdp_get_format(&phys_enc->dpu_kms->base, fmt_fourcc, 0);
 	DPU_DEBUG_VIDENC(phys_enc, "fmt_fourcc 0x%X\n", fmt_fourcc);
 
 	if (phys_enc->hw_cdm)
@@ -414,7 +414,7 @@ static void dpu_encoder_phys_vid_enable(struct dpu_encoder_phys *phys_enc)
 
 	ctl = phys_enc->hw_ctl;
 	fmt_fourcc = dpu_encoder_get_drm_fmt(phys_enc);
-	fmt = phys_enc->dpu_kms->base.funcs->get_format(&phys_enc->dpu_kms->base, fmt_fourcc, 0);
+	fmt = mdp_get_format(&phys_enc->dpu_kms->base, fmt_fourcc, 0);
 
 	DPU_DEBUG_VIDENC(phys_enc, "\n");
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index de17bcbb8492..d3ea91c1d7d2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -326,8 +326,7 @@ static void dpu_encoder_phys_wb_setup(
 
 	wb_job = wb_enc->wb_job;
 	format = msm_framebuffer_format(wb_enc->wb_job->fb);
-	dpu_fmt = phys_enc->dpu_kms->base.funcs->get_format(&phys_enc->dpu_kms->base,
-							    format->pixel_format, wb_job->fb->modifier);
+	dpu_fmt = mdp_get_format(&phys_enc->dpu_kms->base, format->pixel_format, wb_job->fb->modifier);
 
 	DPU_DEBUG("[mode_set:%d, \"%s\",%d,%d]\n",
 			hw_wb->idx - WB_0, mode.name,
@@ -577,7 +576,7 @@ static void dpu_encoder_phys_wb_prepare_wb_job(struct dpu_encoder_phys *phys_enc
 
 	format = msm_framebuffer_format(job->fb);
 
-	wb_cfg->dest.format = phys_enc->dpu_kms->base.funcs->get_format(&phys_enc->dpu_kms->base,
+	wb_cfg->dest.format = mdp_get_format(&phys_enc->dpu_kms->base,
 					     format->pixel_format, job->fb->modifier);
 	if (!wb_cfg->dest.format) {
 		/* this error should be detected during atomic_check */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index cb30137443e8..1955848b1b78 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -982,7 +982,6 @@ static const struct msm_kms_funcs kms_funcs = {
 	.enable_vblank   = dpu_kms_enable_vblank,
 	.disable_vblank  = dpu_kms_disable_vblank,
 	.check_modified_format = dpu_format_check_modified_format,
-	.get_format      = mdp_get_format,
 	.destroy         = dpu_kms_destroy,
 	.snapshot        = dpu_kms_mdp_snapshot,
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index b92a13cc9b36..1c3a2657450c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -627,7 +627,7 @@ static void _dpu_plane_color_fill(struct dpu_plane *pdpu,
 	 * select fill format to match user property expectation,
 	 * h/w only supports RGB variants
 	 */
-	fmt = priv->kms->funcs->get_format(priv->kms, DRM_FORMAT_ABGR8888, 0);
+	fmt = mdp_get_format(priv->kms, DRM_FORMAT_ABGR8888, 0);
 	/* should not happen ever */
 	if (!fmt)
 		return;
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 4ba1cb74ad76..6e4e74f9d63d 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -151,7 +151,6 @@ static const struct mdp_kms_funcs kms_funcs = {
 		.flush_commit    = mdp4_flush_commit,
 		.wait_flush      = mdp4_wait_flush,
 		.complete_commit = mdp4_complete_commit,
-		.get_format      = mdp_get_format,
 		.round_pixclk    = mdp4_round_pixclk,
 		.destroy         = mdp4_destroy,
 	},
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index a874fd95cc20..374704cce656 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -224,7 +224,6 @@ static const struct mdp_kms_funcs kms_funcs = {
 		.prepare_commit  = mdp5_prepare_commit,
 		.wait_flush      = mdp5_wait_flush,
 		.complete_commit = mdp5_complete_commit,
-		.get_format      = mdp_get_format,
 		.destroy         = mdp5_kms_destroy,
 	},
 	.set_irqmask         = mdp5_set_irqmask,
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index ad4bb2b2cd66..09268e416843 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -181,7 +181,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 		      &mode_cmd->pixel_format);
 
 	n = info->num_planes;
-	format = kms->funcs->get_format(kms, mode_cmd->pixel_format,
+	format = mdp_get_format(kms, mode_cmd->pixel_format,
 			mode_cmd->modifier[0]);
 	if (!format) {
 		DRM_DEV_ERROR(dev->dev, "unsupported pixel format: %p4cc\n",
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 0641f6111b93..1e0c54de3716 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -92,10 +92,6 @@ struct msm_kms_funcs {
 	 * Format handling:
 	 */
 
-	/* get msm_format w/ optional format modifiers from drm_mode_fb_cmd2 */
-	const struct msm_format *(*get_format)(struct msm_kms *kms,
-					const uint32_t format,
-					const uint64_t modifiers);
 	/* do format checking on format modified through fb_cmd2 modifiers */
 	int (*check_modified_format)(const struct msm_kms *kms,
 			const struct msm_format *msm_fmt,

-- 
2.39.2


