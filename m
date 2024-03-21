Return-Path: <linux-kernel+bounces-109792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4628855C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0471F21B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD3481D5;
	Thu, 21 Mar 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JUTTOBk/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244020312;
	Thu, 21 Mar 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009975; cv=none; b=Dj2tfWEebfHDjGMgonVIVdMxtcwH7DQR54dTyuBhLR2UNSDzbhMeDzHVMAGsqzpYMyEoJO+SJ10zWJsA5LS9r77xgDBnqSNHBeotlkg/Erhss+ZULSmOFUEN2DURomistXbNGzl7iXNhgjB4bPhb3NaUF+TBF0ITJGQ77BZCw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009975; c=relaxed/simple;
	bh=8io2EGR1L1+Uiz9KhTAPZ8khuUJh03rL0FXlTsw+QaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucNUxAVzB484/pEfu4yMh8t+/0o3fMXfWNoChQv67eNcPZH4XzNyVtOPnmKZs/fhH/4bWe5hJ370OxnrB9BVhT8dbYUVdUMnUGVZfCk6TC7HF5Cc3R9snjjXvuGP0svxftuERinsB7YtxmAne+QM1ujk9QgNKSCEfNlAAO7Qon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JUTTOBk/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L7bZJP012693;
	Thu, 21 Mar 2024 08:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=HFI8HIac9if1Y4WZiEOV
	ol/hOSTOPl6waJF+ZSoXpCY=; b=JUTTOBk/wWMIfAMoGuuCnw6qVml9NnCiREim
	RAY6dbJ9V7vbPSm8k12mLJqjcSCGMflt/3HrZ0LFEXVP/75ZnVPKG1/tczlz5f+b
	9e29KpAUkkl33J2rRLQmxkUO70bGo/KR8uzyMkbdsuNEq7D0mWmLYnUZHAl1mhPo
	rXSGOFWNgFsdAR+KxuplfhQ0OEhCx9208qkkKdUvfBti0TxBHVV9DfaTFXb6+e61
	NLrgHTu/ufCt4a7skpp7Kyb0l7Eh0kctMjynMrFChARCLQfuu+5wdDvZ8lqzjRV6
	ehXwaA0CaubIKq+x40rNaxdORS2W6nyXUEyo6UAy5sik4Uppvg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0c67gkva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L8WZDG002282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:35 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 01:32:30 -0700
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH 1/4] dt-bindings: arm: qcom,coresight-funnel: Add label for multi-ouput
Date: Thu, 21 Mar 2024 16:32:04 +0800
Message-ID: <1711009927-17873-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G6BvcXkXF3yE2H_Vx-vgo_haQ3_zjU8W
X-Proofpoint-ORIG-GUID: G6BvcXkXF3yE2H_Vx-vgo_haQ3_zjU8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210057

Add new property "label" to label the source corresponding to the
output connection. When the funnel supports multi-output, this
property needs to be introduced to mark which source component a
certain output connection corresponds to.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../arm/arm,coresight-dynamic-funnel.yaml     | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
index 44a1041cb0fc..cde62c286d29 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
@@ -66,13 +66,39 @@ properties:
         $ref: /schemas/graph.yaml#/properties/port
 
   out-ports:
-    $ref: /schemas/graph.yaml#/properties/ports
-    additionalProperties: false
-
+    type: object
     properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
       port:
+        type: object
+
+    patternProperties:
+      '^port(@[0-7])?$':
+        type: object
         description: Output connection to CoreSight Trace bus
-        $ref: /schemas/graph.yaml#/properties/port
+
+        patternProperties:
+          "^endpoint(@[0-9a-f]+)?$":
+            type: object
+            properties:
+              remote-endpoint:
+                description: |
+                  phandle to an 'endpoint' subnode of a remote device node.
+                  $ref: /schemas/types.yaml#/definitions/phandle
+              label:
+                description: Label the source corresponding to the output connection
+                $ref: /schemas/types.yaml#/definitions/string
+    oneOf:
+      - required:
+          - port
+      - required:
+          - "#address-cells"
+          - "#size-cells"
 
 required:
   - compatible
-- 
2.17.1


