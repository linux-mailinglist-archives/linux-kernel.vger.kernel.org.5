Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C67D63BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjJYHor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbjJYHoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:44:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4251709
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084f682d31so39191195e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219315; x=1698824115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fFtoAc6Ru7Qp07nSAhUXpkXw+KE3l91fE8GqLwFTz4=;
        b=jDxgooMvcEW0C5tfdy42KHNCYl1+KuokNMUbB4Ymk+6XxlZteIcjv9JsLBqN/c4aWy
         9RKcrXNkcwOQLvf17aLnGO0jteeJvqwDqLUTfcW2iC6RQ0YI7IkzWQYlguCzEIeGoyBl
         O6+m5sCslIogsXq4YACN47nT7Ah8S7/xCmmWQi7MgoonmFVvV2iHUMyfcoq9vUHOs3D/
         70YH0/A4o8ULiLEMyCAqVGRjPGE3GYXqeM2VVDPotKGB3e0lG1iHjgelsJLTBsysGI6P
         efE4zr3rZoS5k8lKuXQpftgQLppULRhONM+9dEl5oEf55Hkk+d2AiuruRZIkr0oX8Ubu
         atFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219315; x=1698824115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fFtoAc6Ru7Qp07nSAhUXpkXw+KE3l91fE8GqLwFTz4=;
        b=RYoV5Lt3lRPOHSjsBvPOR+LQ0m2OBvF+TTkUvfbR9S3KwPriyxnHUH/swSnRf3URSo
         4w9SC21zsdM4IJ/NrJDdeIwto06B0OyWvyonOujv0xH3gLM8V9+kVvzc/x/59J5AElJ5
         L0zlH35eVgCl1IJKK9n3byL16SBx4QnqN7EAKDQNF9HJKQt5kBrsznxqCQIelORwfAKw
         ugVynz4Qbz6CEAGYMqpTdP93+Lr20O3UgRy8g+5ygEbArweJUkvm5LcpL+bV7OG3CGwQ
         mUrUe/QwN5ybJelqKZesinCM2WbDf8Id06BDE1QhDFL3l6b297I3YVytNStElvRMji44
         +bMQ==
X-Gm-Message-State: AOJu0Yzf1GNICgFuJc4V+49LFLu2nF/zdueOu8ZzzM6lnpevsAbhWpud
        8pnY+T5f7fjV2WwFdF6aIhENHw==
X-Google-Smtp-Source: AGHT+IFOJmsVlBgqDuVM7cZUkC1Qc78O56fKpNAsMjlkaX/ns5d9NTUBTm3yNqsbG9uVrOoj5ZA8bg==
X-Received: by 2002:adf:f346:0:b0:32d:bc6e:7f0d with SMTP id e6-20020adff346000000b0032dbc6e7f0dmr9370311wrp.18.1698219314768;
        Wed, 25 Oct 2023 00:35:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm11449058wrt.39.2023.10.25.00.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:35:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:35:04 +0200
Subject: [PATCH 6/8] drm/msm: mdss: add support for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-mdss-v1-6-bb219b8c7a51@linaro.org>
References: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zrLyLHxFw562jEHuGgaIFKv3/ZZayt+rroyJbKldfGQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUnn+VYAawtEoLBs6jAfc7PeGayc71Cx9fxTW+I
 TrFtRReJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFJwAKCRB33NvayMhJ0U/6D/
 0T4blsbsX4VW4wfXWNRfRmOepPALpcWhL0yGQYy28pnluPYrDJEEQJKAEBotJ5nJzS1qw0OaZ30Cam
 wS0O8MKgSdcN1SlX/8nQhTNHe8fHeDPOAmZ9b63cI3M0je4bgUgj8urwzKDjx/fTecVhI5k8NEgh20
 kR2DsFVSq44pXe8CWwzTxd01ykLxtSPw3ebKjID1yu5JxE0sW2w3I+UeOk1UwibG7PA2svtkTnLvdK
 7s8xSOaCbn+QN5ne0CoK8aDD1bd6D6HyHwHTGsNvOtsTeCjMpAgfZwRyFynqh1TYhmzoiRJccmYKJP
 M6Mk+Cj0qIL9t+ruqiqX54HK8zGH7oRmQObJn7b4BEDXLXI5IAbn68d86AQSBQcxfl6jovpvNqK76w
 6zmR+OAsflGlQ4BubdgD1hdqYaR4B3+2ShXRvdptF5RV7LDvHCvgaLMf4G/74yzfsuhuuOPFpP76X4
 WEHjyC6HGQhsZSA2XzmJQkG/5LERVn9W+SLpYSQpJdqzPE609bRBoHLhneF17H9p3BKCMZgZYO9Prn
 NcE5tIaaK+IozI6Kt0D+SSgejIph/YXzKmirs0FLmy+6zQNJClCES3thCUfxDOOpuYR4soGE3esbOX
 MJFVj8yR3aMbV9C1JJMSk4XorYj3Zkl8N/g9qcf9Iz4VgGLcmao5RBgQ+UJQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mobile Display Subsystem (MDSS) support for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 6865db1e3ce8..33947a2e313c 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -621,6 +621,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },
 	{ .compatible = "qcom,sm8450-mdss", .data = &sm8250_data },
 	{ .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
+	{ .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mdss_dt_match);

-- 
2.34.1

