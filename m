Return-Path: <linux-kernel+bounces-110650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308188861CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546091C21D10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833D135A40;
	Thu, 21 Mar 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="niqwiuS3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="aHYViVX9"
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0C5660;
	Thu, 21 Mar 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053719; cv=none; b=FgtD+P0YJU5DNP3I90/lFf0BeaJWlR4sUDZS6WZE+UFVGH4ZzCTYHQu5wl7G2ihIP9EuupGEc7fF/mbytv3zQZKypVk5JtbPiC1u901DcWvzFHdZGajZzGkMhmLsLdOxc4+fKr4OIHaP0AOGXDOFRxDhDAO+tJRF32ZHAlNmn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053719; c=relaxed/simple;
	bh=wK3iF/fiU+q0jztkOEDxn3NlCEy2KwMhoyfosKEDFP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5xBLT7bzCoO+xNawn+uLxEK5cXwWkmGc5QGq08JErGHjNKyeKvlLk7U1nrC87TIaxLMXVWqFppicEcQEGbliMQzZQTrnCpNFwwRYOxFCQb+8xhlpeX2TbutHamZnm2ybWho0ldx4nq/7r/igFquP+1CbvEDHik7+fScctMnNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=niqwiuS3; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=aHYViVX9; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=z3ZHsNstHCqTeQSwT4NV3V3wkLNCBEiBpiIP485m7gU=;
	t=1711053715;x=1711143715; 
	b=niqwiuS3ZJ5pq6EdqfSmoRb0hnpwDNmkBsHt4oWyW7hhXTIdBIJ2IaR25JU15+cM9P881JxFmP3oGgVkUP5ly2d7kz8IhQxWT6BZWn89Wta6xXfBJAUfcQlyXw4qQy6a0swv1NlpWG+CLT0RwOQCeR8kOhsY9BQN2pGzqGlXCLY=;
Received: from [10.12.4.2] (port=39508 helo=smtp29.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rnP2L-00CzEV-QD; Thu, 21 Mar 2024 23:29:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=z3ZHsNstHCqTeQSwT4NV3V3wkLNCBEiBpiIP485m7gU=; t=1711052957; x=1711142957; 
	b=aHYViVX9brUCnYqEHtzAl9AkY5E1hQ6hRi5jf+DziiohKgQKIzZr5FKohctGJiL1KWGo7IBKkcW
	ry6uF0N3d+WvEVcIKxJK0CXRRncjhrHrq1/8QLsn1vr033nrXzWi/d9qHfiHwAjgdGWo3NIZTbocI
	509dAJu6homImTnAbkY=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rnP26-00000005qz4-1HL5; Thu, 21 Mar 2024 23:29:02 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	david@mainlining.org,
	adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 3/7] clk: qcom: Add Display Clock Controller driver for SM7150
Date: Thu, 21 Mar 2024 23:28:10 +0300
Message-ID: <20240321202814.59835-4-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321202814.59835-1-danila@jiaxyga.com>
References: <20240321202814.59835-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD94D5EF110843E6A67041C1113DA195F221E799EC26425FE70182A05F5380850404C228DA9ACA6FE272F29E87F64552CE6D27678DDAA80631441C8C6D5BE7A461CDF7EF9FDA0AB3C10A1875F26E213F90A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A38BB8BAFDA01E41EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E7FC1205106FBD248638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D840358991B472BB56B82A659056168E439CE77429FC3F184FCC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C37EF884183F8E4D67117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFC8011CB230C7A12ABA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B638BCB7A7EE7F5AC876E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B697DDD8CAF9594832089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A52480A99CBDDB138B5002B1117B3ED6966F9E1093FF43A925FB820E9FE7BD014C823CB91A9FED034534781492E4B8EEADBC0994F947283B77C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFFA2C76C52AD5E683606FA82A7B7CE8BB8F527904591DC3557E2ADFFAE998DC157D7FE2FA29F57787A5E652D4FCD6795A0711AF3E2861AB4C07F407391B6C10D86AADEE5E2D953C46146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes26yEte5WHlBVQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498123F80C9C64FBB36E5E07F309F87FFB14FF9C5695B99C3C89610E773F822C07E32C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4A873E06F0BBE0AC55F461D0D97ABE2D6780F70D66B4C0EDB68F3CF0E9FE49B6993595096ACAD5B56232BAB2DD744D27069C9AB29F16EF905D9906FDEF177E729
X-7FA49CB5: 0D63561A33F958A520ECE389252CC0B41E1F95767BA0224EE40E66478006621E8941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C369A9B21EF3CACE7135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes24se3fXhCcSIA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add support for the display clock controller found on SM7150.

Co-developed-by: David Wronek <david@mainlining.org>
Signed-off-by: David Wronek <david@mainlining.org>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/clk/qcom/Kconfig         |   10 +
 drivers/clk/qcom/Makefile        |    1 +
 drivers/clk/qcom/dispcc-sm7150.c | 1020 ++++++++++++++++++++++++++++++
 3 files changed, 1031 insertions(+)
 create mode 100644 drivers/clk/qcom/dispcc-sm7150.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 966770187844..384c50cbdcd0 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -846,6 +846,16 @@ config SM_DISPCC_6125
 	  Say Y if you want to support display devices and functionality such as
 	  splash screen
 
+config SM_DISPCC_7150
+	tristate "SM7150 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	depends on SM_GCC_7150
+	help
+	  Support for the display clock controller on Qualcomm Technologies, Inc
+	  SM7150 devices.
+	  Say Y if you want to support display devices and functionality such as
+	  splash screen.
+
 config SM_DISPCC_8250
 	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index dec5b6db6860..cdec5ce2bb94 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
 obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
 obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
 obj-$(CONFIG_SM_DISPCC_6375) += dispcc-sm6375.o
+obj-$(CONFIG_SM_DISPCC_7150) += dispcc-sm7150.o
 obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
 obj-$(CONFIG_SM_DISPCC_8450) += dispcc-sm8450.o
 obj-$(CONFIG_SM_DISPCC_8550) += dispcc-sm8550.o
diff --git a/drivers/clk/qcom/dispcc-sm7150.c b/drivers/clk/qcom/dispcc-sm7150.c
new file mode 100644
index 000000000000..6f7ea3c0ff4e
--- /dev/null
+++ b/drivers/clk/qcom/dispcc-sm7150.c
@@ -0,0 +1,1020 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ * Copyright (c) 2024, David Wronek <david@mainlining.org>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm7150-dispcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "gdsc.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+	DT_GCC_DISP_GPLL0_CLK,
+	DT_CHIP_SLEEP_CLK,
+	DT_DSI0_PHY_PLL_OUT_BYTECLK,
+	DT_DSI0_PHY_PLL_OUT_DSICLK,
+	DT_DSI1_PHY_PLL_OUT_BYTECLK,
+	DT_DSI1_PHY_PLL_OUT_DSICLK,
+	DT_DP_PHY_PLL_LINK_CLK,
+	DT_DP_PHY_PLL_VCO_DIV_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_CHIP_SLEEP_CLK,
+	P_DISPCC_PLL0_OUT_EVEN,
+	P_DISPCC_PLL0_OUT_MAIN,
+	P_DP_PHY_PLL_LINK_CLK,
+	P_DP_PHY_PLL_VCO_DIV_CLK,
+	P_DSI0_PHY_PLL_OUT_BYTECLK,
+	P_DSI0_PHY_PLL_OUT_DSICLK,
+	P_DSI1_PHY_PLL_OUT_BYTECLK,
+	P_DSI1_PHY_PLL_OUT_DSICLK,
+	P_GCC_DISP_GPLL0_CLK,
+};
+
+static const struct pll_vco fabia_vco[] = {
+	{ 249600000, 2000000000, 0 },
+	{ 125000000, 1000000000, 1 },
+};
+
+/* 860MHz configuration */
+static const struct alpha_pll_config dispcc_pll0_config = {
+	.l = 0x2c,
+	.alpha = 0xcaaa,
+	.test_ctl_val = 0x40000000,
+};
+
+static struct clk_alpha_pll dispcc_pll0 = {
+	.offset = 0x0,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_pll0",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct parent_map dispcc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 1 },
+	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 2 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
+	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
+};
+
+static const struct parent_map dispcc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DP_PHY_PLL_LINK_CLK, 1 },
+	{ P_DP_PHY_PLL_VCO_DIV_CLK, 2 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_DP_PHY_PLL_LINK_CLK },
+	{ .index = DT_DP_PHY_PLL_VCO_DIV_CLK },
+};
+
+static const struct parent_map dispcc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data dispcc_parent_data_2_ao[] = {
+	{ .index = DT_BI_TCXO_AO },
+};
+
+static const struct parent_map dispcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DISPCC_PLL0_OUT_MAIN, 1 },
+	{ P_GCC_DISP_GPLL0_CLK, 4 },
+	{ P_DISPCC_PLL0_OUT_EVEN, 5 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_3[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &dispcc_pll0.clkr.hw },
+	{ .index = DT_GCC_DISP_GPLL0_CLK },
+	{ .hw = &dispcc_pll0.clkr.hw },
+};
+
+static const struct parent_map dispcc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
+	{ P_DSI1_PHY_PLL_OUT_DSICLK, 2 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_4[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_DSI0_PHY_PLL_OUT_DSICLK },
+	{ .index = DT_DSI1_PHY_PLL_OUT_DSICLK },
+};
+
+static const struct parent_map dispcc_parent_map_5[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_DISP_GPLL0_CLK, 4 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_5[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_GCC_DISP_GPLL0_CLK },
+};
+
+static const struct parent_map dispcc_parent_map_6[] = {
+	{ P_CHIP_SLEEP_CLK, 0 },
+};
+
+static const struct clk_parent_data dispcc_parent_data_6[] = {
+	{ .index = DT_CHIP_SLEEP_CLK },
+};
+
+static const struct freq_tbl ftbl_dispcc_mdss_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(37500000, P_GCC_DISP_GPLL0_CLK, 16, 0, 0),
+	F(75000000, P_GCC_DISP_GPLL0_CLK, 8, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_mdss_ahb_clk_src = {
+	.cmd_rcgr = 0x22bc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_5,
+	.freq_tbl = ftbl_dispcc_mdss_ahb_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_ahb_clk_src",
+		.parent_data = dispcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_5),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dispcc_mdss_byte0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_mdss_byte0_clk_src = {
+	.cmd_rcgr = 0x2110,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_0,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_byte0_clk_src",
+		.parent_data = dispcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_byte2_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_byte1_clk_src = {
+	.cmd_rcgr = 0x212c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_0,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_byte1_clk_src",
+		.parent_data = dispcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_byte2_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_dp_aux_clk_src = {
+	.cmd_rcgr = 0x21dc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_2,
+	.freq_tbl = ftbl_dispcc_mdss_byte0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_dp_aux_clk_src",
+		.parent_data = dispcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dispcc_mdss_dp_crypto_clk_src[] = {
+	F(108000, P_DP_PHY_PLL_LINK_CLK, 3, 0, 0),
+	F(180000, P_DP_PHY_PLL_LINK_CLK, 3, 0, 0),
+	F(360000, P_DP_PHY_PLL_LINK_CLK, 1.5, 0, 0),
+	F(540000, P_DP_PHY_PLL_LINK_CLK, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_mdss_dp_crypto_clk_src = {
+	.cmd_rcgr = 0x2194,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_1,
+	.freq_tbl = ftbl_dispcc_mdss_dp_crypto_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_dp_crypto_clk_src",
+		.parent_data = dispcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_1),
+		.flags = CLK_GET_RATE_NOCACHE,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dispcc_mdss_dp_link_clk_src[] = {
+	F(162000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
+	F(270000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
+	F(540000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
+	F(810000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_mdss_dp_link_clk_src = {
+	.cmd_rcgr = 0x2178,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_1,
+	.freq_tbl = ftbl_dispcc_mdss_dp_link_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_dp_link_clk_src",
+		.parent_data = dispcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_dp_pixel1_clk_src = {
+	.cmd_rcgr = 0x21c4,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_1,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_dp_pixel1_clk_src",
+		.parent_data = dispcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_dp_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_dp_pixel_clk_src = {
+	.cmd_rcgr = 0x21ac,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_1,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_dp_pixel_clk_src",
+		.parent_data = dispcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_dp_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_esc0_clk_src = {
+	.cmd_rcgr = 0x2148,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_0,
+	.freq_tbl = ftbl_dispcc_mdss_byte0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_esc0_clk_src",
+		.parent_data = dispcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_esc1_clk_src = {
+	.cmd_rcgr = 0x2160,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_0,
+	.freq_tbl = ftbl_dispcc_mdss_byte0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_esc1_clk_src",
+		.parent_data = dispcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dispcc_mdss_mdp_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(85714286, P_GCC_DISP_GPLL0_CLK, 7, 0, 0),
+	F(100000000, P_GCC_DISP_GPLL0_CLK, 6, 0, 0),
+	F(150000000, P_GCC_DISP_GPLL0_CLK, 4, 0, 0),
+	F(172000000, P_DISPCC_PLL0_OUT_MAIN, 5, 0, 0),
+	F(200000000, P_GCC_DISP_GPLL0_CLK, 3, 0, 0),
+	F(286666667, P_DISPCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_GCC_DISP_GPLL0_CLK, 2, 0, 0),
+	F(344000000, P_DISPCC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(430000000, P_DISPCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_mdss_mdp_clk_src = {
+	.cmd_rcgr = 0x20c8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_3,
+	.freq_tbl = ftbl_dispcc_mdss_mdp_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_mdp_clk_src",
+		.parent_data = dispcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_pclk0_clk_src = {
+	.cmd_rcgr = 0x2098,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_pclk0_clk_src",
+		.parent_data = dispcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_4),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_pixel_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_pclk1_clk_src = {
+	.cmd_rcgr = 0x20b0,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_pclk1_clk_src",
+		.parent_data = dispcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_4),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_pixel_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dispcc_mdss_rot_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(171428571, P_GCC_DISP_GPLL0_CLK, 3.5, 0, 0),
+	F(200000000, P_GCC_DISP_GPLL0_CLK, 3, 0, 0),
+	F(300000000, P_GCC_DISP_GPLL0_CLK, 2, 0, 0),
+	F(344000000, P_DISPCC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(430000000, P_DISPCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_mdss_rot_clk_src = {
+	.cmd_rcgr = 0x20e0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_3,
+	.freq_tbl = ftbl_dispcc_mdss_rot_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_rot_clk_src",
+		.parent_data = dispcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_3),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_mdss_vsync_clk_src = {
+	.cmd_rcgr = 0x20f8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_2,
+	.freq_tbl = ftbl_dispcc_mdss_byte0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_mdss_vsync_clk_src",
+		.parent_data = dispcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dispcc_sleep_clk_src[] = {
+	F(32000, P_CHIP_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dispcc_sleep_clk_src = {
+	.cmd_rcgr = 0x6060,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_6,
+	.freq_tbl = ftbl_dispcc_sleep_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_sleep_clk_src",
+		.parent_data = dispcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_6),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 dispcc_xo_clk_src = {
+	.cmd_rcgr = 0x6044,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = dispcc_parent_map_2,
+	.freq_tbl = ftbl_dispcc_mdss_byte0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "dispcc_xo_clk_src",
+		.parent_data = dispcc_parent_data_2_ao,
+		.num_parents = ARRAY_SIZE(dispcc_parent_data_2_ao),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch dispcc_mdss_ahb_clk = {
+	.halt_reg = 0x2080,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2080,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_byte0_clk = {
+	.halt_reg = 0x2028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_byte0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_byte0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div dispcc_mdss_byte0_div_clk_src = {
+	.reg = 0x2128,
+	.shift = 0,
+	.width = 2,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_byte0_div_clk_src",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_byte0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_byte0_intf_clk = {
+	.halt_reg = 0x202c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x202c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_byte0_intf_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_byte0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_byte1_clk = {
+	.halt_reg = 0x2030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2030,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_byte1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_byte1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div dispcc_mdss_byte1_div_clk_src = {
+	.reg = 0x2144,
+	.shift = 0,
+	.width = 2,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_byte1_div_clk_src",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_byte1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_byte1_intf_clk = {
+	.halt_reg = 0x2034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2034,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_byte1_intf_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_byte1_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_dp_aux_clk = {
+	.halt_reg = 0x2054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_dp_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_dp_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_dp_crypto_clk = {
+	.halt_reg = 0x2048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2048,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_dp_crypto_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_dp_crypto_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_dp_link_clk = {
+	.halt_reg = 0x2040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2040,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_dp_link_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_dp_link_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_dp_link_intf_clk = {
+	.halt_reg = 0x2044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_dp_link_intf_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_dp_link_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_dp_pixel1_clk = {
+	.halt_reg = 0x2050,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2050,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_dp_pixel1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_dp_pixel1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_dp_pixel_clk = {
+	.halt_reg = 0x204c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x204c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_dp_pixel_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_dp_pixel_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_esc0_clk = {
+	.halt_reg = 0x2038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_esc0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_esc0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_esc1_clk = {
+	.halt_reg = 0x203c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x203c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_esc1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_esc1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_mdp_clk = {
+	.halt_reg = 0x200c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x200c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_mdp_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_mdp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_mdp_lut_clk = {
+	.halt_reg = 0x201c,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x201c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_mdp_lut_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_mdp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_non_gdsc_ahb_clk = {
+	.halt_reg = 0x4004,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x4004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_non_gdsc_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_pclk0_clk = {
+	.halt_reg = 0x2004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_pclk0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_pclk0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_pclk1_clk = {
+	.halt_reg = 0x2008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_pclk1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_pclk1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_rot_clk = {
+	.halt_reg = 0x2014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_rot_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_rot_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_rscc_ahb_clk = {
+	.halt_reg = 0x400c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x400c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_rscc_ahb_clk",
+			.parent_names = (const char *[]) {
+				"dispcc_mdss_ahb_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_rscc_vsync_clk = {
+	.halt_reg = 0x4008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_rscc_vsync_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_vsync_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_mdss_vsync_clk = {
+	.halt_reg = 0x2024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_mdss_vsync_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&dispcc_mdss_vsync_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch dispcc_sleep_clk = {
+	.halt_reg = 0x6078,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6078,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "dispcc_sleep_clk",
+			.parent_names = (const char *[]) {
+				"dispcc_sleep_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x3000,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "mdss_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
+};
+
+static struct clk_regmap *dispcc_sm7150_clocks[] = {
+	[DISPCC_MDSS_AHB_CLK] = &dispcc_mdss_ahb_clk.clkr,
+	[DISPCC_MDSS_AHB_CLK_SRC] = &dispcc_mdss_ahb_clk_src.clkr,
+	[DISPCC_MDSS_BYTE0_CLK] = &dispcc_mdss_byte0_clk.clkr,
+	[DISPCC_MDSS_BYTE0_CLK_SRC] = &dispcc_mdss_byte0_clk_src.clkr,
+	[DISPCC_MDSS_BYTE0_DIV_CLK_SRC] = &dispcc_mdss_byte0_div_clk_src.clkr,
+	[DISPCC_MDSS_BYTE0_INTF_CLK] = &dispcc_mdss_byte0_intf_clk.clkr,
+	[DISPCC_MDSS_BYTE1_CLK] = &dispcc_mdss_byte1_clk.clkr,
+	[DISPCC_MDSS_BYTE1_CLK_SRC] = &dispcc_mdss_byte1_clk_src.clkr,
+	[DISPCC_MDSS_BYTE1_DIV_CLK_SRC] = &dispcc_mdss_byte1_div_clk_src.clkr,
+	[DISPCC_MDSS_BYTE1_INTF_CLK] = &dispcc_mdss_byte1_intf_clk.clkr,
+	[DISPCC_MDSS_DP_AUX_CLK] = &dispcc_mdss_dp_aux_clk.clkr,
+	[DISPCC_MDSS_DP_AUX_CLK_SRC] = &dispcc_mdss_dp_aux_clk_src.clkr,
+	[DISPCC_MDSS_DP_CRYPTO_CLK] = &dispcc_mdss_dp_crypto_clk.clkr,
+	[DISPCC_MDSS_DP_CRYPTO_CLK_SRC] = &dispcc_mdss_dp_crypto_clk_src.clkr,
+	[DISPCC_MDSS_DP_LINK_CLK] = &dispcc_mdss_dp_link_clk.clkr,
+	[DISPCC_MDSS_DP_LINK_CLK_SRC] = &dispcc_mdss_dp_link_clk_src.clkr,
+	[DISPCC_MDSS_DP_LINK_INTF_CLK] = &dispcc_mdss_dp_link_intf_clk.clkr,
+	[DISPCC_MDSS_DP_PIXEL1_CLK] = &dispcc_mdss_dp_pixel1_clk.clkr,
+	[DISPCC_MDSS_DP_PIXEL1_CLK_SRC] = &dispcc_mdss_dp_pixel1_clk_src.clkr,
+	[DISPCC_MDSS_DP_PIXEL_CLK] = &dispcc_mdss_dp_pixel_clk.clkr,
+	[DISPCC_MDSS_DP_PIXEL_CLK_SRC] = &dispcc_mdss_dp_pixel_clk_src.clkr,
+	[DISPCC_MDSS_ESC0_CLK] = &dispcc_mdss_esc0_clk.clkr,
+	[DISPCC_MDSS_ESC0_CLK_SRC] = &dispcc_mdss_esc0_clk_src.clkr,
+	[DISPCC_MDSS_ESC1_CLK] = &dispcc_mdss_esc1_clk.clkr,
+	[DISPCC_MDSS_ESC1_CLK_SRC] = &dispcc_mdss_esc1_clk_src.clkr,
+	[DISPCC_MDSS_MDP_CLK] = &dispcc_mdss_mdp_clk.clkr,
+	[DISPCC_MDSS_MDP_CLK_SRC] = &dispcc_mdss_mdp_clk_src.clkr,
+	[DISPCC_MDSS_MDP_LUT_CLK] = &dispcc_mdss_mdp_lut_clk.clkr,
+	[DISPCC_MDSS_NON_GDSC_AHB_CLK] = &dispcc_mdss_non_gdsc_ahb_clk.clkr,
+	[DISPCC_MDSS_PCLK0_CLK] = &dispcc_mdss_pclk0_clk.clkr,
+	[DISPCC_MDSS_PCLK0_CLK_SRC] = &dispcc_mdss_pclk0_clk_src.clkr,
+	[DISPCC_MDSS_PCLK1_CLK] = &dispcc_mdss_pclk1_clk.clkr,
+	[DISPCC_MDSS_PCLK1_CLK_SRC] = &dispcc_mdss_pclk1_clk_src.clkr,
+	[DISPCC_MDSS_ROT_CLK] = &dispcc_mdss_rot_clk.clkr,
+	[DISPCC_MDSS_ROT_CLK_SRC] = &dispcc_mdss_rot_clk_src.clkr,
+	[DISPCC_MDSS_RSCC_AHB_CLK] = &dispcc_mdss_rscc_ahb_clk.clkr,
+	[DISPCC_MDSS_RSCC_VSYNC_CLK] = &dispcc_mdss_rscc_vsync_clk.clkr,
+	[DISPCC_MDSS_VSYNC_CLK] = &dispcc_mdss_vsync_clk.clkr,
+	[DISPCC_MDSS_VSYNC_CLK_SRC] = &dispcc_mdss_vsync_clk_src.clkr,
+	[DISPCC_PLL0] = &dispcc_pll0.clkr,
+	[DISPCC_SLEEP_CLK] = &dispcc_sleep_clk.clkr,
+	[DISPCC_SLEEP_CLK_SRC] = &dispcc_sleep_clk_src.clkr,
+	[DISPCC_XO_CLK_SRC] = &dispcc_xo_clk_src.clkr,
+};
+
+static struct gdsc *dispcc_sm7150_gdscs[] = {
+	[MDSS_GDSC] = &mdss_gdsc,
+};
+
+static const struct regmap_config dispcc_sm7150_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x10000,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc dispcc_sm7150_desc = {
+	.config = &dispcc_sm7150_regmap_config,
+	.clks = dispcc_sm7150_clocks,
+	.num_clks = ARRAY_SIZE(dispcc_sm7150_clocks),
+	.gdscs = dispcc_sm7150_gdscs,
+	.num_gdscs = ARRAY_SIZE(dispcc_sm7150_gdscs),
+};
+
+static const struct of_device_id dispcc_sm7150_match_table[] = {
+	{ .compatible = "qcom,sm7150-dispcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dispcc_sm7150_match_table);
+
+static int dispcc_sm7150_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &dispcc_sm7150_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&dispcc_pll0, regmap, &dispcc_pll0_config);
+	/* Enable clock gating for DSI and MDP clocks */
+	regmap_update_bits(regmap, 0x8000, 0x7f0, 0x7f0);
+
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISPCC_XO_CLK */
+
+	return qcom_cc_really_probe(pdev, &dispcc_sm7150_desc, regmap);
+}
+
+static struct platform_driver dispcc_sm7150_driver = {
+	.probe = dispcc_sm7150_probe,
+	.driver = {
+		.name = "dispcc-sm7150",
+		.of_match_table = dispcc_sm7150_match_table,
+	},
+};
+
+module_platform_driver(dispcc_sm7150_driver);
+
+MODULE_DESCRIPTION("Qualcomm SM7150 Display Clock Controller");
+MODULE_LICENSE("GPL");
-- 
2.44.0


