Return-Path: <linux-kernel+bounces-54409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC084AED9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67D328B134
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A712A152;
	Tue,  6 Feb 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FPafA8VX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF564129A6E;
	Tue,  6 Feb 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203779; cv=none; b=fZMouo0su2lbQ6YpccDFiMlq1VVbzc8It86yuCvUmrgCSQnWAF9Mk8xBEDsy741BcHfD9z1GmlWHs+MI2S6N/cC8Rk3e76mPrRN7HQBWEkSkMIVJP5Gquyz7BDVDw4gmnMr6FSK02tCrYB27IrsGd8gBn9hjgdezp+LG+bf/YNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203779; c=relaxed/simple;
	bh=9Xn9HY2ZMUXFU2z8kP3lVZnvT0TyWycwArAs9PhAWuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuAAXwDIFSPcrOVQrQreiQZwt2VVAnHka/8vLN9TSyo+PDcoMfocKQ0ldmB1bNpAx3wG0CivHKgp86iTxST5/9GGO2uEP/d2ISvBHJe9qNmafDiLMOz03uXDN3MtUeZ+rBdtDXZ7WGazjsicKkIkl9P5hNwoxL4mMpH49uiI/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FPafA8VX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164VVu6025246;
	Tue, 6 Feb 2024 07:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tfk2oZMBY1QjYgBmALjMym7en0dKS68Xzwz2ZK1Y7io=; b=FP
	afA8VXZQxI28oWy9+lwKs+/EEz6eGA/kdszKBxmR12iT4fzFqAAV9cy0VgHNpqh4
	uwp3Wra8AZ5xRn3wSi3KD8ZFOZCp4Hvz5GpLK1SV9Of8sSDw1tWKceEiaIUFaXy3
	wsdgDPybbRn2U1w7KexNElIdX+v/x/YIQBBIcg1wC2t/pCNPnCel+stGlJ9sNljl
	1OeFkYC6BHwtkOl5KEzzI0Sldoj6M22h2dfdCRYtNtkEpB8eZ9m4kWCzyYVByZuI
	+O6CgJxtJv6CJYyp5RKfEdNmlW6zgHqhSDKO3eVjBwdB0dabcHoWu8ReAiP28V3N
	0edsFjlpopiyIwmERsvw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnsvjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:16:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4167GBg2010380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 07:16:12 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 23:16:06 -0800
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
Subject: [PATCH v2 2/5] arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
Date: Mon, 5 Feb 2024 23:15:53 -0800
Message-ID: <cf138f258ecbfbcc94717e4914de2f60153e5abb.1707202761.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707202761.git.quic_uchalich@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tBBq-6zhoctrjYMxWTJgYlinJGZHMlnY
X-Proofpoint-GUID: tBBq-6zhoctrjYMxWTJgYlinJGZHMlnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=505 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060049

Mapping Broadcast_AND region for LLCC in SM8450.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 01e4dfc4babd..d2d6fae55e2a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4306,9 +4306,10 @@ system-cache-controller@19200000 {
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


