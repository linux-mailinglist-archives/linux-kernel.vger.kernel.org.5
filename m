Return-Path: <linux-kernel+bounces-40590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6283E2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9BB1F25789
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8B22EEB;
	Fri, 26 Jan 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VxaS1x9w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C724A04;
	Fri, 26 Jan 2024 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298474; cv=none; b=WicladsJm5F+KaCODnTI048pVrwR7chfKH2qQ5+k2I9ENOqC20rBUFZUbSulDLIAWTY8R2CtOFhgPmnvbHPHk4Uy6HeD2Gdu/hLvwSdLl+v14tCEULhgGDR2yMxmNapYg4Jw2I+ne1+czbfh13gCuy1FBTy0rY4eq3sEgMlXE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298474; c=relaxed/simple;
	bh=rdGq3astIouXNX25p13Z0gE2EIiriAoan3jvO4leqMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZJTU7Rp8Z3IMjFoms9W0lKR29NJCtg3fXdSX3+ochiu7zzFMy6Ub6iJzKnSTx4W3xRRpMmtjHekEFw1IMixuKiQpqoC+uDGPbwk03wNzVetM72IN3Q2VhBb9hxK80sJDt8UihHNXrK9hgd/1sNNntMfa84/DqjHDXZG78AlzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VxaS1x9w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QJMZoY003563;
	Fri, 26 Jan 2024 19:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=v4UB/NHcu1dDEQAevzXnPCLza3yf0d5+YURVQqpdA8M=; b=Vx
	aS1x9wmv4hrCIdfEwfT3bnXL3pAUtgjZHtdIM2Kf3vgGCEcy8dM7OOwjZLUrvYEJ
	ekxLYngC91MFTtd6lBMSMajhygIynoFbAZD3raSYdr4fI/rTOI244mu6xLJF/dpO
	4T0+pXGg1fhjemmCrH94J3coGwqRG2SZqziQGrw7D9SUp3BFnv0uLEmzov/C26Ee
	UDE+e6IExzx1Ecbdu9BJrra6sxkFuaVJjYdYDWO803dTzVcUXKEFp/9N5CGj3yzh
	ARBsBgh3e+mmIIJVaCmXvvmixIzlYWTyYeIlKxv+4Q3Sb2LiQUHNHbWITSUlEc0H
	fJbJBeYrnCQCiWsG2lZA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvfc8gka9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QJlXh4015924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 19:47:34 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 11:47:31 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: arm: msm: Add llcc Broadcast_AND register region
Date: Fri, 26 Jan 2024 11:47:17 -0800
Message-ID: <f86592f43523ec7f025121379a61ed37962ff672.1706296015.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1706296015.git.quic_uchalich@quicinc.com>
References: <cover.1706296015.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -jR42E3HFdlhe1wtIviej2vm60r1C9we
X-Proofpoint-ORIG-GUID: -jR42E3HFdlhe1wtIviej2vm60r1C9we
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=832
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260146

The LLCC block in SM8450, SM8550 and SM8650 has a new register
space for Broadcast_AND region. This is used to check that all
channels have bit set to "1", mainly in SCID activation/deactivation.

Previously we were mapping only the Broadcast_OR region assuming
there was only one broadcast register region. Now we also map
Broadcast_AND region.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml  | 27 ++++++++++++++++++-
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


