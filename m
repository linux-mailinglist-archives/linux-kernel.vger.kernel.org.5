Return-Path: <linux-kernel+bounces-40249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8FA83DD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C571028AE4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D81CF8D;
	Fri, 26 Jan 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cangrTtf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F911CD23;
	Fri, 26 Jan 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282021; cv=none; b=KOHVEDjw3Uo7XS42Rc5m0E66ksdR7P9HJfNHiGfKg09GroSyJtdKWoajSJ3EXoLk6hmjCC8kGEizkpa8CZ2qzcQpFT5ChhpdKw5hFSfDmu3sduUcFWOLZdTyiDrakSvYCC2M8hSlLUDFGqKBQdXTzboRR+ohIqv8QL55rpPkc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282021; c=relaxed/simple;
	bh=cuMZ0xohqpnrjE1sn+GN/bE3cXEaSruxpkeDOj/4obA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=CRFxswmzN0gnfC3pkr+/nNj77yE14h3l1sRR6LSknCPpOGJW31ESK+bn4zeFnQdRakRhLXmbYHiZXFU7yPwsQxVt9q0CQgCqEud0kTnX2j1IfmjzsHO0oyg4GDPY82+LQdBZQ+r44k20EO/vRihDr3v8vdNh9JqplwR99R8eph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cangrTtf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QDmFdj018212;
	Fri, 26 Jan 2024 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=knC
	aqwLbRAz3GezKtQtpwgqOqAROHknpLYmHd715Ma4=; b=cangrTtfhNKiOkAnrxq
	0XboSQkmRMe0bJMR8VkAF0tf99HjEGd+5cUqjMqAj60MF/QhWRxK5u6VQm8RgOMB
	XBwi4dZ/bQM4+DcYZl5IwF9rZBbnoW5ikO7iMwe5wL5ZjMaZfjTaMPhAtkTJFGko
	ifXJkZGCvAstptEIMxoFddw/W1ZRcseK9czgt6HkAuDr5aSi3Ff65i8gw1VCqgDg
	jrs0AYTa6Gw9f6pqEWK53EpvpscIdeQdTLek2RcZ0Lksl0B+SQHiBBZrjDLNphKS
	ypGMJlHuD22qeUFWeVsoF6lB5mYNQsjV+aiontEPWm//Yw008thNcMar6f6xc+T6
	+Vg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv6c8h4y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:13:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QFCpuN006039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:12:51 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 07:12:50 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 26 Jan 2024 07:12:45 -0800
Subject: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOzLs2UC/32NQQ6CMBBFr0JmbQ2tlFRX3sMQU9qpzMKCHSQY0
 rtbOYDL95L//gaMiZDhUm2QcCGmMRZQhwrcYOMDBfnCoGrV1FIawc4oU6+TmBkjq/tJWB382Tb
 Gt1pD2U0JA61789YVHojnMX32i0X+7L/aIoUUaNreoWxC24fr602Ooju68QldzvkLWyXO2LQAA
 AA=
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
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706281970; l=2337;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=cuMZ0xohqpnrjE1sn+GN/bE3cXEaSruxpkeDOj/4obA=;
 b=ijny0goOnqHSWBi7mijP0EEhHd9vvASaf3FCUOX34zm9hoc2TmcYvP2FHOrRw7mcbDfY8N0fh
 IHB4Mm0Hk6sA4eP6lRF4sXyzNfwbNJpS4QIUygYQdhg1UwPbaW77RMC
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dpkZ8ZTPRsSbMbW6gUZELkhTwxU_auXt
X-Proofpoint-ORIG-GUID: dpkZ8ZTPRsSbMbW6gUZELkhTwxU_auXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=606
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260112

The SC8280XP contains two additional tsens instances, providing among
other things thermal measurements for the GPU.

Add these and a GPU thermal-zone.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v2:
- Drop TM/SROT comments
- Remove polling delays, rely on interrupts
- Link to v1: https://lore.kernel.org/r/20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..7bfbb1bd8f4a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
 			#thermal-sensor-cells = <1>;
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
 		aoss_qmp: power-management@c300000 {
 			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0 0x0c300000 0 0x400>;
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


