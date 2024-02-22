Return-Path: <linux-kernel+bounces-77483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A8860636
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA171F255FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051B1F92C;
	Thu, 22 Feb 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bJ4EgVG0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C617BD3;
	Thu, 22 Feb 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643297; cv=none; b=dQ6P/kEhy/rRnTidXJKherMVkziM5AhT49wrxlMRk2VMNd56r3zTJukxmj2SzD9WQnrrwVGVQLljvaxBix1dUiiD2BieK8PYUlgrt9CMTkpbnNjWIcT4XN0s1dELnGobD8rFZJpyFAF+FYa48mb9xHwlvR6a9p7Aci7uzE+ZpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643297; c=relaxed/simple;
	bh=9Xn9HY2ZMUXFU2z8kP3lVZnvT0TyWycwArAs9PhAWuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxtZ3NkwUfDsmern0HNHtiv+LF68zGvOmsRPdA7yt47Zur5x/IuiGveZk0Ca84mu3/H3Q1gICO2aO7tOrY8w5ezZXYHhPo32jPIaJrVC55gKvK6C22Hql9y8mTbjd/p0WEyYzlWVXSsRN2wHstKqDOc+EaYzHbBZrOt7Ph7j+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bJ4EgVG0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MBgb8G012091;
	Thu, 22 Feb 2024 23:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tfk2oZMBY1QjYgBmALjMym7en0dKS68Xzwz2ZK1Y7io=; b=bJ
	4EgVG0+BjSjiwooXygrxWo08/umyd4TA7kGRLoraoFrVTu5vD81+PZ6W+nuDcylY
	L0zvYLn0oZs7znxGtjQZ2fbNPcUK3EBWodOl6BckrkmPKL8CCtGQZPFuOUgQk7Fz
	l9nsgRutqtjxqL5pMwo+bd1kPgBS3zwa7UTnQRbjrhbS+V54yxk3UOdcYFA8xUFJ
	pukcrr3AlCe+DAeTulcTaKslx75OLdKcKgGanjnA027ckYZR5PK0587IE7FkQjVQ
	qrbNJ8mRO7BfWj730izCUxvIzfcisK/uuRgqUYTFbVVu7ysgw6GGsKkHm5REqCbs
	OUg37UEuiJso+QOdgJng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvwwbhqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MN8A82029081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:10 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:08:07 -0800
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
Subject: [PATCH v3 3/5] arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
Date: Thu, 22 Feb 2024 15:07:55 -0800
Message-ID: <8b626c328bfb3ae297a228a6821471c4fcc2ec70.1708551850.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1708551850.git.quic_uchalich@quicinc.com>
References: <cover.1708551850.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vfA18B79-LNLTJ77B5ewDPf2rntPZouV
X-Proofpoint-GUID: vfA18B79-LNLTJ77B5ewDPf2rntPZouV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=618 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220178

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


