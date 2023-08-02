Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5076CF7D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjHBOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjHBOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:06:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1B926B6;
        Wed,  2 Aug 2023 07:06:49 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372DSFVe031179;
        Wed, 2 Aug 2023 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=W10gIVctT3ujq3zWp1jf7iOn/g/XYrymSzaaoA4c7TM=;
 b=H/Dzjk5Qiyf2wPU0y4Sqia2GTi19v9hOXRPBR5Unn5+IYyb794lH9lFQ33mJQgls9pBd
 v/DRCWYlyQpspxEhvKz5AA/enw+LSX4bIsjIYSR3sRF3vmC/O5HiO5KHj7kQa643w+0C
 VaBx3EXsSK6b8RG+6YSDh8l6Bkmj+brfERXUVRysfETuWjmGbTezd6d8VsHCOL9rbPNK
 iVuSf/ibPdamrzluHXRnkmAo87Nxrq5ZmoWX2Bg2EsTtF16BdYxs0zpGPoN4CDBdyNqf
 UP3dEsJSzhD9K9lLODJjIJHqfvTJSXEIe9sNyoDAfy/hVD19t0/wxKFYwtknNSeCTzdy xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7n93gfe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:06:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372E6ich019172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:06:44 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 07:06:37 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v5 02/11] clk: qcom: ipq5332: remove q6 bring up clocks
Date:   Wed, 2 Aug 2023 19:35:57 +0530
Message-ID: <20230802140606.2041889-3-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
References: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rBOw71TcOcuIhpdae5GWNDDchWUbdMvf
X-Proofpoint-ORIG-GUID: rBOw71TcOcuIhpdae5GWNDDchWUbdMvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multipd model Q6 firmware takes care of bringup clocks,
so remove them from gcc driver.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in v5:
	- Rebased on linux-next.

Changes in v4:
	- In V3 series this patch is [05/11]. Here it's moved to [02/11]
	  because to compile dt-bindings patches.

 drivers/clk/qcom/gcc-ipq5332.c | 380 ---------------------------------
 1 file changed, 380 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index ce6dc6e99a29..7153c2853b74 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -2266,150 +2266,6 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	},
 };
 
-static struct clk_branch gcc_q6_ahb_clk = {
-	.halt_reg = 0x25014,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x25014,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_wcss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_ahb_s_clk = {
-	.halt_reg = 0x25018,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x25018,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_ahb_s_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_wcss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_axim_clk = {
-	.halt_reg = 0x2500c,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x2500c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_axim_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_q6_axim_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6_axis_clk = {
-	.halt_reg = 0x25010,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x25010,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_axis_clk",
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
-static struct clk_branch gcc_q6_tsctr_1to2_clk = {
-	.halt_reg = 0x25020,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x25020,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_tsctr_1to2_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_tsctr_div2_clk_src.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_atbm_clk = {
-	.halt_reg = 0x2501c,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x2501c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_atbm_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_at_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_pclkdbg_clk = {
-	.halt_reg = 0x25024,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x25024,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_pclkdbg_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_dap_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_trig_clk = {
-	.halt_reg = 0x250a0,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x250a0,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_trig_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_dap_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_qdss_at_clk = {
 	.halt_reg = 0x2d038,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -2837,24 +2693,6 @@ static struct clk_branch gcc_sys_noc_at_clk = {
 	},
 };
 
-static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
-	.halt_reg = 0x2e030,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x2e030,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_sys_noc_wcss_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_wcss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_uniphy0_ahb_clk = {
 	.halt_reg = 0x16010,
 	.halt_check = BRANCH_HALT,
@@ -3070,204 +2908,6 @@ static struct clk_branch gcc_usb0_sleep_clk = {
 	},
 };
 
-static struct clk_branch gcc_wcss_axim_clk = {
-	.halt_reg = 0x2505c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x2505c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_axim_clk",
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
-static struct clk_branch gcc_wcss_axis_clk = {
-	.halt_reg = 0x25060,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x25060,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_axis_clk",
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
-static struct clk_branch gcc_wcss_dbg_ifc_apb_bdg_clk = {
-	.halt_reg = 0x25048,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x25048,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_apb_bdg_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_dap_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_apb_clk = {
-	.halt_reg = 0x25038,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x25038,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_apb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_dap_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_atb_bdg_clk = {
-	.halt_reg = 0x2504c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x2504c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_atb_bdg_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_at_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_atb_clk = {
-	.halt_reg = 0x2503c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x2503c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_atb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_at_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_nts_bdg_clk = {
-	.halt_reg = 0x25050,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x25050,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_nts_bdg_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_tsctr_div2_clk_src.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_nts_clk = {
-	.halt_reg = 0x25040,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x25040,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_nts_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_qdss_tsctr_div2_clk_src.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_ecahb_clk = {
-	.halt_reg = 0x25058,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x25058,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_ecahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_wcss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_mst_async_bdg_clk = {
-	.halt_reg = 0x2e0b0,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x2e0b0,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_mst_async_bdg_clk",
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
-static struct clk_branch gcc_wcss_slv_async_bdg_clk = {
-	.halt_reg = 0x2e0b4,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x2e0b4,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_slv_async_bdg_clk",
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
 static struct clk_branch gcc_xo_clk = {
 	.halt_reg = 0x34018,
 	.halt_check = BRANCH_HALT,
@@ -3500,15 +3140,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_PCNOC_BFDCD_CLK_SRC] = &gcc_pcnoc_bfdcd_clk_src.clkr,
 	[GCC_PCNOC_LPASS_CLK] = &gcc_pcnoc_lpass_clk.clkr,
 	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
-	[GCC_Q6_AHB_CLK] = &gcc_q6_ahb_clk.clkr,
-	[GCC_Q6_AHB_S_CLK] = &gcc_q6_ahb_s_clk.clkr,
-	[GCC_Q6_AXIM_CLK] = &gcc_q6_axim_clk.clkr,
 	[GCC_Q6_AXIM_CLK_SRC] = &gcc_q6_axim_clk_src.clkr,
-	[GCC_Q6_AXIS_CLK] = &gcc_q6_axis_clk.clkr,
-	[GCC_Q6_TSCTR_1TO2_CLK] = &gcc_q6_tsctr_1to2_clk.clkr,
-	[GCC_Q6SS_ATBM_CLK] = &gcc_q6ss_atbm_clk.clkr,
-	[GCC_Q6SS_PCLKDBG_CLK] = &gcc_q6ss_pclkdbg_clk.clkr,
-	[GCC_Q6SS_TRIG_CLK] = &gcc_q6ss_trig_clk.clkr,
 	[GCC_QDSS_AT_CLK] = &gcc_qdss_at_clk.clkr,
 	[GCC_QDSS_AT_CLK_SRC] = &gcc_qdss_at_clk_src.clkr,
 	[GCC_QDSS_CFG_AHB_CLK] = &gcc_qdss_cfg_ahb_clk.clkr,
@@ -3537,7 +3169,6 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
 	[GCC_SNOC_USB_CLK] = &gcc_snoc_usb_clk.clkr,
 	[GCC_SYS_NOC_AT_CLK] = &gcc_sys_noc_at_clk.clkr,
-	[GCC_SYS_NOC_WCSS_AHB_CLK] = &gcc_sys_noc_wcss_ahb_clk.clkr,
 	[GCC_SYSTEM_NOC_BFDCD_CLK_SRC] = &gcc_system_noc_bfdcd_clk_src.clkr,
 	[GCC_UNIPHY0_AHB_CLK] = &gcc_uniphy0_ahb_clk.clkr,
 	[GCC_UNIPHY0_SYS_CLK] = &gcc_uniphy0_sys_clk.clkr,
@@ -3558,17 +3189,6 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_USB0_PIPE_CLK] = &gcc_usb0_pipe_clk.clkr,
 	[GCC_USB0_SLEEP_CLK] = &gcc_usb0_sleep_clk.clkr,
 	[GCC_WCSS_AHB_CLK_SRC] = &gcc_wcss_ahb_clk_src.clkr,
-	[GCC_WCSS_AXIM_CLK] = &gcc_wcss_axim_clk.clkr,
-	[GCC_WCSS_AXIS_CLK] = &gcc_wcss_axis_clk.clkr,
-	[GCC_WCSS_DBG_IFC_APB_BDG_CLK] = &gcc_wcss_dbg_ifc_apb_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_APB_CLK] = &gcc_wcss_dbg_ifc_apb_clk.clkr,
-	[GCC_WCSS_DBG_IFC_ATB_BDG_CLK] = &gcc_wcss_dbg_ifc_atb_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_ATB_CLK] = &gcc_wcss_dbg_ifc_atb_clk.clkr,
-	[GCC_WCSS_DBG_IFC_NTS_BDG_CLK] = &gcc_wcss_dbg_ifc_nts_bdg_clk.clkr,
-	[GCC_WCSS_DBG_IFC_NTS_CLK] = &gcc_wcss_dbg_ifc_nts_clk.clkr,
-	[GCC_WCSS_ECAHB_CLK] = &gcc_wcss_ecahb_clk.clkr,
-	[GCC_WCSS_MST_ASYNC_BDG_CLK] = &gcc_wcss_mst_async_bdg_clk.clkr,
-	[GCC_WCSS_SLV_ASYNC_BDG_CLK] = &gcc_wcss_slv_async_bdg_clk.clkr,
 	[GCC_XO_CLK] = &gcc_xo_clk.clkr,
 	[GCC_XO_CLK_SRC] = &gcc_xo_clk_src.clkr,
 	[GCC_XO_DIV4_CLK] = &gcc_xo_div4_clk.clkr,
-- 
2.34.1

