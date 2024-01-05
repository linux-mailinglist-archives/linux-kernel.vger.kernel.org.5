Return-Path: <linux-kernel+bounces-17529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAF8824EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EF02831D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632DB18ECF;
	Fri,  5 Jan 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SnPmFByC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC41D68F;
	Fri,  5 Jan 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4054lZaI018206;
	Fri, 5 Jan 2024 07:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=daUbjRA4w9MhA/HZMlgc3cAZna0YvIsopZW/rhUvTjg=; b=Sn
	PmFByCEViHuBTapBqGTDryrG8t3RQRNTiS10/S6NJaJKnhBRuoW9FUqVOUsg3IhI
	ayFUf+c6G6zCgLWossix3sE7E+ORco2ZTQFV+kMEYfBBWokv//0e2au8bXKSiq93
	9xQv9AjbI8gRxl8HYweB0or+uGvTIWrHE/m5NlUKO2wa9nQ33Nd/RyZMkOzR6bgk
	eYKN6ly7qVK4MSbSMIVEeXFs2kTg22mpkqFE8vOAme9Fw8pka4+B5lbBXWUZ6jig
	AF+xWQH6uuyX/JA+yiWQztV8Ru1t3h0j8bCwsHWIG4tUnhYC+cY7VwxycN+jj83P
	TG8dYx2Sv0Lx1YE/TgAQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve97r8cs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 07:02:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40572aAP002746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 07:02:36 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 23:02:31 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <luca.weiss@fairphone.com>,
        <cros-qcom-dts-watchers@chromium.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: qcm6490: Update PSCI suspend param for cluster sleep
Date: Fri, 5 Jan 2024 12:32:23 +0530
Message-ID: <20240105070223.11415-1-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hYcjKSKGQ32mQ5INbVVlZT6yek5cFRG4
X-Proofpoint-GUID: hYcjKSKGQ32mQ5INbVVlZT6yek5cFRG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=847 suspectscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050059

QCM6490 uses Trustzone as firmware whereas SC7280 uses arm trusted
firmware. The PSCI suspend param is different in Trustzone for cluster
sleep. Update the same for qcm6490 based idp and fairphone fp5 boards.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 4 ++++
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 176898c9dbbd..b56f6f26d96f 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -446,6 +446,10 @@
 	};
 };
 
+&CLUSTER_SLEEP_0 {
+	arm,psci-suspend-param = <0x4100b344>;
+};
+
 &dispcc {
 	/* Disable for now so simple-framebuffer continues working */
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 03e97e27d16d..afac0ea0d297 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -415,6 +415,10 @@
 	};
 };
 
+&CLUSTER_SLEEP_0 {
+	arm,psci-suspend-param = <0x4100b344>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.17.1


