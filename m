Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EB17E1BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjKFI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:26:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C9BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:26:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839807e82so24905745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259165; x=1699863965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98m6fyahC9yLw85pMFp0rd38Afgy97hAf7i/gXUd1x8=;
        b=U0mMGdrhNGtukTCHbY8odApf3SDOqnQys9fQ0oIlPWum7EeJFtsAqy+WhvL/QeNshg
         VovRF8m1QBhfbEv1OigETY9Q41XEyOt2X7H3KGzcWR3rNT6MBnryCYYbCk7acWmmujdM
         08XCV0aM7tOTPPpbXBxTaEUX4RhbipOHtAbnCYZZsPPRsRpg/B57nVNVlngzP6ReG0JU
         5Kbn+BAuAK9SbD8iQapOWYREIbWmbPy8nfiorBJ3glVr/HfUOeuUGzpQnesM3tvspPnD
         yj8ecB4OSs1QtOGS36ok5R8ltRnC0jE3XOpFEbrmQF68KSwn7YKzJS53p0YNJXg3pjA3
         lpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259165; x=1699863965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98m6fyahC9yLw85pMFp0rd38Afgy97hAf7i/gXUd1x8=;
        b=CC0jwtP4kl3hQMd4tgDvWBtgsTQ29LapGsUaLG36lXuZgtWmMl+FpqJIDrF8XtHE3z
         6OMjX5b4b1ninN+yiQiL5s+RdsKmKwMRCAiYa0bnVvmrBQuKNcISIKPYklLUYdqbuQmZ
         EpzfB8sX7Eahvk075BGAycPv1/3Usl+9NFebOlch1ae7bcCCPgICU+njsrzD28avKWcg
         6WFL2DQ2ucUY5fbmKTepuQumFcVQC3fLUwq9ZZO74PfUq4J1KmpbRD7aPludYPOdGY22
         gpM6LttQPdgieyOSgdXa67GV6dxD+bEsDsCvS/2f5yKbg9v+UJLuxjjp6S0StcfkZuN9
         eTzw==
X-Gm-Message-State: AOJu0Yyszaji+ihLXE+QsNUHT5cLV/aolMZJO+t9252MW7rEljpSPuUV
        csC34d/nAcr3SHTWsPsC6bQwvg==
X-Google-Smtp-Source: AGHT+IGHVn3oOa0z9zVomBePNQw7sUGQWsOuEQzWfu7LM60kBOjkbsrrXPT9bw/Af/jwNwzq1C0Qzg==
X-Received: by 2002:a05:600c:358f:b0:405:19dd:ad82 with SMTP id p15-20020a05600c358f00b0040519ddad82mr11401483wmq.16.1699259165554;
        Mon, 06 Nov 2023 00:26:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm11610663wmb.28.2023.11.06.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:26:05 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:25:56 +0100
Subject: [PATCH v3 03/11] dt-bindings: clock: qcom: document the SM8650
 Display Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-clocks-v3-3-761a6fadb4c0@linaro.org>
References: <20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8140;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=e2EuLWV7AJn5boOAv0KiZubzEeivWLsyyQZ/3pdy1ME=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKMVJIVkc1xNDJRg/ZdnXLyLgmhgDqen6GBdyxuq
 iFwrCPeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijFQAKCRB33NvayMhJ0T/HD/
 419CqwSfzs6f7SOHkVgRmWf+28ep/gbLIVTVaFZQl9FRK2AQg64oNgzwWxiJETQLl6Cyo0oATk0e7y
 fy2ZLCqcwNoAKePIQGV3tv3N8I+A2f4t2R+MCJ+YpoyL88JK3JJ/PIn2wcrHfmClw3JI/3q46WNDiU
 4b4ufXvQ7SjggI8rSuA86w0WX+qUsTeO0BmuUP3cGAvNUjLttlqOQcgIeY7VnOfTKcTlIjaXsm2qcU
 7pcKmmt3aLVceWBEW93OROtr7OSV0axrTAEZryRK8F0YA0J2kwefH1RfLOFzBUTZMxUMr1PqOYdvZz
 +Wht2d1gipegPiwB36S3+dmamTnim3pGJS49yCtVEbNAE5quEgKDEgDSJv89b4KrF13wFzLp/5wSzt
 na/ZJBd8jMp0F2Qgz6SeQ1m5YdNdLGr8uwQsg/Z+IePX73kV7eexOpJ1JANg8Ub9ILPMgEy70J9Ov8
 qXdpzZ6eFyckcSw08tkaPAJ/E/ExKWBOqyjG+r6QGg+MPC2FpepYxTs2TLYlJ6IedfriXTEpy814HY
 Wv1YZuBezSOsoK+bpQM0XPGFaarFAGWoAqxKNC3vF0uYXkDFP/gz37g9bkVTZhxAxqRZGR03M7TUIe
 lYLfy40eD/oJII5zgnJEgxV/b1BbWhj8QkSlKB6Hn4GNKO82KgGaMDiTGP2w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the SM8650 Display Clock Controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/qcom,sm8650-dispcc.yaml         | 106 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8650-dispcc.h     | 102 ++++++++++++++++++++
 2 files changed, 208 insertions(+)

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
index 000000000000..b0a668b395a5
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-dispcc.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved
+ * Copyright (c) 2023, Linaro Ltd.
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

