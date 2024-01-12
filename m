Return-Path: <linux-kernel+bounces-24463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72182BCE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EF9B254E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C05733D;
	Fri, 12 Jan 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oxlB8I7B"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431C57303;
	Fri, 12 Jan 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dfbb2522b12b11ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=plNlMh6L7Bhe6s5CZZaLhR2KjGh0ZZE3dRsgkTAADBM=;
	b=oxlB8I7BZ4OwAzUMrXvH9tPcFG+YgmS68xa6lPgBMy4gGn+YDwNYGsCayxTBWHd3LI896jUWPebQdD5ZVLindaIMeeOmyCk0sptSC4mSx8YQCxYhwaYjQjcg9LM3vLZJwRhKPDjGRwBB4bj1ZRiOEtTbSEjYeCw8rYq61vPyXYw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f2780ca3-df25-4758-a0d0-0ff3171e98f2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:a3532e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: dfbb2522b12b11ee9e680517dc993faa-20240112
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 700378187; Fri, 12 Jan 2024 17:20:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 17:20:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 17:20:45 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, <christian.koenig@amd.com>, Sumit Semwal
	<sumit.semwal@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
	<tjmercier@google.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>, Joakim Bech
	<joakim.bech@linaro.org>, Jeffrey Kardatzke <jkardatzke@google.com>, "Pavel
 Machek" <pavel@ucw.cz>, Simon Ser <contact@emersion.fr>, Pekka Paalanen
	<ppaalanen@gmail.com>, <jianjiao.zeng@mediatek.com>,
	<kuohong.wang@mediatek.com>, <youlin.pei@mediatek.com>
Subject: [PATCH v4 2/7] dma-buf: heaps: Initialize a restricted heap
Date: Fri, 12 Jan 2024 17:20:09 +0800
Message-ID: <20240112092014.23999-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112092014.23999-1-yong.wu@mediatek.com>
References: <20240112092014.23999-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.555600-8.000000
X-TMASE-MatchedRID: z8c0liBrbjrpHkfingCwBFz+axQLnAVB5Y0kb0hqatw1LB46LFAAkqSd
	3wubgak2t+ki9vYAWeawblw6HaK6mqNu8YiLlIJQDYh1Uz6zv6MuLZ3AqIxH3Fc/Cedjlcvk4PS
	yLdjnTmsKAm/Z86jMQ1b1Mjm+bRZC+niVaMBfU7MC9PSiNyNg6fNYQxCOihTNZ5yuplze9psxK5
	LonEEbrjxXJFV2fyjAccRjfACWEZm4c6uEFrThdkOZWaJBszmquoYFb0nRiqPYIRSS/nf+VaPFj
	JEFr+olwXCBO/GKkVr3FLeZXNZS4H0jHMQPhEvZ/eeo/eLXrNmgmLGCPVS10RF5GyxjDLjxdw0U
	TgINhQPKrXtDwo7Rzro8yJLdnKCjRRbc9yKXf38+Qp0hgi4Bk5/rxaJt3oPahJVRlkc0uv5GBXo
	eyrLHXVBo425nomviD2TeXwRpghw5Asr9kfiuVn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.555600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E0330AFC751236FF884905E6CC3C296B7EE5284951FED07A2D758633DA382B4B2000:8
X-MTK: N

Initialize a restricted heap. Currently just add a null heap, Prepare for
the later patches.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/dma-buf/heaps/Kconfig           |  9 ++++
 drivers/dma-buf/heaps/Makefile          |  3 +-
 drivers/dma-buf/heaps/restricted_heap.c | 67 +++++++++++++++++++++++++
 drivers/dma-buf/heaps/restricted_heap.h | 22 ++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma-buf/heaps/restricted_heap.c
 create mode 100644 drivers/dma-buf/heaps/restricted_heap.h

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index a5eef06c4226..e54506f480ea 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -12,3 +12,12 @@ config DMABUF_HEAPS_CMA
 	  Choose this option to enable dma-buf CMA heap. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
 	  regions, you should say Y here.
+
+config DMABUF_HEAPS_RESTRICTED
+	bool "DMA-BUF Restricted Heap"
+	depends on DMABUF_HEAPS
+	help
+	  Choose this option to enable dma-buf restricted heap. The purpose of this
+	  heap is to manage buffers that are inaccessible to the kernel and user space.
+	  There may be several ways to restrict it, for example it may be encrypted or
+	  protected by a TEE or hypervisor. If in doubt, say N.
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
index 974467791032..a2437c1817e2 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
 obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
+obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED)	+= restricted_heap.o
+obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/heaps/restricted_heap.c
new file mode 100644
index 000000000000..fd7c82abd42e
--- /dev/null
+++ b/drivers/dma-buf/heaps/restricted_heap.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF restricted heap exporter
+ *
+ * Copyright (C) 2024 MediaTek Inc.
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "restricted_heap.h"
+
+static struct dma_buf *
+restricted_heap_allocate(struct dma_heap *heap, unsigned long size,
+			 unsigned long fd_flags, unsigned long heap_flags)
+{
+	struct restricted_buffer *restricted_buf;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret;
+
+	restricted_buf = kzalloc(sizeof(*restricted_buf), GFP_KERNEL);
+	if (!restricted_buf)
+		return ERR_PTR(-ENOMEM);
+
+	restricted_buf->size = ALIGN(size, PAGE_SIZE);
+	restricted_buf->heap = heap;
+
+	exp_info.exp_name = dma_heap_get_name(heap);
+	exp_info.size = restricted_buf->size;
+	exp_info.flags = fd_flags;
+	exp_info.priv = restricted_buf;
+
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto err_free_buf;
+	}
+
+	return dmabuf;
+
+err_free_buf:
+	kfree(restricted_buf);
+	return ERR_PTR(ret);
+}
+
+static const struct dma_heap_ops restricted_heap_ops = {
+	.allocate = restricted_heap_allocate,
+};
+
+int restricted_heap_add(struct restricted_heap *rstrd_heap)
+{
+	struct dma_heap_export_info exp_info;
+	struct dma_heap *heap;
+
+	exp_info.name = rstrd_heap->name;
+	exp_info.ops = &restricted_heap_ops;
+	exp_info.priv = (void *)rstrd_heap;
+
+	heap = dma_heap_add(&exp_info);
+	if (IS_ERR(heap))
+		return PTR_ERR(heap);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(restricted_heap_add);
diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/heaps/restricted_heap.h
new file mode 100644
index 000000000000..443028f6ba3b
--- /dev/null
+++ b/drivers/dma-buf/heaps/restricted_heap.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Restricted heap Header.
+ *
+ * Copyright (C) 2024 MediaTek, Inc.
+ */
+
+#ifndef _DMABUF_RESTRICTED_HEAP_H_
+#define _DMABUF_RESTRICTED_HEAP_H_
+
+struct restricted_buffer {
+	struct dma_heap		*heap;
+	size_t			size;
+};
+
+struct restricted_heap {
+	const char		*name;
+};
+
+int restricted_heap_add(struct restricted_heap *rstrd_heap);
+
+#endif
-- 
2.25.1


