Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B627D6317
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjJYHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjJYHd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:33:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C071BF2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083cd39188so41557895e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219169; x=1698823969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+QvEq+ld/CQ9ohL6hvjNaMtzi5GaxS3Jd1U1pHJ3Po=;
        b=pNkzNSjo0BUyCy6PgtEc1SKV6nYkJO4rfHc5ek94h/zeqxR1zpj8YJ5gEP4gt3RiKE
         Z3nXTRDsgaDV0KiH4/Hs2njjhlV79xHk5flby7+klQsssB5YYgNLuFWnuUyCfPUavi5/
         4dWBn3ovZhXKXwglA5Nf7mTSP+Eugo1EulFp4OHQcqFdBC92DwIL9DcMyPKT9PTWTJx0
         tN1zLkJvZf9nAnVaE06gdeeaU62tlrB2k43wGQmM/8CXo1ZVXLtarsD7bPr37NMMCtqb
         95b0TMplTFcOoLBhJKI/fahGhs19fi+jr/Om4W9mPFPfsn7rInOff7K0DIbbdRe1mtUH
         L8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219169; x=1698823969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+QvEq+ld/CQ9ohL6hvjNaMtzi5GaxS3Jd1U1pHJ3Po=;
        b=wwzA7zEe7H+gvtTLVMYNmhogL57HBMpAqS8MZ/qjzyK+I/6L9IVDT+VLxsWCz/RYq2
         WpF9c+E1CMVV5ax0o1BjFdg7hflobLLfDffv9ddABeOPyHI+UUP6oQlYqITu7d1VU2/V
         I8cmCFE59cx4Eil8YUt09B2QfTOdmsfkU80DQ1Yf7+Cjap3tWXQkU8yhb3GpsvYkx9fg
         tNp96MJe3rfjBUo6zGDBo0ykFqytfsth7DMJRdnwNnkGti/DaX/r/x0lYg61VweQfi+/
         I1vxaXBkD1SdjqWReHFmyRBDfZav/dELCfx6DaQEdqr8E1AEU3AR0gKfnzw822OAlC+6
         YWNg==
X-Gm-Message-State: AOJu0YwKh6uL+BHQmLjYkdp25WrK/yJTSfikv3VEljcWq2RlwPzo8fKR
        7v5E7jsiEHbIGZ8XsI4hMsZiVg==
X-Google-Smtp-Source: AGHT+IF1RUw+ujIr3SHJri1I0TDV5aP51F5z4s4+VgzpK51Moz3XlrmHIce1jSd+RomfohTxBInK4A==
X-Received: by 2002:a05:600c:350f:b0:405:75f0:fd31 with SMTP id h15-20020a05600c350f00b0040575f0fd31mr11314037wmq.31.1698219169108;
        Wed, 25 Oct 2023 00:32:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c15d200b004063d8b43e7sm18422239wmf.48.2023.10.25.00.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:32:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:32:39 +0200
Subject: [PATCH 02/10] dt-bindings: clock: qcom: document the SM8650
 General Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-clocks-v1-2-c89b59594caf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12761;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tsNR/0PjpP3ryJRX0a+6Qb1cJ7lJdvsDCPLBgEZBfPs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMSZyTeUmBM7PNn7N8vYgyTx2qJuQYqt9q7dp4bi
 GnG4CrSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEmQAKCRB33NvayMhJ0QxDD/
 0fv4frM75vXWiqvhPjSK3NOAUX8W8yW34R+y0pEF7LFIXmvhUhxxhW9dgtCYTRjCWz0p06BxhiQdle
 8dR8A9eKoLni6dhUZZtq/BBvsiiMdkrfZ5Ompkktxv00Y7p1yTTiDLkPDoDCfEYF3Rn/COOSKTCiOD
 EIGgIUKhDMy0SZGB8+N63V/HfTsEtGuQZ4CFHTeL/E9g+Ph0cldZzS2H9p39KPNF8SEAfM85tJotFj
 Wi1aW7lDOkIHk5V6E0/Y0m0v1JNH0diZXYHQWerpLJejqwgWAkeNkgee9Fgcq1nGRZLB/B0uVhRlFh
 P82OUGMbPjs+8KZ6mABOqnpJMWTIRGZihc9USzysRscn6Mp9gp6n7fOO5ErMXLBaDDeZhqVvzL/RcY
 3aHwwpEQK3WnLNRNheuQyD8JZwzAt8V1b65Y/NkWknPdPY3yqeRK0biQIEO8b1CSbXnzCr/fYzp8jS
 CWvy2wgUjhkmWLpqCOcb7tvVxg/G2ENiAMJxOSJhqko7CxDTzx11gu6ZzLe7JBVxuAqAZ75S8Qnb1O
 qganwfdMMLZjzDRUdbVjeHYyq7qzFXUWFt2fiPZ4ktyNU7MNQ4Bl37d2RPgRYVvc64bkOCjdIQtC7P
 L2Of4iOinh8Hp05vFYdRK4kTnoc0gEZatkWhrszcQYAbugfednIacnf+5oXQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the SM8650 General Clock Controller.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/clock/qcom,sm8650-gcc.yaml |  65 ++++++
 include/dt-bindings/clock/qcom,sm8650-gcc.h        | 257 +++++++++++++++++++++
 2 files changed, 322 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml
new file mode 100644
index 000000000000..b54761cc8674
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8650-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on SM8650
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on SM8650
+
+  See also:: include/dt-bindings/clock/qcom,sm8650-gcc.h
+
+properties:
+  compatible:
+    const: qcom,sm8650-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board Always On XO source
+      - description: Sleep clock source
+      - description: PCIE 0 Pipe clock source
+      - description: PCIE 1 Pipe clock source
+      - description: PCIE 1 Phy Auxiliary clock source
+      - description: UFS Phy Rx symbol 0 clock source
+      - description: UFS Phy Rx symbol 1 clock source
+      - description: UFS Phy Tx symbol 0 clock source
+      - description: USB3 Phy wrapper pipe clock source
+
+required:
+  - compatible
+  - clocks
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,sm8650-gcc";
+      reg = <0x00100000 0x001f4200>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>,
+               <&pcie0_phy>,
+               <&pcie1_phy>,
+               <&pcie_1_phy_aux_clk>,
+               <&ufs_mem_phy 0>,
+               <&ufs_mem_phy 1>,
+               <&ufs_mem_phy 2>,
+               <&usb_1_qmpphy>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,sm8650-gcc.h b/include/dt-bindings/clock/qcom,sm8650-gcc.h
new file mode 100644
index 000000000000..af02961b7bba
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-gcc.h
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8650_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM8650_H
+
+/* GCC clocks */
+#define GCC_AGGRE_NOC_PCIE_AXI_CLK				0
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				1
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			2
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				3
+#define GCC_BOOT_ROM_AHB_CLK					4
+#define GCC_CAMERA_AHB_CLK					5
+#define GCC_CAMERA_HF_AXI_CLK					6
+#define GCC_CAMERA_SF_AXI_CLK					7
+#define GCC_CAMERA_XO_CLK					8
+#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK				9
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				10
+#define GCC_CNOC_PCIE_SF_AXI_CLK				11
+#define GCC_CPUSS_UBWCP_CLK					12
+#define GCC_CPUSS_UBWCP_CLK_SRC					13
+#define GCC_DDRSS_GPU_AXI_CLK					14
+#define GCC_DDRSS_PCIE_SF_QTB_CLK				15
+#define GCC_DDRSS_UBWCP_CLK					16
+#define GCC_DISP_AHB_CLK					17
+#define GCC_DISP_HF_AXI_CLK					18
+#define GCC_DISP_XO_CLK						19
+#define GCC_GP1_CLK						20
+#define GCC_GP1_CLK_SRC						21
+#define GCC_GP2_CLK						22
+#define GCC_GP2_CLK_SRC						23
+#define GCC_GP3_CLK						24
+#define GCC_GP3_CLK_SRC						25
+#define GCC_GPLL0						26
+#define GCC_GPLL0_OUT_EVEN					27
+#define GCC_GPLL1						28
+#define GCC_GPLL3						29
+#define GCC_GPLL4						30
+#define GCC_GPLL6						31
+#define GCC_GPLL7						32
+#define GCC_GPLL9						33
+#define GCC_GPU_CFG_AHB_CLK					34
+#define GCC_GPU_GPLL0_CLK_SRC					35
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				36
+#define GCC_GPU_MEMNOC_GFX_CLK					37
+#define GCC_GPU_SNOC_DVM_GFX_CLK				38
+#define GCC_PCIE_0_AUX_CLK					39
+#define GCC_PCIE_0_AUX_CLK_SRC					40
+#define GCC_PCIE_0_CFG_AHB_CLK					41
+#define GCC_PCIE_0_MSTR_AXI_CLK					42
+#define GCC_PCIE_0_PHY_RCHNG_CLK				43
+#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC				44
+#define GCC_PCIE_0_PIPE_CLK					45
+#define GCC_PCIE_0_PIPE_CLK_SRC					46
+#define GCC_PCIE_0_SLV_AXI_CLK					47
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				48
+#define GCC_PCIE_1_AUX_CLK					49
+#define GCC_PCIE_1_AUX_CLK_SRC					50
+#define GCC_PCIE_1_CFG_AHB_CLK					51
+#define GCC_PCIE_1_MSTR_AXI_CLK					52
+#define GCC_PCIE_1_PHY_AUX_CLK					53
+#define GCC_PCIE_1_PHY_AUX_CLK_SRC				54
+#define GCC_PCIE_1_PHY_RCHNG_CLK				55
+#define GCC_PCIE_1_PHY_RCHNG_CLK_SRC				56
+#define GCC_PCIE_1_PIPE_CLK					57
+#define GCC_PCIE_1_PIPE_CLK_SRC					58
+#define GCC_PCIE_1_SLV_AXI_CLK					59
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				60
+#define GCC_PDM2_CLK						61
+#define GCC_PDM2_CLK_SRC					62
+#define GCC_PDM_AHB_CLK						63
+#define GCC_PDM_XO4_CLK						64
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				65
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				66
+#define GCC_QMIP_DISP_AHB_CLK					67
+#define GCC_QMIP_GPU_AHB_CLK					68
+#define GCC_QMIP_PCIE_AHB_CLK					69
+#define GCC_QMIP_VIDEO_CV_CPU_AHB_CLK				70
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				71
+#define GCC_QMIP_VIDEO_V_CPU_AHB_CLK				72
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				73
+#define GCC_QUPV3_I2C_CORE_CLK					74
+#define GCC_QUPV3_I2C_S0_CLK					75
+#define GCC_QUPV3_I2C_S0_CLK_SRC				76
+#define GCC_QUPV3_I2C_S1_CLK					77
+#define GCC_QUPV3_I2C_S1_CLK_SRC				78
+#define GCC_QUPV3_I2C_S2_CLK					79
+#define GCC_QUPV3_I2C_S2_CLK_SRC				80
+#define GCC_QUPV3_I2C_S3_CLK					81
+#define GCC_QUPV3_I2C_S3_CLK_SRC				82
+#define GCC_QUPV3_I2C_S4_CLK					83
+#define GCC_QUPV3_I2C_S4_CLK_SRC				84
+#define GCC_QUPV3_I2C_S5_CLK					85
+#define GCC_QUPV3_I2C_S5_CLK_SRC				86
+#define GCC_QUPV3_I2C_S6_CLK					87
+#define GCC_QUPV3_I2C_S6_CLK_SRC				88
+#define GCC_QUPV3_I2C_S7_CLK					89
+#define GCC_QUPV3_I2C_S7_CLK_SRC				90
+#define GCC_QUPV3_I2C_S8_CLK					91
+#define GCC_QUPV3_I2C_S8_CLK_SRC				92
+#define GCC_QUPV3_I2C_S9_CLK					93
+#define GCC_QUPV3_I2C_S9_CLK_SRC				94
+#define GCC_QUPV3_I2C_S_AHB_CLK					95
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				96
+#define GCC_QUPV3_WRAP1_CORE_CLK				97
+#define GCC_QUPV3_WRAP1_QSPI_REF_CLK				98
+#define GCC_QUPV3_WRAP1_QSPI_REF_CLK_SRC			99
+#define GCC_QUPV3_WRAP1_S0_CLK					100
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				101
+#define GCC_QUPV3_WRAP1_S1_CLK					102
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				103
+#define GCC_QUPV3_WRAP1_S2_CLK					104
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				105
+#define GCC_QUPV3_WRAP1_S3_CLK					106
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				107
+#define GCC_QUPV3_WRAP1_S4_CLK					108
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				109
+#define GCC_QUPV3_WRAP1_S5_CLK					110
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				111
+#define GCC_QUPV3_WRAP1_S6_CLK					112
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC				113
+#define GCC_QUPV3_WRAP1_S7_CLK					114
+#define GCC_QUPV3_WRAP1_S7_CLK_SRC				115
+#define GCC_QUPV3_WRAP2_CORE_2X_CLK				116
+#define GCC_QUPV3_WRAP2_CORE_CLK				117
+#define GCC_QUPV3_WRAP2_IBI_CTRL_0_CLK_SRC			118
+#define GCC_QUPV3_WRAP2_IBI_CTRL_2_CLK				119
+#define GCC_QUPV3_WRAP2_IBI_CTRL_3_CLK				120
+#define GCC_QUPV3_WRAP2_S0_CLK					121
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				122
+#define GCC_QUPV3_WRAP2_S1_CLK					123
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				124
+#define GCC_QUPV3_WRAP2_S2_CLK					125
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				126
+#define GCC_QUPV3_WRAP2_S3_CLK					127
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				128
+#define GCC_QUPV3_WRAP2_S4_CLK					129
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				130
+#define GCC_QUPV3_WRAP2_S5_CLK					131
+#define GCC_QUPV3_WRAP2_S5_CLK_SRC				132
+#define GCC_QUPV3_WRAP2_S6_CLK					133
+#define GCC_QUPV3_WRAP2_S6_CLK_SRC				134
+#define GCC_QUPV3_WRAP2_S7_CLK					135
+#define GCC_QUPV3_WRAP2_S7_CLK_SRC				136
+#define GCC_QUPV3_WRAP3_CORE_2X_CLK				137
+#define GCC_QUPV3_WRAP3_CORE_CLK				138
+#define GCC_QUPV3_WRAP3_QSPI_REF_CLK				139
+#define GCC_QUPV3_WRAP3_QSPI_REF_CLK_SRC			140
+#define GCC_QUPV3_WRAP3_S0_CLK					141
+#define GCC_QUPV3_WRAP3_S0_CLK_SRC				142
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				143
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				144
+#define GCC_QUPV3_WRAP_2_IBI_2_AHB_CLK				145
+#define GCC_QUPV3_WRAP_2_IBI_3_AHB_CLK				146
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				147
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				148
+#define GCC_QUPV3_WRAP_3_M_AHB_CLK				149
+#define GCC_QUPV3_WRAP_3_S_AHB_CLK				150
+#define GCC_SDCC2_AHB_CLK					151
+#define GCC_SDCC2_APPS_CLK					152
+#define GCC_SDCC2_APPS_CLK_SRC					153
+#define GCC_SDCC4_AHB_CLK					154
+#define GCC_SDCC4_APPS_CLK					155
+#define GCC_SDCC4_APPS_CLK_SRC					156
+#define GCC_UFS_PHY_AHB_CLK					157
+#define GCC_UFS_PHY_AXI_CLK					158
+#define GCC_UFS_PHY_AXI_CLK_SRC					159
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK				160
+#define GCC_UFS_PHY_ICE_CORE_CLK				161
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				162
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				163
+#define GCC_UFS_PHY_PHY_AUX_CLK					164
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				165
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				166
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				167
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC				168
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				169
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC				170
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				171
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC				172
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				173
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				174
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			175
+#define GCC_USB30_PRIM_MASTER_CLK				176
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				177
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				178
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			179
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		180
+#define GCC_USB30_PRIM_SLEEP_CLK				181
+#define GCC_USB3_PRIM_PHY_AUX_CLK				182
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				183
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				184
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				185
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				186
+#define GCC_VIDEO_AHB_CLK					187
+#define GCC_VIDEO_AXI0_CLK					188
+#define GCC_VIDEO_AXI1_CLK					189
+#define GCC_VIDEO_XO_CLK					190
+#define GCC_GPLL0_AO						191
+#define GCC_GPLL0_OUT_EVEN_AO					192
+#define GCC_GPLL1_AO						193
+#define GCC_GPLL3_AO						194
+#define GCC_GPLL4_AO						195
+#define GCC_GPLL6_AO						196
+
+/* GCC resets */
+#define GCC_CAMERA_BCR						0
+#define GCC_DISPLAY_BCR						1
+#define GCC_GPU_BCR						2
+#define GCC_PCIE_0_BCR						3
+#define GCC_PCIE_0_LINK_DOWN_BCR				4
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				5
+#define GCC_PCIE_0_PHY_BCR					6
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			7
+#define GCC_PCIE_1_BCR						8
+#define GCC_PCIE_1_LINK_DOWN_BCR				9
+#define GCC_PCIE_1_NOCSR_COM_PHY_BCR				10
+#define GCC_PCIE_1_PHY_BCR					11
+#define GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR			12
+#define GCC_PCIE_PHY_BCR					13
+#define GCC_PCIE_PHY_CFG_AHB_BCR				14
+#define GCC_PCIE_PHY_COM_BCR					15
+#define GCC_PDM_BCR						16
+#define GCC_QUPV3_WRAPPER_1_BCR					17
+#define GCC_QUPV3_WRAPPER_2_BCR					18
+#define GCC_QUPV3_WRAPPER_3_BCR					19
+#define GCC_QUPV3_WRAPPER_I2C_BCR				20
+#define GCC_QUSB2PHY_PRIM_BCR					21
+#define GCC_QUSB2PHY_SEC_BCR					22
+#define GCC_SDCC2_BCR						23
+#define GCC_SDCC4_BCR						24
+#define GCC_UFS_PHY_BCR						25
+#define GCC_USB30_PRIM_BCR					26
+#define GCC_USB3_DP_PHY_PRIM_BCR				27
+#define GCC_USB3_DP_PHY_SEC_BCR					28
+#define GCC_USB3_PHY_PRIM_BCR					29
+#define GCC_USB3_PHY_SEC_BCR					30
+#define GCC_USB3PHY_PHY_PRIM_BCR				31
+#define GCC_USB3PHY_PHY_SEC_BCR					32
+#define GCC_VIDEO_AXI0_CLK_ARES					33
+#define GCC_VIDEO_AXI1_CLK_ARES					34
+#define GCC_VIDEO_BCR						35
+
+/* GCC power domains */
+#define PCIE_0_GDSC						0
+#define PCIE_0_PHY_GDSC						1
+#define PCIE_1_GDSC						2
+#define PCIE_1_PHY_GDSC						3
+#define UFS_PHY_GDSC						4
+#define UFS_MEM_PHY_GDSC					5
+#define USB30_PRIM_GDSC						6
+#define USB3_PHY_GDSC						7
+
+#endif

-- 
2.34.1

