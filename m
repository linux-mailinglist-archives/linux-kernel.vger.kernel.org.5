Return-Path: <linux-kernel+bounces-127742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC120895049
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34D51C22B67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE37828B;
	Tue,  2 Apr 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WotAlpp3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEB762EB;
	Tue,  2 Apr 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054077; cv=none; b=glq5/vZQ31iITK6RdAcG61yUpgu3w5nkVg0camwZof5U1WYMLopXleiXsAEqX0DZNV7avCeIvkiXmM4m1l2iJxFSxQg5zzhnfuFj5hrlrQDb3lWZGyz4wYFIPLfrt7VV4RfBipQczfoUa1wiH/pmUntwoPSDQleWp90jSC44jR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054077; c=relaxed/simple;
	bh=9W5yXmNP7RN0YDEaOnAqtXDqESh/DQbRqD3la8UsGLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUSSZlB3nAHyyd9TfN1sYmXpZQ4UQ9L+YSTHDEIlaA+HSIm9pIMPNO8OomcTURXqNkpYw+LtzIKNRwDuVhGJhSUMBHsLeLoF5pzIfdK+NK6hJyuGhjzN6bmWxdmgotHlTUP105Kd9iERSZ3F1aAzAMhWEzscTrEeKuLXO0NI6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WotAlpp3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432AXkVS012365;
	Tue, 2 Apr 2024 10:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=KKVLEPnJvIznfpi1YM59rxoCg/4dR7PZpPDKjrNgMsY=; b=Wo
	tAlpp3q+vQbMXf8lmUCDCE7s9t/CNYXvSWTBSasm0lfc5V2xYQEFOdThINdFR9sr
	5eSqryjs+q2ExfQ/IYAiRkEVJVtloiauKFfT3mFYdroZSuui+KBA3GP6p2bquln6
	luCeLFf1VMi5xGv5rw1WBE4JWDna2hJZ15U55ycsQsD8OQ3t04zr75vWaeIvBMYn
	OXyIwZlDQUc7tYnXzdkXs1bFCSVOEPG6lMpmC1ugrJv/zehcNFCKb6PpeUYDjGyz
	6Riv5cZABPAgHDedF/jAeyJdjrBTJjs/y/N1IpoL2AO5OIVOiKUW+8juizKErE/2
	dMJ5N3iRD9NeMey/LL6Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x893ts0nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:34:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432AYUba012955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:34:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 03:34:25 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_varada@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v6 1/6] dt-bindings: interconnect: Add Qualcomm IPQ9574 support
Date: Tue, 2 Apr 2024 16:04:01 +0530
Message-ID: <20240402103406.3638821-2-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: aOCI7XKsU3cm437dwClUDrTzh0jPn9F8
X-Proofpoint-ORIG-GUID: aOCI7XKsU3cm437dwClUDrTzh0jPn9F8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020076

Add interconnect-cells to clock provider so that it can be
used as icc provider.

Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
interfaces. This will be used by the gcc-ipq9574 driver
that will for providing interconnect services using the
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6:
Removed Reviewed-by: Krzysztof Kozlowski
Redefine the bindings such that driver and DT can share them

v3:
Squash Documentation/ and include/ changes into same patch

qcom,ipq9574.h
	Move 'first id' to clock driver

---
 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 ++
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 36 +++++++++++++++++++
 2 files changed, 39 insertions(+)
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
index 000000000000..988124c39810
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
@@ -0,0 +1,36 @@
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
+#define MASTER(x)	((ICC_ ## x) * 2)
+#define SLAVE(x)	(MASTER(x) + 1)
+
+#endif /* INTERCONNECT_QCOM_IPQ9574_H */
-- 
2.34.1


