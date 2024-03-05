Return-Path: <linux-kernel+bounces-92729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5F872504
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F120FB28CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637D14F98;
	Tue,  5 Mar 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T3a5B1pn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E026DDCB;
	Tue,  5 Mar 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657923; cv=none; b=VpdoZO29v4Rib/4ivWUyeC/wZB4fWgudVjndCzQhBWKvyxX+GMQgBL71qjhyOP0xOu/Tb3VKr5T97haAhiFRN0GXnP8I/Mn8BZYZWOwDK/mvL7iSwJ6wWACI7vG5jMhcNSw3zhUvuHsgfhytONZSrTwcV2NrLHPPgyemaEXeHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657923; c=relaxed/simple;
	bh=3hXGuLPaSoge6PPL81xKpp+QGw0sbKC9BBRUy6g2ATU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsVaqE2aisqwVziuOuD5vI0zq8FlSzBCT0pK23vpO4+4EvUcfpsdRxVfmVA7j8EGVagyqgsgldxPUxw+ooo9HRh0mmjPKfOpR2QSyAiwp0reOJU547dtIktUhS8MBXPHjMKo3L+jOmEKo/hCoTf3GK6LOoQIQfCrHExumuqmoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T3a5B1pn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425CZdsb016430;
	Tue, 5 Mar 2024 16:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=G2pHKm3CYRwftnWlnCzZ
	QoVdTQVzwW6oS8xpp4Rnbrs=; b=T3a5B1pnIUNjkYb2WY5CQ2NBSjnJwNqQOQy9
	TpuAG9K9GrG1kxdl+ngN7WLmwNEGT+fAlgFTYK3q5xM7HYtkz3u55+prYTIRJRAI
	xV7e6mFnJslk0RHc7sLTcuA4dSI8QBEMhKRZvcQOj7DNbt/WzqJdKgWw4GBohUW2
	9wnGGLMLeoadxpL92oOcKAn5L4cyvTqziYbsCb08Pq1zBZP15GTazDce7Wq/UstK
	vEzsfA2Fx2qT62ekFgwfgC+omlUmSvTPZrpV97MdouYiKp3XR0ENzdLfUlcUFh+e
	R7ZlbhhjCLewP47yrFVGzCsV8D8qNmdm0IxDPFdtvFIY9sThgQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnpxhj3ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 16:58:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425GwAOb002612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 16:58:10 GMT
Received: from sriramd-linux.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 08:58:04 -0800
From: Sriram Dash <quic_sriramd@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
Subject: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple power-domains
Date: Tue, 5 Mar 2024 22:27:36 +0530
Message-ID: <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AYZBRZ9_c9lMlF-k_iXZBXK_7GOBinLi
X-Proofpoint-GUID: AYZBRZ9_c9lMlF-k_iXZBXK_7GOBinLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403050136

Some target systems allow multiple resources to be managed by firmware.
On these targets, tasks related to clocks, regulators, resets, and
interconnects can be delegated to the firmware, while the remaining
responsibilities are handled by Linux.

To support the management of partial resources in Linux and leave the rest
to firmware, multiple power domains are introduced. Each power domain can
manage one or more resources, depending on the specific use case.

These power domains handle SCMI calls to the firmware, enabling the
activation and deactivation of firmware-managed resources.

Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
---
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 ++++++++++++++++------
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 ++++++++++++--
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
 3 files changed, 130 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index 1e2d4dd..53b9ba9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -44,7 +44,32 @@ properties:
     maxItems: 5
 
   power-domains:
-    maxItems: 1
+    description: specifies a phandle to PM domain provider node
+    minItems: 1
+    maxItems: 2
+
+  power-domain-names:
+    description:
+      A list of power domain name strings sorted in the same order as the
+      power-domains property.
+
+      For platforms where some resource are firmware managed, the name
+      corresponding to the index of an SCMI domain provider can be
+      "usb_core" or "usb_transfer".
+    items:
+      - const: usb_core
+      - const: usb_transfer
+
+  qmp,fw-managed:
+    description:
+      Some targets allow multiple resources to be managed by firmware.
+      On these targets, tasks related to clocks, regulators, resets, and
+      interconnects can be delegated to the firmware, while the remaining
+      responsibilities are handled by Linux.
+
+      Decide if the target resources will be managed by firmware or High level
+      OS.
+    type: boolean
 
   resets:
     maxItems: 2
@@ -70,14 +95,6 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
-  - resets
-  - reset-names
-  - vdda-phy-supply
-  - vdda-pll-supply
-  - "#clock-cells"
-  - clock-output-names
   - "#phy-cells"
 
 allOf:
@@ -86,6 +103,33 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sa8775p-qmp-usb3-uni-phy
+              - qcom,sc8280xp-qmp-usb3-uni-phy
+              - qcom,x1e80100-qmp-usb3-uni-phy
+    then:
+      required:
+        - power-domains
+
+  - if:
+      not:
+        required:
+          - qmp,fw-managed
+    then:
+      required:
+        - clocks
+        - clock-names
+        - resets
+        - reset-names
+        - vdda-phy-supply
+        - vdda-pll-supply
+        - clock-output-names
+        - "#clock-cells"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,ipq6018-qmp-usb3-phy
               - qcom,ipq8074-qmp-usb3-phy
               - qcom,ipq9574-qmp-usb3-phy
@@ -144,18 +188,6 @@ allOf:
             - const: com_aux
             - const: pipe
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sa8775p-qmp-usb3-uni-phy
-              - qcom,sc8280xp-qmp-usb3-uni-phy
-              - qcom,x1e80100-qmp-usb3-uni-phy
-    then:
-      required:
-        - power-domains
-
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0f200e3..ad2f08f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -49,6 +49,34 @@ properties:
     items:
       - const: ref
 
+  power-domains:
+    description: specifies a phandle to PM domain provider node
+    minItems: 1
+    maxItems: 2
+
+  power-domain-names:
+    description:
+      A list of power domain name strings sorted in the same order as the
+      power-domains property.
+
+      For platforms where some resource are firmware managed, the name
+      corresponding to the index of an SCMI domain provider can be
+      "usb_core" or "usb_transfer".
+    items:
+      - const: usb_core
+      - const: usb_transfer
+
+  hsphy,fw-managed:
+    description:
+      Some targets allow multiple resources to be managed by firmware.
+      On these targets, tasks related to clocks, regulators, resets, and
+      interconnects can be delegated to the firmware, while the remaining
+      responsibilities are handled by Linux.
+
+      Decide if the target resources will be managed by firmware or High level
+      OS.
+    type: boolean
+
   resets:
     items:
       - description: PHY core reset
@@ -154,12 +182,21 @@ required:
   - compatible
   - reg
   - "#phy-cells"
-  - clocks
-  - clock-names
-  - resets
-  - vdda-pll-supply
-  - vdda18-supply
-  - vdda33-supply
+
+
+allOf:
+  - if:
+      not:
+        required:
+          - hsphy,fw-managed
+    then:
+      required:
+        - clocks
+        - clock-names
+        - resets
+        - vdda-pll-supply
+        - vdda18-supply
+        - vdda33-supply
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 63d150b..5bf3a29 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -64,7 +64,31 @@ properties:
 
   power-domains:
     description: specifies a phandle to PM domain provider node
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  power-domain-names:
+    description:
+      A list of power domain name strings sorted in the same order as the
+      power-domains property.
+
+      For platforms where some resource are firmware managed, the name
+      corresponding to the index of an SCMI domain provider can be
+      "usb_core" or "usb_transfer".
+    items:
+      - const: usb_core
+      - const: usb_transfer
+
+  qcom,fw-managed:
+    description:
+      Some targets allow multiple resources to be managed by firmware.
+      On these targets, tasks related to clocks, regulators, resets, and
+      interconnects can be delegated to the firmware, while the remaining
+      responsibilities are handled by Linux.
+
+      Decide if the target resources will be managed by firmware or High level
+      OS.
+    type: boolean
 
   required-opps:
     maxItems: 1
@@ -148,13 +172,20 @@ required:
   - "#address-cells"
   - "#size-cells"
   - ranges
-  - clocks
-  - clock-names
   - interrupts
   - interrupt-names
 
 allOf:
   - if:
+      not:
+        required:
+          - qcom,fw-managed
+    then:
+      required:
+        - clocks
+        - clock-names
+
+  - if:
       properties:
         compatible:
           contains:
-- 
2.7.4


