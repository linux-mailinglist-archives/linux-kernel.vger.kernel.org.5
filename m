Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79587F604A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjKWNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbjKWNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:32:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59BFD47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:32:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859dee28cso6864965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746342; x=1701351142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDsyXZIBlA1lNNF7qhampqO+ATdovopNFgedN9IvC2c=;
        b=my4vLYVncaOIkRKJyF6JK0fTooFigy9rnQkhmOrCqakVS59NSi97iC3Ak9ycv/6IrB
         exVX8mZobSk8bjzLlxArDVO3NJyiZ4c+fNwOiPt06TXTaUY4vaFehuNNW1ShHGqsUG9F
         f5pEHrfq7hQI9cxXo1Wt0ams62e0dtUvYU/1YUZA8hfKkqz36ltiXWDbOYGlea2X6tj5
         ekB2eNeN0PWZFuKkwuO9N4xOiyyOyWoBhz18MImfmxevbDJG+ZZd9GKU7stIL2VZoQYO
         aKBbHd9348KcRcLYC9tynsPNISiKpVWb15hrf/d9z1O4Rg5wLvYJJXvg/A2MO0aklvpK
         0Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746342; x=1701351142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDsyXZIBlA1lNNF7qhampqO+ATdovopNFgedN9IvC2c=;
        b=q9BgQK//jH7rEVCnx3x4M8UrLhZLGSkAc32/YR8E+ME/lFwKjVbrBWmMWb5ySFd1RW
         CLcng6WD9GfOGvEbfcHYws96TlgfUeE6HU5MxU+C7eO4uYeJ4NTLUlWXNrU1H2Ze5IjE
         BwDmoTfoHWJNX9diewiqHqgu6KsTMuYr11sbPaKc02+E3F66sVyv6oTh3Kgj2eGXoM7g
         u/rfFOfSlwwUjcsSXs/qnVH7a8qGLCSgw3NK3ayrrdGBZ2+981mJMMz9lM/Orc3Hj2uD
         WNMRgoxmFBdjBV6GrSO9sOBWkRAh8GExmQ0orZrNsD7JqvH6s9EM1f3D4TbYtU6/i6+2
         NpDA==
X-Gm-Message-State: AOJu0Ywuj8X+x8ppAuaH1gyXyINLVsgxgW0OFCH3TW+EbqqC1jS8Sn6e
        Hwf5YBpqg87sdP88bKgxSu0+T+Fd6l+hOAVQBsNSEc5p
X-Google-Smtp-Source: AGHT+IFKor8ePjIX8dVKYxReB6s2qkMRZmuGEl1vx5it4ytfntmskFQdAa+1S49JXiQG/BatPOEvJw==
X-Received: by 2002:a5d:584a:0:b0:332:d33e:6596 with SMTP id i10-20020a5d584a000000b00332d33e6596mr3186986wrf.14.1700746342174;
        Thu, 23 Nov 2023 05:32:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003313a1e0ba1sm1647658wrw.89.2023.11.23.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:32:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 23 Nov 2023 14:32:12 +0100
Subject: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip Interconnect in Qualcomm SM8650 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-topic-sm8650-upstream-interconnect-v2-1-7e050874f59b@linaro.org>
References: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
In-Reply-To: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9000;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=D7Fd/A7WhCP5OPEQ+1b6VlMpxDd+pfLoU7YvZmGGloc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX1Rjd+eZQbnmjv7woQXRnDvb2omaZ4WTFRNnFTrm
 3OR6BDCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV9UYwAKCRB33NvayMhJ0UzaD/
 0c6dCEVmcCr7zA44I2EJ0Lwwm+VdRngYmXdTQy/LtgkKLQO+gcavtH45euTAWgBYCygWfl4ZyAMc9q
 R+VaEPL3rQ8yoJkV/vGbOyh19il3yJU/JRcnKZslY+j9NKoJOomnNUCA7ge08sTcX8eQGA+LZiyRtH
 5TpAO95W6xwHYfm+OgxbYU1F3eVPcON6HqzmPBLccCganUFfAr4PxOZdqvg+zAF2QQzYo5ptS99vUu
 /uwwnVZ78g2V4Ofh/P0lQFygtX+MqAOOMiSpl/H2iT1UMYk+93g6Gx7rFrqBMZj3MFmZV1DUoo1MOh
 yHC6NMJWOX9dFIRSKFM0+7nYKR8wFxa7wvQdULkxxvUqkCSqngIDyR7cQZh4Kt5eqATfQYtsPmBil6
 YC1Yl00zT/HUiI/TUe8mXd8iS62aCxkMBjjkb/LxKnHx2eB5sJleIbpxKTXhAiBNgD58Wmw0uWC8St
 1sIakvub/7Xgu4qG9q1X6RrfNNCnb6RdwbdDWwHNXk8JwgDkp6xjGJO6uOHpY9QlJCNxtM02B7z0IK
 UGPNHbKBdeTTgiiJYIBPV6ntFdXXZ0DBMNU+uneUqdrmO9soGX3YdYiaOlvPne2fJ/nz2owe25Waap
 WihUtmFniZgir0yh2Erzn6iJO4xK/sanwBdlzQcFexlrCU480+iwXtmp9umg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the RPMh Network-On-Chip Interconnect of the SM8650 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/interconnect/qcom,sm8650-rpmh.yaml    | 136 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm8650-rpmh.h    | 154 +++++++++++++++++++++
 2 files changed, 290 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
new file mode 100644
index 000000000000..f9322de7cd61
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8650-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM8650
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also:: include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8650-aggre1-noc
+      - qcom,sm8650-aggre2-noc
+      - qcom,sm8650-clk-virt
+      - qcom,sm8650-cnoc-main
+      - qcom,sm8650-config-noc
+      - qcom,sm8650-gem-noc
+      - qcom,sm8650-lpass-ag-noc
+      - qcom,sm8650-lpass-lpiaon-noc
+      - qcom,sm8650-lpass-lpicx-noc
+      - qcom,sm8650-mc-virt
+      - qcom,sm8650-mmss-noc
+      - qcom,sm8650-nsp-noc
+      - qcom,sm8650-pcie-anoc
+      - qcom,sm8650-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-clk-virt
+              - qcom,sm8650-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-aggre1-noc
+              - qcom,sm8650-aggre2-noc
+              - qcom,sm8650-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clk_virt: interconnect-0 {
+      compatible = "qcom,sm8650-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,sm8650-aggre1-noc";
+      reg = <0x016e0000 0x14400>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc_phy_axi_clk>, <&gcc_prim_axi_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm8650-rpmh.h b/include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
new file mode 100644
index 000000000000..6c1eaf04e241
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8650_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8650_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_QUP_3				2
+#define MASTER_SDCC_4				3
+#define MASTER_UFS_MEM				4
+#define MASTER_USB3_0				5
+#define SLAVE_A1NOC_SNOC			6
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_2				1
+#define MASTER_CRYPTO				2
+#define MASTER_IPA				3
+#define MASTER_SP				4
+#define MASTER_QDSS_ETR				5
+#define MASTER_QDSS_ETR_1			6
+#define MASTER_SDCC_2				7
+#define SLAVE_A2NOC_SNOC			8
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_CAMERA_CFG			3
+#define SLAVE_CLK_CTL				4
+#define SLAVE_RBCPR_CX_CFG			5
+#define SLAVE_CPR_HMX				6
+#define SLAVE_RBCPR_MMCX_CFG			7
+#define SLAVE_RBCPR_MXA_CFG			8
+#define SLAVE_RBCPR_MXC_CFG			9
+#define SLAVE_CPR_NSPCX				10
+#define SLAVE_CRYPTO_0_CFG			11
+#define SLAVE_CX_RDPM				12
+#define SLAVE_DISPLAY_CFG			13
+#define SLAVE_GFX3D_CFG				14
+#define SLAVE_I2C				15
+#define SLAVE_I3C_IBI0_CFG			16
+#define SLAVE_I3C_IBI1_CFG			17
+#define SLAVE_IMEM_CFG				18
+#define SLAVE_CNOC_MSS				19
+#define SLAVE_MX_2_RDPM				20
+#define SLAVE_MX_RDPM				21
+#define SLAVE_PCIE_0_CFG			22
+#define SLAVE_PCIE_1_CFG			23
+#define SLAVE_PCIE_RSCC				24
+#define SLAVE_PDM				25
+#define SLAVE_PRNG				26
+#define SLAVE_QDSS_CFG				27
+#define SLAVE_QSPI_0				28
+#define SLAVE_QUP_3				29
+#define SLAVE_QUP_1				30
+#define SLAVE_QUP_2				31
+#define SLAVE_SDCC_2				32
+#define SLAVE_SDCC_4				33
+#define SLAVE_SPSS_CFG				34
+#define SLAVE_TCSR				35
+#define SLAVE_TLMM				36
+#define SLAVE_UFS_MEM_CFG			37
+#define SLAVE_USB3_0				38
+#define SLAVE_VENUS_CFG				39
+#define SLAVE_VSENSE_CTRL_CFG			40
+#define SLAVE_CNOC_MNOC_CFG			41
+#define SLAVE_NSP_QTB_CFG			42
+#define SLAVE_PCIE_ANOC_CFG			43
+#define SLAVE_SERVICE_CNOC_CFG			44
+#define SLAVE_QDSS_STM				45
+#define SLAVE_TCU				46
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_IPA_CFG				3
+#define SLAVE_IPC_ROUTER_CFG			4
+#define SLAVE_TME_CFG				5
+#define SLAVE_APPSS				6
+#define SLAVE_CNOC_CFG				7
+#define SLAVE_DDRSS_CFG				8
+#define SLAVE_IMEM				9
+#define SLAVE_SERVICE_CNOC			10
+#define SLAVE_PCIE_0				11
+#define SLAVE_PCIE_1				12
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_UBWC_P_TCU			2
+#define MASTER_APPSS_PROC			3
+#define MASTER_GFX3D				4
+#define MASTER_LPASS_GEM_NOC			5
+#define MASTER_MSS_PROC				6
+#define MASTER_MNOC_HF_MEM_NOC			7
+#define MASTER_MNOC_SF_MEM_NOC			8
+#define MASTER_COMPUTE_NOC			9
+#define MASTER_ANOC_PCIE_GEM_NOC		10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define MASTER_UBWC_P				12
+#define MASTER_GIC				13
+#define SLAVE_GEM_NOC_CNOC			14
+#define SLAVE_LLCC				15
+#define SLAVE_MEM_NOC_PCIE_SNOC			16
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CDSP_HCP				4
+#define MASTER_VIDEO				5
+#define MASTER_VIDEO_CV_PROC			6
+#define MASTER_VIDEO_PROC			7
+#define MASTER_VIDEO_V_PROC			8
+#define MASTER_CNOC_MNOC_CFG			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define SLAVE_SNOC_GEM_NOC_SF			2
+
+#endif

-- 
2.34.1

