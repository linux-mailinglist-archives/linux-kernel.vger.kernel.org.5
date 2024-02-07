Return-Path: <linux-kernel+bounces-56336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143C84C8DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8550AB263BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA214AB4;
	Wed,  7 Feb 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mO/hQ3qs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76E14A89;
	Wed,  7 Feb 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302540; cv=none; b=r/ILn6rT0qJ2dt5gsKoKkCS+sW7tJhC4q1y0zn0qAsw4OzgxUFlnEvdwZBI3negp2ObRXWXlxrfVNtaebCNNNndsXggxbOqHul+cETrl7BAd9pZYRlKp14gVdjL0ZLhaIEbwzvucDOGpTgxqE6NxfCVeCG8+aIM06lkSW9qlGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302540; c=relaxed/simple;
	bh=II47jwsuZLY/0YRKVtpUI0sbrhHp7KT8QYWiYIYnm64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jiHJ6ngut7ABZTMl1n8IvVE53LRz+SyOKcioxGb9Z9PIvwU7oXAyMpgJjtnUcL/TjdpeEO4huNc2mKBGpYSpXiuAOJNuNHXy6slVHVEA3TCRj9qrefbWliCrWfUtIChwiB+8s5ZezqD36MtVfpQMx2e7wp741c/BylbgS43dfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mO/hQ3qs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417AQCvF013143;
	Wed, 7 Feb 2024 10:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=f4a
	6QVU4hulFuG7QklOItbrc6hHNenm18VOdI1gRvJM=; b=mO/hQ3qsZ4NCjy6vB8h
	7a8g10w6fApuzU7RUOC6n7rJwK0gxLthGHk8qp4BDmpFkBm0fnz/9RWfN1U99xZv
	J53BsAZ+MUndGabJzXPMMAQpI2qpEsyvnLEkPly1204TV42ytQDFyfDkTsb2Df/J
	MSqXdLmRfuHkKny7S2XYPkMrMED71J2RbYGBTceKGSlBXdwTeyTSpKvUiKgioOhn
	HdPchDRdi90ycMsqclDXuBdf6MJc+5Auw4qSN+YVI+kKBsVZAXsgWBfXp2CqzOGD
	Xic0cZYQ2rgLCDFv9fj/wdmHyDZOlp4k9kQXAMQexG/A/P/afQJEyP/FDisjHxAu
	3dA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ub6hfnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 10:42:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417Ag13b003200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 10:42:01 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 02:41:56 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 7 Feb 2024 16:11:49 +0530
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAG1ew2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNz3dS8xKSc1PiC5MxUXUvTJMMUMzNDoyQjcyWgjoKi1LTMCrBp0bG
 1tQDbjrJiXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707302517; l=2092;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=II47jwsuZLY/0YRKVtpUI0sbrhHp7KT8QYWiYIYnm64=;
 b=u2Wyoa7F0oRnHv37GNU4l5ZZUKYEDZyWQtH9gXoTyXrBkP3tWdwz3DG5YGmGiYGfxXGIqOQdz
 Wu2/ku5afGnDK6vK/HMRwzBc2CIoCiER/U6gCqaKJouGC18XQcbPwnj
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8L8kUlVtulcoBfuJ32aTvlkce2y4ag-W
X-Proofpoint-ORIG-GUID: 8L8kUlVtulcoBfuJ32aTvlkce2y4ag-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=808 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070079

Enable PCIe1 controller and its corresponding PHY nodes on
qcs6490-rb3g2 platform.

PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
connected. For each endpoint a unique BDF will be assigned and should
assign unique smmu id. So for each BDF add smmu id.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 8bb7d13d85f6..0082a3399453 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pcie1 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
+	pinctrl-names = "default";
+
+	iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
+		    <0x100 &apps_smmu 0x1c81 0x1>,
+		    <0x208 &apps_smmu 0x1c84 0x1>,
+		    <0x210 &apps_smmu 0x1c85 0x1>,
+		    <0x218 &apps_smmu 0x1c86 0x1>,
+		    <0x300 &apps_smmu 0x1c87 0x1>,
+		    <0x400 &apps_smmu 0x1c88 0x1>,
+		    <0x500 &apps_smmu 0x1c89 0x1>,
+		    <0x501 &apps_smmu 0x1c90 0x1>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -420,6 +446,22 @@ &qupv3_id_0 {
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
+
+	pcie1_reset_n: pcie1-reset-n-state {
+		pins = "gpio2";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-disable;
+	};
+
+	pcie1_wake_n: pcie1-wake-n-state {
+		pins = "gpio3";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 };
 
 &uart5 {

---
base-commit: 70d201a40823acba23899342d62bc2644051ad2e
change-id: 20240207-enable_pcie-95b1d6612b27

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


