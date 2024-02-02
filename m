Return-Path: <linux-kernel+bounces-49285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D8F846836
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD51F22985
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2518E3F;
	Fri,  2 Feb 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nPYKcRPO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468618643;
	Fri,  2 Feb 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856071; cv=none; b=e7FjeLU8C0hZA69sKlrIw19vjMhn9EHL9NzpJ4Im98Z5ZYBL5zukW3ynAgQMLsZ6YXyZSsf+3ttrz1GcRjJgoXsuq3ezkPGE+Tq29/6w2zni7hiqWPG5S7KQw2YPquzNwx6PHpanFk9nJHxaCCjhhPDjSRAybLei+5i1gg69JKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856071; c=relaxed/simple;
	bh=O3ZlBs2M/gymncReU73N8tFP0+d/YXl/Z1mBNb1xC4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBdE678I5dAK7MtdCPK5T6OWVYtH/E+buB8eh6iK+kkGKZ+zUzowTmKwYvX33m0dG9AbrX5YfVKDSVdsCWQjJGKWqxiGT7yfvTHhYtepBcTeci2rQEdELGglA6+TPuT9jSuh9x13x7235NQ1eRLOA5l1wO66cqQ+Vn6sVED1Ne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nPYKcRPO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4123e9Ea013493;
	Fri, 2 Feb 2024 06:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=4Wwnw63uGnopclSZhO2/
	bG9bPOdkqKSvCNvqNY3G/TY=; b=nPYKcRPODkYCRwCvleI3BMQtGlh3TwARNOzL
	3D1d61P/FSGzScuUbu6DZC41/Xs2OoJdCvs6CEJxsfKR5MbKGDCUq96ZKmbIp/OT
	GtmObR9LVo7VKwXJwoA3cIsmpzCC51ERqJYCaPKY9ycd1S0RMGUSThYj8XqUTURn
	dqhVfvRwB/qmfpcyL+i76SHdkNkKRoeBif315huCKxQcRzUMsn8ahJtlIi5cgcSP
	Wz1eiDWn23+N9IHbseoWUxlu2OYibJwN3wmzyP0ZpQWoXrQC3dWc5WEjnxhbtkWT
	2HXrsMr9hDUN8F8q7T12N52/TManpjnKtf6keYA0KKBq6Xb6pw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu4gn9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126f6KC014282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:06 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:05 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 08/16] misc: fastrpc: Add support to allocate shared context bank
Date: Fri, 2 Feb 2024 12:10:31 +0530
Message-ID: <20240202064039.15505-9-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OIbYSNkpy2iFAfFdD-q9ESj2m-J2th9Z
X-Proofpoint-ORIG-GUID: OIbYSNkpy2iFAfFdD-q9ESj2m-J2th9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Context banks could be set as a shared one using a DT propery
"qcom,nsessions". The property takes the number of session to
be created of the context bank. This change provides a control
mechanism for user to use shared context banks for light weight
processes. The session is set as shared while its creation and if
a user requests for shared context bank, the same will be allocated
during process initialization.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 117 ++++++++++++++++++++++++------------
 include/uapi/misc/fastrpc.h |  21 +++++++
 2 files changed, 99 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 88f065e78bc2..9f67cfbc0222 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -312,6 +312,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool sharedcb;
 };
 
 struct fastrpc_static_pd {
@@ -371,6 +372,7 @@ struct fastrpc_user {
 	int pd;
 	bool is_secure_dev;
 	bool is_unsigned_pd;
+	bool sharedcb;
 	char *servloc_name;
 	/* Lock for lists */
 	spinlock_t lock;
@@ -879,6 +881,37 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 	.release = fastrpc_release,
 };
 
+static struct fastrpc_session_ctx *fastrpc_session_alloc(
+					struct fastrpc_channel_ctx *cctx, bool sharedcb)
+{
+	struct fastrpc_session_ctx *session = NULL;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	for (i = 0; i < cctx->sesscount; i++) {
+		if (!cctx->session[i].used && cctx->session[i].valid &&
+			cctx->session[i].sharedcb == sharedcb) {
+			cctx->session[i].used = true;
+			session = &cctx->session[i];
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	return session;
+}
+
+static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
+				 struct fastrpc_session_ctx *session)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	session->used = false;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+}
+
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
@@ -1545,6 +1578,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 			goto err_name;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx) {
+		err = -EBUSY;
+		goto err_name;
+	}
+
 	if (!fl->cctx->staticpd_status) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
 		if (err)
@@ -1674,6 +1713,12 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx) {
+		err = -EBUSY;
+		goto err;
+	}
+
 	inbuf.pgid = fl->tgid;
 	inbuf.namelen = strlen(current->comm) + 1;
 	inbuf.filelen = init.filelen;
@@ -1749,36 +1794,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	return err;
 }
 
-static struct fastrpc_session_ctx *fastrpc_session_alloc(
-					struct fastrpc_channel_ctx *cctx)
-{
-	struct fastrpc_session_ctx *session = NULL;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 0; i < cctx->sesscount; i++) {
-		if (!cctx->session[i].used && cctx->session[i].valid) {
-			cctx->session[i].used = true;
-			session = &cctx->session[i];
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&cctx->lock, flags);
-
-	return session;
-}
-
-static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
-				 struct fastrpc_session_ctx *session)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cctx->lock, flags);
-	session->used = false;
-	spin_unlock_irqrestore(&cctx->lock, flags);
-}
-
 static void fastrpc_context_list_free(struct fastrpc_user *fl)
 {
 	struct fastrpc_invoke_ctx *ctx, *n;
@@ -1882,15 +1897,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	fl->cctx = cctx;
 	fl->is_secure_dev = fdevice->secure;
 
-	fl->sctx = fastrpc_session_alloc(cctx);
-	if (!fl->sctx) {
-		dev_err(&cctx->rpdev->dev, "No session available\n");
-		mutex_destroy(&fl->mutex);
-		kfree(fl);
-
-		return -EBUSY;
-	}
-
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -1949,6 +1955,10 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = fl->tgid;
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
@@ -2001,11 +2011,33 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int fastrpc_internal_control(struct fastrpc_user *fl,
+					struct fastrpc_internal_control *cp)
+{
+	int err = 0;
+
+	if (!fl)
+		return -EBADF;
+	if (!cp)
+		return -EINVAL;
+
+	switch (cp->req) {
+	case FASTRPC_CONTROL_SMMU:
+		fl->sharedcb = cp->smmu.sharedcb;
+		break;
+	default:
+		err = -EBADRQC;
+		break;
+	}
+	return err;
+}
+
 static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_enhanced_invoke einv;
 	struct fastrpc_invoke_args *args = NULL;
 	struct fastrpc_ioctl_multimode_invoke invoke;
+	struct fastrpc_internal_control cp = {0};
 	u32 nscalars;
 	u64 *perf_kernel;
 	int err, i;
@@ -2049,6 +2081,12 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
 		break;
+	case FASTRPC_INVOKE_CONTROL:
+		if (copy_from_user(&cp, (void __user *)(uintptr_t)invoke.invparam, sizeof(cp)))
+			return  -EFAULT;
+
+		err = fastrpc_internal_control(fl, &cp);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
@@ -2738,6 +2776,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	if (sessions > 0) {
 		struct fastrpc_session_ctx *dup_sess;
 
+		sess->sharedcb = true;
 		for (i = 1; i < sessions; i++) {
 			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
 				break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 559a3aea85b9..d29188e43b21 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -166,6 +166,27 @@ struct fastrpc_ioctl_capability {
 	__u32 reserved[4];
 };
 
+enum fastrpc_control_type {
+	FASTRPC_CONTROL_LATENCY		=	1,
+	FASTRPC_CONTROL_SMMU		=	2,
+	FASTRPC_CONTROL_KALLOC		=	3,
+	FASTRPC_CONTROL_WAKELOCK	=	4,
+	FASTRPC_CONTROL_PM		=	5,
+	FASTRPC_CONTROL_DSPPROCESS_CLEAN	=	6,
+	FASTRPC_CONTROL_RPC_POLL	=	7,
+	FASTRPC_CONTROL_ASYNC_WAKE	=	8,
+	FASTRPC_CONTROL_NOTIF_WAKE	=	9,
+};
+
+struct fastrpc_ctrl_smmu {
+	u32 sharedcb;	/* Set to SMMU share context bank */
+};
+
+struct fastrpc_internal_control {
+	u32 req;
+	struct fastrpc_ctrl_smmu smmu;
+};
+
 enum fastrpc_perfkeys {
 	PERF_COUNT = 0,
 	PERF_FLUSH = 1,
-- 
2.17.0


