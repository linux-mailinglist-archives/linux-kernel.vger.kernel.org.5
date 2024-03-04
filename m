Return-Path: <linux-kernel+bounces-90673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41A87030C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7D1F21CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D273EA69;
	Mon,  4 Mar 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irtJW8O0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E93D963;
	Mon,  4 Mar 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559766; cv=none; b=JzXGTRMNZpYKZxZphESJub9m9w5yowGALFx2L0wcrMD+PeRrSPz2vS//Mldx9d2jVK3FPlmKonx2UFu4IdTCbkFdfu+7Edqb0rpuQFPfN5NJkb/19KS1xcwra1/vqEiP5pdnzO5QkvWy9JIYMzJ+2rmhiRDglJMqkWF2GF5VkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559766; c=relaxed/simple;
	bh=uof/ush/MFndl5WiP6r2u0em/l91glIDX9t4FzIKBFg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dueV5DguxkohvaAd9Eigp5yFNmm9bBUBRkHjW5GEqlE0MA7BAujrVUQ8mXv3GY4SxYKiGrZPoch7LFP3+YpFodX1DPkxnrmT5vTdI2F0/NNuz66j1qSKk7H5Ru7YwEw7K+Bt8XIsfbJI8I70tunwtb1VBtKjzS1oUf/vin0dj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irtJW8O0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424DgbHs025574;
	Mon, 4 Mar 2024 13:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=J98nZN1Wf+Z8
	xl5UNZWuCOEvqbu2IIbX5MnokV7ko2c=; b=irtJW8O0ksF+hDxzFcr3PG68Jd0V
	059TNjC1T8Dj7Ine7fiH7v3j+xbEcj/KH6TaG4TCGfwp4XJlXf4PNw11VHLjV4kc
	6/KF8MaRWBimKrFpuOLNRLWF0dikLvuyDAbNiiDbB3fpsA9Zp048MUwmRWx9SgAQ
	2IK/o+E2go7bIbZIBZ835UmaZYVBF82oLmNgn3x1fYAzoOtInQ0fzu+Wh2tDDtK8
	eLxjraP0YVoky0KahY9AOl/SFTiqjbzOYrRC7phU3ykVBlaThcVs4be5bYhPfo8K
	DX97vO9XiX8W5hv74ii270Ao+rCgOgm3EL35re1KvEgaq3y3OxmCIG+rJA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn6qx110f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 13:42:37 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 424DgWof003908;
	Mon, 4 Mar 2024 13:42:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wkw6khygt-1;
	Mon, 04 Mar 2024 13:42:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424DgWdU003903;
	Mon, 4 Mar 2024 13:42:32 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 424DgWAl003901;
	Mon, 04 Mar 2024 13:42:32 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id 725815001CE; Mon,  4 Mar 2024 19:12:31 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v1] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Date: Mon,  4 Mar 2024 19:12:28 +0530
Message-Id: <20240304134228.16627-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: od_AhOf-ZDhZmbY2pp2n9cVpFgowZs0n
X-Proofpoint-ORIG-GUID: od_AhOf-ZDhZmbY2pp2n9cVpFgowZs0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1011 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040104
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

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index efeba8275a66..c27076d8b7db 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -83,6 +83,7 @@
 
 #define QCOM_SLIM_NGD_AUTOSUSPEND	MSEC_PER_SEC
 #define SLIM_RX_MSGQ_TIMEOUT_VAL	0x10000
+#define SLIM_QMI_TIMEOUT_MS		1000
 
 #define SLIM_LA_MGR	0xFF
 #define SLIM_ROOT_FREQ	24576000
@@ -1451,7 +1452,11 @@ static void qcom_slim_ngd_up_worker(struct work_struct *work)
 	ctrl = container_of(work, struct qcom_slim_ngd_ctrl, ngd_up_work);
 
 	/* Make sure qmi service is up before continuing */
-	wait_for_completion_interruptible(&ctrl->qmi_up);
+	if (!wait_for_completion_interruptible_timeout(&ctrl->qmi_up,
+						       msecs_to_jiffies(SLIM_QMI_TIMEOUT_MS))) {
+		dev_err(ctrl->dev, "QMI wait timeout\n");
+		return;
+	}
 
 	mutex_lock(&ctrl->ssr_lock);
 	qcom_slim_ngd_enable(ctrl, true);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation


