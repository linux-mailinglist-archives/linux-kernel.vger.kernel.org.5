Return-Path: <linux-kernel+bounces-129595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8EA896CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F31F2F6F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6C1386D2;
	Wed,  3 Apr 2024 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQtKtmSf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742E148301;
	Wed,  3 Apr 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140980; cv=none; b=HW0iE6SwDE90sH6yUy+vmrDpWuJBdAshe0aTwxfhLiXIANo63QMVwIwAUIedq0gmpuQK9noCRwN0Fy+9yskxAvhGAamwMnh7h1wQKc+OIwb6PRUx5pGLZS+mnfec0zWA6I1rIThmIQa5KSjhdOLO+Tr17696YixsApdOIxaRqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140980; c=relaxed/simple;
	bh=7X1JzFacKplkZztj7c11Qy/Q0P0sdl77EcBfY7fuvm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZJd9j8JUEcVKSM0k3/9em2XoqJUdRaq3O3aE+lxFOzB2p/vI4ZHce1yIrIR3jyNgZ2BDkhNiBN84uwLSWMO67jRyWVD0S5Diql8uulq4nteyzU79MR5E12alLwUIt3Mzr1ruYRTYVU1b19IEUD+SdFdb5lRLQnoeYICpDhvZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQtKtmSf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4338git6023162;
	Wed, 3 Apr 2024 10:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ETxTpCrjuZRZwnBobUuBqW7PvZqrTv+YbI1qlBSyhS0=; b=dQ
	tKtmSfXVN5oIftmdzmBjxNw2VlC56AQg9rM0okNoXV4cbYUCBrcUH1pF40MJ8Qum
	9fppx78MwW+gTsQT+SnSIH7ZDSyxrX9qrCDUPxh3LTd1Hbnzmu7Agnq9SQKJ/AY5
	6SHPF1qTidwqhgFV60Eb3vSDJ3NIb+vpJZfZrfGnn7VwZZQTQLDPyHdIwlxBWA+L
	ef9bv1d4p44iwGunZA6Ltmf2fzItUWGNljGDV/VKx4tGmsXr8Z8PlsmQWyGpg9fn
	plIKpzRdNGdlfksl0M4WdCMHewUVRb59EaYED7ieByADuZOGDjmB2rxq+tCyQPWi
	CDUc+nRN05IGm3zsQVNQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93u588rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:42:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433AgsHF027624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:42:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:42:49 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
Date: Wed, 3 Apr 2024 16:12:19 +0530
Message-ID: <20240403104220.1092431-5-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: aw9NgEFAa-JBA1PfB98VeUgwqaExuMQo
X-Proofpoint-ORIG-GUID: aw9NgEFAa-JBA1PfB98VeUgwqaExuMQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030074

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v7: Auto select INTERCONNECT & INTERCONNECT_CLK in COMMON_CLK_QCOM
    to address build break with random config build test, with the
    following combination

	CONFIG_COMMON_CLK_QCOM=y
		and
	CONFIG_INTERCONNECT_CLK=m

    the following error is seen as devm_icc_clk_register is in a
    module and being referenced from vmlinux.

	powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
	>> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'

v6: Move enum to dt-bindings and share between here and DT
    first_id -> icc_first_node_id
v5: Split from common.c changes into separate patch
    No functional changes
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index b0e0eeb1604e..e51328bbd146 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -17,6 +17,8 @@ menuconfig COMMON_CLK_QCOM
 	select RATIONAL
 	select REGMAP_MMIO
 	select RESET_CONTROLLER
+	select INTERCONNECT
+	select INTERCONNECT_CLK
 
 if COMMON_CLK_QCOM
 
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 43da03e4c2dd..0ede625777c9 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -12,6 +12,7 @@
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4067,6 +4068,32 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+#define IPQ_APPS_ID			9574	/* some unique value */
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
@@ -4089,6 +4116,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
 	.clk_hws = gcc_ipq9574_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
+	.icc_hws = icc_ipq9574_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
-- 
2.34.1


