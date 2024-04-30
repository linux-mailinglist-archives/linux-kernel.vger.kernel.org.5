Return-Path: <linux-kernel+bounces-164150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EA8B79E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3831F24A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D214375A;
	Tue, 30 Apr 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="keTOxbcH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285B152783;
	Tue, 30 Apr 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487446; cv=none; b=C/W8Wm+Wy5e7v77sRXREhZZJ3FAriQ9C87DS/xHZ3EiX6sDAslet7IA3LmWingHS64dRyz/fckSDlu/tNQAy7LI979X6dIaM7U0q6U6B1yYDDA2KP/+INhkJfqNfUpvE89nWuHN5ltzffDflzBYxJNUvl9Adt8JW2WM8cnyQb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487446; c=relaxed/simple;
	bh=Zz8ZNu8ONJ/IrefrVxYb6GmtSNop547NfVG6/CDJgcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhIwGg5G9wLrjnr3IRaRqrvgVa9tW96xUphjkpfyA/vjo+BdWK7ylW85fs9QkeULBVeGQb51icfz1xxjJYFDN6wDJJDjj/cXm5gz2GvoXm20/AHWmHz49aPkDUG6i4qe7wqfLUzLvq/99uJgq8h6dVWVYlhFxmgs70hckzZYg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=keTOxbcH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDqEf1006909;
	Tue, 30 Apr 2024 14:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tR1AOsl94kj6JDai99PSTYA3Yi2nJ+FmlfIN6Q+iDFQ=; b=ke
	TOxbcHHLIhVYR6Bs9MYFMKmas6tJX/PlGz4LD10Zhyzc02sEKrc6ZEq8e96H5wXU
	xH0628HMYcMJ2fwXtQLMBp3Smt2FyMYj4DHidBAFdPJq+i/h8biPrzFhrw9Cm/OD
	/fJ5KEWbsTBEQjuhfHyDT1Wpo2dyV0+xQwXCboh1fedeIp7eIQl+NNPZwwx0BhvS
	sD6jBiTp3P+ofmejuszvYZf8npQepU7QSUr8rZ4m5zsnkhfXARS37J/fkFw9t218
	58LWQrYAEdODOshAeVLpGMVkr9Pl9acg3uE7Ao67XrzCDfXHfrkIWqfCcC4SC/km
	NawTvbRcFFGRShouzmeA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtfys3qve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUdiM025421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:39 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:33 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: [PATCH V3 4/8] clk: qcom: videocc-sm8550: Add SM8650 video clock controller
Date: Tue, 30 Apr 2024 19:57:53 +0530
Message-ID: <20240430142757.16872-5-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430142757.16872-1-quic_jkona@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qFlqmiRrth4OaQEc8fQ7WYDt1PyisU3_
X-Proofpoint-ORIG-GUID: qFlqmiRrth4OaQEc8fQ7WYDt1PyisU3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300103

Add support to the SM8650 video clock controller by extending
the SM8550 video clock controller, which is mostly identical
but SM8650 has few additional clocks and minor differences.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/videocc-sm8550.c | 153 +++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index 25133cf5a2b8..c601c35e6724 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/clk-provider.h>
@@ -35,7 +35,7 @@ static const struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2300000000, 0 },
 };
 
-static const struct alpha_pll_config video_cc_pll0_config = {
+static struct alpha_pll_config video_cc_pll0_config = {
 	.l = 0x25,
 	.alpha = 0x8000,
 	.config_ctl_val = 0x20485699,
@@ -66,7 +66,7 @@ static struct clk_alpha_pll video_cc_pll0 = {
 	},
 };
 
-static const struct alpha_pll_config video_cc_pll1_config = {
+static struct alpha_pll_config video_cc_pll1_config = {
 	.l = 0x36,
 	.alpha = 0xb000,
 	.config_ctl_val = 0x20485699,
@@ -117,6 +117,14 @@ static const struct clk_parent_data video_cc_parent_data_1[] = {
 	{ .hw = &video_cc_pll1.clkr.hw },
 };
 
+static const struct parent_map video_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+};
+
 static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
 	F(720000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
 	F(1014000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
@@ -126,6 +134,16 @@ static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_video_cc_mvs0_clk_src_sm8650[] = {
+	F(588000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(900000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1140000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1305000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1440000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1600000000, P_VIDEO_CC_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 video_cc_mvs0_clk_src = {
 	.cmd_rcgr = 0x8000,
 	.mnd_width = 0,
@@ -149,6 +167,15 @@ static const struct freq_tbl ftbl_video_cc_mvs1_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_video_cc_mvs1_clk_src_sm8650[] = {
+	F(840000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1110000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1350000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1500000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1650000000, P_VIDEO_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 video_cc_mvs1_clk_src = {
 	.cmd_rcgr = 0x8018,
 	.mnd_width = 0,
@@ -164,6 +191,26 @@ static struct clk_rcg2 video_cc_mvs1_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_video_cc_xo_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_xo_clk_src = {
+	.cmd_rcgr = 0x810c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_2,
+	.freq_tbl = ftbl_video_cc_xo_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_xo_clk_src",
+		.parent_data = video_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_2),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
 static struct clk_regmap_div video_cc_mvs0_div_clk_src = {
 	.reg = 0x80c4,
 	.shift = 0,
@@ -244,6 +291,26 @@ static struct clk_branch video_cc_mvs0_clk = {
 	},
 };
 
+static struct clk_branch video_cc_mvs0_shift_clk = {
+	.halt_reg = 0x8128,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x8128,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x8128,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0_shift_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch video_cc_mvs0c_clk = {
 	.halt_reg = 0x8064,
 	.halt_check = BRANCH_HALT,
@@ -262,6 +329,26 @@ static struct clk_branch video_cc_mvs0c_clk = {
 	},
 };
 
+static struct clk_branch video_cc_mvs0c_shift_clk = {
+	.halt_reg = 0x812c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x812c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x812c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0c_shift_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch video_cc_mvs1_clk = {
 	.halt_reg = 0x80e0,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -282,6 +369,26 @@ static struct clk_branch video_cc_mvs1_clk = {
 	},
 };
 
+static struct clk_branch video_cc_mvs1_shift_clk = {
+	.halt_reg = 0x8130,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x8130,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x8130,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1_shift_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch video_cc_mvs1c_clk = {
 	.halt_reg = 0x8090,
 	.halt_check = BRANCH_HALT,
@@ -300,6 +407,26 @@ static struct clk_branch video_cc_mvs1c_clk = {
 	},
 };
 
+static struct clk_branch video_cc_mvs1c_shift_clk = {
+	.halt_reg = 0x8134,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x8134,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x8134,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1c_shift_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc video_cc_mvs0c_gdsc = {
 	.gdscr = 0x804c,
 	.en_rest_wait_val = 0x2,
@@ -363,6 +490,7 @@ static struct clk_regmap *video_cc_sm8550_clocks[] = {
 	[VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
 	[VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
 	[VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
+	[VIDEO_CC_XO_CLK_SRC] = NULL,
 };
 
 static struct gdsc *video_cc_sm8550_gdscs[] = {
@@ -403,6 +531,7 @@ static struct qcom_cc_desc video_cc_sm8550_desc = {
 
 static const struct of_device_id video_cc_sm8550_match_table[] = {
 	{ .compatible = "qcom,sm8550-videocc" },
+	{ .compatible = "qcom,sm8650-videocc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
@@ -411,6 +540,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
 	int ret;
+	u32 sleep_clk_offset = 0x8140;
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
@@ -426,12 +556,27 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
+		sleep_clk_offset = 0x8150;
+		video_cc_pll0_config.l = 0x1e;
+		video_cc_pll0_config.alpha = 0xa000;
+		video_cc_pll1_config.l = 0x2b;
+		video_cc_pll1_config.alpha = 0xc000;
+		video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
+		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr;
+		video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr;
+	}
+
 	clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
 
 	/* Keep some clocks always-on */
 	qcom_branch_set_clk_en(regmap, 0x80f4); /* VIDEO_CC_AHB_CLK */
-	qcom_branch_set_clk_en(regmap, 0x8140); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, sleep_clk_offset); /* VIDEO_CC_SLEEP_CLK */
 	qcom_branch_set_clk_en(regmap, 0x8124); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
-- 
2.43.0


