Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616F476DAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHBWZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjHBWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:24:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE723AB7;
        Wed,  2 Aug 2023 15:23:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f38692b3so279949b3a.2;
        Wed, 02 Aug 2023 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691014952; x=1691619752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqGEoOUd/ESEtcnLMxxkmmF+2HvAWe507ZrVsUYfvB8=;
        b=OZEvcpqTsk5jpWwDIykftqID19fsX3SOufb9DrLDherZlc5274MgSh1+i+496ZqGOk
         as+PSGpWPsvqG871b/RM7rD4jvxmwZKWwhV7RlfvcCgmGdaFqBmMfZhCoF2GqLP/J5dA
         eZcseDJH7xny2uktvB80RgF2OrDF3H5u83lgzvFNTRhA7O2vsCGgXzlssljQREN4IqdR
         QVgE01sreLd2x6WM/9Y6AFQq02dDszg9Fmakfae3IXD8Ne9MpHXGGDX2ApX1pukvx/FC
         RKnJJuFTtaJY5MCGXB4LoAqtTti01fCIiLwY2NLeFLlFOQno+1odnaJVBwlVdc5o9IW6
         rjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691014952; x=1691619752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqGEoOUd/ESEtcnLMxxkmmF+2HvAWe507ZrVsUYfvB8=;
        b=Ts/R2hvYAVEkGBf8WNFHkIpSG+8Yw6x/vkgZc7c/hygzSIhTAyKJHsTeFfnNT/aYPH
         WB2667aaTfcB1aq/Q8yFXerOXdw5beEldjFTZ4PyNNnWl9jGlp0a6iAY55lEGX0PMWjv
         T/qA6wx5hWIdjN3t4eodUc4467xvzMhZmGt+UhAaXVUJnvBzW097c3znrUoB2SOMB03q
         jbY0EmsLJCq6HXVL5A15ksFHLaj2DDVWr9LdqFx8bm6niTelyMh6+SFzRC30n24E1aEm
         1Pkv+Bbc7x8r5Jhfj9IopgJkECf1jMR4+UYxbt9R1JOvwEgYQUaDAks5hVGwWarlZmH/
         mBFw==
X-Gm-Message-State: ABy/qLYS1aRl20jG9Ucw6SeMuSwteOc4rYi7brUjrFiuZyCRwGH65Gdn
        H9p34Ld1+7hy6uhAu0VOBIY=
X-Google-Smtp-Source: APBJJlEVl/jx8lxgTCVEF4qXOsOTXbqHOZPKR0q9TTQi6IBaid3v2Q0uzFoeq/tX416LiqSgz/urTg==
X-Received: by 2002:a05:6a00:1887:b0:687:7a30:deb with SMTP id x7-20020a056a00188700b006877a300debmr3224479pfh.15.1691014951825;
        Wed, 02 Aug 2023 15:22:31 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:33de:aac3:fe1d:788])
        by smtp.gmail.com with ESMTPSA id y17-20020a62b511000000b006875df47747sm2379495pfe.154.2023.08.02.15.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:22:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/4] drm/msm: Submit overhead opts
Date:   Wed,  2 Aug 2023 15:21:48 -0700
Message-ID: <20230802222158.11838-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

I recently wrote myself a submitoverhead igt test[1] and spent a bit of
time profiling.  The end result ranges from 1.6x faster for
NO_IMPLICIT_SYNC commits with 100 BOs to 2.5x faster for 1000 BOs.

[1] https://patchwork.freedesktop.org/series/121909/

Rob Clark (4):
  drm/msm: Take lru lock once per job_run
  drm/msm: Use drm_gem_object in submit bos table
  drm/msm: Take lru lock once per submit_pin_objects()
  drm/msm: Remove vma use tracking

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  6 +--
 drivers/gpu/drm/msm/msm_gem.c         | 57 ++++++++++++-----------
 drivers/gpu/drm/msm/msm_gem.h         | 15 ++----
 drivers/gpu/drm/msm/msm_gem_submit.c  | 62 +++++++++++++------------
 drivers/gpu/drm/msm/msm_gem_vma.c     | 67 +--------------------------
 drivers/gpu/drm/msm/msm_gpu.c         | 20 ++++----
 drivers/gpu/drm/msm/msm_rd.c          |  8 ++--
 drivers/gpu/drm/msm/msm_ringbuffer.c  | 10 ++--
 8 files changed, 91 insertions(+), 154 deletions(-)

-- 
2.41.0

