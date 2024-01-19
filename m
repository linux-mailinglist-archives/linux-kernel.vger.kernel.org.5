Return-Path: <linux-kernel+bounces-31414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6226832DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F8A1C23AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398E55E6E;
	Fri, 19 Jan 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bgmKuxsi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F455C11;
	Fri, 19 Jan 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684443; cv=none; b=nGK5CR8yHWDIK5KEBmA8i8ghSmiIj8Dxz980nEZkvdDo1RRVWRIqLjEEa7eOojpZ3wIR0ymnX2RV8jgSMwx5wOCfMIaLy+LAvubH9XYGy35EEUO2BIBJAKlKT1myxJrgfJGMuAi5nqK0+f8rFxZhV4pMQd7W7r9dpfHo2+ANjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684443; c=relaxed/simple;
	bh=DmmofHX3KxPaCl6ZMtjjgYNUSvVnR35NX25lwSeOb50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lB9fYINkIJrWxebNLd/5CZOFjJmYi7EXuy2aZSnTAna8btnpVUxddbgtK1f9b25GwFSq1auE1r3kQTSea/Ts9kW0AIWRaMcV/fw29LMDjkV1TD6DXyhPXEE7lKv0f2Gn/5JrrKEP0LH++I867F0bFIv0g3/p/7YKP4+JHBIvfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bgmKuxsi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JG12Cj027001;
	Fri, 19 Jan 2024 17:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=/c9
	po2kLn4GNWrPlZorjB2epa8/jXcvXyMhmRkCx4ZU=; b=bgmKuxsiFl2/h1zSFp5
	ILazcYC3PfBGC52DRv+JL2i66ikbynksb137/Fwk2mUbiMnOKXHssVYkEq/Loil/
	l86OCwxM98zZ6ANNTDM7EYzr10oPCADquA4wZTIl9f5khmnIUh6agr62eHfz3Dze
	juZQw6Ft+wqxPGiCyyMFMfJsnUxUd2ipDJZLL2Fxrh43c6H6/aOWkpN1hIe7eUU/
	BeMLCt5tkBC29bW9sB2OFu8cwDo5Dp1/QG66x47sDbAfQaArwXkXG8WbVXG030ko
	WFInT/7mPeFvwP7ctGHPs5tn4i/zveLCVbiPoA4tTXk0eBK+xyf4zG4kA7YDRwvK
	/Uw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqhpb9f48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:13:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JHDeAF000526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:13:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 09:13:40 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 19 Jan 2024 09:13:37 -0800
Subject: [PATCH] soc: qcom: aoss: Mark qmp_send() __printf()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240119-aoss-printf-annotation-v1-1-27e2ceb8937a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMCtqmUC/x3MMQrDMAxA0asEzRHETjO0VykZlFputcjGMiFgf
 PeYjn94v4FxETZ4TQ0Kn2KSdISbJ/j8SL+MEkaDX/xjce6JlMwwF9EakVRTpToIhriG7QhMflt
 h4Fw4yvUfv/feb0PZS59oAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel
 test robot" <lkp@intel.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705684420; l=1111;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=DmmofHX3KxPaCl6ZMtjjgYNUSvVnR35NX25lwSeOb50=;
 b=/8yjevG+EvlfESLtBuioM6X7l/awzZNvu12Vq2pNyoSGJbAXksb7ma+iEYFlEmy7r0pspoeay
 I5inyTKce7pCrcb3OhMS1ZqjBXOyVil/QCPds2p4Um3KhXCdG50qldC
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tzwWyyG2CPZtb_KrkwNtHjoz_C2csfPa
X-Proofpoint-GUID: tzwWyyG2CPZtb_KrkwNtHjoz_C2csfPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_10,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190099

As reported by lkp, qmp_send() would benefit from a __printf() marker to
allow the compiler to further validate the passed parameters, fix this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401100855.UYl3HPPt-lkp@intel.com/
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/qcom_aoss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index aff0cfb71482..9d7a74767008 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -214,7 +214,7 @@ static bool qmp_message_empty(struct qmp *qmp)
  *
  * Return: 0 on success, negative errno on failure
  */
-int qmp_send(struct qmp *qmp, const char *fmt, ...)
+int __printf(2, 3) qmp_send(struct qmp *qmp, const char *fmt, ...)
 {
 	char buf[QMP_MSG_LEN];
 	long time_left;

---
base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
change-id: 20240119-aoss-printf-annotation-df3d5bdea253

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


