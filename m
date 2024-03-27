Return-Path: <linux-kernel+bounces-120200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBE88D456
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CCC1F38AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51088250F8;
	Wed, 27 Mar 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AUd2myos"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26221342;
	Wed, 27 Mar 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505089; cv=none; b=PvhvHR/+LzqmoJjnOqh3cyWwnXzdEd7gkX8GnV8vySXiDMaRD0EIf1ciQbmgnG5kQh2TbgbUfIlNXqsEdZeml47mwb4LwOIk75Sjv5C9z9QgbEqhaUNMzKl1uJreLm5VptCDj3CTHjGX3ktC5mrOnTEAenI5ngz+t25wgb3yZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505089; c=relaxed/simple;
	bh=dAecBa0rlCk54e2xFyJlDhnoPk4dL5t352mXh8HQVrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a3uMfNwuyt85KUcbRr1zaqHO5ZpVn/XDKlhVVW7MjwigW51rD0zJfbts2GxIuEQIL1nw1DFjLTML5vPPVs2PNeR79Tptmy15bSKh+x9+ZN9jbPb+u7Cd/fCuthmyHmLLzN3vskMvxS/4+6cDuuMIffiSxFnGX3lMlfvQBXnFr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AUd2myos; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R0vMFv007068;
	Wed, 27 Mar 2024 02:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Vn6DHxH5I3mpqtRE76okvSiRFpsnCvtZEsnXkw5zqSA
	=; b=AUd2myosQm1C1UbeDb9erYyySFiRqyxEV+5s4yNylbxDHe8hDL6ws6HqGPm
	3KaxTBODFrGXR4kGhqVZjRT2xgEmO4p3MLYiUI+eRvH9itS5w2hduchudVAscWjg
	yrU7hqqziaPyLa97iI2+opyuHL8u/WqeD2bm2r0XEu9AzXy1SiJ4HhKXvUktdvZt
	13mfLvOeIytjG5qcADzdSOkTwOgoUu0NSBMfTHfJH1LqnwJ9JWmkHt3MpkplMZS7
	1Yh5xCMtuY4VjkLt4XbOjIpbh5gXfJSz9UpjZDDKTyy3T/ad3xmPGmBbO4ga2sde
	vNwhdsEDSgCkOWJlNWD34CrS1+A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x477yrc4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24Vbx026034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:30 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 19:04:22 -0700
Subject: [PATCH v2 5/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable USB
 Type-C display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-dp-connector-v2-5-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Krishna Kurapati PSSNV
	<quic_kriskura@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=3323;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=dAecBa0rlCk54e2xFyJlDhnoPk4dL5t352mXh8HQVrc=;
 b=668dROWww8ZilxwWqBtSjHpBFERaaRP6Jaj9Qy1b3Os8a+wTIxiAOHOJzhdmUWGjkEmi3ALlc
 /WIIkJ3biBKA5t1L/rNz9ss0vte1M3OWOnJQYYLA7kaWm3Ov8Zi3pCL
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4h6P0ktqqm2_PDJ3X7H-LniMzDkmt4ke
X-Proofpoint-ORIG-GUID: 4h6P0ktqqm2_PDJ3X7H-LniMzDkmt4ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403270012

With the ADSP remoteproc loaded pmic_glink can be introduced and
together with the redriver wired up to provide role and orientation
switching signals as well as USB Type-C display on the RB3gen2.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-By: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 107 ++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 2f94b1b865e7..3cc19ccff90c 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -135,6 +135,49 @@ debug_vm_mem: debug-vm@d0600000 {
 		};
 	};
 
+	pmic-glink {
+		compatible = "qcom,qcm6490-pmic-glink", "qcom,pmic-glink";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&redriver_usb_con_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu_in: endpoint {
+						remote-endpoint = <&redriver_usb_con_sbu>;
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -496,6 +539,36 @@ typec-mux@1c {
 
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
 
@@ -503,6 +576,15 @@ &mdss {
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
@@ -547,7 +629,16 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_dwc3_ss {
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -562,9 +653,23 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p912>;
 
+	orientation-switch;
+
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


