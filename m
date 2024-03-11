Return-Path: <linux-kernel+bounces-98803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63517877FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9528C1C221AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8ED3EA8C;
	Mon, 11 Mar 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BuDzBn5I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622853D993;
	Mon, 11 Mar 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158976; cv=none; b=Cxzc38eSwWNjrY+9qA1UaTxr0CaLsNrja2N7YWaEs2JNtYjrSeRsT4qvq/ooRUUiHxKMMmiyaqVUogLrUJB4F+JCjIIxStV+/g14gw91+Wp9UKinK/b/3MrV+ZInScaUUbfrc1xqJR29zA32vh5y++lihtjkSgHdo4aJBlDD9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158976; c=relaxed/simple;
	bh=e5OS2KfZqUi34EN6ljOccopSAjuFfJjxXLeZrZr03QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEDyi6mVLS878ooD18u6vfnf4UmJSQn4w/9rEAlD4jLZRmubgjMk3Q+SN+vnrKfNgDzTu6aJS2jRuU3RCEiU80MiO6NsEcH7R71AmwzoLLGhJ3EYB16mnK2pMFhYOlCCsyEaC3NL32J/HgeNipcA4tN6lW1J1tX4soTPdKprzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BuDzBn5I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8UbNR003610;
	Mon, 11 Mar 2024 12:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=IY12m7kSau4xhDZbnr3l1VJ1QRoDlTjAgYO72RMf2II=; b=Bu
	DzBn5I4t5oA53r1O+1WhmTcZxA4v94JiD5wUSi/wSeNh6iyOuFPwUWNgTj62QNRv
	PqSXihV/1bhERM7ENOPRT/eJsSIVHTdrANCuYAURt0jXxgQiZawpORWKfWVfyZUu
	ybbw6+sIGlLCyOs6Gli5N544FDpuO3L9f+w8OfBhuVCCMi8p4K9jMSG4JGWeaxye
	uvrb40T6B78pv8Ebh6NogrIPqWFfO310xte8Hmh/pH3Nj3fa/4Ie2S8/O2qZ/1it
	URfnKR4XP/QVeUVkO8c+GUlV/V5sxldJdmVE/xZHEX8Y7lvutDCngWDkBk2YMDHM
	3fQ8CRvPzqUphqttJpKQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxgt8j2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:09:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BC9V4E024013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:09:31 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 05:09:27 -0700
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
Subject: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
Date: Mon, 11 Mar 2024 17:38:58 +0530
Message-ID: <20240311120859.18489-3-quic_kbajaj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wpAVeYzALC_HhE4XJ2QCbtxPXDCpLfs2
X-Proofpoint-GUID: wpAVeYzALC_HhE4XJ2QCbtxPXDCpLfs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=358
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110091

Enable both USB controllers and associated hsphy and qmp phy nodes
on QDU1000 IDP.

Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
index 89b84fb0f70a..126bc71afd90 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -500,3 +500,27 @@ &tlmm {
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


