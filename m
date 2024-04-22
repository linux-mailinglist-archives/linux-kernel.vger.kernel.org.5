Return-Path: <linux-kernel+bounces-153727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716098AD263
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D52812F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B724154BEF;
	Mon, 22 Apr 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K2n8Ee13"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246815443D;
	Mon, 22 Apr 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804071; cv=none; b=DNDQfBcULxhcKbq1p6uB+S98hrIIVcPLURhz15lp8iz9Umro1SbB8ztpoKVl/9Y4BF32pTS5gUxcKpjFWz7iSkO5arbR8i2dWh6tpH2rxtPbZJBX3EmptQNZW1OFf07orOWk//ozeCJ704gPf9wJR706jEe4WlNMSd7ZeIGREAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804071; c=relaxed/simple;
	bh=iTfNBj3uL4RNmKUnsi79+r5SzUOp/Hu08RvAp3Hv/54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghUqI9sS8w/rk62B0ZaWZOnYTwolBwGyyfHzOtsOH5rS4kWro6dJQqC/a0GGwqMsfoErhLEGCz12RA64mU5uV9aGPG1pBHJ6o4tua5zHEWq6n0T2W9wmqxHZ3BS8wL2i3Acd1GdBqbkHjpHxoUYwT40kjqEh6Vym85Zo3AV1Lbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K2n8Ee13; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MCYPwR015091;
	Mon, 22 Apr 2024 16:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=AbqKrw6rrHqD2r/1Dqide2ViI3fNtYxSpf2Z+0H5Hqo=; b=K2
	n8Ee13xCgxuCQ6Vt2qRM0LebGgv1Z7ZHUo3P9eVtdznunqRlOf99JWvoufmelfq0
	5XB2paaVUg/+R4Aianz9wHj5bCriSzu+JRc7cSg9CUn1VnsKw1VJCcuXfJl78Fjb
	JDyEGKXSUV+p0YB4A2FJVPkckv1cbX6r1zgX9Ij2WRfgSrOl6L5w8sdHe+dbGx/O
	WfNRNiaU2/OltDBGnv5s84ehW6L0YT5d8owNLjSsdKMDvsz95UJwbn1lrarnxaRX
	FDZXN9S4PJiMHt3tfd3XDXkIyNVBGt89fMU/Sdkrfy2pviSqtvNJnP8m8nHeLji2
	ggbBiqWTE/RHxjfSog5Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnr0mgkj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:41:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGf19o008027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:41:01 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 09:40:55 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>,
        <abel.vesa@linaro.org>, Rob Herring
	<robh@kernel.org>
Subject: [PATCH V4 1/5] dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
Date: Mon, 22 Apr 2024 22:10:31 +0530
Message-ID: <20240422164035.1045501-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422164035.1045501-1-quic_sibis@quicinc.com>
References: <20240422164035.1045501-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RgYMC1r_-dNER4jl_Hd3yG10-_pY5Veu
X-Proofpoint-ORIG-GUID: RgYMC1r_-dNER4jl_Hd3yG10-_pY5Veu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220070

Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V3:
* Fix Maintainer info in cpucp mbox bindings. [Bjorn]

 .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
new file mode 100644
index 000000000000..f7342d04beec
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
+
+maintainers:
+  - Sibi Sankar <quic_sibis@quicinc.com>
+
+description:
+  The CPUSS Control Processor (CPUCP) mailbox controller enables communication
+  between AP and CPUCP by acting as a doorbell between them.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,x1e80100-cpucp-mbox
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
+        compatible = "qcom,x1e80100-cpucp-mbox";
+        reg = <0x17430000 0x10000>, <0x18830000 0x10000>;
+        interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };
-- 
2.34.1


