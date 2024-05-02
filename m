Return-Path: <linux-kernel+bounces-166175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A28B9728
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D1B28354D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DEF54646;
	Thu,  2 May 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D2qoC6O7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E455466C;
	Thu,  2 May 2024 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640657; cv=none; b=Z66PODFKfzr5CLwFX07AGgAQcW3khvqRy8aM6WnN5pxvT5QNOdDvHUBoXcIrvVL/Nnz1r/wYO3+6xMxv5Pq3Um1zrSpIOzWi1GZbjnvJEBqGpZ5hVEpqyjKATIUbaAoHp13MfpVmK9AJW21/sflJiqE9xDuYggMve6231eRAFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640657; c=relaxed/simple;
	bh=6ybnRSgzmwgQhvj2h0wA5WBI6u0bsgXxQhPo6NKgvDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRZbSpe+G5tfqYW+O38Y6NRLKIpANPjJu5XQG4EyP10+WTWgzNaCg8IIr12oTUm6b5fnASD1ojQFXnKH1RnlvVVWbXCbEk4muhiUP5hCyxk8C87RqtDVNeUsUwPdnsO+ooUsHdRPk8Jua97z7XJekfHLWX3dxrPAKDXBhvyjbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D2qoC6O7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4428uIDQ024281;
	Thu, 2 May 2024 09:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=56YwCakw/N/Wc/uAVUqHrPlre6xDW45zzKL9YBLI5ZE=; b=D2
	qoC6O7FH4Ul09kIEB4WfbywXfx4/A03nZ51YBBbTwCReLsE5/8xepl4faDbN/DxT
	Ok6bWrylq9jewUheUWEIuq2jfQtV/6vKCxr5jvjEjK+ohVdmlTzVuWgTqDqiUWVr
	WlJonHAWDqyduSeZ7XCdvO/EWFm593hKkmP29n4F3DhIgnsjw8bV49MuWLx4wKRF
	cCF2MUkYKatsphC7fb+mSfOIhFgeJnQD5vFIcoNt/qgggdSZHUh0Vg11ym4NXpu5
	MjryeN/lw8IPSo2TVnRjhmJ2DwcEY5cYnGlv2AanpyjUmXCYGstRneMnMhUaYFaE
	7rY4Wzf0axDQYLJ25PUg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xud76axmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:04:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442945EU004937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 09:04:05 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 02:04:00 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_ppratap@quicinc.com>, Jack Pham
	<quic_jackp@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Amrit Anand
	<quic_amrianan@quicinc.com>
Subject: [PATCH v3 3/3] arm64: dts: qcom: qru1000-idp: enable USB nodes
Date: Thu, 2 May 2024 14:33:26 +0530
Message-ID: <20240502090326.21489-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240502090326.21489-1-quic_kbajaj@quicinc.com>
References: <20240502090326.21489-1-quic_kbajaj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qruT8GfQ36aZWrjg0pEqTNA5jdVeS7Yc
X-Proofpoint-GUID: qruT8GfQ36aZWrjg0pEqTNA5jdVeS7Yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=388
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020053

Enable both USB controllers and associated hsphy and qmp phy
nodes on QRU1000 IDP.

Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index 2a862c83309e..1c781d9e24cf 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -467,3 +467,26 @@ &tlmm {
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


