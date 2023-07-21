Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B2F75C87B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGUNyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGUNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:54:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4352D46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9540031acso28696751fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947665; x=1690552465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COTS/QAzo5ItroUDDp1ljiZnm31YXIXNnO3NqsFfRYw=;
        b=y+8NMTdSEjosl0+VrEL2m6ZeT7xTsyDFr4cnLNNPVQTStO8jTr5rveshY4sV9P+frU
         CGt+3fWtG07MLhTsppsLp0wRDDQqLdOprHAgh1ObslLOSMeEjOP5DkX31/n+s0XkIE5v
         0P4Gde8n0aluwjlXivw2tckcWg/Sr+/U+0j2q3wW+y1TkdD4jnk4F1/aaPVxdx1ndq23
         raRIOjPsBGFw2JEzSH9FgL6i8PQSPzEdvnL9Vl4kOP0prIBoiMW5ZIX4tiu16VL0W3Jc
         xLQY8XAT8AiPF1kUso5hFR+aHXROKQo1bIaypG2iVZw49DgUI/QoAiJ0XvuKo0PB6Uns
         LNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947665; x=1690552465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COTS/QAzo5ItroUDDp1ljiZnm31YXIXNnO3NqsFfRYw=;
        b=S7hqvDq534YwN5Oh30V16I0TyIJrSkvienpQGM+lYBfMX+etjrhD0DNjR6YtZjx6oL
         E+mxED0Pje2xbWK5UO5Se7wvOZnOmH8MEHINsVp3UvWchyNnLTpOef6jl/sJSkql6lA5
         UtKlUMS8LrRdo84PlkpvTdbsCw8xINd2sbzPOcBmuYAEmb6fTVydzsNsourdEztVbvf9
         +c7frq1zOLf29QdpssLfbKkRheB54J+Iv96Lk/X2E7+bazpOvyaPaYcOBIOXffgTrvF1
         oW5tf08S61azI1n9VMSiA1NgoO33EuShZxM4e5NJnft7djxVkNx5ZvkHbdxfoSmV4ktG
         cQSQ==
X-Gm-Message-State: ABy/qLaq17JaKs5wWqxdo1H3Au7w1cJepfmMJF4NP+lRpvS14tiN9MM1
        R6O9CeaLjEI5ABPqOLT6hGFpzw==
X-Google-Smtp-Source: APBJJlE85ryxNMlu107A42OO0UvtGFEp8nSS1azwcvqukkajt3C6uFUSXFUlgEyB4/Mbv4Uv9itnnA==
X-Received: by 2002:a2e:6e07:0:b0:2b6:eefc:3e4f with SMTP id j7-20020a2e6e07000000b002b6eefc3e4fmr1625173ljc.21.1689947665464;
        Fri, 21 Jul 2023 06:54:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 15:54:14 +0200
Subject: [PATCH 4/7] dt-bindings: interconnect: qcom: Fix and separate out
 QCS404
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v1-4-93e2bc728fb7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=2986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yLJmYoQCZT249tBOoFu+9SOOzsVr7Zl0XM5AXz8MbsI=;
 b=le/7VScrw3t1YzGj0I8yE/857CPeEuZL18cQbdq51fPW5X5Obfb6+o2cnDr1kLn7bHyNuNfbK
 XQoOwyt50QsBbXbtwm8D4mUEio+W2fT4ZpGaVm7ymCNgMXdGo8GWUtL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out QCS404 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,qcs404.yaml         | 52 ++++++++++++++++++++++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  6 ---
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
new file mode 100644
index 000000000000..aff2daa55802
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,qcs404.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCS404 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm QCS404 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs404-bimc
+      - qcom,qcs404-pcnoc
+      - qcom,qcs404-snoc
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
+        compatible = "qcom,qcs404-snoc";
+        reg = <0x00580000 0x23080>;
+        #interconnect-cells = <1>;
+    };
+
+    pcnoc: interconnect@500000 {
+        compatible = "qcom,qcs404-pcnoc";
+        reg = <0x00500000 0x15080>;
+        #interconnect-cells = <1>;
+    };
+
+    bimc: interconnect@400000 {
+        compatible = "qcom,qcs404-bimc";
+        reg = <0x00400000 0x80000>;
+        #interconnect-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 788c5e88445a..58075c23f9f9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -31,9 +31,6 @@ properties:
       - qcom,msm8996-mnoc
       - qcom,msm8996-pnoc
       - qcom,msm8996-snoc
-      - qcom,qcs404-bimc
-      - qcom,qcs404-pcnoc
-      - qcom,qcs404-snoc
       - qcom,sdm660-a2noc
       - qcom,sdm660-bimc
       - qcom,sdm660-cnoc
@@ -114,9 +111,6 @@ allOf:
               - qcom,msm8996-cnoc
               - qcom,msm8996-pnoc
               - qcom,msm8996-snoc
-              - qcom,qcs404-bimc
-              - qcom,qcs404-pcnoc
-              - qcom,qcs404-snoc
               - qcom,sdm660-bimc
               - qcom,sdm660-cnoc
               - qcom,sdm660-gnoc

-- 
2.41.0

