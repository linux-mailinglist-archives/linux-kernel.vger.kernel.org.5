Return-Path: <linux-kernel+bounces-50341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0488477AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D832840B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4D1586E8;
	Fri,  2 Feb 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGp9akML"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339121552E6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898916; cv=none; b=GBguF6bXnipFOlkn3ZWNO7LIMKADmTnkdMuaNeilhndXQkgitBrejTkUZ6XloQt+2P/095jYPvBaqlZJRsH//g9tc9wie0oHekrFTqF45ONtciR6inOpIF53aLPv+DrJwxLl3hftW15RKGPQAJoDa0ZYJbk2AQix9lJyna343z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898916; c=relaxed/simple;
	bh=ZwiQcj5lS0YwlQcRJrJvZ7jW2ruXKWZFMHV/CbkBTmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGvDFofP7sk/geGzytu7T9Yqu6yiEH/ljwAPZBLTC6ZjGtlTooSztLlWuYDofJt3DtnXHbRvqhsnm8936pedKfX2p3EsrAEjrqnicLvBt2Li2QWJVFiBgu1gIJemnM+kI5EB7FZeRzikYQcn191h+53wolXDeusIJvR3YtB548U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGp9akML; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a372a3773a5so59676066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898911; x=1707503711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k91pc5EhkGw9TQ5MV8voYfFQwWkoUAgKS7iKDYSBv6o=;
        b=gGp9akMLqlCmflT5M2fCVtpatLMIQEoig2/cOOVTaVhrt3W8QvV6ES3eYubsFsraq9
         QdjFw91fVcOPzIv4WpTzsjylocyK2h05V3HIonKTmFUmrLZofV5xVjId1j6t02bftUqF
         vw81AuIA13qn+5F1lhY7Kfyb/wnr8CcFshjEnH7wJlzyQqTOf0p05BayCOTyYWFnHNOj
         qsAGZ7/zrr14MU20s1lcr2kJGJsnAeerYxIi55soqVTt4eVUQ0w4QmnqMudBtsykmCBj
         riQCW/h0sNncpy8FSswY1jvQnl5HUbXr/qcyWzxpeRfdFMHxm8Mxdb1lR/OupWCGTqqO
         oBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898911; x=1707503711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k91pc5EhkGw9TQ5MV8voYfFQwWkoUAgKS7iKDYSBv6o=;
        b=mbJjcdTUnJx25qv6JmjapgepyOGhhlsBDr/XqTKUB+BeiiPws0UjPV9d89xrUPzbSM
         okvbhZtuXlz0xG2/nlrDP3QGfxTh3pht7orot5qxYi4JSqEi9nj80X5+EF8d4L7fFpw6
         X7hy12tYKuM405BidsRt/MrBDuYQjVajH3xvPRDfbAJQtpcqhbGpTWv6PWshlswifFHA
         QMgktWmT+ATQTRog+zrG6YQqAJ9GY0s0yq0t366G0oiBTYtzwPiUyPOCJsOrsOEQBoLE
         Jro/HanL2kPWNW4GR9KO1DAeNozEuQ+i9QRiL7Vb2UNIRHj9aaCQpxRNu1UWIoggX0nd
         zq4A==
X-Gm-Message-State: AOJu0YwdNEf3m0V5D7oL9nEY0PBiOywn6GsFDovdg1K98+mXSImHivkd
	pmVwEfsOGjfLtaD+k5MYBBoccp1u4aUK/NDWd1goYi+Nvr3n1DI/NDo4zsY6O9uQhRfaOTQSOuD
	Z
X-Google-Smtp-Source: AGHT+IG/2TXJixQa3N39HgO96bmxq3XXkRXm0g6lvMS24WbDZ2wKmZxl7w2wj8k4fgvOsZU1OHhsoQ==
X-Received: by 2002:a17:906:30d3:b0:a35:9a1e:f239 with SMTP id b19-20020a17090630d300b00a359a1ef239mr1927382ejb.12.1706898910815;
        Fri, 02 Feb 2024 10:35:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU1DFKDzE/TEqDWHypfitm4S2AbQfQ+rSK82sW24wjFzqAG+0a79zr9R1TUWfXfKGFFvUPADbSWIWSpni9LNM7rkXVPxXvSvMMw+vs0q7iH2qoTzndHKtlboYo4ot+5L10y+1lhkn+sMUw0LnASPSgri7UrIDP31gmewQTtoU/elF+n5i0KOH4CRHzI9GSYhahQwZyJHGErFcUg8+7SiXsnoE6/DR+eshlpkvN08hknS8slJeN9KP49JBPX8E7PcAZul6zyiHxOTt4hIdHeMIqW1PNYVD0EpbweMJGjCMdmg+yIed/SsxiGqZ3/g6vYikL9avP6K3XyjPCvzbyfuDeW1edzvQmE8x3baddN9HKYBO4a8vAF8JWkkkHy+50U2tevWcmUJN6RG26H80Jp5cw3TeYj9oCWxj8nj2TR8ENT+au1rN+e8kRd4aR8Xux9RSYNGwgtrHiIykXLwAisCoLzC0+kfCQynYDvOVmuqlR7ljRxL6w0kfka29yJfZoGzwEuIy+sQOoLfJU0M8fQ6ND+BtSPc7U/4tvlmTE25ORlQ6Pymv+AF4tskQYxG0seBJ4DrVwc0x/ZAI6OxLFF0yM+mg==
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id vh10-20020a170907d38a00b00a36fa497a65sm1051328ejc.110.2024.02.02.10.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:35:10 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 02 Feb 2024 20:34:44 +0200
Subject: [PATCH v4 09/10] clk: qcom: Add TCSR clock driver for x1e80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-x1e80100-clock-controllers-v4-9-7fb08c861c7c@linaro.org>
References: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
In-Reply-To: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9570; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ZwiQcj5lS0YwlQcRJrJvZ7jW2ruXKWZFMHV/CbkBTmk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlvTXLCZbvei++pBsIovxE/Ikn20iFLR7W5TXA3
 yL5Nph8vbuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZb01ywAKCRAbX0TJAJUV
 VkZ5EACCu0jqpYXNS0WncuLkwkhXNyHcJWWesqN4jwMdYi/KvRjGemuiiWV1MYKXXNbqD9RkSy+
 JjBQu+Sn0gffiSwj2nnjZgEYnfnCWjdPVB72bM0w6esUeBZjz/xaz9lSVzxQLEGH5rqt0Jxspza
 Winf394MPzcQCFJVUVRmoMCpfwkhX7RxaS4Q9BBOsrcRDj5tFbPkTLeISHWvj1xG3KGuSeFSTtl
 g1aNd8m0nUKudZtZcRmmT5olkzuZnSD+sld4/2a/rZbs9QVPj48oZ5ZKGhvw9mIe19NExMXAWdb
 5RL3nr/UcYjfYvCyu3p25lhwRL7XE/Ls+OWbZ+QIq3DYiE1RzK/NNob1L380CG2Rk87AUdcb293
 evAfbMF9HgRqOyk6DQQhRiCVdUDJog0to/5G2KGnF8/QRTEHmDJgfgV5NuAhJAmF24b/zQw+rdF
 oSxPentVbi5oR1oKFd5r2MNTYjfHagZLqY2q3WdzvekbjymKu+AT289VgwiAZdbuGw9UUWmUU1E
 L4J/f7sGg8U5ncpCU7gF0ctxzd0M5L5ADXmFCP6w+SQkSUvPk71UUH9zuLAZFI7rk8uaNpCA99E
 0CiinwpHb5TXI/W71dQ9rcFy6rzcniMZczyLbR8MggPr06trskmxBzcllR7IOl1z89/UFQncMq3
 GsLPPrafzN4yuOQ==
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


