Return-Path: <linux-kernel+bounces-129594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B678D896CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2428E648
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF3B1482F8;
	Wed,  3 Apr 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YnnyH4jP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05413A24A;
	Wed,  3 Apr 2024 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140977; cv=none; b=MdKvsb1oJfWEKxtJQRAmjS5XFRuVPB54c0S2Grq/QAzLfhpuTifSKtkPpHcy86SECJyoCY1FTB3vh6JgZEROJv9TCX7MLTxWC3+b6v/z/IJfbBT5W2KoU9Xnz6UI1V2ckKqAylFg5E7tTWpLIR+8PBo5/d4+ewRXJvZwUtDdGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140977; c=relaxed/simple;
	bh=pWmv7Z2rs4fSgPincBCtHMi5Ny86SINVvzdPY2SGErI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=me4Z6mVhy78Hspq6vsePP6SV38mD8qPFr4MnX6BFVSisYPy3pxvlVxFaTnJnVt/2GCkhF7HaOH68nO4dq4rKHPHl5V47PkQr7rutBDd+HeAQM0OoKX8fL/FUWh/3QqjW6hpNS2c7vvJBYw8Yux/ug+/y1JhUEPuqIiSSgZH414U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YnnyH4jP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4338U8F9006895;
	Wed, 3 Apr 2024 10:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SOPjz2y8zVwr/eQd0/jq9B7qpx0cqqsHTQXvLt98C/g=; b=Yn
	nyH4jPMZeBLwq2iNoumtyCkm2Ij0YiC0Rd0I5SgdEzuR9p1fYSMsZIstnXwnY4Vj
	QtFXtrhfVubsgGgYAdIJqHOOuJOIa10JruKvBjtLHxEilfaV9jZIL1iQ65IMRN69
	CU9zG5JA5xKHEr3DbgtIFZOdlW9wt0aDliOL75EfuvWDjH0Y9Z+H+3CZ/eVAxsny
	gtntVL9aN2bg5q4+4dOkHJhUmKwNgNoiytasCnyqZ8WpQtMiFNQ64vm040tyudYo
	xf8itQmXePfaX6QTABM5VaDSxAj6QjeRfeMIr3QUIMgko1LKi9xc4sBtLJjOqxrw
	cs0eWeYIesNcyD8bGJqQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93n3g9qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:42:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433Agnb5014432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:42:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:42:45 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 3/5] clk: qcom: common: Add interconnect clocks support
Date: Wed, 3 Apr 2024 16:12:18 +0530
Message-ID: <20240403104220.1092431-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403104220.1092431-1-quic_varada@quicinc.com>
References: <20240403104220.1092431-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: os_VlQxebyDzn-ok41vS6fnx_7rQoqZs
X-Proofpoint-ORIG-GUID: os_VlQxebyDzn-ok41vS6fnx_7rQoqZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030074

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
 drivers/clk/qcom/common.c | 31 ++++++++++++++++++++++++++++++-
 drivers/clk/qcom/common.h |  3 +++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 8b6080eb43a7..fa4ec89c04c4 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -8,6 +8,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
 
@@ -252,6 +253,34 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
+static int qcom_cc_icc_register(struct device *dev,
+				const struct qcom_cc_desc *desc)
+{
+	struct icc_clk_data *icd;
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
+		icd[i].clk = devm_clk_hw_get_clk(dev, desc->icc_hws[i], "icc");
+		if (!icd[i].clk)
+			return dev_err_probe(dev, -ENOENT,
+					     "(%d) clock entry is null\n", i);
+		icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
+	}
+
+	return devm_icc_clk_register(dev, desc->icc_first_node_id,
+						     desc->num_icc_hws, icd);
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -327,7 +356,7 @@ int _qcom_cc_really_probe(struct device *dev,
 	if (ret)
 		return ret;
 
-	return 0;
+	return qcom_cc_icc_register(dev, desc);
 }
 EXPORT_SYMBOL_GPL(_qcom_cc_really_probe);
 
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 8657257d56d3..43073d2ef32a 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -29,6 +29,9 @@ struct qcom_cc_desc {
 	size_t num_gdscs;
 	struct clk_hw **clk_hws;
 	size_t num_clk_hws;
+	struct clk_hw **icc_hws;
+	size_t num_icc_hws;
+	unsigned int icc_first_node_id;
 };
 
 /**
-- 
2.34.1


