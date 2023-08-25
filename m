Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B0E788E56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjHYSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjHYSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:14:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A1F271B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:13:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so18037551fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692987198; x=1693591998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuhapBp3CPAwUCh3zqvny55rPiH1liaha14zmfFzw5s=;
        b=kK3KWNiUDw5t6chwInYXJekOIqjN2XlJT3jUNEDg12YZIjcOH0N0REPmEDQQB4j4ln
         wSCj4yahtikhg39QP8oyVN+c9dx2BtYtxbMSIfj/m9zIE1VSlo26qQZcnQPPqBO7Qsav
         csuNBQh5F6tYz3jotH6cTbaW5zqiwx4t7TWIv4UBdQhYiccCG8feNafel/zrif51bc9P
         sXP0UsLmCli6RK/X56H5K5gKJKQNgjKAJG6bD4Vwo/j1g08imG2JjRoE1dReKPkwoQUB
         rItKu4jx+q2F7Q2uKDs2qXHvNckIuYBMLcixz3rZfw3ocoMAFSe1HmjML6vT7vG/vEoI
         L0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987198; x=1693591998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuhapBp3CPAwUCh3zqvny55rPiH1liaha14zmfFzw5s=;
        b=IK2fGEVCPmPeyZUk6tZLbWOD1XmT7FC8PCgvlGbFHJYKx7R8DUcE3LMFsbfPZjBqWO
         ehmJVjPzcdLHpzNY+UpSUeTdxL9sKXEiWwbYiE2z8Pw/4Wc5p1gjqs9FI4NlTHOTC0oX
         j1iDWDB2CHLfKrEaCPbIf8yWeSp85OYqVpcRL+QOUbJlVMT2ueKF4zNWQeM57A721Pt7
         3Rx4OkHfdKNxbe1cq3kSktbW01TcjcDxGlsrvf/oYKemaCR2pPtmLlx3nJWniRCpwoay
         7+fiYp8R1fR12iiz4d01odLVYTxe2CPi2pyGZg2C7cEKZQetnJla2jd7ha7nNSJI8gPI
         3IGw==
X-Gm-Message-State: AOJu0YyC0KQpYTCYp/VF6QbsZXKmPqkK3m8B3CyT4LrTCq4raEBORI1o
        1HJ28imG2mA2xvmY1eYO1ml0mg==
X-Google-Smtp-Source: AGHT+IE0U5BZSq1uRBeSg0n4P8ladgQa3d896q0eq0Hl6dGiC/o2r4u+vvVIh5JqDvN9PTYOw6l/tA==
X-Received: by 2002:a05:6512:685:b0:4ff:a23b:de26 with SMTP id t5-20020a056512068500b004ffa23bde26mr17269545lfe.52.1692987198250;
        Fri, 25 Aug 2023 11:13:18 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm374522lfp.9.2023.08.25.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:13:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 20:13:15 +0200
Subject: [PATCH 1/3] dt-bindings: clock: Add Qualcomm SM6115 LPASS clock
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-topic-6115_lpasscc-v1-1-d4857be298e3@linaro.org>
References: <20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org>
In-Reply-To: <20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692987195; l=2573;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kh9vya1fBXN+tmE3ghCrACqatGt7v3zCJwgqf69cR3I=;
 b=bLOWaz2hsvA0KJdAFLk4QotDopwVVfRABaHBZl9cJYQZPg3IO/qfdAtrMs3zeyaCJIMlmde/M
 LM4E4rtCFQGBHwrmGewBP4dQqaII4R4/yLtWrp7zybo1qZElRwbhoma
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115 (and its derivatives or similar SoCs) have a LPASS clock
controller block which provides audio-related resets.

Add bindings for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/clock/qcom,sm6115-lpasscc.yaml        | 53 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm6115-lpasscc.h    | 15 ++++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
new file mode 100644
index 000000000000..58ee84aed073
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6115-lpasscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS Core & Audio Clock Controller on SM6115
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm LPASS core and audio clock controllers provide audio-related resets
+  on SM6115 and its derivatives.
+
+  See also::
+    include/dt-bindings/clock/qcom,sm6115-lpasscc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-lpassaudiocc
+      - qcom,sm6115-lpasscc
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    lpass_audiocc: clock-controller@a6a9000 {
+        compatible = "qcom,sm6115-lpassaudiocc";
+        reg = <0x0a6a9000 0x1000>;
+        #reset-cells = <1>;
+    };
+
+  - |
+    lpasscc: clock-controller@a7ec000 {
+        compatible = "qcom,sm6115-lpasscc";
+        reg = <0x0a7ec000 0x1000>;
+        #reset-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6115-lpasscc.h b/include/dt-bindings/clock/qcom,sm6115-lpasscc.h
new file mode 100644
index 000000000000..799274517c9a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6115-lpasscc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SM6115_H
+#define _DT_BINDINGS_CLK_QCOM_LPASSCC_SM6115_H
+
+/* LPASS CC */
+#define LPASS_SWR_TX_CONFIG_CGCR		0
+
+/* LPASS_AUDIO CC */
+#define LPASS_AUDIO_SWR_RX_CGCR			0
+
+#endif

-- 
2.42.0

