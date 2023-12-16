Return-Path: <linux-kernel+bounces-1868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830E8154FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E91C21416
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895BA57;
	Sat, 16 Dec 2023 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G5esPZz2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76703365;
	Sat, 16 Dec 2023 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFMcLZv028677;
	Sat, 16 Dec 2023 00:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=JkatVcy30T2EwYlk1D954DoSXJ0fv4ntvLv8PCbRndg
	=; b=G5esPZz2dwmuNSA9RSYIuSJJ0y9ml8NEMTrHwF0HbuB1qXMeUN9N0Z8jNON
	HajkGvTccgALR5x/32EUJOvAbAvL08qdvj2/SeOgxfeGryqGbkZ4xK5E1B+QkLcr
	0pvvUbcv1AG0JyW6N1Pj2QFAXi+/scZxiH/Dbv3aWbLMoJmPJDyAgxnpozPm16Tg
	whtNxcePIOyXv7fRCoGia9FNJsOxSambfASfPHFztcCZQOBFm8qbk37zJW+IHTdL
	L/vV5/maeU5vJEZXY56zjNB6kwPv4m2Z1yWbUSdGyEjVN6Wikxb5YAMf+VwiV2SD
	npd4MVbzXrgZQc3c9bk5aY++F/w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0w198hp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L2fO015448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:02 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:01 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:43 -0800
Subject: [PATCH RFC v15 02/30] dt-bindings: Add binding for gunyah
 hypervisor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-2-192a5d872a30@quicinc.com>
References: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
In-Reply-To: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
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
        Sean Christopherson <seanjc@google.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: txtWmqSTCRvfZ8_OOLCkDkE_13G7yX7b
X-Proofpoint-ORIG-GUID: txtWmqSTCRvfZ8_OOLCkDkE_13G7yX7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

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
2.43.0


