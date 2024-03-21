Return-Path: <linux-kernel+bounces-110214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B5885B92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4814128591C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A286255;
	Thu, 21 Mar 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PSFeJn+3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AC58624E;
	Thu, 21 Mar 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034663; cv=none; b=s8URNSulFUk3wW5qVjnu8LED7FjkFmiqKl9C9+kswnzHj+gfvM+vHqCenAdssj363Il8nZNxlpHudoNFvaKaNs2wgHO+MYezNtHEOkLY8J8BuG+0YGEpu83aPvyhDAa2aLv67lxhuug1ysHyW0XTp8A/Vhn3wJrBETgAK5izvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034663; c=relaxed/simple;
	bh=cIwf5+ODApnp9dDmGy58vm92m0RCRPL1X+s9JLtUT3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tm9l32gnST3ueegvlf4cBhpe4vAP1MBtLqyzbZ9KZ0QLar9Ly+mi8Ngvu7Bymxs6Cqrp3YxCH8ARi9tlvn2iUQFK25GKIVrQjxDXbMvPcIQh86sJQ8lX8tv2hgF4R9A0/SYfTvmxugpaMyR2zqQ7fLP7Ywm4yqpze/iUyd/GbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PSFeJn+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LAdwbM029392;
	Thu, 21 Mar 2024 15:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=cG0lVyb2TamI2l+l0k2oVPo2ORBpTsuCykTEHklUfxs=; b=PS
	FeJn+3koptauJaocB6xCzn3xPmKJl4i+ocNFfDyrxqfir2hI5af1Wv/nHuA+U1cL
	NcMe//eFgmq11DaNAezJ/8Z42Xupi9X57CrVEpYyTVHFy197rjMrV9iY9crpU/ZI
	L1A1p6vSleQwU3Ncq7GdlTpBcv8TnHyOSQguMoY7Sw8qxrU7zGM/mZ4wCqqlIYfN
	eZeG1VVs83cIP8zgb4KbMbmfr1j6uHKar5ZWzrvgwYT/eAUXa+pL1Al54e2jHcnq
	u/H5oXPP1LHTNGlSvn7PA3GAGqbI3ot7M4D7tsu4eEYnVyx4c3SMt+sQPi4vdvaq
	lq3d53P/+1vyrfEeOSug==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0ka60r8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LFOFIa027598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:15 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 08:24:13 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh
 Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 1/4] firmware: qcom: scm: Remove log reporting memory allocation failure
Date: Thu, 21 Mar 2024 20:53:59 +0530
Message-ID: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ELKtj7zOupBOlmaCklLVrHxleRGZxuvw
X-Proofpoint-GUID: ELKtj7zOupBOlmaCklLVrHxleRGZxuvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403210110

Remove redundant memory allocation failure.

WARNING: Possible unnecessary 'out of memory' message
+       if (!mdata_buf) {
+               dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
Changes in v2: https://lore.kernel.org/lkml/20240227155308.18395-7-quic_mojha@quicinc.com/
 - Added R-by tag

 drivers/firmware/qcom/qcom_scm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 49ddbcab0680..a11fb063cc67 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -554,10 +554,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-	if (!mdata_buf) {
-		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
+	if (!mdata_buf)
 		return -ENOMEM;
-	}
+
 	memcpy(mdata_buf, metadata, size);
 
 	ret = qcom_scm_clk_enable();
-- 
2.7.4


