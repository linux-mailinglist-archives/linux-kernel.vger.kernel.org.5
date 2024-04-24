Return-Path: <linux-kernel+bounces-156516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A66D8B03B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F14028210D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5196158A1B;
	Wed, 24 Apr 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i2PJh4MZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A0158A04;
	Wed, 24 Apr 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945575; cv=none; b=dG87/rS3k5UPnTXB6+l4DUZ5dpX1o24p9VpT8wIbQknAKBj8itqyXhfswbFHrbFEfg0MtsryEsROiy11Fw6avdRwZr43CploBcQuno+uOCQHRmv7C6egtCvs9e7EvJlA8YhtR8IRAcK0+vN9G2yBjYQknyi2MaKMYt568Q60Rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945575; c=relaxed/simple;
	bh=csO/FoGDnIqZPOwAfcbC3nX1T7SQM6BW0okYxFMh2/c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LO6LpPPEsgYn8ZNT02G6aMWZlRPdgd3YoqA4t8QvJmJJvBYsGrxyJ0bwOmqwsPchDLjjIjLSvAgnH8i71wpdqp4e71YERjN8Vx6g1J7GCJOeLvUiHLiwR7lmBSNMNnAE1VKwzQaGnDc5ykSsIZezIaOFHJY27mXP+7+wzD159oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i2PJh4MZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6X04K016507;
	Wed, 24 Apr 2024 07:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=PEH4sUji3MUL
	6m2mb+lBXxIoyjAO5ggAPg0WEO6ThWQ=; b=i2PJh4MZVSEqOo1JbTD8XMIAAc0g
	FBviwqZMAp6q6Hca/ogvFpHznnsSak5C91w7/QfDNAiLAc8VVyHqR+JsH3FMJ8fs
	0rP4jW9YvzkXWsxxtnd8AI3EuYrEMAvhRKd68N3o2loU4N2bMkEDqpVr8D5V0uxG
	y0DNGeMbWZA92zA8yyeika9pKoaLRZbnr7iACF9tv+puQ3n4/wk+LTrqh8gJo+nu
	N//X49F37Kx5SZhfgpz0AyxZ9a8NmqmquYs2FB6c1NvE7wcEcVxSsYeNtWVzgG9s
	dcZLhcrgzH5XV7xwpemaX1Es68tdQSLVf6pLC/vaQhJDDLnoJkmely4rDA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9kr80c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 07:58:59 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O7wuTA007257;
	Wed, 24 Apr 2024 07:58:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3xm6sktqje-1;
	Wed, 24 Apr 2024 07:58:56 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O7pKHj030861;
	Wed, 24 Apr 2024 07:58:56 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43O7wudp007248;
	Wed, 24 Apr 2024 07:58:56 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id D1C3C5001C1; Wed, 24 Apr 2024 13:28:54 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: cros-qcom-dts-watchers@chromium.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, swboyd@chromium.org, robh@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajpat@codeaurora.org, mka@chromium.org, rojay@codeaurora.org,
        luca.weiss@fairphone.com
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Remove CTS/RTS configuration
Date: Wed, 24 Apr 2024 13:28:53 +0530
Message-Id: <20240424075853.11445-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r-TmsRXwjrRnVb4aGGvhmSVyWlnfnxfk
X-Proofpoint-GUID: r-TmsRXwjrRnVb4aGGvhmSVyWlnfnxfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_05,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240034
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For IDP variant, GPIO 20/21 is used by camera use case and camera
driver is not able acquire these GPIOs as it is acquired by UART5
driver as RTS/CTS pin.

UART5 is designed for debug UART for all the board variants of the
sc7280 chipset and RTS/CTS configuration is not required for debug
uart usecase.

Remove CTS/RTS configuration for UART5 instance and change compatible
string to debug UART.

Remove overwriting compatible property from individual target specific
file as it is not required.

Fixes: 38cd93f413fd ("arm64: dts: qcom: sc7280: Update QUPv3 UART5 DT node")
Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>

---
v1 -> v2:
- Remove compatible property from target specific file.
- Update commit log.
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  1 -
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  1 -
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  1 -
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  1 -
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |  1 -
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 14 ++------------
 6 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index f3432701945f..8cd2fe80dbb2 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -864,7 +864,6 @@
 };
 
 &uart5 {
-	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 47ca2d000341..107302680f56 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -658,7 +658,6 @@
 };
 
 &uart5 {
-	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a085ff5b5fb2..7256b51eb08f 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -632,7 +632,6 @@
 };
 
 &uart5 {
-	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index a0059527d9e4..7370aa0dbf0e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -495,7 +495,6 @@
 };
 
 &uart5 {
-	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index f9b96bd2477e..7d1d5bbbbbd9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -427,7 +427,6 @@
 };
 
 uart_dbg: &uart5 {
-	compatible = "qcom,geni-debug-uart";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index fc9ec367e3a5..246fb7919d27 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1440,12 +1440,12 @@
 			};
 
 			uart5: serial@994000 {
-				compatible = "qcom,geni-uart";
+				compatible = "qcom,geni-debug-uart";
 				reg = <0 0x00994000 0 0x4000>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				clock-names = "se";
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_uart5_cts>, <&qup_uart5_rts>, <&qup_uart5_tx>, <&qup_uart5_rx>;
+				pinctrl-0 = <&qup_uart5_tx>, <&qup_uart5_rx>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7280_CX>;
 				operating-points-v2 = <&qup_opp_table>;
@@ -5407,16 +5407,6 @@
 				function = "qup04";
 			};
 
-			qup_uart5_cts: qup-uart5-cts-state {
-				pins = "gpio20";
-				function = "qup05";
-			};
-
-			qup_uart5_rts: qup-uart5-rts-state {
-				pins = "gpio21";
-				function = "qup05";
-			};
-
 			qup_uart5_tx: qup-uart5-tx-state {
 				pins = "gpio22";
 				function = "qup05";
-- 
2.17.1


