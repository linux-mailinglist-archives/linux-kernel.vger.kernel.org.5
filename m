Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8041075F951
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGXOGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGXOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:06:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3FE71
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so6651803e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207594; x=1690812394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14RYrA+DRfRZwGnHOiBo6ifPBzeHttf2sq1Rsh4mMxk=;
        b=p0/i6H/phcRd2qdsCRj9GAHPvqYRPtlYVVBxq1dgP+4Q9LdSY7tCICgXT+Zso/oa1G
         g1UMR9jlgV9RHiDi/K9iTzpyjeLBx1N5S60BMRstkrbQr9Byz1+WC43sa/BjjVwXHK3e
         yGVMRh/GgXPLZUhjMljgW90KPC5uMqp/tC0zYUOaAr0pIVPOciX+QrBQUJ+nxPhdWb1x
         VIfm5F6ZjlVmK075fKO1vypsHQmz1Nah/0/Zq9yAx11gTh+pw2WuCvuMFZnKhmlJrWFh
         vDoLNogtWywQaFtiKriNQKfOvbXWJH+6nbhmBfoQjguyMg/BQH6lZ32w7BRHUfvnuext
         OZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207594; x=1690812394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14RYrA+DRfRZwGnHOiBo6ifPBzeHttf2sq1Rsh4mMxk=;
        b=dg1pyZ1FUAwaQKWQIdjFlHIv5KUR6nn3dE0yYLqWhX7M6l1PwB2aXUIdHrpDeNdrdQ
         a1JdEuO/kzHBPwiXuCUTcf70agA+/Bq0f5LELYS+NznfY3vWDYybBdjcQWxA+cVe64BT
         0u0TaFCWs82TCvUaJgw7EX4n+2/cLhRN+SANK9JM07tfLt/yw5KvcLT3R+wPNIG0/cga
         hkq3HOVeliBtttAPnQuJRPD32XZ3J2v/McyWGeStIhkdd+HMa3SsWcVaeegHjYzDMcMr
         yJcVjxA9v3U+9WrQplSw1wqZ4iTXIxnvmWtb68pcM5Xd4lta6gSnHRRYYUu14PyfyjMy
         nu/g==
X-Gm-Message-State: ABy/qLbWG85wWs/7SG7uDjKRJC0GxOO8PacS3+OyCPZllm64y3MEGM0P
        DITVMRhw/2x7EvdFQrGa9Gcyxg==
X-Google-Smtp-Source: APBJJlHIBg0VThBi3/p2NGTTvra/Qh5ebG0HFSU5uDIOF4a/++1Yz8fOLXgtfGnu/M7P/h38syshkQ==
X-Received: by 2002:a19:7708:0:b0:4fd:b223:92c with SMTP id s8-20020a197708000000b004fdb223092cmr4433046lfc.60.1690207593955;
        Mon, 24 Jul 2023 07:06:33 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 16:06:29 +0200
Subject: [PATCH v2 3/7] dt-bindings: interconnect: qcom: Fix and separate
 out SDM660
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v2-3-e33d5acbf3bd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=5684;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Q3+njg77nmTQFCS6ZK0ldMDDkYg/P1OjNOZNfVV/stI=;
 b=8CAV+FSysiZniRcfnwoUSVbJhgjcvy3HrIAu82LTP2kT83Q1C850deI158UHMpyepyoBispll
 lneLZG2/l7pAIj8GOJ4suW0I0fErPyzeetQWQxMOzm9vj3/HLHHoQa7
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

Separate out SDM660 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  40 --------
 .../bindings/interconnect/qcom,sdm660.yaml         | 108 +++++++++++++++++++++
 2 files changed, 108 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 4f95d512012a..59895cca6a8c 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -37,12 +37,6 @@ properties:
       - qcom,qcs404-bimc
       - qcom,qcs404-pcnoc
       - qcom,qcs404-snoc
-      - qcom,sdm660-a2noc
-      - qcom,sdm660-bimc
-      - qcom,sdm660-cnoc
-      - qcom,sdm660-gnoc
-      - qcom,sdm660-mnoc
-      - qcom,sdm660-snoc
 
   '#interconnect-cells':
     description: |
@@ -123,10 +117,6 @@ allOf:
               - qcom,qcs404-bimc
               - qcom,qcs404-pcnoc
               - qcom,qcs404-snoc
-              - qcom,sdm660-bimc
-              - qcom,sdm660-cnoc
-              - qcom,sdm660-gnoc
-              - qcom,sdm660-snoc
 
     then:
       properties:
@@ -146,7 +136,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8996-mnoc
-              - qcom,sdm660-mnoc
 
     then:
       properties:
@@ -209,35 +198,6 @@ allOf:
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
index 000000000000..8f6bc6399626
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -0,0 +1,108 @@
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
+  reg:
+    maxItems: 1
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

-- 
2.41.0

