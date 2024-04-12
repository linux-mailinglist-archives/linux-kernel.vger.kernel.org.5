Return-Path: <linux-kernel+bounces-142359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D776E8A2AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB82FB292B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF15D744;
	Fri, 12 Apr 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rsDFcyrQ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9A5C8ED;
	Fri, 12 Apr 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912971; cv=none; b=ly/n8d1PXzxa1jYkwqi1E3KvF5WSwZGTrLL9w9hutv3KyFYICgn4wQP4v8UoryTTDEFHFXcIuCVHJMa6eMzPByYhRB1yJWSBBlZ93VF6Ce1vazzQ5gM1aYiIJpA/0TLLFiTAz150CB4MGNPAjW6VR7lxslwh26peWjEmPtWa4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912971; c=relaxed/simple;
	bh=De7h2bmqjwlvF4WDu4mS6ssgNcHJ0c9/6Ro5G9+C5vE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7zniK4IPNlPmyDOXGhKOurDw2yTkUpf8lcIXDWcnRLp814ZBQYooXkAPyV7wQaWXqRnuY56UrHZmy2SIhO7sal3Md1BJC5gQt3I3+jrhGCYZSZLi6fAqQ7f2UcK+MxkmitSnEkXn7H7cviQTeM4lnjKmP+feHNYxpqdwKP+mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rsDFcyrQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5b49048af8ac11ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kzPuzCQcsrUYAN8nluW8l/GNGj5bqFdRzQmp5l3O/gI=;
	b=rsDFcyrQAZlIlHuRkXRSHceWCAy4AvzMHqurVIzo4aprjMxCdtjQmVweO461j32fcD7uyLwQnkif35y6PXQbMkd3jGCdI1Nlq4A/Kq8IVwHG+1RPJCyGPjaJF/11yHe2yWc9yiSnLzEmtaiL1b7E57+swAMQdVzlLtc9n+l87KE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:12266c33-3690-4889-8865-2aa0681ddbb1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:06b11986-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5b49048af8ac11ee935d6952f98a51a9-20240412
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 244992589; Fri, 12 Apr 2024 17:09:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 17:09:23 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 17:09:21 +0800
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
Subject: [PATCH v5,19/23] media: mediatek: vcodec: disable wait interrupt for svp mode
Date: Fri, 12 Apr 2024 17:08:47 +0800
Message-ID: <20240412090851.24999-20-yunfei.dong@mediatek.com>
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

Waiting interrupt in optee-os for svp mode, need to disable it in kernel
in case of interrupt is cleaned.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_hw.c        | 34 +++++------
 .../vcodec/decoder/mtk_vcodec_dec_pm.c        |  6 +-
 .../decoder/vdec/vdec_h264_req_multi_if.c     | 57 +++++++++++--------
 3 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
index 881d5de41e05..1982c088c6da 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
@@ -72,26 +72,28 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 
 	ctx = mtk_vcodec_get_curr_ctx(dev->main_dev, dev->hw_idx);
 
-	/* check if HW active or not */
-	cg_status = readl(dev->reg_base[VDEC_HW_SYS] + VDEC_HW_ACTIVE_ADDR);
-	if (cg_status & VDEC_HW_ACTIVE_MASK) {
-		mtk_v4l2_vdec_err(ctx, "vdec active is not 0x0 (0x%08x)", cg_status);
-		return IRQ_HANDLED;
-	}
+	if (!ctx->is_secure_playback) {
+		/* check if HW active or not */
+		cg_status = readl(dev->reg_base[VDEC_HW_SYS] + VDEC_HW_ACTIVE_ADDR);
+		if (cg_status & VDEC_HW_ACTIVE_MASK) {
+			mtk_v4l2_vdec_err(ctx, "vdec active is not 0x0 (0x%08x)", cg_status);
+			return IRQ_HANDLED;
+		}
 
-	dec_done_status = readl(vdec_misc_addr);
-	if ((dec_done_status & MTK_VDEC_IRQ_STATUS_DEC_SUCCESS) !=
-	    MTK_VDEC_IRQ_STATUS_DEC_SUCCESS)
-		return IRQ_HANDLED;
+		dec_done_status = readl(vdec_misc_addr);
+		if ((dec_done_status & MTK_VDEC_IRQ_STATUS_DEC_SUCCESS) !=
+		    MTK_VDEC_IRQ_STATUS_DEC_SUCCESS)
+			return IRQ_HANDLED;
 
-	/* clear interrupt */
-	writel(dec_done_status | VDEC_IRQ_CFG, vdec_misc_addr);
-	writel(dec_done_status & ~VDEC_IRQ_CLR, vdec_misc_addr);
+		/* clear interrupt */
+		writel(dec_done_status | VDEC_IRQ_CFG, vdec_misc_addr);
+		writel(dec_done_status & ~VDEC_IRQ_CLR, vdec_misc_addr);
 
-	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
+		wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
 
-	mtk_v4l2_vdec_dbg(3, ctx, "wake up ctx %d, dec_done_status=%x",
-			  ctx->id, dec_done_status);
+		mtk_v4l2_vdec_dbg(3, ctx, "wake up ctx %d, dec_done_status=%x",
+				  ctx->id, dec_done_status);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
index aefd3e9e3061..a94eda936f16 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
@@ -238,7 +238,8 @@ void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 		mtk_vcodec_dec_child_dev_on(ctx->dev, MTK_VDEC_LAT0);
 	mtk_vcodec_dec_child_dev_on(ctx->dev, hw_idx);
 
-	mtk_vcodec_dec_enable_irq(ctx->dev, hw_idx);
+	if (!ctx->is_secure_playback)
+		mtk_vcodec_dec_enable_irq(ctx->dev, hw_idx);
 
 	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
 		mtk_vcodec_load_racing_info(ctx);
@@ -250,7 +251,8 @@ void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
 		mtk_vcodec_record_racing_info(ctx);
 
-	mtk_vcodec_dec_disable_irq(ctx->dev, hw_idx);
+	if (!ctx->is_secure_playback)
+		mtk_vcodec_dec_disable_irq(ctx->dev, hw_idx);
 
 	mtk_vcodec_dec_child_dev_off(ctx->dev, hw_idx);
 	if (IS_VDEC_LAT_ARCH(ctx->dev->vdec_pdata->hw_arch) &&
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
index f27d326f00ba..3186777dcc13 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
@@ -593,14 +593,16 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 		goto vdec_dec_end;
 	}
 
-	/* wait decoder done interrupt */
-	timeout = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
-					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
-	if (timeout)
-		mtk_vdec_err(ctx, "core decode timeout: pic_%d", ctx->decoded_frame_cnt);
-	inst->vsi_core->dec.timeout = !!timeout;
-
-	vpu_dec_core_end(vpu);
+	if (!ctx->is_secure_playback) {
+		/* wait decoder done interrupt */
+		timeout = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
+						       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
+		if (timeout)
+			mtk_vdec_err(ctx, "core decode timeout: pic_%d", ctx->decoded_frame_cnt);
+		inst->vsi_core->dec.timeout = !!timeout;
+
+		vpu_dec_core_end(vpu);
+	}
 	mtk_vdec_debug(ctx, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x",
 		       ctx->decoded_frame_cnt,
 		       inst->vsi_core->dec.crc[0], inst->vsi_core->dec.crc[1],
@@ -724,14 +726,16 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		vdec_msg_queue_qbuf(&inst->ctx->msg_queue.core_ctx, lat_buf);
 	}
 
-	/* wait decoder done interrupt */
-	timeout = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
-					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
-	if (timeout)
-		mtk_vdec_err(inst->ctx, "lat decode timeout: pic_%d", inst->slice_dec_num);
-	inst->vsi->dec.timeout = !!timeout;
+	if (!inst->ctx->is_secure_playback) {
+		/* wait decoder done interrupt */
+		timeout = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
+						       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
+		if (timeout)
+			mtk_vdec_err(inst->ctx, "lat decode timeout: pic_%d", inst->slice_dec_num);
+		inst->vsi->dec.timeout = !!timeout;
 
-	err = vpu_dec_end(vpu);
+		err = vpu_dec_end(vpu);
+	}
 	if (err == SLICE_HEADER_FULL || err == TRANS_BUFFER_FULL) {
 		if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability))
 			vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
@@ -831,16 +835,19 @@ static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
 	if (err)
 		goto err_free_fb_out;
 
-	/* wait decoder done interrupt */
-	err = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
-					   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
-	if (err)
-		mtk_vdec_err(inst->ctx, "decode timeout: pic_%d", inst->ctx->decoded_frame_cnt);
-
-	inst->vsi->dec.timeout = !!err;
-	err = vpu_dec_end(vpu);
-	if (err)
-		goto err_free_fb_out;
+	if (!inst->ctx->is_secure_playback) {
+		/* wait decoder done interrupt */
+		err = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
+						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
+		if (err)
+			mtk_vdec_err(inst->ctx, "decode timeout: pic_%d",
+				     inst->ctx->decoded_frame_cnt);
+
+		inst->vsi->dec.timeout = !!err;
+		err = vpu_dec_end(vpu);
+		if (err)
+			goto err_free_fb_out;
+	}
 
 	memcpy(&inst->vsi_ctx, inst->vpu.vsi, sizeof(inst->vsi_ctx));
 	mtk_vdec_debug(inst->ctx, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x",
-- 
2.18.0


