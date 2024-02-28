Return-Path: <linux-kernel+bounces-85555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E286B7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDDCB23F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB057440C;
	Wed, 28 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mkLcwBt6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3571EB9;
	Wed, 28 Feb 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146226; cv=none; b=S1dc/kYHGasHTEeaO9rCrAADjaDAHSgso/B+DbKvZT9CUKZ3uLdB0pQhlW8CmvtCTopf1OJTsBCCQcuQL2aU51jbKxjg+GfPH7FRrzeV1/yVeHbjG0LHrno9/virZNG/FSSNEdGrJnlOXT03tpDzUpFiSoCGZuqvgu8re4HhYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146226; c=relaxed/simple;
	bh=qJ7niq6CmCPHPuu7A+47NgDwyWhCk2+VCDD6NlHJYuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZRfVHbA2v2Xogu8Rjb9uP3tuNC+cMi3U9UaugWiIbINObR4x1tto+c+QZ/0Puck43OJuYlPxgQC3x/NNROlpKqndvh50H6QE+co8GEh3ljNVH/u+Ywj/fjMWrWKlgHAa9PeRnbhzWxn2jD27rxgXKnHBCt3NAKUz14e/Z/Nyt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mkLcwBt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SDd91q008523;
	Wed, 28 Feb 2024 18:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ZiPseMKtZy0y624G5s3+0Q/s+zXnRig0XH16Jeuxqkg
	=; b=mkLcwBt6CFAfAmBrlkCBWPuJqpnIqdgEwRH5g4sPFw8gdgKOV4IlkF2u2T4
	N3Uu7Dwpq57mxCb4pwmcLU0ZIk6oztdrBeLu5EwCJ9/TM1GtaHyWug97ApwONd5I
	AZxGkNgjuiDX22FOYh5ykUG6djqsPTgrV1KixdmrgmsrX65KjnsW3hxqTLmSHV/s
	g6hJRK/PTk+Zmzt15xLnjXEvpyJiKCsCo2O/M2batbHVZEk6ZkPVaizpXWUbOThM
	TJIsSjNRelGWJQ3ICzvQnDoYOecEkWiD3FDSh/4zT+JUk6VqBrWKVZK6Ca1WJ18L
	skJ0LY1J29MvUqQPDk4aaGsphhw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj5wc8vaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SIoGtF013925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 10:50:13 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Wed, 28 Feb 2024 10:49:59 -0800
Subject: [PATCH 1/3] firmware: qcom-scm: Initialize waitq before setting
 global __scm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240228-multi_waitq-v1-1-ccb096419af0@quicinc.com>
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
In-Reply-To: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Prasad Sodagudi <quic_psdoagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709146213; l=1041;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=qJ7niq6CmCPHPuu7A+47NgDwyWhCk2+VCDD6NlHJYuE=;
 b=hWsqUODIsElXLLnHPgV45a2DNDpX3ki0ik9yy6Rva8e5+2NzYVgjN2a94fhzbtkB8CgkzFuU3
 K5GgZuOWchgBGBqywpKGX0oufBWcXzjdh4pegc2BwxAEI9gkLAQ976y
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A_m_Gaiw4dbEE_OX5PsZztKmPbQwW90S
X-Proofpoint-ORIG-GUID: A_m_Gaiw4dbEE_OX5PsZztKmPbQwW90S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280148

Suppose there's another device probing at the same time as SCM driver.
It calls into SCM and triggers WAITQ sleep but waitq completion
structure may not be initialized yet.
Fix this by moving initialization of waitq before setting global __scm.

Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..c1be8270ead1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1854,11 +1854,11 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	init_completion(&scm->waitq_comp);
+
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
-	init_completion(&__scm->waitq_comp);
-
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
 		if (irq != -ENXIO)

-- 
2.25.1


