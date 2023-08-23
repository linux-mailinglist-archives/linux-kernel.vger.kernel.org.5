Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B811678583C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjHWM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjHWM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:56:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC88E5C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:56:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so31548881fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692795362; x=1693400162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBaJ5OsgfXs2kkcWusba2RO2Avkk4yo/xOTdTxq4iI8=;
        b=nFwEETn78mwFOweFwubXHwB/C+P7qrmJHrgLWAdf4o+b0utAvC65FBdmYaPMg+97JC
         Sj0soxpIMmmMNDaQpyIH2m3mDRjghpxeG6mChYdZX4C2ymOqCbGomsSFYSRPOgEXFxcK
         VC3+ScZpKy0/bft4yKV/j4TDzfMb9KeyzAWejjGQfRJ+pWOpALssQ6ghZix7HZ09wtab
         lHpNTHiuw2ONDZUVu7ECh34B57z9zLmCcLeS+EVejaMSynErA9YmavniFyVooH6NdXbu
         vrA+8lZw/pMaxsi7BzySyj0Fqu8Rh41zvCdP67nVBdCVKwO2elUBNnYu6Bfut1Xmpd8Q
         1DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692795362; x=1693400162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBaJ5OsgfXs2kkcWusba2RO2Avkk4yo/xOTdTxq4iI8=;
        b=jMp7pL2Ymd09Iz+ak/dM8JPwHYNLJVJ9o+XbyphdC3x9itKL/wNS7FXQ6HEcMxOfkO
         JeX9Qvm2XIfPQsMdJhRlx1Vf4+s8qz21/eWiD/MzjX16HSxj1AvBs1zyCPYzsFShbmud
         TrTnVDR8VzzI67Oohdtvga9Q2/NtY0N4+zkWpJ+u3948ZEJK+Gv+edGAq1btND8RrwTH
         D3JCxhBnnsoTNm+NsgikmLvzI5Fv+OnI/PSyLxZP8GRu+KmoQGEmr2oWI4EnT0krWEnX
         ek90zVS3LNVCAOlIeGa9c1QSBdox219kYrOVOASP+c84N/duyAuWO+rRlVm0X3goY6IQ
         Zibw==
X-Gm-Message-State: AOJu0YzqNExX1Vks6qKzY6vsGhkaWahL6o9liFpxZ1Lm2MfB7OLj18ph
        KOC+JOOJT6JL92WjWnOV5PiCXw==
X-Google-Smtp-Source: AGHT+IFQSUpVtDlkA3Qtiu0IIzwzYYR6P8TkdBvNyd1xjlg7sp7x2+BrOapUKG0oxhkxYmgoBboi6Q==
X-Received: by 2002:a05:651c:cf:b0:2bc:bdbd:1542 with SMTP id 15-20020a05651c00cf00b002bcbdbd1542mr6804744ljr.11.1692795361697;
        Wed, 23 Aug 2023 05:56:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj76.neoplus.adsl.tpnet.pl. [83.9.29.76])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b6db0ed72fsm3220256ljb.48.2023.08.23.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:56:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 23 Aug 2023 14:55:54 +0200
Subject: [PATCH v3 01/10] dt-bindings: display/msm/gmu: Add Adreno 7[34]0
 GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v3-1-4ee67ccbaf9d@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v3-0-4ee67ccbaf9d@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v3-0-4ee67ccbaf9d@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692795358; l=2826;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HNK2SS799OXNh7iy5vESf+h2uwh6BGHa1r43G7UvIKE=;
 b=/DAwVATtw+vn+n8shtTbBONnwNRjmULTiU2IxtoBwvSmEXIwhcDqCUfaleCW2fgNtM8NHwn6q
 ikU/lRY9xDHAgUmZU2+KFF9YXbJEByM+k+FDbj5jyrlIkvSttpKAAI8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMU on the A7xx series is pretty much the same as on the A6xx parts.
It's now "smarter", needs a bit less register writes and controls more
things (like inter-frame power collapse) mostly internally (instead of
us having to write to G[PM]U_[CG]X registers from APPS)

The only difference worth mentioning is the now-required DEMET clock,
which is strictly required for things like asserting reset lines, not
turning it on results in GMU not being fully functional (all OOB requests
would fail and HFI would hang after the first submitted OOB).

Describe the A730 and A740 GMU.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 40 +++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 5fc4106110ad..20ddb89a4500 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -21,7 +21,7 @@ properties:
   compatible:
     oneOf:
       - items:
-          - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-gmu-[67][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
       - const: qcom,adreno-gmu-wrapper
 
@@ -213,6 +213,44 @@ allOf:
             - const: axi
             - const: memnoc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,adreno-gmu-730.1
+              - qcom,adreno-gmu-740.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+            - description: Resource controller registers
+            - description: GMU PDC registers
+        reg-names:
+          items:
+            - const: gmu
+            - const: rscc
+            - const: gmu_pdc
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU AXI clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+            - description: GPUSS DEMET clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: axi
+            - const: memnoc
+            - const: hub
+            - const: demet
+
   - if:
       properties:
         compatible:

-- 
2.42.0

