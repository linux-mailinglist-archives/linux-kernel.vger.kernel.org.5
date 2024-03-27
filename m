Return-Path: <linux-kernel+bounces-120520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159C88D8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1016A1F29592
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D142D610;
	Wed, 27 Mar 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PiG4DIoi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D836136;
	Wed, 27 Mar 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527628; cv=none; b=E9v0Y4HKaroRuDqJWW2KNasKVrRZYpienegpRq6NDCeJkcSi+Q2J/LUlCExshw85kMjnaDJ1b4Pfjb44UTbYPQ+jFkTsckjzUMlGbEHcuU0hIpcmAmjNqbe7xxfD2QWjfJAgXbYunCaB7apSzUx8KNRQeEJQiUJAvoUDLZ5QqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527628; c=relaxed/simple;
	bh=yHL6mPRtospIZ4OTP4HD9ELzOkZm6uD6x4Nt6M3zpw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDsAUwCuxqTUzrhIcIEToT2wq/NjEqx6AqKbIBmKRoViV59i6IZwHzLvLt/AeUhV/5AY5I8BddUPhBdp8bDLLcmL8Gccp8w+cfvCu3z4gYVTP1m3B4I7fhDb0A6RnRGOELSAq5YlKf8dNU+s0HZDDHhxQl8uxMD/lTnRRH2PNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PiG4DIoi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R7WTo3001413;
	Wed, 27 Mar 2024 08:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iwtRhpO8wrgW9qHdWqjDdEfNp1t9VQXkDDdJdJHLTdA=; b=Pi
	G4DIoi+p7fm60hcnheoY6FVcthteIS2PGajACSVqtyiaDlc9yMNVpYQVbXMRE9Dj
	fM006os4Wv/K7yN+xYYJvWQ5urj388FFJpucGaOdgXVab8NMgMos0tDeFer02L9B
	9i71iIXr5TAsBDrtEFjz6e9dIZI3HHaqlXTk0HNxYzgusOX4gXtjpJr3gLDXomCQ
	b0MCSNGiWsmlSVstdesz702RyPzHhleZ9E1NTM+jP6A4oquqS/RuXcfDfcNdyb2C
	lslZ9MSRqVBa3rPqNs8GxjFGNdIc2NSgnir0VavNlEabaYlVdFqk3K7J5jDwIb97
	3YGY0mMZSrISnLkCVemg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4782s2w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 08:20:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R8KKTm024795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 08:20:20 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Mar 2024 01:20:15 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 2/3] clk: qcom: add IPQ9574 interconnect clocks support
Date: Wed, 27 Mar 2024 13:48:49 +0530
Message-ID: <20240327081850.2924870-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327081850.2924870-1-quic_varada@quicinc.com>
References: <20240327081850.2924870-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 4dd8jql2SBsWlLKk4UI8pc-di5q7XlvS
X-Proofpoint-ORIG-GUID: 4dd8jql2SBsWlLKk4UI8pc-di5q7XlvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270056

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
v4: Use clk_hw instead of indices
    Do icc register in qcom_cc_probe() call stream
    Add icc clock info to qcom_cc_desc structure
v3: Use indexed identifiers here to avoid confusion
    Fix error messages and move to common.c
v2: Move DTS to separate patch
    Update commit log
    Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/common.c      | 34 ++++++++++++++++++++-
 drivers/clk/qcom/common.h      |  4 ++-
 drivers/clk/qcom/gcc-ipq9574.c | 54 ++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)

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
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..523d30d0ccbc 100644
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
 
@@ -234,6 +236,36 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
+static int qcom_cc_icc_register(struct device *dev,
+				const struct qcom_cc_desc *desc)
+{
+#if IS_ENABLED(CONFIG_INTERCONNECT_CLK)
+	struct icc_provider *provider;
+	struct icc_clk_data *icd;
+	int i;
+
+	if (!desc->icc_hws)
+		return 0;
+
+	icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
+	if (!icd)
+		return dev_err_probe(dev, -ENOMEM, "malloc for icc clock data failed\n");
+
+	for (i = 0; i < desc->num_icc_hws; i++) {
+		icd[i].clk = devm_clk_hw_get_clk(dev, desc->icc_hws[i], "");
+		if (IS_ERR_OR_NULL(icd[i].clk))
+			return dev_err_probe(dev, -ENOENT, "icc clock not found\n");
+		icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
+	}
+
+	provider = icc_clk_register(dev, desc->first_id, desc->num_icc_hws, icd);
+	if (IS_ERR_OR_NULL(provider))
+		return dev_err_probe(dev, PTR_ERR(provider),
+				     "icc_clk_register failed\n");
+#endif
+	return 0;
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -303,7 +335,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	return 0;
+	return qcom_cc_icc_register(dev, desc);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..3c3a07f6dcb9 100644
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
@@ -65,5 +68,4 @@ extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);
 extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 				  const struct qcom_cc_desc *desc);
-
 #endif
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..187fd9dcdf49 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -12,6 +12,7 @@
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4302,56 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+#define IPQ_APPS_ID			9574	/* some unique value */
+
+enum {
+	ICC_ANOC_PCIE0,
+	ICC_SNOC_PCIE0,
+	ICC_ANOC_PCIE1,
+	ICC_SNOC_PCIE1,
+	ICC_ANOC_PCIE2,
+	ICC_SNOC_PCIE2,
+	ICC_ANOC_PCIE3,
+	ICC_SNOC_PCIE3,
+	ICC_SNOC_USB,
+	ICC_ANOC_USB_AXI,
+	ICC_NSSNOC_NSSCC,
+	ICC_NSSNOC_SNOC_0,
+	ICC_NSSNOC_SNOC_1,
+	ICC_NSSNOC_PCNOC_1,
+	ICC_NSSNOC_QOSGEN_REF,
+	ICC_NSSNOC_TIMEOUT_REF,
+	ICC_NSSNOC_XO_DCD,
+	ICC_NSSNOC_ATB,
+	ICC_MEM_NOC_NSSNOC,
+	ICC_NSSNOC_MEMNOC,
+	ICC_NSSNOC_MEM_NOC_1,
+};
+
+static struct clk_hw *icc_ipq9574_hws[] = {
+	[ICC_ANOC_PCIE0] = &gcc_anoc_pcie0_1lane_m_clk.clkr.hw,
+	[ICC_SNOC_PCIE0] = &gcc_anoc_pcie1_1lane_m_clk.clkr.hw,
+	[ICC_ANOC_PCIE1] = &gcc_anoc_pcie2_2lane_m_clk.clkr.hw,
+	[ICC_SNOC_PCIE1] = &gcc_anoc_pcie3_2lane_m_clk.clkr.hw,
+	[ICC_ANOC_PCIE2] = &gcc_snoc_pcie0_1lane_s_clk.clkr.hw,
+	[ICC_SNOC_PCIE2] = &gcc_snoc_pcie1_1lane_s_clk.clkr.hw,
+	[ICC_ANOC_PCIE3] = &gcc_snoc_pcie2_2lane_s_clk.clkr.hw,
+	[ICC_SNOC_PCIE3] = &gcc_snoc_pcie3_2lane_s_clk.clkr.hw,
+	[ICC_SNOC_USB] = &gcc_snoc_usb_clk.clkr.hw,
+	[ICC_ANOC_USB_AXI] = &gcc_anoc_usb_axi_clk.clkr.hw,
+	[ICC_NSSNOC_NSSCC] = &gcc_nssnoc_nsscc_clk.clkr.hw,
+	[ICC_NSSNOC_SNOC_0] = &gcc_nssnoc_snoc_clk.clkr.hw,
+	[ICC_NSSNOC_SNOC_1] = &gcc_nssnoc_snoc_1_clk.clkr.hw,
+	[ICC_NSSNOC_PCNOC_1] = &gcc_nssnoc_pcnoc_1_clk.clkr.hw,
+	[ICC_NSSNOC_QOSGEN_REF] = &gcc_nssnoc_qosgen_ref_clk.clkr.hw,
+	[ICC_NSSNOC_TIMEOUT_REF] = &gcc_nssnoc_timeout_ref_clk.clkr.hw,
+	[ICC_NSSNOC_XO_DCD] = &gcc_nssnoc_xo_dcd_clk.clkr.hw,
+	[ICC_NSSNOC_ATB] = &gcc_nssnoc_atb_clk.clkr.hw,
+	[ICC_MEM_NOC_NSSNOC] = &gcc_mem_noc_nssnoc_clk.clkr.hw,
+	[ICC_NSSNOC_MEMNOC] = &gcc_nssnoc_memnoc_clk.clkr.hw,
+	[ICC_NSSNOC_MEM_NOC_1] = &gcc_nssnoc_mem_noc_1_clk.clkr.hw,
+};
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4323,6 +4374,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
 	.clk_hws = gcc_ipq9574_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
+	.icc_hws = icc_ipq9574_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
+	.first_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
-- 
2.34.1


