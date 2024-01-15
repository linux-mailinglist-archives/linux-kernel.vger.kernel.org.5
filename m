Return-Path: <linux-kernel+bounces-26269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDF82DDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042071F22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39D17BD5;
	Mon, 15 Jan 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mhi9FGuo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2218040;
	Mon, 15 Jan 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FFEkOI025807;
	Mon, 15 Jan 2024 16:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nhVHwgyt/dROCTwBL3dn+GnFtDNV81LhIY2UEZjZLm0=; b=Mh
	i9FGuodHag3m2cD0q73ZEwLwlN71KJaqkE07jidiBTPkYuQEi9x778qLreqwPbT4
	ZuXfRkqBdNRnWf2ItyfeQt9nnxFjwNiNGLP/89cJEq2bAjSEGfJdi+d8PjlCADPi
	KuPji1dqFy1xNuYD53KmPfNbxDfGZcVml6Bvgv73g82J7x3EASTIcUE9ebR+hmar
	y2wvy8XSoPtsZ5e246nEadQgCjQegpAgKgCAIgmmC3knVn8YrS6igwtH2tofROhv
	OzFX2r93fAp0mlajdom5doaMmV2IGmmuem4yjnI9IvZH28ReQLQDRzYQdgET3qyu
	8OrcpnmpBXa3LI58PiEw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn75t862k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:43:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FGh7Tu020790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:43:07 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 08:43:07 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mathieu
 Poirier" <mathieu.poirier@linaro.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: arm: Add device-name in the coresight components
Date: Mon, 15 Jan 2024 08:42:48 -0800
Message-ID: <20240115164252.26510-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
References: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4ImuXbad9OGJ2kxOYfBm0jrplxCV8_p7
X-Proofpoint-ORIG-GUID: 4ImuXbad9OGJ2kxOYfBm0jrplxCV8_p7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401150122

device-name is used to provide a better description of the coresight
device. It can provide the info like the system or HW it belongs to.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../devicetree/bindings/arm/arm,coresight-catu.yaml          | 5 +++++
 .../devicetree/bindings/arm/arm,coresight-cpu-debug.yaml     | 5 +++++
 Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 5 +++++
 .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml    | 5 +++++
 .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml  | 5 +++++
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml           | 5 +++++
 .../bindings/arm/arm,coresight-dynamic-replicator.yaml       | 5 +++++
 .../devicetree/bindings/arm/arm,coresight-etb10.yaml         | 5 +++++
 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml | 5 +++++
 .../devicetree/bindings/arm/arm,coresight-static-funnel.yaml | 5 +++++
 .../bindings/arm/arm,coresight-static-replicator.yaml        | 5 +++++
 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml | 5 +++++
 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml | 5 +++++
 .../devicetree/bindings/arm/arm,coresight-tpiu.yaml          | 5 +++++
 .../devicetree/bindings/arm/qcom,coresight-tpda.yaml         | 5 +++++
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml         | 5 +++++
 16 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
index 2bae06eed693..313e25d62f0d 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
@@ -44,6 +44,11 @@ properties:
       - const: arm,coresight-catu
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
index 0a6bc03ebe00..f7904a7df726 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
@@ -39,6 +39,11 @@ properties:
       - const: arm,coresight-cpu-debug
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index 2d5545a2b49c..ba7b4e2db77c 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -88,6 +88,11 @@ properties:
           - const: arm,coresight-cti
           - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
index c960c8e0a9a5..f94e08ca91f0 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
@@ -39,6 +39,11 @@ properties:
     enum:
       - arm,coresight-dummy-sink
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   in-ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
index 6745b4cc8f1c..031c4a1cb199 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
@@ -38,6 +38,11 @@ properties:
     enum:
       - arm,coresight-dummy-source
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   out-ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
index 44a1041cb0fc..2b4829492218 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
@@ -41,6 +41,11 @@ properties:
       - const: arm,coresight-dynamic-funnel
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
index 03792e9bd97a..c841db363a87 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
@@ -41,6 +41,11 @@ properties:
       - const: arm,coresight-dynamic-replicator
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
index 90679788e0bf..6605a8097a14 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
@@ -41,6 +41,11 @@ properties:
       - const: arm,coresight-etb10
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
index 01200f67504a..d9ab0fc57f72 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
@@ -60,6 +60,11 @@ properties:
           Embedded Trace Macrocell (version 4.x), with system register access only
         const: arm,coresight-etm4x-sysreg
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
index cc8c3baa79b4..342dfb303072 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
@@ -27,6 +27,11 @@ properties:
   compatible:
     const: arm,coresight-static-funnel
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
index 1892a091ac35..eaa828124c58 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
@@ -27,6 +27,11 @@ properties:
   compatible:
     const: arm,coresight-static-replicator
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
index 378380c3f5aa..9bc49fed2096 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
@@ -43,6 +43,11 @@ properties:
       - const: arm,coresight-stm
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 2
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index cb8dceaca70e..ba1dec0f580a 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -42,6 +42,11 @@ properties:
       - const: arm,coresight-tmc
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
index 61a0cdc27745..6a5d0c3468f7 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
@@ -41,6 +41,11 @@ properties:
       - const: arm,coresight-tpiu
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index ea3c5db6b52d..31b7d7471a23 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -54,6 +54,11 @@ properties:
       - const: qcom,coresight-tpda
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     minItems: 1
     maxItems: 2
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 3bad47b7b02b..3b72ca36636e 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -40,6 +40,11 @@ properties:
       - const: qcom,coresight-tpdm
       - const: arm,primecell
 
+  device-name:
+    description:
+      Define the name which can describe what kind of HW or system the
+      device is for.
+
   reg:
     minItems: 1
     maxItems: 2
-- 
2.41.0


