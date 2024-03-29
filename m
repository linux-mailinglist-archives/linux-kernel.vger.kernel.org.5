Return-Path: <linux-kernel+bounces-125457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105B892665
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524101C212FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9013D608;
	Fri, 29 Mar 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p39zoa3m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D813CAAE;
	Fri, 29 Mar 2024 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749251; cv=none; b=A6IfMhgxzaKTdog5+BdB8D+aFf40E9saOQf1Dq2QVBIDdZXvKwW3BJSk7ero1mku7oKeiPX8mnm1GUhzC4rzUbWVbeMwxg1kvVKPA+XxBQHu1PatE2RqBe0lm8eiDo5lL0fbj1j2Hfi/l5krZg/kC4+agIdHvcZGtXbCQB7NaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749251; c=relaxed/simple;
	bh=ifxFGRwsRJfO5TXfbgQ7sNWVRJ8jAHsBVT4dQkAN6HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QIVlsdiXNLd64m2Whn0QhHvf/OVsbvDH7CoPQcS1Lt0QhIzxSpZ70j2e3Wpqhkw/zDofHf07jssjDja9YYLC37bzlvaTRNB/KvoFdu3N4AJ4Vw1TGfnfu1ja807G1w9ni/erkTadqGkvIoU2hO65TITF+TnBaUOgml9Ubelhgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p39zoa3m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TIV6jl004192;
	Fri, 29 Mar 2024 21:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=f6Fn2TRtlo8N69ueJZoY1tzNFkb4NbjxH6a1gE1ZJ8A
	=; b=p39zoa3mtBJOnSKPpIYCAp/PlI3inQmCaScvTIxYufw/CR9zGCvBjd0kwJz
	RBtMYh3pJZzvqxVWCKNkqqCVNMO8dspqw73nkSQTfb43dakhCwAmU0zKdjhkbrpN
	MqAOVQPYIJAFlpHM4pzyjPxCivieNttnwcjpAJTEUKUNbqfGfs5yJOZYwv9bTtH8
	cx1mCK2rVT+vkyAmk38229y7s7aLsrJ9c9GpmaigE3+iFmjhgfjlj54EDpEilNfd
	UcLVzKM1sezjhiGunYiZZwX8iNb2pYCDQmP0fbRx3yxU0nnoRSG9PNna2DZ9s8H/
	w3QB1g2ZOZwaOwXkAIRgXnLMqyw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vn99c3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TLs4ho024078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 14:54:01 -0700
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Fri, 29 Mar 2024 14:53:43 -0700
Subject: [PATCH v4 4/5] arm64: dts: qcom: sm8550: Add Broadcast_AND
 register in LLCC block
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-llcc-broadcast-and-v4-4-107c76fd8ceb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711749240; l=1395;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=ifxFGRwsRJfO5TXfbgQ7sNWVRJ8jAHsBVT4dQkAN6HA=;
 b=dE9IIWSgcF8Rl1SK/QJb/LO0zLdVZZVnbF+HDiTO/86/PBsQrXZyBdYa6L33s440IiiEkzqlV
 IcwHtn9trIrAEclVXb+RMILlgzNnwskLai+gM+MECCxxi28dZGL9JsR
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LtcJCGXc758ATKDJ6D6XREvi51spjC0z
X-Proofpoint-GUID: LtcJCGXc758ATKDJ6D6XREvi51spjC0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=907
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290194

Chipsets before SM8450 have only one broadcast register (Broadcast_OR)
which is used to broadcast writes and check for status bit 0 only in
all channels.
From SM8450 onwards, a new Broadcast_AND region was added
which checks for status bit 1. This hasn't been updated and Broadcast_OR
region was wrongly being used to check for status bit 1 all along.
Hence mapping Broadcast_AND region's address space to LLCC in SM8550.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 3904348075f6..ee387e6f9832 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4263,12 +4263,14 @@ system-cache-controller@25000000 {
 			      <0 0x25200000 0 0x200000>,
 			      <0 0x25400000 0 0x200000>,
 			      <0 0x25600000 0 0x200000>,
-			      <0 0x25800000 0 0x200000>;
+			      <0 0x25800000 0 0x200000>,
+			      <0 0x25a00000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
 				    "llcc3_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 

-- 
2.25.1


