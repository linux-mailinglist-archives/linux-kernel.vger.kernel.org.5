Return-Path: <linux-kernel+bounces-32365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094A835AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B6A28511E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06BFC16;
	Mon, 22 Jan 2024 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FKw2RSY5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD827F4FB;
	Mon, 22 Jan 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903052; cv=none; b=IwpPtE9mSDV8hcfe0tOtnZdyf1GOFP24BE4Htv832HXxVHJDLq3xypgyxIdNol5Eh4SfpqBbq6VKNNcFi8QbILl2rZOZdAk2ibh6QcRLOuSxW4cSNziovD/xtIVEinpHXOXjb16bzouFi0B3hY4QshWg7GoDBbgHDqtucj2XuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903052; c=relaxed/simple;
	bh=TeJNUOHqEVQ9ZK3Jrj8vY3kVCraoKwelk2CGbMC4Boo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NoI/IBP0DJU3unYVMyH8NQNwQsr2hqLJPPE4usnSsW14dM1v/lllnDkBsWL9LGO9Fr4JEGXbrRtkmS+uAYnE2autANMazpsB4ajvbQvLxXulYORnxIsyW4Jh0dtx0kd5va2nTAWQoqlfiNzWfkZhpObYNUw9UNv5wwZ9KC8heEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FKw2RSY5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M4nY2N001782;
	Mon, 22 Jan 2024 05:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=2cKw0rXTvX5TcnpJkF6J6clUX6uI+9JYIr/Vx+0x6yo
	=; b=FKw2RSY5DHEDVU/Zbk/DAbrbz0R5aREIsQii6qh/LSa5UbqeYNJthI7lPIy
	9z8GMwe09Bs9VyJIow+m1CuKtv2cp1UCdFR+Hrvy3ornRWi4CI16zoX5SCIPAIR7
	Fg/th8H7D0p+xq2ou5uc7Cec7NbQHLLjfcwVu09IjMI4ciMBB6izl4MhRvbZZgcc
	vbEotZepPzEHu0wsPmBEtc2U4ynRQyfDyM0aar220mCxMSVFTUBzrxQSBwoEhM3W
	PZ4wFBQkbedC0b8TmEc5KAX2e2rBZt/3oqqasQsVokg8fzSg0XjEMWA35eS8ld5b
	6t/zJV5gQdqleOWfwwWSH+SSndA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6jbu169-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5vJf1017177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:19 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:14 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 22 Jan 2024 11:26:58 +0530
Subject: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=4381;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=TeJNUOHqEVQ9ZK3Jrj8vY3kVCraoKwelk2CGbMC4Boo=;
 b=r/lWofF5onWe4D0BYWhCtmhsk7EIBD0bA1z7etxxsRPJcaBhaHljBc688q8Q2hRL5B9OA6XnF
 DjUPhQ1goDoDkOKt7bxmw1Oho6zI94GJ+X+xJ8l5pFADkoOe0b/SxPh
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cpn6644Kq9ju6nctziib6p1k-yKhUHK4
X-Proofpoint-ORIG-GUID: Cpn6644Kq9ju6nctziib6p1k-yKhUHK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=852 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220041

gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
enabled by default and it's RCG is properly configured by bootloader.

Some of the NSS clocks needs these clocks to be enabled. To avoid
these clocks being disabled by clock framework, drop these entries
from the clock table and enable it in the driver probe itself.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 70 ++++++++----------------------------------
 1 file changed, 12 insertions(+), 58 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 66d5399798fe..38a570b68813 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -1672,24 +1672,6 @@ static struct clk_branch gcc_nssnoc_atb_clk = {
 	},
 };
 
-static struct clk_branch gcc_nssnoc_nsscc_clk = {
-	.halt_reg = 0x17030,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x17030,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_nssnoc_nsscc_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_pcnoc_bfdcd_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_nssnoc_qosgen_ref_clk = {
 	.halt_reg = 0x1701c,
 	.halt_check = BRANCH_HALT,
@@ -2585,42 +2567,6 @@ static struct clk_branch gcc_snoc_lpass_cfg_clk = {
 	},
 };
 
-static struct clk_branch gcc_snoc_nssnoc_1_clk = {
-	.halt_reg = 0x17090,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x17090,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_snoc_nssnoc_1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_system_noc_bfdcd_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_snoc_nssnoc_clk = {
-	.halt_reg = 0x17084,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x17084,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_snoc_nssnoc_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_system_noc_bfdcd_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_snoc_pcie3_1lane_1_m_clk = {
 	.halt_reg = 0x2e050,
 	.halt_check = BRANCH_HALT,
@@ -3330,7 +3276,6 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_NSSCC_CLK] = &gcc_nsscc_clk.clkr,
 	[GCC_NSSCFG_CLK] = &gcc_nsscfg_clk.clkr,
 	[GCC_NSSNOC_ATB_CLK] = &gcc_nssnoc_atb_clk.clkr,
-	[GCC_NSSNOC_NSSCC_CLK] = &gcc_nssnoc_nsscc_clk.clkr,
 	[GCC_NSSNOC_QOSGEN_REF_CLK] = &gcc_nssnoc_qosgen_ref_clk.clkr,
 	[GCC_NSSNOC_SNOC_1_CLK] = &gcc_nssnoc_snoc_1_clk.clkr,
 	[GCC_NSSNOC_SNOC_CLK] = &gcc_nssnoc_snoc_clk.clkr,
@@ -3398,8 +3343,6 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_SDCC1_APPS_CLK_SRC] = &gcc_sdcc1_apps_clk_src.clkr,
 	[GCC_SLEEP_CLK_SRC] = &gcc_sleep_clk_src.clkr,
 	[GCC_SNOC_LPASS_CFG_CLK] = &gcc_snoc_lpass_cfg_clk.clkr,
-	[GCC_SNOC_NSSNOC_1_CLK] = &gcc_snoc_nssnoc_1_clk.clkr,
-	[GCC_SNOC_NSSNOC_CLK] = &gcc_snoc_nssnoc_clk.clkr,
 	[GCC_SNOC_PCIE3_1LANE_1_M_CLK] = &gcc_snoc_pcie3_1lane_1_m_clk.clkr,
 	[GCC_SNOC_PCIE3_1LANE_1_S_CLK] = &gcc_snoc_pcie3_1lane_1_s_clk.clkr,
 	[GCC_SNOC_PCIE3_1LANE_M_CLK] = &gcc_snoc_pcie3_1lane_m_clk.clkr,
@@ -3660,7 +3603,18 @@ static const struct qcom_cc_desc gcc_ipq5332_desc = {
 
 static int gcc_ipq5332_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gcc_ipq5332_desc);
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gcc_ipq5332_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Keep the critical clocks always-On */
+	regmap_update_bits(regmap, 0x17030, BIT(0), BIT(0)); /* gcc_nssnoc_nsscc_clk */
+	regmap_update_bits(regmap, 0x17084, BIT(0), BIT(0)); /* gcc_snoc_nssnoc_clk */
+	regmap_update_bits(regmap, 0x17090, BIT(0), BIT(0)); /* gcc_snoc_nssnoc_1_clk */
+
+	return qcom_cc_really_probe(pdev, &gcc_ipq5332_desc, regmap);
 }
 
 static const struct of_device_id gcc_ipq5332_match_table[] = {

-- 
2.34.1


