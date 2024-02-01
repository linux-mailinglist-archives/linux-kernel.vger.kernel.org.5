Return-Path: <linux-kernel+bounces-48847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2B846251
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1147F1C253BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313573D0A4;
	Thu,  1 Feb 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CCsN8STO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEC12FB12;
	Thu,  1 Feb 2024 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821560; cv=none; b=tpT+jRdCHYFRXmUfepsjTPwsP0Wu2LIoPPuf/vJaIO1Dx1UOgix1tjwVyAfzSf54iDhDfr9wnnrHLNfKhFe1Ypj5gvK5SXnUpFVk6QbplIVQUYcPxiaAXxr/rXarOhuLLBZH6bNABcgZ4DBRI8D49mu+y0LUmO9nyvop6KvYm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821560; c=relaxed/simple;
	bh=/+/FVvxYw1m3V4PhXzToj3z3g3YjB/Ca5+UW7tj+rmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT+taFTJ8Eb5WdGPMy9YnhT4jwOxy2CNWDJVelNqfHNNMHtCLg6l/2R+jtJdnbeUQahJIPdkUbeOE03+L5c1UA9xeRTcdbsBXIhPvYgOJ1bq1oeQqW2jO1OH9ccE1RunSSkr3ymBqQBDVOiYre8TXvfYaFPMtyn+N1OwdVNqlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CCsN8STO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411Jmb1u032191;
	Thu, 1 Feb 2024 21:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=iNUFl+O4Q+nSOF+40pkC
	YbU/d8xhFCc4glTBr+0sDes=; b=CCsN8STOuOQydrW2DiW9sLzAgCcnWBlTWOxH
	8pO3bAmGbIR/FtkFFmjwZ60zscEnNvuMDHNGHWohrAUI4me7/oliDb+f/GRUj8XL
	XngxdUgNdraRY21pNBrTVczEXmYcV92nqOblcD/Jo9G8+JOk467HUtRFaMG7JYAI
	plSG00FDcw1ySYghtEl1RWbDuaYw1H/BI/VXZSM6WFBJG80n5k6mf41WfsScBSYE
	ZzEVR1J8TpgqsPFh1rcCTo71Gq94XUx+XpuhQdEDi5mklmxwrajqnwblikmO/WkN
	xX+wLYZoRDww66GeEFI4Mqg62dQ9iemVT0q722EYhBY4quGVJA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b4y16vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5eZv028370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:40 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:39 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v4 01/10] dt-bindings: iommu: Add Translation Buffer Unit bindings
Date: Thu, 1 Feb 2024 13:05:20 -0800
Message-ID: <20240201210529.7728-2-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BDMj7KM5nmqU7Ej7G0k1JUIEKGi1vezK
X-Proofpoint-GUID: BDMj7KM5nmqU7Ej7G0k1JUIEKGi1vezK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

Add common bindings for the TBUs to describe their properties. The
TBUs are modelled as child devices of the IOMMU and each of them is
described with their compatible, reg and stream-id-range properties.
There could be other implementation specific properties to describe
any resources like clocks, regulators, power-domains, interconnects
that would be needed for TBU operation. Such properties will be
documented in a separate vendor-specific TBU schema.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 14 ++++++++++
 .../devicetree/bindings/iommu/tbu-common.yaml | 28 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/tbu-common.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a4042ae24770..ba3237023b39 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -235,6 +235,20 @@ properties:
       enabled for any given device.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+patternProperties:
+  "^tbu@[0-9a-f]+$":
+    description: TBU child nodes
+    type: object
+    $ref: tbu-common.yaml#
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/iommu/tbu-common.yaml b/Documentation/devicetree/bindings/iommu/tbu-common.yaml
new file mode 100644
index 000000000000..3e95b356e572
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/tbu-common.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/tbu-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Translation Buffer Unit (TBU) common properties
+
+maintainers:
+  - Georgi Djakov <quic_c_gdjako@quicinc.com>
+
+description:
+  The SMMU implements a TBU for system masters. It consists if a
+  Translation Lookaside Buffer (TLB) that caches page tables.
+
+properties:
+  reg:
+    maxItems: 1
+
+  stream-id-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Stream ID range (address and size) that is assigned by the TBU
+    items:
+      minItems: 2
+      maxItems: 2
+
+additionalProperties: true
+...

