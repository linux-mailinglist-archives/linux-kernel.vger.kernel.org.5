Return-Path: <linux-kernel+bounces-125459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D589266B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4821F25174
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F713E048;
	Fri, 29 Mar 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RGh2dCTw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF913B2B2;
	Fri, 29 Mar 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749267; cv=none; b=A+wV+ByhnyjOs5oH6t2nZUzhPRL2opCCaNtoYTDJZ/QOcLC50qUz7F0/CRWxrdCdEmvqWlE6AgxQHN3kwQM1S6bVRC39TQ8Qnxvh5utVJ61xVkc4DnQolPHAk5MTTjHbTVqCpLn7m8MKVmrvLnBphvJp2FjiGKSPJho2f0dJZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749267; c=relaxed/simple;
	bh=w6N/Yt5hjIFG2jZDsiAgK3w42G+Nng+5NoZGH1HWB0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EJs0o4ITG3mVUnlVLtuXr/beyQbckSLC7jatDfp5+nn51nt9Zg9lrWD8V33EyOA93XH+xXcFZbmfhlJ+3HbUQeyIU/fjQDnZ7jP4eJy5MxwHF1rrjdg6GfVClGX61HQlOkbGI+gNZyA95EGnZf3Y9VGcv3qbPxR2KRMCS32bGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RGh2dCTw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TLj10T021877;
	Fri, 29 Mar 2024 21:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=lOWvl2AgS//hWSg8YAISnDnOWFIyXraa4ZZssbcYZqE
	=; b=RGh2dCTwYZBsCp28bddEn+4GtN9RuAT3SbV+dq2xfKpRayIVxzSeViQ2rmP
	WwaM0TpUmBqOlbwPeJJrH0Kftp83+RRSDalX8Netr7a9eTy2nbB70eCMtsdTrIQD
	LHiHCHbMoF6h6POqhyYOInae5nCkngppQlZIRMO7HlvUQbU2Fc+wQ29Mig7QRxfe
	14PROZfhCzZTC4utMQM6GPxOAlSMxl6lbopWhzsfSSPDIZGY/BWb1+iEE8/Gpah3
	RK1EIZMluGG9+ct+OYb7gd2an0ZlppKvfZ5p97dVW1ejs8/Af/uVa3Rw46Z7roHI
	Fr+7KqqrqBH5h8SqDpWOLk7RMrw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5uccsnf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TLs4nx002079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 14:54:01 -0700
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Fri, 29 Mar 2024 14:53:42 -0700
Subject: [PATCH v4 3/5] arm64: dts: qcom: sm8450: Add mapping to llcc
 Broadcast_AND region
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-llcc-broadcast-and-v4-3-107c76fd8ceb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711749240; l=1034;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=w6N/Yt5hjIFG2jZDsiAgK3w42G+Nng+5NoZGH1HWB0Q=;
 b=lNIIje4/dUOl2sD1AjMlpnH1dcYfmyhMuZSj/l+mHy1kSw8bzpmz06MHFq03SDoWDq42Q+V7z
 ump2U+RjWzcASpe8dWZiopdsynqIcLPJ36MYjCTPUZEZkwn41avOPyc
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ix9vk9qqMclOlzOBtNuAzl2QBH4UH1CT
X-Proofpoint-ORIG-GUID: ix9vk9qqMclOlzOBtNuAzl2QBH4UH1CT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=542 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290195

Mapping Broadcast_AND region for LLCC in SM8450.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..72587b9c7bba 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4347,9 +4347,10 @@ system-cache-controller@19200000 {
 			compatible = "qcom,sm8450-llcc";
 			reg = <0 0x19200000 0 0x80000>, <0 0x19600000 0 0x80000>,
 			      <0 0x19300000 0 0x80000>, <0 0x19700000 0 0x80000>,
-			      <0 0x19a00000 0 0x80000>;
+			      <0 0x19a00000 0 0x80000>, <0 0x19c00000 0 0x80000>;
 			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
-				    "llcc3_base", "llcc_broadcast_base";
+				    "llcc3_base", "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 

-- 
2.25.1


