Return-Path: <linux-kernel+bounces-125458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D08892668
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF121F25101
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FB13CC60;
	Fri, 29 Mar 2024 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BtlHbz0c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD439FD6;
	Fri, 29 Mar 2024 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749266; cv=none; b=lo17oTE8zHN3g3/4rU7TnAuMy3ZzP0JZprEaFO9JRk3feaDkUzBcXpgUR3f/AYD6fu1yypWc/qy5LPmlcjxkaREwqE7MV+Cl3T8lwwG/clGLuGwdtukw6nYzoOE3PU1zbwPECmPOvbpIFVhP1BFvE1DUWrnsF6f72hssv1iLw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749266; c=relaxed/simple;
	bh=BkpAtmS8Rvug+lXoZodZdEE8Pzy5W8JODJH0waZXtNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ntcCHSJAOHy5ZqGZUDkjq68jCENbvVgjbo3Kpsi55yIhQemajtfaOI4f2IRJo2MpD6RZF9KS1AkGaek+ddlmhG5jr8LGa+I9Wkno6JY48tlKi10fVY9/F/STIGkkfl3UIZ5RZ+e0gTHsMvejq+eTZ4EahkUcBRzlLdzaMa6IlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BtlHbz0c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TLSoQS023346;
	Fri, 29 Mar 2024 21:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=WcgE4EVvG4hyOn2gTFyia3zF0+c94R0SDUh2cdMOji0
	=; b=BtlHbz0cO7yoxpgX9LkAJWZdb3HFLvoMd4dA1EP7v26N2vGdCNVrt7PRX/R
	M0jgpvjXcZ107E9T6PIsoz4tukkPri5pi2j6hqm8/npdFN3dgjwwOhI1rIxyf2HS
	mZ68fz7kDemHaDF5o+ZUG6VU+BagE3/ZFhkk2xEeihBN3B9j9zhXMFvcWgSmyPS0
	H6JPA7LlCHDinWOGqHFizyVgt7bWF0tH34JdPbieBmc6OupVdTr1zwP379wfz40f
	v7rt6gDJ+D7h3mKOB7GKcU48xPELKwJaqePLsH8rXdOkmfiSq/sQ08EWQ8tBRYGa
	wXy6vRQh804yYbgld7Wd9Pwgz7w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g18ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TLs3Z9002066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 14:54:00 -0700
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Fri, 29 Mar 2024 14:53:40 -0700
Subject: [PATCH v4 1/5] dt-bindings: arm: msm: Add llcc Broadcast_AND
 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-llcc-broadcast-and-v4-1-107c76fd8ceb@quicinc.com>
References: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
In-Reply-To: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Unnathi Chalicheemala
	<quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711749240; l=2507;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=BkpAtmS8Rvug+lXoZodZdEE8Pzy5W8JODJH0waZXtNw=;
 b=2KwM/IX+8f15Jm2xFgS85uwI/Q0snyMdvCH3OZa8yLLpZJZOoi+FlaPQaVp4+grqR+O5whxZQ
 OQEq6cUXCqcAeDC31hkGoSe1ZI4wns9fKpqkZ3O2uK7G/xDu8EuySBz
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lr6KcWDfSQ4sQjBPHfhQuDNn2wW1eFi1
X-Proofpoint-ORIG-GUID: lr6KcWDfSQ4sQjBPHfhQuDNn2wW1eFi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=957
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290195

The LLCC block in SM8450, SM8550 and SM8650 have a new register
space for Broadcast_AND region. This is used to check that all
channels have bit set to "1", mainly in SCID activation/deactivation.

Previously we were mapping only the Broadcast_OR region assuming
there was only one broadcast register region. Now we also map
Broadcast_AND region.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml       | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 07ccbda4a0ab..a6237028957f 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -141,8 +141,31 @@ allOf:
               - qcom,sm8150-llcc
               - qcom,sm8250-llcc
               - qcom,sm8350-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC2 base register region
+            - description: LLCC3 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc2_base
+            - const: llcc3_base
+            - const: llcc_broadcast_base
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sm8450-llcc
               - qcom,sm8550-llcc
+              - qcom,sm8650-llcc
     then:
       properties:
         reg:
@@ -151,7 +174,8 @@ allOf:
             - description: LLCC1 base register region
             - description: LLCC2 base register region
             - description: LLCC3 base register region
-            - description: LLCC broadcast base register region
+            - description: LLCC broadcast OR register region
+            - description: LLCC broadcast AND register region
         reg-names:
           items:
             - const: llcc0_base
@@ -159,6 +183,7 @@ allOf:
             - const: llcc2_base
             - const: llcc3_base
             - const: llcc_broadcast_base
+            - const: llcc_broadcast_and_base
 
 additionalProperties: false
 

-- 
2.25.1


