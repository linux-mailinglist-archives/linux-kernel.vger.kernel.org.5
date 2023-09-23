Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D667AC2ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjIWPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjIWPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:01:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E5D19A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6769so7931125e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695481252; x=1696086052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0JcmES5eq6i+P6K3jjeZcZW1E/M9HeojX8j4CGEfZ4=;
        b=dA7j5pkBoE0ODqObeelRJ90/7ByBlzfg2nPXoERCyZx6YywHvma3a9T2STWWNDBKTu
         ejp9L6lZaNEbe0oyXKfwRxMEyvjdrhZ76YPkpar/H5k0b6DmsPbliXnmaBQnozOOfncY
         MM+rf42ZDzPaSKcKImFowkXpoGAN1pQ86Wc0oYM745WhG9U8g49smcK5WyNTPN2YVPVw
         Z+TWdfSkkw33aUCPqyJDwRWVMXjW6dSo6/Vyoc3aRJDVhsZbofY/zvOZpDdZVhKxN+Ru
         7o56FmmVvEEP/sRXnN4gckLHcdchnaM7FAYTxHtEKeaoygNQfEyu+Drv2TpETO/yjRSg
         fngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481252; x=1696086052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0JcmES5eq6i+P6K3jjeZcZW1E/M9HeojX8j4CGEfZ4=;
        b=UGiEeyqJORbZw5Tuf0m1STIj97GFHHo7pwa8YsrNt6Fls3LpuiJKyjB9JaWMKR1dqy
         KMaiHZdZBtgu4CB2FQ4CMcU0E/X+kxy2ErRMphQ5eoCS8wIRWPN3C0xySLfFXZpZt743
         jpUJy3y9V2Myo+2jTZF8rQMtYrizvu9CuM/IPCi1uvY4Sr5/69AKaJ9JgTqQi0ug/ewu
         9U30XZQKpxar4YygepFPAi3sHXQwemdi6csVipWYM86NQV3MksL9r5QSb7FDHLSQCQPx
         n+FWy21Os+EOADwO/x06CfmAtSkgZEEjhgUIi7d6f7L3j2WQCA5f/7vi2ri/rWsVSHMe
         trhw==
X-Gm-Message-State: AOJu0YyCTZ9D8J8roHgZxmKpyECc/GseEKzy9TrwG0T61aJp6ylKUep+
        56O0TEMtCw31r2v7G30IYkmjog==
X-Google-Smtp-Source: AGHT+IGyhh5rCri/EL77QPBtIrU3OoeY8jyaVydBZfR795IyQuYjkCBZA4MCM+eZ+3MdjrL95Ml0LQ==
X-Received: by 2002:a05:600c:501e:b0:405:2d29:1648 with SMTP id n30-20020a05600c501e00b004052d291648mr4220649wmr.19.1695481251911;
        Sat, 23 Sep 2023 08:00:51 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004053a2138bfsm5787006wms.12.2023.09.23.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 08:00:51 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 1/4] dt-bindings: clock: qcom,camcc.yaml: Convert qcom,camcc to a single yaml file
Date:   Sat, 23 Sep 2023 16:00:42 +0100
Message-Id: <20230923150045.1068556-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
References: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the various camcc yaml files into one. The Camera Clock Controller
is pretty similar from SoC to SoC.

Mostly we have some SoCs which require fewer clocks than others. In some
cases we have SoCs which have required-opps and required-power-domains.

It is likely we could and should extend the thin CAMCC descriptions such
as sdm845 an sm6350 to the more robust descriptions such as sm8250 and
sm8450.

As a result of listing sm8250 and sm8450 together required-opps and
power-domains become required for sm8250, which is a NOP for the dtsi
since both declarations already exist for sm8250.

sm8250 is also chosen as the example for the new combined camcc.yaml.

A minor tweak to fix Bjorn's email address in the Maintainer list is
included.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/clock/qcom,camcc-sm8250.yaml     |  84 ---------
 .../devicetree/bindings/clock/qcom,camcc.yaml | 171 ++++++++++++++++++
 .../bindings/clock/qcom,sc7180-camcc.yaml     |  72 --------
 .../bindings/clock/qcom,sc7280-camcc.yaml     |  71 --------
 .../bindings/clock/qcom,sdm845-camcc.yaml     |  65 -------
 .../bindings/clock/qcom,sm6350-camcc.yaml     |  49 -----
 .../bindings/clock/qcom,sm8450-camcc.yaml     |  85 ---------
 7 files changed, 171 insertions(+), 426 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
deleted file mode 100644
index 426335a2841c..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
+++ /dev/null
@@ -1,84 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,camcc-sm8250.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Camera Clock & Reset Controller on SM8250
-
-maintainers:
-  - Jonathan Marek <jonathan@marek.ca>
-
-description: |
-  Qualcomm camera clock control module provides the clocks, resets and
-  power domains on SM8250.
-
-  See also:: include/dt-bindings/clock/qcom,camcc-sm8250.h
-
-properties:
-  compatible:
-    const: qcom,sm8250-camcc
-
-  clocks:
-    items:
-      - description: AHB
-      - description: Board XO source
-      - description: Board active XO source
-      - description: Sleep clock source
-
-  clock-names:
-    items:
-      - const: iface
-      - const: bi_tcxo
-      - const: bi_tcxo_ao
-      - const: sleep_clk
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  power-domains:
-    items:
-      - description: MMCX power domain
-
-  reg:
-    maxItems: 1
-
-  required-opps:
-    maxItems: 1
-    description:
-      OPP node describing required MMCX performance point.
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    clock-controller@ad00000 {
-      compatible = "qcom,sm8250-camcc";
-      reg = <0x0ad00000 0x10000>;
-      clocks = <&gcc GCC_CAMERA_AHB_CLK>,
-               <&rpmhcc RPMH_CXO_CLK>,
-               <&rpmhcc RPMH_CXO_CLK_A>,
-               <&sleep_clk>;
-      clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
new file mode 100644
index 000000000000..81807b8e0d24
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Jonathan Marek <jonathan@marek.ca>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also:: include/dt-bindings/clock/qcom,camcc-sc7180.h
+  See also:: include/dt-bindings/clock/qcom,camcc-sc7280.h
+  See also:: include/dt-bindings/clock/qcom,camcc-sdm845.h
+  See also:: include/dt-bindings/clock/qcom,camcc-sm8250.h
+  See also:: include/dt-bindings/clock/qcom,sm6350-camcc.h
+  See also:: include/dt-bindings/clock/qcom,sm8450-camcc.h
+  See also:: include/dt-bindings/clock/qcom,sm8550-camcc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7180-camcc
+      - qcom,sc7280-camcc
+      - qcom,sdm845-camcc
+      - qcom,sm6350-camcc
+      - qcom,sm8250-camcc
+      - qcom,sm8450-camcc
+      - qcom,sm8550-camcc
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+
+  reg:
+    maxItems: 1
+
+  required-opps:
+    maxItems: 1
+    description:
+      OPP node describing required MMCX performance point.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7180-camcc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Camera_ahb clock from GCC
+            - description: Camera XO clock from GCC
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: iface
+            - const: xo
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sdm845-camcc
+            - qcom,sm6350-camcc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+        clock-names:
+          items:
+            - const: bi_tcxo
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7280-camcc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board XO active source
+            - description: Sleep clock source
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+            - const: sleep_clk
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8250-camcc
+            - qcom,sm8450-camcc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: AHB
+            - description: Board XO source
+            - description: Board active XO source
+            - description: Sleep clock source
+        clock-names:
+          items:
+            - const: iface
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+            - const: sleep_clk
+      required:
+        - power-domains
+        - required-opps
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@ad00000 {
+      compatible = "qcom,sm8250-camcc";
+      reg = <0x0ad00000 0x10000>;
+      clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>;
+      clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
deleted file mode 100644
index 2dfc2a4f1918..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
+++ /dev/null
@@ -1,72 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sc7180-camcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Camera Clock & Reset Controller on SC7180
-
-maintainers:
-  - Taniya Das <quic_tdas@quicinc.com>
-
-description: |
-  Qualcomm camera clock control module provides the clocks, resets and power
-  domains on SC7180.
-
-  See also:: include/dt-bindings/clock/qcom,camcc-sc7180.h
-
-properties:
-  compatible:
-    const: qcom,sc7180-camcc
-
-  clocks:
-    items:
-      - description: Board XO source
-      - description: Camera_ahb clock from GCC
-      - description: Camera XO clock from GCC
-
-  clock-names:
-    items:
-      - const: bi_tcxo
-      - const: iface
-      - const: xo
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    clock-controller@ad00000 {
-      compatible = "qcom,sc7180-camcc";
-      reg = <0x0ad00000 0x10000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>,
-               <&gcc GCC_CAMERA_AHB_CLK>,
-               <&gcc GCC_CAMERA_XO_CLK>;
-      clock-names = "bi_tcxo", "iface", "xo";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
deleted file mode 100644
index 01feef1cab0a..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
+++ /dev/null
@@ -1,71 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sc7280-camcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Camera Clock & Reset Controller on SC7280
-
-maintainers:
-  - Taniya Das <quic_tdas@quicinc.com>
-
-description: |
-  Qualcomm camera clock control module provides the clocks, resets and
-  power domains on SC7280.
-
-  See also:: include/dt-bindings/clock/qcom,camcc-sc7280.h
-
-properties:
-  compatible:
-    const: qcom,sc7280-camcc
-
-  clocks:
-    items:
-      - description: Board XO source
-      - description: Board XO active source
-      - description: Sleep clock source
-
-  clock-names:
-    items:
-      - const: bi_tcxo
-      - const: bi_tcxo_ao
-      - const: sleep_clk
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    clock-controller@ad00000 {
-      compatible = "qcom,sc7280-camcc";
-      reg = <0x0ad00000 0x10000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>,
-               <&rpmhcc RPMH_CXO_CLK_A>,
-               <&sleep_clk>;
-      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
deleted file mode 100644
index 91d1f7918037..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
+++ /dev/null
@@ -1,65 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sdm845-camcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Camera Clock & Reset Controller on SDM845
-
-maintainers:
-  - Bjorn Andersson <bjorn.andersson@linaro.org>
-
-description: |
-  Qualcomm camera clock control module provides the clocks, resets and power
-  domains on SDM845.
-
-  See also:: include/dt-bindings/clock/qcom,camcc-sm845.h
-
-properties:
-  compatible:
-    const: qcom,sdm845-camcc
-
-  clocks:
-    items:
-      - description: Board XO source
-
-  clock-names:
-    items:
-      - const: bi_tcxo
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    clock-controller@ad00000 {
-      compatible = "qcom,sdm845-camcc";
-      reg = <0x0ad00000 0x10000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>;
-      clock-names = "bi_tcxo";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
deleted file mode 100644
index fd6658cb793d..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
+++ /dev/null
@@ -1,49 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sm6350-camcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Camera Clock & Reset Controller on SM6350
-
-maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
-
-description: |
-  Qualcomm camera clock control module provides the clocks, resets and  power
-  domains on SM6350.
-
-  See also:: include/dt-bindings/clock/qcom,sm6350-camcc.h
-
-properties:
-  compatible:
-    const: qcom,sm6350-camcc
-
-  clocks:
-    items:
-      - description: Board XO source
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - clocks
-
-allOf:
-  - $ref: qcom,gcc.yaml#
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    clock-controller@ad00000 {
-      compatible = "qcom,sm6350-camcc";
-      reg = <0x0ad00000 0x16000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>;
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
deleted file mode 100644
index dc3c18e4ead7..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ /dev/null
@@ -1,85 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sm8450-camcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Camera Clock & Reset Controller on SM8450
-
-maintainers:
-  - Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
-
-description: |
-  Qualcomm camera clock control module provides the clocks, resets and power
-  domains on SM8450.
-
-  See also::
-    include/dt-bindings/clock/qcom,sm8450-camcc.h
-    include/dt-bindings/clock/qcom,sm8550-camcc.h
-
-properties:
-  compatible:
-    enum:
-      - qcom,sm8450-camcc
-      - qcom,sm8550-camcc
-
-  clocks:
-    items:
-      - description: Camera AHB clock from GCC
-      - description: Board XO source
-      - description: Board active XO source
-      - description: Sleep clock source
-
-  power-domains:
-    maxItems: 1
-    description:
-      A phandle and PM domain specifier for the MMCX power domain.
-
-  required-opps:
-    maxItems: 1
-    description:
-      A phandle to an OPP node describing required MMCX performance point.
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - power-domains
-  - required-opps
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom,rpmhpd.h>
-    clock-controller@ade0000 {
-      compatible = "qcom,sm8450-camcc";
-      reg = <0xade0000 0x20000>;
-      clocks = <&gcc GCC_CAMERA_AHB_CLK>,
-               <&rpmhcc RPMH_CXO_CLK>,
-               <&rpmhcc RPMH_CXO_CLK_A>,
-               <&sleep_clk>;
-      power-domains = <&rpmhpd RPMHPD_MMCX>;
-      required-opps = <&rpmhpd_opp_low_svs>;
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
-- 
2.40.1

