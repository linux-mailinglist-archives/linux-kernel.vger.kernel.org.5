Return-Path: <linux-kernel+bounces-32364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B1835AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043FD1C2131A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC3F512;
	Mon, 22 Jan 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mv/jNOuG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A5DF70;
	Mon, 22 Jan 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903050; cv=none; b=e/Ex3Duek2c8Wj9jypRjboHPJQDtZJeFuukVSEEyxQqJdND4wEJ2niobA1m4PaWjH2WqWdgeSglyc1cMwaETNZxi6iZbrieOr4Hf2VS8H+SJtTx0xyMSnBIwm85m8wV/84lEnHQ2qttZXvFf22B715+vPG/XNc0GuIDWZ/6RmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903050; c=relaxed/simple;
	bh=K2/TZ1jR94Do3DQzYdLE5mKWlGTml2gLs76pSKeaNdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WtqXxK/N8GcwDkWW9hi2LovdDwoMlHAa55idm8E51Kd1vK+WKLdj8c7Q0+7i5lgpj/Zndx+0T8tmiIiccbHO9R87c+bsm+RA0guDMr58A/fWnTlzjK6VU2u8o3RXI8I7OvX6u8LTUsW/YGMCOwxJFd3FkgbFMwb3sevwgZoO+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mv/jNOuG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5EMsK017304;
	Mon, 22 Jan 2024 05:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=5LccCVevU5nbbXP+2AfHZW7uW3VJb3lccoM0/87iaYU
	=; b=Mv/jNOuGwyjNm/9e/+0HBlzvkMlX3jZaa5tDwz2rtxME9r5WbxKJJiKCEyi
	g51dhtcpvQRM3c3c1rPCXoq1vBPMld4HuwTVBZJYESXnAUpmC6cQYsDNi97nF18y
	hZlYSouJRbUu/i1cMBhrcI/ErgZG2e4fwe/mem6l+9cehtsbE+ZqkrhpebNkE0qd
	OyNq1KkBAJuH2wf3izMqHCY9dXiGG43d1X8JT2DuGfYNv3NGlsJ8QIcNUPAcTH+/
	cuY28Gun1G/7Gz/aHSy+m0/FfYwq89so9do7B6hTujRnpk4mRyGw4x7JkjEtoO0G
	tL9L+KvJpTXjMYUeQbIRQbI9N5Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr3vnb6t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5vE9I016701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:14 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:09 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 22 Jan 2024 11:26:57 +0530
Subject: [PATCH v4 1/8] clk: qcom: ipq5332: add const qualifier to the
 clk_init_data structure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240122-ipq5332-nsscc-v4-1-19fa30019770@quicinc.com>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
In-Reply-To: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=7738;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=K2/TZ1jR94Do3DQzYdLE5mKWlGTml2gLs76pSKeaNdc=;
 b=j4FRpYRTqIQRWIvKGClv2bg2djlShNPVOqcb3yVXNapzDCDf+b6s1qCwWACtUElVk0xKuyZQD
 jLerTkCVERHDpY3NmCX0pMMdginWiuILBky0UDhA7z/twp1RSsPvwDV
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ptwVnEECxPReTakK_isuKj_1ETOl9U7l
X-Proofpoint-ORIG-GUID: ptwVnEECxPReTakK_isuKj_1ETOl9U7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=945 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220041

There are few places where clk_init_data structure doesn't carry the const
qualifier. Let's add the same.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..66d5399798fe 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -65,7 +65,7 @@ static struct clk_alpha_pll gpll0_main = {
 static struct clk_fixed_factor gpll0_div2 = {
 	.mult = 1,
 	.div = 2,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gpll0_div2",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gpll0_main.clkr.hw },
@@ -78,7 +78,7 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 	.offset = 0x20000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll0",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gpll0_main.clkr.hw },
@@ -106,7 +106,7 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll2_main",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gpll2_main.clkr.hw },
@@ -145,7 +145,7 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 	.offset = 0x22000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll4",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gpll4_main.clkr.hw },
@@ -572,7 +572,7 @@ static struct clk_branch gcc_pcie3x1_0_rchg_clk = {
 	.clkr = {
 		.enable_reg = 0x2907c,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3x1_0_rchg_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 					&gcc_pcie3x1_0_rchg_clk_src.clkr.hw },
@@ -615,7 +615,7 @@ static struct clk_branch gcc_pcie3x1_1_rchg_clk = {
 	.clkr = {
 		.enable_reg = 0x2a078,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3x1_1_rchg_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 					&gcc_pcie3x1_1_rchg_clk_src.clkr.hw },
@@ -678,7 +678,7 @@ static struct clk_branch gcc_pcie3x2_rchg_clk = {
 	.clkr = {
 		.enable_reg = 0x28078,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3x2_rchg_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 					&gcc_pcie3x2_rchg_clk_src.clkr.hw },
@@ -711,7 +711,7 @@ static struct clk_rcg2 gcc_pcie_aux_clk_src = {
 static struct clk_regmap_phy_mux gcc_pcie3x2_pipe_clk_src = {
 	.reg = 0x28064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3x2_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_PCIE_2LANE_PHY_PIPE_CLK,
@@ -725,7 +725,7 @@ static struct clk_regmap_phy_mux gcc_pcie3x2_pipe_clk_src = {
 static struct clk_regmap_phy_mux gcc_pcie3x1_0_pipe_clk_src = {
 	.reg = 0x29064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3x1_0_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
@@ -739,7 +739,7 @@ static struct clk_regmap_phy_mux gcc_pcie3x1_0_pipe_clk_src = {
 static struct clk_regmap_phy_mux gcc_pcie3x1_1_pipe_clk_src = {
 	.reg = 0x2a064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3x1_1_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_PCIE_2LANE_PHY_PIPE_CLK_X1,
@@ -826,7 +826,7 @@ static struct clk_rcg2 gcc_qdss_tsctr_clk_src = {
 static struct clk_fixed_factor gcc_qdss_tsctr_div2_clk_src = {
 	.mult = 1,
 	.div = 2,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_qdss_tsctr_div2_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_qdss_tsctr_clk_src.clkr.hw },
@@ -839,7 +839,7 @@ static struct clk_fixed_factor gcc_qdss_tsctr_div2_clk_src = {
 static struct clk_fixed_factor gcc_qdss_tsctr_div3_clk_src = {
 	.mult = 1,
 	.div = 3,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_qdss_tsctr_div3_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_qdss_tsctr_clk_src.clkr.hw },
@@ -851,7 +851,7 @@ static struct clk_fixed_factor gcc_qdss_tsctr_div3_clk_src = {
 static struct clk_fixed_factor gcc_qdss_tsctr_div4_clk_src = {
 	.mult = 1,
 	.div = 4,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_qdss_tsctr_div4_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_qdss_tsctr_clk_src.clkr.hw },
@@ -863,7 +863,7 @@ static struct clk_fixed_factor gcc_qdss_tsctr_div4_clk_src = {
 static struct clk_fixed_factor gcc_qdss_tsctr_div8_clk_src = {
 	.mult = 1,
 	.div = 8,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_qdss_tsctr_div8_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_qdss_tsctr_clk_src.clkr.hw },
@@ -875,7 +875,7 @@ static struct clk_fixed_factor gcc_qdss_tsctr_div8_clk_src = {
 static struct clk_fixed_factor gcc_qdss_tsctr_div16_clk_src = {
 	.mult = 1,
 	.div = 16,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_qdss_tsctr_div16_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_qdss_tsctr_clk_src.clkr.hw },
@@ -976,7 +976,7 @@ static struct clk_rcg2 gcc_system_noc_bfdcd_clk_src = {
 static struct clk_fixed_factor gcc_system_noc_bfdcd_div2_clk_src = {
 	.mult = 1,
 	.div = 2,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_system_noc_bfdcd_div2_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_system_noc_bfdcd_clk_src.clkr.hw },
@@ -1069,7 +1069,7 @@ static struct clk_rcg2 gcc_usb0_mock_utmi_clk_src = {
 static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
 	.reg = 0x2c074,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
@@ -1111,7 +1111,7 @@ static struct clk_rcg2 gcc_xo_clk_src = {
 static struct clk_fixed_factor gcc_xo_div4_clk_src = {
 	.mult = 1,
 	.div = 4,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_xo_div4_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_xo_clk_src.clkr.hw },
@@ -2431,7 +2431,7 @@ static struct clk_branch gcc_qdss_etr_usb_clk = {
 static struct clk_fixed_factor gcc_eud_at_div_clk_src = {
 	.mult = 1,
 	.div = 6,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_eud_at_div_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 				&gcc_qdss_at_clk_src.clkr.hw },

-- 
2.34.1


