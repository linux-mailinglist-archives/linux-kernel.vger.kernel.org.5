Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEDD7688A7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjG3V6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjG3V63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:58:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39337172C;
        Sun, 30 Jul 2023 14:58:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7866189cff1so223446139f.0;
        Sun, 30 Jul 2023 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690754302; x=1691359102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzT1NtmhVPgMEzc8/Vu/DYGCtAi6F3prLfzQtzunD4A=;
        b=i0VV1Pxf7fG96sx0/4My6LgaDnMdoakFvgPb0GqVsaBE0OE88LPAs1C1z/LFiLzGY5
         tK1P659w0nu2hKiaVoiKdy0SSV51ZlEFs7/CvGJkv6PZFbBdo/R3QRsLeXdRm7XDC7O9
         wdfHH3f0+y2lP3D4FCSXCk8XG7edQ5vLizkTzo3oJESZdEuVmPQAuLS37O0S5Smj3X5w
         7omb+y63UjShSSAZwWtxVTQuLG+fBkZSNtQrEhVlp8snane6OWnw89sObWaAS8FCbao2
         fVuSfXU/JV8oMmCqhR0azQwVHqLzvgLTHx2O7JPpxlBqAO6ok++yOGD8Jat+Qlr4jLNA
         /YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690754302; x=1691359102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzT1NtmhVPgMEzc8/Vu/DYGCtAi6F3prLfzQtzunD4A=;
        b=BgTqcosHqUhG45QhPwDDoX4cpLPSdeIliEirYJRxM5ID9AcXQTb1igItARl2+P6xoS
         OfKfGw/MRxEXmUrvc3H/Y5WAcTuNbW+Kwx4Rg1UmNg9R6v9Z/0WhmxnOqNoi7mrNhVqD
         i0puSXRqp8OSo/JCMojgQNPV6ngTsSphJmKuQqPDSs8ymbrPlAnTGUQn8ESBDZQ+3J70
         nYxbUlbQT6hBCveKEN6WECIZvyjXmYIMhLk/F7Kqg2dRTUFpwWgjTJpyVaWnNhdMXmfS
         rTmsWJ+g3iPxZE6EU4l+uPs+REv+gjkTqH21UtOLotfBHyoA4WHTjIyMcCpgD4Gkp8h9
         U7eg==
X-Gm-Message-State: ABy/qLaxPp8ZGJ8vkCNd0amU/s5lXboP5JVy+9Rd7PFRwoBHTSj/K0f5
        PIqY6crPegixFshUWepJHuw=
X-Google-Smtp-Source: APBJJlH4diQF/gKGaFZFV2noWGnmxyr7j4k1TEOXzKb7Z048RyRdykHNxKRIZVn7OfF540vKITQnhg==
X-Received: by 2002:a05:6e02:218d:b0:346:d51:9922 with SMTP id j13-20020a056e02218d00b003460d519922mr8975282ila.13.1690754302289;
        Sun, 30 Jul 2023 14:58:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e18-20020a92de52000000b003424b3d6d37sm2747520ilr.24.2023.07.30.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 14:58:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 3/5] drm_dbg: add trailing newlines
Date:   Sun, 30 Jul 2023 15:57:52 -0600
Message-ID: <20230730215758.54010-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730215758.54010-1-jim.cromie@gmail.com>
References: <20230730215758.54010-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index e3f61c39df69..80166f702a0d 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -89,7 +89,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++) {
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
@@ -176,7 +176,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 	const struct msm_format *format;
 	int ret, i, n;
 
-	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)",
+	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)\n",
 			mode_cmd, mode_cmd->width, mode_cmd->height,
 			(char *)&mode_cmd->pixel_format);
 
@@ -232,7 +232,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 
 	refcount_set(&msm_fb->dirtyfb, 1);
 
-	drm_dbg_state(dev, "create: FB ID: %d (%p)", fb->base.id, fb);
+	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 
 	return fb;
 
-- 
2.41.0

