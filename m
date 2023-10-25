Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209227D6394
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJYHiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjJYHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37723854
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso798445266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219309; x=1698824109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4zOtiipUT8sw701OMgXZHG72ZF/cn8D9ojdqcZ+I6M=;
        b=W9M+tyQRyCC37AFIud/4M80c5fpBYcDp47q1dxaceoX9cl6xjT/Ab3W3w7VRnFY5GE
         EnQad//dZHFEjFIXSqpYYq12ZBh48/WB3WP6NpIaTJyzZXsmTPXGJvJRk7gOTZrcEcss
         8uaIWEL31anPCRjWIc6UVCjDBuI+5otbe23P0NDj+W+v4j0QL2728PepWYB6nY3ktmm/
         uyiXmI/p8c1mCwWLVnoiV+y94N/wXlunyAV5Pbkinjrlh5RB/R1IwGgvbgmsxQ5K2XKK
         wdRo9uiiZb478kVkDGuOEe00ore/0uAIcWsXB04VahKu7TZT46cFTaPT9mUtP6JZWEFO
         rdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219309; x=1698824109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4zOtiipUT8sw701OMgXZHG72ZF/cn8D9ojdqcZ+I6M=;
        b=DboG5m3MAAX26t6gejFhccUO7UhBr11LDWyepMsqFNpNX/OiDNrObpPgPiVe6fXu0j
         /4AMgcaAkNLaGH2H1NvA85rTX/TrpC95QOrjsFpv6GEfDJLUZVUBWoy+jb1MBCyFwCbF
         ChXnCMuRhWvPPpCl3DgaGmDCKxWfPCg+Avs59IcuLRs4ePVM3rzdDEds86GFE3mq7soB
         cdGBvEtbZjf0oGTCAvjjVt4O5iO09YukC8zsAhy8bKKJX1Xxok9i1HW3oWP31r11entS
         OwY17loXejqm9wrEXI8cj/yBJVnuxQzBe9U57aR1hxdbQz9+EKIeaxNyRB9WvhY+R5kD
         v7uw==
X-Gm-Message-State: AOJu0YwjKKM4sQ7dGF0hF3OiFopdPwiuF1Fxt4u9vJmZSzddzz2Ndu5B
        zzNoDRuBQJlSnTT1lARMDsOm/g==
X-Google-Smtp-Source: AGHT+IEWIlRxJHjlqkDhPQzwZYLZEGQw2y+NFgK0dXdjyK25j8sEgY+p48QN/rjnemCH40nSMuXAxw==
X-Received: by 2002:a17:907:940a:b0:9bf:2ddf:1bca with SMTP id dk10-20020a170907940a00b009bf2ddf1bcamr10284265ejc.62.1698219308901;
        Wed, 25 Oct 2023 00:35:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm11449058wrt.39.2023.10.25.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:35:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:35:00 +0200
Subject: [PATCH 2/8] dt-bindings: display: msm-dsi-controller-main:
 document the SM8650 DSI Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-mdss-v1-2-bb219b8c7a51@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RmyjIW0lZguWP9hWwmPF3DabpwwT0EuPrdA5wtaVnxE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUmE/hLSdAHnisyVX6XnsRoZy11MItZW/udDqz5
 NGspU5iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFJgAKCRB33NvayMhJ0T8BD/
 4gJS5f7QwonEjarJZE7rXHRj4qWZe2gJ9BUxjXRBaFYLeFFwEBAtOyOMAiE1dRXilnJj0TUDZcKC3A
 BHhMD5VsCXzEmta/5kPIGS9OZjZvJkdVzPkp8vyiyokQfUiUdv8sjD0NwOVWNTC8xIlCYK7P6pPE+J
 UHY1JOLMIHJierdDgTpHfyM8PSR7rCb1luhfelsmTRIL3BIWULwiTfdvPBNGjluXLOPCizkxqLTWJF
 wk669lsH26PKp8pmWCDHke6OIU//IVF2fy7AwyLJLMNhhIij0w+O2Ry97rDoEcQyOshJNS1C3lvu9j
 WB6iwaBu7RtVOwde9E8BNjBtktEbR5ZTX1kLd6l0Ah/5u+NGOKMCNKmVecubQmnGGuLg+XQk+AKzPq
 7sD8RBXk/CNJGqz0Q8YuQJN2gMP5MxiIZo+kBq20Bo3EHGHSFc97ZcakRDdM0bq4bwQAZdROJrtxvA
 vv//I9Ouq8Xzl4gCBLnKZUYXjS74zdtNRYh+cmwl/NzFuABX5PfioTJFRvb86YkMrCxP74m8lqBz94
 LfL4eMGRk2Hy2l2v13+2J5tKHzOndjb32BTfS3to35Khyt4tpf490OPG877c5TskAPKyiuiN+ueHBf
 u/G9qOnRMDygT+Y0Ltuk/YSvUH68+AoLeHTAfWaD6KQtSu4O4cfaXZSxquZg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DSI Controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index c6dbab65d5f7..24944979d500 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sm8350-dsi-ctrl
               - qcom,sm8450-dsi-ctrl
               - qcom,sm8550-dsi-ctrl
+              - qcom,sm8650-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
       - enum:
           - qcom,dsi-ctrl-6g-qcm2290
@@ -333,6 +334,7 @@ allOf:
               - qcom,sm8350-dsi-ctrl
               - qcom,sm8450-dsi-ctrl
               - qcom,sm8550-dsi-ctrl
+              - qcom,sm8650-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.34.1

