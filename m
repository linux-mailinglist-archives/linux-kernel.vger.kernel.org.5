Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F47843A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjHVONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjHVOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:12:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C06AE4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:12:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so43124465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692713490; x=1693318290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NuUj1e2uioZdzoL4ZpIuuQFQzc060pGZCFyiXZsTBk=;
        b=hmSFDXgPYiCb848Iaf4vm5HOea1e8nhq5wDEuKLvVOungPI8MXc9KqMdGCX3Khhn+e
         gh752v0OR8OeKkxcBlJvNHARNRuFUETCNPURpjk3o4TPFt+csn8kCEin3QtUHOQ7uM8H
         fDrLb/yxS1X6wp4sZw/pPEQQxbbUmK5mTyGFGf0N1cgBX8WWLBwt1yWzVujCTAvqo/b0
         JpRBw7i45by4LDSYGg9SqVUk8edq6ZtfXMGulaQPPZ84i6IjgDbHEz8Scs65AOf/yC23
         MJyQEA4kTwLd4Gr3CYLSt3wRjQJwZPg9/DbhDOLHVcKBbaQzWkutSwCzuC1x/TTa2P1z
         WMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713490; x=1693318290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NuUj1e2uioZdzoL4ZpIuuQFQzc060pGZCFyiXZsTBk=;
        b=N1zn9TBBQji+GjDyBplTnUtSPe04NTLXlL07ETl7wBsYXZEi1/suLJUYMOVzJna3mo
         DcJb9em31Ie5IxDM9pkTCyU55ENVrhjf6mmjRhWr8Rqe3Ls6h4MwWrWkEBwezc1tm4Xq
         LJ/0Ba2tA8OADXNc4ZgJw1N5ecXLeXZfILOFqswG28AD0HE6qu1jo5JtMxBHYmh+6l7r
         xgQODGneUXheLcw6RAW5HscSIuw07CwEtFZ87aaoOCisgAYrGClixvUMejJyHTvrbNUF
         /awysta4rO9NH4FfAzUzo3osVEpwShNM5pvxRXnhn20gnpzHIpic6v89huQjkTgFPxfy
         x8aw==
X-Gm-Message-State: AOJu0Ywj7kNtazf0BeWsJGivSqtRBb+UHfCqrSleyrKfOdvbmq9WZNcQ
        zKBPQRFy38m375Hkc9AhNk3C9Q==
X-Google-Smtp-Source: AGHT+IHSy+c6X29/B+uc0h5uygx4Wzt9QiBQiMCP9XwGS7qAxnnPDr1NIbD4u82IyvMT2VjNAwDAQg==
X-Received: by 2002:a1c:7705:0:b0:3fe:f99:1ba with SMTP id t5-20020a1c7705000000b003fe0f9901bamr7743291wmi.2.1692713489933;
        Tue, 22 Aug 2023 07:11:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c280900b003fe539b83f2sm19587753wmb.42.2023.08.22.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:11:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 22 Aug 2023 16:11:24 +0200
Subject: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
References: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
In-Reply-To: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GUYupVDxA6Ws4wGq8QNEeRAKEiaPalNqjgPA42KveaA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk5MIPwNRw8LDa2gdB9oBZJxUTJGSl4EtlFfKxpH1O
 EndIqleJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOTCDwAKCRB33NvayMhJ0eZUD/
 9V+26Wr887xbDjhgG5nDAeMB/FACgZL+/702uRsC5Emz9Hk1q+05LP6cwoEZhUT4m+y6ne3ZMliwYo
 pjgaVeXfKSBlrh0FZfatza7xRKIeD+nOTdFqfph7zPaK8UJV/hh2TW+ppVepEB12iFWZ0pWPvD8R2B
 O+6H8AZd416BFMrbrlqi94YrIx72w16Pgm0V52/mhFVYWgTKR3+J7AYuXSZTSMUzKzQZ8Zf+v9WYtI
 yhY4tEyM4bhxEwzISr4YtDgnMQWpzyoeHireX4p1y1wSJPxEX+pFi/mHpw/7hD/7Z5SrzEhhUDklH2
 j1JKqxPWiFRAgQBOg30vebfOaF3eSCo8ryyQZ75OsKm9RrAbPRkryvtr+V5VMuMcAJX1Os35v0XnDy
 mkYbDVsBnmoQUJqeAKjtlh9X5JlaoN2w//Mv6I4jKd2jOe5vK6UQZiksF5wIQH8+dl36dPZfJm2cve
 POyIHHOHB1G+bHyHy/p4NUk0vDRnWzswVIFKYFka7em+zn8lclW8alDuDtxTZeQrGguXFTB+bdjiOC
 C053Sm8qVZrrc6fsQjqPGICSMHHLOKx88P8YpH+Et9IEpe0gGnbcR+6qN69AH6Fe1rEy9fXHmNWvpZ
 yNiwgnr3XQSiIC/p/W+LkdOFU/fsqoQnv9Lo3wcmtU3vVrWE8tCEcEXGI1WA==
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

Document SM8550 compatible for Pseudo Random Generator,
like SM8450 doesn't require clocks setup done by the secure
firmware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 36b0ebd9a44b..60fc9f261b83 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -16,7 +16,9 @@ properties:
           - qcom,prng  # 8916 etc.
           - qcom,prng-ee  # 8996 and later using EE
       - items:
-          - const: qcom,sm8450-prng-ee
+          - enum:
+              - qcom,sm8450-prng-ee
+              - qcom,sm8550-prng-ee
           - const: qcom,prng-ee
 
   reg:
@@ -39,7 +41,9 @@ allOf:
         properties:
           compatible:
             contains:
-              const: qcom,sm8450-prng-ee
+              enum:
+                - qcom,sm8450-prng-ee
+                - qcom,sm8550-prng-ee
     then:
       required:
         - clocks

-- 
2.34.1

