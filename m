Return-Path: <linux-kernel+bounces-46155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D84843B52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040EB1F25A75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DBE69940;
	Wed, 31 Jan 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bq1S3GYN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CB67A16;
	Wed, 31 Jan 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694186; cv=none; b=JbYzvTwLBSLmSXX9T4JrBs/eAc7CdbbZ5qHZgpzX6Dqv08JIeZPlH/Z7gx19A4NVxGjDjo4rua9OYDyqevZ/CS88Qf2E3ab/Ku9zNSdQQNQon4HgZ3PsoX3yqdXKGioDCze4XL49tomSbQLBMJ+Vxe16TxFnvQrRyYQ6cYrK4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694186; c=relaxed/simple;
	bh=+3j16HGIZAY4J4ZI60uEGjVzbBn8FpbNDoy1EDVdFHo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n5DwC1I0tYuUttP+oN1VPS++PEeDBqO+vAl0aaSyRMQttDr6b77wil4tAGZuO2C6YcP1Ts/tDVI5RTRAdkEluOeh7BxG6IcQrp4X4rG6KlBFFz0M9Mqv2RtKDqsKiQX/15+VrLMjjhwJyf/cyuXs/uQN4d7n3tIFG5SThJCiI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bq1S3GYN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V80efM016875;
	Wed, 31 Jan 2024 09:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=TN8sUvXkG9ta
	n3zwgK4OGu5R676NcyPOdYBP/KAfGds=; b=Bq1S3GYNNIHG9pXoyO22im1PE6mf
	JkqGXNMrMJ5cEyJhukntcsP78Zni8m0NMENIQl+VX5SLmBltHpVOe69PhxkYX4oM
	OTTywGkylxW66kbfrKXKDfXQXNcZU7UKg88BR9JASZwJGO/4fb5cE0e8BPQhZlNf
	xkxUXf3lUN4SVkSdvEjabRmKs0AsREH+boyjpQmNnItx3lbwB2VSRv92qLv0toCs
	1lEIRdiiwT5FJ2h2TAXZa4gUGPXQTEm00WUzxO9+i50TPz53ZjNt4XhheZF1Avg/
	pGOlw+ufkTO5jn6MWUFSyfLOF+pjSjBoYQn+OGnQkOohjJzx15yHQW4V6g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyjas084k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 09:43:00 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40V9guWa008461;
	Wed, 31 Jan 2024 09:42:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3vvtwmc41r-1;
	Wed, 31 Jan 2024 09:42:56 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40V9gu4s008455;
	Wed, 31 Jan 2024 09:42:56 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-audityab-hyd.qualcomm.com [10.147.244.159])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40V9guun008454;
	Wed, 31 Jan 2024 09:42:56 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 207879)
	id 876B35001C2; Wed, 31 Jan 2024 15:12:55 +0530 (+0530)
From: Auditya Bhattaram <quic_audityab@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Auditya Bhattaram <quic_audityab@quicinc.com>
Subject: [PATCH] soc: qcom: mdt_loader: Add Upperbounds check for program header access
Date: Wed, 31 Jan 2024 15:12:53 +0530
Message-Id: <20240131094253.20384-1-quic_audityab@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KjhyxFA81mRL8g4Csd0T608oga8KSAz5
X-Proofpoint-ORIG-GUID: KjhyxFA81mRL8g4Csd0T608oga8KSAz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310073
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
is found. Add an upperbound check to phdrs to access within elf size.

Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
---
 drivers/soc/qcom/mdt_loader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6f177e46fa0f..fee86317ad83 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -145,6 +145,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	if (phdrs[0].p_type == PT_LOAD)
 		return ERR_PTR(-EINVAL);

+	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size))
+		return ERR_PTR(-EINVAL);
+
 	for (i = 1; i < ehdr->e_phnum; i++) {
 		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
 			hash_segment = i;
--
2.17.1


