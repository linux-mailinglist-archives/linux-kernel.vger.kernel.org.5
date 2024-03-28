Return-Path: <linux-kernel+bounces-122316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E588F50B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664FA1F2EFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC6324B34;
	Thu, 28 Mar 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c9SkfW+5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1521364;
	Thu, 28 Mar 2024 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591281; cv=none; b=m0IgjUmGBmq4ezn3FH7sby8P+7mAxMKP1EzXaIy+dfC4WcdXVqOTUZOE8O3KGPj5Vv6w9e05aPNN0Ty3Idj51bK+5UolFsxgT5iVp8wiQOGFJfliPE770CcyGuQm2E/lNPajFHmDjXkc6gDyg6GB4stM1A/g+c/9ypWJypvAtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591281; c=relaxed/simple;
	bh=l6vPKLYpgniG4hBTlGEzvh+KSlansaZtTJMXwc9hdPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lU+l8fM3EBv5wViI8M3MGWxH1XqJpaawAyTL+k+O8Q9ltbsYkRfs1UVJBOxg5LNw931P+3hRXvf3CMkwYvhAAuR01KlG8Q1yKJYP2F+hcOjX0mVhLuCl1VeM0q4CX9y7Ya04d8ALKNAr4l+o7epKL4/Zpp6mo+OUZ5EQAmm6qZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c9SkfW+5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S0mLkR027763;
	Thu, 28 Mar 2024 02:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=4qs
	phDqjuf/k+2/ieqVVHViTxtemY++QRvd6gdLn0wU=; b=c9SkfW+5CB3wxbG4y07
	usX848dUd6HG6VlHb8lHOUS3BAcU9QPZtjbsda3tlOgr8GQfe0ZXBxG/AlYgujMJ
	Z+jwdrECLRcS6Tlx7mm9rRcGWjNNWdRK7YpLW9imTGCBOaHqgglI15lg1V/wzM8T
	jCwQ9ERoizC8KKc3Ia3bJlolZZQhPavN6S5y4V4jflerpmHhqSQ3Az8Cw7GsaM3n
	CiL3P2oPHPfu/jaPJP1NEEyfSCPu5cps5pdbVO7BxSS9mZeX0iVQ9N6pYLQmh46y
	0RB6lEHr2uZXqXmVMTWtlorQuV1lrE/ZBLkc+VLdaoDAAcEZewRZ5shIBaYPVItS
	7iQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u208s8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 02:01:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S21EOZ031410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 02:01:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 19:01:13 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 27 Mar 2024 19:01:13 -0700
Subject: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240327-rb3gen2-ufs-v2-1-3de6b5dd78dd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGjPBGYC/23MQQ7CIBCF4as0sxYDtIBx5T1MFy1M21kIFizRN
 Nxd7Nrl/5L37ZAwEia4NjtEzJQo+Bry1IBdBj8jI1cbJJcdb6VmcWxn9JJtU2LGuZEboYxSGur
 jGXGi96Hd+9oLpVeInwPP4rf+d7Jggl2sstINKFB3t3UjS96ebXhAX0r5Av+oEHmoAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711591273; l=2331;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=l6vPKLYpgniG4hBTlGEzvh+KSlansaZtTJMXwc9hdPk=;
 b=ESeCOgfCmCI9FR61Luwj73kWNVQdMaQqi1ksPkPx53Bd9//tocaN6MsQ0oza7qdRxWYvC7miV
 a0RFKhMpx0bBvw8aJfcMZg8BqbJIIxs3YFtiCPAf1dEstRcFNup49DM
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LvThOAb7yXdqsS9oEBJkczpxEW3v2g5T
X-Proofpoint-GUID: LvThOAb7yXdqsS9oEBJkczpxEW3v2g5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_01,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=842 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280008

The rb3gen2 has UFS memory, adjust the necessary supply voltage and add
the controller and phy nodes to enable this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v2:
- Added missing regulator-allow-set-load and regulator-allowed-modes
- Dropped max-voltage for vreg_l9b_1p2 to it's expected value
- Link to v1: https://lore.kernel.org/r/20240326-rb3gen2-ufs-v1-1-8c5c2dae1e64@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 63ebe0774f1d..79d7c8932bff 100644
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
 
@@ -236,8 +236,11 @@ vreg_l8b_0p904: ldo8 {
 		vreg_l9b_1p2: ldo9 {
 			regulator-name = "vreg_l9b_1p2";
 			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1304000>;
+			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l11b_1p504: ldo11 {
@@ -508,6 +511,25 @@ &usb_1_qmpphy {
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


