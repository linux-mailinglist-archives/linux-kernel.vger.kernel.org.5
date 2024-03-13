Return-Path: <linux-kernel+bounces-101415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1187A6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B129E1F23BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FD481B9;
	Wed, 13 Mar 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DqASpK1h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1E47A74;
	Wed, 13 Mar 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328156; cv=none; b=OLzxVEChZH7tdF8awIvyInJVxI2Zff9QEupZ+veSHQxSy7qVBZMbhLzVLwKO1G8c8PoAyJ4PQsPFSIaICeWMu12wl3QeyITEVHiUHU2w02+lU5YhQ0RGCvTAW7D+4kARBOx63e3VLbDWrcJ2zRqdlhy0uBadPV+oyyUYb2Pnf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328156; c=relaxed/simple;
	bh=c4pT6PvjDMpeiAGrjGjctTU2RfRQAJgzGAUdsGZFgrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TuWbGXVohP+JaAQHijoiLeostOZHaoW/KQG0iYqg6byA/gqkeX+zqmTjvHvLvhHDxWheQm4Wl/RjKFdhdkbGA0P7oFLMUX+LxVme/5UhC+iMa6q2cV+uIgYWuImd7oiZtk+Ws4EiGPZLykBPz01ehv1FwtPQcEwsrXqwLnSSHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DqASpK1h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D7jBoe031525;
	Wed, 13 Mar 2024 11:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=/RY/DEwsyprCrQmcpWFIziiKAvbJlwtp/QOiUjoBjvs
	=; b=DqASpK1hkTm1NVRthXxVffiOCeAu0i3Ru0Dv6PHg3vvpEH5JiAMcIps6b4+
	vrFXIUbXcTMvckgbli6ocp3wg7eniphspKAxUbUpeJtxxWacBP/fYxzLoH2eb2zT
	69hmNUaXNH5IrWZA+DwEzJf6JfSUek0/LUbHkhapmN3E+nKtl/aNtzl2NANKlH0G
	c0UI0Abl8pUKEjzTlqeQNKReY92wE9gAwEnHOc9A2MocIgZITLMzqpU7Mf6IAFoQ
	DV4KZg6OIDVPNvOQwytlwyXSecdaaNw0i9Ng2/VFuYSaPj9jiB2KGuX3fjY+asBV
	opT/qrIfdqTGgSDszhgJX3m9a9A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu815rdkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:09:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DB9Aef017977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:09:10 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 04:09:05 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Wed, 13 Mar 2024 16:38:27 +0530
Subject: [PATCH 1/3] dt-bindings: clock: qcom: Update SM8150 videocc
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
In-Reply-To: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RBfzm5g8xSA-AI8Tirq6kPIcbrz-lWdH
X-Proofpoint-ORIG-GUID: RBfzm5g8xSA-AI8Tirq6kPIcbrz-lWdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=789 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130083

Update the videocc device tree bindings for sm8150 to align with the
latest convention.

Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 1 +
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml        | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index bad8f019a8d3..e00fdc8ceaa4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - qcom,sm8450-videocc
       - qcom,sm8550-videocc
+      - qcom,sm8150-videocc
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 6999e36ace1b..28d134ad9517 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -17,7 +17,6 @@ description: |
     include/dt-bindings/clock/qcom,videocc-sc7180.h
     include/dt-bindings/clock/qcom,videocc-sc7280.h
     include/dt-bindings/clock/qcom,videocc-sdm845.h
-    include/dt-bindings/clock/qcom,videocc-sm8150.h
     include/dt-bindings/clock/qcom,videocc-sm8250.h
 
 properties:
@@ -26,7 +25,6 @@ properties:
       - qcom,sc7180-videocc
       - qcom,sc7280-videocc
       - qcom,sdm845-videocc
-      - qcom,sm8150-videocc
       - qcom,sm8250-videocc
 
   clocks:
@@ -75,7 +73,6 @@ allOf:
           enum:
             - qcom,sc7180-videocc
             - qcom,sdm845-videocc
-            - qcom,sm8150-videocc
     then:
       properties:
         clocks:

-- 
2.25.1


