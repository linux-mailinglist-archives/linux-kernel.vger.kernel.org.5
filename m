Return-Path: <linux-kernel+bounces-29278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6633830C08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BF1F2406E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B822F17;
	Wed, 17 Jan 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c+fY/4VN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312C22EF3;
	Wed, 17 Jan 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512933; cv=none; b=eBzCqrfdI1iRKLgfdngpHkXKRCkZl80PAUMgIRxdBdZqDW7LuHXExAJEXxt+HQJOejcxp9v9CKP10uaR40vj009JDPlo2uWvXyjMmCzROG3L8i/Qk8deUhmF2bRxhrdyiB/xL/oPkLvGHpB0AaXdi3zQjyjU21W0kstYaDhbnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512933; c=relaxed/simple;
	bh=TFQR+feEEBpHsXJTBuchdHiyOox+OC/OuiQ/DkbcZOg=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=choMEMdT0npKggOiJXpGiVBgXjSLR+Tn6lC8ya9yPVJCiBUp+ue1JXUYWgqsiKDpH8YSv+e5Pda65nDSS9L+kljEmMT3FbXG1+6LgUwo6+DBm8YBUcR05xFxIResUWNAVjFeuFvFpLApgN1LU+YpNaNWhVuStmiKjYBT2Wd3RN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c+fY/4VN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HFUEJe023157;
	Wed, 17 Jan 2024 17:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vJRsmIyNRJFMsy9uR5zloMhVRxEDjaClfaNYHrRPpAo=; b=c+
	fY/4VNImnmT+huNT6m4s04FrWolVB1zbgmVMgZmQEXkpACxNMUqC/DttOTta22Ns
	GzPHArqE9OnwQ0SwPvADpBKQ8lFUazN/XOoRvoZ4K1li96KW65JOnmVLDDeGqyAi
	nzMGxrU/t1fj781wcbrbyU8KoGGfAYIyvxYl66Ap3lJwWG23tFIcjnqvCmrPpsWd
	urjighMVKbZkBbqr1fVJX5Apigmy5urPSzn9DXz6A2Zwb8Qw8OAMRGY293AEzvuH
	LAHwUVlJi2o3WcjWUSeK52WRsw/eBWgGH1p5Zw68e4oJlrbLtSUu/o2IcW9/YfKU
	tNbzf+7z5BnXs5AVg4Xg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp8gwhhs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HHZOSa005500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:24 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 09:35:19 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>
Subject: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
Date: Wed, 17 Jan 2024 23:04:52 +0530
Message-ID: <20240117173458.2312669-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117173458.2312669-1-quic_sibis@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vZ99buTMmAha5EAUoOQOdh2qQEKLy9_c
X-Proofpoint-ORIG-GUID: vZ99buTMmAha5EAUoOQOdh2qQEKLy9_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=635 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170127

Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
controller.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
new file mode 100644
index 000000000000..2617e5555acb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
+
+maintainers:
+  - Sibi Sankar <quic_sibis@qti.qualcomm.com>
+
+description:
+  The CPUSS Control Processor (CPUCP) mailbox controller enables communication
+  between AP and CPUCP by acting as a doorbell between them.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,x1e80100-cpucp-mbox
+      - const: qcom,cpucp-mbox
+
+  reg:
+    items:
+      - description: CPUCP rx register region
+      - description: CPUCP tx register region
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@17430000 {
+        compatible = "qcom,x1e80100-cpucp-mbox", "qcom,cpucp-mbox";
+        reg = <0x17430000 0x10000>, <0x18830000 0x300>;
+        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };
-- 
2.34.1


