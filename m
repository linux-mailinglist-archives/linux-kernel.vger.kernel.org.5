Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5321C784932
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHVSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHVSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:03:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BB1BE1;
        Tue, 22 Aug 2023 11:02:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bba48b0bd2so31271745ad.3;
        Tue, 22 Aug 2023 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727375; x=1693332175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXZWjfN9jRVe+H33im5sYKdcYpl83+nexah9W681kvs=;
        b=iRhw1Gog6JsojSSHyFFVyXAMLHYDTYhX+sAAqKioKTACGpypHKa/Oenkr89YVegc0Z
         q4trCT8yVEIttQAHR25p7YaDWoHPJ+xIHbeKmYQORBeX9Ve+0uHn1yFEWjH68vlsPUWL
         6ChUtp/1sBn9Jxnj+Sr21xNtiJLlGkApDekAid4/9BXR56psEfnPVLA/YVqsMZW6tFhc
         j6bv8W9wfZIgW3JJ6AVCo7kKXo8Sd3WWO4ZPyzCDlxrfUDx5lm21hKrAEidnhtYbZ0vR
         BcS/PaAFUYJmuew/SDIc+89u+bwRYSxQgDcpea3mSQpPbF0VpMf2zWeJwNgscSSsx0Wi
         GURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727375; x=1693332175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXZWjfN9jRVe+H33im5sYKdcYpl83+nexah9W681kvs=;
        b=jmwpI3jt+pRpaxRwLW6ff/iy2gHb6/0Z/jrQif81a2GaecmbKzhKFb2Zrj0QwNWpWh
         QK/ysAu/pY9C8EupufYNazV6umRm9VFPTvXb1Vb2HAKookz+f81zu8snYgrSqWTlJJrz
         G0ruv1U/cDQNqRvFBiulO3tsq/Kl8sdpEtcw3Jplqtnf+s6ymKmH3KQThc8iv4cG+YSI
         USxKyzKDQDH8PFz8TCHCBQ0l140VS+rWHfwEzr9COwIDCD6jB7CUcZDREmV951xRUu/V
         QJ3fUXI0oHUQDSf5ZkDQ5s7H7BmMB3kMYYnxitX/dR/o77lDQJlRl7qKOHPYxlRJkJam
         KjMA==
X-Gm-Message-State: AOJu0Yzwma2x8jfe0GT2teZ75K0OzKbrlW6dviEzNaWhKHwEC5hf7an0
        tUjLXffHJsBmLyBchs8iFYE=
X-Google-Smtp-Source: AGHT+IGaL6Rsdsko07MG0eHSn51o3kJqFWl1JNQj/3jMWXPTkNXbj6c8kBm6TpsIhDJNhUoYW4zLeg==
X-Received: by 2002:a17:903:32ca:b0:1bb:5b88:73da with SMTP id i10-20020a17090332ca00b001bb5b8873damr9278187plr.61.1692727374873;
        Tue, 22 Aug 2023 11:02:54 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001b53953f306sm9351280plb.178.2023.08.22.11.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:54 -0700 (PDT)
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
Subject: [PATCH v5 11/11] drm/msm: Enable fence signalling annotations
Date:   Tue, 22 Aug 2023 11:01:58 -0700
Message-ID: <20230822180208.95556-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822180208.95556-1-robdclark@gmail.com>
References: <20230822180208.95556-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

