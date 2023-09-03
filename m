Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3C790D76
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbjICSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345337AbjICSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5955F10C;
        Sun,  3 Sep 2023 11:46:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7926de0478eso33144739f.0;
        Sun, 03 Sep 2023 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766779; x=1694371579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ/W1vAuvct0eQaNfV42dDs6Is2Bz/K+5cHGfVn4Nlg=;
        b=pxXggN7K2cIPZVnbjYusU98adr1ZMQOKsZWZrvt0zCwmMzVzAoiU83hMA3LMU6NAPx
         BoJdQDi9U3oNtcJ7WwaGJNLB9GXEHcmGam+7QopzWx2LnvFmCen7KJjog1x6dUIqhcbq
         z8px5QTzhBTdyU9WQgKKq97M4fXd9qBfTqY/dvFfq6dh3aPgfiVtelMaskIIGZT/iZEd
         Ox/oHeo1DqdR7O+wQmAswhfbFB60O6oFuSWfy2WQ4ZPgEDmRqHSbBYt5Y9CMmkOEWX6W
         UlOLJuogZvjUgflvN6Te4o2jeSdZok946dSvPbfp62T1RVkafB85yjz5EqFxSxK8GYVn
         4GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766779; x=1694371579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ/W1vAuvct0eQaNfV42dDs6Is2Bz/K+5cHGfVn4Nlg=;
        b=LUgw2O0RAd9mnYNzbI1e5QPfBfE4elH9oKhg08Rz6JkSblnGdEl+L0H82FLlBrpFmk
         k8XiwVquuBARKhuGwf4lIDuVl0OuLlpaQv3CUzDrubAevRhVB/sZZkN3e9XijFM4WW4A
         g4Y2nRaXlozy/tfWSkqBk46xIecQfwo4kUvr4NYRoXlpOSoDzkf8WlbgWlSgWN8aVsJf
         v00eE37mteVaCkTnO3BVrilc1rUJeE75VcMBDjVQqCUvaCWwpNE0gK10BZsr2vdRTAmm
         tWrBC9SCeDxxT4IfQraPlfq6KD3nQKbi7DSV8r9qY+46PChFsNGzaAfTIRD6Lx8xqTyj
         I6fg==
X-Gm-Message-State: AOJu0YwF0ATHOHjIRfI0W2868GJe7MJvbeZbWl11Hy+K0eLP3kpqlmK0
        JYIfihsZp06ZtTDSh8Y7oK0fufNf9v4svQ==
X-Google-Smtp-Source: AGHT+IG0oYogHO+wAh1Qc2b0RpBbRi8d3sGxNY89NwIzDxZvPXy3apKKIsYkF1LHmvM+09NoaEvKYw==
X-Received: by 2002:a05:6e02:184e:b0:34d:ecbb:9cc4 with SMTP id b14-20020a056e02184e00b0034decbb9cc4mr10979635ilv.3.1693766779453;
        Sun, 03 Sep 2023 11:46:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: [PATCH v2 4/6] drm_dbg: add trailing newlines to msgs
Date:   Sun,  3 Sep 2023 12:46:01 -0600
Message-ID: <20230903184607.272198-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903184607.272198-1-jim.cromie@gmail.com>
References: <20230903184607.272198-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

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

