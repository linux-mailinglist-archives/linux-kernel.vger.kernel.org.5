Return-Path: <linux-kernel+bounces-127601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949C894E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C060FB239FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986258235;
	Tue,  2 Apr 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ULSwMkVr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181D58228;
	Tue,  2 Apr 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048667; cv=none; b=Pr9vWtMiZkOBeKpnRz3TRQKsBj1pikH3f3IPJoUBsMp3V5BO6CkL2Mf8A2421DkOL70jyitEc3qyUCMXf1vjXbv1uM9Z//RwFEO/Aj1P/4L4x48jvXnDxjOtF9lZYsJfGu2zmJ4kGbIhK2+Q3/vYUgz+M6RnEeTNHM6Rc7+wsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048667; c=relaxed/simple;
	bh=PCI/CCGESfUNqVW4jcbTYPliUtx7egH/5+vjGwXzr0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtLoRyhP8BCKNeSJ/KlQxOPFPake97ezdi2L6WN/G7ETp2+gknFE934oATs3b3J8O34Y2+pP18+ioFU1Mlv64wY1BJ52Xb69g5u1+ZjHpa14DTz5rDCidX08JvkAdAgTMpPbQEKKHkLrknJewzXS8TTHG0xyLkXpcNu4lKlPdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ULSwMkVr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4327RiYJ030333;
	Tue, 2 Apr 2024 09:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iLpcL1IlYZQRAz+b1SjA3h6+D469KIgXJgw4bymKUWY=; b=UL
	SwMkVrNaycwAhDn5t4loqZtXnupJPmTTwRh5fkK02V63GX62g1sJLUYFkxsqQqro
	r5pkRgROn40CXDJ4cPjONC8Tky9bwLBQyAEjSitIENi+mGh11nzY2qur0g86Eh18
	AjemQn+yYgOTJjfhOLGC6Ae6HQOq3dcVPENjKHmhbP2tpQuOlI4ICAGnD6CLVI00
	bB91LhCf/ufnokkDQQkgvB/hg7tUYtOzWY4PNPjmfewR+jSLnb04SoG1S1wdDjns
	V0FRSF8Oe/TFIwmaDf+KbmkqHE/l5KnaOgp/PPlnXNti9lYvhfI4l1jT3g1+z5Gk
	HTSZb7Nev2uNG3kOS9Mg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x88eh8t0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:04:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43294LVc012543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 09:04:21 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 02:04:17 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        Komal Bajaj
	<quic_kbajaj@quicinc.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
Date: Tue, 2 Apr 2024 14:33:49 +0530
Message-ID: <20240402090349.30172-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402090349.30172-1-quic_kbajaj@quicinc.com>
References: <20240402090349.30172-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XUOc8BMFuoWbQbaVmsW9vVOe8fxyCiJi
X-Proofpoint-ORIG-GUID: XUOc8BMFuoWbQbaVmsW9vVOe8fxyCiJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=712 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020064

Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 97824c769ba3..a25431ddf922 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -434,6 +434,21 @@ &qupv3_id_0 {
 	status = "okay";
 };

+&remoteproc_adsp {
+	firmware-name = "qcom/qcm6490/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcm6490/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcm6490/wpss.mbn";
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
--
2.42.0


