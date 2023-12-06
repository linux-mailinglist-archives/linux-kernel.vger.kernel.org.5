Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2A806F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378259AbjLFMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377841AbjLFMCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:02:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E03181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:02:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b5155e154so74052605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701864130; x=1702468930; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9luEiqd3rNZRXjehlbFdnQ2e1wzzmxPWamwzOSoC4I=;
        b=jYzdGNcdyUC1zTZyUjENMm1D9CEv1oooXRegryqyxYLT6v2+rFO/HoiYPaQF8kWBUc
         9nSCZN2cqkI17HsYsCJUGiVKvZ46sbXo+9oNhgXsJ5y8LVUiUcPqVXnOHlDSdvB+o/SY
         SP2gWuNLiQ0ZEslR9b+0bOYT38N9bVD9lBakC0Cu2UZzxUwMzuL5h3EUd+p4ujpRASOv
         e8s1ZKIIlpNOEhyIONU9dHG4GkAWoJbwRve4zawfOsm/N95U7BxCuEzMpFzZjNErwm4W
         eo1EgMxKGfC5kqdXAUfSxSWlG//0Pl9gGC/+9Suksi0W6vNWVykGGo7kwiH1gFlM55e5
         0z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864130; x=1702468930;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9luEiqd3rNZRXjehlbFdnQ2e1wzzmxPWamwzOSoC4I=;
        b=PG6PX4o2jNgbp5rCEeDgjfh3K4oyMkFsLYBihdBmViHRQT8+9nSDbNzaCeNoaV/VaJ
         1iZ/UEuxmzvn+Yann0dRbC3AiVb64wB5QiAIyyByUz5a93RKqu35P1ItTjPBAoRFNA/7
         VAl2TMkJVBUhk4uYk61VrMqLOVMyNjcs//9Z2IIw/PZcchdHVopiZddWKXiMIOkmojw2
         zdnBxJNOmtHEa454rzcxgAUZIesoelNDOkTR8TUxnRL2/KsKuHQ+TPPdG+Pn4I6l84r2
         ddZnGXb4yqcP1dFonqOZkk8ZuLyFvLPolr5CUs+UnnQQ5BHZlzgDPH7f/Fz85uFjRYmE
         ri8w==
X-Gm-Message-State: AOJu0YwgimUuWPfzEejpajt90sIzHFPik6GGX9wAcjkkgfWM5qIgd3Ok
        6aTRGUBZBGWVqkiaEbdJ+4cpMg==
X-Google-Smtp-Source: AGHT+IFJokEpInd+DiAKxLDKJAGHst4aJ50KC/hLVyMjr37BE7LjVcnWh8PkujsMGpwy/wk3eMm1WA==
X-Received: by 2002:a7b:cd0d:0:b0:40b:5e4a:4072 with SMTP id f13-20020a7bcd0d000000b0040b5e4a4072mr523452wmj.146.1701864129773;
        Wed, 06 Dec 2023 04:02:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b0040b45356b72sm25543935wmo.33.2023.12.06.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:02:09 -0800 (PST)
Date:   Wed, 6 Dec 2023 15:02:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Fix platform_get_irq() check
Message-ID: <c12bb69b-d676-4345-9712-48aab48f2b48@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() function returns negative error codes.  It never
returns zero.  Fix the check accordingly.

Fixes: 82c2a5751227 ("drm/msm/dp: tie dp_display_irq_handler() with dp driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 61b7103498a7..d80cb3d14c6b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1166,9 +1166,9 @@ static int dp_display_request_irq(struct dp_display_private *dp)
 	struct platform_device *pdev = dp->dp_display.pdev;
 
 	dp->irq = platform_get_irq(pdev, 0);
-	if (!dp->irq) {
+	if (dp->irq < 0) {
 		DRM_ERROR("failed to get irq\n");
-		return -EINVAL;
+		return dp->irq;
 	}
 
 	rc = devm_request_irq(&pdev->dev, dp->irq, dp_display_irq_handler,
-- 
2.42.0

