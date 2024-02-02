Return-Path: <linux-kernel+bounces-49297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AD846856
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3361C252A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697117BA8;
	Fri,  2 Feb 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlkXalsU"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3061755F;
	Fri,  2 Feb 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856148; cv=none; b=dk71f6UiB/nUSfNJMYhj2baGwgfPXlCxRY5D6SwCOERHJB6s8eCmV2hs/3WjeqQRM40pXzXqCPFhK6p9upHzhNBO9iR87Wd/jJksJ/PGEoT/mFbFWhBNunTWjldE4cQew+ATom0Ar4YrQU4YK/yh8xZoz6Nz2ST6FpMaAMNn/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856148; c=relaxed/simple;
	bh=+NFr8mYBC4P23hQZG9N65gdurNpF2PdD+iB+cL8uKSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3Qedjz/XEe90DZpnIDA8HZx/nYGpRiBjcoMAXC+8yU7xli6mTXcSIaJZSHjfBA7eG/64bxTFTjmMWFa8/nzYsRI4lCXvJzEVUPHzEwfocNlnUGmk0cRlnzFrJU4sXTpah8oSTTYly39Lu8V55yVqMPdZHNffTdYVthdqb/8y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlkXalsU; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2191dc7079aso126523fac.0;
        Thu, 01 Feb 2024 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856146; x=1707460946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kknUoT/coBH2uTSWG3cm92iTq0wGRuLA6NNcwJn/zvI=;
        b=OlkXalsUhhcbBLewBb8hbW+lSKO+F4Gf/07Ksg/gqrcTtC6a8vD5Ygrz0cU87Sludw
         3fbB1Bvz7x9zb+a39uRKF0G9RVooV63Y7TTmT+3orPA9B/6t/f2FiIHdvdY7Yid+0zmP
         AYVEE8YWJFwUi7wHpcrdG+RB4PEM/Vk5RVFzgI8fLF42juw3aOGtEpH4CUqPvW+mQkpq
         ZihV4k4VQUbXW9aqHtWgG3XBICtr8gA3QSkekvqT0clzQA2BJAINGTjXJG9OXm6YdKWr
         Ohi6UpOajpx3WMgQU0hvO5yf7WeAFRUfhJtLeb3gFE90qRyL8XK2UZCrAVe+OtMFxHdc
         63RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856146; x=1707460946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kknUoT/coBH2uTSWG3cm92iTq0wGRuLA6NNcwJn/zvI=;
        b=aRsm5AVjObykWF7YdjSBK9jsrSr7AdsnRstUK+qVz/XNOR7O1F3XkiXe80DDHfbG01
         hTaIe/RmceJuWAkJ7U/nfLS3N58/Fac+dGc8brE/AZGJb9uxi6xBaX/5csNPlW8dlTyL
         IyBKUG1VJxspal5UiPFyvUxH3aAeA9yL7hc7h5Fb67uFxnXu3fxB/IwJ8mr1SBREncco
         Qd4peMJL8TtGn396VAciu2S+dCODWAj3cQuAywGcIZFxx1X0wiFrvJIB4UgOE57cxjCy
         LaDLAw0jdr9gZ8vUfcQmR8goQRVAPhHbdYRNbZQsan4oz2+aJh6p8yv5LrD43RP52Eq1
         H7Jg==
X-Gm-Message-State: AOJu0Ywk9O2G3B22nP3SfYlRq/cD7kzedNjUxqcDAOEYURrDVFCek5Oq
	Sdv/yJz0nD7gkaID0OBkz+DeZKaa0kBvv6BqgQIhfxqOoYWiwyJd
X-Google-Smtp-Source: AGHT+IGhrAceiVBG1MixpF+lGLW5e8xlWp28MbQ1WgOjzILbgXN9OxIGWUUTuXftu8ZXhD5K47b73g==
X-Received: by 2002:a05:6870:2305:b0:210:b468:6a5d with SMTP id w5-20020a056870230500b00210b4686a5dmr7859949oao.16.1706856145698;
        Thu, 01 Feb 2024 22:42:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWJo6JTVJYeOEwW2ZPpCEoBhKGBeCiEHLDGAcBvl1pLsgqI+D6lTyXlNi0GbMrzvWxYpAFMhpybOzG2dpmGfIv0w3WzjiasR6R/H5V8FJOWNA20vEWBEh92p2aCPoebta2c6SBxwJCQIRANp/4atUC65BmpvnkjFgWLXude375JWXWCWTmIROIoKEQ3msCAU8jIO0n5qXO4q1npTeuNl43TUm8uRoDoIwu+1yeI5aR4NgPhXqz9v3nQTKTHk8P3iRuDXb9wtu28rrvPY7+seufwgv7aTPODRNn2EOCkiYD3k8o82QN4tJyuk8ppfXBkp+rx3deVO28h+hCQXrADXhlnOLXxiG1hbf8Go/+C09tNlfq3i0RmUMlgF6XK3AIRIf+jUQr/NFeXONRMRkEUcKcZ3Sactf9TwzR+r0s8PlU/pM5rPaLPzsWBaUhT6S/b2KNDcp+vb9oP7QlicgZabvXT4PvSkGsOott6eBO4ZZis73Kflf26kgiSiXy9OMinTZPb/jZO1KpOxp1aygpMIKyFWSt3Wt+GeM7ap7XA08YvVhExHY+n/oFo4Ox9doAISfIohXfzrerEljZwiBC+hCQ2ENYQzHvW/zPFOWbur16vl5vs5RdV0ChOBDEMtumPvbiFjmNefQYb6cjzNYmhJVizsDG5B2ykQ9jQZ33kV40lWY=
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id mm14-20020a0568700e8e00b0021892d2f44dsm335953oab.55.2024.02.01.22.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:42:25 -0800 (PST)
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
Subject: [PATCH v9 3/5] dt-bindings: clock: sophgo: add clkgen for SG2042
Date: Fri,  2 Feb 2024 14:42:18 +0800
Message-Id: <d666b1efe6051aad127f9fa0215922935e5ddc55.1706854074.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706854074.git.unicorn_wang@outlook.com>
References: <cover.1706854074.git.unicorn_wang@outlook.com>
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
 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  37 ++++++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 111 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..5c33eb20c76e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,37 @@
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
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-clkgen.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@30012000 {
+      compatible = "sophgo,sg2042-clkgen";
+      reg = <0x30012000 0x1000>;
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


