Return-Path: <linux-kernel+bounces-93360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD4872E82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C922889F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C51BDCE;
	Wed,  6 Mar 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mw1USBM5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C98101D5;
	Wed,  6 Mar 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709704420; cv=none; b=lWJLlO2XvlJHqYobpQivGPgEkUV0zN1BU15qBN8DbPpOZGGnxzLR3PlNO/XNNKVj6UU7f6gwutAYX69JQgzHasOXYtCHRf99q6RMBv4Nf0JhrSdlBL6HiZ7KhVLOSut+NhYMFTE/5cXGi6MDqZSplNurdhwmkhYBKCn8H/ngQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709704420; c=relaxed/simple;
	bh=I5wUOieJD3ZUYjfyok1s6nSZk2B2zjNd8lL+zwYCZUg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZlLNsELVQFpIJi+b70nY0iLzesFWUolnF+jrs/OdJEESoQYIZmXWumbv5NF6VKLpB5YM1YrhuJvVpB26RFABGfpHd8yal24Sv3FZPtIZDer9hCD3n80jwqb6lE5xkIBA/E52LMuBmHWHp/ZG1bmrrSXIZJudjZgHkBCcMsbsJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mw1USBM5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4265GBAW026912;
	Wed, 6 Mar 2024 05:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=52L1RIbzz0EL
	fBWcpUM9EaDj74BxCy8tajlmOSjrnJ4=; b=mw1USBM5l+P7VZrsQyBZQpEwkveW
	zmW/RorXqQL3TBoP+i5sVUFHawfRzL1FJly+yVA7kCXjQzvWOZujyyPg4SBLlFzK
	/vXOyqriix+GBoos2Kxj+TC2quu8E0a3khssd0CTrjMgJvrbjhXjvrAq/ppMfUNg
	9bAIpQHmxNJYTPchdTnX1aWeqUaj37j8Ivc+yCAFC8pPc50FxSI+fu0DSJBmOHHX
	ER4vl1ibIMrdZrl+L5JW99RCJIn6Kp6vm6VB1ueXmnim8UMaTd1BFuqo7MWgN7G2
	9U9YiN4dlAwLJzfjxsj46BiArdK34F/mnqoJ7TnHsIgZOGkdSQSNrNagyw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnx0y2tax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 05:53:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4265rTSv019542;
	Wed, 6 Mar 2024 05:53:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wp0606a5c-1;
	Wed, 06 Mar 2024 05:53:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4265rTk7019534;
	Wed, 6 Mar 2024 05:53:29 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4265rTT1019532;
	Wed, 06 Mar 2024 05:53:29 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 91E722BC9; Wed,  6 Mar 2024 11:23:28 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] media: venus: avoid multiple core dumps
Date: Wed,  6 Mar 2024 11:23:26 +0530
Message-Id: <1709704406-22501-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7DQoBiCvnEKWTE16WudirzFuxTPnJIpH
X-Proofpoint-ORIG-GUID: 7DQoBiCvnEKWTE16WudirzFuxTPnJIpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_02,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060044
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Core dump is generated whenever there is system error reported
by firmware. Right now, multiple such dumps are generated if
recovery fails in first attempt, since the sys error handler is
invoked again for every failed recovery.
To avoid it, add conditional check to generate core dump only
once during every system error notification from firmware.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.c | 6 +++++-
 drivers/media/platform/qcom/venus/core.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index a712dd4..cc77900 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -67,6 +67,7 @@ static void venus_event_notify(struct venus_core *core, u32 event)
 
 	mutex_lock(&core->lock);
 	set_bit(0, &core->sys_error);
+	set_bit(0, &core->dump_core);
 	list_for_each_entry(inst, &core->instances, list)
 		inst->ops->event_notify(inst, EVT_SESSION_ERROR, NULL);
 	mutex_unlock(&core->lock);
@@ -109,7 +110,10 @@ static void venus_sys_error_handler(struct work_struct *work)
 
 	venus_shutdown(core);
 
-	venus_coredump(core);
+	if (test_bit(0, &core->dump_core)) {
+		venus_coredump(core);
+		clear_bit(0, &core->dump_core);
+	}
 
 	pm_runtime_put_sync(core->dev);
 
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 4a63326..c04ea62 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -233,6 +233,7 @@ struct venus_core {
 		u32 minor;
 		u32 rev;
 	} venus_ver;
+	unsigned long dump_core;
 };
 
 struct vdec_controls {
-- 
2.7.4


