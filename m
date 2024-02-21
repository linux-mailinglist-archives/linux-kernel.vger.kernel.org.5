Return-Path: <linux-kernel+bounces-75646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBCA85ECD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD581F22818
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B62134CC7;
	Wed, 21 Feb 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="blNdUxc0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5733126F11;
	Wed, 21 Feb 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557569; cv=none; b=uDkKUby3u4qw1mrxbAGyfMQGdHqmObcwmb+WNJjhkc1fEchxJ09Ji32ffqn5JTGl7y/IxHM8VIj6x/c/JpZXwa3iQMIyXMn6JXEJd6l0twrJf24Vp50jetJUlimyecoZQE0gVEPHdEWttBMQhSz8tXn2tuoXFhRvInCYsZzS7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557569; c=relaxed/simple;
	bh=Y2qSwk8mNfYuhwG1rzOt+sTbITj2QLeKwrRBBV+22Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V6EBpqNUvbzwFROGW5z7Hhsi3v2wfY71KClykvz0DkeQ5AmWXgCOipwoYa9GMztPP1/GJueoRQ+BAbt4xND6M1FKFmkcRo2mqXAesfgp+y/t2FBOhM69Q3REj1tjutuZ05bgq61N/40rxznHMgk5n1uX/QGoNiOpVjUl2Y+PiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=blNdUxc0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LNHTUQ014377;
	Wed, 21 Feb 2024 23:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=QTP29uXayTppSGBG8X5DJFah/21DBQs8tbaymcmdRPs
	=; b=blNdUxc0Kn+7Srf3j4HTmT7KAu08rkxSwtKOW3p5uU7bVcirG+oL+9+ovf7
	uw7eR68hFJRjSxAlvY531Qkgl3/CdDvWOlZaFKVqNd7TB0JaczvumKbA4SWAryzE
	yOs537Rm+eNnoQ65rlBKAv+1XTglXuOw38vRtJl6oaoIUMu7BEtBSiMs0grlkGrr
	qXLSAiHASlKvO1fmJls18RmabkJuqSq55SI8nRlyALdHpJ1EwQUrwq7l32iMq8PB
	WNcBjDOpTwGO2iFknqauBk/ACUHlYzZc+dqXQCLxZb89OhkSEAR/lbFwo1IhNcdS
	B2NDUnmwj4leV837ECXyWNeYazg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdsk4r3we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNJF9B000680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:19:15 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 21 Feb 2024 15:19:16 -0800
Subject: [PATCH 8/9] arm64: dts: qcom: qcs6490-rb3gen2: Enable USB Type-C
 display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240221-rb3gen2-dp-connector-v1-8-dc0964ef7d96@quicinc.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708557553; l=2319;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Y2qSwk8mNfYuhwG1rzOt+sTbITj2QLeKwrRBBV+22Jk=;
 b=2HBJlKPeitCH7Qs6wDT9HIUJ2DE13MalWy88CSXlms7Evl/wML8C3mEezy8bei51cSs/yxE1h
 24kibnMHQoCDcd3EgxXN1LYZjYuVbo6Cl0TvbgI7TTzEtiFigYw9Tds
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b1Gp7E8x9DXEtpo_5xcJZxwP1tW2zxDA
X-Proofpoint-GUID: b1Gp7E8x9DXEtpo_5xcJZxwP1tW2zxDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210184

With MDSS, pmic_glink, and the redriver in place, wire up the various
components to enable USB Type-C display on the RB3gen2.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 63 +++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 171ed979d55f..4bf1c6351467 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -149,7 +149,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&redriver_usb_con_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu_in: endpoint {
+						remote-endpoint = <&redriver_usb_con_sbu>;
 					};
 				};
 			};
@@ -476,6 +484,36 @@ typec-mux@1c {
 
 		retimer-switch;
 		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				redriver_usb_con_ss: endpoint {
+					remote-endpoint = <&pmic_glink_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				redriver_phy_con_ss: endpoint {
+					remote-endpoint = <&usb_dp_qmpphy_out>;
+					data-lanes = <0 1 2 3>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				redriver_usb_con_sbu: endpoint {
+					remote-endpoint = <&pmic_glink_sbu_in>;
+				};
+			};
+		};
 	};
 };
 
@@ -483,6 +521,15 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	status = "okay";
+};
+
+&mdss_dp_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+};
+
 &mdss_edp {
 	status = "okay";
 };
@@ -534,7 +581,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -554,6 +601,18 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&redriver_phy_con_ss>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp_out>;
+};
+
 &wifi {
 	memory-region = <&wlan_fw_mem>;
 };

-- 
2.25.1


