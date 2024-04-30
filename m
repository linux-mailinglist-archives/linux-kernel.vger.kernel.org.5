Return-Path: <linux-kernel+bounces-163423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5378B6AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E8E1C20F20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05441775;
	Tue, 30 Apr 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2t6gGJw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D840BF2;
	Tue, 30 Apr 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459382; cv=none; b=AJASOHGGHGN4tOT+XfOqGKKcAGSvNGEHzsXh0nDrZpqd+HqBUGm2pcUk8K2SdvvXGsRgmGtgNj90NfARB3IjNnr49TJniJMy++X4Z0vkr5KuQGuuaDEayiFWa1ehBPkB/4Zz9FHHe36rNsgH/tMwBTpwTr+pthB+zbLF/YkHoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459382; c=relaxed/simple;
	bh=TI+Duxp2EJGVJ4LdDfnyodpBJpXYgGGAd/jITQiOpN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X62H2eBinrQ6kgmhT+9I3/x6OP1NE1Try6AsOu4kjt2UTO5s/Hqcu8g/KIwjXeq8W7Z6hNrHrsIBKM+Ejcm5rpu6o6cWBQ2u5aTIdYjkRxzXOVLr7TyuG4WCd64H7OSq1JEqJR12djs4GV+WHQroDee2UeiY8u+bGdtr6yrkeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2t6gGJw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U5rOld022839;
	Tue, 30 Apr 2024 06:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bTD3rZD1+ix+HL2KnDkU+hVfMXeUhq9jJbKM8O/mw78=; b=o2
	t6gGJwZaF9OGj4+OxrrA8IwhdfoENL9zBkDvnRGGHBd9EZ1yOoyAqEYpHOL5DHyw
	YF/ugCsJFSZsrUWG3LVi00MwsdznbOlN5f6Pe795p9EO/sW/sP1BLPF4fealT8R4
	XVB2nH6myeIHSm6DBxPFvSgS5UBoC7VEg/D7R3Y9yQUTyruPtz5rEmd5SYIyaoyx
	C0sMUcR6vLZvq5+VsDOGH+qlAuoAmYceePZ1DQCml4qsH2QBjcPBdEJdUKUSVTxx
	jv+kGhPJk0rrSEHu+W5/x9myctsTxcaqD7x0okE864/vR8l6kRRbnJ0PtLO9/QWO
	Epgj3T17H09jTdCKrO3w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xttw3g3da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:42:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6gtQa019744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:42:55 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:42:49 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bryan.odonoghue@linaro.org>
Subject: [PATCH v11 4/6] clk: qcom: common: Add interconnect clocks support
Date: Tue, 30 Apr 2024 12:12:12 +0530
Message-ID: <20240430064214.2030013-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430064214.2030013-1-quic_varada@quicinc.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CpRvNNjaibxvL9-vPBds6GYuumGb7b1H
X-Proofpoint-ORIG-GUID: CpRvNNjaibxvL9-vPBds6GYuumGb7b1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300047

Unlike MSM platforms that manage NoC related clocks and scaling
from RPM, IPQ SoCs dont involve RPM in managing NoC related
clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for accessing the peripheral controllers present on
these NoCs. Though exposing these as normal clocks would work,
having a minimalistic interconnect driver to handle these clocks
would make it consistent with other Qualcomm platforms resulting
in common code paths. This is similar to msm8996-cbf's usage of
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v9: Remove HWS_DATA macro
v8: Explicitly set master and slave ids
v7: Restore clk_get
v6: first_id -> icc_first_node_id
    Remove clock get so that the peripheral that uses the clock
    can do the clock get
v5: Split changes in common.c to separate patch
    Fix error handling
    Use devm_icc_clk_register instead of icc_clk_register
v4: Use clk_hw instead of indices
    Do icc register in qcom_cc_probe() call stream
    Add icc clock info to qcom_cc_desc structure
v3: Use indexed identifiers here to avoid confusion
    Fix error messages and move to common.c
v2: Move DTS to separate patch
    Update commit log
    Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
---
 drivers/clk/qcom/common.c | 35 ++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/common.h |  9 +++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..a6410b1828ca 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -8,6 +8,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
 
@@ -234,6 +235,38 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
+static int qcom_cc_icc_register(struct device *dev,
+				const struct qcom_cc_desc *desc)
+{
+	struct icc_clk_data *icd;
+	struct clk_hw *hws;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
+		return 0;
+
+	if (!desc->icc_hws)
+		return 0;
+
+	icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
+	if (!icd)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_icc_hws; i++) {
+		icd[i].master_id = desc->icc_hws[i].master_id;
+		icd[i].slave_id = desc->icc_hws[i].slave_id;
+		hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
+		icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
+		if (!icd[i].clk)
+			return dev_err_probe(dev, -ENOENT,
+					     "(%d) clock entry is null\n", i);
+		icd[i].name = clk_hw_get_name(hws);
+	}
+
+	return devm_icc_clk_register(dev, desc->icc_first_node_id,
+						     desc->num_icc_hws, icd);
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -303,7 +336,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	return 0;
+	return qcom_cc_icc_register(dev, desc);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..ea96b2ca3cac 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -19,6 +19,12 @@ struct clk_hw;
 #define PLL_VOTE_FSM_ENA	BIT(20)
 #define PLL_VOTE_FSM_RESET	BIT(21)
 
+struct qcom_icc_hws_data {
+	int master_id;
+	int slave_id;
+	int clk_id;
+};
+
 struct qcom_cc_desc {
 	const struct regmap_config *config;
 	struct clk_regmap **clks;
@@ -29,6 +35,9 @@ struct qcom_cc_desc {
 	size_t num_gdscs;
 	struct clk_hw **clk_hws;
 	size_t num_clk_hws;
+	struct qcom_icc_hws_data *icc_hws;
+	size_t num_icc_hws;
+	unsigned int icc_first_node_id;
 };
 
 /**
-- 
2.34.1


