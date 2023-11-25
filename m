Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92877F8B55
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjKYORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjKYORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:17:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1943133
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00c200782dso409293666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921867; x=1701526667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLrIlTcrfNZmEHwR1vKQ7waqjNZmvK/fvwshiqcqRAo=;
        b=fX7Sgcb2cGwapAialxIgrETc7FqwWNI4RFvJhOCDneFOEJT2hYL/DDFns1cAWkxqr0
         ZieHVA2ryV8P445WjVUjQIqrOu7JQSdNvv4EL4SGRh7iOMI/55P+Q8vLQKsSjamP4y9f
         kTPgNlQZS6yKnrWkMIXom5F/1GONl6CVcO+pZjDq4rz9m9X9ZefzQi/nke/JqtsvT+8A
         OzTAnDECOAnIhJ9UEFvMuvUVxSpR+ztxrVDTGbnaWIdXpmeFa16F7UwZzguoVn7wGzi7
         jLQXoyL0/TBjIOO/D2yUgTazJoQyvLZ0kmwbJyfWKgpImdpWLt20wGwNatVTRIQI9GKK
         vWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921867; x=1701526667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLrIlTcrfNZmEHwR1vKQ7waqjNZmvK/fvwshiqcqRAo=;
        b=rTnKLRy8cDBgAXBn8qvVml2vscUcMOFvXAe09p1/qPQxaWiL45uPMASA0DiK2xfpBp
         Fy2AeAHUdHH4TKp9bxipvwrnb61tS/OTwXH2PYQIVTi4pYwWOKVI0mra/hlDmAsj2KEh
         9SwHJYisp9kayw6vNlnqHqRsr5JXLj9anuMlKwhwMb/u+E1zt8XeGO425+zzeiVPpKjh
         Sl82Js+V4/B2IJ9dKWphT/tchnoe/Z9Qry5YMRUpQZjuqW0gY5u5WJuSd8HzEap0ehsH
         yZHHqQ46vHeIqSIhNjCqgUB8wGAZ7tsEditwHc1RNoak1SbpMGWJfcwOVZb+7aLoluCk
         4aQQ==
X-Gm-Message-State: AOJu0Yz7yhKDrsXrzNu3Qy7OWpiYTEA8ZyKCbXYhXf4S3x06lW/Z3Jrc
        u4/0G1gOSaoiltH1w11g5Z0qIQ==
X-Google-Smtp-Source: AGHT+IHy8KiePOZBp8lIAsCOZSPCZfjYQvCkrTWRBfU0HFRyq1+TOhdthnHNQZRG532gJ6TOTfvz5A==
X-Received: by 2002:a17:907:3c23:b0:a02:3f1e:57e8 with SMTP id gh35-20020a1709073c2300b00a023f1e57e8mr3984306ejc.36.1700921867257;
        Sat, 25 Nov 2023 06:17:47 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:30 +0100
Subject: [PATCH 02/12] dt-bindings: display: msm: Add reg bus and rotator
 interconnects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-2-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=1875;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AFFsjfQ/BWb6zbEE2kIE5M6+YBHmlQ+rokF2C+2Kd04=;
 b=Ko21H+lWGGl59y8qJsZ+LTUw0AWkhTziUlqwg4+lQP0Zq18rNp2fD1omovB6ZeBmhVmjSNMTp
 wKdjaAGzz5nAy1P3zo5fSusiUSJLqx/3Pre4Gi7Q7gCCuziLVKdW0lH
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

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there are
other connection paths:
- a path that connects rotator block to the DDR.
- a path that needs to be handled to ensure MDSS register access
  functions properly, namely the "reg bus", a.k.a the CPU-MDSS CFG
  interconnect.

Describe these paths bindings to allow using them in device trees and in
the driver

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[Konrad: rework for one vs two MDP paths]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/mdss-common.yaml   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index f69196e4cc76..c6305a6e0334 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -61,17 +61,27 @@ properties:
 
   ranges: true
 
+  # This is not a perfect description, but it's impossible to discern and match
+  # the entries like we do with interconnect-names
   interconnects:
     minItems: 1
     items:
       - description: Interconnect path from mdp0 (or a single mdp) port to the data bus
       - description: Interconnect path from mdp1 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    minItems: 1
-    items:
-      - const: mdp0-mem
-      - const: mdp1-mem
+    oneOf:
+      - minItems: 1
+        items:
+          - const: mdp0-mem
+          - const: cpu-cfg
+
+      - minItems: 2
+        items:
+          - const: mdp0-mem
+          - const: mdp1-mem
+          - const: cpu-cfg
 
   resets:
     items:

-- 
2.43.0

