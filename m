Return-Path: <linux-kernel+bounces-127600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6A894E36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56B7283FFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA425789E;
	Tue,  2 Apr 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S67n+XCC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692B56766;
	Tue,  2 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048661; cv=none; b=fa9H22OVXkYDSfxtS8ruHYKDFHpZRCW5yHCVaibtUPTamsrETC8vpvt+w/uFT6NoOvjiuQl4mRF5LCfhSWiGsEOwG62dkA8OF7IGv5cP8NApH+TFSTrTRk2/GED8wKwDQR0/lRoK92UrJO4zGkT1oZG5w+AHw31QIpzWYn+VKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048661; c=relaxed/simple;
	bh=ew52OlP+4WLZXvtL/5Te/v2gvm8lhN6buPx7CzFGAbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuMJ1+lyOtnD8Gcgcpn/FNuXxn+FRaL+oPFVZKSndidrACfcMSRHHiPDtWUXt4TEa4iZvggVilwBlRKFM60DCU+g9AQbGInlxLGNhKDjcdoDiPgJxg36rr3yHwN5V3zbCQ56P6zLhTNKa9zf/+7IxQt3WqkeLDzunSM1pupWPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S67n+XCC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4323adwY025892;
	Tue, 2 Apr 2024 09:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=un0U3xHErJUamQtk1YtzyRZf4SuBPc4Kn41wHP2xMls=; b=S6
	7n+XCCHXC209OsHEZZCawmRfjwA77kXWMLXgusp8tdmPlkvytivceOaA/FcUN2Ft
	ozkYyfxVBqMgiR9mPdiBm1nnZDVSNqTZVE5TQ60tLVO+m7Sd6etqandBqE0tOvuT
	Li6QTLHe1XeDRu0c3voCr14CzkK1cWxhRq5SlvLFg0r7P/HpDb0BzBQ8E7pETlqb
	eipVsL2i//gFwPGbETC0R604VAP1zB2i+qST1XaLB3R6IwxyOqEWvjgik9pu7l1I
	KP7MeB1xAF/YzBFqEyFq0NozxcmD63KYhq1X004IcEaHzU4aQyhCLad29uU+djD5
	fzYRXJ2xlMsfQ3egk1ew==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x84b8976v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:04:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43294FcA002264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 09:04:15 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 02:04:11 -0700
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
Subject: [PATCH v2 1/2] arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
Date: Tue, 2 Apr 2024 14:33:48 +0530
Message-ID: <20240402090349.30172-2-quic_kbajaj@quicinc.com>
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
X-Proofpoint-GUID: l_Kx_3j6ukV1TLpQc6iRFyTm9Q6dysJt
X-Proofpoint-ORIG-GUID: l_Kx_3j6ukV1TLpQc6iRFyTm9Q6dysJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=730 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020064

Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index e4bfad50a669..3014056a3607 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -452,6 +452,26 @@ &qupv3_id_0 {
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
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm6490/modem.mbn";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcm6490/wpss.mbn";
+	status = "okay";
+};
+
 &sdhc_1 {
 	non-removable;
 	no-sd;
--
2.42.0


