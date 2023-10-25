Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168B7D6315
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjJYHdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjJYHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:33:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A081BFD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9338e4695so74988981fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219170; x=1698823970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AocvxGueiEexObIYlW8G4lzpApouq1JKQv+F3M0Q/NM=;
        b=xePiQB2Lx5pkbPtJz5oVZalDpPhI85kwME4GkKOK7q0UP8me/MnYBibN7TebWc4XOD
         xJQECJ8AMDCQ9l9c9+7gB5a0OWB+tKw6aux0/KgYN+QMPPHt9x+35mmM35tJIFmWQ7S1
         9ob+ik3fqWXCPQ5Zc32xf4KQmnfhXdv1to3J73MiOa70p4ItjtIqmpnH6VsH07cYzI2U
         wb72EekLRH088WisT40f4mPGsB/ZnsHM2mNozgMe5uwJUSot2HL24Z87HoiPKb4huOSp
         ZriG949lGcI07ge1qXEyB5YsueIOKJCda6tTBoJFDnYzEM01o20Y5kyzCII+o2Ynn4pQ
         HRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219170; x=1698823970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AocvxGueiEexObIYlW8G4lzpApouq1JKQv+F3M0Q/NM=;
        b=VXVOZYSNia4NQD8pxj1e8ZmwFMB1U7nlTVjhT4nyhYoAKnJYVYr1YDZqMmsFXCtRb6
         pjnRP0E6QVOBl/oaQlW6q7c1B10JhwQkBTQ06sU2iIkR0sGUhLftPptoH6J9VPkM3/1E
         S2ptb2Ga0vS52E03ZuB80beUEkiPZoYGRJJVXmDCtVMPs2BtbHYSRXkuZON34/XX3Hzb
         c8mW1/xd4rHKMbkif1Pl7TV/DN4kWNDJwRGHT6/pt3QTO202wSdm6m236L2eOIjgPSvV
         +4hJGn3neI7GPNG80E8WHcEjrua52qZIycNiQMrCeG4eIt6zGNKH+7sCDeiV0Uur6LVJ
         CHyw==
X-Gm-Message-State: AOJu0YytHObqd1oITI+hc8dbYb8XJY20LFOsnSYdZCfKy/Zzr0CMnatX
        GcRqmEm8RuOsBaYjIitDNxRECg==
X-Google-Smtp-Source: AGHT+IHdIRNzxwor/7VjG9XtS/e+/cJMLaI6U5B5ubfIjfx1hFczFJFRWZBYoCfJq3yiNsVPeUn/WA==
X-Received: by 2002:a2e:be9d:0:b0:2c5:3090:537c with SMTP id a29-20020a2ebe9d000000b002c53090537cmr11732742ljr.17.1698219170316;
        Wed, 25 Oct 2023 00:32:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c15d200b004063d8b43e7sm18422239wmf.48.2023.10.25.00.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:32:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:32:40 +0200
Subject: [PATCH 03/10] dt-bindings: clock: qcom: document the SM8650
 Display Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-clocks-v1-3-c89b59594caf@linaro.org>
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8049;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8lQlZ+3pgDpkiizhHfz2dE5FU+hh7QJIls3ZjAWtZvg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMSasEaoKiptbxzXwYNqjhI6OnRC4LkB0MuyDW3C
 QRJxoCeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEmgAKCRB33NvayMhJ0ekrEA
 DJ8jKSidjIc9fVktjjNaoF06EoHgKXEiDqOU1BrJJX8XKOeQO6vWLs8WKmuDOjkWMOTCAR4K7eqi+l
 fx4vXbEQbx4U0KnIBjAfiFcLLuIC2bk8+CxaGnwrDN9SXhoKIGQskzElvwKTtNgnp1cyIbEnNCMywx
 HtpkkkEHqatBZ4UT4m8NzBhmV9ZhNyk9g9L7iEO4dYvrNCr1Eys6i7CqkstzZu4jSVW9ZraxeRAqsQ
 ocu+e2Y0tZHbdzuou8sfVnHqyGhDyvg9K8E1dibgFLW8dOI/pGzRD2OuvHef5M+L79I+VxyQT6E9ev
 byBkDsj3Sp+Ah9YTOAA1/d6IdX1N9kvFI/tW49bSpvJefNUSA8j6mklhLd0Ekp5BTIOnRBUR+P5CSw
 oshTlttL3xya6rFmD8OncdU+Mfla/ArH55CQy39Yd8BfnuArREtARp6FwDVM/qJ9MGmX239ZXbMzgc
 EKoIjZgBzxY61wp2g77pl0K9+5LfKdvwXlTZMYxfWIYn/f3W3V+VSGyfL2DBDD38TT7HNgHxqMAzNN
 OlwbahDMJKYxiNpACMaH2m3XRvCWpHcKobqT/zX4yGhPOIJSjMSamLsxDUAWW1/e1ppy/RNBpmzUxo
 mvuVdMqWQT9GeWSnXnJPCUXjl17vmoOOQAi5wen1l5JiB+gbjI1C7sNwEzlA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the SM8650 Display Clock Controller.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/qcom,sm8650-dispcc.yaml         | 106 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8650-dispcc.h     | 101 ++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml
new file mode 100644
index 000000000000..5e0c45c380f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8650-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller for SM8650
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  Qualcomm display clock control module provides the clocks, resets and power
+  domains on SM8650.
+
+  See also:: include/dt-bindings/clock/qcom,sm8650-dispcc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8650-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board Always On XO source
+      - description: Display's AHB clock
+      - description: sleep clock
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: Byte clock from DSI PHY1
+      - description: Pixel clock from DSI PHY1
+      - description: Link clock from DP PHY0
+      - description: VCO DIV clock from DP PHY0
+      - description: Link clock from DP PHY1
+      - description: VCO DIV clock from DP PHY1
+      - description: Link clock from DP PHY2
+      - description: VCO DIV clock from DP PHY2
+      - description: Link clock from DP PHY3
+      - description: VCO DIV clock from DP PHY3
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
+  reg:
+    maxItems: 1
+
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8650-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sm8650-dispcc";
+      reg = <0x0af00000 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&gcc GCC_DISP_AHB_CLK>,
+               <&sleep_clk>,
+               <&dsi0_phy 0>,
+               <&dsi0_phy 1>,
+               <&dsi1_phy 0>,
+               <&dsi1_phy 1>,
+               <&dp0_phy 0>,
+               <&dp0_phy 1>,
+               <&dp1_phy 0>,
+               <&dp1_phy 1>,
+               <&dp2_phy 0>,
+               <&dp2_phy 1>,
+               <&dp3_phy 0>,
+               <&dp3_phy 1>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm8650-dispcc.h b/include/dt-bindings/clock/qcom,sm8650-dispcc.h
new file mode 100644
index 000000000000..9115e069e96c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-dispcc.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_SM8650_DISP_CC_H
+#define _DT_BINDINGS_CLK_QCOM_SM8650_DISP_CC_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_ACCU_CLK					0
+#define DISP_CC_MDSS_AHB1_CLK					1
+#define DISP_CC_MDSS_AHB_CLK					2
+#define DISP_CC_MDSS_AHB_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_CLK					4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				7
+#define DISP_CC_MDSS_BYTE1_CLK					8
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				11
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				12
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				13
+#define DISP_CC_MDSS_DPTX0_CRYPTO_CLK				14
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				15
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				16
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			17
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			18
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				19
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			20
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				21
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			22
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		23
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				24
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				25
+#define DISP_CC_MDSS_DPTX1_CRYPTO_CLK				26
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				27
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				28
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			29
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			30
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				31
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			32
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				33
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			34
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		35
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				36
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				37
+#define DISP_CC_MDSS_DPTX2_CRYPTO_CLK				38
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				39
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				40
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			41
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			42
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				43
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			44
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				45
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			46
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				47
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				48
+#define DISP_CC_MDSS_DPTX3_CRYPTO_CLK				49
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				50
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				51
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			52
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			53
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				54
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			55
+#define DISP_CC_MDSS_ESC0_CLK					56
+#define DISP_CC_MDSS_ESC0_CLK_SRC				57
+#define DISP_CC_MDSS_ESC1_CLK					58
+#define DISP_CC_MDSS_ESC1_CLK_SRC				59
+#define DISP_CC_MDSS_MDP1_CLK					60
+#define DISP_CC_MDSS_MDP_CLK					61
+#define DISP_CC_MDSS_MDP_CLK_SRC				62
+#define DISP_CC_MDSS_MDP_LUT1_CLK				63
+#define DISP_CC_MDSS_MDP_LUT_CLK				64
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				65
+#define DISP_CC_MDSS_PCLK0_CLK					66
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				67
+#define DISP_CC_MDSS_PCLK1_CLK					68
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				69
+#define DISP_CC_MDSS_RSCC_AHB_CLK				70
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				71
+#define DISP_CC_MDSS_VSYNC1_CLK					72
+#define DISP_CC_MDSS_VSYNC_CLK					73
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				74
+#define DISP_CC_PLL0						75
+#define DISP_CC_PLL1						76
+#define DISP_CC_SLEEP_CLK					77
+#define DISP_CC_SLEEP_CLK_SRC					78
+#define DISP_CC_XO_CLK						79
+#define DISP_CC_XO_CLK_SRC					80
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+#define MDSS_INT2_GDSC						1
+
+#endif

-- 
2.34.1

