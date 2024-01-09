Return-Path: <linux-kernel+bounces-21320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CF828D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792E31C248EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595043D547;
	Tue,  9 Jan 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YO5qyhSi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305393D39F;
	Tue,  9 Jan 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409GcW81031587;
	Tue, 9 Jan 2024 19:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=lLDuUBmGZvNBtcKj7wbGM3D9GD/JTPUN1398mSvaVtA
	=; b=YO5qyhSisJBy7bUqFg0nkNPGfLRzIKbQDeG9MAPPgqUiW7vKHtIwoENkQz2
	n5fu5lqjw3x4/m5OoeWWfpmerLUdwOdjXirXdP16JIIZcl5x6a69s7mA0uVddIIL
	6DTzU7lGUQA3QjNW4ChDZJd6pJlHtSNCGUtqo7qnTVtD4je0UxIgOdqnubX7xGpU
	XuzYTmG1CXX2jBxT+XnqPED7YjyavmNlqCMphduUcLs/B+vgUJk48RLtnlm1wMZF
	mJ/Jh3vEXQ24EF/Hh92nd/k4ozvX86tJtyxHoxOJkpd9h9plP0UMub3Lr+2pTBGI
	V8UM6u4tT7zdgewLdsE7sMmCpYQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9u9gdbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:37:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jbot3011357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:50 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:49 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:40 -0800
Subject: [PATCH v16 02/34] dt-bindings: Add binding for gunyah hypervisor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-2-634904bf4ce9@quicinc.com>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
In-Reply-To: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: edcD4wUb0AIlamWiAts9LXox64A9mtS0
X-Proofpoint-ORIG-GUID: edcD4wUb0AIlamWiAts9LXox64A9mtS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

The Gunyah Resource Manager applies a devicetree overlay describing the
virtual platform configuration of the guest VM, such as the message
queue capability IDs for communicating with the Resource Manager. This
information is not otherwise discoverable by a VM: the Gunyah hypervisor
core does not provide a direct interface to discover capability IDs nor
a way to communicate with RM without having already known the
corresponding message queue capability ID. Add the DT bindings that
Gunyah adheres for the hypervisor node and message queues.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../bindings/firmware/gunyah-hypervisor.yaml       | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
new file mode 100644
index 000000000000..cdeb4885a807
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gunyah Hypervisor
+
+maintainers:
+  - Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
+  - Elliot Berman <quic_eberman@quicinc.com>
+
+description: |+
+  Gunyah virtual machines use this information to determine the capability IDs
+  of the message queues used to communicate with the Gunyah Resource Manager.
+  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
+
+properties:
+  compatible:
+    const: gunyah-hypervisor
+
+  "#address-cells":
+    description: Number of cells needed to represent 64-bit capability IDs.
+    const: 2
+
+  "#size-cells":
+    description: must be 0, because capability IDs are not memory address
+                  ranges and do not have a size.
+    const: 0
+
+patternProperties:
+  "^gunyah-resource-mgr(@.*)?":
+    type: object
+    description:
+      Resource Manager node which is required to communicate to Resource
+      Manager VM using Gunyah Message Queues.
+
+    properties:
+      compatible:
+        const: gunyah-resource-manager
+
+      reg:
+        items:
+          - description: Gunyah capability ID of the TX message queue
+          - description: Gunyah capability ID of the RX message queue
+
+      interrupts:
+        items:
+          - description: Interrupt for the TX message queue
+          - description: Interrupt for the RX message queue
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    hypervisor {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        compatible = "gunyah-hypervisor";
+
+        gunyah-resource-mgr@0 {
+            compatible = "gunyah-resource-manager";
+            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX allowed IRQ */
+                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX requested IRQ */
+            reg = <0x00000000 0x00000000>, /* TX capability ID */
+                  <0x00000000 0x00000001>; /* RX capability ID */
+        };
+    };

-- 
2.34.1


