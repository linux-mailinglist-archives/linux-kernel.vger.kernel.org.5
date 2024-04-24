Return-Path: <linux-kernel+bounces-156458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072F8B02FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D73285853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BA158869;
	Wed, 24 Apr 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XJna2nkf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94D1586D2;
	Wed, 24 Apr 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943099; cv=none; b=mrqmtB8t+kwdppbhBwJYdkVw2u5cuNi/Ung2V/HJgRFIBrb/mlxH88Lei2t5C3j3wB8TIGeTeq7WHgPN/KiO9Nm/kZiqBTWB3nLJOwlIb9OKlGpD9gF8fAA+q5ofeH0Cae3A38d25Tm4l9d7VK67kIDYc/9ias3zqCO2nV0/Jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943099; c=relaxed/simple;
	bh=fv+GIGOvqiVeo78BkG+zPn+Of31/+ZsuY6byizPk83M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D0EbTIJpWzkK+UecZ/nB81tC1dLZukuykj7JWf3m/jI0YYnmVfZIzVzEiWmyLMStd6JIlag33Kb5J867bAc8N2a1+7zEpX4PJcS3nWJxqc0wocPtrw67IJ8Fk9fJb6s4t+rQ/rD60kQtoYrH+79KFEdPH3jr8lu/8O7FBmXY+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XJna2nkf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6YeiK026977;
	Wed, 24 Apr 2024 07:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=SIiiTzshdZnb
	bu1Kn6CE4UY2GKQW75/stSab/emf5JE=; b=XJna2nkfoXTIZgOdFk70qFdqXN3y
	BArphEIY96aRK9BDdQJxD5LhHX0zGXA9GJxV/wh4O7Vgae1QFtuHUz+A/GJD3LRD
	BkybJ2MkuPgnvT4cJCgDMzJBx8c3ABzgJ7b20aUSLrkn1JPJysVtJfFMTnqAhgfc
	d1+bkyaRXpQIaf6COKZPh4BZd8SPHGO2ZJBl6Sd/tzRMRROVJUNuO7hf/L57/IuU
	oxD/+KjJJdqz5DYFJrx6R+0ORKvcuy2a6L/+WH5a+aGUzOePiqLlrHRiQvlTTq6S
	flVZIAidFLR14msxNavzx7GJ4aX8qlj8TtvrbXEoCFEUMmI3PyaDtyQ3xg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e05nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 07:18:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O7I7AK006061;
	Wed, 24 Apr 2024 07:18:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xm6sm3w5m-1;
	Wed, 24 Apr 2024 07:18:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O7I7vw006055;
	Wed, 24 Apr 2024 07:18:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43O7I6k9006053;
	Wed, 24 Apr 2024 07:18:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 463843030; Wed, 24 Apr 2024 12:48:06 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] media: venus: fix use after free in vdec_close
Date: Wed, 24 Apr 2024 12:47:50 +0530
Message-Id: <1713943070-24085-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yzx1oSc-SW4RbTjoohJQ-sn1EZR-AmMi
X-Proofpoint-ORIG-GUID: Yzx1oSc-SW4RbTjoohJQ-sn1EZR-AmMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_04,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240031
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There appears to be a possible use after free with vdec_close().
The firmware will add buffer release work to the work queue through
HFI callbacks as a normal part of decoding. Randomly closing the
decoder device from userspace during normal decoding can incur
a read after free for inst.

Fix it by cancelling the work in vdec_close.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 29130a9..56f8a25 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1747,6 +1747,7 @@ static int vdec_close(struct file *file)
 
 	vdec_pm_get(inst);
 
+	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	vdec_ctrl_deinit(inst);
-- 
2.7.4


