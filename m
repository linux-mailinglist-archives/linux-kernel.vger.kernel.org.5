Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE576DA74
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHBWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjHBWK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:10:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7928B1;
        Wed,  2 Aug 2023 15:10:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so216987b3a.1;
        Wed, 02 Aug 2023 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691014256; x=1691619056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS7jKywCwzPEYTek2DVZfa+QW/jrs4EVMkt69yjjB4g=;
        b=DM5GmrSrp7pkb96vFp0am+4e0FOtX8mlij/Tn+iVrr8Ot2sIwBau8udRx3G/H77fGB
         xuqQ6Zg/gZv/DNaq+ZWWWPcR2KmOVYyev64d3HQV6c+LGsiKZruxPXKKGaPr8nmLuztM
         mGseP5Re6VhyufBN1pVpf/Dca5YRxjO3wnkSlvveH72a86YvDYY4f+fuePY3H1tvnPBz
         FzSyXTfclNUFncdAMwlPtT/+gJqZn2M6VYbuOODH5jS8bLjv0WFcA6p2GAX/g2Wq+Xs3
         kkB7H7BOxODlq5DMtwOlNB4uNVFSbAA7I/dDzpYXI50vm3g/Coxii9wJe0prkhOh1td6
         ggsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691014256; x=1691619056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZS7jKywCwzPEYTek2DVZfa+QW/jrs4EVMkt69yjjB4g=;
        b=NQ1KHnfa46hZEiIRdOE7LAlU+KAG9iWuFlhNN25pZvsL7eGMnPMNSKNxXOlaAR67YY
         0mbdlpnmIfyNB3X3xKQNycHWmkYrbpT418I4l/ju5tMqwjWGH39DBCJy8/DAV1QG60XR
         uKxjPKvf6tzYl1EmqMbz5qwVFdRm/hw62OoyHiXcVFH91zD72NppszBwN0B519ICNUn8
         R8Y8+VTUAx2ASvS/R0D434lt9AjbD0PoIdqBU7NWfi2XbxERuZsTnvuKkX5Gdre//z/3
         88W2gbGuDU3zzejaTFuOaU/NqU22QnmBF4KnAyZ0tgggydqjeDwM9j/E3bdX2O1lOewK
         0IrQ==
X-Gm-Message-State: ABy/qLbmBgrggVjBgpWndQZlU8ChbzYv9BTDO8ixevbGt1l/AHeLHuL+
        +j9NpzqavygsRrr0HF6tOT5nSAchwwg=
X-Google-Smtp-Source: APBJJlFEQNzOIOSaw5Pe1VIp3Muf2+ySX824Yhcd2Q2fgmtJ9+vtqc93rg73zYoliwszPRCir3NZjw==
X-Received: by 2002:a05:6a00:847:b0:67a:52a7:b278 with SMTP id q7-20020a056a00084700b0067a52a7b278mr22331335pfk.9.1691014255942;
        Wed, 02 Aug 2023 15:10:55 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:33de:aac3:fe1d:788])
        by smtp.gmail.com with ESMTPSA id ey2-20020a056a0038c200b006829969e3b0sm11460134pfb.85.2023.08.02.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:10:55 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC] drm/msm: Disallow relocs on a6xx+
Date:   Wed,  2 Aug 2023 15:10:44 -0700
Message-ID: <20230802221047.9944-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Mesa stopped using these pretty early in a6xx bringup.  Take advantage
of this to disallow some legacy UABI.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
So, it was late 2018 when mesa stopped using relocs.  At that point a6xx
support was still in a pretty early state.  I guess you _could_ use such
an old version of mesa with a6xx hw.. but you really shouldn't.

 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 ++
 drivers/gpu/drm/msm/msm_gem_submit.c    | 10 ++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index ba35c2a87021..695cce82d914 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1078,6 +1078,8 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu->info = config->info;
 	adreno_gpu->chip_id = config->chip_id;
 
+	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
+
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
 	    adreno_gpu->info->family < ADRENO_6XX_GEN1) {
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 63c96416e183..3b908f9f5493 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -882,6 +882,16 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		if (submit->valid)
 			continue;
 
+		if (!gpu->allow_relocs) {
+			if (submit->cmd[i].nr_relocs) {
+				DRM_ERROR("relocs not allowed\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
+			continue;
+		}
+
 		ret = submit_reloc(submit, msm_obj, submit->cmd[i].offset * 4,
 				submit->cmd[i].nr_relocs, submit->cmd[i].relocs);
 		if (ret)
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 7a4fa1b8655b..4252e3839fbc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -285,6 +285,15 @@ struct msm_gpu {
 	/* True if the hardware supports expanded apriv (a650 and newer) */
 	bool hw_apriv;
 
+	/**
+	 * @allow_relocs: allow relocs in SUBMIT ioctl
+	 *
+	 * Mesa won't use relocs for driver version 1.4.0 and later.  This
+	 * switch-over happened early enough in mesa a6xx bringup that we
+	 * can disallow relocs for a6xx and newer.
+	 */
+	bool allow_relocs;
+
 	struct thermal_cooling_device *cooling;
 };
 
-- 
2.41.0

