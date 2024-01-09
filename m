Return-Path: <linux-kernel+bounces-21086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E282898A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F9C288162
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA53A1A2;
	Tue,  9 Jan 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d3DBv95S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2939FE5;
	Tue,  9 Jan 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409DASe0021854;
	Tue, 9 Jan 2024 15:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=nK4
	Hf4fWSXmLG/xYQ4mMhiWXDuk5dRvBPIYZXj8BQFo=; b=d3DBv95SaehR5lG46nb
	tYgvnpTcPNOTnSdYK4kFNA59hJ3rbZjcSn8JIGLZCT0pWbLFJ3MsRSbwPN4fwSzu
	FCEMeZEIa0xFO7ozP8yuzIYMsXEEckag80YTg8KCVJFnaeAkzu2SGPNRdY8aAfr8
	9ahf/Hjf4vQEg2UHImsZhl4EX5la5K3xrqKZKvYhiy1cdspzBqVRPlW9u+K9NGTF
	Wp8sT+uv+f1LlZCvFUdvmuXzffRkHnIpCXz07sQ6Vyz25Gq7Jor4Qkgut+UVsVeK
	AW8edCze3ooI6OJdm9+h4q1izG6dvQhj+I8fsdfkkgtzr8bCCcTHu7QnDpbRhBdn
	qmA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3me0q1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:59:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409FxRgT013128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 15:59:27 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 07:59:23 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Tue, 9 Jan 2024 21:28:52 +0530
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Update domain-idle-states for
 cluster sleep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-qcm6490_cluster_sleep-v2-1-8f94f1ad188d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADttnWUC/03Myw6CMBCF4Vchs7akU4uIK9/DGILjYCdSLi0YE
 8K7W125O9/i/CtEDsIRTtkKgV8SZegTzC4Dck3/YCX3ZDDaWI26UhP5g610Td0SZw517JhHZci
 2WBZHtLcDpO8YuJX3r3u5Jrdh8Gp2gZv/WqFLbcw+R7RYKFTTIlT7Z3SNO3+39JTT4GHbPqiHy
 IGoAAAA
To: <agross@kernel.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <luca.weiss@fairphone.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704815963; l=3670;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=HsiLymAapDxICNsJm8RvR9nghbPna45N73qjzdrRzlo=;
 b=OdMiayAB6VBVip4oObSIOW2EVh8xOQqWSFMElAuVCEtQ88JD6PcCQnPVvpqRFr8wwKvkOh8cW
 PmiSvrFM2doB8eXEVsihBaZCVALGK6Zz1za9iC/1Mp0a2RQvDbGsEum
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jiby65QDFMFSDLzIg2fJEItjMmt2Rzni
X-Proofpoint-GUID: Jiby65QDFMFSDLzIg2fJEItjMmt2Rzni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=923 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090129

QCM6490 uses Trustzone as firmware whereas SC7280 uses arm trusted firmware.
The PSCI suspend param and the number of domain-idle-states supported is
different in Trustzone for cluster sleep.

Move the arm trusted firmware supported domain-idle-states in chrome specific
sc7280-chrome-common.dtsi and add the Trustzone supported sleep states as default
domain-idle-states in sc7280.dtsi

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
Changes in v2:
- Move chrome specific domain-idle-states to sc7280-chrome-common.dtsi
- Keep LA+LE+WP+friends values as default
- Add additional cluster sleep states
- Link to v1: https://lore.kernel.org/lkml/20240105070223.11415-1-quic_mkshah@quicinc.com/
---
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 17 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 28 ++++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index c4d00a81da39..3fcf2e65afca 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -18,6 +18,7 @@
  */
 
 /delete-node/ &cdsp_mem;
+/delete-node/ &domain_idle_states;
 /delete-node/ &gpu_zap_mem;
 /delete-node/ &gpu_zap_shader;
 /delete-node/ &hyp_mem;
@@ -26,6 +27,18 @@
 /delete-node/ &sec_apps_mem;
 
 / {
+	cpus {
+		domain_idle_states: domain-idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x40003444>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9926>;
+			};
+		};
+	};
+
 	reserved-memory {
 		camera_mem: memory@8ad00000 {
 			reg = <0x0 0x8ad00000 0x0 0x500000>;
@@ -39,6 +52,10 @@
 	};
 };
 
+&CLUSTER_PD {
+	domain-idle-states = <&CLUSTER_SLEEP_0>;
+};
+
 &lpass_aon {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 83b5b76ba179..9f4df595dd21 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -453,15 +453,29 @@
 			};
 		};
 
-		domain-idle-states {
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
+		domain_idle_states: domain-idle-states {
+			CLUSTER_SLEEP_APSS_OFF: cluster-sleep-0 {
 				compatible = "domain-idle-state";
-				idle-state-name = "cluster-power-down";
-				arm,psci-suspend-param = <0x40003444>;
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <3048>;
+				min-residency-us = <6118>;
+			};
+
+			CLUSTER_SLEEP_CX_RET: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41001344>;
 				entry-latency-us = <3263>;
+				exit-latency-us = <4562>;
+				min-residency-us = <8467>;
+			};
+
+			CLUSTER_SLEEP_LLCC_OFF: cluster-sleep-2 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x4100b344>;
+				entry-latency-us = <3638>;
 				exit-latency-us = <6562>;
-				min-residency-us = <9926>;
-				local-timer-stop;
+				min-residency-us = <9826>;
 			};
 		};
 	};
@@ -872,7 +886,7 @@
 
 		CLUSTER_PD: power-domain-cluster {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
+			domain-idle-states = <&CLUSTER_SLEEP_APSS_OFF &CLUSTER_SLEEP_CX_RET &CLUSTER_SLEEP_LLCC_OFF>;
 		};
 	};
 

---
base-commit: bffdfd2e7e63175ae261131a620f809d946cf9a7
change-id: 20240109-qcm6490_cluster_sleep-2c4f175814b6

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


