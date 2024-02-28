Return-Path: <linux-kernel+bounces-85556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76F86B7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE99D286A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B19015CD59;
	Wed, 28 Feb 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dwe/EJSs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58E71EB3;
	Wed, 28 Feb 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146232; cv=none; b=BV8Q+tOq1aqZPXZYK7WnppS7Xw/KLXZyxzN7VV7QANAp7yaKI6GTlFTYXZB9Xt9Xv9BnIsGnEBjN2dLgGQbq0fv3Bnn0WVMqUG9eezN8yJxpsJrtBhyqlPqyDIzkZeDdcKLBGibirEWcyzHtVkGnl8nSxrNf7YDEtBOh6eiOSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146232; c=relaxed/simple;
	bh=cCJNI83N6rsCRckXXH/moUQ8dBac6pWGN8ufZKJRRGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nVQ3+FNmyhY3gOG5O6wx2VwxrPXKnUAlMbaXj1eMlrGi93DcUpHu7VTBlWaX8zO0PTDaWGxHsq+fAEJR7WRGQTzSSFQwZooDqrWrDRZsDzB3XxB5vNbDtJeFuZFJLsZlavfWVcmIPZ8mgLxFmJj+/ZvMA/j/aQbBy34mOk5Sg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dwe/EJSs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SEGGPM004022;
	Wed, 28 Feb 2024 18:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=K7mkrfq1S60nScHf6Bg536eGqqIlIrdzYLJ933gbQoI
	=; b=Dwe/EJSsht/j49cLMs3k+I7onNNEiCy8sIBQro/76UUAfoNmZ7HUtU1OVSe
	9vPkDQcI3lPn1lCSEtpzLBKRdXQG8gnsBOwKjekb3UFvid2y5jyM6jVXQJj7tcsM
	1hO18p9rR4vHv6uJR11KZz0DmtVXgIp37Hnl+gSnhbUiE6eKDGuS0wbkLNVRw9r2
	aqd6KDImf2jJ0K197Gu3a1RgwRbcvqZLUduO4/todG0bLX7GOSJjRbPFZBVyCOBE
	9mNB/XeWguOtAayo+ygrAOY8JlvIM6G8U+xAm+T5be3GEymOpNfhPLNKNeov+HVm
	jWZTrMMeFZOXo3QeNX5s3lOR6SA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj6en8sa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SIoHGd001964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 10:50:13 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Wed, 28 Feb 2024 10:50:01 -0800
Subject: [PATCH 3/3] firmware: qcom-scm: Remove
 QCOM_SMC_WAITQ_FLAG_WAKE_ALL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240228-multi_waitq-v1-3-ccb096419af0@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709146213; l=1197;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=cCJNI83N6rsCRckXXH/moUQ8dBac6pWGN8ufZKJRRGw=;
 b=fujmx0xJs81Cd0KwcwbVJRKhGkmWMxmzdxkShvQ6Qlq92Ig1PwPVtvreDECwhV4SVtXucN11y
 noRAmOFVA6pARIybJDIhPL0rZdRbJxURJUR/ulj24j/10WIR3L6Vdn7
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5kt6Ma8DwnAbiSFEPgjLQaly0GqUfnTh
X-Proofpoint-ORIG-GUID: 5kt6Ma8DwnAbiSFEPgjLQaly0GqUfnTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=993 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280148

This will not be supported by current firmware due to firmware
limitations, so remove it.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 4606c49ef155..2657372f210f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -113,7 +113,6 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 };
 
 #define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
-#define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
 
 static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_UNKNOWN] = "unknown",
@@ -1828,9 +1827,8 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 			goto out;
 		}
 
-		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
-		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
-			dev_err(scm->dev, "Invalid flags found for wq_ctx: %u\n", flags);
+		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE) {
+			dev_err(scm->dev, "Invalid flags received for wq_ctx: %u\n", flags);
 			goto out;
 		}
 

-- 
2.25.1


