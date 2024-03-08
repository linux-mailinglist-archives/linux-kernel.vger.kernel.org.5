Return-Path: <linux-kernel+bounces-96562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AD875E35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31F51F24230
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6224F61D;
	Fri,  8 Mar 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n68LeM5C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F74F1E3;
	Fri,  8 Mar 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881519; cv=none; b=a38fAS7sS67R3HudFesWQ+/8oB2chhUx9MIAwsiyRlD/1VJI42tmMFvAnLWcTc1XoatsiGmvxITT+1eJLST+eW/rHcB8fjOBW+NybCx1bBO34k94kHwzD6PkmCuEJlVl1DI1LRyTuKPqUiHkL4/L/IM6CBBrxjxTWYj0HQb3qkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881519; c=relaxed/simple;
	bh=auAvfyL9/NwjHofiaKdvsJ5HRwI2wB71jtofGwEUZWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEoMDRT1dcFT31+Qnrebh1KGNC0ctvrvZLjstrzaTMQeNSvGjF2XamBJLvNC3b6aFFgg6s/kiMRIPiAm7L5ZGsaGfOfm8MxibhGfTN/+DlPdoAG8xKEfvNnTUyVyYkR9stF3HeXFFtBKSVp9+vSbYkFBrTsYbUWqMOwjOeXnHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n68LeM5C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428500vQ003427;
	Fri, 8 Mar 2024 07:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=/Gzy0NVAYZAyiNrJSsU8
	SKqXKEm4dQDEhjgs1vOJrVk=; b=n68LeM5CfFPh3rcOP+QJyyOAXQzqqltN4xLC
	8SBWroVZwMk6Mrkox0u3WGhdYWRWOxAuN2XlVYjfOqGqcsp0hiYeJQYMxBLK4R8X
	1uKVpRNNmMNwAgpeZLEDtopF1f7e/urqwIjYjMvOSeYKAZ/s7Ux8gs+KvGF49vt8
	/eFOluLUVosixsPhUal4TXLou3d9LMWp/z99L76GXo4KPJmbA+/LHBn/tDmYiicr
	RbAohQ2HHHTihG5QvduL83mgJCEnq9IOghS5fuprvA6ayUBYhFyqQUfwj3374pIL
	eqtE5AgTBsbykaH1caDjIorKsQ6K6jI9BPw5/1HqRRtGtrA+QA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8q12k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 07:05:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42874xhB009620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 07:04:59 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 23:04:53 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v6 1/4] dt-bindings: arm: qcom: Document QCS8550 SoC and the AIM300 AIoT board
Date: Fri, 8 Mar 2024 15:04:29 +0800
Message-ID: <20240308070432.28195-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240308070432.28195-1-quic_tengfan@quicinc.com>
References: <20240308070432.28195-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jKjIuDDMWrGkmVF37mKFiQ8mE7aBX5F_
X-Proofpoint-ORIG-GUID: jKjIuDDMWrGkmVF37mKFiQ8mE7aBX5F_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080054

Document QCS8550 SoC and the AIM300 AIoT board bindings.
QCS8550 is derived from SM8550. The difference between SM8550 and
QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
in IoT scenarios.
AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC chip
etc.
AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..8115088a6076 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -42,6 +42,7 @@ description: |
         msm8996
         msm8998
         qcs404
+        qcs8550
         qcm2290
         qcm6490
         qdu1000
@@ -1005,6 +1006,13 @@ properties:
               - qcom,sm8550-qrd
           - const: qcom,sm8550
 
+      - items:
+          - enum:
+              - qcom,qcs8550-aim300-aiot
+          - const: qcom,qcs8550-aim300
+          - const: qcom,qcs8550
+          - const: qcom,sm8550
+
       - items:
           - enum:
               - qcom,sm8650-mtp
-- 
2.17.1


