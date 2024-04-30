Return-Path: <linux-kernel+bounces-164386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F28B7D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC4C1C209FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF7181CFF;
	Tue, 30 Apr 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T9nHxHti"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC21802D9;
	Tue, 30 Apr 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494725; cv=none; b=qgl2v2i0nJmghbTvTH/Nu9mOQ1A3LwLrrBx0+wJsP5Ihebt77H9O6WHjavtAMbbagBFqlhZKQU+vQoPHybxk8VkpK241qbcohxiUUVipxt251COJPr9fxwmOPhtDipRJ9eFSLCQxFdCf6Hs5MESV8XHdOgaWx9MN0jSNfRWCEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494725; c=relaxed/simple;
	bh=eEwpKA9eimH5IItZ7lk5+yvlBFgoCmRBmu4D4mg/9BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HRE8eplFdNux6NE4ZOaTLS49vRARe7zqJHJxop/OFSwc78labod8vhOjPSCxs4jiMElVvL0wJU++ooWKnKhiE/5OVIjfaYdME6lYMCDLrNarv/a8QKGcPZlDw84NQOK5uqsfJq1ruH4fyj54MnHNUuRz8HWFqUixu4jRaYGkWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T9nHxHti; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U5ra8g022930;
	Tue, 30 Apr 2024 16:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=ZAl/Q23+BAwdfUELEQHpiOL1cbIeVR68SdsEy0W+5e4=; b=T9
	nHxHti0OnqT7Sd9pANlHpHnzXQST5EoqLFEdFcWrTSJs5+OBcqvd9sFVmsvPcp/w
	wkf+D2zGm8dZHjmP1GuFsfjmKKg724BIyRPx3tC/GiV+PLANlo/EHiRfPdCB1XAJ
	n/X5XrWYproj1Pbm9K6TneM1F3sR5xB34DvNBbF00ZwsTgC2Wa4TpKMltAt7OkGt
	QTBRUNF5Xvd2AX9zChr3jFsJJmYktn6EDikr/92cINO2XAVQsJn6BuHikdHVr28K
	ECD82atQEo2c0+GGTnZjpq22hhblbFvKg0ZdRTT/ZrFtveKm8ASBgytsTtsnXjZ8
	WdXq6+UBDbUVY+fYoW1g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xttw3hghg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:32:00 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UGVv7O003714;
	Tue, 30 Apr 2024 16:31:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1f8a-1;
	Tue, 30 Apr 2024 16:31:57 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UGVuDP003707;
	Tue, 30 Apr 2024 16:31:57 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UGVusi003706;
	Tue, 30 Apr 2024 16:31:56 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 281872287; Tue, 30 Apr 2024 22:01:56 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: qcom: sa8775p: Set max link speed to gen4 for ep pcie
Date: Tue, 30 Apr 2024 22:01:51 +0530
Message-Id: <1714494711-10322-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5u0jMRtzRv-YDDqs6mNpW42F34t2HLiO
X-Proofpoint-ORIG-GUID: 5u0jMRtzRv-YDDqs6mNpW42F34t2HLiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300118
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Adding this change to set max link speed to gen4 as sa8775p supports
gen4 so that pcie link can be enumerated as gen4.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 0c52180..aad2cd7 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3730,7 +3730,7 @@
 		power-domains = <&gcc PCIE_0_GDSC>;
 		phys = <&pcie0_phy>;
 		phy-names = "pciephy";
-		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
+		max-link-speed = <4>;
 		num-lanes = <2>;
 
 		status = "disabled";
@@ -3888,7 +3888,7 @@
 		power-domains = <&gcc PCIE_1_GDSC>;
 		phys = <&pcie1_phy>;
 		phy-names = "pciephy";
-		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
+		max-link-speed = <4>;
 		num-lanes = <4>;
 
 		status = "disabled";
-- 
2.7.4


