Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BFB7793D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjHKQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjHKQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:05:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501C10DE;
        Fri, 11 Aug 2023 09:05:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc3d94d40fso18907155ad.3;
        Fri, 11 Aug 2023 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691769911; x=1692374711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZRMmH5v/BxY4ax8oeXvl1jWy77Sd8S2/awGfYcHbs8=;
        b=GJDMPCHFPULCocVk+R3xk7keeGDRvu06pOGCvVMjSbu8Kw9nnq63erYCOvZFYAWPlD
         WNg42PS21/FFwxvdwKtbv5GOf6PXH7K5PS7FyenLew/86kHLK4M28fvXYhzwJJpdHFMn
         S5pvK5VnHIv+96UI2jf8lVuyerbdY5LORdZy+VYqORYkQGJZrHt7thOwwMZWHB+MOmk3
         7kwAW8abFxjMm5qgmiqJmt4YnjHBWUdnYlg8Fdh1tDYIyBZtlRD+CU3mzkg5WGkbwoXC
         9UrH66Da4SlXXwXWOiLAMq+01u34d+mTOWYV97gy+iFWmn9wl8TFyy+BSzY7MIttRAP/
         KGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769911; x=1692374711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZRMmH5v/BxY4ax8oeXvl1jWy77Sd8S2/awGfYcHbs8=;
        b=llSfY3Bqpon78w1CFRbzb37Zvk5UuDGSVzn4MbXsYr/P9S4yzS6IjyuuCusXWuhPZl
         /tOdO7NGcRnqMJAa20F2XSlMQP+a2TpO+l4bmQyhsvGc7BODLlPvoPZlfX9P/2rEBGrU
         7JpoYTECrs+JuHT+5kh2iTBSxjbBvS5SJs9Hz2lUZyLsI2+y3drp1B9HZUdzsZ9phg3+
         thXc2WbQnH8Y3aS4uHdLv6JQJYWM48FPpeBgd2OhJpfLkoPGnrAl9bNCRrgYd9Y7nLvP
         xdCut64Mii0yrtcbjfQeugasjTf98lhHlsraCHPcbZvMdC7CVVsMB0qpo725ONbAzBEz
         OYmA==
X-Gm-Message-State: AOJu0Yyo4dKhDMM5Jmd5YertIgLo/wVzPW8e3W88fuQqStHsuDMyaFZq
        2UqZuM8gnkSSQ0Tok1dmUes=
X-Google-Smtp-Source: AGHT+IGAXs29hkurPfxRsosPHD9dA5tnRT8kdv9dJQhVbh1vnorPPHLqbLtmGuzzWKlU7fmXj1LrnQ==
X-Received: by 2002:a17:902:ecc6:b0:1b8:1335:b775 with SMTP id a6-20020a170902ecc600b001b81335b775mr3280309plh.0.1691769911361;
        Fri, 11 Aug 2023 09:05:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b001bb9d6b1baasm4089085plb.198.2023.08.11.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:05:10 -0700 (PDT)
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
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a690: Switch to a660_gmu.bin
Date:   Fri, 11 Aug 2023 09:05:03 -0700
Message-ID: <20230811160505.174574-1-robdclark@gmail.com>
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

There isn't actually a a690_gmu.bin.  But it appears that the normal
a660_gmu.bin works fine.  Normally all the devices within a sub-
generation (or "family") will use the same fw, and a690 is in the a660
family.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 1ed270dae148..756a9cfe1cbf 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -478,7 +478,7 @@ static const struct adreno_info gpulist[] = {
 		.family = ADRENO_6XX_GEN4,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a690_gmu.bin",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
 		},
 		.gmem = SZ_4M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-- 
2.41.0

