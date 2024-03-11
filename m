Return-Path: <linux-kernel+bounces-98804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C5877FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE32281266
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687363FB3D;
	Mon, 11 Mar 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQSVneRy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1193FB3B;
	Mon, 11 Mar 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158981; cv=none; b=aTsFuP82Rt2Yx3Km4cuu0cZlQFyPoK1NaQc03vsk3ZtmftCn24JZ8Fkx8YxB04iMPitgcyMgnPnWBBUIBgn/ZXNTRs1zP2rXGQSTPsvf/mOltGh1GiGwvyLWNFCXfdpMxvO5TrKr+VyaU5ExFSxJOx240KKSzbbkYCLLbhLv9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158981; c=relaxed/simple;
	bh=Pmrmyq7URfLf09kUtXkpAtdm6Y9SQW9j2YoRGpPDU8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ8UDo44gQid7aTnkFH5u/dWzsMfq7CMbTjlCZqGzIYUPgDpgC/iuX7gP/Uh3p7WW4w8zJUCxIFZ+xHMxeaKUvmBnHVsE0XRTeQ691eQPLT7DgqebzjGWkvnjDX9ANzScKvqXJFdBJ6zJSIVSU7ZOkHKEMXywwFuxMdYrywwc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQSVneRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BBnhAA016808;
	Mon, 11 Mar 2024 12:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+oUg1sXv3xj6/5EFsJRFeSLvuYL6dZItyPy0usT9Wzw=; b=lQ
	SVneRytmOaqPEfK9h7ryNuL6ZSrIiN52tOp8KBjjhJkEHsrrOObGyQMqpvDCOkGv
	mRuBarhNOMHEKWEZp2Y2sepoFilnBOzKAx9vzrerJede9Madhtq3cADqzRCx7LJA
	wi2jEOLqI1TeprzAY/bLjjceTag25Pt2+Rc1+eXRsv0lEpKZ/vbesiFqCLt3nGtb
	L2ofN7vWn5OiaDP7XDnRtjvMoK2tF5gmBe+8ewDmn+l3AYju7mXC4MxOXt1ecM6C
	4sVIBSil5qpL+1ef7G0CDtKepFYAytOH0aIV7UzBGG/tVAruqmjapYwZo7CCT3M6
	JI0g+HeNpHiTR1GmH6wg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt1dwg1h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:09:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BC9ZEM016045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:09:35 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 05:09:32 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>,
        "Amrit
 Anand" <quic_amrianan@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: qru1000-idp: enable USB nodes
Date: Mon, 11 Mar 2024 17:38:59 +0530
Message-ID: <20240311120859.18489-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
References: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _17xmVMVsZIk9d6ktYGAIRfRwSMgUr0D
X-Proofpoint-ORIG-GUID: _17xmVMVsZIk9d6ktYGAIRfRwSMgUr0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=358 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110091

Enable both USB controllers and associated hsphy and qmp phy nodes
on QRU1000 IDP.

Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index 258483af065b..c4d8027b8b20 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -467,3 +467,27 @@ &tlmm {
 &uart7 {
 	status = "okay";
 };
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l8a_0p91>;
+	vdda18-supply = <&vreg_l14a_1p8>;
+	vdda33-supply = <&vreg_l2a_2p3>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l8a_0p91>;
+	vdda-pll-supply = <&vreg_l3a_1p2>;
+
+	status = "okay";
+};
--
2.42.0


