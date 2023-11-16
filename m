Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638097EE4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjKPPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbjKPPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:54:28 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BCA5;
        Thu, 16 Nov 2023 07:54:23 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGARpgY007319;
        Thu, 16 Nov 2023 16:53:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=KRA2udpuhlJzs3GHkhImi1brRnjKmCmxOVNos6Ie3A0=; b=qL
        VlepB9clVgh/12vfgeGJ0Nc+XNIyUCyN91NGs/1cZW3bDm1izpRivK79ANfUxLbx
        RoZCwRiW92pP09hXNKgGku6XZaKWaeGM1HZAJTCdvjODGAPdLhKRxoeRT7Bl+yba
        1Ej6V6YuqK+wR8RN7vLs5nZJBOxoB+cfbIYRGbMpBUKDiBhn9bSj1Ckyn3YNG6K9
        eodPlLpx8sKs70PQRN9M8DHUmnxzlFr4xRWHTBG/6XiRgfHB0y8b9hVG1Df7jLav
        LJ8IXDVqFFIxq3XJKGNyf7DQd07ixjJRqn5M3NruDdmW4wqiy5BfW6T7lqvuyAst
        umMOYY4iE6lJuadiYG/Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u9ym8ymf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 16:53:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA08A10005A;
        Thu, 16 Nov 2023 16:53:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE274237D88;
        Thu, 16 Nov 2023 16:53:50 +0100 (CET)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 16 Nov
 2023 16:53:50 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform
Date:   Thu, 16 Nov 2023 16:49:50 +0100
Message-ID: <20231116154952.1206705-4-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116154952.1206705-1-gabriel.fernandez@foss.st.com>
References: <20231116154952.1206705-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_16,2023-11-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Adds clock and reset binding entries for STM32MP25 SoC family

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 .../bindings/clock/st,stm32mp25-rcc.yaml      |  72 +++
 include/dt-bindings/clock/st,stm32mp25-rcc.h  | 492 ++++++++++++++++++
 include/dt-bindings/reset/st,stm32mp25-rcc.h  | 165 ++++++
 3 files changed, 729 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
 create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
 create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
new file mode 100644
index 000000000000..1bdcfacd62d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/st,stm32mp25-rcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP25 Reset Clock Controller
+
+maintainers:
+  - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
+
+description: |
+  The RCC hardware block is both a reset and a clock controller.
+  RCC makes also power management (resume/supend).
+
+  See also::
+    include/dt-bindings/clock/st,stm32mp25-rcc.h
+    include/dt-bindings/reset/st,stm32mp25-rcc.h
+
+properties:
+  compatible:
+    enum:
+      - st,stm32mp25-rcc
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
+  clocks:
+    description: Specifies oscillators.
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: hse
+      - const: hsi
+      - const: msi
+      - const: lse
+      - const: lsi
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+
+    rcc: clock-controller@44200000 {
+        compatible = "st,stm32mp25-rcc";
+        reg = <0x44200000 0x10000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        clock-names = "hse", "hsi", "msi", "lse", "lsi";
+        clocks = <&scmi_clk CK_SCMI_HSE>,
+                 <&scmi_clk CK_SCMI_HSI>,
+                 <&scmi_clk CK_SCMI_MSI>,
+                 <&scmi_clk CK_SCMI_LSE>,
+                 <&scmi_clk CK_SCMI_LSI>;
+    };
+...
diff --git a/include/dt-bindings/clock/st,stm32mp25-rcc.h b/include/dt-bindings/clock/st,stm32mp25-rcc.h
new file mode 100644
index 000000000000..9876ee0dd1e4
--- /dev/null
+++ b/include/dt-bindings/clock/st,stm32mp25-rcc.h
@@ -0,0 +1,492 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
+ */
+
+#ifndef _DT_BINDINGS_STM32MP25_CLKS_H_
+#define _DT_BINDINGS_STM32MP25_CLKS_H_
+
+/* INTERNAL/EXTERNAL OSCILLATORS */
+#define HSI_CK			0
+#define HSE_CK			1
+#define MSI_CK			2
+#define LSI_CK			3
+#define LSE_CK			4
+#define I2S_CK			5
+#define RTC_CK			6
+#define SPDIF_CK_SYMB		7
+
+/* PLL CLOCKS */
+#define PLL1_CK			8
+#define PLL2_CK			9
+#define PLL3_CK			10
+#define PLL4_CK			11
+#define PLL5_CK			12
+#define PLL6_CK			13
+#define PLL7_CK			14
+#define PLL8_CK			15
+
+#define CK_CPU1			16
+
+/* APB DIV CLOCKS */
+#define CK_ICN_APB1		17
+#define CK_ICN_APB2		18
+#define CK_ICN_APB3		19
+#define CK_ICN_APB4		20
+#define CK_ICN_APBDBG		21
+
+/* GLOBAL TIMER */
+#define TIMG1_CK		22
+#define TIMG2_CK		23
+
+/* FLEXGEN CLOCKS */
+#define CK_ICN_HS_MCU		24
+#define CK_ICN_SDMMC		25
+#define CK_ICN_DDR		26
+#define CK_ICN_DISPLAY		27
+#define CK_ICN_HSL		28
+#define CK_ICN_NIC		29
+#define CK_ICN_VID		30
+#define CK_FLEXGEN_07		31
+#define CK_FLEXGEN_08		32
+#define CK_FLEXGEN_09		33
+#define CK_FLEXGEN_10		34
+#define CK_FLEXGEN_11		35
+#define CK_FLEXGEN_12		36
+#define CK_FLEXGEN_13		37
+#define CK_FLEXGEN_14		38
+#define CK_FLEXGEN_15		39
+#define CK_FLEXGEN_16		40
+#define CK_FLEXGEN_17		41
+#define CK_FLEXGEN_18		42
+#define CK_FLEXGEN_19		43
+#define CK_FLEXGEN_20		44
+#define CK_FLEXGEN_21		45
+#define CK_FLEXGEN_22		46
+#define CK_FLEXGEN_23		47
+#define CK_FLEXGEN_24		48
+#define CK_FLEXGEN_25		49
+#define CK_FLEXGEN_26		50
+#define CK_FLEXGEN_27		51
+#define CK_FLEXGEN_28		52
+#define CK_FLEXGEN_29		53
+#define CK_FLEXGEN_30		54
+#define CK_FLEXGEN_31		55
+#define CK_FLEXGEN_32		56
+#define CK_FLEXGEN_33		57
+#define CK_FLEXGEN_34		58
+#define CK_FLEXGEN_35		59
+#define CK_FLEXGEN_36		60
+#define CK_FLEXGEN_37		61
+#define CK_FLEXGEN_38		62
+#define CK_FLEXGEN_39		63
+#define CK_FLEXGEN_40		64
+#define CK_FLEXGEN_41		65
+#define CK_FLEXGEN_42		66
+#define CK_FLEXGEN_43		67
+#define CK_FLEXGEN_44		68
+#define CK_FLEXGEN_45		69
+#define CK_FLEXGEN_46		70
+#define CK_FLEXGEN_47		71
+#define CK_FLEXGEN_48		72
+#define CK_FLEXGEN_49		73
+#define CK_FLEXGEN_50		74
+#define CK_FLEXGEN_51		75
+#define CK_FLEXGEN_52		76
+#define CK_FLEXGEN_53		77
+#define CK_FLEXGEN_54		78
+#define CK_FLEXGEN_55		79
+#define CK_FLEXGEN_56		80
+#define CK_FLEXGEN_57		81
+#define CK_FLEXGEN_58		82
+#define CK_FLEXGEN_59		83
+#define CK_FLEXGEN_60		84
+#define CK_FLEXGEN_61		85
+#define CK_FLEXGEN_62		86
+#define CK_FLEXGEN_63		87
+
+/* LOW SPEED MCU CLOCK */
+#define CK_ICN_LS_MCU		88
+
+#define CK_BUS_STM500		89
+#define CK_BUS_FMC		90
+#define CK_BUS_GPU		91
+#define CK_BUS_ETH1		92
+#define CK_BUS_ETH2		93
+#define CK_BUS_PCIE		94
+#define CK_BUS_DDRPHYC		95
+#define CK_BUS_SYSCPU1		96
+#define CK_BUS_ETHSW		97
+#define CK_BUS_HPDMA1		98
+#define CK_BUS_HPDMA2		99
+#define CK_BUS_HPDMA3		100
+#define CK_BUS_ADC12		101
+#define CK_BUS_ADC3		102
+#define CK_BUS_IPCC1		103
+#define CK_BUS_CCI		104
+#define CK_BUS_CRC		105
+#define CK_BUS_MDF1		106
+#define CK_BUS_OSPIIOM		107
+#define CK_BUS_BKPSRAM		108
+#define CK_BUS_HASH		109
+#define CK_BUS_RNG		110
+#define CK_BUS_CRYP1		111
+#define CK_BUS_CRYP2		112
+#define CK_BUS_SAES		113
+#define CK_BUS_PKA		114
+#define CK_BUS_GPIOA		115
+#define CK_BUS_GPIOB		116
+#define CK_BUS_GPIOC		117
+#define CK_BUS_GPIOD		118
+#define CK_BUS_GPIOE		119
+#define CK_BUS_GPIOF		120
+#define CK_BUS_GPIOG		121
+#define CK_BUS_GPIOH		122
+#define CK_BUS_GPIOI		123
+#define CK_BUS_GPIOJ		124
+#define CK_BUS_GPIOK		125
+#define CK_BUS_LPSRAM1		126
+#define CK_BUS_LPSRAM2		127
+#define CK_BUS_LPSRAM3		128
+#define CK_BUS_GPIOZ		129
+#define CK_BUS_LPDMA		130
+#define CK_BUS_HSEM		131
+#define CK_BUS_IPCC2		132
+#define CK_BUS_RTC		133
+#define CK_BUS_SPI8		134
+#define CK_BUS_LPUART1		135
+#define CK_BUS_I2C8		136
+#define CK_BUS_LPTIM3		137
+#define CK_BUS_LPTIM4		138
+#define CK_BUS_LPTIM5		139
+#define CK_BUS_IWDG5		140
+#define CK_BUS_WWDG2		141
+#define CK_BUS_I3C4		142
+#define CK_BUS_TIM2		143
+#define CK_BUS_TIM3		144
+#define CK_BUS_TIM4		145
+#define CK_BUS_TIM5		146
+#define CK_BUS_TIM6		147
+#define CK_BUS_TIM7		148
+#define CK_BUS_TIM10		149
+#define CK_BUS_TIM11		150
+#define CK_BUS_TIM12		151
+#define CK_BUS_TIM13		152
+#define CK_BUS_TIM14		153
+#define CK_BUS_LPTIM1		154
+#define CK_BUS_LPTIM2		155
+#define CK_BUS_SPI2		156
+#define CK_BUS_SPI3		157
+#define CK_BUS_SPDIFRX		158
+#define CK_BUS_USART2		159
+#define CK_BUS_USART3		160
+#define CK_BUS_UART4		161
+#define CK_BUS_UART5		162
+#define CK_BUS_I2C1		163
+#define CK_BUS_I2C2		164
+#define CK_BUS_I2C3		165
+#define CK_BUS_I2C4		166
+#define CK_BUS_I2C5		167
+#define CK_BUS_I2C6		168
+#define CK_BUS_I2C7		169
+#define CK_BUS_I3C1		170
+#define CK_BUS_I3C2		171
+#define CK_BUS_I3C3		172
+#define CK_BUS_TIM1		173
+#define CK_BUS_TIM8		174
+#define CK_BUS_TIM15		175
+#define CK_BUS_TIM16		176
+#define CK_BUS_TIM17		177
+#define CK_BUS_TIM20		178
+#define CK_BUS_SAI1		179
+#define CK_BUS_SAI2		180
+#define CK_BUS_SAI3		181
+#define CK_BUS_SAI4		182
+#define CK_BUS_USART1		183
+#define CK_BUS_USART6		184
+#define CK_BUS_UART7		185
+#define CK_BUS_UART8		186
+#define CK_BUS_UART9		187
+#define CK_BUS_FDCAN		188
+#define CK_BUS_SPI1		189
+#define CK_BUS_SPI4		190
+#define CK_BUS_SPI5		191
+#define CK_BUS_SPI6		192
+#define CK_BUS_SPI7		193
+#define CK_BUS_BSEC		194
+#define CK_BUS_IWDG1		195
+#define CK_BUS_IWDG2		196
+#define CK_BUS_IWDG3		197
+#define CK_BUS_IWDG4		198
+#define CK_BUS_WWDG1		199
+#define CK_BUS_VREF		200
+#define CK_BUS_DTS		201
+#define CK_BUS_SERC		202
+#define CK_BUS_HDP		203
+#define CK_BUS_IS2M		204
+#define CK_BUS_DSI		205
+#define CK_BUS_LTDC		206
+#define CK_BUS_CSI		207
+#define CK_BUS_DCMIPP		208
+#define CK_BUS_DDRC		209
+#define CK_BUS_DDRCFG		210
+#define CK_BUS_GICV2M		211
+#define CK_BUS_USBTC		212
+#define CK_BUS_USB3PCIEPHY	214
+#define CK_BUS_STGEN		215
+#define CK_BUS_VDEC		216
+#define CK_BUS_VENC		217
+#define CK_SYSDBG		218
+#define CK_KER_TIM2		219
+#define CK_KER_TIM3		220
+#define CK_KER_TIM4		221
+#define CK_KER_TIM5		222
+#define CK_KER_TIM6		223
+#define CK_KER_TIM7		224
+#define CK_KER_TIM10		225
+#define CK_KER_TIM11		226
+#define CK_KER_TIM12		227
+#define CK_KER_TIM13		228
+#define CK_KER_TIM14		229
+#define CK_KER_TIM1		230
+#define CK_KER_TIM8		231
+#define CK_KER_TIM15		232
+#define CK_KER_TIM16		233
+#define CK_KER_TIM17		234
+#define CK_KER_TIM20		235
+#define CK_BUS_SYSRAM		236
+#define CK_BUS_VDERAM		237
+#define CK_BUS_RETRAM		238
+#define CK_BUS_OSPI1		239
+#define CK_BUS_OSPI2		240
+#define CK_BUS_OTFD1		241
+#define CK_BUS_OTFD2		242
+#define CK_BUS_SRAM1		243
+#define CK_BUS_SRAM2		244
+#define CK_BUS_SDMMC1		245
+#define CK_BUS_SDMMC2		246
+#define CK_BUS_SDMMC3		247
+#define CK_BUS_DDR		248
+#define CK_BUS_RISAF4		249
+#define CK_BUS_USB2OHCI		250
+#define CK_BUS_USB2EHCI		251
+#define CK_BUS_USB3DR		252
+#define CK_KER_LPTIM1		253
+#define CK_KER_LPTIM2		254
+#define CK_KER_USART2		255
+#define CK_KER_UART4		256
+#define CK_KER_USART3		257
+#define CK_KER_UART5		258
+#define CK_KER_SPI2		259
+#define CK_KER_SPI3		260
+#define CK_KER_SPDIFRX		261
+#define CK_KER_I2C1		262
+#define CK_KER_I2C2		263
+#define CK_KER_I3C1		264
+#define CK_KER_I3C2		265
+#define CK_KER_I2C3		266
+#define CK_KER_I2C5		267
+#define CK_KER_I3C3		268
+#define CK_KER_I2C4		269
+#define CK_KER_I2C6		270
+#define CK_KER_I2C7		271
+#define CK_KER_SPI1		272
+#define CK_KER_SPI4		273
+#define CK_KER_SPI5		274
+#define CK_KER_SPI6		275
+#define CK_KER_SPI7		276
+#define CK_KER_USART1		277
+#define CK_KER_USART6		278
+#define CK_KER_UART7		279
+#define CK_KER_UART8		280
+#define CK_KER_UART9		281
+#define CK_KER_MDF1		282
+#define CK_KER_SAI1		283
+#define CK_KER_SAI2		284
+#define CK_KER_SAI3		285
+#define CK_KER_SAI4		286
+#define CK_KER_FDCAN		287
+#define CK_KER_DSIBLANE		288
+#define CK_KER_DSIPHY		289
+#define CK_KER_CSI		290
+#define CK_KER_CSITXESC		291
+#define CK_KER_CSIPHY		292
+#define CK_KER_LVDSPHY		293
+#define CK_KER_STGEN		294
+#define CK_KER_USB3PCIEPHY	295
+#define CK_KER_USB2PHY2EN	296
+#define CK_KER_I3C4		297
+#define CK_KER_SPI8		298
+#define CK_KER_I2C8		299
+#define CK_KER_LPUART1		300
+#define CK_KER_LPTIM3		301
+#define CK_KER_LPTIM4		302
+#define CK_KER_LPTIM5		303
+#define CK_KER_TSDBG		304
+#define CK_KER_TPIU		305
+#define CK_BUS_ETR		306
+#define CK_BUS_SYSATB		307
+#define CK_KER_ADC12		308
+#define CK_KER_ADC3		309
+#define CK_KER_OSPI1		310
+#define CK_KER_OSPI2		311
+#define CK_KER_FMC		312
+#define CK_KER_SDMMC1		313
+#define CK_KER_SDMMC2		314
+#define CK_KER_SDMMC3		315
+#define CK_KER_ETH1		316
+#define CK_KER_ETH2		317
+#define CK_KER_ETH1PTP		318
+#define CK_KER_ETH2PTP		319
+#define CK_KER_USB2PHY1		320
+#define CK_KER_USB2PHY2		321
+#define CK_KER_ETHSW		322
+#define CK_KER_ETHSWREF		323
+#define CK_MCO1			324
+#define CK_MCO2			325
+#define CK_KER_DTS		326
+#define CK_ETH1_RX		327
+#define CK_ETH1_TX		328
+#define CK_ETH1_MAC		329
+#define CK_ETH2_RX		330
+#define CK_ETH2_TX		331
+#define CK_ETH2_MAC		332
+#define CK_ETH1_STP		333
+#define CK_ETH2_STP		334
+#define CK_KER_USBTC		335
+#define CK_BUS_ADF1		336
+#define CK_KER_ADF1		337
+#define CK_BUS_LVDS		338
+#define CK_KER_LTDC		339
+#define CK_KER_GPU		340
+#define CK_BUS_ETHSWACMCFG	341
+#define CK_BUS_ETHSWACMMSG	342
+#define HSE_DIV2_CK		343
+
+#define STM32MP25_LAST_CLK	344
+
+#define CK_SCMI_ICN_HS_MCU	0
+#define CK_SCMI_ICN_SDMMC	1
+#define CK_SCMI_ICN_DDR		2
+#define CK_SCMI_ICN_DISPLAY	3
+#define CK_SCMI_ICN_HSL		4
+#define CK_SCMI_ICN_NIC		5
+#define CK_SCMI_ICN_VID		6
+#define CK_SCMI_FLEXGEN_07	7
+#define CK_SCMI_FLEXGEN_08	8
+#define CK_SCMI_FLEXGEN_09	9
+#define CK_SCMI_FLEXGEN_10	10
+#define CK_SCMI_FLEXGEN_11	11
+#define CK_SCMI_FLEXGEN_12	12
+#define CK_SCMI_FLEXGEN_13	13
+#define CK_SCMI_FLEXGEN_14	14
+#define CK_SCMI_FLEXGEN_15	15
+#define CK_SCMI_FLEXGEN_16	16
+#define CK_SCMI_FLEXGEN_17	17
+#define CK_SCMI_FLEXGEN_18	18
+#define CK_SCMI_FLEXGEN_19	19
+#define CK_SCMI_FLEXGEN_20	20
+#define CK_SCMI_FLEXGEN_21	21
+#define CK_SCMI_FLEXGEN_22	22
+#define CK_SCMI_FLEXGEN_23	23
+#define CK_SCMI_FLEXGEN_24	24
+#define CK_SCMI_FLEXGEN_25	25
+#define CK_SCMI_FLEXGEN_26	26
+#define CK_SCMI_FLEXGEN_27	27
+#define CK_SCMI_FLEXGEN_28	28
+#define CK_SCMI_FLEXGEN_29	29
+#define CK_SCMI_FLEXGEN_30	30
+#define CK_SCMI_FLEXGEN_31	31
+#define CK_SCMI_FLEXGEN_32	32
+#define CK_SCMI_FLEXGEN_33	33
+#define CK_SCMI_FLEXGEN_34	34
+#define CK_SCMI_FLEXGEN_35	35
+#define CK_SCMI_FLEXGEN_36	36
+#define CK_SCMI_FLEXGEN_37	37
+#define CK_SCMI_FLEXGEN_38	38
+#define CK_SCMI_FLEXGEN_39	39
+#define CK_SCMI_FLEXGEN_40	40
+#define CK_SCMI_FLEXGEN_41	41
+#define CK_SCMI_FLEXGEN_42	42
+#define CK_SCMI_FLEXGEN_43	43
+#define CK_SCMI_FLEXGEN_44	44
+#define CK_SCMI_FLEXGEN_45	45
+#define CK_SCMI_FLEXGEN_46	46
+#define CK_SCMI_FLEXGEN_47	47
+#define CK_SCMI_FLEXGEN_48	48
+#define CK_SCMI_FLEXGEN_49	49
+#define CK_SCMI_FLEXGEN_50	50
+#define CK_SCMI_FLEXGEN_51	51
+#define CK_SCMI_FLEXGEN_52	52
+#define CK_SCMI_FLEXGEN_53	53
+#define CK_SCMI_FLEXGEN_54	54
+#define CK_SCMI_FLEXGEN_55	55
+#define CK_SCMI_FLEXGEN_56	56
+#define CK_SCMI_FLEXGEN_57	57
+#define CK_SCMI_FLEXGEN_58	58
+#define CK_SCMI_FLEXGEN_59	59
+#define CK_SCMI_FLEXGEN_60	60
+#define CK_SCMI_FLEXGEN_61	61
+#define CK_SCMI_FLEXGEN_62	62
+#define CK_SCMI_FLEXGEN_63	63
+#define CK_SCMI_ICN_LS_MCU	64
+#define CK_SCMI_HSE		65
+#define CK_SCMI_LSE		66
+#define CK_SCMI_HSI		67
+#define CK_SCMI_LSI		68
+#define CK_SCMI_MSI		69
+#define CK_SCMI_HSE_DIV2	70
+#define CK_SCMI_CPU1		71
+#define CK_SCMI_SYSCPU1		72
+#define CK_SCMI_PLL2		73
+#define CK_SCMI_PLL3		74
+#define CK_SCMI_RTC		75
+#define CK_SCMI_RTCCK		76
+#define CK_SCMI_ICN_APB1	77
+#define CK_SCMI_ICN_APB2	78
+#define CK_SCMI_ICN_APB3	79
+#define CK_SCMI_ICN_APB4	80
+#define CK_SCMI_ICN_APBDBG	81
+#define CK_SCMI_TIMG1		82
+#define CK_SCMI_TIMG2		83
+#define CK_SCMI_BKPSRAM		84
+#define CK_SCMI_BSEC		85
+#define CK_SCMI_ETR		87
+#define CK_SCMI_FMC		88
+#define CK_SCMI_GPIOA		89
+#define CK_SCMI_GPIOB		90
+#define CK_SCMI_GPIOC		91
+#define CK_SCMI_GPIOD		92
+#define CK_SCMI_GPIOE		93
+#define CK_SCMI_GPIOF		94
+#define CK_SCMI_GPIOG		95
+#define CK_SCMI_GPIOH		96
+#define CK_SCMI_GPIOI		97
+#define CK_SCMI_GPIOJ		98
+#define CK_SCMI_GPIOK		99
+#define CK_SCMI_GPIOZ		100
+#define CK_SCMI_HPDMA1		101
+#define CK_SCMI_HPDMA2		102
+#define CK_SCMI_HPDMA3		103
+#define CK_SCMI_HSEM		104
+#define CK_SCMI_IPCC1		105
+#define CK_SCMI_IPCC2		106
+#define CK_SCMI_LPDMA		107
+#define CK_SCMI_RETRAM		108
+#define CK_SCMI_SRAM1		109
+#define CK_SCMI_SRAM2		110
+#define CK_SCMI_LPSRAM1		111
+#define CK_SCMI_LPSRAM2		112
+#define CK_SCMI_LPSRAM3		113
+#define CK_SCMI_VDERAM		114
+#define CK_SCMI_SYSRAM		115
+#define CK_SCMI_OSPI1		116
+#define CK_SCMI_OSPI2		117
+#define CK_SCMI_TPIU		118
+#define CK_SCMI_SYSDBG		119
+#define CK_SCMI_SYSATB		120
+#define CK_SCMI_TSDBG		121
+#define CK_SCMI_STM500		122
+
+#endif /* _DT_BINDINGS_STM32MP25_CLKS_H_ */
diff --git a/include/dt-bindings/reset/st,stm32mp25-rcc.h b/include/dt-bindings/reset/st,stm32mp25-rcc.h
new file mode 100644
index 000000000000..c92370ba00ed
--- /dev/null
+++ b/include/dt-bindings/reset/st,stm32mp25-rcc.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author(s): Gabriel Fernandez <gabriel.fernandez@foss.st.com>
+ */
+
+#ifndef _DT_BINDINGS_STM32MP25_RESET_H_
+#define _DT_BINDINGS_STM32MP25_RESET_H_
+
+#define TIM1_R		1
+#define TIM2_R		2
+#define TIM3_R		3
+#define TIM4_R		4
+#define TIM5_R		5
+#define TIM6_R		6
+#define TIM7_R		7
+#define TIM8_R		8
+#define TIM10_R		9
+#define TIM11_R		10
+#define TIM12_R		11
+#define TIM13_R		12
+#define TIM14_R		13
+#define TIM15_R		14
+#define TIM16_R		15
+#define TIM17_R		16
+#define TIM20_R		17
+#define LPTIM1_R	18
+#define LPTIM2_R	19
+#define LPTIM3_R	20
+#define LPTIM4_R	21
+#define LPTIM5_R	22
+#define SPI1_R		23
+#define SPI2_R		24
+#define SPI3_R		25
+#define SPI4_R		26
+#define SPI5_R		27
+#define SPI6_R		28
+#define SPI7_R		29
+#define SPI8_R		30
+#define SPDIFRX_R	31
+#define USART1_R	32
+#define USART2_R	33
+#define USART3_R	34
+#define UART4_R		35
+#define UART5_R		36
+#define USART6_R	37
+#define UART7_R		38
+#define UART8_R		39
+#define UART9_R		40
+#define LPUART1_R	41
+#define IS2M_R		42
+#define I2C1_R		43
+#define I2C2_R		44
+#define I2C3_R		45
+#define I2C4_R		46
+#define I2C5_R		47
+#define I2C6_R		48
+#define I2C7_R		49
+#define I2C8_R		50
+#define SAI1_R		51
+#define SAI2_R		52
+#define SAI3_R		53
+#define SAI4_R		54
+#define MDF1_R		55
+#define MDF2_R		56
+#define FDCAN_R		57
+#define HDP_R		58
+#define ADC12_R		59
+#define ADC3_R		60
+#define ETH1_R		61
+#define ETH2_R		62
+#define USB2_R		63
+#define USB2PHY1_R	64
+#define USB2PHY2_R	65
+#define USB3DR_R	66
+#define USB3PCIEPHY_R	67
+#define USBTC_R		68
+#define ETHSW_R		69
+#define SDMMC1_R	70
+#define SDMMC1DLL_R	71
+#define SDMMC2_R	72
+#define SDMMC2DLL_R	73
+#define SDMMC3_R	74
+#define SDMMC3DLL_R	75
+#define GPU_R		76
+#define LTDC_R		77
+#define DSI_R		78
+#define LVDS_R		79
+#define CSI_R		80
+#define DCMIPP_R	81
+#define CCI_R		82
+#define VDEC_R		83
+#define VENC_R		84
+#define WWDG1_R		85
+#define WWDG2_R		86
+#define VREF_R		87
+#define DTS_R		88
+#define CRC_R		89
+#define SERC_R		90
+#define OSPIIOM_R	91
+#define I3C1_R		92
+#define I3C2_R		93
+#define I3C3_R		94
+#define I3C4_R		95
+#define IWDG2_KER_R	96
+#define IWDG4_KER_R	97
+#define RNG_R		98
+#define PKA_R		99
+#define SAES_R		100
+#define HASH_R		101
+#define CRYP1_R		102
+#define CRYP2_R		103
+#define PCIE_R		104
+#define OSPI1_R		105
+#define OSPI1DLL_R	106
+#define OSPI2_R		107
+#define OSPI2DLL_R	108
+#define FMC_R		109
+#define DBG_R		110
+#define GPIOA_R		111
+#define GPIOB_R		112
+#define GPIOC_R		113
+#define GPIOD_R		114
+#define GPIOE_R		115
+#define GPIOF_R		116
+#define GPIOG_R		117
+#define GPIOH_R		118
+#define GPIOI_R		119
+#define GPIOJ_R		120
+#define GPIOK_R		121
+#define GPIOZ_R		122
+#define HPDMA1_R	123
+#define HPDMA2_R	124
+#define HPDMA3_R	125
+#define LPDMA_R		126
+#define HSEM_R		127
+#define IPCC1_R		128
+#define IPCC2_R		129
+#define C2_HOLDBOOT_R	130
+#define C1_HOLDBOOT_R	131
+#define C1_R		132
+#define C1P1POR_R	133
+#define C1P1_R		134
+#define C2_R		135
+#define C3_R		136
+#define SYS_R		137
+#define VSW_R		138
+#define C1MS_R		139
+#define DDRCP_R		140
+#define DDRCAPB_R	141
+#define DDRPHYCAPB_R	142
+#define DDRCFG_R	143
+#define DDR_R		144
+
+#define RST_SCMI_C1_R		0
+#define RST_SCMI_C2_R		1
+#define RST_SCMI_C1_HOLDBOOT_R	2
+#define RST_SCMI_C2_HOLDBOOT_R	3
+#define RST_SCMI_FMC		4
+#define RST_SCMI_OSPI1		5
+#define RST_SCMI_OSPI1DLL	6
+#define RST_SCMI_OSPI2		7
+#define RST_SCMI_OSPI2DLL	8
+
+#endif /* _DT_BINDINGS_STM32MP25_RESET_H_ */
-- 
2.25.1

