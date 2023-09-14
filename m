Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AF7A0BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbjINR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbjINR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:26:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B38270C;
        Thu, 14 Sep 2023 10:25:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1135248b3a.1;
        Thu, 14 Sep 2023 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694712300; x=1695317100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+79uOjNcwbPpa9/kVCOKluSz7c5JO5jNMvatVqMKNmk=;
        b=le9eYzacaYfaC8ENloAqRPWLaeUZS49RijAY68gSuZVVv+34Vg+A+6uhGmRswDi6xU
         ydMWojRBuRME0iO9UzuznxwV5CwpprXuAZopjehw6MYSJdTvuycoYEWThjOrOBiQTeCU
         64arN+xnRyjrWshoV8Qywwii3X4qu4p7Lhth06U5zp87A6ibcVpllMsZcyI7AprEKp25
         8RfrsmeibiaEVWgQzwahcFGpdJQFik26o41yuNRPX8HyqzLZtlxPYmeiuZVXZZq3j7o1
         qB6IGyZvgSUkmzGLogRALiFIV2hoCKXLnBrDM07YydtCUoiSIX1zUpgoEAQVzQP1Ux84
         rGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712300; x=1695317100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+79uOjNcwbPpa9/kVCOKluSz7c5JO5jNMvatVqMKNmk=;
        b=LnI+UD2Dh22cW4TkY20PJ/pLFR8i4MasWaCxV+zYbz2SX+MxJatP8ysJ6JQaTv/ztm
         Y99E9VTSqSAV410L6oMjsLS0MVtwtWJg+YuE46fJAGhgO1dGPXaIavRtDBt4umdz//NY
         C2ILQXNXXjH6O9iNAC52IYGOOgRzGd5nlj2rmxSwc3GDVG4k3/21cUowyb7r1WWgJ5Ci
         BZayy295yqOsDNDCuVvAh8JD2KQSk7jL4/VNt172KUNGFuxrZiuYUYb8CFsqp/P/Fb6m
         LKvrbG1U1e+/P+RtujN+9X9d2QkkA+i0CMSzAEpQcYqyFHwEfBPFbg8l54eop8zIyzQ/
         ePMQ==
X-Gm-Message-State: AOJu0Yw/XvPKchPAAV8/c5ZeJ1t1RGhqf0gP358+tIfma7gqDD4BdWc5
        X5KkIQKbj4vjQzcUG447xVU=
X-Google-Smtp-Source: AGHT+IE4WagPU98qTyEPXPYSna4/oDNmZGqhDL/qk1IPm23B19BR2S/R2kqj0qHwqaw0dp9Ogt9YEw==
X-Received: by 2002:a05:6a21:998b:b0:13d:df16:cf29 with SMTP id ve11-20020a056a21998b00b0013ddf16cf29mr6980311pzb.15.1694712300117;
        Thu, 14 Sep 2023 10:25:00 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0068aca503b9fsm1587905pfn.114.2023.09.14.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 10:24:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC] drm/msm/rd: Check PT_PTRACED for cmdstream dumping
Date:   Thu, 14 Sep 2023 10:24:53 -0700
Message-ID: <20230914172453.9707-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

So, when you want to get a cmdstream trace of some deqp or piglit test,
but you happen to be running it on the same laptop with full desktop
env, the current dump-everything firehose of `cat $debugfs/dri/n/rd` is
quite a bit too much.  Ptrace seemed kind of a natural way to control
it, ie. either run what you want to trace under gdb or hack in a
ptrace(PTRACE_TRACEME) call.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index a908373cf34b..a105ca1f2102 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -979,7 +979,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	/* The scheduler owns a ref now: */
 	msm_gem_submit_get(submit);
 
-	msm_rd_dump_submit(priv->rd, submit, NULL);
+	if (current->ptrace & PT_PTRACED)
+		msm_rd_dump_submit(priv->rd, submit, NULL);
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
-- 
2.41.0

