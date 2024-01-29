Return-Path: <linux-kernel+bounces-42181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C083FD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515221F220B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7414D5A0;
	Mon, 29 Jan 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X74J8VsP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5244D583;
	Mon, 29 Jan 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505126; cv=none; b=HclaSrAoqKsofK5dpfZD8Mg7HBgD503TJmASyPb9s4aevwOfqtt393Ayg0ZR5kl2MivJXQYAvgQDaIHRlHJ3PQaD1TBI/As5Uchhx+3llih7lyKn6ScWuMoVOINFgG0dF2is48xMzZ1+jMnsJVuhwBLfpYPt8WZNg873PgM4vJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505126; c=relaxed/simple;
	bh=Hmow3T0BqoQVvzYU+lNs0mVs4UR5j8+2I7n8hD0DKjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+XpoFtzHeH7+teHIVUqhHc41VvoD7mQv9bKQZ2gSioIHzay0Hac8FJoZ63HzWrxmEb/v6kZPTlvi7qgFH+v4Z4sRSDzvtIfLghZB0oSpKFGrg76msUpbrnj2LqbROQJT33PdHeMhy4alKMxwbGrHTCFi6xY9PDVdqKykXeqGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X74J8VsP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4T9e9002818;
	Mon, 29 Jan 2024 05:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=h6iV1xYUuyVCQxCXDT+O0sojHxg8BfPTRwe7LiM6Ocs=; b=X7
	4J8VsPUWq51n5xji8p6zx5o224iWdezlLEs5c0nS7MFvF+SQe3ziaWIaPiDIMKUh
	XwxiF4rBaFVH7MhixWE9lnCHwhg+p/m4kUxVyddklIQ2Q3Mpjprs1xy8hlNDlxIX
	SqTlUYkozV3NTSY+9r53SFz+O0R8/aHSXp5QnMc2D4WwCWlzdmQljLahZu5x8T3i
	UmkRDcSq9J7cD6D6pJcFAjgxsi0135bc0fpZfS/XxsUEYWvbNwaYdzwaTSkErQRC
	T1WjKGM/qqwbkb3vxLF7n3ThNHZ+vf1GufCDlUnceb6iF1cS4aXlToWGtdvduSdK
	2YeQa8zgt3i9HvxWVRNg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvs5p2v6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:11:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5BjGB021124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:11:45 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:11:39 -0800
From: Devi Priya <quic_devipriy@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 3/7] clk: qcom: gcc-ipq9574: Add gpll0_out_aux clock & enable few nssnoc clocks
Date: Mon, 29 Jan 2024 10:41:00 +0530
Message-ID: <20240129051104.1855487-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
References: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: blDEYuSrOtdm8H_ynAnu5PLqkLITQU-5
X-Proofpoint-ORIG-GUID: blDEYuSrOtdm8H_ynAnu5PLqkLITQU-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290034

gcc_nssnoc_nsscc_clk, gcc_nssnoc_snoc_clk, gcc_nssnoc_snoc_1_clk are
enabled by default and the RCGs are properly configured by the bootloader.

Some of the NSS clocks needs these clocks to be enabled. To avoid
these clocks being disabled by clock framework, drop these entries
from the clock table and enable it in the driver probe itself.

Also, add support for gpll0_out_aux clock which acts as the parent for
certain networking subsystem (nss) clocks.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Dropped flags for gpll0_out_aux
	- Dropped few nss clock entries from the clock table and enabled
	  them in the probe

 drivers/clk/qcom/gcc-ipq9574.c | 83 ++++++++++++----------------------
 1 file changed, 28 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index e8190108e1ae..987703431b5b 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -105,6 +105,20 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 	},
 };
 
+static struct clk_alpha_pll_postdiv gpll0_out_aux = {
+	.offset = 0x20000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpll0_out_aux",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll0_main.clkr.hw
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ro_ops,
+	},
+};
+
 static struct clk_alpha_pll gpll4_main = {
 	.offset = 0x22000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
@@ -2186,23 +2200,6 @@ static struct clk_branch gcc_nsscfg_clk = {
 	},
 };
 
-static struct clk_branch gcc_nssnoc_nsscc_clk = {
-	.halt_reg = 0x17030,
-	.clkr = {
-		.enable_reg = 0x17030,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_nssnoc_nsscc_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&pcnoc_bfdcd_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_nsscc_clk = {
 	.halt_reg = 0x17034,
 	.clkr = {
@@ -2585,40 +2582,6 @@ static struct clk_branch gcc_q6ss_boot_clk = {
 	},
 };
 
-static struct clk_branch gcc_nssnoc_snoc_clk = {
-	.halt_reg = 0x17028,
-	.clkr = {
-		.enable_reg = 0x17028,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_nssnoc_snoc_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&system_noc_bfdcd_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_nssnoc_snoc_1_clk = {
-	.halt_reg = 0x1707c,
-	.clkr = {
-		.enable_reg = 0x1707c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_nssnoc_snoc_1_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&system_noc_bfdcd_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_qdss_etr_usb_clk = {
 	.halt_reg = 0x2d060,
 	.clkr = {
@@ -4043,7 +4006,6 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
 	[PCNOC_BFDCD_CLK_SRC] = &pcnoc_bfdcd_clk_src.clkr,
 	[GCC_NSSCFG_CLK] = &gcc_nsscfg_clk.clkr,
-	[GCC_NSSNOC_NSSCC_CLK] = &gcc_nssnoc_nsscc_clk.clkr,
 	[GCC_NSSCC_CLK] = &gcc_nsscc_clk.clkr,
 	[GCC_NSSNOC_PCNOC_1_CLK] = &gcc_nssnoc_pcnoc_1_clk.clkr,
 	[GCC_QDSS_DAP_AHB_CLK] = &gcc_qdss_dap_ahb_clk.clkr,
@@ -4059,8 +4021,6 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_CMN_12GPLL_AHB_CLK] = &gcc_cmn_12gpll_ahb_clk.clkr,
 	[GCC_CMN_12GPLL_APU_CLK] = &gcc_cmn_12gpll_apu_clk.clkr,
 	[SYSTEM_NOC_BFDCD_CLK_SRC] = &system_noc_bfdcd_clk_src.clkr,
-	[GCC_NSSNOC_SNOC_CLK] = &gcc_nssnoc_snoc_clk.clkr,
-	[GCC_NSSNOC_SNOC_1_CLK] = &gcc_nssnoc_snoc_1_clk.clkr,
 	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
 	[WCSS_AHB_CLK_SRC] = &wcss_ahb_clk_src.clkr,
 	[GCC_Q6_AHB_CLK] = &gcc_q6_ahb_clk.clkr,
@@ -4140,6 +4100,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_SNOC_PCIE1_1LANE_S_CLK] = &gcc_snoc_pcie1_1lane_s_clk.clkr,
 	[GCC_SNOC_PCIE2_2LANE_S_CLK] = &gcc_snoc_pcie2_2lane_s_clk.clkr,
 	[GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
+	[GPLL0_OUT_AUX] = &gpll0_out_aux.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq9574_resets[] = {
@@ -4326,7 +4287,19 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gcc_ipq9574_desc);
+
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Keep the critical clocks always-On */
+	regmap_update_bits(regmap, 0x17030, BIT(0), BIT(0)); /* gcc_nssnoc_nsscc_clk */
+	regmap_update_bits(regmap, 0x17028, BIT(0), BIT(0)); /* gcc_nssnoc_snoc_clk */
+	regmap_update_bits(regmap, 0x1707C, BIT(0), BIT(0)); /* gcc_nssnoc_snoc_1_clk */
+
+	return qcom_cc_really_probe(pdev, &gcc_ipq9574_desc, regmap);
 }
 
 static struct platform_driver gcc_ipq9574_driver = {
-- 
2.34.1


