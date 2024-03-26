Return-Path: <linux-kernel+bounces-118948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0488C1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C598F2E4237
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78F74BE5;
	Tue, 26 Mar 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ACTVaFWD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB273179;
	Tue, 26 Mar 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455245; cv=none; b=H+N1EgDM0xkIaGBahiaBZOPLahwasd5kiSvStHIM7uq0uC5As2clxa8uzzlMFGt8FVPV3a4UX0oxc2teJjUOaIJ2Tha8eoUvXotpRIh4Q0iXVPIQbirgX3p/oxJA2Wo22p0CcsLcCf6QVT+gdgUaAhPa8QrbnG0xpVmAtSjExQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455245; c=relaxed/simple;
	bh=MczzhMT3beYrggDjREwDfVCMjsjPiJTSENy678yjNY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFKRIC8xg6HeMNPXMqS1AIAkQsVV/ptd15jNiNR3JZQQMcWz3cnsfIpQ5E8W1BBS3eWfk9iF7Xw8DFys1e1VxA2h+8xbNUA4+h6khoAdArbCZC1JpGSBTOZPkuECA1h9BrIuOh+Kx+cB8xBk+CNfvOotOo/I+iflbGs+yl0ePaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ACTVaFWD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q8TQxJ012411;
	Tue, 26 Mar 2024 12:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jCtsJs18DU7rXK8fKx/m60mAK3BO2XW2WLD75aZb36s=; b=AC
	TVaFWDpEh0iTNgxK73FYqfdMBovelekHNfaiC83D4iGxY9PByqA6HJ5Cvlx9Go2Y
	cg5qJ6//OLmL9vVj8QatkgyelGcovqM1ExME7mPkDhOuFFp2XIPsAbEI3kz1yOgc
	IWYSRtkSP+TbL/Di1fS9K9RWCWccIDMCm5rfB7GI9kk9IhDSu8c4PY6f972iLg5G
	0dCpndIkLPJKUh+KhcOShpU1KFNht3EbLXk9AIS4QWb8AnKEN94mIgYceGGWlOnl
	hJY3aLz4whEyJKXZjcxCwCV/1ZPmGdgEGZ1EJpx0wt6ds+PRI3UwpavcCDIgIh9o
	M5fjV831v//jWp64vECA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3tvy8mm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:13:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QCDwDE008964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:13:58 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 05:13:54 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 1/3] dt-bindings: interconnect: Add Qualcomm IPQ9574 support
Date: Tue, 26 Mar 2024 17:43:10 +0530
Message-ID: <20240326121312.1702701-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326121312.1702701-1-quic_varada@quicinc.com>
References: <20240326121312.1702701-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 0H6AJW-_EB7Ze5RhjGz2klBEjf-Hq1C6
X-Proofpoint-ORIG-GUID: 0H6AJW-_EB7Ze5RhjGz2klBEjf-Hq1C6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260085

Add interconnect-cells to clock provider so that it can be
used as icc provider.

Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
interfaces. This will be used by the gcc-ipq9574 driver
that will for providing interconnect services using the
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3:
Squash Documentation/ and include/ changes into same patch

qcom,ipq9574.h
	Move 'first id' to clock driver

---
 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
 2 files changed, 62 insertions(+)
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
index 000000000000..9c95fbd5dc46
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ9574_H
+#define INTERCONNECT_QCOM_IPQ9574_H
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


