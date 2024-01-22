Return-Path: <linux-kernel+bounces-33161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD483656F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E6283EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EB3D96D;
	Mon, 22 Jan 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IxMn83hm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C73D56E;
	Mon, 22 Jan 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933880; cv=none; b=NycN6NL8SbLryULX/lgPd+Y3jEDTF2IQIX0QB4kWO+R+5gMnN9/Ubsz30iWkWxwqKmeM+HiXNfBTUEKxwjeAmOCU7vRrXxHZqKdDTvUsG0YSoMEut5fl9FIRgdFgxgfX6iMZ7FkM1/yV8ks0QB9xGSoWBPasbZnaikdKJqm+GXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933880; c=relaxed/simple;
	bh=5534V6lHT7b3TtGG2QWKvu4mP1JeauyYWUBJvnXGqfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndbgka3QSp2jWTDCz12DqAYisSGURiD0iTNWSTuCqBmD7Az5yzBHHDqIe0MNFsREsCswVlpdhtJ4tKQmRL/UA5DZ5nTmqYiO/6Ds5KLx+XGmBwLsZ8vUjtS1QDfycZLZw7yPDHssh5VtKTm1Zel/8pvC5R0hYnLZdm/c5hebzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IxMn83hm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MEBCva001216;
	Mon, 22 Jan 2024 14:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=XpjkMMKePFkA/dKoK41E
	QFyIy6K2tQwE34XDn+uOUr8=; b=IxMn83hm6mXy1YHUflwBEZahQTvBpCk+wIDs
	UWb/Aa/u/n07qNEfLonKogTLB/gjN+W7lPPNKFmax2fV8rLQlMTSWjLvuG5UlWso
	poaOaVJ1wmBasVNrQ3UfQABiJ/25QQ19yAzIQrdxgeafRPlPvTZ5nOZbsW3/bPsP
	o0drNpQvWwJ6wiXxCZpbIY8C4yKYVX4slbhLJHj14TKMj73T5EIeLgYz3VoNQoXj
	LN4JEv4oe2fN1QAKwrjyyemYv0ChJ29oIHnaW9uMppAyCAsATu8xnV92QsR8F/Ds
	2NP075o9BcXMJIWlnfVxuT7jQCX4y+bYD6cEAejJ9VFZbmcg9Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vssw9g1e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MEVF4e002418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 14:31:15 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 06:31:12 -0800
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: <georgi.djakov@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [3/4] dt-bindings: interconnect: Add clock property to enable QOS on SC7280
Date: Mon, 22 Jan 2024 20:00:29 +0530
Message-ID: <20240122143030.11904-4-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122143030.11904-1-quic_okukatla@quicinc.com>
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
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
X-Proofpoint-GUID: BUfOUhV7cOIJPoAbwVjVtfCqh8-Cn7VJ
X-Proofpoint-ORIG-GUID: BUfOUhV7cOIJPoAbwVjVtfCqh8-Cn7VJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220098

Added clock property to enable clocks required for accessing
qos registers.

Change-Id: Ie0478cc7ae9742742e2389cfa37ee57bab1aa320
Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 .../interconnect/qcom,sc7280-rpmh.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index b135597d9489..758a6e924037 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -53,10 +53,50 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre1-noc
+              - qcom,sc7280-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
     interconnect {
         compatible = "qcom,sc7280-clk-virt";
         #interconnect-cells = <2>;
@@ -69,3 +109,12 @@ examples:
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
     };
+
+    interconnect@16e0000 {
+        reg = <0x016e0000 0x1c080>;
+        compatible = "qcom,sc7280-aggre1-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+    };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


