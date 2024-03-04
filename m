Return-Path: <linux-kernel+bounces-90070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498DE86F9C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96B51F21208
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67865E552;
	Mon,  4 Mar 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nqe+i3y6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE41C15B;
	Mon,  4 Mar 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531637; cv=none; b=uYbTSvpI1m9VesLuuMlaAZwzM75Kw367DmlsXpxhiiaBEaofdv9y0gGAiEV81h3sfrCJIohcsQKwDJPzNjFmKK79aceKciuabNMYB4jMEPxLHk4QQjzNF7Jeb60BH9bSN/RWyeG3M8hBo7rC5N6unsgNTt/cPSHxTJhGUSvxjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531637; c=relaxed/simple;
	bh=mq7TXZio7/RiS+CzlqRoYNx2kIW5aRL1dfqJKXxlyhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxaOpdQ6IAmwRO0GUYuWlzHjNKmwSNFzKOT+oVc3XYV8L240jEE+UjYwg9pwZueFnbdt/50+V8pJ9+VPKwO7QAF4duRyu31QTN4l0DJudW5p15gqw9Ebcv3gx58Abo2mUN+KlR3AcSynHCLMbLJXX79/MAtqhy4L1EF4QgtFFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nqe+i3y6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4244RC6H016966;
	Mon, 4 Mar 2024 05:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=6rDCeTT
	ETG1od6jjW0uQ/pSuXaAVw8UI/PnLswPNZME=; b=nqe+i3y6qe4cCRR3F8yqE91
	p271gSiFe8qZ5ihvlGlacSIe0W/NoWplgKxSpYyk7BLuv2EAneARyzx4AUpMtdj6
	odo9DYr4uWgiexMW3tRqQhZW0+lnR+UVwIH5y/4txQiBHi1fdsOEqJ5Dos9mRWyf
	pznBvjprtZ+U+2vnWBAeasx7p3kF45S3PD8o5ZJoixMGjEdykC6+qBV2kbN7uCoP
	kIn3SD45SWOhjtAv/A72BQ5IoLmlLYlkaIQeNuMfspsqmqz0+syXrB6S93uM04BX
	5DwfADG7QmUpKTfqZjCqhIyD+Up5dIBOXbhYMP8XUpvN8O9WCTmWnOuY1VnI3+Q=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn5b389hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 05:53:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4245rlkX007939;
	Mon, 4 Mar 2024 05:53:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wkw6kx590-1;
	Mon, 04 Mar 2024 05:53:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4245rloi007918;
	Mon, 4 Mar 2024 05:53:47 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4245rktG007913;
	Mon, 04 Mar 2024 05:53:47 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id C71C0500966; Mon,  4 Mar 2024 11:23:45 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: Add initial support for rb5gen2 board
Date: Mon,  4 Mar 2024 11:23:33 +0530
Message-ID: <20240304055333.15952-4-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304055333.15952-1-quic_wasimn@quicinc.com>
References: <20240304055333.15952-1-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O3KFxJ24p-C8jDqO0RsdhuL-QKUmS8fy
X-Proofpoint-ORIG-GUID: O3KFxJ24p-C8jDqO0RsdhuL-QKUmS8fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040042

RB5gen2 is based on QCS8550-Rb5gen2 SOM for IOT solutions.
This initial version describes VPH_PWR, UART & USB3.1(HS).

On-board PMICs:
- PMR735D
- PM8010

Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 02d9bc3bfce7..75f4fb5cc0a9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -97,6 +97,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-rb5gen2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
diff --git a/arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts b/arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts
new file mode 100644
index 000000000000..2affe188bd23
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "qcs8550-rb5gen2-som.dtsi"
+#include "pm8010.dtsi"
+#include "pmr735d_a.dtsi"
+#include "pmr735d_b.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QCS8550 RB5Gen2";
+	compatible = "qcom,qcs8550-rb5gen2", "qcom,qcs8550-rb5gen2-som",
+			"qcom,qcs8550", "qcom,sm8550";
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
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
+			};
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		vdd-bob1-supply = <&vph_pwr>;
+		vdd-bob2-supply = <&vph_pwr>;
+	};
+
+	regulators-2 {
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+	};
+
+	regulators-3 {
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+	};
+
+	regulators-4 {
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+	};
+
+	regulators-5 {
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+	};
+};
+
+&pm8550b_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_1p8>;
+	vdd3-supply = <&vreg_l5b_3p1>;
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l1e_0p88>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&pm8550b_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3f_0p88>;
+
+	status = "okay";
+};
--
2.43.2


