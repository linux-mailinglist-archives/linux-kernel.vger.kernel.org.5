Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADFF80BFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjLKDh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKDhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:37:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01274ED;
        Sun, 10 Dec 2023 19:38:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB1aYSc032663;
        Mon, 11 Dec 2023 03:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=5LccCVevU5nbbXP+2AfHZW7uW3VJb3lccoM0/87iaYU
        =; b=MarcoODBWf2vWp/D1oY1gK0mZSopSIZ85uEWP9Vy+PS3+6lB51NuBmTGX2F
        m2boqeLxCxzfoKIPGL85AYtcW3wkgTQxv0rvyjcP98bxrfzjF9/Eti2R9AvHa36l
        JRH9J8ZSPySXyjQLeYapLOjdK/oqEslcjqCzKavtqms/xNtU6taYgBxj3NUpGO5m
        wSDuDPqK+KT8eLYaUVVANLKQjQWwtq+kwo3//Yp+drY2/L7rBxtRW+WG/PxIQyIS
        9Rhf3gfBXc1ZLtFA1iF4RIdRFids6GcBp27GObYQZV4SP2HyEVWmLS92flpUrT2c
        xffqs9q/Vx/TvuetvQXdoQHtk4g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnk5t5h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:37:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3bgab030142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:37:42 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 19:37:37 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Mon, 11 Dec 2023 09:07:23 +0530
Subject: [PATCH v3 1/8] clk: qcom: ipq5332: add const qualifier to the
 clk_init_data structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231211-ipq5332-nsscc-v3-1-ad13bef9b137@quicinc.com>
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
In-Reply-To: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702265852; l=7738;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=K2/TZ1jR94Do3DQzYdLE5mKWlGTml2gLs76pSKeaNdc=;
 b=NdlJm2gWTA6667xxG1nA9EsuDuRk/fCsgNRptFK0fYFvhgkiIg7rUiiRM9P28TjgOf986XyT1
 Lf5mDoCwin7D5S3vv9Q3dSaGTazLq7IegypaXFepuh1gl28f8289Cti
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8Id3iCa6JObnLRVXNCtHOsfki_zB9584
X-Proofpoint-GUID: 8Id3iCa6JObnLRVXNCtHOsfki_zB9584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=964
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110028
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

