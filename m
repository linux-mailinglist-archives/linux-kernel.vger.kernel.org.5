Return-Path: <linux-kernel+bounces-48823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEB846214
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C30283F46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229C3BB3D;
	Thu,  1 Feb 2024 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oy/sTYLi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A33CF5B;
	Thu,  1 Feb 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820319; cv=none; b=TpqTYy+wiSiGjrEAvUVIL9jkROW6wrUrMlOio5d7hbXWnV5i0VL9Dh5MVMrsHglis1iYS+3sEvgLsdCsyOI9+vIg8ka42dkeUPNh+v9Ms5YTUxGlMU4+nh1VPhQxbkSopBf9nOTZXo7xU9GUDguQRXOxivhWnLhkHlCjouHi110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820319; c=relaxed/simple;
	bh=XsipdpcFYHP+DSQUfNuvFC6Yj9UlAvfSpAFJTOt750Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnNIuLLdlMKS1qpdUkLI1y3i9uolHgPNxzH78PUj+scfFvr5Kq+C1wnZkLKXWwDfTucXjmZG5iePGXst/lOAoOHjYljd5NLVTVXfzzGK8xJu3EdfhELqEzrAi/TzvPRIHnaVWFoGS1lif4KlWPhkkQAcQiUPVFsbZl2ku/csBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oy/sTYLi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411J225K027868;
	Thu, 1 Feb 2024 20:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kpE5sCFq3dmk4U1+LA8mrhI3/a/VConRpuJvlSn/PyE=; b=Oy
	/sTYLij8oTogZRGyIRQ7oIXihLb9V2JFlVqYE7dKzB1sWiHq4nfJHxLhFo7508oL
	voPFbwWVTZaAjk5ld0ccuK1ncrmUseBsCA2KkPVI33yFgi6SGhoo2jFMFmvC2Vqs
	V4ORp3S4ekv/WXN7AQ0Z12J+5t/A6hmR6IaG37X1uEUQTADh0yFWShw66eHNTRz4
	Llm54skubShtfyRY3kjjGfZrJHVFUch1pTuO2pCbMoidmtvhmEscnaWCQ0fMAm70
	JuEoLLuVJAdRE0BpJmUWs2wgvE7DhPpqldEbet3mEnJeiVNLSIlNDm3cJim1JEVV
	C479MVB66IS30otvQZcQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b4y15su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 20:45:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411KjDSW032583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 20:45:13 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 12:45:12 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: soc: qcom: Add qcom,pbs bindings
Date: Thu, 1 Feb 2024 12:44:22 -0800
Message-ID: <20240201204421.16992-4-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240201204421.16992-2-quic_amelende@quicinc.com>
References: <20240201204421.16992-2-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -BjEwpR5czPYxh_WK_Pg19ZmPb2nrvN5
X-Proofpoint-GUID: -BjEwpR5czPYxh_WK_Pg19ZmPb2nrvN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010160

Add binding for the Qualcomm Programmable Boot Sequencer device.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/qcom/qcom,pbs.yaml           | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
new file mode 100644
index 000000000000..b502ca72266a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,pbs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Programmable Boot Sequencer
+
+maintainers:
+  - Anjelique Melendez <quic_amelende@quicinc.com>
+
+description: |
+  The Qualcomm Technologies, Inc. Programmable Boot Sequencer (PBS)
+  supports triggering power up and power down sequences for clients
+  upon request.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,pmi632-pbs
+      - const: qcom,pbs
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@0 {
+      reg = <0x0 SPMI_USID>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pbs@7400 {
+        compatible = "qcom,pmi632-pbs", "qcom,pbs";
+        reg = <0x7400>;
+      };
+    };
-- 
2.41.0


