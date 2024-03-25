Return-Path: <linux-kernel+bounces-116825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1388A43F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B391F3BED7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4C31966BF;
	Mon, 25 Mar 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LNv9QAQS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694C1B04BE;
	Mon, 25 Mar 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362086; cv=none; b=F3g1V8DyF1HBrtUKiQpnhnRozObzJvkD4qfAqqC9ur+6K0XsNiQgxxx/yKWWUlQWyzqsdQkDgWU0FwOX+yHmVmRh7LGrDklS0+gjLu4XArTKrNn413AQU13mXq0Bsx60Ct9TiJGzHJ4A7gx8AyJN/uVY4weuftgg+Ix0i+gvSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362086; c=relaxed/simple;
	bh=h9Pbpo0h6P/xU2AHtAIT3qMJd8Q/luhts8wY6O3Eweo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1ZfHTdaIkKG7m/zZm/0EeWApBb6k5XeL4BaBoITR2e41+TAr9MRdBrbCJTOCtrKIrWz7ehobI53ppriuXyvle7Z4MD65S5YNTg/bfgipePGBCT5qXKJiRG9WTIzKxHOkAcvvtMkoh5VqrqZsjMWaMogq9ac2BeEPD7c/9wJKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LNv9QAQS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P7MOmi023695;
	Mon, 25 Mar 2024 10:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Q0ha2IWDCQx2s46UlYuAhr94THBiDjdiNC+8EpKOg7w=; b=LN
	v9QAQSZtogyZaERn1uLUcCfXVIT9LhYcF1XZv05oDrPit6ZybVVdD2IC4jfJi/Q0
	/22GZQv0GeQRECENV+7Mu+99VQ8juCGSyc+dzu0L8ads72Bcekzpfvh7cfRhSlq+
	n8HcBdNvu/gzlHN+9aJL90mlwtP/dSHkxkWReYicKmr6YNC0R9Qh9bI7IrXOqkSj
	KXsRnObuFQziKHCIAu8XxZLXZqh8g7VJ05Cpj4kD2hF/JSELlQuR28Tgu2yxilE/
	bQUIoGUmsZAZqi5NoPtTj4bb3cB9avXcOW01HM2TTHeyPJcUf3Urq0KMKvwDjoOl
	biKAMDRRBYMP6GLso1EA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x319j8rds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:21:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PALB1V007283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:21:11 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 03:21:06 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 3/4] clk: qcom: add IPQ9574 interconnect clocks support
Date: Mon, 25 Mar 2024 15:50:35 +0530
Message-ID: <20240325102036.95484-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325102036.95484-1-quic_varada@quicinc.com>
References: <20240325102036.95484-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZgB72T5PBkOlOEKFMUAPvuObuQgritH9
X-Proofpoint-GUID: ZgB72T5PBkOlOEKFMUAPvuObuQgritH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250056

Unlike MSM platforms that manage NoC related clocks and scaling
from RPM, IPQ SoCs dont involve RPM in managing NoC related
clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for accessing the peripheral controllers present on
these NoCs. Though exposing these as normal clocks would work,
having a minimalistic interconnect driver to handle these clocks
would make it consistent with other Qualcomm platforms resulting
in common code paths.  This is similar to msm8996-cbf's usage of
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Move DTS to separate patch
    Update commit log
    Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c | 65 +++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8ab08e7b5b6c..af73a0b396eb 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -243,6 +243,8 @@ config IPQ_GCC_8074
 
 config IPQ_GCC_9574
 	tristate "IPQ9574 Global Clock Controller"
+	select INTERCONNECT
+	select INTERCONNECT_CLK
 	help
 	  Support for global clock controller on ipq9574 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..ed25bb34216a 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -9,9 +9,12 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4304,33 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+
+static struct icc_clk_data *icc_ipq9574;
+
+static int noc_clks[] = {
+	GCC_ANOC_PCIE0_1LANE_M_CLK,
+	GCC_SNOC_PCIE0_1LANE_S_CLK,
+	GCC_ANOC_PCIE1_1LANE_M_CLK,
+	GCC_SNOC_PCIE1_1LANE_S_CLK,
+	GCC_ANOC_PCIE2_2LANE_M_CLK,
+	GCC_SNOC_PCIE2_2LANE_S_CLK,
+	GCC_ANOC_PCIE3_2LANE_M_CLK,
+	GCC_SNOC_PCIE3_2LANE_S_CLK,
+	GCC_SNOC_USB_CLK,
+	GCC_ANOC_USB_AXI_CLK,
+	GCC_NSSNOC_NSSCC_CLK,
+	GCC_NSSNOC_SNOC_CLK,
+	GCC_NSSNOC_SNOC_1_CLK,
+	GCC_NSSNOC_PCNOC_1_CLK,
+	GCC_NSSNOC_QOSGEN_REF_CLK,
+	GCC_NSSNOC_TIMEOUT_REF_CLK,
+	GCC_NSSNOC_XO_DCD_CLK,
+	GCC_NSSNOC_ATB_CLK,
+	GCC_MEM_NOC_NSSNOC_CLK,
+	GCC_NSSNOC_MEMNOC_CLK,
+	GCC_NSSNOC_MEM_NOC_1_CLK,
+};
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4327,7 +4357,40 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+	int ret = qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+	struct icc_provider *provider;
+	struct icc_clk_data *icd;
+	int i;
+
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "%s failed\n", __func__);
+
+	icd = devm_kmalloc(&pdev->dev, ARRAY_SIZE(noc_clks) * sizeof(*icd),
+			   GFP_KERNEL);
+
+	if (IS_ERR_OR_NULL(icd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(icd),
+				     "%s malloc failed\n", __func__);
+
+	icc_ipq9574 = icd;
+
+	for (i = 0; i < ARRAY_SIZE(noc_clks); i++, icd++) {
+		icd->clk = gcc_ipq9574_clks[noc_clks[i]]->hw.clk;
+		if (IS_ERR_OR_NULL(icd->clk)) {
+			dev_err(&pdev->dev, "%s: %d clock not found\n",
+				__func__, noc_clks[i]);
+			return -ENOENT;
+		}
+		icd->name = clk_hw_get_name(&gcc_ipq9574_clks[noc_clks[i]]->hw);
+	}
+
+	provider = icc_clk_register(&pdev->dev, IPQ_APPS_ID,
+				    ARRAY_SIZE(noc_clks), icc_ipq9574);
+	if (IS_ERR_OR_NULL(provider))
+		return dev_err_probe(&pdev->dev, PTR_ERR(provider),
+				     "%s: icc_clk_register failed\n", __func__);
+
+	return 0;
 }
 
 static struct platform_driver gcc_ipq9574_driver = {
-- 
2.34.1


