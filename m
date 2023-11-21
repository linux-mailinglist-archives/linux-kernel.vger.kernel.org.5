Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD07F30D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjKUObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjKUOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:31:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25190;
        Tue, 21 Nov 2023 06:31:23 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE2DS0003250;
        Tue, 21 Nov 2023 14:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=gqI+CxuXvB2nck6peTPOubE2SjCZOAUdVyrGTve6okI=;
 b=ASCU4lH8yIdXTbYQu9gUAcScKEnrCLM4rRh1FRFoOo1Z2M/QeWvKhmfmMav1bLfbtwsp
 Bh2FqxWnZBtx7jdg/um26w+U9wHR1hbZJcyd+rt5bi+36DJkYHJXRRQ3oe9qHWm/Qj4f
 8XwUPEYtKpEygUFHunwMKfh+HxCq9jsPkpFyvCfeDrl0K/BefShzrPNjL8uUcZov70FK
 BeI0B7yATUtbc/4fEthuVvE8BnGEkPznSqruY+VyVI1kgeEtxdJ1dlm/pf5MbCacGIjl
 QjpzNfmmqXGUlWBoLTMz1GN42ji+u1nHSWcMHiQDtokFWC7y6oqmAMjQcDOaOHxPid1P zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugu548vpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALEVCrL007741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:12 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 06:31:07 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Tue, 21 Nov 2023 20:00:43 +0530
Subject: [PATCH v2 1/9] clk: qcom: ipq5332: add const qualifier to the
 clk_init_data structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231121-ipq5332-nsscc-v2-1-a7ff61beab72@quicinc.com>
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
In-Reply-To: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700577061; l=7721;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=+0Hvf6odeN5BU615J2c1Ow0cnXHABxgNEO32lQZZoLs=;
 b=KfY7rf2rGZK5HvUMmizxYsSIwSMJYnC5mNJWiiMuF7R+EVmScAvyHr9w/HDHXXhqbA0uEv6wO
 Y6JZRsYsONaBll4VkGlCMcO4lFjgdmnZXzOq4lzlxoWc8qjYLJnHDcg
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kJM-JN6_YoKioih57Q8O9WWiQm-QurjI
X-Proofpoint-ORIG-GUID: kJM-JN6_YoKioih57Q8O9WWiQm-QurjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=900 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few places where clk_init_data structure doesn't carry the const
qualifier. Let's add the same.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- New patch
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

