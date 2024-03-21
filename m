Return-Path: <linux-kernel+bounces-109691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451A881C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C1F1C20BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504123BB3D;
	Thu, 21 Mar 2024 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pwqCHxTO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23231A8F;
	Thu, 21 Mar 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002537; cv=none; b=ibajTf5Qo2s+S44CjlfOCK8kgvaiBnRID95FNdAXP6R03en/CbUbjIYN030B6Mol20ku6nWaJGgJzpct7ELwzJhb5kucXo+VPyjqLZAgpBWpCkugR4Dw4bPckL6z7ryPNI8pO+g7LFVKC5bThgNafTgpa5b2plTk/3YMTFRsabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002537; c=relaxed/simple;
	bh=ywXNGWBJIjxEpNqogrBlZNGruWrX8jwMTO9YSyXu4F4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJ9ig4uIuSaIBF/v9lr5Sy0zQchdkB0nTF6paTxDWHx0DQyjABBuEXKZghg5onIqYE5jTkHYpweEbiZCAAYPQHRvwwM5w1IwHI/fB1E0Gqd29sZdmtER2uJ6R2EVuCvKJQIoE2E9geqHaoy3tcem9MDw21H5qobPIEJbSC8LNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pwqCHxTO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L5e3D5013876;
	Thu, 21 Mar 2024 06:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Gr0xlIHCUrVByViKQl4ImMdeIBY9ngvVlNpiaAkbZmA=; b=pw
	qCHxTONBBt99b5+hwVayayqING5nUTjLzP/8lpHc81k4PqUdwlE+/cFXNWXjG08Z
	4V+aK5PPMTaBvm3iJLPen/UP7er4mwm+3JSXlbdq12fDVGOL3rB3yD7hvub6s6Bc
	5onFNkAub1Q91bD1xQYb7StZSUtNoXRCHlHLBTiLAfZTRD+VyYCyG0ER0LKZ0F+h
	tkr5gAlUnsFy+5Wnri88kAyFYge5Jg/8xFrqkihwIjoj05jbQv/rk4kE7f5LoH1r
	kVnat+UlGNjhF66F1aYel15mlirHe/0vFnUn1yyp6N3i0M2vNymPxaQ/LjPxEV0r
	aqVKlYoKBR3Rtywk3MNw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0b548fx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 06:28:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L6So6W004652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 06:28:50 GMT
Received: from hu-ugoswami-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 23:28:47 -0700
From: Udipto Goswami <quic_ugoswami@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8450: Update SNPS Phy parameters for QRD platform
Date: Thu, 21 Mar 2024 11:58:34 +0530
Message-ID: <20240321062834.21510-1-quic_ugoswami@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-GUID: O-BFNXgsrZilb1AeCTTGnMCveJaLJclj
X-Proofpoint-ORIG-GUID: O-BFNXgsrZilb1AeCTTGnMCveJaLJclj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=754 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210041

Update SNPS Phy tuning parameters for sm8450 QRD platform to fix
electrical compliance failures.

Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
---
changes in v2: Recipient list was corrected.

 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index c7d05945aa51..7b62ead68e77 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -467,6 +467,14 @@
 	vdda-pll-supply = <&vreg_l5b_0p88>;
 	vdda18-supply = <&vreg_l1c_1p8>;
 	vdda33-supply = <&vreg_l2b_3p07>;
+	qcom,squelch-detector-bp = <(-2090)>;
+	qcom,hs-disconnect-bp = <1743>;
+	qcom,pre-emphasis-amplitude-bp = <40000>;
+	qcom,pre-emphasis-duration-bp = <20000>;
+	qcom,hs-amplitude-bp = <2000>;
+	qcom,hs-output-impedance-micro-ohms = <2600000>;
+	qcom,hs-crossover-voltage-microvolt = <(-31000)>;
+	qcom,hs-rise-fall-time-bp = <(-4100)>;
 };
 
 &usb_1_qmpphy {
-- 
2.17.1


