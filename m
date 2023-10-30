Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CD7DB85E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjJ3KhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJ3KhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:37:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB1DF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:36:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd64814fso5949137e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698662210; x=1699267010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQUtMmhP8dK4X8gyF58pOXTNlNmCqs0e9rkXe7+J4ZQ=;
        b=tYMGk+04AsffpInG91hCw7Y/XO8cSr7cA0r30paogsY9GPrxQ0x3YLTDh5/5KmKQlO
         57mkfyLvXFbjsLJaQciUPv2Qh3Pc0X5IbNwZbrGgUMtBUe8Rlj/tL0jH5VcXnDGVbKYU
         f7bCYTzF23wlqcVhIqDjxorUaTjEhwnsqgJ++E422RyXJMtao+U1l8ByeXeAlYa7kVMw
         v/MH3iti99Liq+zp/vJjDqnOcFL+iwSMT3yHcFQF3iTsaUEVG/4GN9WqtANe0tFCB3ws
         XrRh0wWxJdfZhU39H+rVnt03wg8O5GrfNW/OZlim+NExnI2Z11z8yl87JVLqWnN6l7hQ
         Hggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698662210; x=1699267010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQUtMmhP8dK4X8gyF58pOXTNlNmCqs0e9rkXe7+J4ZQ=;
        b=JpCyxA5PiV9D3aHwE7HiWHaePase2ZnQvbU+WHV5rcNgoaQimC4843prw1GhFUHATZ
         1m8vsIkXpbQoS8cUyT+vcu5T+CGMuPAupmxa6GyMN0UfN56jXCJ/fvx4s5AmeMihOyOB
         5H+7KC7dz3ftb96Udh9kvg+yK//QYsp0+H03mJzeDp+NQH/KmcPC2bp9AbLkoEoO4XSa
         bMbLSnkDkXN8GqHmTu54Km7OnW+UG4NTrzi1W2eL9jf7KvPqmQYkzpSyMux9BFmxdGaW
         Wzr+obQr8ZvUvR7FTaUkaKmg7HZ1aKrJx4mvW9h0vK8k1lBNZlKN4xfkOgigR5Xe1U0w
         gt2g==
X-Gm-Message-State: AOJu0YwDubNmA3FKB618oPUC/4VNBonbZaStl7QZ+Lf9SsogD5huT1OO
        CQQ8f4mOF0LpjBTme/rx/yLcdg==
X-Google-Smtp-Source: AGHT+IHfXwpP2Ap37baVspJyHp0mJ1Xts9KTo2NI4MBOzgvTKkzyrjYYn9sVwp8m+CprIkiqj1KTsA==
X-Received: by 2002:a05:6512:1081:b0:500:daf6:3898 with SMTP id j1-20020a056512108100b00500daf63898mr7278395lfg.26.1698662210356;
        Mon, 30 Oct 2023 03:36:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c458500b004060f0a0fd5sm8783209wmo.13.2023.10.30.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:36:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 11:36:28 +0100
Subject: [PATCH v2 6/8] drm/msm: mdss: add support for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-mdss-v2-6-43f1887c82b8@linaro.org>
References: <20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=optkb8hrjPq+qQd/lfPAxbzCpU2oz8b/um1vODBfZNk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP4c4OkV6WLFVMCM8tqrTGgQhQNBWAphAL/cwfIQt
 vYYkR4iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT+HOAAKCRB33NvayMhJ0Sx0EA
 CIp76pTITqgi3wDKcfBUVjawQmBU0/xXhBqhZJ7sAh85xtmsGbq2/gBMTHrZjYbHjWme+yArLaq43j
 t/nDhz8d15VtIrspB+9LCvys5122PjjuX156COziR8hXhf+06N/oyikJ8H91PUu8gyhbaVoNjtjg6/
 L2w5/6Z77s3KZTSea6mWhrtzhu/YpZZTZBxLC/Og/G6jnsDO+3cyrzR1tSIi7j4xGy5A5qa+Eos7jq
 hLKMZJACH0+WWomVmI8K4SWk6zvt1gJWF/WfKmq6/BwSGZkTT3zNbvRB/VH3IIy8j6ZEbt+3ZcJGl9
 s9HXU/R6/tgHxoqNvLqi625JyQblU6TO1TInXRNXzaRPF51OcqC+zIahgmtw33crkyQ45SyVLId/JE
 YjfmHsV1SxDVIhGsEzW5FnRj25u4P88Ig0Jlfc/f4MT4/uLZc9DwMH2eywyFrbpJwiJNs5XbmIn8MK
 J7aeirEe6k0aM6013XgoHMi/HjZXZTI8dnpdrjIf9KHD2r7tx/9ojh/sgEDVf4DKi3DynfPIZhrWww
 0UIPW2gs1s2ApQqZR/PPV1gh/F3bTVUUcqjvyP6bws0ILOLwjFes3mfARC/R5TYK9S8YSaysRPhRIs
 UquLdh5ZrYw/z/JLrihh6nUrj3m+1OGDeplgyvTP2BcTqTlAhxOQVzOXKDSw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mobile Display Subsystem (MDSS) support for the SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

