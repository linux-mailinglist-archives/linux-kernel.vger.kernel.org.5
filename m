Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBED7D6497
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjJYIKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjJYH6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:58:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742961FCA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a0907896so7963371e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698220069; x=1698824869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxyI9U3WR02fQeUKBIyEzZWTap999iKoTwOR3ADXuho=;
        b=WWbb09Q8UisS9hAEN0owiET1KjkpUkPEeQr84jb7kmWi8bOUtyutXEg+iSCYhG4bdb
         kQJymOiDT13075LcKR5Pj7EH9klVk5Bs2BNXiS9+KJMjMzKh9dGfv+jWXtaIePhlK5pA
         U+ZV2uy4/NlwEeNi1yeak6YSAbgc/6ieeBhQViaz9Mp9bEbPGvr/FEFpmNwx8vg+AcZD
         0fKwy+2UAjAolh+Is1mDDidW+gxRv25lwLgu69QFBP3flkqCnBKpmqfpuMDDYDqGv082
         NGMHC9vnrUwGNLEy7nswSgy0bD0sx46MIxayKeYcVSbV91wXFracWrcD7a1YWq9tvL3I
         FqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220069; x=1698824869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxyI9U3WR02fQeUKBIyEzZWTap999iKoTwOR3ADXuho=;
        b=wHDgruOsS/MJOsowAPbDhCkNS6i504xwhH/P1/wPPOBXZoCjLGgFhlqs2HMXZeQJoC
         fePV8aJmQkCmB7veqX+sk9p3JfsT7PP9h/NNxPlp0zDc16nz8L9KsYiUj79Sat5HevhU
         ZK+aCC1hPAf/WcFEpDmaqFIX7sPOu3YeyGMEN+H65cWBSLFDdFUVrkfB3K+Tdm9I9TQi
         C9aKUJQHu0KyiU5rutpm6Vc28NDCImxm9mnvARNKXWQ3OnLact5gOypfHoqIYRBWGRE/
         SN7P9ojpTMt1aB7HReulS2Pc1ItVHtPfF6MEVxUuSPTBx+MkSnLwBrxa5lhvifKyuspQ
         R8bg==
X-Gm-Message-State: AOJu0Yy6j9oQuuV1jyHlJ7Kedh0crXn9+l3S79KjWiIteJ89W597iSay
        IDvcbPp4LqfG1sEJFpBNj9OXSg==
X-Google-Smtp-Source: AGHT+IHyFi7r1LDPib8SpYfKruYp8nfnVQkvS1q2zjYbJGWKBVH79lsgOREFjdZuA7yCRj1aYZiDfA==
X-Received: by 2002:a05:6512:48d6:b0:500:7c51:4684 with SMTP id er22-20020a05651248d600b005007c514684mr9684535lfb.56.1698220068657;
        Wed, 25 Oct 2023 00:47:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b004053a6b8c41sm13900970wmq.12.2023.10.25.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:47:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:47:41 +0200
Subject: [PATCH RFC 1/8] dt-bindings: arm: qcom: document SM8650 and the
 reference boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-dt-v1-1-a821712af62f@linaro.org>
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=K8r8UVBd7sE1H7blMVAT4uM/6tI0fE/WKgrcPwIcvvQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMgfrmP/8wDsehZGgruxBV7jrneXTSmT7kCmqqz+
 7lPFGT+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjIHwAKCRB33NvayMhJ0TfJEA
 C53cTi3ZA5edaEiQ0Y1TKP7KMPdb3NJ/qWkZYD5WZ0O6RV99evpv70OfOyQQUK2zT2kiwUvdT20tEj
 aDF+S+1OaeXMOL+hWJAajjVIDNOml2q89qhnkfuDlrqh/wNvqlMG3qfUGNqnDdikOIls3kloRPqUcB
 ygqdCyvUCNoVzmVeVotUN1qWuPJI2Opy2YeO8sEdZqZ683/S1hl1En5+JB6aMY4xIgD8qgSUMsVy3Z
 QFFJhhnwX6rDnL/T26oYHFG4RFvzmPJwGqE1Dt2qYmQpZ89VcDKIoPBV30w+xWNy6xPo6qvxc6rFKL
 Hxq5NMLvgWxoZGRde6UwpidX5vlvAVIeasQ6TQftOitXH/7MXni652MRpJOwMGF6Jf+/V7Wxt1+bg4
 DE7BPsacrvQk7TwQRnCtO3z4efHuK67dd1YC2JXCsWuNcRq4xBTi9GoGNnpiSfi3rNLAXdmoIFgd4l
 ELiQFSdlf+Ljtid2qWmRKgQvNeegjWiCCi2GN8x0hIVJK/2ZQCK/gtMMGddRjgEWeooxaYdhV1YxmV
 1zf98jHEvw6M5XLJDhOcu57aHt9x411+XxRb9C4J9qDZfWuP7H3kVKfPvV6HQ8SZWj29EaMVL9ZTcu
 +KBS2W2H+nF6t6NaAheMhhxzCJbkx1bxqhoiHn037PrBR/GxbMrUjRUpM2Ig==
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

Document the SM8650 SoC and based MTP (Mobile Test Platforms) and QRD
(Qualcomm Reference Device) boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..c5b6518973d8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -87,6 +87,7 @@ description: |
         sm8350
         sm8450
         sm8550
+        sm8650
 
   The 'board' element must be one of the following strings:
 
@@ -1044,6 +1045,12 @@ properties:
               - qcom,sm8550-qrd
           - const: qcom,sm8550
 
+      - items:
+          - enum:
+              - qcom,sm8650-mtp
+              - qcom,sm8650-qrd
+          - const: qcom,sm8650
+
   # Board compatibles go above
 
   qcom,msm-id:

-- 
2.34.1

