Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B017D633E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJYHfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjJYHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:34:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD01729
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40859c464daso32811325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219207; x=1698824007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugTMPOPgRl8FHJw/bepLzzxJjl7JVouyyZ90mGvKM8k=;
        b=Htl2Kc8YCvdvct7bSIBKueOI6J90Lcd9ifSzz/iU5Hq/NvV+I8gbpcwoJ3cUuZOoJu
         gUK/+GXQajG9czLrsTvIvPFHb0zsEI8RPJPcj2Lx4NsArpjE281akTQojf4mTRYic7Cj
         X/cFK5UFfBJtKbK/L5fxqv3US6EP8sEJwb5pl/SO1Dpgxsgu8cu5FKa3fiijVQLOo/oZ
         w5Ss5E18NBufVgB5qp8stJXuekNgrnPNJoXrJOZjlYh6791rD3xgP16xieRZ41uYL7sV
         7fZ8r/gkKL3cE0SJG9JeR5AZ9tjNNAugEZmvno/uzBN4Fs5C2s9j4yABmu4pC93+uZuz
         +DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219207; x=1698824007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugTMPOPgRl8FHJw/bepLzzxJjl7JVouyyZ90mGvKM8k=;
        b=oVBVK6aKAM2NV/mV1SLWmNeBQ9vl6eGrU3d6/GlSUK50gPVvB7KYJLP/T/dSuakztG
         fpqb6yEOObOxLKMXKcN0evg2zjDxR1sPVog0KBX2yhVGE7vrGLXlXnw4x/b69Jx3R5iq
         zkeeKXcFc+B0JCRx03LSeRzlgcY0X7+Q2cVc4VpKS5kmrc+rgVx8ngkkY4B15Hgkn4np
         03j/qnI+FCaevXNxKdexGZ2c9NdaV0qj5JIRgvESZy++4rRbuVVivETlR4Cn6Mw9EfZo
         Mlw0NrRb0aNEWWZg99KtrH+sSrb4CiKowZlZVkZJILGwt15FlkBsb4MY10WTN8SLcoX4
         n0SA==
X-Gm-Message-State: AOJu0YygOJxeBbbOiDbZT6s1Fd54IAOQiqjiQ8sl7M0yu/Yyb9gfMqPk
        kgrUnSXq8KLn4GXg3oe0t2eTcA==
X-Google-Smtp-Source: AGHT+IFFi6if87derniSSwTbSiJD/P12f4sgcS7Hn2rtpTi0L+JFXH/+jkwFU+o+gdIZC73O4SPfrQ==
X-Received: by 2002:a05:600c:3b8c:b0:3fe:d71a:d84e with SMTP id n12-20020a05600c3b8c00b003fed71ad84emr11478194wms.1.1698219207042;
        Wed, 25 Oct 2023 00:33:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d628d000000b0032daf848f68sm11470533wru.59.2023.10.25.00.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:33:26 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:33:23 +0200
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip Interconnect in Qualcomm SM8650 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-interconnect-v1-1-b7277e03aa3d@linaro.org>
References: <20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8933;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ssY5roIDfUcCHnuQSTCub5EJIW/Q9chlYxI/YJIcKHw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMTET9sQEVaKpRsdILUhSxq1KXvBapf5at4hZHP7
 ft3hwCiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjExAAKCRB33NvayMhJ0eOeEA
 C2P1QP7LyGUJA09RdNGJIBxfyAGufni9Pq7yFuKC4F7pDKYtNSar9GuUa51hIm0XHQ43WDTwOZfvEM
 dJ213Z0NVVemjITM0Zc5w9CwZKSVm7P85JoYpsRoMX/WehawyET+BOWDSF23x7Talctme++z24Ql/L
 ecd0e2v0proAufQD4CBCDv9fsnJZ1k385O1P4S+r7O0uGWR2ENIytZBiV01UMOWxTxMPN45koUtn+O
 BMWYvH1WkGUzaFUXVbLDKZiXgyEFSTic99KbGnZjX0bBI8FDT5S9toeSESCPH+WDUL7kcahHNvmEQd
 1uWeQ8WK1oHbt1wA7G7B/O1Tkh5+qvHwcwta3yEq1tMQqqPf9W+diNZB9ALrY2Y//77suv0C0XZN+n
 +vWbtOhTaDuJk1fmM12B1LDutEl2jwbkp/L9XZDoH05iVCzW0rdCgNDjHd8w5AwnF3iKiWE2d1DR1s
 ll26IrhVzJ06WKYIMiuW/9lcoQ8XD+ou0b2LAZ6oBg2UPu839fO09oIy7u68o4GKcrRJAorvauaGyl
 9QyAPDv4XN0py0nk0lsvQTV/1xL/4J/+psOTbd9wmM9LTfDAQm/lPvQZYzCwhlk/7BMu0ncUXmHrTu
 U2R3ISLOdPw4Kx4JWlCF8sOrpIvfife31ip8jwbBgNHgTpJno8NEH8FkZLqg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the RPMh Network-On-Chip Interconnect of the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/interconnect/qcom,sm8650-rpmh.yaml    | 136 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm8650-rpmh.h    | 154 +++++++++++++++++++++
 2 files changed, 290 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
new file mode 100644
index 000000000000..65b239ac2afd
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
+required:
+  - compatible
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

