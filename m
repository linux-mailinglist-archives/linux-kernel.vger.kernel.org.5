Return-Path: <linux-kernel+bounces-108896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56A881180
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C1285D03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0124C3FB82;
	Wed, 20 Mar 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p50v3l7n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2840843;
	Wed, 20 Mar 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936654; cv=none; b=fWH5QXeBjk8iR9jZCWm+n9qUlgzLQxDN9K0MtrYGUbU3hrORMoq7m5lNNUO70TiOBYYjlE7E3KFXDrpWEiWnJ4FWRCPp6OBFcGCyn19j80oJlyxeCOZncyedbXuWlbzWvPHAsgZaM6TEClyFQcNrOi1vWL4O/B34riY8x30Y7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936654; c=relaxed/simple;
	bh=6BqKuQkKI7qqdSWP3RT3IfyKn2XXs/cwX6b6EcQFUXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8wzjheZNXMsb/hKEC36y4We/E0pelJ/MRuXZCsF2wLcGKKvdEzh9FX/odvwoP3d85aM84OcSRtJuj/MnIFnNjYy0ml/1a/9UsTDK8RU2OrPbzaJaICXj2hjPa/ds23Hmjd4EU8+D0JhjHWNM6TdeJDHcocykdb17lWtKt/A7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p50v3l7n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KBjCo1005923;
	Wed, 20 Mar 2024 12:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=yZkO476
	vWnBXahdSSyoINxOnrUmV547YEJLIGTKnHJQ=; b=p50v3l7nNS6K8XEov+CN+3S
	na4xRK8KNYVi6MlR2LWCW5Pi+9cg50QOKMbBKusXJd6CduSOzm6gGXYmYbeTgOJV
	0zGHquWoojVldCnoVv0xogBUrVvnRYTXbRZwddkVEebGq7UoKBsE65YlalHrlPYP
	vYCqy1xqGSMPKEg/UroQV5q3e6kTp4+4AsdMPyiCP+3XJ6eNO1I72bzIBRrRgyIt
	SJsBD869113JaIUdMEodjYAYuWTxVZBPEox1/a5a5pPkOJIt8cXOTI3WnBg3RpuT
	9bnck3/kBDOb5lupR3xXvSYrjb1jGNhWdz9loU0Lr+4CtGaucLg13OoYind1RnQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq138u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:10:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KCAjjv002954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:10:45 GMT
Received: from hu-uchheda-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 05:10:41 -0700
From: Umang Chheda <quic_uchheda@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_uchheda@quicinc.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: enable PMIC Volume and Power buttons
Date: Wed, 20 Mar 2024 17:40:16 +0530
Message-ID: <20240320121016.2878367-1-quic_uchheda@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vfYBdB2E3afv6-YuT3Ul3nb2Jk5xjWnY
X-Proofpoint-GUID: vfYBdB2E3afv6-YuT3Ul3nb2Jk5xjWnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200096

The Volume Down & Power buttons are controlled by the PMIC via
the PON hardware, and the Volume Up is connected to a PMIC gpio.

Enable the necessary hardware and setup the GPIO state for the
Volume Up gpio key.

Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 63ebe0774f1d..73f6d18d2331 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -9,6 +9,8 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7250b.dtsi"
@@ -39,6 +41,22 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&key_vol_up_default>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume_up";
+			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+			linux,can-disable;
+		};
+	};
+
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
 			reg = <0x0 0x80700000 0x0 0x100000>;
@@ -471,6 +489,25 @@ &gcc {
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&pm7325_gpios {
+	key_vol_up_default: key-vol-up-state {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.25.1


