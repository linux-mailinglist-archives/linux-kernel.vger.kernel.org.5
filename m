Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF757FA61D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjK0QUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjK0QUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:20:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC4113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:14 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so613546866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102013; x=1701706813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4Qar7YCtECHHHtbAdP3JjSDpAvBK1JG0fUmDN50K9U=;
        b=U/6kaPrNqZdRj8gmxaL8dtAtgL9bMR+e2QJTb7FMUSINp1Eg7FwgdEYThheaq8AKKY
         khS3w7TcTMrsg7L2WHgh3GA1VxSJdn/A/lDkhSmDsdfV3+lM2MFNnqnjzKlI8V7yGVj8
         DpE2W47Dm2etEXgLc9TSY2eZ/In/1GXOQn9NSezpokprIPz0RQbTdnqyEf+mJt1fx3hP
         Vr1cHNvFAZJ7Yw+uZbfbMmX1d8xqYUxvK5V3IJqCKsf/5nLZKKbuHiWkWWgon1VCjysO
         AIi8p5212SO0jw0U85MvfOeh5/ggv89+GiPT9d8Y1a02q9q6Am5/JKbcbvH5G6gsUGri
         OlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102013; x=1701706813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Qar7YCtECHHHtbAdP3JjSDpAvBK1JG0fUmDN50K9U=;
        b=Uu1I53AOKraMl00BvLzNTGLeJkzTXHvtaX6IIwqDtZJEvjJeLLMNtJyS9SQoZglLI3
         MprO91AgwcMqTf+zSjjDjVsLVoLr5BfBx60iBAd0KSgzRBSSdD51lXv+jBBSJ2YZ9zw/
         vcIPaxacKd0AVY1NRkggXefkE3l6gtCATFhcD1xBcXXC3etzu0Y5OrvY1STG0dC6mXlY
         ACEuu0xsJtb170rnqQgdiry5N1s92kjy/kJ1FxXYEKcF/arn46zIDYt5cxGSicDOJH8e
         NkasNJLAo4lvAZwN48SJ2ZHX2OfMl65ebocSWFh7yW8Js71ux+Zo5NkXNFGE7A86gM0b
         lerQ==
X-Gm-Message-State: AOJu0Yx+hLvB5ErdNcVqB6NxOBzBtD4KmDJd1oPt043eOr6Z6cui4rVs
        U4jU5asBQjJu4RR+xTTzucHttkaSwaCIMWzZN7s=
X-Google-Smtp-Source: AGHT+IF2zH3PWtUHX1jYKPVrd2c0nOGMkqPFufplsRrEuosRu8zLboazblnBYXTJ0eNzXlHNagLNiA==
X-Received: by 2002:a17:906:fad6:b0:a10:d5ef:ff00 with SMTP id lu22-20020a170906fad600b00a10d5efff00mr1855674ejb.2.1701102012755;
        Mon, 27 Nov 2023 08:20:12 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 17:20:03 +0100
Subject: [PATCH 1/6] dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-1-a228b8122ebf@linaro.org>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=2687;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=74tAYPhFS0JRCe3sr6MjDifnedbnYgVr+albesY88R0=;
 b=No3Vb43Hd8bD4NOsHXSg5ppXhq7oWxb1HCy48OeWtBGzmM/Vf85XVb4qfsN85FKcmgSofqivP
 np1tT3yPxGoBCcURjbxS75Vp3ViOIvu5TsM+75m9B+XJYAMDFfL629i
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 and SM8550 both use a Qualcomm-modified MMU500 for their GPU.
In both cases, it requires a set of clocks to be enabled. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 48 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index aa9e1c0895a5..19dba93a7654 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -89,6 +89,8 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
+              - qcom,sm8550-smmu-500
           - const: qcom,adreno-smmu
           - const: qcom,smmu-500
           - const: arm,mmu-500
@@ -453,6 +455,50 @@ allOf:
             - description: Voter clock required for HLOS SMMU access
             - description: Interface clock required for register access
 
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm8450-smmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: gmu
+            - const: hub
+            - const: hlos
+            - const: bus
+            - const: iface
+            - const: ahb
+
+        clocks:
+          items:
+            - description: GMU clock
+            - description: GPU HUB clock
+            - description: HLOS vote clock
+            - description: GPU memory bus clock
+            - description: GPU SNoC bus clock
+            - description: GPU AHB clock
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm8550-smmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: hlos
+            - const: bus
+            - const: iface
+            - const: ahb
+
+        clocks:
+          items:
+            - description: HLOS vote clock
+            - description: GPU memory bus clock
+            - description: GPU SNoC bus clock
+            - description: GPU AHB clock
+
   # Disallow clocks for all other platforms with specific compatibles
   - if:
       properties:
@@ -473,8 +519,6 @@ allOf:
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8350-smmu-500
-              - qcom,sm8450-smmu-500
-              - qcom,sm8550-smmu-500
     then:
       properties:
         clock-names: false

-- 
2.43.0

