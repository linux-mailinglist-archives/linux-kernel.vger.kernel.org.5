Return-Path: <linux-kernel+bounces-93608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410D87328D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C57B28388
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3485EE61;
	Wed,  6 Mar 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g3hibTTt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A25D8F9;
	Wed,  6 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716623; cv=none; b=GHuAdFC+1BGME1AllYEOfkeUzOFKvgM/a20YL+oM+tXpbLWmcsVFVf3VxyOBjlhv7ot4zdgAhklu2JDovwzfrjQ0hZd+nCP+4l1KzyCmzjYATbLkP7ZWiG7E0r8z798gzCW56eZEH7b08hIQk9ton2S3QygG49c/jNAQiohexNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716623; c=relaxed/simple;
	bh=6VrZRSURzUXrSBObI2POcRjZjknLbdF/Dl4bUKgbr9M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Qxf22Af3s5iqoE0rzbrdFP32BKdHpnKV365lAxHZKceNH+/CzrD4DeQZlBPHdO2BPwg4twIJTBmly8j9uEHUQ9HeQsQx9HAz3Emv0sx0Vuw3VbxPyK3s6BnafLjwcgx2n5s3f5eLea4qW+NOqgwzHCOdZdjdyyjDNLDQXU3RTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g3hibTTt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4265q93M026583;
	Wed, 6 Mar 2024 09:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=gQv1BqfTdUsf
	nWnODQhK96rxVTBRcHtoOh+02sf4lcI=; b=g3hibTTtKpbYCOwJlBXWXOYb4Sbv
	I1IXYHKCkppebLWb+v0gLOGg6Fyf2sH0QgXgwlUkNqqItJyM6SJYSBRJ4fxtegZv
	gwbslXAn3GCsZSGzypFpwSAD1GfvMkOfDp0QPYf+I+l8pZJzDS3dAKoej4pRk3fZ
	DXCmwKILt92uFuGgzAXKuxmFw2coW2vIq+BmK7KDHPDlKYWy18vi51EzqUo0Tt4d
	W+F2nb3KpEuRYoOffdCXkxqpAMCgUqRagjwVS2h3P7aRScpvNGiYLm9TyLom3VOC
	gBJedd6fO42gAz10/BZ+B03DDGD+ccGXc4Dg9UVMIjgW4gLLDTD7pD0k1Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjqf0dae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 09:16:49 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4269GktO022533;
	Wed, 6 Mar 2024 09:16:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wkw6kt155-1;
	Wed, 06 Mar 2024 09:16:46 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4269GkNT022528;
	Wed, 6 Mar 2024 09:16:46 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4269Gk91022527;
	Wed, 06 Mar 2024 09:16:46 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id C772A5001D9; Wed,  6 Mar 2024 14:46:44 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>, stable@vger.kernel.org
Subject: [PATCH v2] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Date: Wed,  6 Mar 2024 14:46:42 +0530
Message-Id: <20240306091642.9123-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jDFJ5S_vQCEQaiGFzoqot2HSa80kYa4k
X-Proofpoint-ORIG-GUID: jDFJ5S_vQCEQaiGFzoqot2HSa80kYa4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1011 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060072
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In current driver qcom_slim_ngd_up_worker() indefinitely
waiting for ctrl->qmi_up completion object. This is
resulting in workqueue lockup on Kthread.

Added wait_for_completion_interruptible_timeout to
allow the thread to wait for specific timeout period and
bail out instead waiting infinitely.

Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v1 -> v2:
- Remove macro and add value inline.
- add fix, cc and review tag.
---
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index efeba8275a66..a09a26bf4988 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1451,7 +1451,11 @@ static void qcom_slim_ngd_up_worker(struct work_struct *work)
 	ctrl = container_of(work, struct qcom_slim_ngd_ctrl, ngd_up_work);
 
 	/* Make sure qmi service is up before continuing */
-	wait_for_completion_interruptible(&ctrl->qmi_up);
+	if (!wait_for_completion_interruptible_timeout(&ctrl->qmi_up,
+						       msecs_to_jiffies(MSEC_PER_SEC))) {
+		dev_err(ctrl->dev, "QMI wait timeout\n");
+		return;
+	}
 
 	mutex_lock(&ctrl->ssr_lock);
 	qcom_slim_ngd_enable(ctrl, true);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation


