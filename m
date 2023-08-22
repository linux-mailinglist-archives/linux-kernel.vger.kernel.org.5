Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CA784917
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjHVSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHVSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:02:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A91A5;
        Tue, 22 Aug 2023 11:02:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a40d8557eso1809934b3a.1;
        Tue, 22 Aug 2023 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727349; x=1693332149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cv12IOdait6ymjaYszXMAGuiT9Jd+UPhC/JiVaEEqfY=;
        b=fcG17FQQRsQANikmQNoBQ1b7CbblUulB4/6CIZfIMksNwrQGmSCfc0GXvHR7o8+9Dp
         p8jr0/i0v+5w05s6LQ0GWwaeda0mq5QxIikM+xfhTVKS8ai/dTUVUz8Rps0UBH2E7ufe
         EfFVcu+XqMNN97alHgi152v9eAWYG/GGMXe4N6VvZtxxFsbnWBFQb+DsZD+IwsoB+Ha9
         bYmbK1OTUSfbwpB6PsTHPWoeYEwPjA49parPWOAJI4BvKvNdz0Xk0fz+596EGPIcVcVO
         NplcmJdlB/CEzcPqlc/Vmg1/97IXuO1mWmJKpo0Zb5G/KDvcN5Q/1dJ7KW7N46IdQWih
         PmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727349; x=1693332149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cv12IOdait6ymjaYszXMAGuiT9Jd+UPhC/JiVaEEqfY=;
        b=XcteJ6UpYLotwziAntGXo0wtmqg57Ak0S8r/4PmOBZB26AbWQIkDPt/YtuNUF+H/le
         QvY8261hURfvDppWK71b0y4VashrWqU1+OSWigeT52YhOk2hHoRA2uX6CUfeoUmeye24
         o+Py3+gA7Y6sdjWiA7eOnAwBHJUNl3dA5NYmtlshFb9vvqWjPy5LzuMGurSwzrt03KVM
         A7T9debXlt346/mu+4Bk06qL/G8WHpPSyKKOlzPpJCE6vuqbU7YOxtg4zfSx1FMD4P3Z
         kAb8fi3G7R85VeUg/prRxEPpAZJD9OFupCTWJ3yvAaBtpMdWS4YIgwD5SwNXtXqmwUp5
         e7BQ==
X-Gm-Message-State: AOJu0YwrOIqE9GfVDjOQ08Ql5EGIQCBAPJv9V0V5XYhicqA3vKnZlUaF
        BcANq/pDyJb41myfoNYQ/xw=
X-Google-Smtp-Source: AGHT+IHivdlTA5i8F2mOxuTTgQNpG6QN0iSZpJjTDEPGyc+27OY/9g3vLdDskpUqLo68wCNoUTn3kg==
X-Received: by 2002:a05:6a00:17aa:b0:68b:a137:373d with SMTP id s42-20020a056a0017aa00b0068ba137373dmr2036907pfg.17.1692727349165;
        Tue, 22 Aug 2023 11:02:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b0068783a2dfdasm3320769pfn.104.2023.08.22.11.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        Marijn Suijten <marijn.suijten@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH v5 00/11] drm/msm+PM+icc: Make job_run() reclaim-safe
Date:   Tue, 22 Aug 2023 11:01:47 -0700
Message-ID: <20230822180208.95556-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Inspired by https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
it seemed like a good idea to get rid of memory allocation in job_run()
fence signaling path, and use lockdep annotations to yell at us about
anything that could deadlock against shrinker/reclaim.  Anything that
can trigger reclaim, or block on any other thread that has triggered
reclaim, can block the GPU shrinker from releasing memory if it is
waiting the job to complete, causing deadlock.

The first two patches decouple allocation from devfreq->lock, and teach
lockdep that devfreq->lock can be acquired in paths that the shrinker
indirectly depends on.

The next three patches do the same for PM QoS.  And the next two do a
similar thing for interconnect.

And then finally the last two patches enable the lockdep fence-
signalling annotations.


v2: Switch from embedding hw_fence in submit/job object to preallocating
    the hw_fence.  Rework "fenced unpin" locking to drop obj lock from
    fence signaling path (ie. the part that was still WIP in the first
    iteration of the patchset).  Adds the final patch to enable fence
    signaling annotations now that job_run() and job_free() are safe.
    The PM devfreq/QoS and interconnect patches are unchanged.

v3: Mostly unchanged, but series is much smaller now that drm changes
    have landed, mostly consisting of the remaining devfreq/qos/
    interconnect fixes.

v4: Re-work PM / QoS patch based on Rafael's suggestion

v5: Add a couple more drm/msm patches for issues I found as making
    my way to the bottom of the rabbit hole.  In particular, I had
    to move power enable earlier, before enqueing to the scheduler,
    rather than after the scheduler waits for in-fences, which means
    we could be powering up slightly earlier than needed.  If runpm
    had a separate prepare + enable similar to the clk framework, we
    wouldn't need this.

Rob Clark (11):
  PM / devfreq: Drop unneed locking to appease lockdep
  PM / devfreq: Teach lockdep about locking order
  PM / QoS: Fix constraints alloc vs reclaim locking
  PM / QoS: Decouple request alloc from dev_pm_qos_mtx
  PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
  interconnect: Fix locking for runpm vs reclaim
  interconnect: Teach lockdep about icc_bw_lock order
  drm/msm/a6xx: Remove GMU lock from runpm paths
  drm/msm: Move runpm enable in submit path
  drm/sched: Add (optional) fence signaling annotation
  drm/msm: Enable fence signalling annotations

 drivers/base/power/qos.c               | 98 +++++++++++++++++++-------
 drivers/devfreq/devfreq.c              | 52 +++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c  | 15 +---
 drivers/gpu/drm/msm/msm_gem_submit.c   |  2 +
 drivers/gpu/drm/msm/msm_gpu.c          |  2 -
 drivers/gpu/drm/msm/msm_ringbuffer.c   |  1 +
 drivers/gpu/drm/scheduler/sched_main.c |  9 +++
 drivers/interconnect/core.c            | 18 ++++-
 include/drm/gpu_scheduler.h            |  2 +
 9 files changed, 130 insertions(+), 69 deletions(-)

-- 
2.41.0

