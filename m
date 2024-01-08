Return-Path: <linux-kernel+bounces-19116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1440826840
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6415B20BED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB9849C;
	Mon,  8 Jan 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AILAj7Bw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D08BF3;
	Mon,  8 Jan 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dd8cba736aso1119012a34.3;
        Sun, 07 Jan 2024 22:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704696556; x=1705301356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjwnneVN9aCrITVec0MNUZace+XiXQAwVu+e+wr5VYs=;
        b=AILAj7BwwILapMl0yYptHmJq9NUp3jBXC2QxfQvJR1OI977UinI6pB8xfz44pctMDa
         aF8YldfG4saz6H8k8sybNLkRiN53b4Awhw4pNScAIcsT123pJfv21SyFtW6DS2JWK/lr
         daqK+QMWXJoNrtgOK7XAUKUzI6w4+fA4PsXeW6DnyfOK6flEfMHXCOWUbwT+qWOv3FhB
         rfWFqAkj13gclmJZ9U/yVwSKudcePvpMXBovC1JQCG3FSNPn/Y2yNoZKm/UlS4+Phrrw
         IE37vNh+VUUxKgL+yYFIar9+6UGvYQyMv0VJPYMa2fyHCn7rZrgQUIuqktUMxNF/cmlJ
         qdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704696556; x=1705301356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjwnneVN9aCrITVec0MNUZace+XiXQAwVu+e+wr5VYs=;
        b=OvE/WmsO/qPweEgGhEcktpkivWVi+4sHKFkJh/3as+QjoFsGY0zsjKTYPuqgtJPVPE
         3Kk7QStFIVqwb3mUM7fAaH5bzpUtxdJf5DNmq6QneX76VG/0XNpM9FIju5C9FytH1KSh
         d4UVpmBmWihoaUrj0rHuBH0pnyOABnJWvhq1dXqFa1N50kyF3mHWmHe6RzaNDyxJm10W
         qUE0QuLl3qkmu7m4lqi9wgewvsxUHzMbGm8ZU0MGg1aHiZxylB4DcWHfVyTCoctkmTbj
         Nh+SExcIT8G/Kq3ctrHy9oSFdSOnF23+OAMKZOLUZxHsCQ0eFRP3AAaFbojuxSkpUyEj
         /e5A==
X-Gm-Message-State: AOJu0YyV53seF0BfKxXSauVX2qmfsA13oBrBkXBpW3gNPQk1ABykz8zT
	ckbI7dw1c/JmB7sfpvbI0N4=
X-Google-Smtp-Source: AGHT+IEQCk0DQOoEAx3PIG2X97t9FwvUQ1mvOQrSza10s1hHKA6Hs5C/+hDdvgOWdCma8cj3+JSB4g==
X-Received: by 2002:a9d:62da:0:b0:6dc:1347:e46f with SMTP id z26-20020a9d62da000000b006dc1347e46fmr2463618otk.16.1704696556118;
        Sun, 07 Jan 2024 22:49:16 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id e14-20020a05683013ce00b006d87e38f91asm1277497otq.56.2024.01.07.22.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:49:15 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
Date: Mon,  8 Jan 2024 14:49:09 +0800
Message-Id: <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704694903.git.unicorn_wang@outlook.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the clock generator on the SG2042 RISC-V SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  53 ++++++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 169 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..f9935e66fc95
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Clock Generator
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-clkgen
+
+  reg:
+    maxItems: 1
+
+  sophgo,system-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to SG2042 System Controller node. On SG2042, part of control
+      registers of Clock Controller are defined in System controller. Clock
+      driver will use this phandle to get the register map base to plus the
+      offset of the registers to access them.
+
+  clocks:
+    items:
+      - description: Clock Generation IC (25 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-clkgen.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - sophgo,system-ctrl
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@30012000 {
+        compatible = "sophgo,sg2042-clkgen";
+        reg = <0x30012000 0x1000>;
+        sophgo,system-ctrl = <&sys_ctrl>;
+        clocks = <&cgi>;
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-clkgen.h b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
new file mode 100644
index 000000000000..78cd3c3efdb6
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
+#define __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
+
+/* Divider clocks */
+#define DIV_CLK_MPLL_RP_CPU_NORMAL_0	0
+#define DIV_CLK_MPLL_AXI_DDR_0		1
+#define DIV_CLK_FPLL_DDR01_1		2
+#define DIV_CLK_FPLL_DDR23_1		3
+#define DIV_CLK_FPLL_RP_CPU_NORMAL_1	4
+#define DIV_CLK_FPLL_50M_A53		5
+#define DIV_CLK_FPLL_TOP_RP_CMN_DIV2	6
+#define DIV_CLK_FPLL_UART_500M		7
+#define DIV_CLK_FPLL_AHB_LPC		8
+#define DIV_CLK_FPLL_EFUSE		9
+#define DIV_CLK_FPLL_TX_ETH0		10
+#define DIV_CLK_FPLL_PTP_REF_I_ETH0	11
+#define DIV_CLK_FPLL_REF_ETH0		12
+#define DIV_CLK_FPLL_EMMC		13
+#define DIV_CLK_FPLL_SD			14
+#define DIV_CLK_FPLL_TOP_AXI0		15
+#define DIV_CLK_FPLL_TOP_AXI_HSPERI	16
+#define DIV_CLK_FPLL_AXI_DDR_1		17
+#define DIV_CLK_FPLL_DIV_TIMER1		18
+#define DIV_CLK_FPLL_DIV_TIMER2		19
+#define DIV_CLK_FPLL_DIV_TIMER3		20
+#define DIV_CLK_FPLL_DIV_TIMER4		21
+#define DIV_CLK_FPLL_DIV_TIMER5		22
+#define DIV_CLK_FPLL_DIV_TIMER6		23
+#define DIV_CLK_FPLL_DIV_TIMER7		24
+#define DIV_CLK_FPLL_DIV_TIMER8		25
+#define DIV_CLK_FPLL_100K_EMMC		26
+#define DIV_CLK_FPLL_100K_SD		27
+#define DIV_CLK_FPLL_GPIO_DB		28
+#define DIV_CLK_DPLL0_DDR01_0		29
+#define DIV_CLK_DPLL1_DDR23_0		30
+
+/* Gate clocks */
+#define GATE_CLK_RP_CPU_NORMAL_DIV0	31
+#define GATE_CLK_AXI_DDR_DIV0		32
+
+#define GATE_CLK_RP_CPU_NORMAL_DIV1	33
+#define GATE_CLK_A53_50M		34
+#define GATE_CLK_TOP_RP_CMN_DIV2	35
+#define GATE_CLK_HSDMA			36
+#define GATE_CLK_EMMC_100M		37
+#define GATE_CLK_SD_100M		38
+#define GATE_CLK_TX_ETH0		39
+#define GATE_CLK_PTP_REF_I_ETH0		40
+#define GATE_CLK_REF_ETH0		41
+#define GATE_CLK_UART_500M		42
+#define GATE_CLK_EFUSE			43
+
+#define GATE_CLK_AHB_LPC		44
+#define GATE_CLK_AHB_ROM		45
+#define GATE_CLK_AHB_SF			46
+
+#define GATE_CLK_APB_UART		47
+#define GATE_CLK_APB_TIMER		48
+#define GATE_CLK_APB_EFUSE		49
+#define GATE_CLK_APB_GPIO		50
+#define GATE_CLK_APB_GPIO_INTR		51
+#define GATE_CLK_APB_SPI		52
+#define GATE_CLK_APB_I2C		53
+#define GATE_CLK_APB_WDT		54
+#define GATE_CLK_APB_PWM		55
+#define GATE_CLK_APB_RTC		56
+
+#define GATE_CLK_AXI_PCIE0		57
+#define GATE_CLK_AXI_PCIE1		58
+#define GATE_CLK_SYSDMA_AXI		59
+#define GATE_CLK_AXI_DBG_I2C		60
+#define GATE_CLK_AXI_SRAM		61
+#define GATE_CLK_AXI_ETH0		62
+#define GATE_CLK_AXI_EMMC		63
+#define GATE_CLK_AXI_SD			64
+#define GATE_CLK_TOP_AXI0		65
+#define GATE_CLK_TOP_AXI_HSPERI		66
+
+#define GATE_CLK_TIMER1			67
+#define GATE_CLK_TIMER2			68
+#define GATE_CLK_TIMER3			69
+#define GATE_CLK_TIMER4			70
+#define GATE_CLK_TIMER5			71
+#define GATE_CLK_TIMER6			72
+#define GATE_CLK_TIMER7			73
+#define GATE_CLK_TIMER8			74
+#define GATE_CLK_100K_EMMC		75
+#define GATE_CLK_100K_SD		76
+#define GATE_CLK_GPIO_DB		77
+
+#define GATE_CLK_AXI_DDR_DIV1		78
+#define GATE_CLK_DDR01_DIV1		79
+#define GATE_CLK_DDR23_DIV1		80
+/* DPLL0 */
+#define GATE_CLK_DDR01_DIV0		81
+/* DPLL1 */
+#define GATE_CLK_DDR23_DIV0		82
+
+#define GATE_CLK_DDR01			83
+#define GATE_CLK_DDR23			84
+#define GATE_CLK_RP_CPU_NORMAL		85
+#define GATE_CLK_AXI_DDR		86
+#define GATE_CLK_RXU0			87
+#define GATE_CLK_RXU1			88
+#define GATE_CLK_RXU2			89
+#define GATE_CLK_RXU3			90
+#define GATE_CLK_RXU4			91
+#define GATE_CLK_RXU5			92
+#define GATE_CLK_RXU6			93
+#define GATE_CLK_RXU7			94
+#define GATE_CLK_RXU8			95
+#define GATE_CLK_RXU9			96
+#define GATE_CLK_RXU10			97
+#define GATE_CLK_RXU11			98
+#define GATE_CLK_RXU12			99
+#define GATE_CLK_RXU13			100
+#define GATE_CLK_RXU14			101
+#define GATE_CLK_RXU15			102
+#define GATE_CLK_RXU16			103
+#define GATE_CLK_RXU17			104
+#define GATE_CLK_RXU18			105
+#define GATE_CLK_RXU19			106
+#define GATE_CLK_RXU20			107
+#define GATE_CLK_RXU21			108
+#define GATE_CLK_RXU22			109
+#define GATE_CLK_RXU23			110
+#define GATE_CLK_RXU24			111
+#define GATE_CLK_RXU25			112
+#define GATE_CLK_RXU26			113
+#define GATE_CLK_RXU27			114
+#define GATE_CLK_RXU28			115
+#define GATE_CLK_RXU29			116
+#define GATE_CLK_RXU30			117
+#define GATE_CLK_RXU31			118
+#define GATE_CLK_MP0			119
+#define GATE_CLK_MP1			120
+#define GATE_CLK_MP2			121
+#define GATE_CLK_MP3			122
+#define GATE_CLK_MP4			123
+#define GATE_CLK_MP5			124
+#define GATE_CLK_MP6			125
+#define GATE_CLK_MP7			126
+#define GATE_CLK_MP8			127
+#define GATE_CLK_MP9			128
+#define GATE_CLK_MP10			129
+#define GATE_CLK_MP11			130
+#define GATE_CLK_MP12			131
+#define GATE_CLK_MP13			132
+#define GATE_CLK_MP14			133
+#define GATE_CLK_MP15			134
+
+/* MUX clocks */
+#define MUX_CLK_DDR01			135
+#define MUX_CLK_DDR23			136
+#define MUX_CLK_RP_CPU_NORMAL		137
+#define MUX_CLK_AXI_DDR			138
+
+/* PLL clocks */
+#define MPLL_CLK			139
+#define FPLL_CLK			140
+#define DPLL0_CLK			141
+#define DPLL1_CLK			142
+
+#endif /* __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__ */
-- 
2.25.1


