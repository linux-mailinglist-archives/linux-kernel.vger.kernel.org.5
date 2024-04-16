Return-Path: <linux-kernel+bounces-146685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F5E8A6952
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4631F21F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5F128805;
	Tue, 16 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ilgu4fgS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD612839F;
	Tue, 16 Apr 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265443; cv=none; b=euFggGVqVH0NhSxRKked5aMygQKcBmrp3coLDYjDipyVlEvH+fH6BiYnpR50e3eQTu8h22kP7Yy0k3StIrj9aRFff5OGxB16+8Fc2AOzK9YfBIwPb7MYoZ+bMVobSInbWdqF+77tRNbCox0ww0T7yOZ96C6PRYUlke3B8+GTIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265443; c=relaxed/simple;
	bh=sYmuLspY/b0xXJ6GODuEyh5bTCuWxoBIgmUpur4bjzo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VPFA2exi1KUTj3h+c1h6NnH6nyQ0gxZu2igtlv/D37YHYJGqBsl5uvL+pPm1Oh2W7lih30q/UqoreKBGUof3a+nlu04PyzDqPn3/IuIkssRFufngLli++w152KnjhejnMswxxeUxyfQsep5Zj6kBOfKndJFSfAb3O+/+SaDSCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ilgu4fgS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G9PFdp019747;
	Tue, 16 Apr 2024 11:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=HY44SXyh9AvL
	QwBO+4Ku2R5e0M2EqqIcEr13txqbRok=; b=Ilgu4fgSBZ88xqWUjpZB7U8IEF7f
	X+OD0ATaW1Y6G7Vsg7FuokjWMh4Z1POtxNpb9v5HvAUTzzMM5UAerkjpQACCXv4S
	BqVu07PQt2hsakAO4i1LksygmZkelByiZiizWDw8/uPRRUpmtnLBNpfJw3z6X/MU
	vce2ikssS2IrjcWxkHOOSgidTdXydLVI2wz5BmGydscCEOyTy857Dz/Yimot8u88
	SAJttEn9pLaRKJN0/LG9yFnZrXAA997I7q6iPdkzTxWeqTbwRpX5vFvCESO/ZEpZ
	WfSLSsqSPzTvnaEUvQVLAFGcjpNuzOzFyEOfAUPiSDgCg7AsZHkkiLswkw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhpny886b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 11:03:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43GB3ITN023067;
	Tue, 16 Apr 2024 11:03:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3xfk4kqrj8-1;
	Tue, 16 Apr 2024 11:03:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GB3HXb023062;
	Tue, 16 Apr 2024 11:03:17 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43GB3AiR023031;
	Tue, 16 Apr 2024 11:03:17 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id 6873C500C6C; Tue, 16 Apr 2024 16:26:52 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: cros-qcom-dts-watchers@chromium.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, swboyd@chromium.org, robh@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajpat@codeaurora.org, mka@chromium.org, rojay@codeaurora.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Remove CTS/RTS configuration
Date: Tue, 16 Apr 2024 16:26:50 +0530
Message-Id: <20240416105650.2626-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7w5elmBqewWqENvqVGj37HW3b70ZecdR
X-Proofpoint-ORIG-GUID: 7w5elmBqewWqENvqVGj37HW3b70ZecdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=956 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160068
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove CTS and RTS pinctrl configuration for UART5 node as
it's designed for debug UART for all the board variants of the
sc7280 chipset.

Also change compatible string to debug UART.

Fixes: 38cd93f413fd ("arm64: dts: qcom: sc7280: Update QUPv3 UART5 DT node")
Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 38c183b2bb26..2a6b4c4639d1 100644
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
@@ -5397,16 +5397,6 @@
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


