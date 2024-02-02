Return-Path: <linux-kernel+bounces-49283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A3846831
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D79C28936B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC91862F;
	Fri,  2 Feb 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d0cDRUzE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02821799F;
	Fri,  2 Feb 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856067; cv=none; b=QFqhW8qhIzvVxIt21oUlihO+KFIXy3YpDrpyOdpw1Zuw9KDiLe/pdcr9/+rTk/zRS5PUGAxtlJ+b3Dp9s5MdsmxXVmVTfSytwo7LtzraNeO2yuhyNx8boswzPqovfuRXkO36BHLUAMolf5YXz/O18tDgD/0wbESqWMJn8YeX2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856067; c=relaxed/simple;
	bh=e4GvRAWwK96yhzVq+gR2KS/40O1uNixKY6sanJMyQlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1vaRCYNj7tl+WOgcBj6TV7kfJDZPeWSgDhReLqFflGtGd9XgOH8XRKA5lgxNqgWOfQyTpu8vmIEufEdlj117vSMBzqgZC8SYMmVXRgyRRuK8SvYiLUmTQZC5Vh+Eu4faIbnmOSlgldtFw6zFQQCpzq9v9hNvXRhorZoFEGV+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d0cDRUzE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121XeLo016772;
	Fri, 2 Feb 2024 06:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=N3Dv48xtfmlwAEC+/v+R
	dWKgQQYo/NY0vTk4yRTUSvs=; b=d0cDRUzEK/BDA1IdDhvy+3q0NQyZ4tdS2fWk
	ElQ38jBVVOO5ey0r1J/+VxySuerSh2Ly0arc77AqSwvTYsrQccXqMY1taCWzPcXX
	NT+LIvgw5rGGAQM35TjMab8RCHo3m9jxuFvkL0L6VfieCyWgz3ip8b5ARuNeV0Kj
	6xLMDrAzAaQF+ysokBw5tPAF7w0MU2tEvxU6iiqTlAqXB23IvTs5PhxyahJv75Kt
	hfjs25dM+WFIn1VG0av3BJfcx41OgdGFgYXefWsV5ZBRB4JbGfbo9MuceewZTh5q
	gJ99jzuzglq3mQ37/TBdhJNmSN9g/8Qx4q3hG3tGavDZxdmCZw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu4gn9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126f2gF027303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:02 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:00 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 06/16] misc: fastrpc: Capture kernel and DSP performance counters
Date: Fri, 2 Feb 2024 12:10:29 +0530
Message-ID: <20240202064039.15505-7-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: kSfhfFZkRobm2K2ew-rKWKo_rm277FNK
X-Proofpoint-ORIG-GUID: kSfhfFZkRobm2K2ew-rKWKo_rm277FNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Add support to capture kernel performance counters for different
kernel level operations. These counters collects the information
for remote call and copies the information to a buffer shared
by user.

Collection of DSP performance counters is also added as part of
this change. DSP updates the performance information in the
metadata which is then copied to a buffer passed by the users.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 136 ++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |  14 ++++
 2 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a1b910459a90..33687d7f9a28 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -19,6 +19,7 @@
 #include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
@@ -35,6 +36,8 @@
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
 #define FASTRPC_MAX_CRCLIST	64
+#define FASTRPC_KERNEL_PERF_LIST (PERF_KEY_MAX)
+#define FASTRPC_DSP_PERF_LIST 12
 #define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
@@ -119,6 +122,27 @@
 #define SENSORS_PDR_SLPI_SERVICE_NAME            SENSORS_PDR_ADSP_SERVICE_NAME
 #define SLPI_SENSORPD_NAME                       "msm/slpi/sensor_pd"
 
+#define PERF_END ((void)0)
+
+#define PERF(enb, cnt, ff) \
+	{\
+		struct timespec64 startT = {0};\
+		uint64_t *counter = cnt;\
+		if (enb && counter) {\
+			ktime_get_real_ts64(&startT);\
+		} \
+		ff ;\
+		if (enb && counter) {\
+			*counter += getnstimediff(&startT);\
+		} \
+	}
+
+#define GET_COUNTER(perf_ptr, offset)  \
+	(perf_ptr != NULL ?\
+		(((offset >= 0) && (offset < PERF_KEY_MAX)) ?\
+			(uint64_t *)(perf_ptr + offset)\
+				: (uint64_t *)NULL) : (uint64_t *)NULL)
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -243,6 +267,19 @@ struct fastrpc_map {
 	struct kref refcount;
 };
 
+struct fastrpc_perf {
+	u64 count;
+	u64 flush;
+	u64 map;
+	u64 copy;
+	u64 link;
+	u64 getargs;
+	u64 putargs;
+	u64 invargs;
+	u64 invoke;
+	u64 tid;
+};
+
 struct fastrpc_invoke_ctx {
 	int nscalars;
 	int nbufs;
@@ -251,6 +288,8 @@ struct fastrpc_invoke_ctx {
 	int tgid;
 	u32 sc;
 	u32 *crc;
+	u64 *perf_kernel;
+	u64 *perf_dsp;
 	u64 ctxid;
 	u64 msg_sz;
 	struct kref refcount;
@@ -265,6 +304,7 @@ struct fastrpc_invoke_ctx {
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_buf_overlap *olaps;
 	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_perf *perf;
 };
 
 struct fastrpc_session_ctx {
@@ -325,6 +365,7 @@ struct fastrpc_user {
 	struct fastrpc_session_ctx *sctx;
 	struct fastrpc_buf *init_mem;
 
+	u32 profile;
 	int tgid;
 	int pd;
 	bool is_secure_dev;
@@ -336,6 +377,17 @@ struct fastrpc_user {
 	struct mutex mutex;
 };
 
+static inline int64_t getnstimediff(struct timespec64 *start)
+{
+	int64_t ns;
+	struct timespec64 ts, b;
+
+	ktime_get_real_ts64(&ts);
+	b = timespec64_sub(ts, *start);
+	ns = timespec64_to_ns(&b);
+	return ns;
+}
+
 static void fastrpc_free_map(struct kref *ref)
 {
 	struct fastrpc_map *map;
@@ -521,6 +573,9 @@ static void fastrpc_context_free(struct kref *ref)
 	if (ctx->buf)
 		fastrpc_buf_free(ctx->buf);
 
+	if (ctx->fl->profile)
+		kfree(ctx->perf);
+
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -640,6 +695,14 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	fastrpc_channel_ctx_get(cctx);
 
 	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
+	ctx->perf_dsp = (u64 *)(uintptr_t)invoke->perf_dsp;
+	ctx->perf_kernel = (u64 *)(uintptr_t)invoke->perf_kernel;
+	if (ctx->fl->profile) {
+		ctx->perf = kzalloc(sizeof(*(ctx->perf)), GFP_KERNEL);
+		if (!ctx->perf)
+			return ERR_PTR(-ENOMEM);
+		ctx->perf->tid = ctx->fl->tgid;
+	}
 	ctx->sc = sc;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
@@ -903,7 +966,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
-		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * FASTRPC_MAX_CRCLIST +
+		sizeof(u32) + sizeof(u64) * FASTRPC_DSP_PERF_LIST;
 
 	return size;
 }
@@ -970,16 +1034,22 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	int inbufs, i, oix, err = 0;
 	u64 len, rlen, pkt_size;
 	u64 pg_start, pg_end;
+	u64 *perf_counter = NULL;
 	uintptr_t args;
 	int metalen;
 
+	if (ctx->fl->profile)
+		perf_counter = (u64 *)ctx->perf + PERF_COUNT;
+
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	metalen = fastrpc_get_meta_size(ctx);
 	pkt_size = fastrpc_get_payload_size(ctx, metalen);
 
+	PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_MAP),
 	err = fastrpc_create_maps(ctx);
 	if (err)
 		return err;
+	PERF_END);
 
 	ctx->msg_sz = pkt_size;
 
@@ -1012,6 +1082,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		if (ctx->maps[i]) {
 			struct vm_area_struct *vma = NULL;
 
+			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_MAP),
 			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
 			pages[i].addr = ctx->maps[i]->phys;
 
@@ -1026,9 +1097,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pg_end = ((ctx->args[i].ptr + len - 1) & PAGE_MASK) >>
 				  PAGE_SHIFT;
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
-
+			PERF_END);
 		} else {
-
+			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_COPY),
 			if (ctx->olaps[oix].offset == 0) {
 				rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
 				args = ALIGN(args, FASTRPC_ALIGN);
@@ -1050,12 +1121,14 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
 			args = args + mlen;
 			rlen -= mlen;
+			PERF_END);
 		}
 
 		if (i < inbufs && !ctx->maps[i]) {
 			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
 
+			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_COPY),
 			if (!kernel) {
 				if (copy_from_user(dst, (void __user *)src,
 						   len)) {
@@ -1065,6 +1138,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			} else {
 				memcpy(dst, src, len);
 			}
+			PERF_END);
 		}
 	}
 
@@ -1095,9 +1169,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_map *mmap = NULL;
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
-	u64 *fdlist;
-	u32 *crclist;
-	int i, inbufs, outbufs, handles;
+	u64 *fdlist, *perf_dsp_list;
+	u32 *crclist, *poll;
+	int i, inbufs, outbufs, handles, perferr;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
@@ -1106,6 +1180,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
 	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
 	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
+	poll = (u32 *)(crclist + FASTRPC_MAX_CRCLIST);
+	perf_dsp_list = (u64 *)(poll + 1);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
@@ -1135,6 +1211,12 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 				FASTRPC_MAX_CRCLIST * sizeof(u32)))
 			return -EFAULT;
 	}
+	if (ctx->perf_dsp && perf_dsp_list) {
+		perferr = copy_to_user((void __user *)ctx->perf_dsp,
+				perf_dsp_list, FASTRPC_DSP_PERF_LIST * sizeof(u64));
+		if (perferr)
+			dev_info(fl->sctx->dev, "Warning: failed to copy perf data %d\n", perferr);
+	}
 	return 0;
 }
 
@@ -1170,13 +1252,32 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static void fastrpc_update_invoke_count(u32 handle, u64 *perf_counter,
+					struct timespec64 *invoket)
+{
+	u64 *invcount, *count;
+
+	invcount = GET_COUNTER(perf_counter, PERF_INVOKE);
+	if (invcount)
+		*invcount += getnstimediff(invoket);
+
+	count = GET_COUNTER(perf_counter, PERF_COUNT);
+	if (count)
+		*count += 1;
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_enhanced_invoke *invoke)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
 	struct fastrpc_invoke *inv = &invoke->inv;
 	u32 handle, sc;
-	int err = 0;
+	u64 *perf_counter = NULL;
+	int err = 0, perferr = 0;
+	struct timespec64 invoket = {0};
+
+	if (fl->profile)
+		ktime_get_real_ts64(&invoket);
 
 	if (!fl->sctx)
 		return -EINVAL;
@@ -1195,16 +1296,22 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (fl->profile)
+		perf_counter = (u64 *)ctx->perf + PERF_COUNT;
+	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_GETARGS),
 	err = fastrpc_get_args(kernel, ctx);
 	if (err)
 		goto bail;
+	PERF_END);
 
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
+	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_LINK),
 	/* Send invoke buffer to remote dsp */
 	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
 	if (err)
 		goto bail;
+	PERF_END);
 
 	if (kernel) {
 		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
@@ -1218,10 +1325,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
+	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_PUTARGS),
 	/* populate all the output buffers with results */
 	err = fastrpc_put_args(ctx, kernel);
 	if (err)
 		goto bail;
+	PERF_END);
 
 	/* Check the response from remote dsp */
 	err = ctx->retval;
@@ -1235,6 +1344,15 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		list_del(&ctx->node);
 		spin_unlock(&fl->lock);
 		fastrpc_context_put(ctx);
+	} else if (ctx) {
+		if (fl->profile && !err)
+			fastrpc_update_invoke_count(handle, perf_counter, &invoket);
+		if (fl->profile && ctx->perf && ctx->perf_kernel) {
+			perferr = copy_to_user((void __user *)ctx->perf_kernel,
+						ctx->perf, FASTRPC_KERNEL_PERF_LIST * sizeof(u64));
+			if (perferr)
+				dev_info(fl->sctx->dev, "Warning: failed to copy perf data %d\n", perferr);
+		}
 	}
 
 	if (err)
@@ -1828,6 +1946,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_invoke_args *args = NULL;
 	struct fastrpc_ioctl_multimode_invoke invoke;
 	u32 nscalars;
+	u64 *perf_kernel;
 	int err, i;
 
 	if (copy_from_user(&invoke, argp, sizeof(invoke)))
@@ -1862,6 +1981,9 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 				return -EFAULT;
 			}
 		}
+		perf_kernel = (u64 *)(uintptr_t)einv.perf_kernel;
+		if (perf_kernel)
+			fl->profile = true;
 		einv.inv.args = (u64)args;
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 45c15be1de58..559a3aea85b9 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -166,4 +166,18 @@ struct fastrpc_ioctl_capability {
 	__u32 reserved[4];
 };
 
+enum fastrpc_perfkeys {
+	PERF_COUNT = 0,
+	PERF_FLUSH = 1,
+	PERF_MAP = 2,
+	PERF_COPY = 3,
+	PERF_LINK = 4,
+	PERF_GETARGS = 5,
+	PERF_PUTARGS = 6,
+	PERF_INVARGS = 7,
+	PERF_INVOKE = 8,
+	PERF_TID = 9,
+	PERF_KEY_MAX = 10,
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.17.0


