Return-Path: <linux-kernel+bounces-54783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC484B3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2911C223F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C6132C3C;
	Tue,  6 Feb 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MfEFZcig"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C2130E25;
	Tue,  6 Feb 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219147; cv=none; b=JDiugdZ7doh+MPGctgW2y37UNQxAwnpDNuWFY9osshslkXcaYDgWqZFDtnb+SsCTDtrgED0QX3H76eg42uRhjz7xOzSbxoxIisos7I1cND2qX5NSMx0J6hEY0E5+UGh/OvgR4BFLllYFWxr2vPUf7w2q9wcpUW6W0AEJJ9NpxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219147; c=relaxed/simple;
	bh=LGf8J48+MEMNKuUnX2Es6DdZqghMwyjboputw226Tho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/HjzF3tN9Lv3d9pxezXML6YA7uRT0gTbYanbDYzrlrvfmS0biYtLXJo0S/l4/q2p+PKFX7TIDrmoju5+AMvyx1hIXNQSPqGO/9hQPEgkSWXoOwMaVeQZH/niS3VhUQ7xJUFpcI8WZay+A32WERvtT8/Hbm5O96Mf3i8xG7hb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MfEFZcig; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41650Hsw017845;
	Tue, 6 Feb 2024 11:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EjJwPF3eUseYPgOTFWN5E3vlkPR2dvPSwtJ9HQgkGDs=; b=Mf
	EFZcigptGykb2DGoElkXfNXTCX7/MRtuPpAVrvtNpkYWMrsyNFZfBjfdEOwLLj59
	2poxFVtYTrzskXhvcumPsYFSJFfcQtQVlhlJe+y/IuGG7fa1m4CUwO6ozRiTrQy3
	qYzOJr1Rb8W4jEYBUznXE7mXjh4sS7mHiMhp4Fw0JRFkQkida7b//Y3DbnGisBQZ
	KOLwI7+f3TNbbVsM5SIWJzdgYHijl1ZnMbdrsCL18fYF4KJlYLXU70Wqw0cYA+sP
	BfEYifP+TU1NLNVZgKPslav8Y3NEN8N7OaUpohfDhj/hfrDEEf8ofq3s1kCMZdcO
	KV7dhY34zAWjCdhC1rBg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3apjh3t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:32:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416BWK9G001070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:32:20 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:32:15 -0800
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Jagadeesh Kona
	<quic_jkona@quicinc.com>
Subject: [PATCH 2/5] clk: qcom: videocc-sm8550: Add support for SM8650 videocc
Date: Tue, 6 Feb 2024 17:01:42 +0530
Message-ID: <20240206113145.31096-3-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206113145.31096-1-quic_jkona@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Y9Yibup4qNlo2lCK-DcW7yAGb216IQJ7
X-Proofpoint-GUID: Y9Yibup4qNlo2lCK-DcW7yAGb216IQJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060081

Add support to the SM8650 video clock controller by extending the
SM8550 video clock controller, which is mostly identical but SM8650
has few additional clocks and minor differences.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 drivers/clk/qcom/videocc-sm8550.c | 160 +++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index f3c9dfaee968..cdc08f5900fc 100644
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
@@ -354,15 +481,20 @@ static struct clk_regmap *video_cc_sm8550_clocks[] = {
 	[VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
 	[VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
 	[VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
+	[VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr,
 	[VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
 	[VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
+	[VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr,
 	[VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
 	[VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
 	[VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
+	[VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr,
 	[VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
 	[VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
+	[VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr,
 	[VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
 	[VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
+	[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr,
 };
 
 static struct gdsc *video_cc_sm8550_gdscs[] = {
@@ -380,6 +512,7 @@ static const struct qcom_reset_map video_cc_sm8550_resets[] = {
 	[CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },
 	[VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
 	[VIDEO_CC_MVS1C_CLK_ARES] = { 0x8090, 2 },
+	[VIDEO_CC_XO_CLK_ARES] = { 0x8124, 2 },
 };
 
 static const struct regmap_config video_cc_sm8550_regmap_config = {
@@ -402,6 +535,7 @@ static struct qcom_cc_desc video_cc_sm8550_desc = {
 
 static const struct of_device_id video_cc_sm8550_match_table[] = {
 	{ .compatible = "qcom,sm8550-videocc" },
+	{ .compatible = "qcom,sm8650-videocc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
@@ -410,6 +544,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
 	int ret;
+	u32 offset;
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
@@ -425,6 +560,23 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8550-videocc")) {
+		video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = NULL;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = NULL;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = NULL;
+		video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = NULL;
+		video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = NULL;
+		offset = 0x8140;
+	} else  if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
+		video_cc_pll0_config.l = 0x1e;
+		video_cc_pll0_config.alpha = 0xa000;
+		video_cc_pll1_config.l = 0x2b;
+		video_cc_pll1_config.alpha = 0xc000;
+		video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
+		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
+		offset = 0x8150;
+	}
+
 	clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
 
@@ -435,7 +587,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 	 *	video_cc_xo_clk
 	 */
 	regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
+	regmap_update_bits(regmap, offset, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
-- 
2.43.0


