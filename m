Return-Path: <linux-kernel+bounces-129592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405A896CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29E81F2F3A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489CF146D54;
	Wed,  3 Apr 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mvLN6ALA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428A146A66;
	Wed,  3 Apr 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140968; cv=none; b=MLWTDslNEuBnXviHr2iYq5G2+FM8gINMmRC5oa6rufDP86fTkpe0nRsbgvPykLIVAns/d9Ef4a/N+i1Sej+JvvP5q9r7BVI9KMViPqTAoYqU1f0s2VsJaCIVnFox3YPKWHHDszlTkiZ7fGOoRb6nFF9/kHhaAymQfLfAT4w4p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140968; c=relaxed/simple;
	bh=9vXJ4fMeH0AJi/6pIEb+FRuf/sH04bxlgCiMuQgM2bg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceIE9/XcqBGXRZI1/ZWFK49oPGrqFvh8I0T8g/P1YxCH3I0XqtHdvI2P5otLLMVGFv9PNIKmvuZ37gkj3CT2MnF79hEREShcOBV4uj3XkxKGfRIjEYtjzV1a9RO9ndrktkMB6YNKlKR02dRDNaFwcguA74EKslWMovS9M5yY6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mvLN6ALA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4338ZHfd024056;
	Wed, 3 Apr 2024 10:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jbvF0MCF2C2Mmz2NYz7f1XlDBB86x7DW2vnn7XlwIfk=; b=mv
	LN6ALAVMh1lw7kRXMlXELF9vA6862eV13uiOSpgbPioejgv7zGoyISGpPp7RndLb
	Bzhz4MTyJLxl4+6+lE7XIbRHUwLkHTz2xbM5ajbyuX+0YKbzs3cYqyKMeLCT17o9
	qKwLKQNdgtm4UgYe324w0y4bspl/AAzgIjCo1yeoK3V08kb6BIVYI9EVMlGzOIHC
	MGtCa+JX0xq8w5Qrseyj0NfnSMV+guqvgxA2LXxHu1SHkngjlOExgtEHrKuRgIAp
	oKAvsWnPe9ACEOHUxrbM7oGqqzX/RA3pBUdrmEOZxMHqbox4H5SIMcW0hwrZ3Ayb
	H02kn9J9IIVgWbusYohQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9377rb9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:42:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433AgeYo027472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:42:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:42:36 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: interconnect: Add Qualcomm IPQ9574 support
Date: Wed, 3 Apr 2024 16:12:16 +0530
Message-ID: <20240403104220.1092431-2-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: g3AfaEDS0rL7jAjVcPdQ0zLAKpPoxMts
X-Proofpoint-ORIG-GUID: g3AfaEDS0rL7jAjVcPdQ0zLAKpPoxMts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030074

Add interconnect-cells to clock provider so that it can be
used as icc provider.

Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
interfaces. This will be used by the gcc-ipq9574 driver
that will for providing interconnect services using the
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v7:
Fix macro names to be consistent with other bindings
v6:
Removed Reviewed-by: Krzysztof Kozlowski
Redefine the bindings such that driver and DT can share them

v3:
Squash Documentation/ and include/ changes into same patch

qcom,ipq9574.h
	Move 'first id' to clock driver

---
 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 87 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
index 944a0ea79cd6..824781cbdf34 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
@@ -33,6 +33,9 @@ properties:
       - description: PCIE30 PHY3 pipe clock source
       - description: USB3 PHY pipe clock source
 
+  '#interconnect-cells':
+    const: 1
+
 required:
   - compatible
   - clocks
diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
new file mode 100644
index 000000000000..0b076b0cf880
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ9574_H
+#define INTERCONNECT_QCOM_IPQ9574_H
+
+#define ICC_ANOC_PCIE0		0
+#define ICC_SNOC_PCIE0		1
+#define ICC_ANOC_PCIE1		2
+#define ICC_SNOC_PCIE1		3
+#define ICC_ANOC_PCIE2		4
+#define ICC_SNOC_PCIE2		5
+#define ICC_ANOC_PCIE3		6
+#define ICC_SNOC_PCIE3		7
+#define ICC_SNOC_USB		8
+#define ICC_ANOC_USB_AXI	9
+#define ICC_NSSNOC_NSSCC	10
+#define ICC_NSSNOC_SNOC_0	11
+#define ICC_NSSNOC_SNOC_1	12
+#define ICC_NSSNOC_PCNOC_1	13
+#define ICC_NSSNOC_QOSGEN_REF	14
+#define ICC_NSSNOC_TIMEOUT_REF	15
+#define ICC_NSSNOC_XO_DCD	16
+#define ICC_NSSNOC_ATB		17
+#define ICC_MEM_NOC_NSSNOC	18
+#define ICC_NSSNOC_MEMNOC	19
+#define ICC_NSSNOC_MEM_NOC_1	20
+
+#define ICC_NSSNOC_PPE		0
+#define ICC_NSSNOC_PPE_CFG	1
+#define ICC_NSSNOC_NSS_CSR	2
+#define ICC_NSSNOC_IMEM_QSB	3
+#define ICC_NSSNOC_IMEM_AHB	4
+
+#define MASTER_ANOC_PCIE0		(ICC_ANOC_PCIE0 * 2)
+#define SLAVE_ANOC_PCIE0		((ICC_ANOC_PCIE0 * 2) + 1)
+#define MASTER_SNOC_PCIE0		(ICC_SNOC_PCIE0 * 2)
+#define SLAVE_SNOC_PCIE0		((ICC_SNOC_PCIE0 * 2) + 1)
+#define MASTER_ANOC_PCIE1		(ICC_ANOC_PCIE1 * 2)
+#define SLAVE_ANOC_PCIE1		((ICC_ANOC_PCIE1 * 2) + 1)
+#define MASTER_SNOC_PCIE1		(ICC_SNOC_PCIE1 * 2)
+#define SLAVE_SNOC_PCIE1		((ICC_SNOC_PCIE1 * 2) + 1)
+#define MASTER_ANOC_PCIE2		(ICC_ANOC_PCIE2 * 2)
+#define SLAVE_ANOC_PCIE2		((ICC_ANOC_PCIE2 * 2) + 1)
+#define MASTER_SNOC_PCIE2		(ICC_SNOC_PCIE2 * 2)
+#define SLAVE_SNOC_PCIE2		((ICC_SNOC_PCIE2 * 2) + 1)
+#define MASTER_ANOC_PCIE3		(ICC_ANOC_PCIE3 * 2)
+#define SLAVE_ANOC_PCIE3		((ICC_ANOC_PCIE3 * 2) + 1)
+#define MASTER_SNOC_PCIE3		(ICC_SNOC_PCIE3 * 2)
+#define SLAVE_SNOC_PCIE3		((ICC_SNOC_PCIE3 * 2) + 1)
+#define MASTER_USB			(ICC_USB * 2)
+#define SLAVE_USB			((ICC_USB * 2) + 1)
+#define MASTER_USB_AXI			(ICC_USB_AXI * 2)
+#define SLAVE_USB_AXI			((ICC_USB_AXI * 2) + 1)
+#define MASTER_NSSNOC_NSSCC		(ICC_NSSNOC_NSSCC * 2)
+#define SLAVE_NSSNOC_NSSCC		((ICC_NSSNOC_NSSCC * 2) + 1)
+#define MASTER_NSSNOC_SNOC_0		(ICC_NSSNOC_SNOC_0 * 2)
+#define SLAVE_NSSNOC_SNOC_0		((ICC_NSSNOC_SNOC_0 * 2) + 1)
+#define MASTER_NSSNOC_SNOC_1		(ICC_NSSNOC_SNOC_1 * 2)
+#define SLAVE_NSSNOC_SNOC_1		((ICC_NSSNOC_SNOC_1 * 2) + 1)
+#define MASTER_NSSNOC_PCNOC_1		(ICC_NSSNOC_PCNOC_1 * 2)
+#define SLAVE_NSSNOC_PCNOC_1		((ICC_NSSNOC_PCNOC_1 * 2) + 1)
+#define MASTER_NSSNOC_QOSGEN_REF	(ICC_NSSNOC_QOSGEN_REF * 2)
+#define SLAVE_NSSNOC_QOSGEN_REF		((ICC_NSSNOC_QOSGEN_REF * 2) + 1)
+#define MASTER_NSSNOC_TIMEOUT_REF	(ICC_NSSNOC_TIMEOUT_REF * 2)
+#define SLAVE_NSSNOC_TIMEOUT_REF	((ICC_NSSNOC_TIMEOUT_REF * 2) + 1)
+#define MASTER_NSSNOC_XO_DCD		(ICC_NSSNOC_XO_DCD * 2)
+#define SLAVE_NSSNOC_XO_DCD		((ICC_NSSNOC_XO_DCD * 2) + 1)
+#define MASTER_NSSNOC_ATB		(ICC_NSSNOC_ATB * 2)
+#define SLAVE_NSSNOC_ATB		((ICC_NSSNOC_ATB * 2) + 1)
+#define MASTER_MEM_NOC_NSSNOC		(ICC_MEM_NOC_NSSNOC * 2)
+#define SLAVE_MEM_NOC_NSSNOC		((ICC_MEM_NOC_NSSNOC * 2) + 1)
+#define MASTER_NSSNOC_MEMNOC		(ICC_NSSNOC_MEMNOC * 2)
+#define SLAVE_NSSNOC_MEMNOC		((ICC_NSSNOC_MEMNOC * 2) + 1)
+#define MASTER_NSSNOC_MEM_NOC_1		(ICC_NSSNOC_MEM_NOC_1 * 2)
+#define SLAVE_NSSNOC_MEM_NOC_1		((ICC_NSSNOC_MEM_NOC_1 * 2) + 1)
+
+#define MASTER_NSSNOC_PPE		(ICC_NSSNOC_PPE * 2)
+#define SLAVE_NSSNOC_PPE		((ICC_NSSNOC_PPE * 2) + 1)
+#define MASTER_NSSNOC_PPE_CFG		(ICC_NSSNOC_PPE_CFG * 2)
+#define SLAVE_NSSNOC_PPE_CFG		((ICC_NSSNOC_PPE_CFG * 2) + 1)
+#define MASTER_NSSNOC_NSS_CSR		(ICC_NSSNOC_NSS_CSR * 2)
+#define SLAVE_NSSNOC_NSS_CSR		((ICC_NSSNOC_NSS_CSR * 2) + 1)
+#define MASTER_NSSNOC_IMEM_QSB		(ICC_NSSNOC_IMEM_QSB * 2)
+#define SLAVE_NSSNOC_IMEM_QSB		((ICC_NSSNOC_IMEM_QSB * 2) + 1)
+#define MASTER_NSSNOC_IMEM_AHB		(ICC_NSSNOC_IMEM_AHB * 2)
+#define SLAVE_NSSNOC_IMEM_AHB		((ICC_NSSNOC_IMEM_AHB * 2) + 1)
+
+#endif /* INTERCONNECT_QCOM_IPQ9574_H */
-- 
2.34.1


