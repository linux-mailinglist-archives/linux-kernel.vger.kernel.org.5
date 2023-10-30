Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7CD7DB83E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjJ3Kgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjJ3Kgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:36:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC941B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:36:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd19eac8so6200215e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698662204; x=1699267004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4+eh4kuDYlM+0XoOFl1j21GXPiGzFQcZ1jyrcn8Ob0=;
        b=u/fEPZXV9eyvLZ9iB6nTekew23qDT/qQNTEfN0OlLceiONqZNrmS4d3dKWn2bfVoxx
         Wb0xKOTtUaqoHDYK0K+I+Y6Qb2oioEeOQ8xREb/Pa0Kbx/DJ8Zf03IihPEHzq076GdiN
         edMrok4bjLsVBJYDTn/iwlgyeiuyCh/Hhv42shjlB9Z5wdQma9fslCwkr0iXqG85jbKc
         AWY6erqRoofgXssD5Hjz3g1YyuoNJMFOAEE8lECAeAReMI1ztd6Am9d3qp2oM5fngmn+
         JLG0+cq4jymxHsyKiOi5B+wzRbaUuFcXL1pnRWn0HZCJtQgzLgkd1nlTO8MbewsM7J1g
         IfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698662204; x=1699267004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4+eh4kuDYlM+0XoOFl1j21GXPiGzFQcZ1jyrcn8Ob0=;
        b=avHk37yPscSHkBGw0N3K+oiVUZRR6saPYsAjWiuKaW9NXMlRjaTsPDwABibpzhEiZb
         jABGI/NwTJhuCmTMMM8I5/g3BAM7NHZ1BJWHkywlYyo0Hq6ahWN7xPPUzqr+MyPXeZjw
         AJFBpJnBz9/pfWfR4T+jETLxZ3VEoYV/QJo+aRzgrw2KQbiITVCR6kpJszVf6fIFFoxK
         WS7REuRTmO6tFLrNOi3JZpmfSkXwqTpkv9k1UQb3ZVWi5HsPwLGfacdaegc1sZJcAynz
         avtMgYSLhseMqRbzCftnRn/Wme4EaZRE+UpXP6uo99oCw7KaDZd8EeuLB1oxR4GgjBzI
         Dv9A==
X-Gm-Message-State: AOJu0YxM0KZESGEGwMN7XbB/K6K2TED8+gHsJrkeKFfBrJmnPvpVeG5E
        s/lCntUU8qdHIT8H1mRklbcVcQ==
X-Google-Smtp-Source: AGHT+IEGVqS4uBQs7Hw9muJEQ3nUCcWEPHRVACdpa5VFhl/0qtWKcas+HfqqFi17wdBt63lJA02IpQ==
X-Received: by 2002:a05:6512:1323:b0:500:c292:e44e with SMTP id x35-20020a056512132300b00500c292e44emr1937739lfu.54.1698662204156;
        Mon, 30 Oct 2023 03:36:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c458500b004060f0a0fd5sm8783209wmo.13.2023.10.30.03.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:36:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 11:36:23 +0100
Subject: [PATCH v2 1/8] dt-bindings: display: msm-dsi-phy-7nm: document the
 SM8650 DSI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-mdss-v2-1-43f1887c82b8@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OnxXDntwlDGC0O778vMV/1raM0wE4XEonnITvW0QgTg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP4c2aGxS0U5Ah+TIDzr6R44jBG5iqvXQWoDEG8RF
 ie8kz06JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT+HNgAKCRB33NvayMhJ0Y84D/
 wOLJD1bdmKRgnGkL1btpWYk2/qN2eino/ju7Djdxyil88vqlZ/C/EVo6DzR+Zofdbrdge2PJN0J8I+
 STBVVgTJjC6CSTb3Br2t67OdW0OOkzV4uFusPMtvFR09u4Ra6C2S5F6qNBk9TOpR2Z7o6fTu3wuflp
 Vb9+MC9fPJCn6fjDtXCq6A702uGswZZMhYHatu7Wwz3TjS3MkcllTBs6SUL+Nzv6kjQX6N2bhReQ1h
 JT3yyLDi/jugzzTUQDsilTS1UXusAw1NbHhM+C66e9BwqezEbwTpqhjtOfMIGlJEt4mvHIdrcFi7Em
 DUPUGXvf+Y1+BsgJh7q9Lk9BOJ19wKA5+PrW85Ep9SZWAOWQgIrtjHEvneKVa1w6TUsa5x1tVuKNZO
 h2VWFvKWnUdJjInhMkBrGmTNIs06s2u0NhtYRZYDz3Tgl62qws/nLq8kf3VX/AdfPhZKaaRxE0j75O
 hECfLfa3ByxasP4Bl1oAp+PSFW65XjwAa0oOfGHko1vDCZNL/C0nxEhqa1SZGYySiiQuhoWG/Dia7R
 k/cwahyL5audoDI8msJ+PDytTFa78lo+KNs2rBLtZRBZcwlAqn00gvei/KMY5Jw0ghHTwTgi528jVZ
 GgxbrH8q0fJF5yBypUQoyHIdBre/pqv958DDwfbT2xdkJ70HwFHiIkn9RXwg==
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

Document the DSI PHY on the SM8650 Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index dd6619555a12..7e764eac3ef3 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -22,6 +22,7 @@ properties:
       - qcom,sm8350-dsi-phy-5nm
       - qcom,sm8450-dsi-phy-5nm
       - qcom,sm8550-dsi-phy-4nm
+      - qcom,sm8650-dsi-phy-4nm
 
   reg:
     items:

-- 
2.34.1

