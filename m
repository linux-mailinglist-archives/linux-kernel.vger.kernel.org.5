Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A847FA47D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjK0P3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjK0P26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:28:58 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF35B10A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:28:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50ba73196b1so3393602e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098937; x=1701703737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCPGBitG9/6KXdvU+lPUvXD7HIIGNEDSeEGVdElqkaM=;
        b=aATXXn5zw2+SiTVONWWSQn2wZSynq/ULHGaPjSxd8dCHxJNJxoEkvu9H9b1qP/9P8+
         0zt0I0Z0wA+wqotXrt+VDEf2SyxEBb8p6Nocd9hVDD5/i9HnFMyh3EvZF6UYI058fct0
         caLtApejpL6YcSybj1XVQlM70888nBebK6IWRnLhEZxOTau4A8To84F5QzJ35z9bC4WA
         9lStuVtgC2azDp6y47rtwKqFTRfp+1mCYB0vAyvSBkBgKA9zZJlmEbowubxc8WJ2rcKo
         93/Bd5MnhRWd7IB5jQv6LqVnOazGA4XPzBJH4faKVHAct76X1GtWbeQaQSxIHl3Tqj+j
         lbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098937; x=1701703737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCPGBitG9/6KXdvU+lPUvXD7HIIGNEDSeEGVdElqkaM=;
        b=jbDjLM19D+kG1Q0bTaK9d9q3adp8cOG1uWjlMTf1nxpI/OQ8qk4g3xdG4K0456ipmA
         Ssh/jC/stKK0QqcAxSKVMSSTqiuBwBHujnMYMSvGgOSG3Mui+Xem89nIt6TRMPCa7oOJ
         s7ERe7HhXqzlRP39LppFkCcdLXxz3EwtwbfxVHtIj32p02S8zFD+txwMreES0+BWLumr
         gJZeoY1lSg1LpWO+0JXMF23W0bwTsT0QBZtrc9x8pH52cK99kIzQ5/B0bNRxWEcxFJHQ
         hBwdE3uucMweH7de4w9c9wOi22YHlXNbR+IYiJ3/L+H+iqYihOAVkj1XtSKwfLb2FoT6
         qTFQ==
X-Gm-Message-State: AOJu0YxenU6jcihQ+/apr1WRv++IrbEkqjWXgnT9vMVmUhSqrNYGlW+9
        CpoYrMhk1MIvKpM+U8CX14yFwQ==
X-Google-Smtp-Source: AGHT+IH9HFjsaRyEGI/bPEJt0t/pme1c29F8+9ebs0nRfu5ekDAC+NwjiRH9hv37y5bc3wqPAZ2OmQ==
X-Received: by 2002:ac2:4344:0:b0:50b:aee8:bdfb with SMTP id o4-20020ac24344000000b0050baee8bdfbmr3090897lfl.2.1701098936988;
        Mon, 27 Nov 2023 07:28:56 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:28:56 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 16:28:42 +0100
Subject: [PATCH v2 02/12] dt-bindings: display: msm: Add reg bus and
 rotator interconnects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-2-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
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
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=10671;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AI8ujGLZlBaJZlOW2pjBLpvVqMuO/BaY4E8wkJtK6AM=;
 b=92JPSK9FgauS056u7gnbDz0tlni42SCYcsIB7205V/h69eeky/CTMVYu3yBn8m9nzQflpHtdq
 QkP37nctQDvDO4bHhFeyPD3umxJLk4TKtT6t5EUgXCgzknfSc2Ms6b/
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

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there are
other connection paths:
- a path that connects rotator block to the DDR.
- a path that needs to be handled to ensure MDSS register access
  functions properly, namely the "reg bus", a.k.a the CPU-MDSS CFG
  interconnect.

Describe these paths to allow using them in device trees and in the
driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[Konrad: rework for one vs two MDP paths, update examples]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/mdss-common.yaml   | 18 ++++++++++++++----
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml        | 14 ++++++++++----
 .../bindings/display/msm/qcom,sc7180-mdss.yaml         | 14 ++++++++++----
 .../bindings/display/msm/qcom,sc7280-mdss.yaml         | 14 ++++++++++----
 .../bindings/display/msm/qcom,sm6115-mdss.yaml         | 10 ++++++++++
 .../bindings/display/msm/qcom,sm6125-mdss.yaml         |  8 ++++++--
 .../bindings/display/msm/qcom,sm6350-mdss.yaml         |  8 ++++++--
 .../bindings/display/msm/qcom,sm6375-mdss.yaml         |  8 ++++++--
 .../bindings/display/msm/qcom,sm8450-mdss.yaml         | 13 ++++++++-----
 9 files changed, 80 insertions(+), 27 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index d71a8e09a798..f0cdb5422688 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -36,10 +36,14 @@ properties:
     maxItems: 2
 
   interconnects:
-    maxItems: 1
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 1
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -98,8 +102,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        interconnects = <&mmrt_virt MASTER_MDP0 &bimc SLAVE_EBI1>;
-        interconnect-names = "mdp0-mem";
+        interconnects = <&mmrt_virt MASTER_MDP0 &bimc SLAVE_EBI1>,
+                        <&bimc MASTER_APPSS_PROC &config_noc SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
 
         iommus = <&apps_smmu 0x420 0x2>,
                  <&apps_smmu 0x421 0x0>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
index 3432a2407caa..7a0555b15ddf 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
@@ -36,10 +36,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 1
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 1
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -106,8 +110,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>;
-        interconnect-names = "mdp0-mem";
+        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>,
+                        <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
 
         iommus = <&apps_smmu 0x800 0x2>;
         ranges;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
index bbb727831fca..2947f27e0585 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
@@ -36,10 +36,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 1
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 1
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -118,8 +122,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>;
-        interconnect-names = "mdp0-mem";
+        interconnects = <&mmss_noc MASTER_MDP0 &mc_virt SLAVE_EBI1>,
+                        <&gem_noc MASTER_APPSS_PROC &cnoc2 SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
 
         iommus = <&apps_smmu 0x900 0x402>;
         ranges;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index dde5c2acead5..309de1953c88 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -29,6 +29,16 @@ properties:
   iommus:
     maxItems: 2
 
+  interconnects:
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
index 671c2c2aa896..3deb9dc81c9c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
@@ -35,10 +35,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
index e1dcb453762e..c9ba1fae8042 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
@@ -35,10 +35,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
index b15c3950f09d..8e8a288d318c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -35,10 +35,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
index 001b26e65301..747a2e9665f4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
@@ -30,10 +30,10 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    maxItems: 3
 
   interconnect-names:
-    maxItems: 2
+    maxItems: 3
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -91,9 +91,12 @@ examples:
         reg = <0x0ae00000 0x1000>;
         reg-names = "mdss";
 
-        interconnects = <&mmss_noc MASTER_MDP_DISP 0 &mc_virt SLAVE_EBI1_DISP 0>,
-                        <&mmss_noc MASTER_MDP_DISP 0 &mc_virt SLAVE_EBI1_DISP 0>;
-        interconnect-names = "mdp0-mem", "mdp1-mem";
+        interconnects = <&mmss_noc MASTER_MDP_DISP &mc_virt SLAVE_EBI1_DISP>,
+                        <&mmss_noc MASTER_MDP_DISP &mc_virt SLAVE_EBI1_DISP>,
+                        <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_DISPLAY_CFG>;
+        interconnect-names = "mdp0-mem",
+                             "mdp1-mem",
+                             "cpu-cfg";
 
         resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 

-- 
2.43.0

