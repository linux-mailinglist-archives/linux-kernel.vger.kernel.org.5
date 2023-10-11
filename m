Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B387C52C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbjJKL7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346453AbjJKL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:59:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D423A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:59:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3215f19a13aso6620919f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697025577; x=1697630377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsQnCsdEgoRqx/0kV6DCr4RnZmImebMb1AwUAtzJVaY=;
        b=OeMont8ULJbr3/gY6ujbwVF+ZCG71Dol6Fe4lHOC/gF84HjjzhKacCbjyyezynV25+
         NVH5dEuoPIEo8dzBaVfxAwKaa3O/u/2eSaBzOEBeRRgOXIk98Y8FC9z6haPiCSjG09I9
         lDBXMOCcDNSPjmmqGpnnGh9pShUT5m+73xA5vmgNtKkKXxFBcUoFMyZgPiHCiFbRKg59
         4u1w8iqLToI1AqtGP29Wfeii6lr+QMecl+78qxR6Wiw1q6GAVG6UtTrJiu74JvpxwiyB
         5iXs9fwO4ivVd/XV1hwOL2lVf9uZ+W+G9QAvF9fbmTdOMWYUbfVOi7pTlNYClw9UBcfg
         5xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025577; x=1697630377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsQnCsdEgoRqx/0kV6DCr4RnZmImebMb1AwUAtzJVaY=;
        b=mLTanX9rr/V4rCFr4NZ+STVmCrbBD4rx2ypsW0Q16BP7nXrXUB7dTuEulfgt6VKZ6H
         xB5yGRWmOXF5v9tKuvsO7bfHNw8IyxBer9WOHiuzd76PpThGC0oOu4xjrFd6CvUm5Bkw
         mDvO3fD6ovZjTJG0F8kwhlmuY/PJ6EYGPECtzoHQL7dbJlCTfifCAcz+khu/5CPJHTIc
         neludwPx32oeodUL9/U0CKMn5/DxRridIjKKEfAl6pTS53sYbjVB/uSmP0emDWD+fuJq
         H1t4YMbRfZw2kT9isEfHYSBjAhXQWN0ZpC5kjIIyeOGoCOO101VORr1fEwYWDXZE6cx3
         CXtA==
X-Gm-Message-State: AOJu0YzD416EmVacsJXZL9VWGqPltQQa7iAXGOBapbR8MUR51ppgXRLE
        e5wIRhtdq30kAeK+wkU9eIfrFLYdvabxpseQYh+haIg6
X-Google-Smtp-Source: AGHT+IF6yYFwWYKE+4WXsTbKE/HqQQy8ggsl2c0EMYFnIA3PX9VoujmmuKsMLTue2i5CoCcSl4LqbQ==
X-Received: by 2002:a5d:6a07:0:b0:314:350a:6912 with SMTP id m7-20020a5d6a07000000b00314350a6912mr18299418wru.36.1697025577092;
        Wed, 11 Oct 2023 04:59:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b00323293bd023sm15447805wro.6.2023.10.11.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:59:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 11 Oct 2023 13:59:24 +0200
Subject: [PATCH v2 4/5] drm/msm/dpu: sm8550: remove unused VIG and DMA
 clock controls entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-4-b219c945df53@linaro.org>
References: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org>
In-Reply-To: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4052;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/YvnbvtVwdDoYwRn39FhtdoIOp+AWBdN1wWhRK/q9WY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJo4imJZTshJB6ricqOf06LUOTqgSFjTeK40A4OEI
 rvdkUK+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSaOIgAKCRB33NvayMhJ0cLuD/
 0U2JdzIB0K3rExrUslKlMwoHU8JsoaXVoAaSsVxUEL7cSpfkkdhOTc/jYmeQGLUmoBOv5BMcEG+FuK
 96ZY4rCabK2oQBX62N0k+uEqDZsqABOaFKneUtDYIWKXjvd97XvrwPAmdLuRkZnEKJ6yz2zUHPl7LD
 UtTWOsH72Tj/uMaOanirY3soKanJkxvIsSehdCJbg/CKfJhOXa+B+nfYyZ0VVBThKdWciouiCWyMEs
 YRu5O4PW/lb1ckjGE0HRsRkzJ35IQqDyBpQUk5MiFUGExCHG6zHNrIeT3F/VL8qh16dPBmsjeNsxWG
 NhC+PFxp3XmkaKTYYanMZOYUXWbLUqWPIw9dpJGC2t3V+/UPqanwKGIJyhY5s5cu6/bDQdIv/WxsaS
 Pe89AfY3kyGq9A8fZjCes+F3Y203BJTK0FDcN43vLTsknAbh7BNhDY69iMmA1+9hFsuVmtp1xmwK6D
 rMYkEYoqIz9kQv9rhOqInFcYSD0n7Un3QGt8okqHgOIo/kHIkhSQDmOK4C/D8jb3Q1wTrWTH559Mnz
 9YKHBdaEI/stsNT7/3zEZeUI5aaHvauvfwAFhESOvcz34B744qHRCn88MWVna4CFltTMN/v1mledou
 kgPSzlbmJNk0CCsJPqeKwM30vSFLjTiR8a6YZEkl5fQcqSLW+Uk8Z18vynbQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 has the SSPP clk_ctrl in the SSPP registers, remove the
duplicate clock controls from the MDP top.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index 7bed819dfc39..4590a01c1252 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -24,16 +24,6 @@ static const struct dpu_mdp_cfg sm8550_mdp = {
 	.base = 0, .len = 0x494,
 	.features = BIT(DPU_MDP_PERIPH_0_REMOVED),
 	.clk_ctrls = {
-		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x4330, .bit_off = 0 },
-		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x6330, .bit_off = 0 },
-		[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x8330, .bit_off = 0 },
-		[DPU_CLK_CTRL_VIG3] = { .reg_off = 0xa330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x24330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x26330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x28330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2a330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA4] = { .reg_off = 0x2c330, .bit_off = 0 },
-		[DPU_CLK_CTRL_DMA5] = { .reg_off = 0x2e330, .bit_off = 0 },
 		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
 	},
 };
@@ -81,7 +71,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_0,
 		.xin_id = 0,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG0,
 	}, {
 		.name = "sspp_1", .id = SSPP_VIG1,
 		.base = 0x6000, .len = 0x344,
@@ -89,7 +78,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_1,
 		.xin_id = 4,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG1,
 	}, {
 		.name = "sspp_2", .id = SSPP_VIG2,
 		.base = 0x8000, .len = 0x344,
@@ -97,7 +85,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_2,
 		.xin_id = 8,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG2,
 	}, {
 		.name = "sspp_3", .id = SSPP_VIG3,
 		.base = 0xa000, .len = 0x344,
@@ -105,7 +92,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_vig_sblk_3,
 		.xin_id = 12,
 		.type = SSPP_TYPE_VIG,
-		.clk_ctrl = DPU_CLK_CTRL_VIG3,
 	}, {
 		.name = "sspp_8", .id = SSPP_DMA0,
 		.base = 0x24000, .len = 0x344,
@@ -113,7 +99,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_0,
 		.xin_id = 1,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA0,
 	}, {
 		.name = "sspp_9", .id = SSPP_DMA1,
 		.base = 0x26000, .len = 0x344,
@@ -121,7 +106,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_1,
 		.xin_id = 5,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA1,
 	}, {
 		.name = "sspp_10", .id = SSPP_DMA2,
 		.base = 0x28000, .len = 0x344,
@@ -129,7 +113,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_2,
 		.xin_id = 9,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA2,
 	}, {
 		.name = "sspp_11", .id = SSPP_DMA3,
 		.base = 0x2a000, .len = 0x344,
@@ -137,7 +120,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sdm845_dma_sblk_3,
 		.xin_id = 13,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA3,
 	}, {
 		.name = "sspp_12", .id = SSPP_DMA4,
 		.base = 0x2c000, .len = 0x344,
@@ -145,7 +127,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_dma_sblk_4,
 		.xin_id = 14,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA4,
 	}, {
 		.name = "sspp_13", .id = SSPP_DMA5,
 		.base = 0x2e000, .len = 0x344,
@@ -153,7 +134,6 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
 		.sblk = &sm8550_dma_sblk_5,
 		.xin_id = 15,
 		.type = SSPP_TYPE_DMA,
-		.clk_ctrl = DPU_CLK_CTRL_DMA5,
 	},
 };
 

-- 
2.34.1

