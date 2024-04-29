Return-Path: <linux-kernel+bounces-162322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA288B59C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A962AB2AC35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC3A83CB7;
	Mon, 29 Apr 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ep3+JWJ0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCD71749
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395756; cv=none; b=fFJCrbWBZzyw/aHGyDNHip5d78SH9wmEff9IQc2hDr4yEng1eKqz7Bi+JhNo5+6brXrhegTuKdnERk2JcjI6bu5n+V3wEREYVsAMcR+yPEHGLCR3MvPMtAtlnugASwD3sZkFVGMwRrb5KUPRfRtCpKN6b7J2dAfidHfBwsScKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395756; c=relaxed/simple;
	bh=sZXeH9pFaUNb7pYS5vvEfjV4mcl2sh9kGR5Iq9Zz5YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3JpddbqOoJ2HglmKzk2+fxS44xn0zvROE0gwC74mUfBcsctZ/9dWXzyijHHRsef8ghiNrBf03f0mNykLFOm/EC9TMgM/CS/j9FcieaCyqk/MLFGpSgyfZxcGRQh1Kcg+iFqI/gfUbTOTxXoua7V1SCDU3IG6u5mpb42MWmhBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ep3+JWJ0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a524ecaf215so556342766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714395752; x=1715000552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gayVHE+Q3GJOVW17Gy0IQyJxmaRaOcRbywObHSbZE7M=;
        b=Ep3+JWJ00Jh7KUcimnReRkIwq8HBdVFpydDntqzujupbyHLq0HtVF4UeWIcd4LU/7d
         Am1oUxEvxX59bjwr8yDycO9V8yit1xpypt18oMjU3l4AvShJd3CfKXEnRAgbMjXPw/Cc
         qBrH6zE9xcGFhg1JVwrJMCld2yl827Xg39brSG+unOuyq792PWSsjmVA8mDw5oFCimD0
         +ARsZlbc0/X3W7LnYIX/XtCzwOVwxkHX8TBbEUdR17C39NbC3JlxRs4Um+DQ/Jax+RGZ
         QnypIZmhQcflQ7Ohjx8ZnDLC+v/PbUs0OpkJcxoBPWj74wLsCsNr42q72zd8fS1gvcH6
         X26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395752; x=1715000552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gayVHE+Q3GJOVW17Gy0IQyJxmaRaOcRbywObHSbZE7M=;
        b=NbOwHUFlZbkG6PNJEwaI8IHnoUfsW7xdSqGx91+GYRUr6SPPFsmS7w16JDrrn5wTgz
         LnJRP7hBrUQ5lMK7mNuePItSxPr0iWkh2JZFzZRxKgbKFYDJDyNF31jIjNCOXLDX/+Bq
         TG+muA5eUk1aK9KNezVeWpPwUJxIB4GsBwNVj84oDfGKMdli85px+59EzJOEmdpxxtBk
         drqZh3/sRmAZYJMO+7zY3Py7GG0bxmMC6Wiz2LZXAV5uGiqZ6UTYC8gz28tvXoAXTMD/
         EPd1YWeTk6FAfwBDUSkd+usdUO4AP06CVRF4mSJtzBptVlXaYJJ9eBUdlb5b/o7/86Zc
         ZCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaNsUAbhqpsHNOkADsuXSpIXLP5q+I3tHKp3wPoMhC3eKvzpVcabFf+CY41yBF8d876JwGSHGDfsnftV0Iqgyruoz/BMIQFevpYEzM
X-Gm-Message-State: AOJu0YymkDf5H1DYkZ0p0xjne967gKOtgfRn5OTocp9z0kAef06gbr43
	nVavQuhVNbnX4LsOZLvCJHG28GFGNMC2n7pyXe+sq2V5jAL0/uMaxf5H20t92dw=
X-Google-Smtp-Source: AGHT+IGt2dl2iA+X6V4cP5zoaRA7shE8eITK/myqKxhJSeySVW9JGXsZMzZnY5o8B0yLUPNyr9/UOQ==
X-Received: by 2002:a17:906:3e4d:b0:a55:653b:3981 with SMTP id t13-20020a1709063e4d00b00a55653b3981mr6155595eji.50.1714395751421;
        Mon, 29 Apr 2024 06:02:31 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id dk21-20020a170907941500b00a55aee4bf74sm9976074ejc.79.2024.04.29.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:02:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 14:02:19 +0100
Subject: [PATCH v3 3/3] clk: samsung: gs101: add support for cmu_hsi2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-hsi0-gs101-v3-3-f233be0a2455@linaro.org>
References: <20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org>
In-Reply-To: <20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

From: Peter Griffin <peter.griffin@linaro.org>

CMU_HSI2 is the clock management unit used for the hsi2 block.
HSI stands for High Speed Interface and as such it generates
clocks for PCIe, UFS and MMC card.

This patch adds support for the muxes, dividers, and gates in
cmu_hsi2.

The following clocks are marked CLK_IS_CRITICAL as disabling
them results in an immediate system hang.
CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK
CLK_GOUT_HSI2_LHM_AXI_P_HSI2_I_CLK

The following clocks are marked CLK_IGNORE_UNUSED as they are
needed for UFS to be functional.
CLK_GOUT_HSI2_SSMT_HSI2_ACLK
CLK_GOUT_HSI2_SSMT_HSI2_PCLK
CLK_GOUT_HSI2_LHS_ACEL_D_HSI2_I_CLK
CLK_GOUT_HSI2_SYSMMU_HSI2_CLK_S2
CLK_GOUT_HSI2_XIU_D_HSI2_ACLK
CLK_GOUT_HSI2_XIU_P_HSI2_ACLK

CLK_GOUT_HSI2_GPIO_HSI2_PCLK is marked CLK_IGNORE_UNUSED until
the exynos pinctrl clock patches land then it can be removed.

Some clocks in this unit have very long names. To help with this
the clock name mangling strategy was updated to include removing
the following sub-strings.
- G4X2_DWC_PCIE_CTL_
- G4X1_DWC_PCIE_CTL_
- PCIE_SUB_CTRL_
- INST_0_
- LN05LPE_
- TM_WRAPPER_
- SF_

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
[AD: resolve merge conflicts]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 507 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 507 insertions(+)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index ce0ff35f4548..05129c3b2f68 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -21,6 +21,7 @@
 #define CLKS_NR_TOP	(CLK_GOUT_CMU_TPU_UART + 1)
 #define CLKS_NR_APM	(CLK_APM_PLL_DIV16_APM + 1)
 #define CLKS_NR_HSI0	(CLK_GOUT_HSI0_XIU_P_HSI0_ACLK + 1)
+#define CLKS_NR_HSI2	(CLK_GOUT_HSI2_XIU_P_HSI2_ACLK + 1)
 #define CLKS_NR_MISC	(CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
 #define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
 #define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
@@ -2385,6 +2386,509 @@ static const struct samsung_cmu_info hsi0_cmu_info __initconst = {
 	.clk_name		= "bus",
 };
 
+/* ---- CMU_HSI2 ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_HSI2 (0x14400000) */
+#define PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER												0x0600
+#define PLL_CON1_MUX_CLKCMU_HSI2_BUS_USER												0x0604
+#define PLL_CON0_MUX_CLKCMU_HSI2_MMC_CARD_USER												0x0610
+#define PLL_CON1_MUX_CLKCMU_HSI2_MMC_CARD_USER												0x0614
+#define PLL_CON0_MUX_CLKCMU_HSI2_PCIE_USER												0x0620
+#define PLL_CON1_MUX_CLKCMU_HSI2_PCIE_USER												0x0624
+#define PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER												0x0630
+#define PLL_CON1_MUX_CLKCMU_HSI2_UFS_EMBD_USER												0x0634
+#define HSI2_CMU_HSI2_CONTROLLER_OPTION													0x0800
+#define CLKOUT_CON_BLK_HSI2_CMU_HSI2_CLKOUT0												0x0810
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN					0x2000
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN					0x2004
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_ACLK								0x2008
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_PCLK								0x200c
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_ACLK								0x2010
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_PCLK								0x2014
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_D_TZPC_HSI2_IPCLKPORT_PCLK									0x201c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPC_HSI2_IPCLKPORT_PCLK										0x2020
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPIO_HSI2_IPCLKPORT_PCLK										0x2024
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IPCLKPORT_PCLK									0x2028
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHM_AXI_P_HSI2_IPCLKPORT_I_CLK									0x202c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHS_ACEL_D_HSI2_IPCLKPORT_I_CLK									0x2030
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_I_ACLK										0x2034
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_SDCLKIN									0x2038
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG				0x203c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG				0x2040
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG				0x2044
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK				0x2048
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG				0x204c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG				0x2050
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG				0x2054
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK				0x2058
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PHY_UDBG_I_APB_PCLK						0x205c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PIPE_PAL_PCIE_INST_0_I_APB_PCLK				0x2060
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_SF_PCIEPHY210X2_LN05LPE_QCH_TM_WRAPPER_INST_0_I_APB_PCLK	0x2064
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4A_1_IPCLKPORT_I_CLK									0x2068
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4B_1_IPCLKPORT_I_CLK									0x206c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_ACLK										0x2070
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_PCLK										0x2074
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_ACLK									0x2078
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_PCLK									0x207c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_ACLK									0x2080
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_PCLK									0x2084
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_ACLK									0x2088
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_PCLK									0x208c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK									0x2090
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK									0x2094
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK								0x2098
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_OSCCLK_IPCLKPORT_CLK								0x209c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_ACLK										0x20a0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_PCLK										0x20a4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSMMU_HSI2_IPCLKPORT_CLK_S2									0x20a8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK									0x20ac
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK								0x20b0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_PCLK								0x20b4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_ACLK								0x20b8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_PCLK								0x20bc
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_ACLK								0x20c0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_PCLK								0x20c4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_ACLK								0x20c8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_PCLK								0x20cc
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK										0x20d0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO									0x20d4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK									0x20d8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_D_HSI2_IPCLKPORT_ACLK										0x20dc
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_P_HSI2_IPCLKPORT_ACLK										0x20e0
+#define DMYQCH_CON_PCIE_GEN4_1_QCH_SCLK_1												0x3000
+#define PCH_CON_LHM_AXI_P_HSI2_PCH													0x3008
+#define PCH_CON_LHS_ACEL_D_HSI2_PCH													0x300c
+#define QCH_CON_D_TZPC_HSI2_QCH														0x3010
+#define QCH_CON_GPC_HSI2_QCH														0x3014
+#define QCH_CON_GPIO_HSI2_QCH														0x3018
+#define QCH_CON_HSI2_CMU_HSI2_QCH													0x301c
+#define QCH_CON_LHM_AXI_P_HSI2_QCH													0x3020
+#define QCH_CON_LHS_ACEL_D_HSI2_QCH													0x3024
+#define QCH_CON_MMC_CARD_QCH														0x3028
+#define QCH_CON_PCIE_GEN4_1_QCH_APB_1													0x302c
+#define QCH_CON_PCIE_GEN4_1_QCH_APB_2													0x3030
+#define QCH_CON_PCIE_GEN4_1_QCH_AXI_1													0x3034
+#define QCH_CON_PCIE_GEN4_1_QCH_AXI_2													0x3038
+#define QCH_CON_PCIE_GEN4_1_QCH_DBG_1													0x303c
+#define QCH_CON_PCIE_GEN4_1_QCH_DBG_2													0x3040
+#define QCH_CON_PCIE_GEN4_1_QCH_PCS_APB													0x3044
+#define QCH_CON_PCIE_GEN4_1_QCH_PMA_APB													0x3048
+#define QCH_CON_PCIE_GEN4_1_QCH_UDBG													0x304c
+#define QCH_CON_PCIE_IA_GEN4A_1_QCH													0x3050
+#define QCH_CON_PCIE_IA_GEN4B_1_QCH													0x3054
+#define QCH_CON_PPMU_HSI2_QCH														0x3058
+#define QCH_CON_QE_MMC_CARD_HSI2_QCH													0x305c
+#define QCH_CON_QE_PCIE_GEN4A_HSI2_QCH													0x3060
+#define QCH_CON_QE_PCIE_GEN4B_HSI2_QCH													0x3064
+#define QCH_CON_QE_UFS_EMBD_HSI2_QCH													0x3068
+#define QCH_CON_SSMT_HSI2_QCH														0x306c
+#define QCH_CON_SSMT_PCIE_IA_GEN4A_1_QCH												0x3070
+#define QCH_CON_SSMT_PCIE_IA_GEN4B_1_QCH												0x3074
+#define QCH_CON_SYSMMU_HSI2_QCH														0x3078
+#define QCH_CON_SYSREG_HSI2_QCH														0x307c
+#define QCH_CON_UASC_PCIE_GEN4A_DBI_1_QCH												0x3080
+#define QCH_CON_UASC_PCIE_GEN4A_SLV_1_QCH												0x3084
+#define QCH_CON_UASC_PCIE_GEN4B_DBI_1_QCH												0x3088
+#define QCH_CON_UASC_PCIE_GEN4B_SLV_1_QCH												0x308c
+#define QCH_CON_UFS_EMBD_QCH														0x3090
+#define QCH_CON_UFS_EMBD_QCH_FMP													0x3094
+#define QUEUE_CTRL_REG_BLK_HSI2_CMU_HSI2												0x3c00
+
+static const unsigned long cmu_hsi2_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_MMC_CARD_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_MMC_CARD_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_PCIE_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_PCIE_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	HSI2_CMU_HSI2_CONTROLLER_OPTION,
+	CLKOUT_CON_BLK_HSI2_CMU_HSI2_CLKOUT0,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_D_TZPC_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPC_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPIO_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHM_AXI_P_HSI2_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHS_ACEL_D_HSI2_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_I_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_SDCLKIN,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PHY_UDBG_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PIPE_PAL_PCIE_INST_0_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_SF_PCIEPHY210X2_LN05LPE_QCH_TM_WRAPPER_INST_0_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4A_1_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4B_1_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_OSCCLK_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSMMU_HSI2_IPCLKPORT_CLK_S2,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_D_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_P_HSI2_IPCLKPORT_ACLK,
+	DMYQCH_CON_PCIE_GEN4_1_QCH_SCLK_1,
+	PCH_CON_LHM_AXI_P_HSI2_PCH,
+	PCH_CON_LHS_ACEL_D_HSI2_PCH,
+	QCH_CON_D_TZPC_HSI2_QCH,
+	QCH_CON_GPC_HSI2_QCH,
+	QCH_CON_GPIO_HSI2_QCH,
+	QCH_CON_HSI2_CMU_HSI2_QCH,
+	QCH_CON_LHM_AXI_P_HSI2_QCH,
+	QCH_CON_LHS_ACEL_D_HSI2_QCH,
+	QCH_CON_MMC_CARD_QCH,
+	QCH_CON_PCIE_GEN4_1_QCH_APB_1,
+	QCH_CON_PCIE_GEN4_1_QCH_APB_2,
+	QCH_CON_PCIE_GEN4_1_QCH_AXI_1,
+	QCH_CON_PCIE_GEN4_1_QCH_AXI_2,
+	QCH_CON_PCIE_GEN4_1_QCH_DBG_1,
+	QCH_CON_PCIE_GEN4_1_QCH_DBG_2,
+	QCH_CON_PCIE_GEN4_1_QCH_PCS_APB,
+	QCH_CON_PCIE_GEN4_1_QCH_PMA_APB,
+	QCH_CON_PCIE_GEN4_1_QCH_UDBG,
+	QCH_CON_PCIE_IA_GEN4A_1_QCH,
+	QCH_CON_PCIE_IA_GEN4B_1_QCH,
+	QCH_CON_PPMU_HSI2_QCH,
+	QCH_CON_QE_MMC_CARD_HSI2_QCH,
+	QCH_CON_QE_PCIE_GEN4A_HSI2_QCH,
+	QCH_CON_QE_PCIE_GEN4B_HSI2_QCH,
+	QCH_CON_QE_UFS_EMBD_HSI2_QCH,
+	QCH_CON_SSMT_HSI2_QCH,
+	QCH_CON_SSMT_PCIE_IA_GEN4A_1_QCH,
+	QCH_CON_SSMT_PCIE_IA_GEN4B_1_QCH,
+	QCH_CON_SYSMMU_HSI2_QCH,
+	QCH_CON_SYSREG_HSI2_QCH,
+	QCH_CON_UASC_PCIE_GEN4A_DBI_1_QCH,
+	QCH_CON_UASC_PCIE_GEN4A_SLV_1_QCH,
+	QCH_CON_UASC_PCIE_GEN4B_DBI_1_QCH,
+	QCH_CON_UASC_PCIE_GEN4B_SLV_1_QCH,
+	QCH_CON_UFS_EMBD_QCH,
+	QCH_CON_UFS_EMBD_QCH_FMP,
+	QUEUE_CTRL_REG_BLK_HSI2_CMU_HSI2,
+};
+
+PNAME(mout_hsi2_ufs_embd_p)	= { "oscclk", "dout_cmu_shared0_div4",
+				    "dout_cmu_shared2_div2", "fout_spare_pll" };
+
+PNAME(mout_hsi2_pcie_p)		= { "oscclk", "dout_cmu_shared2_div2" };
+
+PNAME(mout_hsi2_bus_p)		= { "dout_cmu_shared0_div4",
+				    "dout_cmu_shared1_div4",
+				    "dout_cmu_shared2_div2",
+				    "dout_cmu_shared3_div2",
+				    "fout_spare_pll", "oscclk", "oscclk",
+				    "oscclk" };
+
+PNAME(mout_hsi2_mmc_card_p)	= { "fout_shared2_pll", "fout_shared3_pll",
+				    "dout_cmu_shared0_div4", "fout_spare_pll" };
+
+PNAME(mout_hsi2_bus_user_p)	= { "oscclk", "dout_cmu_hsi2_bus" };
+PNAME(mout_hsi2_mmc_card_user_p) = { "oscclk", "dout_cmu_hsi2_mmc_card" };
+PNAME(mout_hsi2_pcie_user_p)	= { "oscclk", "dout_cmu_hsi2_pcie" };
+PNAME(mout_hsi2_ufs_embd_user_p) = { "oscclk", "dout_cmu_hsi2_ufs_embd" };
+
+static const struct samsung_mux_clock hsi2_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_HSI2_BUS_USER, "mout_hsi2_bus_user", mout_hsi2_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_HSI2_MMC_CARD_USER, "mout_hsi2_mmc_card_user",
+	    mout_hsi2_mmc_card_user_p, PLL_CON0_MUX_CLKCMU_HSI2_MMC_CARD_USER,
+	    4, 1),
+	MUX(CLK_MOUT_HSI2_PCIE_USER, "mout_hsi2_pcie_user",
+	    mout_hsi2_pcie_user_p, PLL_CON0_MUX_CLKCMU_HSI2_PCIE_USER,
+	    4, 1),
+	MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_hsi2_ufs_embd_user",
+	    mout_hsi2_ufs_embd_user_p, PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	    4, 1),
+};
+
+static const struct samsung_gate_clock hsi2_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_PHY_REFCLK_IN,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_phy_refclk_in",
+	     "mout_hsi2_pcie_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_PHY_REFCLK_IN,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_phy_refclk_in",
+	     "mout_hsi2_pcie_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_ACLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4a_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_PCLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4a_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4B_1_ACLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4b_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4B_1_PCLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4b_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_D_TZPC_HSI2_PCLK,
+	     "gout_hsi2_d_tzpc_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_D_TZPC_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_GPC_HSI2_PCLK,
+	     "gout_hsi2_gpc_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPC_HSI2_IPCLKPORT_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI2_GPIO_HSI2_PCLK,
+	     "gout_hsi2_gpio_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPIO_HSI2_IPCLKPORT_PCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	/* Disabling this clock makes the system hang. Mark the clock as critical. */
+	GATE(CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK,
+	     "gout_hsi2_hsi2_cmu_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IPCLKPORT_PCLK,
+	     21, CLK_IS_CRITICAL, 0),
+	/* Disabling this clock makes the system hang. Mark the clock as critical. */
+	GATE(CLK_GOUT_HSI2_LHM_AXI_P_HSI2_I_CLK,
+	     "gout_hsi2_lhm_axi_p_hsi2_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHM_AXI_P_HSI2_IPCLKPORT_I_CLK,
+	     21, CLK_IS_CRITICAL, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_LHS_ACEL_D_HSI2_I_CLK,
+	     "gout_hsi2_lhs_acel_d_hsi2_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHS_ACEL_D_HSI2_IPCLKPORT_I_CLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI2_MMC_CARD_I_ACLK,
+	     "gout_hsi2_mmc_card_i_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_I_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_MMC_CARD_SDCLKIN,
+	     "gout_hsi2_mmc_card_sdclkin", "mout_hsi2_mmc_card_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_SDCLKIN,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_DBI_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_dbi_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_MSTR_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_mstr_aclk_ug",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_SLV_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_slv_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_I_DRIVER_APB_CLK,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_i_driver_apb_clk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_DBI_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_dbi_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_MSTR_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_mstr_aclk_ug",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_SLV_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_slv_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_I_DRIVER_APB_CLK,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_i_driver_apb_clk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PHY_UDBG_I_APB_PCLK,
+	     "gout_hsi2_pcie_gen4_1_pcs_pma_phy_udbg_i_apb_pclk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PHY_UDBG_I_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PIPE_PAL_PCIE_I_APB_PCLK,
+	     "gout_hsi2_pcie_gen4_1_pcs_pma_pipe_pal_pcie_i_apb_pclk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PIPE_PAL_PCIE_INST_0_I_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PCIEPHY210X2_QCH_I_APB_PCLK,
+	     "gout_hsi2_pcie_gen4_1_pcs_pma_pciephy210x2_qch_i_apb_pclk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_SF_PCIEPHY210X2_LN05LPE_QCH_TM_WRAPPER_INST_0_I_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_IA_GEN4A_1_I_CLK,
+	     "gout_hsi2_pcie_ia_gen4a_1_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4A_1_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_IA_GEN4B_1_I_CLK,
+	     "gout_hsi2_pcie_ia_gen4b_1_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4B_1_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PPMU_HSI2_ACLK,
+	     "gout_hsi2_ppmu_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PPMU_HSI2_PCLK,
+	     "gout_hsi2_ppmu_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_MMC_CARD_HSI2_ACLK,
+	     "gout_hsi2_qe_mmc_card_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_MMC_CARD_HSI2_PCLK,
+	     "gout_hsi2_qe_mmc_card_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4A_HSI2_ACLK,
+	     "gout_hsi2_qe_pcie_gen4a_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4A_HSI2_PCLK,
+	     "gout_hsi2_qe_pcie_gen4a_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4B_HSI2_ACLK,
+	     "gout_hsi2_qe_pcie_gen4b_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4B_HSI2_PCLK,
+	     "gout_hsi2_qe_pcie_gen4b_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK,
+	     "gout_hsi2_qe_ufs_embd_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK,
+	     "gout_hsi2_qe_ufs_embd_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_CLK_HSI2_BUS_CLK,
+	     "gout_hsi2_clk_hsi2_bus_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK,
+	     21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_HSI2_CLK_HSI2_OSCCLK_CLK,
+	     "gout_hsi2_clk_hsi2_oscclk_clk", "oscclk",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_OSCCLK_IPCLKPORT_CLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_SSMT_HSI2_ACLK,
+	     "gout_hsi2_ssmt_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_SSMT_HSI2_PCLK,
+	     "gout_hsi2_ssmt_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_PCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_SYSMMU_HSI2_CLK_S2,
+	     "gout_hsi2_sysmmu_hsi2_clk_s2", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSMMU_HSI2_IPCLKPORT_CLK_S2,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI2_SYSREG_HSI2_PCLK,
+	     "gout_hsi2_sysreg_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4a_dbi_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4a_dbi_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_SLV_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4a_slv_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_SLV_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4a_slv_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_DBI_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4b_dbi_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_DBI_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4b_dbi_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_SLV_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4b_slv_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_SLV_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4b_slv_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_ACLK,
+	     "gout_hsi2_ufs_embd_i_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO,
+	     "gout_hsi2_ufs_embd_i_clk_unipro", "mout_hsi2_ufs_embd_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK,
+	     "gout_hsi2_ufs_embd_i_fmp_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_XIU_D_HSI2_ACLK,
+	     "gout_hsi2_xiu_d_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_D_HSI2_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_XIU_P_HSI2_ACLK,
+	     "gout_hsi2_xiu_p_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_P_HSI2_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info hsi2_cmu_info __initconst = {
+	.mux_clks		= hsi2_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(hsi2_mux_clks),
+	.gate_clks		= hsi2_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(hsi2_gate_clks),
+	.nr_clk_ids		= CLKS_NR_HSI2,
+	.clk_regs		= cmu_hsi2_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cmu_hsi2_clk_regs),
+	.clk_name		= "bus",
+};
+
 /* ---- CMU_MISC ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_MISC (0x10010000) */
@@ -3910,6 +4414,9 @@ static const struct of_device_id gs101_cmu_of_match[] = {
 	}, {
 		.compatible = "google,gs101-cmu-hsi0",
 		.data = &hsi0_cmu_info,
+	}, {
+		.compatible = "google,gs101-cmu-hsi2",
+		.data = &hsi2_cmu_info,
 	}, {
 		.compatible = "google,gs101-cmu-peric0",
 		.data = &peric0_cmu_info,

-- 
2.44.0.769.g3c40516874-goog


