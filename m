Return-Path: <linux-kernel+bounces-42002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A283FA8C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9913B22D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77444F5E8;
	Sun, 28 Jan 2024 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQceZRle"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BD4F5ED
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482377; cv=none; b=oMNXvLA73dqlyt96K9FhqNuiSXr1Lp8ORzz5In+2ua0DbQjCR8ps9duVQZL2EL0axXtKcQvsC4FeYbk/tHyM29SpDs3yUtPhTPbtWuFq2nI9Ow2Po0fA2KVC1hO7Rpw7uDRM2DsatXSemRlghpdNx1ZCQcHnZcvb8FFHElNT6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482377; c=relaxed/simple;
	bh=ZwiQcj5lS0YwlQcRJrJvZ7jW2ruXKWZFMHV/CbkBTmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuIDEAHvIxdGyLPnrKcotQogGvZST+pyaoIUco4pOR42BEm5+rF5vpC/6tSsetgCbmZxnEBOpN/garoQud0+ADDRI+QEvoMii4sEVuoxzymsC9vMJPAZTJ5TR47Y+gxDTg+XP2NPLxVZ8Ev8tHBtIFXrdKOhWCYy1x/Vxwwsrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQceZRle; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55efe051e4aso451175a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482373; x=1707087173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k91pc5EhkGw9TQ5MV8voYfFQwWkoUAgKS7iKDYSBv6o=;
        b=eQceZRleeeXicfku6FyC6H+XkePXOkHs3kUk+YI1+SWgJVXXAmVyzJpeR4o/NmyOzW
         HPOG6fUNEg50CuNId9be8L8MP5E8N12zB4v9sD4TJNoXBZiopNCf5Tae3NRZ24B2O/q7
         xrqAiBsXiwKc3+IihTbjCSmet+fJxkunVPvoSVcxizvrCPXH8pQcTfIQ8EjOCISf/sGg
         PgLweG5bJxL/7oGqCtLyI9/1SJ7g8BsulJZGGQ6+xCMh7tCcc35+f59jMFp6WeLv88lR
         PPlkLdNwoCRP282/duDvpXald9i0equ2Yl7GaQg/9dkrUr7WlBVpo1bD3rLl01jJ0NlI
         eGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482373; x=1707087173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k91pc5EhkGw9TQ5MV8voYfFQwWkoUAgKS7iKDYSBv6o=;
        b=OnFyGzfKYi5uS1dH0a1+oD2lMSyvcKkUUiiOLXn0SOo6/roB022+N1PB3/BNSJu4nj
         Q/S7th0ubWe2WP7zl3jvd8RmTxHIF5rKu3p1iKxNst0GOcq/TKbIY9gspQ2TdgX9P4iX
         zhISu7UBA4goOmZ799KukJndC1lZqYnAd83kb361eWDEhn8J5/bqcFAhVNiewU6oy1I8
         i2UBceuARLI/B8qCcKcy0E4pNR1Xyk1YbCR3OmKf84KuNDqO41lnCgulQAS3LFgA8/N1
         y1MSkwnw0xeIy1ry+p0iOCUEbTSeYyXyHPxlKWX+TpW70IDHr/N4fFUHaP2pkJFr3Ryk
         fWFA==
X-Gm-Message-State: AOJu0Yz948qhQkA3MSwBqFq4CHfksfuVypsH9F+Ax/6GAxzGVamGBE1U
	BbPDkL63UhINXDObgphVypd+cepCWV4GMZ4wdXzWeqvSoEStRhElurrYkxzV4Ds=
X-Google-Smtp-Source: AGHT+IGEW+L1UKrTMBTvZuZIC6Nk9jnsZE4S/n8LIGzyXAxD0d4iacU96ZGM1SoDRtVJ/9y0/DO/vg==
X-Received: by 2002:a17:907:20ed:b0:a23:62fd:e2f6 with SMTP id rh13-20020a17090720ed00b00a2362fde2f6mr4350418ejb.30.1706482373087;
        Sun, 28 Jan 2024 14:52:53 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b00a30cd599285sm3259996ejg.223.2024.01.28.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:52:52 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 00:52:22 +0200
Subject: [PATCH v3 09/10] clk: qcom: Add TCSR clock driver for x1e80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-clock-controllers-v3-9-d96dacfed104@linaro.org>
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9570; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ZwiQcj5lS0YwlQcRJrJvZ7jW2ruXKWZFMHV/CbkBTmk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlttqyIFrp95j6ipUQPXJ5KtvtRFk52/c3SeNv0
 GwJQi0lXP6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbasgAKCRAbX0TJAJUV
 VpawD/wNYqsDEOtojV/qnp7rHdANtL6frLP+kOMF7XSrfPVTXshHZuEKbc5Gcw5HKeOJOcaFgxm
 fAIlL444mNgX/Ni1Zo0Y+UEfyiOOETOhoiDoejJf5jSVaB6sixrLNWhnMVJeluj+FmPeNWIS07C
 zEgzdSncRG+xhVaeyCconlo1r+VSUhxdKmZMHiBwxDY2QLiOO9mwytOPuYwWN20UvxvVWX0yvd5
 1rvvnpNQK6h5vZfCFrbsa/rxb95vqbpyE8AbizWkBP/D6GjwxXbm0C0tkTKDzRZFN8FKJn2Z0go
 /kZok7fmu4NDiak0uMH3+WQ2MJu/Jzv77NaNLZ9WO/iKMIeoSg4N5VE/nKtPVqaguh1CssCvhyQ
 fFMuFZ6XaHuTvyyT3Q8X6R14YUv7i452DCsf2ZI1WPp6hFDEkWGPRJzH0BIZ/Hx5AoMJNuhFUxU
 SJWPNU6kUTGwz9t5jr7gzw185Tf4/C9MI/Ps42+seFm3G4XoM4uHg/JOwNP0pC/a4TEa3mkrFDm
 w57EN6vkeM556L1zUyjMXbFo+v9u7jOKUlacMIKIuCB715WMMaVyDCF5HUs9dnFei212uDtBsj3
 VxUylgilBwTGlhuu3yAAB/MDhp8VUyo8j3yk51XG9cEXwxE3VircHotDZytMSGZaAVYqZCWX8Ph
 m2ZR2UKNmNvR04A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The TCSR clock controller found on X1E80100 provides refclks
for PCIE, USB and UFS. Add clock driver for it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/Kconfig           |   8 ++
 drivers/clk/qcom/Makefile          |   1 +
 drivers/clk/qcom/tcsrcc-x1e80100.c | 285 +++++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d66934ca5e94..0633728c870c 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -49,6 +49,14 @@ config CLK_X1E80100_GPUCC
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config CLK_X1E80100_TCSRCC
+	tristate "X1E80100 TCSR Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select QCOM_GDSC
+	help
+	  Support for the TCSR clock controller on X1E80100 devices.
+	  Say Y if you want to use peripheral devices such as SD/UFS.
+
 config QCOM_A53PLL
 	tristate "MSM8916 A53 PLL"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index a037a29e9d61..750b084553c6 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
 obj-$(CONFIG_CLK_X1E80100_DISPCC) += dispcc-x1e80100.o
 obj-$(CONFIG_CLK_X1E80100_GCC) += gcc-x1e80100.o
 obj-$(CONFIG_CLK_X1E80100_GPUCC) += gpucc-x1e80100.o
+obj-$(CONFIG_CLK_X1E80100_TCSRCC) += tcsrcc-x1e80100.o
 obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
 obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
 obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
diff --git a/drivers/clk/qcom/tcsrcc-x1e80100.c b/drivers/clk/qcom/tcsrcc-x1e80100.c
new file mode 100644
index 000000000000..ff61769a0807
--- /dev/null
+++ b/drivers/clk/qcom/tcsrcc-x1e80100.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
+
+#include "clk-branch.h"
+#include "clk-regmap.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO_PAD,
+};
+
+static struct clk_branch tcsr_edp_clkref_en = {
+	.halt_reg = 0x15130,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15130,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "tcsr_edp_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_2l_4_clkref_en = {
+	.halt_reg = 0x15100,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15100,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_2l_4_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_2l_5_clkref_en = {
+	.halt_reg = 0x15104,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15104,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_2l_5_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_8l_clkref_en = {
+	.halt_reg = 0x15108,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15108,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_8l_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_mp0_clkref_en = {
+	.halt_reg = 0x1510c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1510c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_mp0_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_mp1_clkref_en = {
+	.halt_reg = 0x15110,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15110,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_mp1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_1_clkref_en = {
+	.halt_reg = 0x15114,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15114,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_phy_clkref_en = {
+	.halt_reg = 0x15118,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15118,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_phy_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb4_1_clkref_en = {
+	.halt_reg = 0x15120,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15120,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb4_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb4_2_clkref_en = {
+	.halt_reg = 0x15124,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15124,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb4_2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_2_clkref_en = {
+	.halt_reg = 0x15128,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15128,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_4l_clkref_en = {
+	.halt_reg = 0x1512c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1512c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_4l_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *tcsr_cc_x1e80100_clocks[] = {
+	[TCSR_EDP_CLKREF_EN] = &tcsr_edp_clkref_en.clkr,
+	[TCSR_PCIE_2L_4_CLKREF_EN] = &tcsr_pcie_2l_4_clkref_en.clkr,
+	[TCSR_PCIE_2L_5_CLKREF_EN] = &tcsr_pcie_2l_5_clkref_en.clkr,
+	[TCSR_PCIE_8L_CLKREF_EN] = &tcsr_pcie_8l_clkref_en.clkr,
+	[TCSR_USB3_MP0_CLKREF_EN] = &tcsr_usb3_mp0_clkref_en.clkr,
+	[TCSR_USB3_MP1_CLKREF_EN] = &tcsr_usb3_mp1_clkref_en.clkr,
+	[TCSR_USB2_1_CLKREF_EN] = &tcsr_usb2_1_clkref_en.clkr,
+	[TCSR_UFS_PHY_CLKREF_EN] = &tcsr_ufs_phy_clkref_en.clkr,
+	[TCSR_USB4_1_CLKREF_EN] = &tcsr_usb4_1_clkref_en.clkr,
+	[TCSR_USB4_2_CLKREF_EN] = &tcsr_usb4_2_clkref_en.clkr,
+	[TCSR_USB2_2_CLKREF_EN] = &tcsr_usb2_2_clkref_en.clkr,
+	[TCSR_PCIE_4L_CLKREF_EN] = &tcsr_pcie_4l_clkref_en.clkr,
+};
+
+static const struct regmap_config tcsr_cc_x1e80100_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2f000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc tcsr_cc_x1e80100_desc = {
+	.config = &tcsr_cc_x1e80100_regmap_config,
+	.clks = tcsr_cc_x1e80100_clocks,
+	.num_clks = ARRAY_SIZE(tcsr_cc_x1e80100_clocks),
+};
+
+static const struct of_device_id tcsr_cc_x1e80100_match_table[] = {
+	{ .compatible = "qcom,x1e80100-tcsr" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tcsr_cc_x1e80100_match_table);
+
+static int tcsr_cc_x1e80100_probe(struct platform_device *pdev)
+{
+	return qcom_cc_probe(pdev, &tcsr_cc_x1e80100_desc);
+}
+
+static struct platform_driver tcsr_cc_x1e80100_driver = {
+	.probe = tcsr_cc_x1e80100_probe,
+	.driver = {
+		.name = "tcsrcc-x1e80100",
+		.of_match_table = tcsr_cc_x1e80100_match_table,
+	},
+};
+
+static int __init tcsr_cc_x1e80100_init(void)
+{
+	return platform_driver_register(&tcsr_cc_x1e80100_driver);
+}
+subsys_initcall(tcsr_cc_x1e80100_init);
+
+static void __exit tcsr_cc_x1e80100_exit(void)
+{
+	platform_driver_unregister(&tcsr_cc_x1e80100_driver);
+}
+module_exit(tcsr_cc_x1e80100_exit);
+
+MODULE_DESCRIPTION("QTI TCSR Clock Controller X1E80100 Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


