Return-Path: <linux-kernel+bounces-31877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC68335D1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED0A1C20D96
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E110A08;
	Sat, 20 Jan 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U8wa5Pi4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DC1376;
	Sat, 20 Jan 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778371; cv=none; b=Hqn1uUWF8Cs25CWz8pNYdJ5mcDD4tT1kwT2Hj+jSAf/UzeN6Ko5XC0h3sZJchhe0KAUqqHGl/yt6mAmGcKq3ueqRsY/WOceWCR61jShKik3iFQbNNkkE49+h6LmE08Bw9YuMWNnL91m2m6Q/S3pvz+QIo+PDpHSHb1Kr0fO/Jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778371; c=relaxed/simple;
	bh=jjMyJ4ozxhyUgHd47NMzuQZa8zgDtR87dPDE4p9cXXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQqdT9RyOTtCP8+SU6l36CEU6GNQT32kFCGVykzPQI7xHFy+88Jsk6c43KGGWFp4S5AZ3hwtXhoccwkHjjUaTM1MC2FjWlmdrIcDNSQ4khufJ1qOYB4y7cYanYYmxRKdSUnlqhGWpFT+9Q+HDBILKUaHuaVMyo3c6o9Fessy69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U8wa5Pi4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KJJKrH012525;
	Sat, 20 Jan 2024 19:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=LgvFM9y
	2+1N+mHNJh0fXJCCTLD1j8btP1HWxoCsieME=; b=U8wa5Pi4xlxYkkEa/D7IS3u
	/jjcr9NCT6qaKS8HScQFhOReZpLV8ffqO5CkxjPEUHZZIxbc+poRrVBdVTSpFzhY
	sQivzHqf2JZPOCzyZrbao/0HApRBSoFz5zuKHuYzW30Y1x5MutnLx5BRCw++9TAk
	RMFtKLz1qvXdsJTSwP/TtapMPWfb4gETWanEOD+QRR0xje6gjJ4imB7Ej5TH29up
	4FV5dizZJ0bQwnSJrrza6g0Zw3nrcWPbbAxfhtZTZ7jOtsTZHlfd0iUbcvrTWwbh
	j2FKhRkoPnNhDhP525/5QCf1++tUovqf/J5IvQ/kIheSA5uXbJhxRES9BmOx3NA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5gpgywr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:19:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KJJI0h025947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:19:18 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 11:19:14 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 0/4] Fix USB Interrupts on Qualcomm Platforms
Date: Sun, 21 Jan 2024 00:49:00 +0530
Message-ID: <20240120191904.15408-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4EF8uBPrIK41-_G-5CaOpnjq5qBOT4Kh
X-Proofpoint-ORIG-GUID: 4EF8uBPrIK41-_G-5CaOpnjq5qBOT4Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=1
 malwarescore=0 impostorscore=0 mlxlogscore=201 lowpriorityscore=0
 spamscore=1 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200157

Currently the interrupts mentioned in most of Qualcomm platforms
are partially faulty because of following reasons:

1. hs_phy_irq mentioned on QUSB2 PHY targets is actually qusb2_phy interrupt
2. pwr_event irq is missing for many targets
3. Actual hs_phy_irq is also missing for most of the platforms

DT changes made as per binidngs update done in [1].

Changes in v2:
Didn't modify usb3 controller interrupts as they were changed to MPM
recently and I wasn't able to get my hands on missing interrupt numbres.

[1]: https://lore.kernel.org/all/20231227091951.685-1-quic_kriskura@quicinc.com/

Link to v1:
https://lore.kernel.org/all/20231211121611.6765-1-quic_kriskura@quicinc.com/

Krishna Kurapati (4):
  arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
  arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332

 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 14 ++++++++-----
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 14 +++++++------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi  |  8 ++++++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi  | 13 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi  | 14 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi  |  7 +++++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi  |  8 ++++++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi  |  7 +++++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi   | 16 +++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi  |  6 ++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi   | 14 ++++++++-----
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 12 +++++++----
 arch/arm64/boot/dts/qcom/sdm630.dtsi   | 17 ++++++++++++----
 arch/arm64/boot/dts/qcom/sdm670.dtsi   | 14 ++++++++-----
 arch/arm64/boot/dts/qcom/sdm845.dtsi   | 28 +++++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm6115.dtsi   |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi   |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi   | 13 +++++++-----
 arch/arm64/boot/dts/qcom/sm6375.dtsi   | 12 ++++++-----
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 28 +++++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 28 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 28 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 12 ++++++-----
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 12 ++++++-----
 24 files changed, 238 insertions(+), 105 deletions(-)

-- 
2.42.0


