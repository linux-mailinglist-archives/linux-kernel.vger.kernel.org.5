Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB178A70A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjH1IF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjH1IF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:05:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F09194
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2623053f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693209918; x=1693814718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7pEehOps5QbkVKkyuuv31XzsIbizKaBqk17S7JImMg=;
        b=BtsktCcnkMkvhD6e5FGtzvV28au/oJFeaFSq8IPPBo36QOFyCR2gkMRpkKSZCF+uPx
         1h89AAjoBxxe7ZgSY8qaLtm86AcPnbT05tmI8JKt6hwkKa/zLO2XFfQCklOtLHZzgbZa
         492PLJBUyCYzPkNXvvkunEH6OEOpI5gG3pVlQNuRNiX4kdYLt1ldBkdSRTZj49dPRqJm
         +YrZRVWIr9y7ghmQDMlMS5+k4j+r9UDegzg6jXKcnMxbrKTQGEl8pec7IBNDr3Ot8mLs
         VGLAtdK7L+6IHtBD0LXrA229VeEVKq/DGt8d+TKuM4LzdcY5UIOaKl4PKpCTrUyDewkh
         kXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209918; x=1693814718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7pEehOps5QbkVKkyuuv31XzsIbizKaBqk17S7JImMg=;
        b=kA0RsUHuzRxQee9hqQHhWEZ1u6qnLvliGkh14Rjb/rkILF50KocUtxjEWtXZHjppzg
         FNh1OCCV1PBbbvEOf8F5dnWiDX+REsyMFRXimY1aDy2HySJ/5+MQN3YCidY81n6I5ZJD
         rGtOtwrHa7ojJVkD9CTcbI/NK7ZLHBAvYAinJ1HacB88tUlBKY5zCtnqoOPemWwqJ/2I
         zhco3P4nXrljCp3DmnzDh/POQGt9XfJ+BnQYgWXJWNIhdsF0qk7836WgpFL05VVa7KzV
         zaXcq1RZT/myeBHotB+ScwHOhrpr986nUJmYaMPNNQYanhc/h9qYbHTQ9Kc9pY7jLgD/
         ejxg==
X-Gm-Message-State: AOJu0YwMQdGGUQybniVbm0RfEJAmBhiUR2GFruu1tkIQPcANO9qxEdEs
        N/ay5UUwNjPrqXGcFonXD3yYCg==
X-Google-Smtp-Source: AGHT+IGtcWa0vdfJlQAVlrZJH5+xzDeO/CXZcAHamsTvYSCjmn3m3vGPWKyG271PhNMxJnWpMeZeNw==
X-Received: by 2002:a5d:510e:0:b0:31c:5c77:48ec with SMTP id s14-20020a5d510e000000b0031c5c7748ecmr13590179wrt.62.1693209918679;
        Mon, 28 Aug 2023 01:05:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003fa96fe2bd9sm13067035wmf.22.2023.08.28.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:05:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 28 Aug 2023 10:04:39 +0200
Subject: [PATCH v3 4/6] dt-bindings: crypto: qcom,prng: document SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-topic-sm8550-rng-v3-4-7a0678ca7988@linaro.org>
References: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
In-Reply-To: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=929;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BGnfWkUzwQH2a4KJs8LRMIJys6CcDcyVifGwYt3sjFA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk7FU4LMc9R86qxMjqtSQHBNkBIKyi3eHZH2WQ4mZO
 8ofc1GqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOxVOAAKCRB33NvayMhJ0X/oD/
 9NshRyEi1JWBG8NE9uX7z98tAzWOX69s7cfaSu6pfZTTYR1EffXqWHkdY5HIYwwOknt1WHbbSwkXNU
 8do+97PhKLS+I+PTQuZCsB7OUz4qZBP8EPNc9ydHbzup9+i/gLirvOL6q41nm1pB5ftWvWA0RgSM32
 E1OS1+mHCWysGti/P2B5ri1woMKEiNLuKtgDRdiKhUgwiL5HCPHff/grwK8cec7HEumvfyDJ0R7wfS
 JRFXmfg5oC6i0nA+jacBQbpwBua1YfXFxeZvylfmnqkavfsUijc8fYnGVSMP49/kimLiHIhydc59nu
 W5XwRppdppsgLg9fjChWVYFgTVeTr+l+kX4pTSgZ1yrmVs1uDqaSvUXcbU5Zs+nxaE9/w5Hw8tNOjh
 wb9mI29SJeyrPmS11kXYt3RjhpgEZAD10td0tKDP4UKxuR7RRbDgmi2uefHMan3OC+MVXMAAYdmPrS
 JbQHBtkA51WZ7K0z/KXiNjly//jBG9p5Kv20T3XzVZbpxTUY33RlMN6iTkOs70eFAJfShM2jnEwUSv
 8alAGNlefy+4scVSnVLwvOrofMvlC/yizQlsCKPqLoY78vte8TNOVdSDhYYeK+RTx3L8HcrP5AkfkO
 ErlTxfBLSsdjGH1Mp2FXszoVswIQ9seqOIxxmrpZyF7xKRVhDiuO6rM0vafg==
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

Document SM8550 compatible for the True Random Number Generator.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 4245c9e424a3..633993f801c6 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -16,7 +16,9 @@ properties:
           - qcom,prng  # 8916 etc.
           - qcom,prng-ee  # 8996 and later using EE
       - items:
-          - const: qcom,sm8450-trng
+          - enum:
+              - qcom,sm8450-trng
+              - qcom,sm8550-trng
           - const: qcom,trng
 
   reg:

-- 
2.34.1

