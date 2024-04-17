Return-Path: <linux-kernel+bounces-148358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1E8A8167
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57251F21C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F013D25A;
	Wed, 17 Apr 2024 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RgpEjX+s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92413AD25;
	Wed, 17 Apr 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351416; cv=none; b=QiXAq7ml2A5E/+iTdJwwIf7GHIUhv/hHTWHx1wB/W6PB3TkUHr7/nKtHCsfhPR7JdBUBWkQDTcKchxX4fRRH44lTugfiG/SDL/D1eJifbW9FHBFldbSVktVL8xmxd+T1gdx0UIrdozNHiD4JkiXlcfm2hJi/p6WX2PtGU2wiVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351416; c=relaxed/simple;
	bh=oJtfiid9IioNRrugLc5bUVBOYEZmj6gElh2LpdZgvyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc8oE3QHhQXKL63xkOePvapy2qQu2ZBFG8sKAy2BMZoTkUfF9WXiifpNDmsK8L3GI1cipbRK/HCC9YO6cOqopaSeSyERvDTWOfmyPC4ujghmaPNRfdYLFKHCTRfWxtwDT7Ph2nIbvGOO9/6dJ2jSMcJIN9ovaNpuEsJVFYC0Mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RgpEjX+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8u29f014362;
	Wed, 17 Apr 2024 10:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Dez6Zyb+4DE2Om2f/t0vMGrmQF8kSk8Xomnq2/egjB4=; b=Rg
	pEjX+sK8X/u3W4/kud/GJ4Su8obS2LAIEDzrAxc6Gn8FkwrbCgpqkWi7ZLselbMK
	OaPUgh6jKFghUo6a14DZrnG6F0nZtN+tTuVqzJiX/r0spWRoF8Z3sFROxJqF1Acg
	i4NXuyyJTursKGzozekAU5jwOTSdsRsKknSAaoh2trdbIyM1b6OS8u9eFnN7gOpl
	xch+SWsbwC5szMJ5PVjPgvdjA0Kz0lgSKSN4ztLSOtMjKJvTk4/ZHoEgqGZ4dZdX
	1SD22ezXeyaPYog0jW8lCzvv04v6/OnlKxSbib99JhJgmS3y4MRgr15Q5tY4TiNF
	xJwJgmB6gQ0MPeYvgjXQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr0rbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HAuoGB032102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 03:56:45 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 3/7] dt-bindings: interconnect: Add Qualcomm IPQ9574 support
Date: Wed, 17 Apr 2024 16:26:01 +0530
Message-ID: <20240417105605.836705-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417105605.836705-1-quic_varada@quicinc.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WJAk5dYIigvFgIo7wg9HJ4huHGwXrU6V
X-Proofpoint-GUID: WJAk5dYIigvFgIo7wg9HJ4huHGwXrU6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170075

Add interconnect-cells to clock provider so that it can be
used as icc provider.

Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
interfaces. This will be used by the gcc-ipq9574 driver
that will for providing interconnect services using the
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v8:
Remove ICC_xxx macros
Fix macro defines to be consistent with other bindings
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
index 000000000000..42019335c7dd
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ9574_H
+#define INTERCONNECT_QCOM_IPQ9574_H
+
+#define MASTER_ANOC_PCIE0		0
+#define SLAVE_ANOC_PCIE0		1
+#define MASTER_SNOC_PCIE0		2
+#define SLAVE_SNOC_PCIE0		3
+#define MASTER_ANOC_PCIE1		4
+#define SLAVE_ANOC_PCIE1		5
+#define MASTER_SNOC_PCIE1		6
+#define SLAVE_SNOC_PCIE1		7
+#define MASTER_ANOC_PCIE2		8
+#define SLAVE_ANOC_PCIE2		9
+#define MASTER_SNOC_PCIE2		10
+#define SLAVE_SNOC_PCIE2		11
+#define MASTER_ANOC_PCIE3		12
+#define SLAVE_ANOC_PCIE3		13
+#define MASTER_SNOC_PCIE3		14
+#define SLAVE_SNOC_PCIE3		15
+#define MASTER_USB			16
+#define SLAVE_USB			17
+#define MASTER_USB_AXI			18
+#define SLAVE_USB_AXI			19
+#define MASTER_NSSNOC_NSSCC		20
+#define SLAVE_NSSNOC_NSSCC		21
+#define MASTER_NSSNOC_SNOC_0		22
+#define SLAVE_NSSNOC_SNOC_0		23
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
+#define MASTER_NSSNOC_PPE		0
+#define SLAVE_NSSNOC_PPE		1
+#define MASTER_NSSNOC_PPE_CFG		2
+#define SLAVE_NSSNOC_PPE_CFG		3
+#define MASTER_NSSNOC_NSS_CSR		4
+#define SLAVE_NSSNOC_NSS_CSR		5
+#define MASTER_NSSNOC_IMEM_QSB		6
+#define SLAVE_NSSNOC_IMEM_QSB		7
+#define MASTER_NSSNOC_IMEM_AHB		8
+#define SLAVE_NSSNOC_IMEM_AHB		9
+
+#endif /* INTERCONNECT_QCOM_IPQ9574_H */
-- 
2.34.1


