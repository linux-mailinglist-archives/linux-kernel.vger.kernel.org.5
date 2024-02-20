Return-Path: <linux-kernel+bounces-72249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C3B85B127
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129F51C22221
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE951033;
	Tue, 20 Feb 2024 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1+JtcFv"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EB53368;
	Tue, 20 Feb 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398567; cv=none; b=rdYQUEfDcXoKuHdAfAh/R7Rke1xFiugq9zzR6r09Iwo9THhiAltg/wGHhk2zJxF2kgfiMXVGjcH6xLqfClarQ8ApskpV7hgvDwZtg6TMFGQ3ugl+eklv1qQoFDO4kCil133NrLTz46Zwnw8Ik8F2ma6cu1zukiN3dlAOHN4CEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398567; c=relaxed/simple;
	bh=PBw2itTAtKyfRh4CMnHbW9CagQfymiDEoWMz3owEgO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMBipyEYT2w6MwBHMm5mQpasMrj2Qjc7Y7e5zp72G1tEpULlWMlz6ZXH0Ba8z8HdUf4hkpfc045AeNsagcdi1hewrSTV/29u+3ACJjMV9XscfZudIve4cbT1fZ+7MSvWr9GZudvKfuXebOw9yaH97ecD7xCPXTylG+6IykBBtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1+JtcFv; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20503dc09adso3237523fac.2;
        Mon, 19 Feb 2024 19:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398565; x=1709003365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbbStuGHEQUQVFTlFPjjJtb3aZpnoFzyfr/hxOay39o=;
        b=R1+JtcFvSeWufXTKL3MaJvRFzzXxrH2XwVBM5vvixQFGbMVZe0EHOYmLQKFm+lu42a
         v6Et8n6ls8sVpJkWEBKNGb7mQDeaBitJEEuIXpQxwtpZp+rV8z7XvB9QUMOYrqXqEZND
         eSZRyqtvna/78HxOZ7RMxJXaXvUDbLlUcmb00X9MX/yFDGSnDRxY4X2Za+rxJlAPmsG2
         2L7zfq1yxK6VsnMo6N5pvc+RE2wsn0BsBopkhCVDfZyCmNyooFLv28XGEROXeqrfaA/N
         t7Wkh5fYI+T/EDuwfCSka3nydPHVrB1Dw9UZZqgLT7L9uoDpP9CrISesgU5Thjo1qRJP
         +YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398565; x=1709003365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbbStuGHEQUQVFTlFPjjJtb3aZpnoFzyfr/hxOay39o=;
        b=tGdDU0Ke63dtkIV7L3qq5F4OzEsA3bd6BVcdEt+AU7gTGsT1LhZkfFiNZuJN5uMMRH
         EAtKAWnBhmitcYqxmh9X6uzVsEknUC9QgO+urT4CTvagI2jsiAU6v4HLuDZJS3EZu58s
         /ZKKA3D/02Qp/kyJGbLHglw1s9dg9nlrJvt+/Sa2ob9kr0WAx3MZGez469RqiPJFatGM
         wg5uxjGqN8e1SyYODgO9Ro7agsVsf35YMJsrXoWrFx5X+d2IFpCeNiOFd2wMJGkc9/WW
         F50zJtMtO9tEi+3sHjABtDWQgGkDlS+0szxFTfDQX/2E+2r873UeN83WhJv7ELAs+Dxk
         j3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU3shjKgvVB2IIoVdUaGZXjUTQi7NRxtEHqh7q4udVusx7B6vxF08X7GA7/vjDwH/9Qsi1h8AdX1BrknXZJaKuSgmC0ddp3sWMdfeHi30hEfHxc6u/j2cANRPG9uiLI9UGIGNBisF2I+M1CH+ysFsnxJcP78nNB+bybZtxLtkAoanf7MQ==
X-Gm-Message-State: AOJu0YxriBrEYwUY6GX/qYwn9NUuzffCibZOcvimorA1sDcxVPslAaAi
	aPeWKK1AL4gia3o2P/PP0wjVxWN3CzomMb3uCo3S1CJ5zX1pkTGO
X-Google-Smtp-Source: AGHT+IHyst5SY8GMfSqnwAm0HK3m2/ezDXV/jUuFrzNbN/6M0ssU9UphcQkhEX5j/6J87oIIXRFFog==
X-Received: by 2002:a05:6870:a181:b0:21e:df8b:5280 with SMTP id a1-20020a056870a18100b0021edf8b5280mr4539022oaf.27.1708398565318;
        Mon, 19 Feb 2024 19:09:25 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id a22-20020a056808129600b003c15d47fbe6sm426961oiw.46.2024.02.19.19.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:09:25 -0800 (PST)
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
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v11 3/5] dt-bindings: clock: sophgo: add clkgen for SG2042
Date: Tue, 20 Feb 2024 11:09:18 +0800
Message-Id: <cebef63e3e704db58658b5eae3f1fc4dfd1a587e.1708397315.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the clock generator of divider/mux and gates working
for other subsystem than RP subsystem for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  49 ++++++++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 111 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..e31dece67215
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Clock Generator for divider/mux/gate
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
+  clocks:
+    items:
+      - description: Main PLL
+      - description: Fixed PLL
+      - description: DDR PLL 0
+      - description: DDR PLL 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-clkgen.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@30012000 {
+      compatible = "sophgo,sg2042-clkgen";
+      reg = <0x30012000 0x1000>;
+      clocks = <&pllclk 0>,
+               <&pllclk 1>,
+               <&pllclk 2>,
+               <&pllclk 3>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-clkgen.h b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
new file mode 100644
index 000000000000..84f7857317a2
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_CLKGEN_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_CLKGEN_H__
+
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
+
+#define GATE_CLK_DDR01_DIV0		81
+#define GATE_CLK_DDR23_DIV0		82
+
+#define GATE_CLK_DDR01			83
+#define GATE_CLK_DDR23			84
+#define GATE_CLK_RP_CPU_NORMAL		85
+#define GATE_CLK_AXI_DDR		86
+
+#define MUX_CLK_DDR01			87
+#define MUX_CLK_DDR23			88
+#define MUX_CLK_RP_CPU_NORMAL		89
+#define MUX_CLK_AXI_DDR			90
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_CLKGEN_H__ */
-- 
2.25.1


