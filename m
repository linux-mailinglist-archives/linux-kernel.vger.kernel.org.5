Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C97D6374
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjJYHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJYHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:36:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71810116
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-508126afc88so1300487e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219272; x=1698824072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbrvIzvdzq/AFVOVjbVafR3T9nNAQ5I5GLW0AHPZ5/k=;
        b=Vz6qgUNf7iBBNGbQ5Q3S+9nBKLCrFfuWXi9pAnEZqnaHJTVNWsxRFykgBtlTW88G0D
         d/ZomFdfzqgM4aSeu4j3eR6Mmae5UtepHfzul8+GAQxFnvvOdLsDezOMXhtlnkQbUHEC
         PbbE8u+vYclu6rlYF+KdhPiSBA4KjqoU1iQK7WB/EJmKa0q/qLWAnK445VYdGT4mM6wf
         1dRu1/9QFOE+yT6DTFpwkhKZuGWKXjrsgdj44Di+jatt8RSGUkiO9YFuKfKC8+gcRScU
         ER1yWvVf9OeO0XESXDpzvxovO9aWw5LqS+v8cmMKcqIo9WJ2qYxLygWS2PEe8D70MLWE
         UvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219272; x=1698824072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbrvIzvdzq/AFVOVjbVafR3T9nNAQ5I5GLW0AHPZ5/k=;
        b=HR2x7XKLZ69ZNqAAPHscyizAXLJSwfFoJBk44PHhrGokYrAoP+zjp7Wz3Qzh67eiYm
         Rrd7eSD63rahr/3Bh42lbnFtyIqEbqhe2VKW9/YiV6B12CNKEI57GotXdkxeelgs1tOE
         BdH7CVC1T089LWdd+7PmiY81brUxU5GqBVSB+EhesJL+NjXd0h+anfVB18CsoW3HuH/S
         sqc+0/F5e0Dmc0JAphLHYioc+aRGwFqWlrHdP/hu0LSqXf2UN4SWLpeAvu1bg7W0VKMF
         okC2KDHqZtIgGyz5WBgkzq3CH/RBldpECsYDOkRPWqvLX+7Og3UwcBH8jXuvhYMYNBDK
         NyGg==
X-Gm-Message-State: AOJu0YxAyV3I7M7WauIdvXEJnO2C841Md0XzavA6WQjz19drT07iwuCg
        VbTRmaR3hh1WOdsFoolAWbozK6C11yNA2l1pf6xc0yL3
X-Google-Smtp-Source: AGHT+IEZO5QiKOjC2lbTgrH0pnqsb9TCUneqoGjzkdruJYssC7pozOdxX1CYD6R9k55MHLVaDaAZrg==
X-Received: by 2002:a19:7015:0:b0:503:7be:c85d with SMTP id h21-20020a197015000000b0050307bec85dmr10051522lfc.35.1698219272614;
        Wed, 25 Oct 2023 00:34:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b0032dde679398sm11431392wrs.8.2023.10.25.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:34:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:34:25 +0200
Subject: [PATCH 3/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 document the SM8650 QMP USB/DP Combo PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-phy-v1-3-6137101520c4@linaro.org>
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KnCaelpeaszap3KN0CRLC15V35wlkNa/TjtN4fP9oFk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUCl3WwZsvJzEEGEdGRKVUDhdZTxdbatOrOyBLX
 s7Vj1yyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFAgAKCRB33NvayMhJ0a6WD/
 9zb9fqAocbGRCVJVVlWKfgXMeW5q9BF3FDnpm0+DCjwMQofCx5JE5amlasApZRsXBj/ibGanI9bEOt
 aMd0P5edbATNkInvjw3wdjRYVQedWyQ3kug1t/937mZXnyPImgFJoc+la5QA2NwE9uHcAEBGTLjXgO
 /BwyJJniPPKhfkBPHKjU/EQ4rLTT9M+uixKRcjLE3Uj7AwUbAzRI/x6Fqw23xwWJr9j8WyhsFJxjpR
 U/JsAJrpvDeUgKyiiPt/OcKrhxPdKJ8E9/H4/2IpipbqCRtZzbnS7ng508hZ3Elwo5lwcFHRz/HqBB
 Hadwunpcvcvg8z9qNyx7Orh0cIndmcGyV0yZFYas6KZx+romuNw5QAPCufPWazVp4QvYevDuNekKy2
 Ze3jy97x8WboWjcN1rNSRIAIATNWCBsIfjkSDsPLaYQAsd8f8Og0SjthZ6rqiiiHDmOfftmEa3F7hz
 9OukfROqYx1SmRIpUxROzbil572WwRtMsEQv/MFnClf9c8wSpfp18hqK2ch71IxWTrWNDTS17XVaWA
 QiG+yDqmYUORl3gBaH4SqlQODzrj2mqfflWjLVqeotYUNkSMtpdRN8deA/QCmqrh2gdN16I+CqMLue
 Ah8pEekWifx4QjCuw/5lifCrAKSR4KTwIqCeKNmbnzNOqQhJbBHPljXv0Szw==
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

Document the QMP USB/DP Combo PHY on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 9af203dc8793..ae83cb8cb21f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,sm8350-qmp-usb3-dp-phy
       - qcom,sm8450-qmp-usb3-dp-phy
       - qcom,sm8550-qmp-usb3-dp-phy
+      - qcom,sm8650-qmp-usb3-dp-phy
 
   reg:
     maxItems: 1
@@ -128,6 +129,7 @@ allOf:
             - qcom,sc8280xp-qmp-usb43dp-phy
             - qcom,sm6350-qmp-usb3-dp-phy
             - qcom,sm8550-qmp-usb3-dp-phy
+            - qcom,sm8650-qmp-usb3-dp-phy
     then:
       required:
         - power-domains

-- 
2.34.1

