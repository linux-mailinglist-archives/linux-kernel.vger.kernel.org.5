Return-Path: <linux-kernel+bounces-63020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBFF852962
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7021C23132
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC6171BF;
	Tue, 13 Feb 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MOKxO+fk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C01426A;
	Tue, 13 Feb 2024 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806878; cv=none; b=bCUIq6mzQDqOvueSfZc89e+cyjhLipuODZ1JGxvr2VPGX51PlwtDNa39dgavMaQ4SNxr43eNPocRhutONfGW0Y/XwRcJS0VUDxfQG7qd2j+p56wv6I5gwbMumiyXpa6w9WP75McTaFkFiS0mkuOJjIKt4uHWMz/xOkkXPDfk7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806878; c=relaxed/simple;
	bh=CLzIozoMqKyU0DRj84tcGE1rca1rs3iZhCK34uQKCTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=it2ysTu9Ih0t2xP6XUBahaS/i49wF7yfK/lCtpYszaNuT7ZsLllCb/6PRAAobWBhLjEo1PQ8uaQbQaw96CwZSzo+6dpIeAx1kM3inzc1MSmFbz9D6AfW+vy5WAvuo5RDQiW2r+xe56TOaJKezbLADf4nB95UtTord61DwWVEkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MOKxO+fk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D68AWv019517;
	Tue, 13 Feb 2024 06:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=I/s
	Kdqsdfjt0XvKL2lIL1k30/MAC02Xj8ecBcRIWFrg=; b=MOKxO+fk7VM0iYc9x5I
	7upv8g/UcE74rTfeSA0v0y+O77BnkUtQktxNT2NL/zYXISj9wgNGQb/ZrXqwW2f8
	JieAZmioL3+tnmKQ9MwyQ1BG+7Z7sTDWIK81fGdvHAH+eVgGFM1ODxojXMFzDDXa
	6d7olu2LS0CFFm78BAF1bPB3P7/Rz1Pl4NaKmx8aQc/cbQ2NyI8wUPIw1PEe56kz
	UpCNkhhHZ843SQ0pI7eIQHrLtbDLDEoLJpyP1xtAJrpG/x0jDi69+RNxpOnMtnJx
	YRqbz5+aJRtkn42U82wLxokO+ASnOa3vgzLfBZhugZSGTjvCqWcG52ps7eKhsPkO
	qjA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7yh30b8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:47:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D6lcDM002309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:47:38 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 22:47:34 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Tue, 13 Feb 2024 12:17:24 +0530
Subject: [PATCH v2] clk: qcom: gcc-sm8150: De-register
 gcc_cpuss_ahb_clk_src
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240213-gcc-ao-support-v2-1-fd2127e8d8f4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHsQy2UC/3XMQQ6CMBCF4auQWTumLa0SV97DsCjTArOwxRaIh
 nB3K3uX/0vet0H2iX2GW7VB8itnjqGEOlVAow2DR3alQQmlhVQ1DkRoI+ZlmmKa0XW2M0Z6q3s
 B5TQl3/P7AB9t6ZHzHNPn8Ff5W/9Sq0SBF5KNM7UUzVXfXwsTBzpTfEK77/sXo7MuDK4AAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AZ7u9ZVSENaFfAoiY6w2Jit7sAIru79Z
X-Proofpoint-GUID: AZ7u9ZVSENaFfAoiY6w2Jit7sAIru79Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=964 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130051

De-register the gcc_cpuss_ahb_clk_src and its branch clocks
as there is no rate setting happening on them.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Remove gcc_cpuss_ahb_clk_src and its branch clocks.
---
Changes in v2:
- As per Konrad's comments, de-register the gcc_cpuss_ahb_clk_src
  instead of adding AO support as no rate-setting is happening on it.
- Link to v1: https://lore.kernel.org/r/20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com
---
 drivers/clk/qcom/gcc-sm8150.c | 61 -------------------------------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 05d115c52dfe..f06f0548fe7d 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -207,28 +207,6 @@ static const struct clk_parent_data gcc_parents_7[] = {
 	{ .hw = &gpll0_out_even.clkr.hw },
 };
 
-static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
-	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
-	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
-	.cmd_rcgr = 0x48014,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_data = gcc_parents_0,
-		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_emac_ptp_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
@@ -1321,24 +1299,6 @@ static struct clk_branch gcc_cfg_noc_usb3_sec_axi_clk = {
 	},
 };
 
-static struct clk_branch gcc_cpuss_ahb_clk = {
-	.halt_reg = 0x48000,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x52004,
-		.enable_mask = BIT(21),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]){
-				      &gcc_cpuss_ahb_clk_src.clkr.hw },
-			.num_parents = 1,
-			 /* required for cpuss */
-			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_cpuss_dvm_bus_clk = {
 	.halt_reg = 0x48190,
 	.halt_check = BRANCH_HALT,
@@ -2645,24 +2605,6 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
 	},
 };
 
-static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
-	.halt_reg = 0x4819c,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x52004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_sys_noc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]){
-				      &gcc_cpuss_ahb_clk_src.clkr.hw },
-			.num_parents = 1,
-			/* required for cpuss */
-			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_tsif_ahb_clk = {
 	.halt_reg = 0x36004,
 	.halt_check = BRANCH_HALT,
@@ -3510,8 +3452,6 @@ static struct clk_regmap *gcc_sm8150_clocks[] = {
 	[GCC_CAMERA_XO_CLK] = &gcc_camera_xo_clk.clkr,
 	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
 	[GCC_CFG_NOC_USB3_SEC_AXI_CLK] = &gcc_cfg_noc_usb3_sec_axi_clk.clkr,
-	[GCC_CPUSS_AHB_CLK] = &gcc_cpuss_ahb_clk.clkr,
-	[GCC_CPUSS_AHB_CLK_SRC] = &gcc_cpuss_ahb_clk_src.clkr,
 	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
 	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
 	[GCC_CPUSS_RBCPR_CLK] = &gcc_cpuss_rbcpr_clk.clkr,
@@ -3629,7 +3569,6 @@ static struct clk_regmap *gcc_sm8150_clocks[] = {
 	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
 	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
 	[GCC_SDCC4_APPS_CLK_SRC] = &gcc_sdcc4_apps_clk_src.clkr,
-	[GCC_SYS_NOC_CPUSS_AHB_CLK] = &gcc_sys_noc_cpuss_ahb_clk.clkr,
 	[GCC_TSIF_AHB_CLK] = &gcc_tsif_ahb_clk.clkr,
 	[GCC_TSIF_INACTIVITY_TIMERS_CLK] = &gcc_tsif_inactivity_timers_clk.clkr,
 	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,

---
base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
change-id: 20240123-gcc-ao-support-dbab551ea4f0

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


