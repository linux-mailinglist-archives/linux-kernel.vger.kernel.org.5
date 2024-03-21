Return-Path: <linux-kernel+bounces-109648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF3881BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E12B21CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF13A1D3;
	Thu, 21 Mar 2024 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VR1Q4uZ0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EEE383AA;
	Thu, 21 Mar 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995565; cv=none; b=gPAwtcNs1/z1mUj6a+5tgeqFAnycrXsoppa1Ek3zSbmoYKn8m45aJ2CJsKoSx8gxED9HcdhLTDoys/0d8l7HXlq4wN+APOFdCNsq0lGbV5UCw+SqfT2n4404qV0VuL3I1UbUS+i6zb8x5GrhkbJnU8BjMfrt70W80qjdJBhr0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995565; c=relaxed/simple;
	bh=mHeLjAhiOYUQn58WVbnhc+GFUkjMepFcOi6zO3KCzeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzcvaxK26eU10OafdBSvYgif0kSNPam+vU8mLff+gw6wx4tCP0+h+cQJC/uVmf0FQJDQirVi01dZnOKgxFi6vp0HJa6bEqUik8VvTRkyWLCBeY1GbnyJMNql7tpZ6lBS2+Ez7zwfmDeXZVZo8syucbrkNGfSrN5gK/79KbuWSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VR1Q4uZ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L3kXwJ028074;
	Thu, 21 Mar 2024 04:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1ULtc50BTgzlYCoZ1BSWEUzWp64OGXyHwQThNlSiSY0=; b=VR
	1Q4uZ0AHu6t99mu54Kk0s8ZzpUVrNdhUbpk+yDbzKSzPArhjdktAewsvf4tiWTiQ
	4YL4ufKCWueHslekvBpzT9npGoKGD35R7e9S5tVCZJxVUbvzfiSLjPXhlRzfe0qd
	WIOxeOvDuFiGSX6zRmHFE4tZmhsAOreVOOPuV6E0kiv5vJGvcdHJ8PjKRmDCIDzQ
	Hsk2HJxKebG9xMHF4k6SKR43XDyLRiQ+XbVvMnhcukv01FhZ03zQhJbMCSYaolT6
	lvCZRUoxfJU9EcQ6mDb4IfDAUV5E6eGNAPc3J293qwodM5VpfecHANMmOnsgPGu9
	kpkJBiphWXV8srrBq9Og==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0aah0c88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 04:32:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L4WbOT000951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 04:32:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 21:32:32 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm IPQ9574 support
Date: Thu, 21 Mar 2024 10:01:48 +0530
Message-ID: <20240321043149.2739204-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321043149.2739204-1-quic_varada@quicinc.com>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 5PePL7FHYnx-5i0L6bnhsPgKincKZcHw
X-Proofpoint-ORIG-GUID: 5PePL7FHYnx-5i0L6bnhsPgKincKZcHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210028

Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
interfaces. This will be used by the gcc-ipq9574 driver
that will for providing interconnect services using the
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
new file mode 100644
index 000000000000..96f79a86e8d2
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+#ifndef INTERCONNECT_QCOM_IPQ9574_H
+#define INTERCONNECT_QCOM_IPQ9574_H
+
+#define IPQ_APPS_ID			9574	/* some unique value */
+#define IPQ_NSS_ID			(IPQ_APPS_ID * 2)
+
+#define IPQ_ANOC_PCIE0_1_MAS		0
+#define IPQ_ANOC_PCIE0_1_SLV		1
+#define IPQ_SNOC_PCIE0_1_MAS		2
+#define IPQ_SNOC_PCIE0_1_SLV		3
+#define IPQ_ANOC_PCIE1_1_MAS		4
+#define IPQ_ANOC_PCIE1_1_SLV		5
+#define IPQ_SNOC_PCIE1_1_MAS		6
+#define IPQ_SNOC_PCIE1_1_SLV		7
+#define IPQ_ANOC_PCIE2_2_MAS		8
+#define IPQ_ANOC_PCIE2_2_SLV		9
+#define IPQ_SNOC_PCIE2_2_MAS		10
+#define IPQ_SNOC_PCIE2_2_SLV		11
+#define IPQ_ANOC_PCIE3_2_MAS		12
+#define IPQ_ANOC_PCIE3_2_SLV		13
+#define IPQ_SNOC_PCIE3_2_MAS		14
+#define IPQ_SNOC_PCIE3_2_SLV		15
+#define IPQ_USB_MAS			16
+#define IPQ_USB_SLV			17
+#define IPQ_USB_AXI_MAS			18
+#define IPQ_USB_AXI_SLV			19
+#define IPQ_NSSNOC_NSSCC_MAS		20
+#define IPQ_NSSNOC_NSSCC_SLV		21
+#define IPQ_NSSNOC_SNOC_MAS		22
+#define IPQ_NSSNOC_SNOC_SLV		23
+#define IPQ_NSSNOC_SNOC_1_MAS		24
+#define IPQ_NSSNOC_SNOC_1_SLV		25
+#define IPQ_NSSNOC_PCNOC_1_MAS		26
+#define IPQ_NSSNOC_PCNOC_1_SLV		27
+#define IPQ_NSSNOC_QOSGEN_REF_MAS	28
+#define IPQ_NSSNOC_QOSGEN_REF_SLV	29
+#define IPQ_NSSNOC_TIMEOUT_REF_MAS	30
+#define IPQ_NSSNOC_TIMEOUT_REF_SLV	31
+#define IPQ_NSSNOC_XO_DCD_MAS		32
+#define IPQ_NSSNOC_XO_DCD_SLV		33
+#define IPQ_NSSNOC_ATB_MAS		34
+#define IPQ_NSSNOC_ATB_SLV		35
+#define IPQ_MEM_NOC_NSSNOC_MAS		36
+#define IPQ_MEM_NOC_NSSNOC_SLV		37
+#define IPQ_NSSNOC_MEMNOC_MAS		38
+#define IPQ_NSSNOC_MEMNOC_SLV		39
+#define IPQ_NSSNOC_MEM_NOC_1_MAS	40
+#define IPQ_NSSNOC_MEM_NOC_1_SLV	41
+
+#define IPQ_NSS_CC_NSSNOC_PPE_MAS	0
+#define IPQ_NSS_CC_NSSNOC_PPE_SLV	1
+#define IPQ_NSS_CC_NSSNOC_PPE_CFG_MAS	2
+#define IPQ_NSS_CC_NSSNOC_PPE_CFG_SLV	3
+#define IPQ_NSS_CC_NSSNOC_NSS_CSR_MAS	4
+#define IPQ_NSS_CC_NSSNOC_NSS_CSR_SLV	5
+#define IPQ_NSS_CC_NSSNOC_IMEM_QSB_MAS	6
+#define IPQ_NSS_CC_NSSNOC_IMEM_QSB_SLV	7
+#define IPQ_NSS_CC_NSSNOC_IMEM_AHB_MAS	8
+#define IPQ_NSS_CC_NSSNOC_IMEM_AHB_SLV	9
+
+#endif /* INTERCONNECT_QCOM_IPQ9574_H */
-- 
2.34.1


