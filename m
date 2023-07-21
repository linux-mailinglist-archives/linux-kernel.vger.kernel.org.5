Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9175C880
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGUNyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjGUNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:54:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676FF30D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so28775021fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947667; x=1690552467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBUsteqLu7y8+xgr1TJou03mZFL/AZVahDAq950kxKE=;
        b=rjF47Th3/hRTDtMyoiSfusLRy39bct+VeR7dGUzA8U3wzLvbdq6BggiappuVyRStkQ
         woRrFxR5ng+TiR5PxGZ8+ulUBEEiwIcFp/XotNZuWe7NvFNZwoR6EZ7HArcQLF4ywx0h
         wX1zlFmH+KC/dSDrc8HRXnvh8SQV0/5sD6sMOHSu7ucRonVMEDk5rHf2SjTEOOcAaxf8
         JfWKSoM6anJ+LSxu0L9+Hj7UzCYWLaMmH4up69p5vZGnqguKOFAx23PjlT3VHtIzIDil
         DGB0awSXhBTb/dZSaKppt1r+FWXpVtC9k/dnSCqDKmXRKYayG3/cfX/YlPDWzotNDTG0
         a8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947667; x=1690552467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBUsteqLu7y8+xgr1TJou03mZFL/AZVahDAq950kxKE=;
        b=eviNDWhX1vFfyCQpzcgS4WK1HwQSEnTakp8e3xJ8rCudk7sqHlWhV/84QE78keV+V1
         W/0CK/5zm+gFI/wUsgE7GOIqhjYWbpECmkScZb0smvLyKUqX4RvqA5LIGT7wGPcFpYow
         FrRR6tz2niZeDwg9wdHFkPRN3N3zeFgvkV/6y7qw3YZeUWg7s/DJ9aDTATBoYShRI5mA
         dcBAX3W9G5Z+pKdh3G7mkmOEfmtgKcaPTW048VteeoLd41ix+/6I7pY2JX0b7qzFEVdF
         cXpPhgqtJsd8dqsipvqyx/8vHLfmt51ZWZWMLzf1CN801VUpdm+agZmSkX332Ka6+ih9
         lpZQ==
X-Gm-Message-State: ABy/qLYS5Sy3cTmXxrwNTCJUZFhY02fxbYyr3YYhUAsqu4ZjZQ1JIq2A
        VEDEdZ0GYUwJb2qk8ff1X60DyA==
X-Google-Smtp-Source: APBJJlHXXgj3BLIgzyOPCmokvIYAs7FTHU9urEnquOD67fGEIlob8jhC5MCYE8UzWCpkRT9zQKdQ7A==
X-Received: by 2002:a2e:918f:0:b0:2b9:4811:2b6 with SMTP id f15-20020a2e918f000000b002b9481102b6mr1644947ljg.48.1689947667418;
        Fri, 21 Jul 2023 06:54:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 15:54:15 +0200
Subject: [PATCH 5/7] dt-bindings: interconnect: qcom: Fix and separate out
 SDM660
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v1-5-93e2bc728fb7@linaro.org>
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=6388;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aIph4bDHvXEr+JTA974zl/DL90W6BaBG3UKW2IdvHQI=;
 b=H+lDdtOm5Q9CBZU5K7TQHbP+0H8cCp3axubc3Nsz0PSofl6P3mZR68vYjR9EaZ+L4EQhjowjs
 FbaZBLP9Xi5C5b/513gHtDWV4sQm+lVbJyCS/bNsFSPGBmZJnsTNowr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out SDM660 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  40 -------
 .../bindings/interconnect/qcom,sdm660.yaml         | 131 +++++++++++++++++++++
 2 files changed, 131 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 58075c23f9f9..00fe355f26de 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -31,12 +31,6 @@ properties:
       - qcom,msm8996-mnoc
       - qcom,msm8996-pnoc
       - qcom,msm8996-snoc
-      - qcom,sdm660-a2noc
-      - qcom,sdm660-bimc
-      - qcom,sdm660-cnoc
-      - qcom,sdm660-gnoc
-      - qcom,sdm660-mnoc
-      - qcom,sdm660-snoc
 
   '#interconnect-cells':
     description: |
@@ -111,10 +105,6 @@ allOf:
               - qcom,msm8996-cnoc
               - qcom,msm8996-pnoc
               - qcom,msm8996-snoc
-              - qcom,sdm660-bimc
-              - qcom,sdm660-cnoc
-              - qcom,sdm660-gnoc
-              - qcom,sdm660-snoc
 
     then:
       properties:
@@ -134,7 +124,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8996-mnoc
-              - qcom,sdm660-mnoc
 
     then:
       properties:
@@ -197,35 +186,6 @@ allOf:
             - description: Aggregate2 NoC UFS AXI Clock
             - description: UFS AXI Clock
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sdm660-a2noc
-
-    then:
-      properties:
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-            - const: ipa
-            - const: ufs_axi
-            - const: aggre2_ufs_axi
-            - const: aggre2_usb3_axi
-            - const: cfg_noc_usb2_axi
-
-        clocks:
-          items:
-            - description: Bus Clock.
-            - description: Bus A Clock.
-            - description: IPA Clock.
-            - description: UFS AXI Clock.
-            - description: Aggregate2 UFS AXI Clock.
-            - description: Aggregate2 USB3 AXI Clock.
-            - description: Config NoC USB2 AXI Clock.
-
   - if:
       not:
         properties:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
new file mode 100644
index 000000000000..29b1a1987642
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM660 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm SDM660 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm660-a2noc
+      - qcom,sdm660-bimc
+      - qcom,sdm660-cnoc
+      - qcom,sdm660-gnoc
+      - qcom,sdm660-mnoc
+      - qcom,sdm660-snoc
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+
+  clocks:
+    minItems: 1
+    maxItems: 5
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
+          const: qcom,sdm660-mnoc
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
+          const: qcom,sdm660-a2noc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: IPA Clock.
+            - description: UFS AXI Clock.
+            - description: Aggregate2 UFS AXI Clock.
+            - description: Aggregate2 USB3 AXI Clock.
+            - description: Config NoC USB2 AXI Clock.
+
+        clock-names:
+          items:
+            - const: ipa
+            - const: ufs_axi
+            - const: aggre2_ufs_axi
+            - const: aggre2_usb3_axi
+            - const: cfg_noc_usb2_axi
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm660.h>
+    #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    bimc: interconnect@1008000 {
+        compatible = "qcom,sdm660-bimc";
+        reg = <0x01008000 0x78000>;
+        #interconnect-cells = <1>;
+    };
+
+    cnoc: interconnect@1500000 {
+        compatible = "qcom,sdm660-cnoc";
+        reg = <0x01500000 0x10000>;
+        #interconnect-cells = <1>;
+    };
+
+    snoc: interconnect@1626000 {
+        compatible = "qcom,sdm660-snoc";
+        reg = <0x01626000 0x7090>;
+        #interconnect-cells = <1>;
+    };
+
+    a2noc: interconnect@1704000 {
+        compatible = "qcom,sdm660-a2noc";
+        reg = <0x01704000 0xc100>;
+        #interconnect-cells = <1>;
+        clocks = <&rpmcc RPM_SMD_IPA_CLK>,
+                 <&gcc GCC_UFS_AXI_CLK>,
+                 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+                 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+                 <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
+        clock-names = "ipa",
+                      "ufs_axi",
+                      "aggre2_ufs_axi",
+                      "aggre2_usb3_axi",
+                      "cfg_noc_usb2_axi";
+    };
+
+    mnoc: interconnect@1745000 {
+        compatible = "qcom,sdm660-mnoc";
+        reg = <0x01745000 0xa010>;
+        #interconnect-cells = <1>;
+        clocks = <&mmcc AHB_CLK_SRC>;
+        clock-names = "iface";
+    };
+
+    gnoc: interconnect@17900000 {
+        compatible = "qcom,sdm660-gnoc";
+        reg = <0x17900000 0xe000>;
+        #interconnect-cells = <1>;
+    };

-- 
2.41.0

