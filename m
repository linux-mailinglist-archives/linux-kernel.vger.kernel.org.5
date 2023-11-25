Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE027F8B80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjKYOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjKYOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:18:03 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F1EDF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:18:01 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9947f488fso8152361fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921880; x=1701526680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMfZuIt+BqG7KJ9nvVW95qPOCXnGA5QHM/Q3t0t9+4M=;
        b=JVI45ek3nUjZLPzP4gXrVK6Ab8mYya+JK4b9mYzHFa9kiBUUgmVW6Ybu1S57XM133X
         sWPLVrKUB1M7pNEFCuz7eD4XAmzvC+6D3TR8kHQAgPPd38FkMkn17vsYbKb59i2meUfU
         SAWGZDfuF/G6CIujKfDfZtbA0Bemft9M9Cmo5bIwg33LZDJInr6K+D73xo6I50bQAUfZ
         z9cGALg2Ud+B2vcWHsrnWq4FX3j62ud1TC5RR+tsBGTZ27m7fEVeVX9eCCE784mz4DB/
         aup5BIVu+Eln1mdCD3Bz44W4j/e+Za7ToZXE+PhXAaaOYF4wPXlUsOb7gnDnXe5kMDwd
         K1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921880; x=1701526680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMfZuIt+BqG7KJ9nvVW95qPOCXnGA5QHM/Q3t0t9+4M=;
        b=xEdSkooKqkGxYFC4SPxZTEaesO1sz3ZW3JpSGvkkJiRrxgld7Mel2iChbMViS8/6oi
         Eu+0zJA7NfAJBLLKMtm1Z/oq//FpMAbZ0z5+JvwRQ1N5/qe0HURPqKH+MUQpozyIeUFA
         gDS88YElLZOA+Ll6IaAYig9KY18ib7ixjDo+5MRfn2PPqGgmchbedv9Q3G1eKx7GuCmw
         XnL6zC7Hg7lRIvGhJJDnmCX47JftAnpdtRjY7b0wRkTshhysp934j//cF78M1SNhJRJk
         HiLVHqAFta/q5nOi9Z+x8D4PNW8RRBa0WGZNaWQ/JQ24vS7kc8fZmtg6AVlLQ7Zz1ZCf
         Krlw==
X-Gm-Message-State: AOJu0YwC2JVeAAQFgO+IWVa9/o3/Oc4W7/CPa790Df01gz+igIyq1TSn
        3pLfQXmU7xO+dQU6sxRPyC+OeA==
X-Google-Smtp-Source: AGHT+IGY8/ylhRHLmys2VuwyghOEp5L7XnbE9NC1OHEjDt/EDFIyFNSFmFVQ5bIXBVUTdxQp2wEScQ==
X-Received: by 2002:a2e:350d:0:b0:2c6:ed74:39bd with SMTP id z13-20020a2e350d000000b002c6ed7439bdmr4479087ljz.12.1700921879933;
        Sat, 25 Nov 2023 06:17:59 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:59 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:34 +0100
Subject: [PATCH 06/12] dt-bindings: firmware: qcom,scm: Allow interconnect
 for everyone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-6-11d71b12b058@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=1089;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zKRggNekRjMo2HWiE/Zd6htFQdzWQ+j1rvOWJYZk1Dg=;
 b=J86IamNFPWjvFl8R15HeGrbbKv6nxOgsRyV2gcyGjGQvv0D4Sonw6dL4ASTha1oCz3/d/YNgs
 sy9rMHIgH7XD+CMd35v3AcW4emIGcmWa0HZbVIBI6fy/CV5AVKhIpjD
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

Every Qualcomm SoC physically has a "CRYPTO0<->DDR" interconnect lane.
Allow this property to be present, no matter the SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 0613a37a851a..f3a87a8426d0 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -178,21 +178,6 @@ allOf:
           minItems: 3
           maxItems: 3
 
-  # Interconnects
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,scm-qdu1000
-                - qcom,scm-sc8280xp
-                - qcom,scm-sm8450
-                - qcom,scm-sm8550
-    then:
-      properties:
-        interconnects: false
-
   # Interrupts
   - if:
       not:

-- 
2.43.0

