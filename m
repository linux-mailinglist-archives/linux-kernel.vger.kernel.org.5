Return-Path: <linux-kernel+bounces-49286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321D846839
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AF6288F38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82C1AACC;
	Fri,  2 Feb 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pb8Pnu4t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406B18E20;
	Fri,  2 Feb 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856074; cv=none; b=MzVI7ytc+QwQi41xVb334psosejI9GYVbR5ZSam8Lpye94RTxjVdEQVM3hRqJljsbW5XcgZRV2/gdfAov2gNHc6NwIpoO5yz6MtnzIGqIud4warPl98Ld6Eiv8jUqwdqhZAC+0xWpdhCmh45thoSykrlIyrGjBih0dhjIu2ERVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856074; c=relaxed/simple;
	bh=4B9Ns6TsZjVKi9CwB+d9xAswYYoNPECimUxLdYg5rhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUxrELfcFWAO5+yNFmmU+wQ9vFHDI9nHM2Cqa+8p1mlDKchNKA9eYLTYFAWQDcspEtb6dLUE09QBAan1zNX75iX7RNW6cGurC2fbS2Ez0xmp9RjnDCf/H/DgT/MXVB67Ep+R7k7RsivSbqWP2mUGGQJfUYO+IZ+SUcFBoEhNGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pb8Pnu4t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124UfDn001619;
	Fri, 2 Feb 2024 06:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=3QpRhw1cE6x/zr+zQ2qt
	AXOixpxYsDMJLq6tAH40KCU=; b=Pb8Pnu4teQ2zYtCMI0X5SVBpAg2zDbZ1ovWW
	3nklIgfIlx+Tl16VLwk5EMLZ0yWRdK3kvO3gPGQjLYxvfInKAnKSE5rojJPaKTU6
	BXoDgBne4wH4i+bgAVoW1E9XGmTIYP7QU9yn32vl1k4KIL8e7MnoxfhRrs647eFN
	EEmZ7WPl3EHjk0jS6eTIodINSkbV3/oNmdPI/aHtKQjEDuCrLtv3nwwnEObuZveN
	hhH1V/tS+AK7Aci9ICxqUigHv4eepgdjQ3AXaUJ+Bp8aw/TGw8Rxo4HKOvl+9nBT
	RbodFJgVzwA1eWlsxrrY/VlCCrq/AQ7iFXYsemMwpOlM3BysCA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00n3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126f8Va014299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:09 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:07 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 09/16] misc: fastrpc: Add early wakeup support for fastRPC driver
Date: Fri, 2 Feb 2024 12:10:32 +0530
Message-ID: <20240202064039.15505-10-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: u8ybO9ggLff3-XsJDEJa0MmYoayDRL7m
X-Proofpoint-ORIG-GUID: u8ybO9ggLff3-XsJDEJa0MmYoayDRL7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

CPU wake up and context switch latency are significant in FastRPC
overhead for remote calls. As part of this change, DSP sends early
signal of completion to CPU and FastRPC driver detects early signal
on the given context and starts polling on a memory for actual
completion. Multiple different response flags are added to support
DSP user early hint of approximate time of completion, early response
from DSP user to wake up CPU and poll on memory for actual completion.
Complete signal is also added which is sent by DSP user in case of
timeout after early response is sent.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 267 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 254 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9f67cfbc0222..e4bb01bad7fb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -108,6 +108,19 @@
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
+#define FASTRPC_RSP_VERSION2 2
+/* Early wake up poll completion number received from remoteproc */
+#define FASTRPC_EARLY_WAKEUP_POLL (0xabbccdde)
+/* timeout in us for polling until memory barrier */
+#define FASTRPC_POLL_TIME_MEM_UPDATE (500)
+/* timeout in us for busy polling after early response from remoteproc */
+#define FASTRPC_POLL_TIME (4000)
+/* timeout in us for polling completion signal after user early hint */
+#define FASTRPC_USER_EARLY_HINT_TIMEOUT (500)
+/* CPU feature information to DSP */
+#define FASTRPC_CPUINFO_DEFAULT (0)
+#define FASTRPC_CPUINFO_EARLY_WAKEUP (1)
+
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 #define AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME   "audio_pdr_adsp"
@@ -143,6 +156,27 @@
 			(uint64_t *)(perf_ptr + offset)\
 				: (uint64_t *)NULL) : (uint64_t *)NULL)
 
+/* Response types supported for RPC calls
+ * Difference between response and signal terms used here -
+ * response carries return value where as signal is just a notification without return value
+ */
+enum fastrpc_response_flags {
+	/* normal job completion response */
+	NORMAL_RESPONSE = 0,
+	/* early response, cpu will poll on memory for actual completion */
+	EARLY_RESPONSE = 1,
+	/* user hint before completion with estimated completion time */
+	USER_EARLY_SIGNAL = 2,
+	/* extra completion clear signal to cpu when DSP updating poll
+	 * memory later than 2 ms after sending early response
+	 */
+	COMPLETE_SIGNAL = 3,
+	/* status notification response of DSP User PD */
+	STATUS_RESPONSE = 4,
+	/* process updates poll memory instead of glink response */
+	POLL_MODE = 5,
+};
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -220,6 +254,14 @@ struct fastrpc_invoke_rsp {
 	int retval;		/* invoke return value */
 };
 
+struct fastrpc_invoke_rspv2 {
+	u64 ctx;		/* invoke caller context */
+	int retval;		/* invoke return value */
+	u32 flags;		/* early response flags */
+	u32 early_wake_time;	/* user hint in us */
+	u32 version;		/* version number */
+};
+
 struct fastrpc_buf_overlap {
 	u64 start;
 	u64 end;
@@ -287,11 +329,17 @@ struct fastrpc_invoke_ctx {
 	int pid;
 	int tgid;
 	u32 sc;
+	/* user hint of completion time in us */
+	u32 early_wake_time;
 	u32 *crc;
 	u64 *perf_kernel;
 	u64 *perf_dsp;
 	u64 ctxid;
 	u64 msg_sz;
+	/* work done status flag */
+	bool is_work_done;
+	/* response flags from remote processor */
+	enum fastrpc_response_flags rsp_flags;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -347,7 +395,9 @@ struct fastrpc_channel_ctx {
 	struct list_head rmaps;
 	bool secure;
 	bool unsigned_support;
+	bool cpuinfo_status;
 	u64 dma_mask;
+	u64 cpuinfo_todsp;
 };
 
 struct fastrpc_device {
@@ -711,6 +761,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	ctx->pid = current->pid;
 	ctx->tgid = user->tgid;
 	ctx->cctx = cctx;
+	ctx->rsp_flags = NORMAL_RESPONSE;
+	ctx->is_work_done = false;
 	init_completion(&ctx->work);
 	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
 
@@ -1320,6 +1372,117 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx, u32 timeout)
+{
+	int err = -EIO, i, j;
+	u32 sc = ctx->sc;
+	struct fastrpc_invoke_buf *list;
+	struct fastrpc_phy_page *pages;
+	u64 *fdlist = NULL;
+	u32 *crclist = NULL, *poll = NULL;
+	unsigned int inbufs, outbufs, handles;
+
+	/* calculate poll memory location */
+	inbufs = REMOTE_SCALARS_INBUFS(sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(sc);
+	handles = REMOTE_SCALARS_INHANDLES(sc) + REMOTE_SCALARS_OUTHANDLES(sc);
+	list = fastrpc_invoke_buf_start(ctx->rpra, ctx->nscalars);
+	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
+	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
+	poll = (u32 *)(crclist + FASTRPC_MAX_CRCLIST);
+
+	/* poll on memory for DSP response. Return failure on timeout */
+	for (i = 0, j = 0; i < timeout; i++, j++) {
+		if (*poll == FASTRPC_EARLY_WAKEUP_POLL) {
+			/* Remote processor sent early response */
+			err = 0;
+			break;
+		}
+		if (j == FASTRPC_POLL_TIME_MEM_UPDATE) {
+			/* make sure that all poll memory writes by DSP are seen by CPU */
+			dma_rmb();
+			j = 0;
+		}
+		udelay(1);
+	}
+	return err;
+}
+
+static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
+						u32 kernel)
+{
+	int interrupted = 0;
+
+	if (kernel)
+		wait_for_completion(&ctx->work);
+	else
+		interrupted = wait_for_completion_interruptible(&ctx->work);
+
+	return interrupted;
+}
+
+static void fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
+			int *ptr_interrupted, u32 kernel)
+{
+	int err, i = 0;
+	bool wait_resp = false;
+	u32 wTimeout = FASTRPC_USER_EARLY_HINT_TIMEOUT;
+	u32 wakeTime = ctx->early_wake_time;
+
+	do {
+		switch (ctx->rsp_flags) {
+		/* Try polling on completion with timeout */
+		case USER_EARLY_SIGNAL:
+			/* Try wait if completion time is less than timeout
+			 * disable preempt to avoid context switch latency
+			 */
+			preempt_disable();
+			i = 0;
+			wait_resp = false;
+			for (; wakeTime < wTimeout && i < wTimeout; i++) {
+				wait_resp = try_wait_for_completion(&ctx->work);
+				if (wait_resp)
+					break;
+				udelay(1);
+			}
+			preempt_enable();
+			if (!wait_resp) {
+				*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
+				if (*ptr_interrupted || ctx->is_work_done)
+					return;
+			}
+			break;
+		/* Busy poll on memory for actual job done */
+		case EARLY_RESPONSE:
+			err = poll_for_remote_response(ctx, FASTRPC_POLL_TIME);
+			/* Mark job done if poll on memory successful or
+			 * wait for completion if poll on memory timeout
+			 */
+			if (!err) {
+				ctx->is_work_done = true;
+				return;
+			}
+			if (!ctx->is_work_done) {
+				*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
+				if (*ptr_interrupted || ctx->is_work_done)
+					return;
+			}
+			break;
+		case COMPLETE_SIGNAL:
+		case NORMAL_RESPONSE:
+			*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
+			if (*ptr_interrupted || ctx->is_work_done)
+				return;
+			break;
+		default:
+			*ptr_interrupted = -EBADR;
+			dev_err(ctx->fl->sctx->dev, "unsupported response type:0x%x\n", ctx->rsp_flags);
+			break;
+		}
+	} while (!ctx->is_work_done);
+}
+
 static void fastrpc_update_invoke_count(u32 handle, u64 *perf_counter,
 					struct timespec64 *invoket)
 {
@@ -1341,7 +1504,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	struct fastrpc_invoke *inv = &invoke->inv;
 	u32 handle, sc;
 	u64 *perf_counter = NULL;
-	int err = 0, perferr = 0;
+	int err = 0, perferr = 0, interrupted = 0;
 	struct timespec64 invoket = {0};
 
 	if (fl->profile)
@@ -1390,15 +1553,17 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	PERF_END);
 
 wait:
-	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
-			err = -ETIMEDOUT;
-	} else {
-		err = wait_for_completion_interruptible(&ctx->work);
+	fastrpc_wait_for_completion(ctx, &interrupted, kernel);
+	if (interrupted != 0) {
+		err = interrupted;
+		goto bail;
 	}
-
-	if (err)
+	if (!ctx->is_work_done) {
+		err = -ETIMEDOUT;
+		dev_err(fl->sctx->dev, "Error: Invalid workdone state for handle 0x%x, sc 0x%x\n",
+			handle, sc);
 		goto bail;
+	}
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
@@ -2162,6 +2327,36 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	return 0;
 }
 
+static int fastrpc_send_cpuinfo_to_dsp(struct fastrpc_user *fl)
+{
+	int err = 0;
+	u64 cpuinfo = 0;
+	struct fastrpc_invoke_args args[1];
+	struct fastrpc_enhanced_invoke ioctl;
+
+	if (!fl)
+		return -EBADF;
+
+	cpuinfo = fl->cctx->cpuinfo_todsp;
+	/* return success if already updated to remote processor */
+	if (fl->cctx->cpuinfo_status)
+		return 0;
+
+	args[0].ptr = (u64)(uintptr_t)&cpuinfo;
+	args[0].length = sizeof(cpuinfo);
+	args[0].fd = -1;
+
+	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(1, 1, 0);
+	ioctl.inv.args = (u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
+	if (!err)
+		fl->cctx->cpuinfo_status = true;
+
+	return err;
+}
+
 static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_ioctl_capability cap = {0};
@@ -2634,6 +2829,8 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
 		err = fastrpc_init_attach(fl, ROOT_PD);
+		if (!err)
+			fastrpc_send_cpuinfo_to_dsp(fl);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
@@ -2953,6 +3150,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
 		if (err)
 			goto fdev_error;
+		data->cpuinfo_todsp = FASTRPC_CPUINFO_DEFAULT;
 		break;
 	case CDSP_DOMAIN_ID:
 		data->unsigned_support = true;
@@ -2964,6 +3162,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
 		if (err)
 			goto fdev_error;
+		data->cpuinfo_todsp = FASTRPC_CPUINFO_EARLY_WAKEUP;
 		break;
 	default:
 		err = -EINVAL;
@@ -3051,31 +3250,73 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	fastrpc_channel_ctx_put(cctx);
 }
 
+static void fastrpc_notify_user_ctx(struct fastrpc_invoke_ctx *ctx, int retval,
+		u32 rsp_flags, u32 early_wake_time)
+{
+	ctx->retval = retval;
+	ctx->rsp_flags = (enum fastrpc_response_flags)rsp_flags;
+	switch (rsp_flags) {
+	case NORMAL_RESPONSE:
+	case COMPLETE_SIGNAL:
+		/* normal and complete response with return value */
+		ctx->is_work_done = true;
+		complete(&ctx->work);
+		break;
+	case USER_EARLY_SIGNAL:
+		/* user hint of approximate time of completion */
+		ctx->early_wake_time = early_wake_time;
+		break;
+	case EARLY_RESPONSE:
+		/* rpc framework early response with return value */
+		complete(&ctx->work);
+		break;
+	default:
+		break;
+	}
+}
+
 static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 				  int len, void *priv, u32 addr)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
 	struct fastrpc_invoke_rsp *rsp = data;
+	struct fastrpc_invoke_rspv2 *rspv2 = NULL;
 	struct fastrpc_invoke_ctx *ctx;
 	unsigned long flags;
 	unsigned long ctxid;
+	u32 rsp_flags = 0;
+	u32 early_wake_time = 0;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (len >= sizeof(*rspv2)) {
+		rspv2 = data;
+		if (rspv2) {
+			early_wake_time = rspv2->early_wake_time;
+			rsp_flags = rspv2->flags;
+		}
+	}
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (!ctx) {
-		dev_err(&rpdev->dev, "No context ID matches response\n");
-		return -ENOENT;
+		dev_info(&cctx->rpdev->dev, "Warning: No context ID matches response\n");
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		return 0;
 	}
 
-	ctx->retval = rsp->retval;
-	complete(&ctx->work);
+	if (rspv2) {
+		if (rspv2->version != FASTRPC_RSP_VERSION2) {
+			dev_err(&cctx->rpdev->dev, "Incorrect response version %d\n", rspv2->version);
+			spin_unlock_irqrestore(&cctx->lock, flags);
+			return -EINVAL;
+		}
+	}
+	fastrpc_notify_user_ctx(ctx, rsp->retval, rsp_flags, early_wake_time);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	/*
 	 * The DMA buffer associated with the context cannot be freed in
-- 
2.17.0


