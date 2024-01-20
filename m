Return-Path: <linux-kernel+bounces-31881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBF8335DD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD691F221E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC615481;
	Sat, 20 Jan 2024 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZEIdAZto"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9715483;
	Sat, 20 Jan 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778384; cv=none; b=YgzNhxKCR+/5l/5DOpZaQLe2uY/EKsQBbyc13oUiGYxrH/X2BW4OH7Jo9qLhx4SZRQkBTHSLS0xbalx/UENi8dcB1EFxbGxRgFOG+nRcuuSZlugJjet3iVt88n/U4qwtlcvQv3JUHtfMJfw1b7Q2S6UnngIlj6+byCzNkg6EKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778384; c=relaxed/simple;
	bh=HDJDZ7O9mdNe/Y3AxDRfD6+ErhPOkpfNXxy4R/TlEVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogRWjDNNwKP5CGssWTYHnTGhTV1aTm/pwhWKG13bo6Qpm3oKn1S0arjGLGFlZB2pjdBm6konhctQlQuPo9kf6i/AjUTkx0ScdOnK/L+/jJo36WAF7+nMoMPMFoMXiumZ2LPgQjMPbFJT68cJQ4DaP0hhYhGMpbyhJQJD3UkAIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZEIdAZto; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KJ0AMg022742;
	Sat, 20 Jan 2024 19:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=JAN4K8Xa62IAsqf/M72hM6xabS3g3wSCJxBQxVgkqKM=; b=ZE
	IdAZtoebL4M0rVhhS7kOf/RVEbUVc6UUgH1e1fk4WpHrJSjZ7qCIlAdC4bc7nW3V
	QyLMbaXWAL4kAg1YKBOzFN3CrH3ff0Di01WZdf0TO5f1RXcGJhrsqkBZz9h8d7/e
	0BbaNgi1L60G/odI01NLjekO3ca/csiUnHs7iJ00RtUQNwLanAAn8+A8QxgnYJML
	SvSUQJTxduKkWuST9mHaNd2pdubOo1YNi2IBAbsDeiz/1OOPu990GZ+xldmB5TKI
	w8NQaZiAFBCP238vmeqThK8qxHi0rMoXGn9+1kaAnNmthDpF1dOZnwiqmRR/vtqz
	2FR582XDUdcAYhr302HQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6d7gxkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:19:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KJJcYd023063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:19:38 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 11:19:34 -0800
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332
Date: Sun, 21 Jan 2024 00:49:04 +0530
Message-ID: <20240120191904.15408-5-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240120191904.15408-1-quic_kriskura@quicinc.com>
References: <20240120191904.15408-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: EK0SSNQfUE-BVe2KJPcrquvVNK8qoj0B
X-Proofpoint-ORIG-GUID: EK0SSNQfUE-BVe2KJPcrquvVNK8qoj0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=286 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200157

For qcs404 and ipq5332, certain interrupts are missing in DT.
Add them to ensure they are in accordance to bindings.

The interrupts added enable remote wakeup functionality for these SoCs.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi |  8 ++++++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 42e2e48b2bc3..770d9c2fb456 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -320,8 +320,12 @@ usb: usb@8af8800 {
 			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;
 
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq";
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 52 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq";
 
 			clocks = <&gcc GCC_USB0_MASTER_CLK>,
 				 <&gcc GCC_SNOC_USB_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 2f2eeaf2e945..a05d0234f7fc 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -675,6 +675,14 @@ usb3: usb@7678800 {
 			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "hs_phy_irq",
+					  "qusb2_phy";
+
 			status = "disabled";
 
 			usb3_dwc3: usb@7580000 {
@@ -704,6 +712,14 @@ usb2: usb@79b8800 {
 			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB_HS_SYSTEM_CLK>;
 			assigned-clock-rates = <19200000>, <133333333>;
+
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "hs_phy_irq",
+					  "qusb2_phy";
+
 			status = "disabled";
 
 			usb@78c0000 {
-- 
2.42.0


