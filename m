Return-Path: <linux-kernel+bounces-119687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178E88CC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613801C65814
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299D128814;
	Tue, 26 Mar 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Houtpz5a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CEE84D0D;
	Tue, 26 Mar 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477911; cv=none; b=T94OrGQlIQx/xNAAeFmVB309z8L7E2nfJoP5UWeiWTE2aiCogTiQrhaTX0GMfFvSO6N2ectTcAq/RWEbrO+i/XLR7DW5ImbKwbvjSnyPSjeO4WG1wDAMz8FG1sbvSY+DxEMJcOhk8oU3ahQC4tlB5SOa/8FL1ivJ41jgdb3K/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477911; c=relaxed/simple;
	bh=Hy7edzumEoWeONYYCu1G0+IrMmMDfxYK/QUHU24I/Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RyVS4DiZKjJyZ3KxVaH7cylSpVcEx4QVY+qsTUoTtj11RWFj5rYcihm/SqByEUIMh1KfLocGPZbfABe2DQGI+GCJsENPzAuE8B5pu6PWuw5MORkbD1867xjy//RX4rJspN2+hqcd7t1ksIMJyFnaTYaE7i78b2Q3ALd3SHNRaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Houtpz5a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QG6CL1011820;
	Tue, 26 Mar 2024 18:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=CLe
	32OEPO+KVS6LX1ndJG84GupdaXxVbnPB6jH9BUAI=; b=Houtpz5aPGZkHtUop7J
	R6Hj+jP3cG9jIdgEt000sjfowcFglPUUt3BHAnRJb82SzIbE1OC7tSJYgqewDLMi
	wTOJSKY527H41fd3RUtFP8urBgjkS0TrH512mQzESSZrDLu+91iUsqOPUN0aWKbL
	/zlj4B2kXWBxPXst/33BgWJycZUe7/mIlGEX4YivVgwZvIxLKnVIAVvI/Qb4lliy
	EM53d6YINyjVXJevOPSXqDv/fpMygkwsXrHq1JX8ErfsoyOPQ4KyPSzCS1LTE3WZ
	DBcn3TGSnQ8L3S4bapRbM8VW2yQv8NtK8REOsbDW5YVTUDuFLp4Wd9uMHKCcy+lg
	Prw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x41k68att-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 18:02:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QI2UT3015068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 18:02:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 11:02:30 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 11:02:30 -0700
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-ufs-v1-1-8c5c2dae1e64@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALUNA2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMz3aIk4/TUPCPd0rRiXfOUlCQDc0NTc1NTMyWgjoKi1LTMCrBp0bG
 1tQBGS2bKXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711476150; l=1626;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Hy7edzumEoWeONYYCu1G0+IrMmMDfxYK/QUHU24I/Pk=;
 b=lDO306RXcsUfdGEU/nZkY0RAVYJ6JLaKK3YRNJc/yf9lrJeMOxFZoSkpcRVVKC/lt6NDUd87v
 jYmbjeny+XeB5bTDXzwLLjXDWpoLaOm24XmUbWCMZF4OZWb/yRNSmzZ
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eNto9_vGL8HkPuqiG2lbeY-eOPn7AEpB
X-Proofpoint-GUID: eNto9_vGL8HkPuqiG2lbeY-eOPn7AEpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=847 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260129

The rb3gen2 has UFS memory, adjust the necessary supply voltage and add
the controller and phy nodes to enable this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 63ebe0774f1d..0177d93ecd1d 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -221,8 +221,8 @@ vreg_l6b_1p2: ldo6 {
 
 		vreg_l7b_2p952: ldo7 {
 			regulator-name = "vreg_l7b_2p952";
-			regulator-min-microvolt = <2400000>;
-			regulator-max-microvolt = <3544000>;
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
@@ -508,6 +508,25 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l7b_2p952>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <900000>;
+	vccq2-supply = <&vreg_l9b_1p2>;
+	vccq2-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
 &wifi {
 	memory-region = <&wlan_fw_mem>;
 };

---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240326-rb3gen2-ufs-7ddb07157556

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


