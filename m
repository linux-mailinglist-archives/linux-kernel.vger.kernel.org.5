Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811C75C886
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGUNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGUNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:54:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D173595
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so28541321fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947671; x=1690552471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpX4cT8wPV+NQfH+IImmqD1hdn6km50iOH+4WrfJWg8=;
        b=yCjR6tdX/gl2oyIl+4eD24upwiujU/zwrEtEmDq9IctO0lYxoDiJ62S44TfIy3rcs/
         25WPeU5SQ4B5S+pT8cm/FnEA7lT3x6o55b13OdnkdyV0fSVMHULXeNb6Fw088OVHatqI
         vYJ36nZ0toihwf+93ttE8dB/uJDGTL4dxXo8ts8jJcS3CSKl5Jdmb3JIWKVW/DVsYLCA
         DxwjPGKbseCBqnLQG9xeVgDlCOz9lR3JTq9v4GGXUns6dmqGQdZQ1zcMGn941OQ7VobX
         GrZrHtsazHLRy4ilVc34BR2ML2iPOt+tvIcYBzK5nDfmnja1deulnuSrEddk+KFZ5WCR
         WVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947671; x=1690552471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpX4cT8wPV+NQfH+IImmqD1hdn6km50iOH+4WrfJWg8=;
        b=d3UkFGXWYGTocUuNE9ymjF7ikF3OT/AD22ZL2Z8P62ql2PJEdswAFHLSlyrIxkOiKs
         W8/ajqCl/fmVDJFzLK5EE7US/Bopf+yl488un+c/LZ8rC7E4+ic2y5NUrzRUjIrfMy8q
         hjK+EibXRLr+T8dSIDo6Jc6Y+iapS3gVNWIIPTDwpUlbkaF2EPFJlULC3FyMzeawxciq
         Ta5LoGT8BQ1Q6FKwTxFBA5wbk4pj9gDex+Z5g6HDyelluP96+YDPsIuFFWbYJgVYxcrQ
         9wFvYQvuk2XFlUMoPLc9sOfS4Uc/MboxCORlBCH74Py/TRAhG5AmA/F/qYfDZ4xPagmq
         R4JQ==
X-Gm-Message-State: ABy/qLaMx+/DCe3Cvq4aIb43evBe6NR16FAlVosuaP1YTRyfWnl41k1h
        evuhGASq8Z7UKRfaKfYvs1/FTQ==
X-Google-Smtp-Source: APBJJlHgIaRtr1McXoxhDuFZTQC/N+rwooAH0qB8pe7oyGzpGS4Qm+x0cQqulgqiXKZjxneBZ96Crw==
X-Received: by 2002:a2e:3806:0:b0:2b6:d326:156d with SMTP id f6-20020a2e3806000000b002b6d326156dmr1489191lja.19.1689947671167;
        Fri, 21 Jul 2023 06:54:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 15:54:17 +0200
Subject: [PATCH 7/7] dt-bindings: interconnect: qcom: Fix and separate out
 MSM8939
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v1-7-93e2bc728fb7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=7038;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IQUTBiDEvFP7VrKldMNLzy8w9qoar1n9X231aFtNUqQ=;
 b=wcAd3kkT91A4SpXAWDtGg37iM1f2Q2aFmD3WGys3R5+JHy+QiOY1VuRjx5V2J/qelS/7W7ZDN
 c1TYhlR6H2YA+UgNPNS6VGjuEU3fP6kbY8zEgmRCsvxnwpnu75XD1lJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out MSM8939 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

This was the final one, so also retire the shared file.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8939.yaml        |  74 ++++++++++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 156 ---------------------
 2 files changed, 74 insertions(+), 156 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
new file mode 100644
index 000000000000..00378c1ef9d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8939 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm MSM8939 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8939-bimc
+      - qcom,msm8939-pcnoc
+      - qcom,msm8939-snoc
+
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    $ref: qcom,rpm-common.yaml#
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    properties:
+      compatible:
+        const: qcom,msm8939-snoc-mm
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    snoc: interconnect@580000 {
+        compatible = "qcom,msm8939-snoc";
+        reg = <0x00580000 0x14000>;
+        #interconnect-cells = <1>;
+    };
+
+    pcnoc: interconnect@500000 {
+        compatible = "qcom,msm8939-pcnoc";
+        reg = <0x00500000 0x11000>;
+        #interconnect-cells = <1>;
+    };
+
+    bimc: interconnect@400000 {
+        compatible = "qcom,msm8939-bimc";
+        reg = <0x00400000 0x62000>;
+        #interconnect-cells = <1>;
+
+          snoc_mm: interconnect-snoc {
+              compatible = "qcom,msm8939-snoc-mm";
+              #interconnect-cells = <1>;
+          };
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
deleted file mode 100644
index 6f8836312496..000000000000
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ /dev/null
@@ -1,156 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/interconnect/qcom,rpm.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm RPM Network-On-Chip Interconnect
-
-maintainers:
-  - Georgi Djakov <georgi.djakov@linaro.org>
-
-description: |
-  RPM interconnect providers support system bandwidth requirements through
-  RPM processor. The provider is able to communicate with the RPM through
-  the RPM shared memory device.
-
-properties:
-  reg:
-    maxItems: 1
-
-  compatible:
-    enum:
-      - qcom,msm8939-bimc
-      - qcom,msm8939-pcnoc
-      - qcom,msm8939-snoc
-
-  '#interconnect-cells':
-    description: |
-      Value: <1> is one cell in an interconnect specifier for the
-      interconnect node id, <2> requires the interconnect node id and an
-      extra path tag.
-    enum: [ 1, 2 ]
-
-  clocks:
-    minItems: 2
-    maxItems: 7
-
-  clock-names:
-    minItems: 2
-    maxItems: 7
-
-  power-domains:
-    maxItems: 1
-
-# Child node's properties
-patternProperties:
-  '^interconnect-[a-z0-9]+$':
-    type: object
-    additionalProperties: false
-    description:
-      snoc-mm is a child of snoc, sharing snoc's register address space.
-
-    properties:
-      compatible:
-        enum:
-          - qcom,msm8939-snoc-mm
-
-      '#interconnect-cells':
-        const: 1
-
-      clock-names:
-        items:
-          - const: bus
-          - const: bus_a
-
-      clocks:
-        items:
-          - description: Bus Clock
-          - description: Bus A Clock
-
-    required:
-      - compatible
-      - '#interconnect-cells'
-      - clock-names
-      - clocks
-
-required:
-  - compatible
-  - reg
-  - '#interconnect-cells'
-  - clock-names
-  - clocks
-
-additionalProperties: false
-
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8939-bimc
-              - qcom,msm8939-pcnoc
-              - qcom,msm8939-snoc
-
-    then:
-      properties:
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-
-        clocks:
-          items:
-            - description: Bus Clock
-            - description: Bus A Clock
-
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,msm8939-snoc
-    then:
-      patternProperties:
-        '^interconnect-[a-z0-9]+$': false
-
-examples:
-  - |
-      #include <dt-bindings/clock/qcom,rpmcc.h>
-
-      bimc: interconnect@400000 {
-              compatible = "qcom,msm8939-bimc";
-              reg = <0x00400000 0x62000>;
-              #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
-      };
-
-      pcnoc: interconnect@500000 {
-              compatible = "qcom,msm8939-pcnoc";
-              reg = <0x00500000 0x11000>;
-              #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
-                       <&rpmcc RPM_SMD_PCNOC_A_CLK>;
-      };
-
-      snoc: interconnect@580000 {
-              compatible = "qcom,msm8939-snoc";
-              reg = <0x00580000 0x14080>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
-              #interconnect-cells = <1>;
-
-              snoc_mm: interconnect-snoc {
-                      compatible = "qcom,msm8939-snoc-mm";
-                      clock-names = "bus", "bus_a";
-                      clocks = <&rpmcc RPM_SMD_SYSMMNOC_CLK>,
-                               <&rpmcc RPM_SMD_SYSMMNOC_A_CLK>;
-                      #interconnect-cells = <1>;
-              };
-      };

-- 
2.41.0

