Return-Path: <linux-kernel+bounces-42241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D354383FE76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5910B1F21529
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1C537ED;
	Mon, 29 Jan 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OMBdsH8L"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26064E1DC;
	Mon, 29 Jan 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509853; cv=none; b=plB9gsPskeTwUrLKZZ2ILqAlolRWcbjkHZH6Ljfnc8uOrfmctqJ9epOQwYd8KKcbgaQjJCLuH6pG6kRVpfC1RrEI3re+4Yj7cel+eIdKiG/XnDrF/5o/c+BadOwkb2Xj44tQy4vDMnN3dVA9bdgcjYyaNjYFS8eHpfQF5B5xFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509853; c=relaxed/simple;
	bh=YmGSlmvsC6y8Pg4I3syRhSxSRjKdGNAUmRqX5TOnbAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdM64N0JmEDP+XMDvIoqRClwNDY9qt3y5rNFv4DNT6zK8cg8CiCAc6f7cE0b/0nXnOyZ2nyuScf7prbfqaJE2BbULlul6XrlxXfZCNhhJke2+qP2RavCrx1xC2hOAI4CHfihlkAyH4ezH8Jj/bkUTwG+09VGvBnSlvmATVUHqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OMBdsH8L; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eed795d0be6f11eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VBRSF4YwZCz5T0Zk1nE7YVf8B1quLvMs45dUf37h/JQ=;
	b=OMBdsH8LvgJFk4uHD47/XD/hQyXmcP1yXYobnaQuM+gxqhjUKSE+f3yFO6tv7G273MKUX08ko7njJ+f7CxPwPLbCRgGpMAugaN3D5XfP82ckC7WSKxt89VyZLMRGgv4MbnCkjxjpC+eauFXMXWiiQLI9dqWevPRl+EecxYApd8M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:6d561463-008a-4c56-bc1b-29aa5dd3f193,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:d9b5c38e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eed795d0be6f11eea2298b7352fd921d-20240129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 812860472; Mon, 29 Jan 2024 14:30:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 14:30:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 14:30:42 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Jeffrey Kardatzke <jkardatzke@google.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC: Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>, Hsin-Yi
 Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, Daniel
 Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei Dong
	<yunfei.dong@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Brian
 Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J .
 Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,06/22] dma-heap: Add proper kref handling on dma-buf heaps
Date: Mon, 29 Jan 2024 14:30:09 +0800
Message-ID: <20240129063025.29251-7-yunfei.dong@mediatek.com>
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
X-MTK: N

From: John Stultz <jstultz@google.com>

Add proper refcounting on the dma_heap structure.
While existing heaps are built-in, we may eventually
have heaps loaded from modules, and we'll need to be
able to properly handle the references to the heaps

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[Yong: Just add comment for "minor" and "refcount"]
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/dma-buf/dma-heap.c | 29 +++++++++++++++++++++++++++++
 include/linux/dma-heap.h   |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 22f6c193db0d..97025ee8500f 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -11,6 +11,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <linux/err.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
@@ -30,6 +31,7 @@
  * @heap_devt:		heap device node
  * @list:		list head connecting to list of heaps
  * @heap_cdev:		heap char device
+ * @refcount:		reference counter for this heap device
  *
  * Represents a heap of memory from which buffers can be made.
  */
@@ -40,6 +42,7 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+	struct kref refcount;
 };
 
 static LIST_HEAD(heap_list);
@@ -240,6 +243,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	if (!heap)
 		return ERR_PTR(-ENOMEM);
 
+	kref_init(&heap->refcount);
 	heap->name = exp_info->name;
 	heap->ops = exp_info->ops;
 	heap->priv = exp_info->priv;
@@ -304,6 +308,31 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	return err_ret;
 }
 
+static void dma_heap_release(struct kref *ref)
+{
+	struct dma_heap *heap = container_of(ref, struct dma_heap, refcount);
+	unsigned int minor = MINOR(heap->heap_devt);
+
+	mutex_lock(&heap_list_lock);
+	list_del(&heap->list);
+	mutex_unlock(&heap_list_lock);
+
+	device_destroy(dma_heap_class, heap->heap_devt);
+	cdev_del(&heap->heap_cdev);
+	xa_erase(&dma_heap_minors, minor);
+
+	kfree(heap);
+}
+
+/**
+ * dma_heap_put - drops a reference to a dmabuf heap, potentially freeing it
+ * @heap: DMA-Heap whose reference count to decrement
+ */
+void dma_heap_put(struct dma_heap *heap)
+{
+	kref_put(&heap->refcount, dma_heap_release);
+}
+
 static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index fbe86ec889a8..d57593f8a1bc 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -46,4 +46,6 @@ const char *dma_heap_get_name(struct dma_heap *heap);
 
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
 
+void dma_heap_put(struct dma_heap *heap);
+
 #endif /* _DMA_HEAPS_H */
-- 
2.18.0


