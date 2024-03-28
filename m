Return-Path: <linux-kernel+bounces-122557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CF88F96F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13821C2BD11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511854776;
	Thu, 28 Mar 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oVuhAMsg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4564CF3;
	Thu, 28 Mar 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612876; cv=none; b=UcvH+j+7lG8Q4Z0ZEo0OCIP3f2QfQTJtHozVSblQjOkj9B7ZTn0oSc2tkQcyy2d4xkyAMMpW/g3aZDqqL0fzxAo7/LNKp8HthbeYVmL1jctKm5F0eAHnFIJjZ6qihpOiGhkTmWVHFofa1G/3MsDczJpYGwfNwRsiyeLA0125lbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612876; c=relaxed/simple;
	bh=zGhU2iK5kYU3pEKw7AzFJkONgxMu3LC/ralOMZm5Bfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1oZ2Xa07r9cMFeB5Sq5P/pqklsLxPc1kL5av4HJVCyWQEvYEPy26XURu0ECe/EUDXOCc9oBq1wabKI+uypTV8JsT70ukxgJmOVuGPeFcn5gVBzHlP25X/37Y4x1XyhNZy1yuEmxR5wbVuNIxQXw1AUZgnrjl/zU3FBfaKNVoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oVuhAMsg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S3kPCU022059;
	Thu, 28 Mar 2024 08:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=4iZyAboJoN0NbBDVbCmVMbZBvrNfJWhHU2ksVrEN4+k=; b=oV
	uhAMsgX9S+DPn9SXqF79/7fu+z3KThQ83ut7SFobJcabamIphrdG+NC/aUzp9/mV
	Y8oL+lMCi4AWC1uyFnaM6c4TGel2QNlzrfJQjJOavc4eIEg5J6Udnp0jJNSeQVA5
	oQdGtLqt1qMHvn48f2qGIoLY1PEGX+k6xlVXb/goyyP3yZ/tsWIOnYp9rIxVN0nQ
	q8Lmwlunqk2BPD0DryDLE3Wo8A191tKGiVWog63DPliBQggE+eyRb2OnKqEaoLdt
	fHXbgKz/lpfVlRxA1GtNSxn1XZY3ZHNoV0aU6KzbNYhKMZFxtKV7A8ctrosOJbpd
	dNSUCNJFYTay7nDFSHnA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u212fqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S81Aiw032581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:10 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 01:01:05 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
Date: Thu, 28 Mar 2024 13:29:35 +0530
Message-ID: <20240328075936.223461-5-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RDxh2ugGPs02X5DAv1DuWgfTkHcPp9VG
X-Proofpoint-GUID: RDxh2ugGPs02X5DAv1DuWgfTkHcPp9VG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280052

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Split from common.c changes into separate patch
    No functional changes
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c | 54 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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


