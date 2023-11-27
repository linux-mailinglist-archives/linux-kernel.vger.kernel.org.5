Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F184C7F9E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjK0LLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjK0LLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:11:05 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506EF136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:11:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5098e423ba2so5812613e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701083466; x=1701688266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrH/JGlM/sEwiQVmTMXaMn2giY8tjo5E5+l9Dv01fks=;
        b=SQmltOjmiQojBsJv+PVZEYt7DSKLS3c63+V9JbNgMtnG+1IQDeC1BoyAfYRrO4V+uH
         6pOx4iq2IElpA0FT73qaZxPMFFPyF77evQKfXvATR0WJwvnqfPYtUUj3KVFSop8Fj2VJ
         nzHQ4Bg2m3NOlTlsYfWnFvyK/gbMWmic+Lrh2RskHMErbYSkjNcBy6RvYhPkFqLJivq3
         UeHJA3JIa2zWO2DIi9e62nHPiJKaULS0ILFkw+suvZqlWx6eDQnJPkpFa2yYy12ChhZi
         4ACHsCp5zYEYmmQ6DLPmtMlRCfWFWTuAoX1riKpa89LpipdZy0QrwIwUZH8I4vVxaB0O
         Fj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701083466; x=1701688266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrH/JGlM/sEwiQVmTMXaMn2giY8tjo5E5+l9Dv01fks=;
        b=pbfKhyzETjtdNf5oFHhyGexeCL62nc7vRVI8R11+2uMtatyF67r6/r3IPBFDiRoegt
         bUq835qG6MWP4+lOcmJ9srIHKiX1y2916F+4apMMaZpoO48Xv0xqYcW5xjsV4ek+B+cS
         w5NuLlyY1mMckPgCbEoWhGVHElPKwVUobjcpAEzE4k2qJVaGO5UMxLEoOFRGeK9DMkay
         IM8wZj5AQ5m6Z/vQKs1dZgsicfBZUT/CJ7c1kCvJPd1Flk8/83+dYK0RGaSbsPd3bBh3
         anNfhgPcQScHPfkOASURA+OBNU0iFonrEx24Hf7iNhm9e3wpCGJlRGbSBk+dRGBi73Ao
         Zdig==
X-Gm-Message-State: AOJu0YwBG76Ij7spmhKIe0SojrzqV9gLflbJCx4D6sRuX701GCKFWg/b
        pOuX3k5Kegc602VObUV2VEQtmA==
X-Google-Smtp-Source: AGHT+IHWP9VhnwnJLkrxRvbBNHAddZ6lotrgtblwr4/l/QgTQiFXyEV+kfqFzmjvCHwfeBh+ms7xRA==
X-Received: by 2002:a05:6512:41b:b0:50b:aa9b:c9ca with SMTP id u27-20020a056512041b00b0050baa9bc9camr4039264lfk.57.1701083466350;
        Mon, 27 Nov 2023 03:11:06 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906089b00b009fe0902961bsm5537329eje.23.2023.11.27.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:11:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 12:10:59 +0100
Subject: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SM6115 NoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-6115icc-v2-1-69d05d90871b@linaro.org>
References: <20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org>
In-Reply-To: <20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701083462; l=7746;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=E4y7x9DxUyUwxdcFN78HbP+Sm7ZTeBa28I4zBkYFbuw=;
 b=RJmfm6+IjmfA1owI6JWQqqhPM/ZJ5z5q/zOdH6gldOBRmeXXgvCDSv76VIJXECKarD/AHM+vX
 o4ly0sro76UBEEbqCZoWKNwxyrRphX7+nRs0tFG2ioswi+vJWodoLX+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm SM6115 Network-On-Chip interconnect.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,sm6115.yaml         | 148 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sm6115.h     | 111 ++++++++++++++++
 2 files changed, 259 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
new file mode 100644
index 000000000000..279c8a5070ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
@@ -0,0 +1,148 @@
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

