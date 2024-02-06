Return-Path: <linux-kernel+bounces-55741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235D84C10D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCECF1F24A14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923CA1CD35;
	Tue,  6 Feb 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1uqz4TW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033641CAB7;
	Tue,  6 Feb 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263479; cv=none; b=T5ILCQSQGXChkPp304bJOUbwz7MBattaJqCQX+VSB6/UXjJ0xkRTAhA2NQF3MCSOl2oNVkzTptJa76jzCEqY7FzK1E0/ebox4uKpQj74FinxoQk5d8cGir9yxmFIHDTisN1vqwU3AwlZ7IJGibIElR76CvB69nGfYGNr/DkS2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263479; c=relaxed/simple;
	bh=spty8AvkVL9Bt1VeS+W6dnQA391hBnF8pcqsQvgJUq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aIiQGDRXwxvC1kXjjpZ9wfgpBV8cbXM+4smhjDgFa99wElFBBX6mVGhXkjQFLT24Es8GOPjOR8zKpttNQaNvnEE/MJl5pHZdBpQ8I5ENUfuI1sH3Zv/qdqmx6cvWFy9f6bPqp5MGI43G2nufVLIKUXmy/18JM6HQj2r/adDQo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L1uqz4TW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416NRT0b006382;
	Tue, 6 Feb 2024 23:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=fR3
	BIanxRqA5hDEquxVPHhJD0+is0HzOqyK/Fw2mmi0=; b=L1uqz4TWBAatMQuSiLP
	Ki5xbFdjC22Hy3SBjFFj0//UpR44LU5rMESEx6hJU3OdLCsBL8a4uZIAFE58PLzG
	qcotxwcf3QgVyD3Loyi4C2nmv/DXs8lyF9hAHbVZmIaD/It0Op2vr43TuXS5fcpm
	ubJYhf+ycnA9gRWrJjkTiZnCN+m/EeyHXOjooummBUez51Lv4xk4fuuXqYpCeGTD
	ri9vssSmEn2qngwqpk3vC2QWYkCzGBddckwX27nYdntY6rIqgXwfCP9st8o857Kv
	vxCSRh5rkqCt+scRAdaRgsmgbBFbkEyTs3K+BYU5VFjMrosseXZrzBocxQzMlxlF
	P8Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3x41r25a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 23:51:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416NpDrq023574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 23:51:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 15:51:12 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 6 Feb 2024 15:51:11 -0800
Subject: [PATCH v3] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-sc8280xp-tsens2_3-v3-1-4577b3b38ea8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO7FwmUC/33NwQ7CIAyA4VdZOIsBBgQ9+R7GmA2K60E2YZKZZ
 e8u20kT4/Fv068zSRAREjlWM4mQMWEfStS7itiuCTeg6EoTwYRknBuarBGGTQMdE4QkrjVtlHe
 HRhqnlSLlbojgcdrM86V0h2ns42t7kfk6/adlTjkFo1sLXHrd+tPjiRaD3dv+TlYviw9D6F+GK
 IZRTDpuys7Bt7EsyxskRhcg+AAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707263472; l=2593;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=spty8AvkVL9Bt1VeS+W6dnQA391hBnF8pcqsQvgJUq0=;
 b=TEZUDBwEcrj4TLlpziE0tAIdrq+Jr36MrKI4UFTwb3jo+l8TjzauOADPiHYLPVv4MquFDhCrL
 /k5MQVlaAWDCgF6GLNtTIXSc2/AK8M4Gxgll41+tzbY4S5/gPHtHuwD
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eqdG9L0eJomh6E7HJ-Z6w2sfODcl6LDr
X-Proofpoint-GUID: eqdG9L0eJomh6E7HJ-Z6w2sfODcl6LDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_15,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=679 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060169

The SC8280XP contains two additional tsens instances, providing among
other things thermal measurements for the GPU.

Add these and a GPU thermal-zone.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v3:
- Sorted tsens nodes by address.
- Link to v2: https://lore.kernel.org/r/20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com

Changes in v2:
- Drop TM/SROT comments
- Remove polling delays, rely on interrupts
- Link to v1: https://lore.kernel.org/r/20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..38ecf6768b1a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4011,6 +4011,28 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		tsens2: thermal-sensor@c251000 {
+			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c251000 0 0x1ff>,
+			      <0 0x0c224000 0 0x8>;
+			#qcom,sensors = <11>;
+			interrupts-extended = <&pdc 122 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens3: thermal-sensor@c252000 {
+			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c252000 0 0x1ff>,
+			      <0 0x0c225000 0 0x8>;
+			#qcom,sensors = <5>;
+			interrupts-extended = <&pdc 123 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
@@ -5212,6 +5234,21 @@ cpu-crit {
 			};
 		};
 
+		gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
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


