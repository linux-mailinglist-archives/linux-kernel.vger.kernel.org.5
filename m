Return-Path: <linux-kernel+bounces-116823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA4788A437
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AAE1F3E53C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD7190662;
	Mon, 25 Mar 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K0EQt+RU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40643127B7E;
	Mon, 25 Mar 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362074; cv=none; b=gv7tQx2saNDM6qF3jdtkQoToPSO0pUcP5oOjkjUZbqbbkVK8fEwgAYZLlZYO04xwtTUd/bdNqOPcUy7hmgvpDTjmRvJfXVYq+t+6H0NQIB+0Hycxjp3IzRKq4ad8jFIQ79Roj5kc/UX0juG9MJY+e9jhKUem9I7nACKYJ9l/bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362074; c=relaxed/simple;
	bh=EwBLJCRuDGnlb+1kReoiUAmfLwH1mveI1PPI8tZxDrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMOdOGh4B8q6rm47KHWpF/6I9FPQc8rN/VaTBX+2ACWvTmNlZFIThMjdcJr2gokUNGpWppWYE0yn5+FxsxOxX4RqaLcqbqkmA6hUxtGKusAwFQsJAiAbEYlzo0J3XQnJ2e7Ksgd43hxZL4zY2TW2fRwkw9s++ffVmb8j0YYeliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K0EQt+RU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P7lle1013943;
	Mon, 25 Mar 2024 10:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yZGRdb7p7HB+Eimrbvr8cAQ+jjUiNF6N9K1yRSiH7Hc=; b=K0
	EQt+RUucnmY0CbGhBc6PUzgQfjK31h2dVjex11MHPb8ayIookcjRwjpyQVrHmHMr
	WEGVTL0y0AIqjBsfxQAGdo90VY9BnfK14SY4m3kIkByRQ8dtJHNcMNLltUPuWrWe
	6O5T8iNss0mzdZcfSxre1KjVQC1ZwNUNc9+szEZLiXOG4eDhekWxtSLOVxEY4KMB
	VPovpiP84CvI3o/Uo24XUieKC2tNq6TbThmC6PTkRz1lqg+vHWHcecxsUlEdiZtQ
	qNTwxIc2m6iuOFg9CoMQXpkaN00poXN8qOzHjqD5HfIkSa5fdlPsaoaUEjxNrOmS
	mBRmN3rLNomWeicjYY4A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hp0dp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:21:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PAL6Qo031100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:21:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 03:21:01 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 2/4] dt-bindings: interconnect: Add Qualcomm IPQ9574 support
Date: Mon, 25 Mar 2024 15:50:34 +0530
Message-ID: <20240325102036.95484-3-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CXU0qLzj7DS01JnL5I7EpHHaGe7nNEep
X-Proofpoint-GUID: CXU0qLzj7DS01JnL5I7EpHHaGe7nNEep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250057

Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
interfaces. This will be used by the gcc-ipq9574 driver
that will for providing interconnect services using the
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Rename master slave macros
    Fix license identifier
---
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
new file mode 100644
index 000000000000..b7b32aa6bbb1
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ9574_H
+#define INTERCONNECT_QCOM_IPQ9574_H
+
+#define IPQ_APPS_ID			9574	/* some unique value */
+#define IPQ_NSS_ID			(IPQ_APPS_ID * 2)
+
+#define MASTER_ANOC_PCIE0_1		0
+#define SLAVE_ANOC_PCIE0_1		1
+#define MASTER_SNOC_PCIE0_1		2
+#define SLAVE_SNOC_PCIE0_1		3
+#define MASTER_ANOC_PCIE1_1		4
+#define SLAVE_ANOC_PCIE1_1		5
+#define MASTER_SNOC_PCIE1_1		6
+#define SLAVE_SNOC_PCIE1_1		7
+#define MASTER_ANOC_PCIE2_2		8
+#define SLAVE_ANOC_PCIE2_2		9
+#define MASTER_SNOC_PCIE2_2		10
+#define SLAVE_SNOC_PCIE2_2		11
+#define MASTER_ANOC_PCIE3_2		12
+#define SLAVE_ANOC_PCIE3_2		13
+#define MASTER_SNOC_PCIE3_2		14
+#define SLAVE_SNOC_PCIE3_2		15
+#define MASTER_USB			16
+#define SLAVE_USB			17
+#define MASTER_USB_AXI			18
+#define SLAVE_USB_AXI			19
+#define MASTER_NSSNOC_NSSCC		20
+#define SLAVE_NSSNOC_NSSCC		21
+#define MASTER_NSSNOC_SNOC		22
+#define SLAVE_NSSNOC_SNOC		23
+#define MASTER_NSSNOC_SNOC_1		24
+#define SLAVE_NSSNOC_SNOC_1		25
+#define MASTER_NSSNOC_PCNOC_1		26
+#define SLAVE_NSSNOC_PCNOC_1		27
+#define MASTER_NSSNOC_QOSGEN_REF	28
+#define SLAVE_NSSNOC_QOSGEN_REF		29
+#define MASTER_NSSNOC_TIMEOUT_REF	30
+#define SLAVE_NSSNOC_TIMEOUT_REF	31
+#define MASTER_NSSNOC_XO_DCD		32
+#define SLAVE_NSSNOC_XO_DCD		33
+#define MASTER_NSSNOC_ATB		34
+#define SLAVE_NSSNOC_ATB		35
+#define MASTER_MEM_NOC_NSSNOC		36
+#define SLAVE_MEM_NOC_NSSNOC		37
+#define MASTER_NSSNOC_MEMNOC		38
+#define SLAVE_NSSNOC_MEMNOC		39
+#define MASTER_NSSNOC_MEM_NOC_1		40
+#define SLAVE_NSSNOC_MEM_NOC_1		41
+
+#define MASTER_NSS_CC_NSSNOC_PPE	0
+#define SLAVE_NSS_CC_NSSNOC_PPE		1
+#define MASTER_NSS_CC_NSSNOC_PPE_CFG	2
+#define SLAVE_NSS_CC_NSSNOC_PPE_CFG	3
+#define MASTER_NSS_CC_NSSNOC_NSS_CSR	4
+#define SLAVE_NSS_CC_NSSNOC_NSS_CSR	5
+#define MASTER_NSS_CC_NSSNOC_IMEM_QSB	6
+#define SLAVE_NSS_CC_NSSNOC_IMEM_QSB	7
+#define MASTER_NSS_CC_NSSNOC_IMEM_AHB	8
+#define SLAVE_NSS_CC_NSSNOC_IMEM_AHB	9
+
+#endif /* INTERCONNECT_QCOM_IPQ9574_H */
-- 
2.34.1


