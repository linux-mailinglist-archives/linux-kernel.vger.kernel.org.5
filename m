Return-Path: <linux-kernel+bounces-92730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C7872508
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0344B1F27355
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12291756A;
	Tue,  5 Mar 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pH2n1kjn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6113FE7;
	Tue,  5 Mar 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657925; cv=none; b=ZHOJzeuT2ydBCFq1K6Fc7X5kDkM7Anx2CC14+6EeDHykDXcpz2GV43WFkVRLxBocouxB+O0qOhjR/Bh2PyBzUjVAGMUpaNv7z06p5iLNNdlVdOaVayIeJM2FHNRkmoKPfv6sXAizbmXsLdmh9p0cqjmGayPkya15ngzT3wer5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657925; c=relaxed/simple;
	bh=Qm0C26vTnQqEvuwDTzCGjcvi2jLIcHMgjHueZPAbtT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6URNm5dIuzMjk4SF+ekbU8YD1PnzRDOVjN/N1PExtD8QcYNDGbJxDfmBBeDRUgix0Pxn0notqUQJYGbE/OzcTHXTaNV4aUodyw9WIFhDgzOBP4Jee5zibQgvG1u57gF6NXIxHjqIeE/RMW7tZUVR9FHZ1Z294RPIEWRVkXWpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pH2n1kjn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425Bb5eQ029986;
	Tue, 5 Mar 2024 16:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Xs6jRcPBO7nBTZpyc36A
	h5Ui2+hN1jTLQY9o2umMWDc=; b=pH2n1kjnfK2/cWn16CHl+qHGhhknKmvE3mTy
	mkRtWTMC60RabqWgPGTlF7Op7DIKhmf6V2iFKkCWrjgfkianmmbTro/KwxCJ3H67
	h41G7fnq9MH2O0mxIwcPiP0Aw3D+CNtd4hPTY77w9RhstgUcTCZzjl3Dyi1UmYw+
	5PKEv1pCW+IrWeO+s389ZtaI9e3F4MWA48zHvmMmvIQ1rCCSQK8ItzHLjiPx4rWJ
	4iFZzuxIe6NVpCm+ygAmBh4iOxYIUVoTe1IeqrFR/Nl1p+AAvCqieg0GWlvJ1ZLX
	8NOYGU86IBgJ5QfBPlLcRRtmWV6c4g4SLqMjTfsbKBa8OEe0xg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnx0y1bd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 16:58:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425GwNci002686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 16:58:23 GMT
Received: from sriramd-linux.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 08:58:17 -0800
From: Sriram Dash <quic_sriramd@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
Subject: [RFC 3/3] arm64: dts: qcom: sa8775p-ride: Enable support for firmware managed resources
Date: Tue, 5 Mar 2024 22:27:38 +0530
Message-ID: <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jrikr7EeNqiNk9tY66_Lziis6LT8vrGz
X-Proofpoint-ORIG-GUID: Jrikr7EeNqiNk9tY66_Lziis6LT8vrGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050136

Establish the channel and domain mapping for the power domains to connect
with firmware, enabling the firmware to handle the assigned resources.
Since these delegated resources will remain invisible to the operating
system, ensure that any references to them are removed.

Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 +++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 26ad05b..b6c9cac 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -764,8 +764,18 @@
 };
 
 &usb_0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_en_state>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ required-opps;
+	/delete-property/ resets;
+	/delete-property/ interconnects;
+	/delete-property/ interconnect-names;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	qcom,fw-managed;
 
 	status = "okay";
 };
@@ -775,23 +785,45 @@
 };
 
 &usb_0_hsphy {
-	vdda-pll-supply = <&vreg_l7a>;
-	vdda18-supply = <&vreg_l6c>;
-	vdda33-supply = <&vreg_l9a>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ resets;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	hsphy,fw-managed;
 
 	status = "okay";
 };
 
 &usb_0_qmpphy {
-	vdda-phy-supply = <&vreg_l1c>;
-	vdda-pll-supply = <&vreg_l7a>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ resets;
+	/delete-property/ reset-names;
+	/delete-property/ #clock-cells;
+	/delete-property/ clock-output-names;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	qmp,fw-managed;
 
 	status = "okay";
 };
 
 &usb_1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_en_state>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ required-opps;
+	/delete-property/ resets;
+	/delete-property/ interconnects;
+	/delete-property/ interconnect-names;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	qcom,fw-managed;
 
 	status = "okay";
 };
@@ -801,23 +833,45 @@
 };
 
 &usb_1_hsphy {
-	vdda-pll-supply = <&vreg_l7a>;
-	vdda18-supply = <&vreg_l6c>;
-	vdda33-supply = <&vreg_l9a>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ resets;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	hsphy,fw-managed;
 
 	status = "okay";
 };
 
 &usb_1_qmpphy {
-	vdda-phy-supply = <&vreg_l1c>;
-	vdda-pll-supply = <&vreg_l7a>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ resets;
+	/delete-property/ reset-names;
+	/delete-property/ #clock-cells;
+	/delete-property/ clock-output-names;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	qmp,fw-managed;
 
 	status = "okay";
 };
 
 &usb_2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb2_en_state>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ required-opps;
+	/delete-property/ resets;
+	/delete-property/ interconnects;
+	/delete-property/ interconnect-names;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	qcom,fw-managed;
 
 	status = "okay";
 };
@@ -827,9 +881,13 @@
 };
 
 &usb_2_hsphy {
-	vdda-pll-supply = <&vreg_l7a>;
-	vdda18-supply = <&vreg_l6c>;
-	vdda33-supply = <&vreg_l9a>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ resets;
+
+	power-domains = <TODO>, <TODO>;
+	power-domain-names = "usb_transfer", "usb_core";
+	hsphy,fw-managed;
 
 	status = "okay";
 };
-- 
2.7.4


