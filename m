Return-Path: <linux-kernel+bounces-49278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29524846826
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5735B23AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E01775A;
	Fri,  2 Feb 2024 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BFI81TRL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55A17556;
	Fri,  2 Feb 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856056; cv=none; b=izGO5c6lS4Mrv3MAH5UaernchAhCt2oCjb3+95SQYHl8b4yyj8Jb6VcK6KvHRX6d3Mq2j7Pa5B9IHFq3VAo5gqwu9WZo6Cu4nF/YESRuk5pJKaX1nRkv+iyDw120jn6iXXlK+cDeHgm5kutBrb+T80YfoxVMKTTFp7Ti37mUUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856056; c=relaxed/simple;
	bh=VnjGikD3+8LM3EsshRS2+CpJ6NioY50g7djKTdknQjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efdyhnNpY04bh+YFJ+uX1F7Hnot+mtKSjurKVcTmGRmpj/mNuz7xmWIvAbxTP7Xkz9Id8elpZuQpn3nbd5byPW9ouCYJLQG70t/zcVnzIXMtjSWNHIMitjwSC310Q4oP9Bo3zoCeoqFZFFMpDHXy2uf7QSJ/D0y/vUruFAeTCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BFI81TRL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4123pr9b023855;
	Fri, 2 Feb 2024 06:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=5/ViGItAQDCuANO6a8Sh
	tZBeE3FMPpo+n5Za9x3lcSI=; b=BFI81TRL4PJ98Ji7E2uU3LzGX31g07QOVu2w
	13+nvmm2gt/y1r0NdDs7SH/mjFLNhB/7P5mksra7jk/7Q/4pPM85Hk1fHb1PLI9D
	IQy5LL4VORYpSW9X0IwpsQgc46acLnjzJ/IpRVT/Y9ySDMw6opC3YqyeS+XmSvof
	+UmhO8JGj3qPCqJhjr0I0WK1kdW+0VI83W9OZ1hmZl1gcprOW9h6LaQUFW1VIc8b
	v2WH7Fv5pNcHWIJvV44KArebWd04R4abLULJDlrZn8+J/YUiLuVcUeZPjsyKueuR
	D3tu4yJhnygmA0AilDqCQ6boSmLfP6hHQPm4mTfbnCI3ojge2A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwc0n2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:40:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126epZj004451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:40:51 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:40:49 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 01/16] misc: fastrpc: Redesign remote heap management
Date: Fri, 2 Feb 2024 12:10:24 +0530
Message-ID: <20240202064039.15505-2-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: tRpx9zjprpDtcfOvHuqzzc_C_ooDs4B1
X-Proofpoint-ORIG-GUID: tRpx9zjprpDtcfOvHuqzzc_C_ooDs4B1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Current remote heap design comes with problems where all types
of buffers are getting added to interrupted list and also user
unmap request is not handled properly. Add changes to maintain
list in a way that it can be properly managed and used at different
audio PD specific scenarios.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 180 +++++++++++++++++++++++++++++++----------
 1 file changed, 139 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1c6c62a7f7f5..f3ef5e194f11 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -196,6 +196,7 @@ struct fastrpc_buf {
 	struct dma_buf *dmabuf;
 	struct device *dev;
 	void *virt;
+	u32 flag;
 	u64 phys;
 	u64 size;
 	/* Lock for dma buf attachments */
@@ -273,11 +274,11 @@ struct fastrpc_channel_ctx {
 	struct kref refcount;
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
+	bool staticpd_status;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct fastrpc_buf *remote_heap;
-	struct list_head invoke_interrupted_mmaps;
+	struct list_head rmaps;
 	bool secure;
 	bool unsigned_support;
 	u64 dma_mask;
@@ -326,7 +327,7 @@ static void fastrpc_free_map(struct kref *ref)
 			err = qcom_scm_assign_mem(map->phys, map->size,
 				&src_perms, &perm, 1);
 			if (err) {
-				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
 						map->phys, map->size, err);
 				return;
 			}
@@ -817,7 +818,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		map->attr = attr;
 		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
 		if (err) {
-			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
 					map->phys, map->size, err);
 			goto map_err;
 		}
@@ -1139,7 +1140,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
-	struct fastrpc_buf *buf, *b;
 
 	int err = 0;
 
@@ -1200,13 +1200,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		fastrpc_context_put(ctx);
 	}
 
-	if (err == -ERESTARTSYS) {
-		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-			list_del(&buf->node);
-			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
-		}
-	}
-
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -1231,14 +1224,48 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 	return false;
 }
 
+static int fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
+{
+	struct fastrpc_buf *buf, *b;
+	int err = 0;
+
+	list_for_each_entry_safe(buf, b, &cctx->rmaps, node) {
+		if (cctx->vmcount) {
+			u64 src_perms = 0;
+			struct qcom_scm_vmperm dst_perms;
+			u32 i;
+
+			for (i = 0; i < cctx->vmcount; i++)
+				src_perms |= BIT(cctx->vmperms[i].vmid);
+
+			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+			dst_perms.perm = QCOM_SCM_PERM_RWX;
+			err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+				&src_perms, &dst_perms, 1);
+			if (err) {
+				pr_err("%s: Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+					__func__, buf->phys, buf->size, err);
+				return err;
+			}
+		}
+		list_del(&buf->node);
+		fastrpc_buf_free(buf);
+	}
+
+	return 0;
+}
+
 static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					      char __user *argp)
 {
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
+	struct fastrpc_buf *buf = NULL;
+	u64 phys = 0, size = 0;
 	char *name;
 	int err;
+	bool scm_done = false;
 	struct {
 		int pgid;
 		u32 namelen;
@@ -1271,24 +1298,29 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
-	if (!fl->cctx->remote_heap) {
-		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
-						&fl->cctx->remote_heap);
+	if (!fl->cctx->staticpd_status) {
+		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
 		if (err)
 			goto err_name;
 
+		phys = buf->phys;
+		size = buf->size;
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
-			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-							(u64)fl->cctx->remote_heap->size,
+			err = qcom_scm_assign_mem(phys, (u64)size,
 							&fl->cctx->perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
-				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
-					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
+					phys, size, err);
 				goto err_map;
 			}
+			scm_done = true;
 		}
+		fl->cctx->staticpd_status = true;
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->cctx->rmaps);
+		spin_unlock(&fl->lock);
 	}
 
 	inbuf.pgid = fl->tgid;
@@ -1304,8 +1336,8 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->phys;
-	pages[0].size = fl->cctx->remote_heap->size;
+	pages[0].addr = phys;
+	pages[0].size = size;
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1322,7 +1354,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount) {
+	if (fl->cctx->vmcount && scm_done) {
 		u64 src_perms = 0;
 		struct qcom_scm_vmperm dst_perms;
 		u32 i;
@@ -1332,15 +1364,18 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
 		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-						(u64)fl->cctx->remote_heap->size,
+		err = qcom_scm_assign_mem(phys, (u64)size,
 						&src_perms, &dst_perms, 1);
 		if (err)
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
-				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+				phys, size, err);
 	}
 err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
+	fl->cctx->staticpd_status = false;
+	spin_lock(&fl->lock);
+	list_del(&buf->node);
+	spin_unlock(&fl->lock);
+	fastrpc_buf_free(buf);
 err_name:
 	kfree(name);
 err:
@@ -1807,6 +1842,26 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
 				      &args[0]);
 	if (!err) {
+		if (buf->flag == ADSP_MMAP_REMOTE_HEAP_ADDR) {
+			if (fl->cctx->vmcount) {
+				u64 src_perms = 0;
+				struct qcom_scm_vmperm dst_perms;
+				u32 i;
+
+				for (i = 0; i < fl->cctx->vmcount; i++)
+					src_perms |= BIT(fl->cctx->vmperms[i].vmid);
+
+				dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+				dst_perms.perm = QCOM_SCM_PERM_RWX;
+				err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+								&src_perms, &dst_perms, 1);
+				if (err) {
+					dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+						buf->phys, buf->size, err);
+					return err;
+				}
+			}
+		}
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
 		spin_lock(&fl->lock);
 		list_del(&buf->node);
@@ -1823,7 +1878,12 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
+	struct fastrpc_munmap_req_msg req_msg;
+	struct fastrpc_map *map = NULL, *iterm, *m;
 	struct device *dev = fl->sctx->dev;
+	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
+	int err = 0;
+	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1837,13 +1897,52 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	}
 	spin_unlock(&fl->lock);
 
-	if (!buf) {
-		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
-			req.vaddrout, req.size);
+	if (buf) {
+		err = fastrpc_req_munmap_impl(fl, buf);
+		return err;
+	}
+
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iter, b, &fl->cctx->rmaps, node) {
+		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			buf = iter;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+	if (buf) {
+		err = fastrpc_req_munmap_impl(fl, buf);
+		return err;
+	}
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iterm, m, &fl->maps, node) {
+		if (iterm->raddr == req.vaddrout) {
+			map = iterm;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+	if (!map) {
+		dev_err(dev, "map not in list\n");
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	req_msg.pgid = fl->tgid;
+	req_msg.size = map->size;
+	req_msg.vaddr = map->raddr;
+
+	args[0].ptr = (u64) (uintptr_t) &req_msg;
+	args[0].length = sizeof(req_msg);
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
+				      &args[0]);
+	if (err)
+		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+	else
+		fastrpc_map_put(map);
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1909,6 +2008,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
 	buf->raddr = (uintptr_t) rsp_msg.vaddr;
+	buf->flag = req.flags;
 
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
@@ -1918,14 +2018,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
 			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
 					buf->phys, buf->size, err);
 			goto err_assign;
 		}
 	}
 
 	spin_lock(&fl->lock);
-	list_add_tail(&buf->node, &fl->mmaps);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		list_add_tail(&buf->node, &fl->cctx->rmaps);
+	else
+		list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
@@ -2332,7 +2435,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
+	INIT_LIST_HEAD(&data->rmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2370,13 +2473,14 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
+	cctx->staticpd_status = false;
+	fastrpc_mmap_remove_ssr(cctx);
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2387,12 +2491,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
-
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
-
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
-- 
2.17.0


