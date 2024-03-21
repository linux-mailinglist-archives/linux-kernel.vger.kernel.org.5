Return-Path: <linux-kernel+bounces-110218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F5885B99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94E61F2195D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFC8625B;
	Thu, 21 Mar 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lb0Mh8TE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C89A947;
	Thu, 21 Mar 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034708; cv=none; b=IrGy8TE140MA6kXla1YQb0nbcUkzv204kyEWhJ5OcxzyiRSdVtqSKwxA6F3rZgeiLG+dDOmzCAXqtbc4Hz4rmscsVotCabG7pbleQiEM+1+cNf+eCofq2Op4ke+XP7WAv8iT+fLkjmb6FRXeP3aQYiiSxfPb+z1Ocw8Bue2n4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034708; c=relaxed/simple;
	bh=nScFnHlL7qAuBvXIbJwu/HhkppyDJ/y3VdbR3v42IXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQrZ+y+jjSgxCtHChJt1biGX0HZtcqwXnDbevU+fGBV2nLnKsC9ta2Cd9VPNVIh8dK5iczFUoeZy/aTsuqdTMGottADRtHD6eA5CfxhyQzdl3M0ufvilq/E/Q7MATDI8m4ja+pUHFGL6b0fCDSFArOzN5Bqlld0tu7pDI3RkkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lb0Mh8TE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6Y0qL026315;
	Thu, 21 Mar 2024 15:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=4xUMm1i3A01jJ6DH6SDj
	r2kR8eQLRFI5iu89vpudroE=; b=lb0Mh8TEiX50t6rKKgfRXwNHdsMKuwBukRwu
	sAPLsmaxoEnWFMikTeKnPY/aWAXkKtCmxocp7rXobPvJcEPUReQ+Rcp7fbzfkMCn
	C65Z+oMvotshpFkFoOWb87vCyJzuNlCWGRWqCqNEaEb573hKEtyT006yZirAtKm1
	MpQBYnYjyUUG7cQrYzl+OMvWLCijD0AHMY6/J5S4DgLyCQ3OPQqAYyGwKN1e6sFk
	DxXcfoO7yRzPzxTmMEvoxK3jtnukx0TvFRHLpFELOIZOFMG+ZqkzSO9Bt8hjw5jx
	xqG0+YCXpL9i2ooN6s40fT9csclsVjtgSPM/izEY7NH9BJEz/A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fqxh8py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:25:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LFOP6P013309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:25 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 08:24:23 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh
 Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 4/4] firmware: qcom: scm: Fix __scm and waitq completion variable initialization
Date: Thu, 21 Mar 2024 20:54:02 +0530
Message-ID: <1711034642-22860-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qlzqtlVChHi5xwsx2rVUc494xtlMvSQc
X-Proofpoint-GUID: qlzqtlVChHi5xwsx2rVUc494xtlMvSQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210111

It is possible qcom_scm_is_available() gives wrong indication that
if __scm is initialized while __scm->dev is not and similar issue
is also possible with __scm->waitq_comp.

Fix this appropriately by the use of release barrier and read barrier
that will make sure if __scm is initialized so, is all of its field
variable.

Fixes: d0f6fa7ba2d6 ("firmware: qcom: scm: Convert SCM to platform driver")
Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2:
 - Added barrier instruction to make the stores available only
   after __scm initialization.
 - Moved __scm->waitq_comp initialized slight up in program order.
 - Added Fixes tag.

 drivers/firmware/qcom/qcom_scm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e238ebe21099..f014a934a603 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1737,7 +1737,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
  */
 bool qcom_scm_is_available(void)
 {
-	return !!__scm;
+	return !!READ_ONCE(__scm);
 }
 EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
@@ -1818,10 +1818,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (!scm)
 		return -ENOMEM;
 
+	scm->dev = &pdev->dev;
 	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
 	if (ret < 0)
 		return ret;
 
+	init_completion(&scm->waitq_comp);
 	mutex_init(&scm->scm_bw_lock);
 
 	scm->path = devm_of_icc_get(&pdev->dev, NULL);
@@ -1853,10 +1855,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	__scm = scm;
-	__scm->dev = &pdev->dev;
-
-	init_completion(&__scm->waitq_comp);
+	/* Let all above stores be available after this */
+	smp_store_release(&__scm, scm);
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
-- 
2.7.4


