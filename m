Return-Path: <linux-kernel+bounces-163424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29CB8B6AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509331F219B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1158E2C18D;
	Tue, 30 Apr 2024 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bt41vtYq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498D4502F;
	Tue, 30 Apr 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459387; cv=none; b=gi9ixXqTkiBY1LKnjsaMeWM2WNPyYmP9qJJtxes3KLLEOR5E8iwCeYCs1k6DkeV6icTVQhDfl5MOX4knA/SlNDPCb1ekbAgo5IXfJbk/VMDn1OVtVkq5U6rB9zF7KyL8JpekMe/KoVBdySsAVhxxTVIn2kUvaV00QhexBOj4PCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459387; c=relaxed/simple;
	bh=Ea+yh5bJhWlo9fqGNBe+88nv1kD1Kgiy3gI5uuVoKfs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYDm9TE+ivMwSQw8+A9tz9wCZHAU5nUf5Sdz2FtuRV4LrKXgj/JCaXXUgJj3z4Gr4lCMPo5Cvb3DCgEEX5Qk+MkmdMP5TE/DoSQHvZJzg5a00L5HscvvB1a1jliLD1j9jH/mdl50eVG8EQQYutpTGDHOt0lN6jkYA67Ee+yz4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bt41vtYq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U56tLZ022706;
	Tue, 30 Apr 2024 06:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=oXCXc5jcKH/SXCjOInAxbrpKvEvMjBOoRoN08k/C1Hk=; b=bt
	41vtYqHNxfjjOPGHK8eqdBSX9hcdoKvemup7QOOUko6cgqWSAoNkubk9mGRurypY
	+HE+r4qlyX7Xsj0nH9DIByIyrBs+HPhziYmm78Bex8RcqV+z3eR12lDLGUW/D1GF
	vFWi3/Yu7rdPTMSVOaQDSHvJO9HsnDf1JRkv3LC7/WDvBF8ZOOldGqrd3wDIZYEg
	etBVb7G180F9ttxIEyoi2tBx3EE8RCLeMMDx1kmU4klsz9fdt0Uidu6yNPZOovXi
	LegLcdduXvqBzSrJw8/RawCxsPQtJVZ8NLySlZ0Qb6T3FugvjkQnWVLmFYBQfX97
	K30xgkwyYdpjjVUwzBLw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvt2m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:43:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6h0Jj020601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:43:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:42:55 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bryan.odonoghue@linaro.org>
Subject: [PATCH v11 5/6] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
Date: Tue, 30 Apr 2024 12:12:13 +0530
Message-ID: <20240430064214.2030013-6-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: k2T-Xapd4OCOnwiou5OPMEmwiyG6KpgI
X-Proofpoint-GUID: k2T-Xapd4OCOnwiou5OPMEmwiyG6KpgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300047

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v10: Set gcc-ipq9574 driver's sync_state to icc_sync_state
v9: Remove HWS_DATA macro
v8: Bind clock and interconnect using master and slave ids
    Use indices instead of clock pointers
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
 drivers/clk/qcom/gcc-ipq9574.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1bb51a058872..92e2d0293eec 100644
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
index 0a3f846695b8..3738f92c6f9c 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -12,6 +14,7 @@
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4304,32 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+#define IPQ_APPS_ID			9574	/* some unique value */
+
+static struct qcom_icc_hws_data icc_ipq9574_hws[] = {
+	{ MASTER_ANOC_PCIE0, SLAVE_ANOC_PCIE0, GCC_ANOC_PCIE0_1LANE_M_CLK },
+	{ MASTER_SNOC_PCIE0, SLAVE_SNOC_PCIE0, GCC_SNOC_PCIE0_1LANE_S_CLK },
+	{ MASTER_ANOC_PCIE1, SLAVE_ANOC_PCIE1, GCC_ANOC_PCIE1_1LANE_M_CLK },
+	{ MASTER_SNOC_PCIE1, SLAVE_SNOC_PCIE1, GCC_SNOC_PCIE1_1LANE_S_CLK },
+	{ MASTER_ANOC_PCIE2, SLAVE_ANOC_PCIE2, GCC_ANOC_PCIE2_2LANE_M_CLK },
+	{ MASTER_SNOC_PCIE2, SLAVE_SNOC_PCIE2, GCC_SNOC_PCIE2_2LANE_S_CLK },
+	{ MASTER_ANOC_PCIE3, SLAVE_ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK },
+	{ MASTER_SNOC_PCIE3, SLAVE_SNOC_PCIE3, GCC_SNOC_PCIE3_2LANE_S_CLK },
+	{ MASTER_USB, SLAVE_USB, GCC_SNOC_USB_CLK },
+	{ MASTER_USB_AXI, SLAVE_USB_AXI, GCC_ANOC_USB_AXI_CLK },
+	{ MASTER_NSSNOC_NSSCC, SLAVE_NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK },
+	{ MASTER_NSSNOC_SNOC_0, SLAVE_NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK },
+	{ MASTER_NSSNOC_SNOC_1, SLAVE_NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK },
+	{ MASTER_NSSNOC_PCNOC_1, SLAVE_NSSNOC_PCNOC_1, GCC_NSSNOC_PCNOC_1_CLK },
+	{ MASTER_NSSNOC_QOSGEN_REF, SLAVE_NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK },
+	{ MASTER_NSSNOC_TIMEOUT_REF, SLAVE_NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK },
+	{ MASTER_NSSNOC_XO_DCD, SLAVE_NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK },
+	{ MASTER_NSSNOC_ATB, SLAVE_NSSNOC_ATB, GCC_NSSNOC_ATB_CLK },
+	{ MASTER_MEM_NOC_NSSNOC, SLAVE_MEM_NOC_NSSNOC, GCC_MEM_NOC_NSSNOC_CLK },
+	{ MASTER_NSSNOC_MEMNOC, SLAVE_NSSNOC_MEMNOC, GCC_NSSNOC_MEMNOC_CLK },
+	{ MASTER_NSSNOC_MEM_NOC_1, SLAVE_NSSNOC_MEM_NOC_1, GCC_NSSNOC_MEM_NOC_1_CLK },
+};
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4323,6 +4352,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
 	.clk_hws = gcc_ipq9574_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
+	.icc_hws = icc_ipq9574_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
@@ -4335,6 +4367,7 @@ static struct platform_driver gcc_ipq9574_driver = {
 	.driver = {
 		.name   = "qcom,gcc-ipq9574",
 		.of_match_table = gcc_ipq9574_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1


