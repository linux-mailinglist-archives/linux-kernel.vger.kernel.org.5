Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8D7FD9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjK2OlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjK2OlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:41:03 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840FCD6F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a178d491014so74970566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701268866; x=1701873666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqbTJ8EbDQbHHnryxuUzp2b+Ju/3+ZVUiQp8WfOFvU0=;
        b=QIP8JiDTLx4zdtE46Sv1Sef8RfLIqOuZlchHVv7t5gcFEzHm70XCMRA1mRTyQRKkj7
         SddCfhjq+imbNJJkhfRoHx7PvQ2NsDW2RYm2xSjmhTj1yT9JVEe/bsog+ItkWdKAJC03
         GWmQbkDSJKYm0HFlwlILow7tT0tI2akHpkeLUYFFUyo9w+/Ce7O6Y4wi5rWonqkx52tc
         tFB0rK5D34xigeja7E8FGMJtup6QBLQeqt4qPWd3ggPQc2eGFyk3vdYPp5Hpre/cFot8
         WKmEk0Ip7lnRB3g/Oz7pDqcnElSqbK+wDqN2FqEsS96JUADz6oU1CVR4Udsq1c4EezEk
         rUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268866; x=1701873666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqbTJ8EbDQbHHnryxuUzp2b+Ju/3+ZVUiQp8WfOFvU0=;
        b=N9x5gx9R+GHZfcS//Gb3/nH+Tx2PGJXfbj4OqvFkVyfwxgPIz8BmAiacGDBR2R3GLN
         a8c4CQoCKRXjz2p1Wk4oVlVUtCP+63XtjBkmZ74HVZEAs8rq2XQ4nhscFTOcveLlNWoK
         stpDkeZpHHsnS03jP0U9OTV++cdH3cmToT3aRfw+E4yq99G3+jMgftJfYh9M6xnyjNsD
         ns61BzK8U5NXH6xPwSXzjsvY2XXf1evRMNUdTn/7C3VSocCTBap4VNDoEpPixhG/w8rf
         1jjZKeZ9A1I83U76NOmM9pU19JE2srTrOjhR3aDeN3KiyJBRO4kzFCWz0qEkXYVlbXFQ
         G7fg==
X-Gm-Message-State: AOJu0YxHzi1wfFoffnmi0kEyEGmjiYhCu7+vDcoK0IYDTvdBF3yP/nrQ
        jviDaMjeXvm56gR5SmxEAx7qTQ==
X-Google-Smtp-Source: AGHT+IGIqYCOlzlKtMXJVvfx2IZ2REpgcTE7xG28KEZiT2qVxkpmUZgkVnZnDgGmqxIHZB+3fu00/w==
X-Received: by 2002:a17:907:9187:b0:a04:1714:539d with SMTP id bp7-20020a170907918700b00a041714539dmr10358275ejb.55.1701268865932;
        Wed, 29 Nov 2023 06:41:05 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906285500b00a0179ebc25esm7965638ejc.85.2023.11.29.06.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:41:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 15:41:01 +0100
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM6115 NoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-6115icc-v3-1-bd8907b8cfd7@linaro.org>
References: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
In-Reply-To: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701268861; l=7801;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8Ybxwq3bSFbHr5wYpl4WXvhpK9emTDOCAH9yeI0PfQc=;
 b=aa++H1T03Nn9WxucYcwftbwibLlV6ecWGtc+Ip7lR17nI7aXmxgD/USOe+OvssSN6LawTxl3e
 /aeQgD8t7a+DsMFphxCI869zzlRyG0W/LO5qy/2Il2OMOSOf5KlRLDM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm SM6115 Network-On-Chip interconnect.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,sm6115.yaml         | 152 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sm6115.h     | 111 +++++++++++++++
 2 files changed, 263 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
new file mode 100644
index 000000000000..14b1a0b08e73
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm6115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6115 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description:
+  The Qualcomm SM6115 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-bimc
+      - qcom,sm6115-cnoc
+      - qcom,sm6115-snoc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    $ref: qcom,rpm-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm6115-clk-virt
+          - qcom,sm6115-mmrt-virt
+          - qcom,sm6115-mmnrt-virt
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm6115-cnoc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: USB-NoC AXI clock
+
+        clock-names:
+          items:
+            - const: usb_axi
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm6115-snoc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: CPU-NoC AXI clock.
+            - description: UFS-NoC AXI clock.
+            - description: USB-NoC AXI clock.
+            - description: IPA clock.
+
+        clock-names:
+          items:
+            - const: cpu_axi
+            - const: ufs_axi
+            - const: usb_axi
+            - const: ipa
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6115-bimc
+            - qcom,sm6115-clk-virt
+            - qcom,sm6115-mmrt-virt
+            - qcom,sm6115-mmnrt-virt
+
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    snoc: interconnect@1880000 {
+        compatible = "qcom,sm6115-snoc";
+        reg = <0x01880000 0x60200>;
+        clocks = <&gcc GCC_SYS_NOC_CPUSS_AHB_CLK>,
+                 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
+                 <&rpmcc RPM_SMD_IPA_CLK>;
+        clock-names = "cpu_axi",
+                      "ufs_axi",
+                      "usb_axi",
+                      "ipa";
+        #interconnect-cells = <1>;
+
+        qup_virt: interconnect-clk {
+            compatible = "qcom,sm6115-clk-virt";
+            #interconnect-cells = <1>;
+        };
+
+        mmnrt_virt: interconnect-mmnrt {
+            compatible = "qcom,sm6115-mmnrt-virt";
+            #interconnect-cells = <1>;
+        };
+
+        mmrt_virt: interconnect-mmrt {
+            compatible = "qcom,sm6115-mmrt-virt";
+            #interconnect-cells = <1>;
+        };
+    };
+
+    cnoc: interconnect@1900000 {
+        compatible = "qcom,sm6115-cnoc";
+        reg = <0x01900000 0x8200>;
+        #interconnect-cells = <1>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm6115.h b/include/dt-bindings/interconnect/qcom,sm6115.h
new file mode 100644
index 000000000000..21090e585f05
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm6115.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM6115_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM6115_H
+
+/* BIMC */
+#define MASTER_AMPSS_M0				0
+#define MASTER_SNOC_BIMC_RT			1
+#define MASTER_SNOC_BIMC_NRT			2
+#define SNOC_BIMC_MAS				3
+#define MASTER_GRAPHICS_3D			4
+#define MASTER_TCU_0				5
+#define SLAVE_EBI_CH0				6
+#define BIMC_SNOC_SLV				7
+
+/* CNOC */
+#define SNOC_CNOC_MAS				0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_USB			2
+#define SLAVE_APSS_THROTTLE_CFG			3
+#define SLAVE_BIMC_CFG				4
+#define SLAVE_BOOT_ROM				5
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG		6
+#define SLAVE_CAMERA_RT_THROTTLE_CFG		7
+#define SLAVE_CAMERA_CFG			8
+#define SLAVE_CLK_CTL				9
+#define SLAVE_RBCPR_CX_CFG			10
+#define SLAVE_RBCPR_MX_CFG			11
+#define SLAVE_CRYPTO_0_CFG			12
+#define SLAVE_DCC_CFG				13
+#define SLAVE_DDR_PHY_CFG			14
+#define SLAVE_DDR_SS_CFG			15
+#define SLAVE_DISPLAY_CFG			16
+#define SLAVE_DISPLAY_THROTTLE_CFG		17
+#define SLAVE_GPU_CFG				18
+#define SLAVE_GPU_THROTTLE_CFG			19
+#define SLAVE_HWKM_CORE				20
+#define SLAVE_IMEM_CFG				21
+#define SLAVE_IPA_CFG				22
+#define SLAVE_LPASS				23
+#define SLAVE_MAPSS				24
+#define SLAVE_MDSP_MPU_CFG			25
+#define SLAVE_MESSAGE_RAM			26
+#define SLAVE_CNOC_MSS				27
+#define SLAVE_PDM				28
+#define SLAVE_PIMEM_CFG				29
+#define SLAVE_PKA_CORE				30
+#define SLAVE_PMIC_ARB				31
+#define SLAVE_QDSS_CFG				32
+#define SLAVE_QM_CFG				33
+#define SLAVE_QM_MPU_CFG			34
+#define SLAVE_QPIC				35
+#define SLAVE_QUP_0				36
+#define SLAVE_RPM				37
+#define SLAVE_SDCC_1				38
+#define SLAVE_SDCC_2				39
+#define SLAVE_SECURITY				40
+#define SLAVE_SNOC_CFG				41
+#define SLAVE_TCSR				42
+#define SLAVE_TLMM				43
+#define SLAVE_USB3				44
+#define SLAVE_VENUS_CFG				45
+#define SLAVE_VENUS_THROTTLE_CFG		46
+#define SLAVE_VSENSE_CTRL_CFG			47
+#define SLAVE_SERVICE_CNOC			48
+
+/* SNOC */
+#define MASTER_CRYPTO_CORE0			0
+#define MASTER_SNOC_CFG				1
+#define MASTER_TIC				2
+#define MASTER_ANOC_SNOC			3
+#define BIMC_SNOC_MAS				4
+#define MASTER_PIMEM				5
+#define MASTER_QDSS_BAM				6
+#define MASTER_QPIC				7
+#define MASTER_QUP_0				8
+#define MASTER_IPA				9
+#define MASTER_QDSS_ETR				10
+#define MASTER_SDCC_1				11
+#define MASTER_SDCC_2				12
+#define MASTER_USB3				13
+#define SLAVE_APPSS				14
+#define SNOC_CNOC_SLV				15
+#define SLAVE_OCIMEM				16
+#define SLAVE_PIMEM				17
+#define SNOC_BIMC_SLV				18
+#define SLAVE_SERVICE_SNOC			19
+#define SLAVE_QDSS_STM				20
+#define SLAVE_TCU				21
+#define SLAVE_ANOC_SNOC				22
+
+/* CLK Virtual */
+#define MASTER_QUP_CORE_0			0
+#define SLAVE_QUP_CORE_0			1
+
+/* MMRT Virtual */
+#define MASTER_CAMNOC_HF			0
+#define MASTER_MDP_PORT0			1
+#define SLAVE_SNOC_BIMC_RT			2
+
+/* MMNRT Virtual */
+#define MASTER_CAMNOC_SF			0
+#define MASTER_VIDEO_P0				1
+#define MASTER_VIDEO_PROC			2
+#define SLAVE_SNOC_BIMC_NRT			3
+
+#endif

-- 
2.43.0

