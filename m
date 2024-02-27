Return-Path: <linux-kernel+bounces-83553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C06869B50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F831C24E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2659D14AD31;
	Tue, 27 Feb 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q9I2jvRY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0314A4E0;
	Tue, 27 Feb 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049234; cv=none; b=epD2g+jwj/P8UGpAof74SpkEUzPNs5R4LM0xziGHcuozfDxXwwHda2G20OjqFPb9Urd2kcRW3v6fjqT+vrG5fsPCXUeapHDydHaw8izB3CkNHKYXo8EGUwf1vugdhnTMJlSYbvqRaZV67+4AcCpAXyXECId8foCVGutzN35ysss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049234; c=relaxed/simple;
	bh=+J0F74HTuPKCdwhUHHllo8INkNq/eyJeGz2YooKuLm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3SUvbDQ8aaO7MtnzXJuRZWUNcx1vsj2XxwT14Os1JVP51ooYn1e8vcYUE4SeE/y2uuEQX+rR+Ql/9Cz9+qZEgh+h7rIB8EpAdV9Hez8HZDo5NCoj9fDazmHThSAk+kGxz6+nWBzK1ZK++TkiFIGjtIRDmml+ShcZn/fUlfS12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q9I2jvRY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RDndPW028801;
	Tue, 27 Feb 2024 15:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cOKvVvpD1I2S/Q9+VH6NkXE2J8N1Hqi/V3A0NVLdoCA=; b=Q9
	I2jvRY4Pz1xCC90Of6JV62iSOYVqavpo/eoQlat/TPanB5kBt/tMhnaMn7nqAbCi
	Eiy64MHm85O0lKKe0o+Sgclrs0Xyb43kMri0fjzQF+IWRmcwjJHKmzoioUUnm8oZ
	U0xfo55DQRd6ANWNJaj4wH1pfXXRDrqZCs4ObekhqfVfvI5rnA1lb/z42cUU1BtB
	TNODRjro1Mnq12Zw3+wzbq4vESecrgqhBXgDAzxx+RKfoe+l4UerHm+kD9ovkh5J
	YNhcO18pC9wcNfRPN6mzlXFL+e8oa8h2g8qnmO5cgvEjT3xr+C36mvoWUBU1yE/8
	daw9A47TYgejLeZM2V0Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64qhtv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrmRa000472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:48 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:46 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
Date: Tue, 27 Feb 2024 21:23:06 +0530
Message-ID: <20240227155308.18395-8-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240227155308.18395-1-quic_mojha@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OxoyHR36EaGPMTU2SDlkdk8ZqNJP6E5g
X-Proofpoint-GUID: OxoyHR36EaGPMTU2SDlkdk8ZqNJP6E5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270123

qcom_scm_is_available() gives wrong indication if __scm
is initialized but __scm->dev is not.

Fix this appropriately by making sure if __scm is
initialized and then it is associated with its
device.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 6c252cddd44e..6f14254c0c10 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (!scm)
 		return -ENOMEM;
 
+	scm->dev = &pdev->dev;
 	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
 	if (ret < 0)
 		return ret;
@@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
 		return ret;
 
 	__scm = scm;
-	__scm->dev = &pdev->dev;
 
 	init_completion(&__scm->waitq_comp);
 
-- 
2.43.0.254.ga26002b62827


