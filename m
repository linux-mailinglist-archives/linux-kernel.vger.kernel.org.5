Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C997A8F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjITWqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:46:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFEDCC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:46:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-532e6f8125cso261331a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695249968; x=1695854768; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYdcY0DcGe67NgqwyBu5FTTz8YAdNQwb3MR5ZbpO8t0=;
        b=EeUj2hO2ciolB2ZVQ+gPSCFL6bMzRgtnUFwYXvGX7y7sT5m/GNDPFx5CuqSjkKrIhL
         Jv6fuPaz/zPhMu4UoFT3gkTHwiNQaX/e3d6aMHFwi1SiNBbXjKss5MEMqmdBkRgY+Lpv
         eevm2EIYIh1eu8ryy0mJ9W0nGHtomat0BUllJAyoz85Ny6liuQu1hvVaGNftTXJRkWf+
         IeDAdwtYijXjk+luq7VkNAHC+NoLH6jv/xqb8czbLlm04oPywfujKzP6UVeS8RPs3mMy
         hfPcvy1Ja3urpB9uDobfh8nHnAH9vEPeXKMdYnWUtSijQ7I4lYgRDZZLXGMs71akWRZr
         p8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695249968; x=1695854768;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYdcY0DcGe67NgqwyBu5FTTz8YAdNQwb3MR5ZbpO8t0=;
        b=BoQvu1hmUSjHUBo0bz+w/sSHnZc+GYA2tAijKaRvk1WYiWdHJgZKfOxlr+/qSMPy3u
         ob33YJ37iiGQVQ0maIRPYcpImAgwTgV2uOOJ+wNZ99QulrqOD2FMnv1Ck/c5qgvVtwgX
         FYjMLyXcrQQygmMA/mHcBEPQP+YMXWFmTYh1rFA9czZ4G53cktPlunsz55GAhLX5NYOM
         9REoWB/TJMfY0f2iFY88uTSdwhL0FVDzGRCJ3mb3AZbRKJuD07FmdkEbjfDiP+x4kwoT
         RPRJ73ykbWeDsPVrmOEKjk+IX2+QyCLRRITnQPTkCMbPEz0uOzCmhgCoR37yBkrrUptb
         HgZQ==
X-Gm-Message-State: AOJu0YzK7oAWlthQ4ne3CuxHcJk1H/RasyIN3spFw9mdVgdCSG+tnVqf
        Q/yWUJlPpiOUYi4IWuHvPQgy8g==
X-Google-Smtp-Source: AGHT+IFa3rKPBGbMiv5r+wZtefSamWAegDbMuYEFn/StayXODb0Qn9SHx1kh5ZK8H8oo42epAKi5/w==
X-Received: by 2002:a17:906:209a:b0:9a5:da6c:6539 with SMTP id 26-20020a170906209a00b009a5da6c6539mr3585083ejq.75.1695249968267;
        Wed, 20 Sep 2023 15:46:08 -0700 (PDT)
Received: from [127.0.1.1] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b00992f309cfe8sm118285ejm.178.2023.09.20.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 15:46:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] SC7280 DPU fixups
Date:   Thu, 21 Sep 2023 00:46:05 +0200
Message-Id: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC12C2UC/x3MTQqAIBBA4avErBNsoh+7SkSITjUbE60IxLsnL
 b/FewkiBaYIU5Ug0MORT1fQ1BWYQ7udBNtiQImtVCjFdXo2YsBRrtbfolMalSFrdE9QIh9o4/c
 fzkvOH7K9vZJgAAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found a couple mistakes, this series attempts to fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      drm/msm/dpu: Fix SC7280 PP length
      drm/msm/dpu: Add missing DPU_DSC_OUTPUT_CTRL to SC7280
      drm/msm/dpu: Fix SC7280 DSC block length

 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 926f75c8a5ab70567eb4c2d82fbc96963313e564
change-id: 20230920-topic-7280_dpu-59a29cedca6e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

