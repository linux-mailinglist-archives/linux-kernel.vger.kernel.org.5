Return-Path: <linux-kernel+bounces-103240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6187BCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D579FB220CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2925A78A;
	Thu, 14 Mar 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oAd5lpuV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1F51C3B;
	Thu, 14 Mar 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419422; cv=none; b=iQscH1Fmqq67viaUtbwiYLFQ6iLa0jt2T9ak4jnjeg3OZPDwj2DfHPbOc/ag23LPeU1UM/OxR9BQg+p1jrIwpvurBcHREddiCDW9NGLIZjERI+IZt5irz3IfJMotPzgUijl1brmmwmrRrxwydjsjZGH4Cgh6w8RlMuorq+zgJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419422; c=relaxed/simple;
	bh=n8ezrz5jd7hNUPzPgsVZBIi28zC+AadwmySdaTgNUGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzMGzN7lZ2ALhjlyRxcezBjcA4Rjwh9Luz+zgjPcOujmZzw3F+mQBQIz0fcVkNVHgkQdUYiM5Vj5EorYBmJ5htM60cJvY1Cfoad8IL9uyU3OEY0VTUdv4k6qNtuQvp6Xfu0IN1auEem2g3w/2IWAPvHpx48Rl3r2Ncar6SHWpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oAd5lpuV; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9b3950fae1fe11eeb8927bc1f75efef4-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7sVPRU24+3K0BIlXmBK+0H+MuH8ajVpk1w0ATKvuubY=;
	b=oAd5lpuVcfNIc+JaWLMBZmRozzS7maBQ3uVXSLosnMUxRzBo2iK+u5bWGqB8hxGhNPvFrDuQqAO0REI2vZMeU6ny2r/+gSUm+Gs3bKLwnuIjs69zFoouWNJcd7sUqXVDyPrtcDzo1SJ+Rb+hQ5/RwNFOz+ZUV9fKoPzYTp9Rfrw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:56cbe2b4-c9f2-43ef-bdf7-8ed2d2823afd,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6f543d0,CLOUDID:9d52e5ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 9b3950fae1fe11eeb8927bc1f75efef4-20240314
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1780625510; Thu, 14 Mar 2024 20:30:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 20:30:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 20:30:11 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>, Irui Wang
	<irui.wang@mediatek.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, "Yunfei
 Dong" <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,1/2] media: mediatek: vcodec: adding lock to protect decoder context list
Date: Thu, 14 Mar 2024 20:30:08 +0800
Message-ID: <20240314123009.20205-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314123009.20205-1-yunfei.dong@mediatek.com>
References: <20240314123009.20205-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.355500-8.000000
X-TMASE-MatchedRID: uIXscqjWAPlQs1SN7/4/IMnlbo5l7mGFIaVkFIrQFhuCsBeCv8CM/QOH
	les/nBwn30jMKEtbXpdRvuieHBZsv5AbpTKt/Q8otOGPzYU8VIINmmuV06qWFslgi/vLS272hds
	WDb3rmc33wq3Amcn18gpmvwgMv6TJKgsbwct+M19jVtAwIy+afvjiOl7CtwVh31GU/N5W5BAiiF
	Ii+xQv728mJ6Jsq2mt5IJAD6OA/XPTLBkSptG5BBIRh9wkXSlFCt59Uh3p/NXjsTquy0JRiwVj/
	b97sBMuntyiDz2y+JOYOsnXI2BT/1xxDx5qbkR9FEUknJ/kEl6tIWznhjjBtfoLR4+zsDTtKNd/
	i50Eigz93/4flH1+CWvIkJyN2fOMixNA84MA+ns5A9DRE/8a/lZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.355500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	290735E1FE6CD8F36369DE9F616204A90BDF2F733ECCD5A1346E7B6D0078CCBC2000:8
X-MTK: N

Add a lock for the ctx_list, to avoid accessing a NULL pointer
within the 'vpu_dec_ipi_handler' fucntion when the ctx_list has
been deleted due to an unexpected behavior on the SCP IP block.

Hardware name: Google juniper sku16 board (DT)
pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
pc : vpu_dec_ipi_handler+0x58/0x1f8 [mtk_vcodec_dec]
lr : scp_ipi_handler+0xd0/0x194 [mtk_scp]
sp : ffffffc0131dbbd0
x29: ffffffc0131dbbd0 x28: 0000000000000000
x27: ffffff9bb277f348 x26: ffffff9bb242ad00
x25: ffffffd2d440d3b8 x24: ffffffd2a13ff1d4
x23: ffffff9bb7fe85a0 x22: ffffffc0133fbdb0
x21: 0000000000000010 x20: ffffff9b050ea328
x19: ffffffc0131dbc08 x18: 0000000000001000
x17: 0000000000000000 x16: ffffffd2d461c6e0
x15: 0000000000000242 x14: 000000000000018f
x13: 000000000000004d x12: 0000000000000000
x11: 0000000000000001 x10: fffffffffffffff0
x9 : ffffff9bb6e793a8 x8 : 0000000000000000
x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : fffffffffffffff0
x3 : 0000000000000020 x2 : ffffff9bb6e79080
x1 : 0000000000000010 x0 : ffffffc0131dbc08
Call trace:
vpu_dec_ipi_handler+0x58/0x1f8 [mtk_vcodec_dec (HASH:6c3f 2)]
scp_ipi_handler+0xd0/0x194 [mtk_scp (HASH:7046 3)]
mt8183_scp_irq_handler+0x44/0x88 [mtk_scp (HASH:7046 3)]
scp_irq_handler+0x48/0x90 [mtk_scp (HASH:7046 3)]
irq_thread_fn+0x38/0x94
irq_thread+0x100/0x1c0
kthread+0x140/0x1fc
ret_from_fork+0x10/0x30
Code: 54000088 f94ca50a eb14015f 54000060 (f9400108)
---[ end trace ace43ce36cbd5c93 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: 0x12c4000000 from 0xffffffc010000000
PHYS_OFFSET: 0xffffffe580000000
CPU features: 0x08240002,2188200c
Memory Limit: none

Fixes: 655b86e52eac ("media: mediatek: vcodec: Fix possible invalid memory access for decoder")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 4 ++--
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c    | 5 +++++
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h    | 2 ++
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index 9f6e4b59455d..9a11a2c24804 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
@@ -58,12 +58,12 @@ static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
 
-	mutex_lock(&dev->dev_mutex);
+	mutex_lock(&dev->dev_ctx_lock);
 	list_for_each_entry(ctx, &dev->ctx_list, list) {
 		ctx->state = MTK_STATE_ABORT;
 		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx->id);
 	}
-	mutex_unlock(&dev->dev_mutex);
+	mutex_unlock(&dev->dev_ctx_lock);
 }
 
 static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index f47c98faf068..2073781ccadb 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -268,7 +268,9 @@ static int fops_vcodec_open(struct file *file)
 
 	ctx->dev->vdec_pdata->init_vdec_params(ctx);
 
+	mutex_lock(&dev->dev_ctx_lock);
 	list_add(&ctx->list, &dev->ctx_list);
+	mutex_unlock(&dev->dev_ctx_lock);
 	mtk_vcodec_dbgfs_create(ctx);
 
 	mutex_unlock(&dev->dev_mutex);
@@ -311,7 +313,9 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
 	mtk_vcodec_dbgfs_remove(dev, ctx->id);
+	mutex_lock(&dev->dev_ctx_lock);
 	list_del_init(&ctx->list);
+	mutex_unlock(&dev->dev_ctx_lock);
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
 	return 0;
@@ -404,6 +408,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	for (i = 0; i < MTK_VDEC_HW_MAX; i++)
 		mutex_init(&dev->dec_mutex[i]);
 	mutex_init(&dev->dev_mutex);
+	mutex_init(&dev->dev_ctx_lock);
 	spin_lock_init(&dev->irqlock);
 
 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index 849b89dd205c..85b2c0d3d8bc 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -241,6 +241,7 @@ struct mtk_vcodec_dec_ctx {
  *
  * @dec_mutex: decoder hardware lock
  * @dev_mutex: video_device lock
+ * @dev_ctx_lock: the lock of context list
  * @decode_workqueue: decode work queue
  *
  * @irqlock: protect data access by irq handler and work thread
@@ -282,6 +283,7 @@ struct mtk_vcodec_dec_dev {
 	/* decoder hardware mutex lock */
 	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
 	struct mutex dev_mutex;
+	struct mutex dev_ctx_lock;
 	struct workqueue_struct *decode_workqueue;
 
 	spinlock_t irqlock;
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
index 82e57ae983d5..da6be556727b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
@@ -77,12 +77,14 @@ static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec_dev *dec_dev, struct vde
 	struct mtk_vcodec_dec_ctx *ctx;
 	int ret = false;
 
+	mutex_lock(&dec_dev->dev_ctx_lock);
 	list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
 		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
 			ret = true;
 			break;
 		}
 	}
+	mutex_unlock(&dec_dev->dev_ctx_lock);
 
 	return ret;
 }
-- 
2.18.0


