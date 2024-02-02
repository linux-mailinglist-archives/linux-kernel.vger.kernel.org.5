Return-Path: <linux-kernel+bounces-49287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2A84683B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF92289903
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD862555F;
	Fri,  2 Feb 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F9KS1R1l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C833199D9;
	Fri,  2 Feb 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856075; cv=none; b=VBAg2+Lnd3pJVXQQWvaExw9QyftM96HmXuZ+B5pOethrCy9r78I3q5apIuldGGsYA8TWly37usFCKyx0Emjs0sPEfFutQYChooIE7y7sZZhF9kZTwI0nunOf981287HIYCbmsbpOyq24gByOeJrtAV2I9ux1YiDH69chs9JaUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856075; c=relaxed/simple;
	bh=2Ehjwo/Vd5r9E7HGbSQo9oSfejaHbQjOK+/5kozcDWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXyrAp7F1RGt8KIyev5qyN30urSQ7UJQ/DETRddOw6lzDbwdewTaDrIZs+ZsyLuHsvV4QBVs7s0clDM4qSsWuwpbfWIE/3zOKxI5TsXQAvnxuVgQG7ctknJaRdKzr6qw2U0I/TEiivmX3qJvVfsmY7IRh8zygMuNa4S3l0jx/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F9KS1R1l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4122EMM2004186;
	Fri, 2 Feb 2024 06:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=RDPZHWX7iZQRiYXsY0lU
	h79KcCxlXrs4AtNhueuf94E=; b=F9KS1R1l9UxcXDXBvGKbilTgEvVxZQOZUaKh
	lvuI3nWNwrJj4XQ91vUpefC+y6vOXF+xadMl5qFltq8QtEGmnO16fuZDe8Ab10KG
	H1ZZA6IxozJb3/txb6r/k43Ipfc1hkdeN+NncDFdWem+ndj0W31U5zOlSPnu/HRF
	D4w71p+STmgtLr3x4QhDzNI49TKgGrSn00FyqKuLYTvqWc/lNY37MH+SGlW950Ni
	MMgbv/Uoehksa2YTu9MLszRhDsyyVt9bPQpSMv3zvWeGhJ+gL8O2oX/CG7Xbie3Y
	pofOmgjNSvIzcnI4MMxjaWJY0mmZPScyvFjQhjnrTDhzRLSiOQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptw8ndb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fBoV004683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:11 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:09 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 10/16] misc: fastrpc: Add polling mode support for fastRPC driver
Date: Fri, 2 Feb 2024 12:10:33 +0530
Message-ID: <20240202064039.15505-11-quic_ekangupt@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4ZWYRrCMAxlqkSM-X-xIVyf6altgtwF3
X-Proofpoint-GUID: 4ZWYRrCMAxlqkSM-X-xIVyf6altgtwF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=857 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

For any remote call to DSP, after sending an invocation message,
fastRPC driver waits for glink response and during this time the
CPU can go into low power modes. Adding a polling mode support
with which fastRPC driver will poll continuously on a memory
after sending a message to remote subsystem which will eliminate
CPU wakeup and scheduling latencies and reduce fastRPC overhead.
With this change, DSP always sends a glink response which will
get ignored if polling mode didn't time out.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 50 +++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h | 10 +++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e4bb01bad7fb..296ddae0ef7c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -111,6 +111,8 @@
 #define FASTRPC_RSP_VERSION2 2
 /* Early wake up poll completion number received from remoteproc */
 #define FASTRPC_EARLY_WAKEUP_POLL (0xabbccdde)
+/* Poll response number from remote processor for call completion */
+#define FASTRPC_POLL_RESPONSE (0xdecaf)
 /* timeout in us for polling until memory barrier */
 #define FASTRPC_POLL_TIME_MEM_UPDATE (500)
 /* timeout in us for busy polling after early response from remoteproc */
@@ -418,11 +420,15 @@ struct fastrpc_user {
 	struct fastrpc_buf *init_mem;
 
 	u32 profile;
+	/* Threads poll for specified timeout and fall back to glink wait */
+	u32 poll_timeout;
 	int tgid;
 	int pd;
 	bool is_secure_dev;
 	bool is_unsigned_pd;
 	bool sharedcb;
+	/* If set, threads will poll for DSP response instead of glink wait */
+	bool poll_mode;
 	char *servloc_name;
 	/* Lock for lists */
 	spinlock_t lock;
@@ -1398,6 +1404,11 @@ static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx, u32 timeout)
 			/* Remote processor sent early response */
 			err = 0;
 			break;
+		} else if (*poll == FASTRPC_POLL_RESPONSE) {
+			err = 0;
+			ctx->is_work_done = true;
+			ctx->retval = 0;
+			break;
 		}
 		if (j == FASTRPC_POLL_TIME_MEM_UPDATE) {
 			/* make sure that all poll memory writes by DSP are seen by CPU */
@@ -1475,6 +1486,15 @@ static void fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
 			if (*ptr_interrupted || ctx->is_work_done)
 				return;
 			break;
+		case POLL_MODE:
+			err = poll_for_remote_response(ctx, ctx->fl->poll_timeout);
+
+			/* If polling timed out, move to normal response state */
+			if (err)
+				ctx->rsp_flags = NORMAL_RESPONSE;
+			else
+				*ptr_interrupted = 0;
+			break;
 		default:
 			*ptr_interrupted = -EBADR;
 			dev_err(ctx->fl->sctx->dev, "unsupported response type:0x%x\n", ctx->rsp_flags);
@@ -2176,6 +2196,33 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int fastrpc_manage_poll_mode(struct fastrpc_user *fl, u32 enable, u32 timeout)
+{
+	const unsigned int MAX_POLL_TIMEOUT_US = 10000;
+
+	if ((fl->cctx->domain_id != CDSP_DOMAIN_ID) || (fl->pd != USER_PD)) {
+		dev_err(&fl->cctx->rpdev->dev, "poll mode only allowed for dynamic CDSP process\n");
+		return -EPERM;
+	}
+	if (timeout > MAX_POLL_TIMEOUT_US) {
+		dev_err(&fl->cctx->rpdev->dev, "poll timeout %u is greater than max allowed value %u\n",
+			timeout, MAX_POLL_TIMEOUT_US);
+		return -EBADMSG;
+	}
+	spin_lock(&fl->lock);
+	if (enable) {
+		fl->poll_mode = true;
+		fl->poll_timeout = timeout;
+	} else {
+		fl->poll_mode = false;
+		fl->poll_timeout = 0;
+	}
+	spin_unlock(&fl->lock);
+	dev_info(&fl->cctx->rpdev->dev, "updated poll mode to %d, timeout %u\n", enable, timeout);
+
+	return 0;
+}
+
 static int fastrpc_internal_control(struct fastrpc_user *fl,
 					struct fastrpc_internal_control *cp)
 {
@@ -2190,6 +2237,9 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	case FASTRPC_CONTROL_SMMU:
 		fl->sharedcb = cp->smmu.sharedcb;
 		break;
+	case FASTRPC_CONTROL_RPC_POLL:
+		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
+		break;
 	default:
 		err = -EBADRQC;
 		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index d29188e43b21..b4959cc4d254 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -182,9 +182,17 @@ struct fastrpc_ctrl_smmu {
 	u32 sharedcb;	/* Set to SMMU share context bank */
 };
 
+struct fastrpc_ctrl_latency {
+	u32 enable;	/* latency control enable */
+	u32 latency;	/* latency request in us */
+};
+
 struct fastrpc_internal_control {
 	u32 req;
-	struct fastrpc_ctrl_smmu smmu;
+	union {
+		struct fastrpc_ctrl_smmu smmu;
+		struct fastrpc_ctrl_latency lp;
+	};
 };
 
 enum fastrpc_perfkeys {
-- 
2.17.0


