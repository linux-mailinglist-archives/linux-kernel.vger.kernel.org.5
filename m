Return-Path: <linux-kernel+bounces-161692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1638B4FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6321F21E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552D8F55;
	Mon, 29 Apr 2024 03:10:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A88BE5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714360226; cv=none; b=QNd+6a/lNl05fIOaJGtOIIDVsmeLK+oEKKJFqY7iun+EbZm9ipjPkXcsriQwSZ5knZwP8QBXi2w6NxaBW3ZeaBUTvXxz9v4enPqUabMqvEZtZMXDfh/5pLQGebuEgGmqKSbQk29C15KxhxUol6dO72fLN8G+xhVwetHoCRgFRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714360226; c=relaxed/simple;
	bh=0xWnBySin3hvFWM+Gg+lPth7dwJaIqmVEkA7v93kco4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPI9tnIejoufqYOV53WALHqkH7YebLOCiBvr6PVwYcEyQWc8k4d64ZiBanVLza/BsJNW1fwzQ71PqldVAQsjvpKHotQgSNulK7zG+eswvTvnwa2KPzC0cKCTjVC7cZJrfeKPpSsi6dlvr/zKj40h7aju3p/ijrl+TELsR4qVPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 44d8254c05d511ef9305a59a3cc225df-20240429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e55886f0-59a4-4474-9cc4-478929e21d55,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.37,REQID:e55886f0-59a4-4474-9cc4-478929e21d55,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:6f543d0,CLOUDID:7313eae06029394b1295c53706b3a94b,BulkI
	D:240429110502VVCX1UY7,BulkQuantity:0,Recheck:0,SF:66|25|100|17|19|43|101|
	74|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-UUID: 44d8254c05d511ef9305a59a3cc225df-20240429
X-User: liweishi@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liweishi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 277750069; Mon, 29 Apr 2024 11:05:01 +0800
From: Weishi Li <liweishi@kylinos.cn>
To: liweishi@kylinos.cn
Cc: airlied@redhat.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	gurchetansingh@chromium.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	olvaffe@gmail.com,
	tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
Date: Mon, 29 Apr 2024 11:05:41 +0800
Message-Id: <20240429030541.56702-1-liweishi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402093922.268368-1-liweishi@kylinos.cn>
References: <20240402093922.268368-1-liweishi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both virtio_gpu_queue_ctrl_buffer and virtio_gpu_queue_cursor use
virtqueue_add_sgs to upload the structure virtio_gpu_vbuffer * vbuf
to virtqueue. However, when virtqueue_add_sgs returns -EIO or -ENOMEM,
it means vbuf upload failed, and vbuf will not be able to be
free by virtio_gpu_dequeue_*_func, resulting in a continuous increase
in memory allocated to vgdev ->vbufs.

Therefore, when upload fails，vbuf needs to be free directly.

Signed-off-by: Weishi Li <liweishi@kylinos.cn>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index b1a00c0c25a7..26f2e45635c1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -356,12 +356,14 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	WARN_ON(ret);
+	if (ret < 0 && ret != -ENOSPC) {
+		free_vbuf(vgdev, vbuf);
+	} else {
+		vbuf->seqno = ++vgdev->ctrlq.seqno;
+		trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
 
-	vbuf->seqno = ++vgdev->ctrlq.seqno;
-	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
-
-	atomic_inc(&vgdev->pending_commands);
-
+		atomic_inc(&vgdev->pending_commands);
+	}
 	spin_unlock(&vgdev->ctrlq.qlock);
 
 	drm_dev_exit(idx);
@@ -469,6 +471,8 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
+	else if (ret < 0) {
+		free_vbuf(vgdev, vbuf);
 	} else {
 		vbuf->seqno = ++vgdev->cursorq.seqno;
 		trace_virtio_gpu_cmd_queue(vq,
-- 
2.25.1


