Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC87DB664
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJ3Jru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjJ3Jrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:47:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB6B6;
        Mon, 30 Oct 2023 02:47:44 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U8OTEK000830;
        Mon, 30 Oct 2023 09:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=C7DYLGiKV5lE/9t/qTidkZ8vlSjIyxJ0rFmwZMM0b78=;
 b=W9yejQX9h7a2VyLaB9ONcTVvR8ntckQN/qgieTiU4t63Tt7ZTNC0ImNcPnTFY9BzZfqF
 wEVYWGne21qa+7/UwrcKreqPsbUMc16Dp7TcScfBY47PBv7JPjnul4WUaaCMyMBrl9a7
 I5Z2Jo2vOmJRoscwiKa239F1jHliXPmecIozjpz2GXWaR8LLgrPZbzqG3oXGhOjn6Vy3
 2LBitj4QuQw7dFK92yb7FAnZFOc2ruNYnEZAOidCBbx99LHb/m99GCIkxO39ElqL/5q0
 UubG9FrXtlbdjLIYgxRB1/Nb77PbDrFUBhhEgXykwq5Gqdlp5+YMc+XvHxkYibscllNK MA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jr9xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:47:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U9lZB2030817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:47:35 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 02:47:29 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Mon, 30 Oct 2023 15:17:16 +0530
Subject: [PATCH 1/8] clk: qcom: ipq5332: drop the few nssnoc clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231030-ipq5332-nsscc-v1-1-6162a2c65f0a@quicinc.com>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
In-Reply-To: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698659244; l=3486;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=oVXi/0aUJi/5j62/P9dVUg1qaWfJBSnzkOdAng8wz00=;
 b=YV3QNxwuR6BcsLyU2vlvKyR9LiL9ZPWLst2yoXkjsSWUgWNV2t+YABaWJROo6/TTeAp3D74K5
 //VCcxGISVgDekMQFbfXAjnuvlNezjoNoGocHENvKljAaRKvZH5IDlS
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rtvgygZ8iZFI4OowwggOsRtvolOJGNMa
X-Proofpoint-ORIG-GUID: rtvgygZ8iZFI4OowwggOsRtvolOJGNMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_08,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=708
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
enabled by default and it's RCG is properly configured by bootloader.

Some of the NSS clocks needs these clocks to be enabled. To avoid
these clocks being disabled by clock framework, drop these entries.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 57 ------------------------------------------
 1 file changed, 57 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..235849876a9a 100644
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

-- 
2.34.1

