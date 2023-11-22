Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348A7F47FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjKVNmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjKVNm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:42:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5FD5C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:42:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00b056ca38so370425666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700660540; x=1701265340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BWOWZJ4bKKTaHvDdXp7NnJtygL/XFE5ozRJDhdsHlg=;
        b=ZrS1Y1vzGcBuK+b2wTXMV+uh+3azLkG0ftZqCKno6oT0mphIQE0GeGBGgoiXv0p7l+
         AXwtWHdmFOeNROoGpdNXiKybWKdoPt5aBUScWC+FoU/05iumT3dZubDc0AiUxqxD2aCr
         acOyqfy8vdqDne3gChaAEmcbXFWcYWVof36Gdma3vezBfUEMBJdNNCzoXZ32FvhSC34+
         d4hjpwwBJ+oJeo/YgsT7dq3F1yT4uePrYgKFgkqg0LJdkjiszyy7eRNV/aUbbJZCWmZM
         hT75DPgzocfXGLv/N+CYYVHOE/KTbLg/xAS96ii3zBGYkhOTICWdULrlqXS1ED8IaRPk
         lxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660540; x=1701265340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BWOWZJ4bKKTaHvDdXp7NnJtygL/XFE5ozRJDhdsHlg=;
        b=sJemT4yziyf1TCKrbmhhX9K+fQGvxKsJvyiRdGjA9eY7npq0zfvNeD3idayzifN+tW
         vmFZFJ1ACkC8ujSnAOdITxsyv6gZlKGbx5AYopG2R9nUHj45K4f3Nh6xtZPhMQi1/I+b
         NRACYsHw+DBJh0Y3NqqhZxHsYagnmN64BAmWCbe29cKAiZgHx9X3gLE5JhkD32xeZiLE
         khbLeASyACzb5VT9l+6JvqukAd9sDnqVzres+GN48mvP/Ob3mS4FG1NYe5R92/vBPTgE
         HrKmv+VBs7LdNnGebmF0WygseZmcqfLvPChdz5S2LMW2sWi78hFZesxCmOlslPrWhCor
         iO1g==
X-Gm-Message-State: AOJu0YzovjuwQb86mNVyarvueEi2eRuKRcH7kjr2ZZZcQp4vBV+HboLC
        R+4k9EPQGu0+LGfMx3xdq6FPcw==
X-Google-Smtp-Source: AGHT+IHKSnvRJnL0sSO4h5SVtYo5MxXvzsFAyXQ3kyjLuPM0Xi+Dlk0mOGgEwCYBXupDONo/5EzbuA==
X-Received: by 2002:a17:907:d38a:b0:a00:a591:929 with SMTP id vh10-20020a170907d38a00b00a00a5910929mr1860465ejc.24.1700660540106;
        Wed, 22 Nov 2023 05:42:20 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b009a19701e7b5sm6676797eje.96.2023.11.22.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:42:19 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 15:42:12 +0200
Subject: [PATCH 1/2] dt-bindings: clock: qcom: Document the X1E80100 TCSR
 Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-x1e80100-clk-tcsrcc-v1-1-43078c6d6452@linaro.org>
References: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org>
In-Reply-To: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ABrzOdHYRscdBJgZXnNOaPRIjzqaXUQAEaqk/uMwhbk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXgU3PRluQqdUeuBzlGbnF7n829L6a1tCWnvwM
 l1wl0OXeC6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV4FNwAKCRAbX0TJAJUV
 VtitD/9TZeupU1efniF1r1nYwFg6Coy5n1fYHyAkyNUxMDoU7aWqQHBf0QqPKbQ1RUC4HfGnQe+
 y/62OKh8F2Ok24X/oOZH/Bj2BaYoYzWDzVcrFssNssowTSMJ1ky2lUW/IJt6b0VGO1hHQaOFx0U
 RWqwWcJrlkTY4xfsRhKU7s3faWzQsWQLlE7mnS/pUQ1bJ1jB+O3UU9LAFPKoFnoWyRgPrfjopTg
 5cWvmF17Wo+QGrk//X3rh9kCzyg2uZbY4P6QBr5uUznskb8nNPjl7FrczqMW5c3u2GObbsJJdRO
 kmI3kt1xSnZ63yUSrnpX5XtslugIAwKVl66ALQE5Xtdcb9FOjxzLVJWzHqGp4yTFIbSmy0uZzcV
 JAEnq5DjJ1lqs1VMi24XncNZXl/nprtmF7uEsffpd1Baf7upISet2zqDygwAJjsDmieTzCjaWzK
 i5mHSYrSTTz0ghybcTKOhNwxefGozxfWwqYtXchlOu8zPZNTPtL0ncZmPCYVmuqp8aXN7KyRplM
 uLQarmeVBZHtklb8FpltnT52BI1g3CJhOqiJdG3WZoAH3lZkVwPh0xk45gKdySlodKgGBfpseoX
 UZYdrYXez2koW/TYgZf/es5eRtN1kGv/aF7exvXbWSl67NLA79qB8s8Z4WkqhGVDk8l/iWqTnCJ
 QiLGkhC3aLdHH+Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the X1E80100 TCSR Clock Controller.

Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,x1e80100-tcsr.yaml         | 55 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     | 23 +++++++++
 2 files changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,x1e80100-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,x1e80100-tcsr.yaml
new file mode 100644
index 000000000000..4adc8ee0287c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,x1e80100-tcsr.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,x1e80100-tcsr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TCSR Clock Controller on X1E80100
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm TCSR clock control module provides the clocks, resets and
+  power domains on X1E80100
+
+  See also:: include/dt-bindings/clock/qcom,x1e80100-tcsr.h
+
+properties:
+  compatible:
+    items:
+      - const: qcom,x1e80100-tcsr
+      - const: syscon
+
+  clocks:
+    items:
+      - description: TCXO pad clock
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    clock-controller@1fc0000 {
+      compatible = "qcom,x1e80100-tcsr", "syscon";
+      reg = <0x1fc0000 0x30000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,x1e80100-tcsr.h b/include/dt-bindings/clock/qcom,x1e80100-tcsr.h
new file mode 100644
index 000000000000..bae2c4654ee2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,x1e80100-tcsr.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_X1E80100_TCSR_CC_H
+#define _DT_BINDINGS_CLK_QCOM_X1E80100_TCSR_CC_H
+
+/* TCSR CC clocks */
+#define TCSR_PCIE_2L_4_CLKREF_EN				0
+#define TCSR_PCIE_2L_5_CLKREF_EN				1
+#define TCSR_PCIE_8L_CLKREF_EN					2
+#define TCSR_USB3_MP0_CLKREF_EN					3
+#define TCSR_USB3_MP1_CLKREF_EN					4
+#define TCSR_USB2_1_CLKREF_EN					5
+#define TCSR_UFS_PHY_CLKREF_EN					6
+#define TCSR_USB4_1_CLKREF_EN					7
+#define TCSR_USB4_2_CLKREF_EN					8
+#define TCSR_USB2_2_CLKREF_EN					9
+#define TCSR_PCIE_4L_CLKREF_EN					10
+#define TCSR_EDP_CLKREF_EN					11
+
+#endif

-- 
2.34.1

