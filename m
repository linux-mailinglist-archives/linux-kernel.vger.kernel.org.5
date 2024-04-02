Return-Path: <linux-kernel+bounces-127746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC61895059
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D711C22A38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9B81203;
	Tue,  2 Apr 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cLe8nuAH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61E7FBA1;
	Tue,  2 Apr 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054091; cv=none; b=h/3IlZywdNRWnuf5OiLM7jLQp4wTuv5/R4tVhhXWPqJSe6q1zIHCI8iir4lHL70s95yf38ghgFztvQpQHAV4jyE4f3w8MvHmwIRoVQXvYNwOwymD+izL/fJX5tS9jnHnBHCLz/hOUUTEiRLkz5o8rEmlVZW7YLm2+XWI+ZQpuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054091; c=relaxed/simple;
	bh=A201PwE649L4Nwc6P4ssXhFIHSjpP4MlvEYwTwP7l1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPN3SN1NzTQXy1ebt6gNxAgfiZMfhKt5zZsVTlLzBhgIbVy/TGC3eF70uD+qVhB6r54dkR4BE4awwJRJPM02cxTbPn43fbyc6CbOuiNDnNA9loTxrPmYXHNlTJeFtbbX82N2K1/aSg4ePHXuXmBOPkDqalKLtDx16+vTB6MT148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cLe8nuAH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43286fxN021848;
	Tue, 2 Apr 2024 10:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XLtC6fosCAltPbnUfvJMExj816aMYrdKzHUzvEfnsyg=; b=cL
	e8nuAHJ2sNb9T9pT4sKndRbOYgDaoDobxm0WLIkFK/G7kNdWiuzLwnoV5Uc9B1Cw
	5+9TKfrWGtHFHICbY8KhMwYnOMMpuCMEZm0zsdNbq/D3Iq3h9Zzbvgwm54BfnwcZ
	YRjm/ZYct3p7SYCbXCq4EAOVW77iicZdP94E1nH5bjFhtUJE8Jj9gjeU/z4PNAgZ
	6hzyCxncPGT5OWmzBE1KdeQeV/PKwuwm6OqTodseyUpUYs4PyX1Moykrt54DdFRI
	iKzneDksJd63KmwX7lXD6joWFI6MYbOa7o6G60ji9UloyvZ4sRnVDNipW65wwND5
	9Dk5E5jQjNOtJf44SZ2Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x88eh92h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:34:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432AYjpQ007033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:34:45 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 03:34:40 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_varada@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v6 4/6] clk: qcom: common: Add interconnect clocks support
Date: Tue, 2 Apr 2024 16:04:04 +0530
Message-ID: <20240402103406.3638821-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402103406.3638821-1-quic_varada@quicinc.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: JcOquWBiVx2CAFUcOSKWVJgwR48mtRka
X-Proofpoint-ORIG-GUID: JcOquWBiVx2CAFUcOSKWVJgwR48mtRka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=947 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020076

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
 drivers/clk/qcom/common.c | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/common.h |  3 +++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..d5c008048994 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -8,6 +8,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
 
@@ -234,6 +235,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
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
+		/*
+		 * get_clk will be done by the peripheral device using this
+		 * clock with devm_clk_hw_get_clk() so that we can associate
+		 * the clk handle with the consumer device. It would also help
+		 * us make it so that drivers defer probe until their
+		 * clk isn't an orphan.
+		 */
+		icd[i].clk = desc->icc_hws[i]->clk;
+		if (!icd[i].clk)
+			return dev_err_probe(dev, -ENOENT,
+					     "(%d) clock entry is null\n", i);
+		icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
+	}
+
+	return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->icc_first_node_id,
+						     desc->num_icc_hws, icd));
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -303,7 +339,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	return 0;
+	return qcom_cc_icc_register(dev, desc);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..9058ffd46260 100644
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


