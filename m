Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAF75F952
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGXOGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGXOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:06:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E64E64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6635959e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207595; x=1690812395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI3XSmWAQW8kVYbRI7HJqEcMWkjdmlEzkWOn/96mEgA=;
        b=Ott7X6Os1IoihehNSwApHp/wFXhfiWvlFOWLG7OGw/CMc4YMMfVZSGj39pFm/qPNNj
         BPlGbP65zcP7bezsKJnCrPLmadcmk4KyPEmi0PghS5PaAU826zdpuoO1n1C5/OBHKFOn
         ALJgrdglMRUT8VhGl7qGXB82WMnlMadvtxPh4zwDz4lAtO1t18mK6Z9VbHne8CkEeZjX
         I6FBGLVLu/NWHy8qNZ4pVCZn1hmWnqKBXGi3SeLECzmAVUgwWxWJWeRYgzpKiy+xrUiz
         fKH1pmGJ5HOf2Qd0iKlI/xAfMWf5DMb4d44VfHD/2G9RjU8l/0156T1zUeFd1E5UMPsA
         Wq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207595; x=1690812395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI3XSmWAQW8kVYbRI7HJqEcMWkjdmlEzkWOn/96mEgA=;
        b=A8voK0qSudYXSE1JTMhbQZV1adoYnFScBhCMRzNT5F47hnvbyzhaGVLodV11ZRLtao
         nQS5sG4pirVDQ6ylygOVdylOuNl+P4yN4n/xo0czCD4R9QwsSZFRzKzyvA6O3tTluAlj
         pn6y43/p1EEnIFo/RYsXYgfja7Qb9QKz9E74YUMoh7abxd1UlBCz/et6LbCS3/vOjpKE
         QvCEgdf4C5loAtaOMQFXAf5V8kJ0csTu34tyKZHhpcsJ8/uW/fg+UdQZmuNfW8b/QmfL
         VqUqJHj83qFI3D2tr3ugl6pFOW5QIL+F8aTJSc7t+RGba9JjfWRe06kgkWJFIqOIkfDz
         2rMw==
X-Gm-Message-State: ABy/qLYUkeMTCIfDx955cuoFs5JmiLmYYil4nGT5sB5gXvv+NOk7JSBg
        XfSiH8V3GsRyEom8ApnSNDOMbQ==
X-Google-Smtp-Source: APBJJlEhWyNGqyocM6AhI4dDvZ283TDQ98noWRDU/Sd8MeLvAMT4j5NoEl1+zxyMozTcufNiF0xkug==
X-Received: by 2002:a05:6512:230e:b0:4fb:9e1a:e592 with SMTP id o14-20020a056512230e00b004fb9e1ae592mr6272439lfu.4.1690207595358;
        Mon, 24 Jul 2023 07:06:35 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 16:06:30 +0200
Subject: [PATCH v2 4/7] dt-bindings: interconnect: qcom: Fix and separate
 out MSM8996
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v2-4-e33d5acbf3bd@linaro.org>
References: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=6848;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QDEI6Sb98whTXz4RR85RkJ/E6rSVXmsPchXZMmzX0g8=;
 b=PO497tZUlELC9HCQFTcHw2KURjUPrTKa5kd5VuYKSpu7MwWA6OBtUMRshsDBTESHUmaZoOA/B
 X/llGnfOsDMAJEm63fuhESig7Th4B1SX5NvQbC0zhk+JYQWTfGJ37ov
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out MSM8996 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8996.yaml        | 126 +++++++++++++++++++++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  81 -------------
 2 files changed, 126 insertions(+), 81 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml
new file mode 100644
index 000000000000..e3f964aaad1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8996.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8996 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm MSM8996 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8996-a0noc
+      - qcom,msm8996-a1noc
+      - qcom,msm8996-a2noc
+      - qcom,msm8996-bimc
+      - qcom,msm8996-cnoc
+      - qcom,msm8996-mnoc
+      - qcom,msm8996-pnoc
+      - qcom,msm8996-snoc
+
+  reg:
+    maxItems: 1
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8996-a0noc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Aggregate0 System NoC AXI Clock.
+            - description: Aggregate0 Config NoC AHB Clock.
+            - description: Aggregate0 NoC MPU Clock.
+
+        clock-names:
+          items:
+            - const: aggre0_snoc_axi
+            - const: aggre0_cnoc_ahb
+            - const: aggre0_noc_mpu_cfg
+
+      required:
+        - power-domains
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8996-mnoc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: CPU-NoC High-performance Bus Clock.
+
+        clock-names:
+          const: iface
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8996-a2noc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Aggregate2 NoC UFS AXI Clock
+            - description: UFS AXI Clock
+
+        clock-names:
+          items:
+            - const: aggre2_ufs_axi
+            - const: ufs_axi
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    bimc: interconnect@408000 {
+        compatible = "qcom,msm8996-bimc";
+        reg = <0x00408000 0x5a000>;
+        #interconnect-cells = <1>;
+    };
+
+    a0noc: interconnect@543000 {
+        compatible = "qcom,msm8996-a0noc";
+        reg = <0x00543000 0x6000>;
+        #interconnect-cells = <1>;
+        clocks = <&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
+                 <&gcc GCC_AGGRE0_CNOC_AHB_CLK>,
+                 <&gcc GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK>;
+        clock-names = "aggre0_snoc_axi",
+                      "aggre0_cnoc_ahb",
+                      "aggre0_noc_mpu_cfg";
+        power-domains = <&gcc AGGRE0_NOC_GDSC>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 59895cca6a8c..3e1bcbbdb532 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -26,14 +26,6 @@ properties:
       - qcom,msm8939-bimc
       - qcom,msm8939-pcnoc
       - qcom,msm8939-snoc
-      - qcom,msm8996-a0noc
-      - qcom,msm8996-a1noc
-      - qcom,msm8996-a2noc
-      - qcom,msm8996-bimc
-      - qcom,msm8996-cnoc
-      - qcom,msm8996-mnoc
-      - qcom,msm8996-pnoc
-      - qcom,msm8996-snoc
       - qcom,qcs404-bimc
       - qcom,qcs404-pcnoc
       - qcom,qcs404-snoc
@@ -109,11 +101,6 @@ allOf:
               - qcom,msm8939-bimc
               - qcom,msm8939-pcnoc
               - qcom,msm8939-snoc
-              - qcom,msm8996-a1noc
-              - qcom,msm8996-bimc
-              - qcom,msm8996-cnoc
-              - qcom,msm8996-pnoc
-              - qcom,msm8996-snoc
               - qcom,qcs404-bimc
               - qcom,qcs404-pcnoc
               - qcom,qcs404-snoc
@@ -130,74 +117,6 @@ allOf:
             - description: Bus Clock
             - description: Bus A Clock
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8996-mnoc
-
-    then:
-      properties:
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-            - const: iface
-
-        clocks:
-          items:
-            - description: Bus Clock.
-            - description: Bus A Clock.
-            - description: CPU-NoC High-performance Bus Clock.
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8996-a0noc
-
-    then:
-      properties:
-        clock-names:
-          items:
-            - const: aggre0_snoc_axi
-            - const: aggre0_cnoc_ahb
-            - const: aggre0_noc_mpu_cfg
-
-        clocks:
-          items:
-            - description: Aggregate0 System NoC AXI Clock.
-            - description: Aggregate0 Config NoC AHB Clock.
-            - description: Aggregate0 NoC MPU Clock.
-
-      required:
-        - power-domains
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8996-a2noc
-
-    then:
-      properties:
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-            - const: aggre2_ufs_axi
-            - const: ufs_axi
-
-        clocks:
-          items:
-            - description: Bus Clock
-            - description: Bus A Clock
-            - description: Aggregate2 NoC UFS AXI Clock
-            - description: UFS AXI Clock
-
   - if:
       not:
         properties:

-- 
2.41.0

