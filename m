Return-Path: <linux-kernel+bounces-156288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE48B00D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A378283FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893B154C0F;
	Wed, 24 Apr 2024 05:11:27 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D11E868;
	Wed, 24 Apr 2024 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935487; cv=none; b=Rsv9k1vARDjogAJ5uE9+9BdQ3NZuPKjXPj/hYMhZKZeitAS4SxUi+GWWR5SD/vyaOD5jsy48KgfiQw5oSFWHEYqRkHTYeDUqC0wl2JMJZg2NkvVQZm1AORKsWoFVXpvL6Cx0VXs6kQYhjeFdNNVMFe3qRauMDuAY7XHBFY+jydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935487; c=relaxed/simple;
	bh=SSFAJUpb02iFZ0+qSaHkBCk1sa9KpZ3Dc9Sr2srIl9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/U6F16ERXw9az/ILF7D6nNDkUjO0658hlMHyqhVnAOtnTP8i9Py/u6GrV02haxeHFmyk/rrzJ5q9DoN7/JJonDScnH69Zx56eepvo3d0z7ctvj/+q/o8J+VrLl+DhCQS3FQu+rYzsScnCjOyiWpSN6zixtM4+oiCMnC5l6u4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Wed, 24 Apr 2024
 13:10:20 +0800
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
To: <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chuan Liu <chuan.liu@amlogic.com>
Subject: [PATCH v7 3/5] dt-bindings: clock: add Amlogic C3 peripherals clock controller
Date: Wed, 24 Apr 2024 13:09:26 +0800
Message-ID: <20240424050928.1997820-4-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the peripherals clock controller dt-bindings for Amlogic C3 SoC family

Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../clock/amlogic,c3-peripherals-clkc.yaml    | 120 ++++++++++
 .../clock/amlogic,c3-peripherals-clkc.h       | 212 ++++++++++++++++++
 2 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
new file mode 100644
index 000000000000..98e30b8c0529
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,c3-peripherals-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic C3 series Peripheral Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Chuan Liu <chuan.liu@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,c3-peripherals-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 16
+    items:
+      - description: input oscillator (usually at 24MHz)
+      - description: input oscillators multiplexer
+      - description: input fix pll
+      - description: input fclk div 2
+      - description: input fclk div 2p5
+      - description: input fclk div 3
+      - description: input fclk div 4
+      - description: input fclk div 5
+      - description: input fclk div 7
+      - description: input gp0 pll
+      - description: input gp1 pll
+      - description: input hifi pll
+      - description: input sys clk
+      - description: input axi clk
+      - description: input sys pll div 16
+      - description: input cpu clk div 16
+      - description: input pad clock for rtc clk (optional)
+
+  clock-names:
+    minItems: 16
+    items:
+      - const: xtal_24m
+      - const: oscin
+      - const: fix
+      - const: fdiv2
+      - const: fdiv2p5
+      - const: fdiv3
+      - const: fdiv4
+      - const: fdiv5
+      - const: fdiv7
+      - const: gp0
+      - const: gp1
+      - const: hifi
+      - const: sysclk
+      - const: axiclk
+      - const: sysplldiv16
+      - const: cpudiv16
+      - const: pad_osc
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@0 {
+            compatible = "amlogic,c3-peripherals-clkc";
+            reg = <0x0 0x0 0x0 0x49c>;
+            #clock-cells = <1>;
+            clocks = <&xtal_24m>,
+                     <&scmi_clk 8>,
+                     <&scmi_clk 12>,
+                     <&clkc_pll 3>,
+                     <&clkc_pll 5>,
+                     <&clkc_pll 7>,
+                     <&clkc_pll 9>,
+                     <&clkc_pll 11>,
+                     <&clkc_pll 13>,
+                     <&clkc_pll 15>,
+                     <&scmi_clk 13>,
+                     <&clkc_pll 17>,
+                     <&scmi_clk 9>,
+                     <&scmi_clk 10>,
+                     <&scmi_clk 14>,
+                     <&scmi_clk 15>;
+            clock-names = "xtal_24m",
+                          "oscin",
+                          "fix",
+                          "fdiv2",
+                          "fdiv2p5",
+                          "fdiv3",
+                          "fdiv4",
+                          "fdiv5",
+                          "fdiv7",
+                          "gp0",
+                          "gp1",
+                          "hifi",
+                          "sysclk",
+                          "axiclk",
+                          "sysplldiv16",
+                          "cpudiv16";
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
new file mode 100644
index 000000000000..d115c741c255
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
+
+#define CLKID_RTC_XTAL_CLKIN			0
+#define CLKID_RTC_32K_DIV			1
+#define CLKID_RTC_32K_MUX			2
+#define CLKID_RTC_32K				3
+#define CLKID_RTC_CLK				4
+#define CLKID_SYS_RESET_CTRL			5
+#define CLKID_SYS_PWR_CTRL			6
+#define CLKID_SYS_PAD_CTRL			7
+#define CLKID_SYS_CTRL				8
+#define CLKID_SYS_TS_PLL			9
+#define CLKID_SYS_DEV_ARB			10
+#define CLKID_SYS_MMC_PCLK			11
+#define CLKID_SYS_CPU_CTRL			12
+#define CLKID_SYS_JTAG_CTRL			13
+#define CLKID_SYS_IR_CTRL			14
+#define CLKID_SYS_IRQ_CTRL			15
+#define CLKID_SYS_MSR_CLK			16
+#define CLKID_SYS_ROM				17
+#define CLKID_SYS_UART_F			18
+#define CLKID_SYS_CPU_ARB			19
+#define CLKID_SYS_RSA				20
+#define CLKID_SYS_SAR_ADC			21
+#define CLKID_SYS_STARTUP			22
+#define CLKID_SYS_SECURE			23
+#define CLKID_SYS_SPIFC				24
+#define CLKID_SYS_NNA				25
+#define CLKID_SYS_ETH_MAC			26
+#define CLKID_SYS_GIC				27
+#define CLKID_SYS_RAMA				28
+#define CLKID_SYS_BIG_NIC			29
+#define CLKID_SYS_RAMB				30
+#define CLKID_SYS_AUDIO_PCLK			31
+#define CLKID_SYS_PWM_KL			32
+#define CLKID_SYS_PWM_IJ			33
+#define CLKID_SYS_USB				34
+#define CLKID_SYS_SD_EMMC_A			35
+#define CLKID_SYS_SD_EMMC_C			36
+#define CLKID_SYS_PWM_AB			37
+#define CLKID_SYS_PWM_CD			38
+#define CLKID_SYS_PWM_EF			39
+#define CLKID_SYS_PWM_GH			40
+#define CLKID_SYS_SPICC_1			41
+#define CLKID_SYS_SPICC_0			42
+#define CLKID_SYS_UART_A			43
+#define CLKID_SYS_UART_B			44
+#define CLKID_SYS_UART_C			45
+#define CLKID_SYS_UART_D			46
+#define CLKID_SYS_UART_E			47
+#define CLKID_SYS_I2C_M_A			48
+#define CLKID_SYS_I2C_M_B			49
+#define CLKID_SYS_I2C_M_C			50
+#define CLKID_SYS_I2C_M_D			51
+#define CLKID_SYS_I2S_S_A			52
+#define CLKID_SYS_RTC				53
+#define CLKID_SYS_GE2D				54
+#define CLKID_SYS_ISP				55
+#define CLKID_SYS_GPV_ISP_NIC			56
+#define CLKID_SYS_GPV_CVE_NIC			57
+#define CLKID_SYS_MIPI_DSI_HOST			58
+#define CLKID_SYS_MIPI_DSI_PHY			59
+#define CLKID_SYS_ETH_PHY			60
+#define CLKID_SYS_ACODEC			61
+#define CLKID_SYS_DWAP				62
+#define CLKID_SYS_DOS				63
+#define CLKID_SYS_CVE				64
+#define CLKID_SYS_VOUT				65
+#define CLKID_SYS_VC9000E			66
+#define CLKID_SYS_PWM_MN			67
+#define CLKID_SYS_SD_EMMC_B			68
+#define CLKID_AXI_SYS_NIC			69
+#define CLKID_AXI_ISP_NIC			70
+#define CLKID_AXI_CVE_NIC			71
+#define CLKID_AXI_RAMB				72
+#define CLKID_AXI_RAMA				73
+#define CLKID_AXI_CPU_DMC			74
+#define CLKID_AXI_NIC				75
+#define CLKID_AXI_DMA				76
+#define CLKID_AXI_MUX_NIC			77
+#define CLKID_AXI_CVE				78
+#define CLKID_AXI_DEV1_DMC			79
+#define CLKID_AXI_DEV0_DMC			80
+#define CLKID_AXI_DSP_DMC			81
+#define CLKID_12_24M_IN				82
+#define CLKID_12M_24M				83
+#define CLKID_FCLK_25M_DIV			84
+#define CLKID_FCLK_25M				85
+#define CLKID_GEN_SEL				86
+#define CLKID_GEN_DIV				87
+#define CLKID_GEN				88
+#define CLKID_SARADC_SEL			89
+#define CLKID_SARADC_DIV			90
+#define CLKID_SARADC				91
+#define CLKID_PWM_A_SEL				92
+#define CLKID_PWM_A_DIV				93
+#define CLKID_PWM_A				94
+#define CLKID_PWM_B_SEL				95
+#define CLKID_PWM_B_DIV				96
+#define CLKID_PWM_B				97
+#define CLKID_PWM_C_SEL				98
+#define CLKID_PWM_C_DIV				99
+#define CLKID_PWM_C				100
+#define CLKID_PWM_D_SEL				101
+#define CLKID_PWM_D_DIV				102
+#define CLKID_PWM_D				103
+#define CLKID_PWM_E_SEL				104
+#define CLKID_PWM_E_DIV				105
+#define CLKID_PWM_E				106
+#define CLKID_PWM_F_SEL				107
+#define CLKID_PWM_F_DIV				108
+#define CLKID_PWM_F				109
+#define CLKID_PWM_G_SEL				110
+#define CLKID_PWM_G_DIV				111
+#define CLKID_PWM_G				112
+#define CLKID_PWM_H_SEL				113
+#define CLKID_PWM_H_DIV				114
+#define CLKID_PWM_H				115
+#define CLKID_PWM_I_SEL				116
+#define CLKID_PWM_I_DIV				117
+#define CLKID_PWM_I				118
+#define CLKID_PWM_J_SEL				119
+#define CLKID_PWM_J_DIV				120
+#define CLKID_PWM_J				121
+#define CLKID_PWM_K_SEL				122
+#define CLKID_PWM_K_DIV				123
+#define CLKID_PWM_K				124
+#define CLKID_PWM_L_SEL				125
+#define CLKID_PWM_L_DIV				126
+#define CLKID_PWM_L				127
+#define CLKID_PWM_M_SEL				128
+#define CLKID_PWM_M_DIV				129
+#define CLKID_PWM_M				130
+#define CLKID_PWM_N_SEL				131
+#define CLKID_PWM_N_DIV				132
+#define CLKID_PWM_N				133
+#define CLKID_SPICC_A_SEL			134
+#define CLKID_SPICC_A_DIV			135
+#define CLKID_SPICC_A				136
+#define CLKID_SPICC_B_SEL			137
+#define CLKID_SPICC_B_DIV			138
+#define CLKID_SPICC_B				139
+#define CLKID_SPIFC_SEL				140
+#define CLKID_SPIFC_DIV				141
+#define CLKID_SPIFC				142
+#define CLKID_SD_EMMC_A_SEL			143
+#define CLKID_SD_EMMC_A_DIV			144
+#define CLKID_SD_EMMC_A				145
+#define CLKID_SD_EMMC_B_SEL			146
+#define CLKID_SD_EMMC_B_DIV			147
+#define CLKID_SD_EMMC_B				148
+#define CLKID_SD_EMMC_C_SEL			149
+#define CLKID_SD_EMMC_C_DIV			150
+#define CLKID_SD_EMMC_C				151
+#define CLKID_TS_DIV				152
+#define CLKID_TS				153
+#define CLKID_ETH_125M_DIV			154
+#define CLKID_ETH_125M				155
+#define CLKID_ETH_RMII_DIV			156
+#define CLKID_ETH_RMII				157
+#define CLKID_MIPI_DSI_MEAS_SEL			158
+#define CLKID_MIPI_DSI_MEAS_DIV			159
+#define CLKID_MIPI_DSI_MEAS			160
+#define CLKID_DSI_PHY_SEL			161
+#define CLKID_DSI_PHY_DIV			162
+#define CLKID_DSI_PHY				163
+#define CLKID_VOUT_MCLK_SEL			164
+#define CLKID_VOUT_MCLK_DIV			165
+#define CLKID_VOUT_MCLK				166
+#define CLKID_VOUT_ENC_SEL			167
+#define CLKID_VOUT_ENC_DIV			168
+#define CLKID_VOUT_ENC				169
+#define CLKID_HCODEC_0_SEL			170
+#define CLKID_HCODEC_0_DIV			171
+#define CLKID_HCODEC_0				172
+#define CLKID_HCODEC_1_SEL			173
+#define CLKID_HCODEC_1_DIV			174
+#define CLKID_HCODEC_1				175
+#define CLKID_HCODEC				176
+#define CLKID_VC9000E_ACLK_SEL			177
+#define CLKID_VC9000E_ACLK_DIV			178
+#define CLKID_VC9000E_ACLK			179
+#define CLKID_VC9000E_CORE_SEL			180
+#define CLKID_VC9000E_CORE_DIV			181
+#define CLKID_VC9000E_CORE			182
+#define CLKID_CSI_PHY0_SEL			183
+#define CLKID_CSI_PHY0_DIV			184
+#define CLKID_CSI_PHY0				185
+#define CLKID_DEWARPA_SEL			186
+#define CLKID_DEWARPA_DIV			187
+#define CLKID_DEWARPA				188
+#define CLKID_ISP0_SEL				189
+#define CLKID_ISP0_DIV				190
+#define CLKID_ISP0				191
+#define CLKID_NNA_CORE_SEL			192
+#define CLKID_NNA_CORE_DIV			193
+#define CLKID_NNA_CORE				194
+#define CLKID_GE2D_SEL				195
+#define CLKID_GE2D_DIV				196
+#define CLKID_GE2D				197
+#define CLKID_VAPB_SEL				198
+#define CLKID_VAPB_DIV				199
+#define CLKID_VAPB				200
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H */
-- 
2.39.2


