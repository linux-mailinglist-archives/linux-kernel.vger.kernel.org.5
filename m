Return-Path: <linux-kernel+bounces-122556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10888F968
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88791F2E7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD26214E;
	Thu, 28 Mar 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LbP0m7oT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32B5467C;
	Thu, 28 Mar 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612872; cv=none; b=PU/S8I7qw6YoZp7cHF66ON9NgkXgzxnmPJHk9jzCzoxMuE2u/H2dYtyRpHGDHpxA5wI9OwroLc0jTeZDHv4Lp7Imwvrsnovq0omRwHNcr0wVNKbeWDx9WRRgbQqaiTV8W0M3KtQW/3Ta0WU/PVgs8XYi1J68LgCkoZHGRVKt3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612872; c=relaxed/simple;
	bh=vgEZXW+jhgn4DKaiG8Be8CsdfqoLZ0HAo8wE1hzYhYI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOaJmmaEikO4XN3Xf830jUl+yYaeNbHZpdlqmS+eiHqWpi5DRsAbnwRyBpKlQg4HFiBhgkSUYkT4ZXP4n8+E6aWvP8bBvqvcptyyjllw37DEMKHuSJyS3pLMT4M0n9ub831mfGHCrQqlc7eYSOsD8wSu2yMsozNk3yuGYvHqnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LbP0m7oT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S6qjK8027630;
	Thu, 28 Mar 2024 08:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VN+BV00nogxrt9VNOzklsHzlRkiMLC2S9Qc1TzhlA5o=; b=Lb
	P0m7oT++NoUBiiWku2wpIqNMhC079JfSvw5Tzx5L4D5hQ/HVn+pv2TUOoSes6rOs
	7zXMyD/WXXHkqRWSkCQIkx4o9xs3fUA8GOAW7fmS9XgvGUjvkhSVnKlX0UP4jHR3
	RBv2TOhF5fAcNhvIL/dnvnWFDxRo7ZVzF4cPgLC+60M2oiT9ESBNgymAQEiQA/Hj
	Sqd01UKrgySukByL0j3iWESw/YXYeP7tkMr7fLl/ryd51CG7Z6iSJmGH3fvO05cX
	Hib8amdHu2xiQ5osR4lwZuCsGZBQPqENS/65eiuIhX78Z39z53BcSdnYrvyxevN6
	SMGCvVqvbNMeVGxniINA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxg8fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S815AV000961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:05 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 01:01:00 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 3/5] clk: qcom: common: Add interconnect clocks support
Date: Thu, 28 Mar 2024 13:29:34 +0530
Message-ID: <20240328075936.223461-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328075936.223461-1-quic_varada@quicinc.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: jpYabgwTdg-FBQj1lY9gHiRqsqCzFhgJ
X-Proofpoint-ORIG-GUID: jpYabgwTdg-FBQj1lY9gHiRqsqCzFhgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280052

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
 drivers/clk/qcom/common.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/common.h |  3 +++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..9fa271812373 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -8,6 +8,8 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
 
@@ -234,6 +236,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
+#if IS_ENABLED(CONFIG_INTERCONNECT_CLK)
+static int qcom_cc_icc_register(struct device *dev,
+				const struct qcom_cc_desc *desc)
+{
+	struct icc_clk_data *icd;
+	int i;
+
+	if (!desc->icc_hws)
+		return 0;
+
+	icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
+	if (!icd)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_icc_hws; i++) {
+		icd[i].clk = devm_clk_hw_get_clk(dev, desc->icc_hws[i], "qcom");
+		if (IS_ERR(icd[i].clk))
+			return dev_err_probe(dev, PTR_ERR(icd[i].clk),
+					     "get clock failed (%ld)\n",
+					     PTR_ERR(icd[i].clk));
+
+		icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
+	}
+
+	return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->first_id,
+						     desc->num_icc_hws, icd));
+}
+#else
+static int qcom_cc_icc_register(struct device *dev,
+				const struct qcom_cc_desc *desc)
+{
+	return 0;
+}
+#endif
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -303,7 +340,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	return 0;
+	return qcom_cc_icc_register(dev, desc);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..d8ac26d83f3c 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -29,6 +29,9 @@ struct qcom_cc_desc {
 	size_t num_gdscs;
 	struct clk_hw **clk_hws;
 	size_t num_clk_hws;
+	struct clk_hw **icc_hws;
+	size_t num_icc_hws;
+	unsigned int first_id;
 };
 
 /**
-- 
2.34.1


