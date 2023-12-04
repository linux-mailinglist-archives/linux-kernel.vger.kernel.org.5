Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0F80337C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbjLDMzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjLDMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:55:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EE109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:55:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so13676905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694538; x=1702299338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VYbVKXhxANMzmAo5DevDefivd0gCsbNC7OR7kQaPmk=;
        b=IoDNXalFUmES1fSYW9ynJsO+d3+R5Fqu03qlm+not/pECMwuZQokuSD94kTAyW1Nbs
         LcpC2Y7GkNCkN04VOZlpfAcDUw7MpuFeJoqGqEzFzgMoRWdI7iDTVcdLL9XmWxVxvwCY
         Uv5GJEPNWkDkCbETRYRlyV6yYS2YtNkqe7Ys84FkWNWrYECJPBVvgm19I8DgLAv213eq
         lXw7qvbLMywXywjoufQditAJ1fM7lqwm7r9fohVNRSmRgrDJD79u1dY2a4jTaKQgM/j0
         u+K6EjxR0jxphcaDxjb+vohxIrtK4tEQcPI6Q1SaLyXGaRUz4V/YBby7GI89YQ8hicPR
         ilKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694538; x=1702299338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VYbVKXhxANMzmAo5DevDefivd0gCsbNC7OR7kQaPmk=;
        b=QwHT+6y4RNzI7+v8jYKbwrP8tnMd+vxwqraTX/R1LqgEHWDSmnpZn4CKBwVktPgDDe
         cCdIVoUKgdZ30QvQ6NtGH+7Sx4o4DkRvrj3cXrJ0NT9jIXG7LJLkmFOo/ZjW+nvlqHV7
         j0bYSsVoSF9JzzOqXqXFftkiszAY513XJ335gBiaiZQJtnEfVvtwnefQhDapwY2rEKkk
         S2NkIeUkz6J64bKQPPkOh98uoyq/ep4U0hWF0iUDJqRqJ266JGKqZ/dy7P0wKfkh6e47
         wxEhpnQLxFQUvx1DYDo2n1arpw66A+vuCvoOYE0RXfVYVdUDl3Gv18yhr6wN8tBG6ilM
         ueyQ==
X-Gm-Message-State: AOJu0Yygw9wXkzbtbDvQfPgZHeAoKrQWX2djTomU0TC/4HKBz83sp55K
        w9besTujzncbTzf79JEkQkE0QYa16Yyoo/ntUeE=
X-Google-Smtp-Source: AGHT+IF20KkqSBNgI0V5q5M23rtNvOl2oHvkQdd+994YeANMyI+Y4stIiq0gluNCbAppjSBRCJtivg==
X-Received: by 2002:a05:600c:1385:b0:40b:3fc7:c88a with SMTP id u5-20020a05600c138500b0040b3fc7c88amr1831169wmf.39.1701694537845;
        Mon, 04 Dec 2023 04:55:37 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:37 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 04 Dec 2023 13:55:20 +0100
Subject: [PATCH v2 1/6] dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-1-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=2754;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1ykSmvOZZDjJjgZpitbyB4XwAgvbWrZhIXxM64S4nPE=;
 b=lj3IMiwPIJxgczSTOsCkVKkVF04JuQ2p6btaSUMQQGimuIK9Sqsb4x4moWx+oYn8OzCWFpfam
 br91WBeade2BjmO2oLO7ObprbqxSPbY8KcKz1j29Mnt3F70tYkAnC9D
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 and SM8550 both use a Qualcomm-modified MMU500 for their GPU.
In both cases, it requires a set of clocks to be enabled. Describe that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

