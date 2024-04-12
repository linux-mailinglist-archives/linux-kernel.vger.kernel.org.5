Return-Path: <linux-kernel+bounces-142343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E38A2A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A741F21E26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E117555;
	Fri, 12 Apr 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X8ogcuG7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD451C34;
	Fri, 12 Apr 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912946; cv=none; b=ry46LiHMT/yUIMytf5sRofdGNdCZKOshXyLtFR4EtGf5gYsxPWkCNPrm+VlIH2T+py2l1a0mGKtfGS1MaB+0p0ZE54GS6GSQxVfoMyv+LjrVG2+DrG7v7BRD2iIgAx0oSCdEslSqw0B0Cf24NGycL3iTkiHcpF+wlP88xY+HPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912946; c=relaxed/simple;
	bh=9w2g6Gq7+Vgz14KR9HnQQihLeCCf4NtwnAbBqhhkmRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWv76oNB/kX7yjAmql41nrX91YONDOUzw+TYGgj+1AcYcns0/DCyc0DaXhQbvIrmhyhHQXk3N3rWIDojsfjGjSG8BlSGwgx/eNX3pSFDFbrSKZ78KnzZAsq4MT6af5N25HeOBKBpavly70Hu2wWCdpAude14yksQQwjl8D2VF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=X8ogcuG7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4cd68b70f8ac11ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iRfjJ9YWROks75IUMtZC2wrUKi1suXGk03fbJUFbyt0=;
	b=X8ogcuG7k02r9QcI+boGS1sbNC8ewFF0RrFKzzPr2nCC5i2KepA4kKvwnr7T6rvg0CAdEjx1zlse8WzO/fGpv657DatzWLxApyJlZ3XemvaHukvq6LzHnEmiFujdsvZdZIXScnELpD9HcvvN9y+Eb375eF67v/WNwxgfP8FEosU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:baeb2352-1877-40b8-82b5-923bd9aad8bc,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:d1af1986-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4cd68b70f8ac11ee935d6952f98a51a9-20240412
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2074265045; Fri, 12 Apr 2024 17:09:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 17:08:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 17:08:57 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Jeffrey Kardatzke <jkardatzke@google.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>, Nicolas
 Dufresne <nicolas.dufresne@collabora.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Sebastian Fricke
	<sebastian.fricke@collabora.com>, Tomasz Figa <tfiga@chromium.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>, Hsin-Yi
 Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, Daniel
 Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei Dong
	<yunfei.dong@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Brian
 Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J .
 Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5,03/23] v4l2: verify restricted dmabufs are used in restricted queue
Date: Fri, 12 Apr 2024 17:08:31 +0800
Message-ID: <20240412090851.24999-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412090851.24999-1-yunfei.dong@mediatek.com>
References: <20240412090851.24999-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Jeffrey Kardatzke <jkardatzke@google.com>

Verfies in the dmabuf implementations that if the restricted memory
flag is set for a queue that the dmabuf submitted to the queue is
unmappable.

Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 8 ++++++++
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 3d4fd4ef5310..f953570fef27 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -710,6 +710,14 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
 		return -EINVAL;
 	}
 
+	/* Verify the dmabuf is restricted if we are in restricted mode, this is done
+	 * by validating there is no page entry for the dmabuf.
+	 */
+	if (buf->vb->vb2_queue->restricted_mem && sg_page(sgt->sgl)) {
+		pr_err("restricted queue requires restricted dma_buf");
+		return -EINVAL;
+	}
+
 	/* checking if dmabuf is big enough to store contiguous chunk */
 	contig_size = vb2_dc_get_contiguous_size(sgt);
 	if (contig_size < buf->size) {
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 6975a71d740f..f87bd3f40b9b 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -570,6 +570,14 @@ static int vb2_dma_sg_map_dmabuf(void *mem_priv)
 		return -EINVAL;
 	}
 
+	/* Verify the dmabuf is restricted if we are in restricted mode, this is done
+	 * by validating there is no page entry for the dmabuf.
+	 */
+	if (buf->vb->vb2_queue->restricted_mem && !sg_page(sgt->sgl)) {
+		pr_err("restricted queue requires restricted dma_buf");
+		return -EINVAL;
+	}
+
 	buf->dma_sgt = sgt;
 	buf->vaddr = NULL;
 
-- 
2.18.0


