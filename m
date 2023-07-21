Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD92975C883
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGUNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjGUNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:54:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DF30F2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b74310566cso29538631fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947669; x=1690552469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWkRcpOedeArCEscq2yxcc47EYJ2ymI/mFGN4ymylxQ=;
        b=yjqB2ejH0JTFcLFtXnkUneZGRe6r+jQjd/jBbk1oTsEKfwGSaoaMg1W6hsAWIpUOWx
         Xaknm8WI3qAQO/zLEnJJ7C3F50qc4ixmaRvoydocqkX9BUXmCWJUbvmKHkD2GGW5m4z1
         c5ISVev+1IzSvD8mlAOUkDpcAECT0K7MbACsc1lyX7KLHrifNm4Zf4TLDdtOWCLwKjzj
         4RN/VWCfv5T3LYtIUL5dAb+T8UqmcQnOYuiIjFPoaIW5995rBq5RHjP13YB/wGE4Mhid
         KlbQgUFm9De1lBTpmcim+BE7u4YZVP1KZXqdUrLruVONGMOxbDpHP6upMI4ln33FSe2b
         kVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947669; x=1690552469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWkRcpOedeArCEscq2yxcc47EYJ2ymI/mFGN4ymylxQ=;
        b=Z7Xbdj28FqXIyGL90vImrUq+MJMjdbHSj7ojI4NGW3TWn+bk+CCIuMEIPJm5z9zQQ7
         XVXrOKM/IelZrCzLUnnMeJMUwQX/T7DZihlBGwmi5AVXwP+HkeOdRpoL4zRkfK1p/TnC
         y2vin2Avb5b16KU6iC/Fsbo0oqRSfwWmgoCYtpERBFKtNfIdPYmgNxLdjlHz1bdCNUo2
         s/RqZJq/GaVeVmzsyG0VL7MaUiUrakibmuhXz0p5ZMk5/w/WnBZhUjUoKu2fhCweVfX/
         0heWfONpCb2lyO3v+uccUslnTtTQI4qkukOz6wYDu1s24FLKl7ZYP/93S00CBn9mXGxy
         MkLQ==
X-Gm-Message-State: ABy/qLZA+WlNf5wt2aai62jRoR489nx+HZKjSJ7qKvBoF2mM+e4SBtYr
        1bHRjFe5d2H49l7kzK1qeghRTw==
X-Google-Smtp-Source: APBJJlFzX8NvFeCGnp5Z6uexkXvl+ajqV5Bpc3yzOia4g9Dwpc4znJkXphgSPRXe7TSN2qOcH9JDwg==
X-Received: by 2002:a2e:86da:0:b0:2b6:efd0:5dd8 with SMTP id n26-20020a2e86da000000b002b6efd05dd8mr1634608ljj.46.1689947669377;
        Fri, 21 Jul 2023 06:54:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 15:54:16 +0200
Subject: [PATCH 6/7] dt-bindings: interconnect: qcom: Fix and separate out
 MSM8996
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v1-6-93e2bc728fb7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=7945;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PWu3a5dolgeEy3btNnyCZeLaOBqvgejanYJrTAWDhz4=;
 b=Nx+O8TB9iqeNL6qPuRipXL3ucY+bObWvrXPCWIhTMq9GING8aOc5bd+RHeA834Z7DCo9W/9rQ
 36ySWj50FqFB/9VltFGM5agtvQXe057i897XV6HDMdJMlQTXf+lJRdT
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

Separate out MSM8996 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8996.yaml        | 165 +++++++++++++++++++++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  81 ----------
 2 files changed, 165 insertions(+), 81 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml
new file mode 100644
index 000000000000..c003ca5ee746
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml
@@ -0,0 +1,165 @@
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
+    cnoc: interconnect@500000 {
+        compatible = "qcom,msm8996-cnoc";
+        reg = <0x00500000 0x1000>;
+        #interconnect-cells = <1>;
+    };
+
+    snoc: interconnect@524000 {
+        compatible = "qcom,msm8996-snoc";
+        reg = <0x00524000 0x1c000>;
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
+
+    a1noc: interconnect@562000 {
+        compatible = "qcom,msm8996-a1noc";
+        reg = <0x00562000 0x5000>;
+        #interconnect-cells = <1>;
+    };
+
+    a2noc: interconnect@583000 {
+        compatible = "qcom,msm8996-a2noc";
+        reg = <0x00583000 0x7000>;
+        clocks = <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+                 <&gcc GCC_UFS_AXI_CLK>;
+        clock-names = "aggre2_ufs_axi",
+                      "ufs_axi";
+        #interconnect-cells = <1>;
+    };
+
+    mnoc: interconnect@5a4000 {
+        compatible = "qcom,msm8996-mnoc";
+        reg = <0x005a4000 0x1c000>;
+        clocks = <&mmcc AHB_CLK_SRC>;
+        clock-names = "iface";
+        #interconnect-cells = <1>;
+    };
+
+    pnoc: interconnect@5c0000 {
+        compatible = "qcom,msm8996-pnoc";
+        reg = <0x005c0000 0x3000>;
+        #interconnect-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 00fe355f26de..6f8836312496 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -23,14 +23,6 @@ properties:
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
 
   '#interconnect-cells':
     description: |
@@ -100,11 +92,6 @@ allOf:
               - qcom,msm8939-bimc
               - qcom,msm8939-pcnoc
               - qcom,msm8939-snoc
-              - qcom,msm8996-a1noc
-              - qcom,msm8996-bimc
-              - qcom,msm8996-cnoc
-              - qcom,msm8996-pnoc
-              - qcom,msm8996-snoc
 
     then:
       properties:
@@ -118,74 +105,6 @@ allOf:
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

