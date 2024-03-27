Return-Path: <linux-kernel+bounces-120195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA588D445
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322AB2E3D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1D2033A;
	Wed, 27 Mar 2024 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NqA4C7xc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821F1CFA9;
	Wed, 27 Mar 2024 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505085; cv=none; b=R6cHW0NwUWzHQZEzqzhw4kTXFBikOINhA4me3YzhNoKOj434DnfkO62ZOb/NkLAGasf4sBugUPVir9vSK+reYQ4EYhnJnRgDGpDCTaQJic6ZHdO8lhCSwz0gmDGe0PzjIRKWqigx7mOsWDwyE2a2uXiOLmm74HQhhQ6B4U8E9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505085; c=relaxed/simple;
	bh=UcA5fpODFuXRXze3of7NZl/yRckbmHg59bEwRvNw+5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G4LF4moMsENpT+OhJs2LgBJpcIJQGdv+uEWcnVmF77sywBfHZX2OztoyZYIvrcKR43SLni9wOz8X0jkktotsjxWPKCqNQq1eiDXzEmIDSL+6oHJ7PR9FOcED9qPpS0CsuQEMuRWp159ejKb6vhxcPMSI7XCsQ7DvKhWjIHK4C1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NqA4C7xc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R0Tid1019760;
	Wed, 27 Mar 2024 02:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=RSiZS1eVBzwonBiGx/3biM0BhrxixAuWSSq1VEY8GeI
	=; b=NqA4C7xchNTOLuu6I5wFfAOuzrAb+QEJdQ8UQPGjyIUnSz9RTXyAlDmteDv
	f4HypLjFKpWMJ7Yuaf+XtY/TwPutKuyVmMVv5yX/kPKaPicidC7SKdmjqufN2xoG
	zfJ0JP47q0El/jpcGD7qEbGwZuplMSJFkx3yZlaG3TFBAC/4AH1O84U491/yqxpl
	532GYZM9Jg+HIBNqFHfHLF1ysGll4N6HsOSED4uUaYh0Tmw7bQD1Rb88oGNRjwrZ
	3QWucw669zqzpUy2V4kTJnfgnneca02q6MZIpjKUZEHUmMBBoBprU0Dd/WseSN99
	PG01J3hDjefVOF6oli6vvS3srEA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4782rbgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24Uei012490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:30 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 26 Mar 2024 19:04:20 -0700
Subject: [PATCH v2 3/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and
 cdsp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240326-rb3gen2-dp-connector-v2-3-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=833;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=UcA5fpODFuXRXze3of7NZl/yRckbmHg59bEwRvNw+5k=;
 b=gX+LBpPP/9ppX+IG84hsrHiqE42tdpxe2uPNtf0IRyKdsal8ixQq+5nzi9FBKHBtMCjOxSG09
 MjTZgg/WtPrDI6NPlnObn0m6B1gXtBSwB2OiSclUZG7/n4iBKNvpW1h
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DnCoExS9qmUtWfwKFsN-_5f5k95X4cGh
X-Proofpoint-ORIG-GUID: DnCoExS9qmUtWfwKFsN-_5f5k95X4cGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=805 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270012

Define firmware paths and enable the ADSP and CDSP remoteprocs.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index f90bf3518e98..5b267a94a282 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -508,6 +508,16 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/qcs6490/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcs6490/cdsp.mbn";
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */

-- 
2.25.1


