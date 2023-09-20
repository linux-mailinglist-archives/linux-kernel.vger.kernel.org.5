Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8847A8F92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjITWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjITWqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:46:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D043DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:46:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a65f9147ccso28369566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695249969; x=1695854769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdSuAkG4VTCtPFnst9Jv9C/wFXy4KDDgAI8d6hl528I=;
        b=zmUHaUEdzDyYlqyrB4Lve7V6uUU52sqFV2Eu67kI3Yw/niDrOviUbZKaghbDLJj01R
         XdRJKss4/gAaumBGg+m9vcAiabkF6OFEzoD93YVLUiDIPNitvnx6GsgPgtbAu+WNN2FV
         vq6Zx/4n0unzW23nG9qTJ4XNiTQG69/cPo2GQHwLGJ+/kbtM0dJ9SdpqkAijamJuA04V
         eKcdvEagDCpsWUy6ny4XzRNoRhAgZcmswmgbuJe+HhPZzYhOK25IYJ2ru847YeUc3A+8
         5O3Yw+XAflTT7srQ57egs+ASPdgLHJbPjdGbx/7Q5+9jQMN8qdxQ05OWvvvzg5/pzesF
         I06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695249969; x=1695854769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdSuAkG4VTCtPFnst9Jv9C/wFXy4KDDgAI8d6hl528I=;
        b=g2dvvFdNVzV6bx7/dD+TF9gImk9NCS/h4yU1nof0N0Wg9yVwib0wXoQ9LBiST10ghA
         A+rlxENtyw9LEu1yvoy2RyfYB7rVViax+Uuwf3u4p6KjwcZwGNv6Pm0Lu5LZRSz87AK7
         eg2FJQrkSzepDOJRmm/qpJH0G3i9O4o3e9V3qRFBZCygLaRsA4pIHlNh/OeEJ0GLfPNo
         Pp5bVesMakEfunSZBH8WeiHI4oTSL6HSBkt0KOgqaZu9H/KNFbDBCkxeAbNU6fmKJ3KK
         s/HdZCt5r4yCAWKKNADHmLg+Yt/tn6rU0zSteEi83m6hZSvhaSoX8ezzE9pnzhDbl2FO
         0j3A==
X-Gm-Message-State: AOJu0YyLmOVmIN0SCIyyl6rQxaEGYcESylM1PcK239GUQF5oCkfP8ONd
        K8r/+1TJy1HtPUYYgjjpIIJQ0w==
X-Google-Smtp-Source: AGHT+IGmn7SRDvmNps2xltWiAV/8ypq3MJY+6zz/ooTGSLT7+Q/E1kHCXDOP6lmDewqMh5Dw1MUueQ==
X-Received: by 2002:a17:907:b609:b0:9ae:61d:4248 with SMTP id vl9-20020a170907b60900b009ae061d4248mr3049732ejc.48.1695249969770;
        Wed, 20 Sep 2023 15:46:09 -0700 (PDT)
Received: from [127.0.1.1] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b00992f309cfe8sm118285ejm.178.2023.09.20.15.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 15:46:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 21 Sep 2023 00:46:07 +0200
Subject: [PATCH 2/3] drm/msm/dpu: Add missing DPU_DSC_OUTPUT_CTRL to SC7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-topic-7280_dpu-v1-2-6912a97183d5@linaro.org>
References: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
In-Reply-To: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPU_DSC_OUTPUT_CTRL should be enabled for all platforms with a CTL
CFG 1.0.0. SC7280 is one of them. Add it.

Fixes: 0d1b10c63346 ("drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index dc3198335164..b6a59d7b94c4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -164,7 +164,7 @@ static const struct dpu_dsc_cfg sc7280_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
 		.base = 0x80000, .len = 0x4,
-		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
+		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN) | BIT(DPU_DSC_OUTPUT_CTRL),
 		.sblk = &dsc_sblk_0,
 	},
 };

-- 
2.39.2

