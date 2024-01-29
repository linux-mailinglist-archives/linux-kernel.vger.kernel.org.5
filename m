Return-Path: <linux-kernel+bounces-42240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97C83FE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139FA284926
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4201524BE;
	Mon, 29 Jan 2024 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LD+6dD3I"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1274D599;
	Mon, 29 Jan 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509852; cv=none; b=lHPcB3KFF0z+kbYOMENpEtVXR4TGdzGOQoE5CUzV5fFZOwup5ELNi4jmkw1n7Ycc8vmOSPs+cUolMF1k7nOXPCJ9PK7kkmYlBgKApLOJxUI6susy1pOhuZWgXZICtNIHbyyyr4/9rS1xsMqBnA9101jfi67paHHQFjJlOtP83fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509852; c=relaxed/simple;
	bh=B2BbMbPzqwowimew9zJAjA/tTXytJajNYxTUH+gmpT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfuvlJewh0u9M/dvA6MGPU+M0tBNFhL6vzQhGbYTg8gV+xv6Bkze+Au8jEzL8bn1QoO9dd3MbVsZ+YW5JlOZAJ5/O7B5nMGY2+yce/EfGN/MSQ5PSD3fYp1WVLMtiVz0VHxkCMdnOzLkN5Ecgvz6J5UZmLCCTDUeD1oB5CFgrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LD+6dD3I; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb6c3b58be6f11ee9e680517dc993faa-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BD29QZW6/FDb7FZtrvhAxAS5CCjAP62wNXiOAvvLw5I=;
	b=LD+6dD3I0dp1/S9SwTmkafuXqR2ff5p7CQUJ6PKzk/a9+FxrEE4+bwIyvTwmPrY3J6xSMCNS75yEskCAP0ZjgnEysYvrze/7n5c4d4YvOlPmnnJsaz+4j3p8RBKTxjr4GKjN4MPUpVxMvNlyHmdLSa4rM3oCVnjdbNmX7gz1MwM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:e00845e5-6348-4a93-b871-3692684fce89,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:a6a85c83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb6c3b58be6f11ee9e680517dc993faa-20240129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 521927469; Mon, 29 Jan 2024 14:30:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 14:30:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 14:30:37 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Jeffrey Kardatzke <jkardatzke@google.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC: Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>,
	"Hsin-Yi Wang" <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	"Daniel Vetter" <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	"Brian Starkey" <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T
 . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,02/22] v4l2: handle restricted memory flags in queue setup
Date: Mon, 29 Jan 2024 14:30:05 +0800
Message-ID: <20240129063025.29251-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129063025.29251-1-yunfei.dong@mediatek.com>
References: <20240129063025.29251-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.647000-8.000000
X-TMASE-MatchedRID: D0Pm2dEMlxOWHmpvkeKJB57tR0mnRAg1TJDl9FKHbrk1LB46LFAAkq/H
	ZLCMsEf9UVB7I/2CDSABbn1cvMDZHaEAqPOtlpvtjtK7dC6UBnnbKTxp3+WtIMj0QMA/92m24ft
	l+EKh+CByQYB2WJEWjc4upQc4xGVCue4A1S8vO3qUa50su1E7W7l8khgtUner0rKJ/e4C60yEIt
	GBZvH9STFmRUjzEp4LgDLqnrRlXrZ8nn9tnqel2LI7zVffJqTzY1SQaZlBkE5q9KgCqgNquvdVF
	r8ODUj71JdaDtUEfQfhx+G8+x+UoX7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.647000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DF0AFB3E5D025F6365231BC54E73BDE096F68A18030DC6CC188FCD1EB7D572242000:8
X-MTK: N

From: Jeffrey Kardatzke <jkardatzke@google.com>

Validates the restricted memory flags when setting up a queue and
ensures the queue has the proper capability.

Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 21 +++++++++++++++++++
 .../media/common/videobuf2/videobuf2-v4l2.c   |  4 +++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 41a832dd1426..7f5fd9ec9117 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -813,6 +813,15 @@ static bool verify_coherency_flags(struct vb2_queue *q, bool non_coherent_mem)
 	return true;
 }
 
+static bool verify_restricted_mem_flags(struct vb2_queue *q, bool restricted_mem)
+{
+	if (restricted_mem != q->restricted_mem) {
+		dprintk(q, 1, "restricted memory model mismatch\n");
+		return false;
+	}
+	return true;
+}
+
 int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		     unsigned int flags, unsigned int *count)
 {
@@ -820,6 +829,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
+	bool restricted_mem = flags & V4L2_MEMORY_FLAG_RESTRICTED;
 	unsigned int i;
 	int ret = 0;
 
@@ -862,6 +872,9 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 			return 0;
 	}
 
+	if (restricted_mem && (!q->allow_restricted_mem || memory != V4L2_MEMORY_DMABUF))
+		return -EINVAL;
+
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
@@ -882,6 +895,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	if (ret)
 		return ret;
 	set_queue_coherency(q, non_coherent_mem);
+	q->restricted_mem = restricted_mem;
 
 	/*
 	 * Ask the driver how many buffers and planes per buffer it requires.
@@ -986,6 +1000,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
+	bool restricted_mem = flags & V4L2_MEMORY_FLAG_RESTRICTED;
 	bool no_previous_buffers = !q_num_bufs;
 	int ret = 0;
 
@@ -994,6 +1009,9 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		return -ENOBUFS;
 	}
 
+	if (restricted_mem && (!q->allow_restricted_mem || memory != V4L2_MEMORY_DMABUF))
+		return -EINVAL;
+
 	if (no_previous_buffers) {
 		if (q->waiting_in_dqbuf && *count) {
 			dprintk(q, 1, "another dup()ped fd is waiting for a buffer\n");
@@ -1015,6 +1033,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			return ret;
 		q->waiting_for_buffers = !q->is_output;
 		set_queue_coherency(q, non_coherent_mem);
+		q->restricted_mem = restricted_mem;
 	} else {
 		if (q->memory != memory) {
 			dprintk(q, 1, "memory model mismatch\n");
@@ -1022,6 +1041,8 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		}
 		if (!verify_coherency_flags(q, non_coherent_mem))
 			return -EINVAL;
+		if (!verify_restricted_mem_flags(q, restricted_mem))
+			return -EINVAL;
 	}
 
 	num_buffers = min(*count, q->max_num_buffers - q_num_bufs);
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 54d572c3b515..e825b1e2e22f 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -686,6 +686,8 @@ static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS;
 	if (q->supports_requests)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_REQUESTS;
+	if (q->allow_restricted_mem && q->io_modes & VB2_DMABUF)
+		*caps |= V4L2_BUF_CAP_SUPPORTS_RESTRICTED_MEM;
 }
 
 static void validate_memory_flags(struct vb2_queue *q,
@@ -700,7 +702,7 @@ static void validate_memory_flags(struct vb2_queue *q,
 		*flags = 0;
 	} else {
 		/* Clear all unknown flags. */
-		*flags &= V4L2_MEMORY_FLAG_NON_COHERENT;
+		*flags &= V4L2_MEMORY_FLAG_NON_COHERENT | V4L2_MEMORY_FLAG_RESTRICTED;
 	}
 }
 
-- 
2.18.0


