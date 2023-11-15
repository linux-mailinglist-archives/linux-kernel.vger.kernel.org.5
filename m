Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021777E7FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjKJSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjKJSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:00:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326732BE17;
        Fri, 10 Nov 2023 01:20:30 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7fgOa031331;
        Fri, 10 Nov 2023 09:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3oXcR2fgkQUnVZRUf8EM5mbxCM+GrpWo02mNYAvfJSQ=;
 b=LI4afS+6vFY5aZVf788+S0ytveto+0qWiYQJF0Df0CFXsU7c55IHagoi2yEzxBKbyVS8
 oDgppMgcEny/uLKmC90vg6J19mvnGWO3DY3YXPPBWTHSPZSjOKRBzfTHz1B9KspP0Dxb
 Co6hDYrEevt3c6EY2/nCQJPPdDgMlJt36rOI8WYwnBC8fTaGv42ClymvknQPar55K66r
 kvEQtqnuw1VpSqTEd8vCXcdb+xavVI7vwup8BCGFeHnVDfShTKCkWQZTjgE4d7AW2p3N
 Hz8tkbottASV9g5R/nQWJG/sfmaJ+bL4PICE8Hap6jzvSJ87yzobdPswow4QbAaWLA6s Eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9f3k0e7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:20:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA9KPdr032202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:20:25 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 01:20:17 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <quic_mmanikan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v6 03/11] clk: qcom: ipq9574: remove q6 bring up clocks
Date:   Fri, 10 Nov 2023 14:49:31 +0530
Message-ID: <20231110091939.3025413-4-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110091939.3025413-1-quic_mmanikan@quicinc.com>
References: <20231110091939.3025413-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4tCrXYpbuvVTGXqYZjzsIbiRK2SkxGsf
X-Proofpoint-GUID: 4tCrXYpbuvVTGXqYZjzsIbiRK2SkxGsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=998
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multipd model Q6 firmware takes care of bringup clocks,
so remove them from gcc driver.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in v6:
	- Rebased on linux-next.

Changes in v5:
	- Rebased on linux-next.

Changes in v4:
	- In V3 series this patch is [04/11]. Here it's moved to [03/11]
	  because to compile dt-bindings patches.

Changes in v3:
	- Rebased on linux-next.

 drivers/clk/qcom/gcc-ipq9574.c | 326 ---------------------------------
 1 file changed, 326 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index e8190108e1ae..e6d8ab5fbf29 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -2567,24 +2567,6 @@ static struct clk_rcg2 system_noc_bfdcd_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_q6ss_boot_clk = {
-	.halt_reg = 0x25080,
-	.halt_check = BRANCH_HALT_SKIP,
-	.clkr = {
-		.enable_reg = 0x25080,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_boot_clk",
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
 static struct clk_branch gcc_nssnoc_snoc_clk = {
 	.halt_reg = 0x17028,
 	.clkr = {
@@ -2655,91 +2637,6 @@ static struct clk_rcg2 wcss_ahb_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_q6_ahb_clk = {
-	.halt_reg = 0x25014,
-	.clkr = {
-		.enable_reg = 0x25014,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
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
-	.clkr = {
-		.enable_reg = 0x25018,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_ahb_s_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
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
-	.clkr = {
-		.enable_reg = 0x25058,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_ecahb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_acmt_clk = {
-	.halt_reg = 0x2505c,
-	.clkr = {
-		.enable_reg = 0x2505c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_acmt_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
-	.halt_reg = 0x2e030,
-	.clkr = {
-		.enable_reg = 0x2e030,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_sys_noc_wcss_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static const struct freq_tbl ftbl_wcss_axi_m_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
 	F(133333333, P_GPLL0, 6, 0, 0),
@@ -2760,23 +2657,6 @@ static struct clk_rcg2 wcss_axi_m_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_anoc_wcss_axi_m_clk = {
-	.halt_reg = 0x2e0a8,
-	.clkr = {
-		.enable_reg = 0x2e0a8,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_anoc_wcss_axi_m_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&wcss_axi_m_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static const struct freq_tbl ftbl_qdss_at_clk_src[] = {
 	F(240000000, P_GPLL4, 5, 0, 0),
 	{ }
@@ -2795,40 +2675,6 @@ static struct clk_rcg2 qdss_at_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_q6ss_atbm_clk = {
-	.halt_reg = 0x2501c,
-	.clkr = {
-		.enable_reg = 0x2501c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_atbm_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_at_clk_src.clkr.hw
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
-	.clkr = {
-		.enable_reg = 0x2503c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_atb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_at_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_nssnoc_atb_clk = {
 	.halt_reg = 0x17014,
 	.clkr = {
@@ -3065,40 +2911,6 @@ static struct clk_fixed_factor qdss_tsctr_div2_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_q6_tsctr_1to2_clk = {
-	.halt_reg = 0x25020,
-	.clkr = {
-		.enable_reg = 0x25020,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_tsctr_1to2_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_tsctr_div2_clk_src.hw
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
-	.clkr = {
-		.enable_reg = 0x25040,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_nts_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_tsctr_div2_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_qdss_tsctr_div2_clk = {
 	.halt_reg = 0x2d044,
 	.clkr = {
@@ -3273,74 +3085,6 @@ static struct clk_branch gcc_qdss_tsctr_div16_clk = {
 	},
 };
 
-static struct clk_branch gcc_q6ss_pclkdbg_clk = {
-	.halt_reg = 0x25024,
-	.clkr = {
-		.enable_reg = 0x25024,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_pclkdbg_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_q6ss_trig_clk = {
-	.halt_reg = 0x25068,
-	.clkr = {
-		.enable_reg = 0x25068,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6ss_trig_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
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
-	.clkr = {
-		.enable_reg = 0x25038,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_apb_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_dbg_ifc_dapbus_clk = {
-	.halt_reg = 0x25044,
-	.clkr = {
-		.enable_reg = 0x25044,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_dbg_ifc_dapbus_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&qdss_dap_sync_clk_src.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_qdss_dap_clk = {
 	.halt_reg = 0x2d058,
 	.clkr = {
@@ -3462,58 +3206,6 @@ static struct clk_rcg2 q6_axi_clk_src = {
 	},
 };
 
-static struct clk_branch gcc_q6_axim_clk = {
-	.halt_reg = 0x2500c,
-	.clkr = {
-		.enable_reg = 0x2500c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_q6_axim_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&q6_axi_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_wcss_q6_tbu_clk = {
-	.halt_reg = 0x12050,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0xb00c,
-		.enable_mask = BIT(6),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_wcss_q6_tbu_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&q6_axi_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_mem_noc_q6_axi_clk = {
-	.halt_reg = 0x19010,
-	.clkr = {
-		.enable_reg = 0x19010,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_mem_noc_q6_axi_clk",
-			.parent_hws = (const struct clk_hw *[]) {
-				&q6_axi_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static const struct freq_tbl ftbl_q6_axim2_clk_src[] = {
 	F(342857143, P_GPLL4, 3.5, 0, 0),
 	{ }
@@ -4063,16 +3755,8 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_NSSNOC_SNOC_1_CLK] = &gcc_nssnoc_snoc_1_clk.clkr,
 	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
 	[WCSS_AHB_CLK_SRC] = &wcss_ahb_clk_src.clkr,
-	[GCC_Q6_AHB_CLK] = &gcc_q6_ahb_clk.clkr,
-	[GCC_Q6_AHB_S_CLK] = &gcc_q6_ahb_s_clk.clkr,
-	[GCC_WCSS_ECAHB_CLK] = &gcc_wcss_ecahb_clk.clkr,
-	[GCC_WCSS_ACMT_CLK] = &gcc_wcss_acmt_clk.clkr,
-	[GCC_SYS_NOC_WCSS_AHB_CLK] = &gcc_sys_noc_wcss_ahb_clk.clkr,
 	[WCSS_AXI_M_CLK_SRC] = &wcss_axi_m_clk_src.clkr,
-	[GCC_ANOC_WCSS_AXI_M_CLK] = &gcc_anoc_wcss_axi_m_clk.clkr,
 	[QDSS_AT_CLK_SRC] = &qdss_at_clk_src.clkr,
-	[GCC_Q6SS_ATBM_CLK] = &gcc_q6ss_atbm_clk.clkr,
-	[GCC_WCSS_DBG_IFC_ATB_CLK] = &gcc_wcss_dbg_ifc_atb_clk.clkr,
 	[GCC_NSSNOC_ATB_CLK] = &gcc_nssnoc_atb_clk.clkr,
 	[GCC_QDSS_AT_CLK] = &gcc_qdss_at_clk.clkr,
 	[GCC_SYS_NOC_AT_CLK] = &gcc_sys_noc_at_clk.clkr,
@@ -4085,27 +3769,18 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[QDSS_TRACECLKIN_CLK_SRC] = &qdss_traceclkin_clk_src.clkr,
 	[GCC_QDSS_TRACECLKIN_CLK] = &gcc_qdss_traceclkin_clk.clkr,
 	[QDSS_TSCTR_CLK_SRC] = &qdss_tsctr_clk_src.clkr,
-	[GCC_Q6_TSCTR_1TO2_CLK] = &gcc_q6_tsctr_1to2_clk.clkr,
-	[GCC_WCSS_DBG_IFC_NTS_CLK] = &gcc_wcss_dbg_ifc_nts_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV2_CLK] = &gcc_qdss_tsctr_div2_clk.clkr,
 	[GCC_QDSS_TS_CLK] = &gcc_qdss_ts_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV4_CLK] = &gcc_qdss_tsctr_div4_clk.clkr,
 	[GCC_NSS_TS_CLK] = &gcc_nss_ts_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV8_CLK] = &gcc_qdss_tsctr_div8_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV16_CLK] = &gcc_qdss_tsctr_div16_clk.clkr,
-	[GCC_Q6SS_PCLKDBG_CLK] = &gcc_q6ss_pclkdbg_clk.clkr,
-	[GCC_Q6SS_TRIG_CLK] = &gcc_q6ss_trig_clk.clkr,
-	[GCC_WCSS_DBG_IFC_APB_CLK] = &gcc_wcss_dbg_ifc_apb_clk.clkr,
-	[GCC_WCSS_DBG_IFC_DAPBUS_CLK] = &gcc_wcss_dbg_ifc_dapbus_clk.clkr,
 	[GCC_QDSS_DAP_CLK] = &gcc_qdss_dap_clk.clkr,
 	[GCC_QDSS_APB2JTAG_CLK] = &gcc_qdss_apb2jtag_clk.clkr,
 	[GCC_QDSS_TSCTR_DIV3_CLK] = &gcc_qdss_tsctr_div3_clk.clkr,
 	[QPIC_IO_MACRO_CLK_SRC] = &qpic_io_macro_clk_src.clkr,
 	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
 	[Q6_AXI_CLK_SRC] = &q6_axi_clk_src.clkr,
-	[GCC_Q6_AXIM_CLK] = &gcc_q6_axim_clk.clkr,
-	[GCC_WCSS_Q6_TBU_CLK] = &gcc_wcss_q6_tbu_clk.clkr,
-	[GCC_MEM_NOC_Q6_AXI_CLK] = &gcc_mem_noc_q6_axi_clk.clkr,
 	[Q6_AXIM2_CLK_SRC] = &q6_axim2_clk_src.clkr,
 	[NSSNOC_MEMNOC_BFDCD_CLK_SRC] = &nssnoc_memnoc_bfdcd_clk_src.clkr,
 	[GCC_NSSNOC_MEMNOC_CLK] = &gcc_nssnoc_memnoc_clk.clkr,
@@ -4129,7 +3804,6 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_UNIPHY1_SYS_CLK] = &gcc_uniphy1_sys_clk.clkr,
 	[GCC_UNIPHY2_SYS_CLK] = &gcc_uniphy2_sys_clk.clkr,
 	[GCC_CMN_12GPLL_SYS_CLK] = &gcc_cmn_12gpll_sys_clk.clkr,
-	[GCC_Q6SS_BOOT_CLK] = &gcc_q6ss_boot_clk.clkr,
 	[UNIPHY_SYS_CLK_SRC] = &uniphy_sys_clk_src.clkr,
 	[NSS_TS_CLK_SRC] = &nss_ts_clk_src.clkr,
 	[GCC_ANOC_PCIE0_1LANE_M_CLK] = &gcc_anoc_pcie0_1lane_m_clk.clkr,
-- 
2.34.1

