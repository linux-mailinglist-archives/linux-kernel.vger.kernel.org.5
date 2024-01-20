Return-Path: <linux-kernel+bounces-31879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1DF8335D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAEF1C209AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437A1429F;
	Sat, 20 Jan 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S9CB13fb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0512E47;
	Sat, 20 Jan 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778376; cv=none; b=izVm0VPr865bKy5qOhh6Ndk9pXWwpnu6Jy3433c4e9U6WoktBfuh7YFu+Zte4BAJFTQJH/MX9UnXXsb1Xl7kmCkgAZQfBuH3KTH1O8UEljqpuBGQdF9YLrQF27euO2BjzlXsU0tT22d+neU1SeLPZZHc/dbWCf64+xAdc3cRfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778376; c=relaxed/simple;
	bh=h5DmxKQFFvgIJrrjpbW4M3LI8nx9/y0ZMVwvNF87v60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5RbtDcDYLs8fd6RmFK+KYDSPuNd7omPQCqmvu+esrDShUhmNpkfSOVZjtvxuSt2h9aBLuIwoA8kAAGkvn7VBiOSVChtH+Em8BQV/ox4ckQFoDRYTo7zXtvK0+xH/AjwBWqWXyOjoYD9n1UuDOlkoqFgA0mlMZNY35Yk8ALIE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S9CB13fb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KIw7BW012281;
	Sat, 20 Jan 2024 19:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=YAjjipR4ICPom4WFSbOfnTKRrAYXuCmcdtEdNQ1KUxs=; b=S9
	CB13fb/CjGXewCG/2G5pS6TJ/irFU/gQ0YRfGaqTtmh0Ow+Vx5fCJtFRBnQcwtLY
	z8sj0fXYmRB/rkrvEVlHrnltxhwFwJ6lw4Yztj6XLuVYg7aDIs3gq70mxotBKSKI
	W9QX/67VC9+tU+X5ec84PZ2WjDiuxgzfj0l+OeDwsuzSOvlNoF3TUeyqjrjy1pzO
	3mD5iWRC8IoSUcDKgeRci/olpW778TmjSnVof2VNR1prTXQCY5GCQxGr55PzqMep
	C+JcqFBg3FgPytOF3Upf7/1hwQ0ZBIo+JH3Mmr0Nh3FPxmDTs+F30YI5euKX+2aR
	GyquVIzjZhArxqCE9zaw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6jbrwqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:19:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KJJN17029419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:19:23 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 11:19:19 -0800
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
Subject: [PATCH v2 1/4] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
Date: Sun, 21 Jan 2024 00:49:01 +0530
Message-ID: <20240120191904.15408-2-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: tDF_5opXiX7OaB-H5ki7ffN4brxCxXjy
X-Proofpoint-ORIG-GUID: tDF_5opXiX7OaB-H5ki7ffN4brxCxXjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200157

On several QUSB2 Targets, the hs_phy_irq mentioned is actually
qusb2_phy interrupt specific to QUSB2 PHY's. Rename hs_phy_irq
to qusb2_phy for such targets.

In actuality, the hs_phy_irq is also present in these targets, but
kept in for debug purposes in hw test environments. This is not
triggered by default and its functionality is mutually exclusive
to that of qusb2_phy interrupt.

Add missing hs_phy_irq's, pwr_event irq's for QUSB2 PHY targets.
Add missing ss_phy_irq on some targets which allows for remote
wakeup to work on a Super Speed link.

Also modify order of interrupts in accordance to bindings update.
Since driver looks up for interrupts by name and not by index, it
is safe to modify order of these interrupts in the DT.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi |  7 +++++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  8 ++++++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi |  7 +++++--
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 17 +++++++++++++----
 arch/arm64/boot/dts/qcom/sm6115.dtsi  |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi  |  9 +++++++--
 8 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 5e1277fea725..ea70b57d1871 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -418,6 +418,12 @@ usb2: usb@70f8800 {
 					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
 			assigned-clock-rates = <133330000>,
 					       <24000000>;
+
+			interrupts-extended = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy";
+
 			resets = <&gcc GCC_USB1_BCR>;
 			status = "disabled";
 
@@ -630,6 +636,13 @@ usb3: usb@8af8800 {
 					       <133330000>,
 					       <24000000>;
 
+			interrupts-extended = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "ss_phy_irq";
+
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index cf295bed3299..c2914f827a7b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -627,6 +627,13 @@ usb_0: usb@8af8800 {
 						<133330000>,
 						<19200000>;
 
+			interrupts-extended = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "ss_phy_irq";
+
 			power-domains = <&gcc USB0_GDSC>;
 
 			resets = <&gcc GCC_USB0_BCR>;
@@ -669,6 +676,13 @@ usb_1: usb@8cf8800 {
 						<133330000>,
 						<19200000>;
 
+			interrupts-extended = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "ss_phy_irq";
+
 			power-domains = <&gcc USB1_GDSC>;
 
 			resets = <&gcc GCC_USB1_BCR>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index ad2f8cf9c966..8bd1499b5c8f 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1160,9 +1160,12 @@ usb3: usb@70f8800 {
 			#size-cells = <1>;
 			ranges;
 
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "ss_phy_irq";
 
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8d41ed261adf..600720d3a8f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3408,8 +3408,12 @@ usb2: usb@76f8800 {
 			#size-cells = <1>;
 			ranges;
 
-			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq";
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq";
 
 			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
 				<&gcc GCC_USB20_MASTER_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 2793cc22d381..348eee866451 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2132,9 +2132,12 @@ usb3: usb@a8f8800 {
 					  <&gcc GCC_USB30_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <120000000>;
 
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "ss_phy_irq";
 
 			power-domains = <&gcc USB_30_GDSC>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 513fe5e76b68..940901474804 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1281,9 +1281,14 @@ usb3: usb@a8f8800 {
 					  <&gcc GCC_USB30_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <120000000>;
 
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq",
+					  "ss_phy_irq";
 
 			power-domains = <&gcc USB_30_GDSC>;
 			qcom,select-utmi-as-pipe-clk;
@@ -1463,8 +1468,12 @@ usb2: usb@c2f8800 {
 					  <&gcc GCC_USB20_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <60000000>;
 
-			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq";
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq";
 
 			qcom,select-utmi-as-pipe-clk;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 160e098f1075..cf8e72f06f8e 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1586,9 +1586,14 @@ usb: usb@4ef8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <66666667>;
 
-			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq",
+					  "ss_phy_irq";
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 1dd3a4056e26..00a2e0980163 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1185,9 +1185,14 @@ usb3: usb@4ef8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <66666667>;
 
-			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq",
+					  "ss_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 			qcom,select-utmi-as-pipe-clk;
-- 
2.42.0


