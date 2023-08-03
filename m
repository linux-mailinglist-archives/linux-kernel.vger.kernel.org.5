Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73476F570
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHCWDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjHCWDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:03:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C844214;
        Thu,  3 Aug 2023 15:02:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so977002a12.1;
        Thu, 03 Aug 2023 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100157; x=1691704957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXZWjfN9jRVe+H33im5sYKdcYpl83+nexah9W681kvs=;
        b=Af4HYsP21mKSBHrPbKz2NpveemF6uwBT1sqWwDLsPtvM3YsxUwa5D+L114TsYL9LJF
         qGKv+qE5ecIQtCimduvkKUI6DAwH0wMa7scKIszgw/LUohFbIQuwXJNGIghRVtOM+swX
         edw4kN4ZMGakALGBXyEWOX/uJpyC686aQwCNpXvu2KXbMPHNoCZu2m7qCQEO5KdEk3LH
         iAAXYxNpxcu01fJOZJDMeLSftYmzn92ekYN8aRYg5uaLeOcgXqNWcJ5ttwAudypA7dJI
         RtB8bhKQ+DDQRR2XGbZIrrf1GeGXbIPP9rS4tG9gL9H5b/WVdZ+aIaPWaPxDNl/8xyam
         8Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100157; x=1691704957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXZWjfN9jRVe+H33im5sYKdcYpl83+nexah9W681kvs=;
        b=V0Yc48ZjgkNpOpgMT+LXdC+IWokjVsGCvZ/ET/ccKr+2eSNTcB8Z1aJ+KzCHjq4+dA
         iqYNcAWbBrfO31i1puFGsRAG2JVBmPqJW/FCG6Y0/MV+Fl3E7M94VSpq8HYi/4ckb3no
         ONesWGurXNsSpKBlRzvdFTiVeniIlOHtRFPfY+QuttCELr8OmZdbkVxHwYHdbiSavxIF
         LvBYo2akenHzY6Kd7uDROWcaI3IrvnCYM+t5SyJNdmcn1aww4jHaHxlwU25vxJyua1BP
         buI+Vzlawe/8kWTieqyZmmH/eluLwwUb9PI5g99gU5ct6x5J6o9WzOctTDHSOUcfAJnm
         uHyg==
X-Gm-Message-State: AOJu0YxElFcfdA/4WVY4B51JcIs+/F4G502ErSrrq2Wlh8DQeiqYfDZY
        bQ7iZIWhznxEWEOaQey+00XV9KzPoP0=
X-Google-Smtp-Source: AGHT+IGl2tGbAFvssGQqeZ1wP6XLECY7/4WzZoYSgAMqTT2kydzqs2HGdiQ8789wcCkrTEohoNh2QA==
X-Received: by 2002:a17:90a:764a:b0:263:6e10:7cdd with SMTP id s10-20020a17090a764a00b002636e107cddmr9864pjl.38.1691100157236;
        Thu, 03 Aug 2023 15:02:37 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001b8622c1ad2sm317439plr.130.2023.08.03.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:02:36 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 9/9] drm/msm: Enable fence signalling annotations
Date:   Thu,  3 Aug 2023 15:01:57 -0700
Message-ID: <20230803220202.78036-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803220202.78036-1-robdclark@gmail.com>
References: <20230803220202.78036-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Now that the runpm/qos/interconnect lockdep vs reclaim issues are
solved, we can enable the fence signalling annotations without lockdep
making it's immediate displeasure known.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 7f5e0a961bba..cb9cf41bcb9b 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -97,6 +97,7 @@ struct msm_ringbuffer *msm_ringbuffer_new(struct msm_gpu *gpu, int id,
 	 /* currently managing hangcheck ourselves: */
 	sched_timeout = MAX_SCHEDULE_TIMEOUT;
 
+	ring->sched.fence_signalling = true;
 	ret = drm_sched_init(&ring->sched, &msm_sched_ops,
 			num_hw_submissions, 0, sched_timeout,
 			NULL, NULL, to_msm_bo(ring->bo)->name, gpu->dev->dev);
-- 
2.41.0

