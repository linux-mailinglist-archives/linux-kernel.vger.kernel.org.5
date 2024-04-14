Return-Path: <linux-kernel+bounces-144354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5938A44E4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577FEB21001
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA413699C;
	Sun, 14 Apr 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CXmpEMFV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5831350F2;
	Sun, 14 Apr 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123123; cv=none; b=IjXzF4BKxoqnDq+eL2kDcxK46z7YlVIaEuuhmLM4uhDCALjFGoxPfmORIwX47srTFGiGS6/FwQiuwLHWLb/waohc9L0SY8Vb9LgeGWN0aj8tasHkAiGQUq+im9yBbOm0SyCj4cKuR2gSrFayBlpOM+zWNZ39twmqq6+9JycPdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123123; c=relaxed/simple;
	bh=TWv1U7DxesL7iZ9CZE155Z+hlcCtHiJXNPh9W1+g1ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M1zlK6H39Kb31jFfPv15TOs0v3IF5J5kkayFOdF1EsXVUvY9ZMphob712T+UvI4v0zyHeH0DPwnO4DFh2hSzY20eXmwrCnU6LNId/uLX6N6nXvKiavU+g1Ei0kElTyyLKxnZWsN+QL8OZ1V7GH3kes8xbOC3+Gzjm67YOLoJrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CXmpEMFV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EJVeJA007414;
	Sun, 14 Apr 2024 19:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=PvcmryY2yqY12//scIIQRdKGTFYpt+q7cEqQ0Qo7mJ4
	=; b=CXmpEMFV/FoIajA1h6k+551P+oUFM1+wa80rNCz/HIEhsHk9+ukVfFGkcqD
	Ln0tQxYN0c/zHIafVtuscizApe+XlcHm0eArpclJ568XSYSWzeM44lJ27aZk3Zv0
	DnmYFmVuYczjAo6SRpSEAUfFlphy3yNyuNeBIG+77SKY+etselEtL43B/gLbBIBy
	sGAH2qbePPGpCIxafH3ochwdHAtg34OnZM2gIdrpIgyFwFyveuCnTOk4t+s6hBo1
	rpVqC1RF8mfKnJ7qMaVYNUdqSW0XMPj4S0fonOKEXS5j9K2VBNgU1JItJPky9wtG
	y0FL7nirnvzSSpHEVrfQW/eB9wA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfjtkj63r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EJVc7o023182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:38 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 12:30:30 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Sun, 14 Apr 2024 12:30:24 -0700
Subject: [PATCH v2 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240414-arm-psci-system_reset2-vendor-reboots-v2-1-da9a055a648f@quicinc.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mkgvUQWw8D5bEW0tQR8zx67JxPSXDf5e
X-Proofpoint-GUID: mkgvUQWw8D5bEW0tQR8zx67JxPSXDf5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140142

PSCI reboot mode will map a mode name to multiple magic values instead
of just one. Convert the mode-.* property to an array. Users of the
reboot-mode schema will need to specify the maxItems of the mode-.*
properties. Existing users will all be 1.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml   |  4 ++++
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml  |  4 ++++
 .../devicetree/bindings/power/reset/reboot-mode.yaml         | 12 ++++++++++--
 .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml  |  4 ++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
index 627f8a6078c2..03b3b9be36de 100644
--- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
@@ -30,6 +30,10 @@ properties:
 
 allOf:
   - $ref: reboot-mode.yaml#
+  - patternProperties:
+      "^mode-.*$":
+        items:
+          maxItems: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index fc8105a7b9b2..95964e04d5d6 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -68,6 +68,10 @@ allOf:
     then:
       allOf:
         - $ref: reboot-mode.yaml#
+        - patternProperties:
+            "^mode-.*$":
+              items:
+                maxItems: 1
 
       properties:
         reg:
diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index ad0a0b95cec1..b9617b8880c3 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -28,13 +28,21 @@ description: |
 
 properties:
   mode-normal:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "#/patternProperties/^mode-.*$"
     description:
       Default value to set on a reboot if no command was provided.
 
 patternProperties:
   "^mode-.*$":
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    # Note: to reference this schema, the allOf should include hint about
+    # maxItems for the inner cell
+    # allOf:
+    # - $ref: /schemas/power/reset/reboot-mode.yaml#
+    # - patternProperties:
+    #     "^mode-.*$":
+    #       items:
+    #         maxItems: 1
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
index b6acff199cde..bf6d68355e7f 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -31,6 +31,10 @@ properties:
 
 allOf:
   - $ref: reboot-mode.yaml#
+  - patternProperties:
+      "^mode-.*$":
+        items:
+          maxItems: 1
 
 unevaluatedProperties: false
 

-- 
2.34.1


