Return-Path: <linux-kernel+bounces-30612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7383220E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5941C22BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C601DFC1;
	Thu, 18 Jan 2024 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VHZvUFbw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6411D688;
	Thu, 18 Jan 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618857; cv=none; b=a2+59ze0TJgXrhdikgRS6CmCM2r6jhKq0exL4VHURTt2LKjuR6bbsr/M5+c0EpzmuM251Q2aWssbBInFQilPBew9Wvv9nJekPeCE/5zICqIGxSl6PHdrVqJ70eGxBy/OxoHGha1FdkSS2Gidf4jPkOeIbaY76lcXg32JL5VJjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618857; c=relaxed/simple;
	bh=/xgDlirmg//lpL37mmgAf9h0tQ9Ilkkc6guk2v2yVNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aNIFzfGGJWua8RobqvZky5ejXkAq3oJrMJiXassH5ZkWSh2j+Qo69lYfLBfGCAtZjhCfnI/tbdmmaJHcKHEmoRulTUYzFdebHYH/gxT7Os/TfL/0QnurzOlZ31wfH/x/HYAaRH+H8yDnbfB1UqDB8UCXpqElFVhUFmzabGt6Pr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VHZvUFbw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IMr0U0005990;
	Thu, 18 Jan 2024 23:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=OQk
	BZR1Pnd2c8BBgKIOiMkfkdGGDimI57H9zZTAVK2k=; b=VHZvUFbw5w4e1JAPatk
	IqivVWKP7iFzhHlCoHFLb+ICMVCTHdZ7wAtIJOCoRmj4RHpsTaJ4P6Y4D31mn51j
	C90wJLgrNtqaBmmCf4x8RVMr1o+bvdNT/1IM+ToHqWgN/VoLewEkTVRB2tIMgxEV
	fVH7FREBgzt3zc5HmczQB5wCjikLp3JPppKUhpiU0k/qeGGLGGKauDtcCwcA5+a9
	xZtlvSfHee1k7ImHsR8dLEFMh/GvQiGSSDadV9GKK2BFms8tR62pTu08/ski9dhA
	6fWKv/ehvufeJUVI7pp0X6AEopX3y8XgEJZZUaqzdKlTWRd5PYpUkSFBziYJEV68
	d4A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq1s79tkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 23:00:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IN0dKd015585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 23:00:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 15:00:39 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 18 Jan 2024 15:00:23 -0800
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIatqWUC/x3MQQqAIBBA0avErBPUMqyrRITkWLOxcCKE8O5Jy
 7f4/wXGRMgwNS8kfIjpjBWqbWA7XNxRkK8GLXUvlbKCN6utzJe4GSPrtRPOBD+63vrBGKjdlTB
 Q/p/zUsoH7zomhGMAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705618839; l=2193;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=/xgDlirmg//lpL37mmgAf9h0tQ9Ilkkc6guk2v2yVNo=;
 b=oGSxLsDFyDQYKE23MHJbR+I4s86iQTna1bXZ/fp7hG8CNfL2uicmNJTNK6SAuki2mPB6ZSISI
 nXd0kZ5ADdBB/sf1mxUdZ1yBUAJudjg+CEHn+nIxvHjZDz7pDwu1Y2G
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NqR7U-If9g26ntJFdimDY5oP2_dwse_g
X-Proofpoint-GUID: NqR7U-If9g26ntJFdimDY5oP2_dwse_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=587 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180155

The SC8280XP contains two additional tsens instances, providing among
other things thermal measurements for the GPU.

Add these and a GPU thermal-zone.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..68b5ac0339a0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		tsens2: thermal-sensor@c251000 {
+			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c251000 0 0x1ff>, /* TM */
+			      <0 0x0c224000 0 0x8>; /* SROT */
+			#qcom,sensors = <11>;
+			interrupts-extended = <&pdc 122 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens3: thermal-sensor@c252000 {
+			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c252000 0 0x1ff>, /* TM */
+			      <0 0x0c225000 0 0x8>; /* SROT */
+			#qcom,sensors = <5>;
+			interrupts-extended = <&pdc 123 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
 		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
@@ -5212,6 +5234,21 @@ cpu-crit {
 			};
 		};
 
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens2 2>;
+
+			trips {
+				cpu-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
 		mem-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;

---
base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
change-id: 20240118-sc8280xp-tsens2_3-a5fd9a48d655

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


