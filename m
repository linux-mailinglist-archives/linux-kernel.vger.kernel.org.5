Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E17D62D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjJYHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjJYHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:31:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963D10E9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:31:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32dc918d454so3394521f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219101; x=1698823901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOTcwnczC4PxQ6rH6U9sEzrC3HgOOqwX7rzdkrhwTSA=;
        b=IsKfJ6E8iYWp1LFhNFSUjKvIRsuPjZyF5YQMYqU9BFce/13JyLhTHFLO/iwy/ipflJ
         ZupXbXztf1UpVetan5PYq8qq8ISinfTaCS3ejQ32GgExsWhPZvKk5xnci0w+pVMU4Llm
         N4FnMdcxWrxYNXDWsab4yvfcN19iG3WK/9q/UJRbkUnnM1njCtQ4FfN0HgGlI9CoHja9
         n6NBtmY0+wsB2pXW/4lmTKpFq8jWOVXTTjljiHd4R2SSF7zJ45AWZQNzIXUCkxK3T2vM
         d06sN1IBxyoFGzxjoHGAK2zUcwvA10Urjg2dJayw3MMwwkzqFepwNEXWSs2tEvOfAn/Z
         WFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219101; x=1698823901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOTcwnczC4PxQ6rH6U9sEzrC3HgOOqwX7rzdkrhwTSA=;
        b=ZnpumR2YxCW8GrS/oSR3qQQ7gqLKiI5Wpz7MNmLI5jBTLh/fmvr+Fo5jWgDlsqGb4D
         PE7dhn1Y9Ya7o9Cz4zODGmOx4u1kWKvYyxi24PyVCLKTRSMbNEvFcfdivj8k9DLZHrTV
         pWBJdkuSxDtdeSpm1XoHkaF+jS25x6cswL/35VASMlfSl6yLafZXyQs67YZIoE+MAY8y
         5aT1EACQDBZWIG2Ob2wIZK2H/j0CcSssrTuhsZrw5XBDGwA13V1isqkhW5LlQ2qU5Fhj
         TRt9Y+IuAMduX9km+2RUSemjJUfZJ1dACwhlwZxvRQpEo9xEpoeMC1UwCiWxFowg3AoB
         QBNw==
X-Gm-Message-State: AOJu0YyKj1grb5L850Tg6lQSdetxpFLcK4LpqshIb/5Ao+ZzHMKlgwKh
        JDPXOzXeoHO334FoZQccYmmzJg==
X-Google-Smtp-Source: AGHT+IG10Ywr4AUqFCwhjwvjXmKE1Q2T8+BNjR0knvrMvXz8egk4VsBuxzX/f20oHYVQSJtXgSx/Yg==
X-Received: by 2002:adf:e7d2:0:b0:32d:9541:b1e3 with SMTP id e18-20020adfe7d2000000b0032d9541b1e3mr10279213wrn.26.1698219101107;
        Wed, 25 Oct 2023 00:31:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6451000000b0032da022855fsm11412184wrw.111.2023.10.25.00.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:31:40 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:31:36 +0200
Subject: [PATCH 1/2] dt-bindings: cache: qcom,llcc: Document the SM8650
 Last Level Cache Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-llcc-v1-1-ba4566225424@linaro.org>
References: <20231025-topic-sm8650-upstream-llcc-v1-0-ba4566225424@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-llcc-v1-0-ba4566225424@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=705;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1tWYKwSx3WCKiHpm9o3BwMtVTqHehsjlnL71tGFw3vg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMRaoSduImM+/KwRTGZ/L+3qaXVeDa/2mgHZQPsL
 HIcii3uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEWgAKCRB33NvayMhJ0fq3D/
 0UW+duyu/oHfNYjeGYNvSIu841qr+DeTsLef78+JWgqZu4/WgydwscExxWQ2tMoyCTuB7bzBFfuZOk
 v3LqPTrUK9++5QF+brnvjY9x0mJCBMDK1Tk3nsxGKQcG9rdnYIgEmP6wxLP2aPUzT/VwB7A8DZH0oX
 NLNWeIrdIOAuywvVwa7d8bmV9JJMx5o2hrdLoEoaM5kSDAWQTUewH1GskD+I8z5G+SQwFpDT3/2wHJ
 EQHYWuoERxHJWP5wvj9oSwHPF/XbuxrQSSVRvWr7bV3A5iDc7NrhzJVZVf2cRk46gVLYeaQmrkzVHe
 tjSF9IZklvJ0zrGBIa4LI7/1WPZewjabUCnyUrvqfJ+WRLVzamE3q6jQUoyx4T/C1mx9T7OUFoabnm
 47CY9fL0k3x5XfbJeS+8a9+CqwoDJD39yjhS5eSHzI6kkZkjE5wZ2Kk334VpC3RCgjazWl6tJaEb9u
 wp+iSRit/+gfrl3BLOnyC2Yb5QYhHwHpZ3lcbpRfNwfxbRwihD/0vIbmfyU1G7/Cib4tX2taaO1q+u
 Q+oIxUt7FL+cylCKvi4JICvTH+Kpf65q76SAvunY41eN9txodJH8TkXcTLhMTmMqr7E5FaOfQhajaS
 2zteyGwzEr/W8vqoaMhcSoj4qoXCsNt2jI3i8Ap3TWrbBS8dkz2jROXnYLVQ==
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

Document the Last Level Cache Controller on the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 580f9a97ddf7..7a211e35e166 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -33,6 +33,7 @@ properties:
       - qcom,sm8350-llcc
       - qcom,sm8450-llcc
       - qcom,sm8550-llcc
+      - qcom,sm8650-llcc
 
   reg:
     minItems: 2

-- 
2.34.1

