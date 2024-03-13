Return-Path: <linux-kernel+bounces-101558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BC87A8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE97BB22A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799F446B4;
	Wed, 13 Mar 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qFnVBFU7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21C4438F;
	Wed, 13 Mar 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337620; cv=none; b=A/HwzAedjKeQAZGmRGPjCI89/hH1vFID7TrQXOxEb9wWq8waUPb91zdu5CCBomfCpOdDwNpMcQ3iyRUQGKJOXcVhsNcb5azw9Y511pJ/7KoaYm3AaPyHsY2NsB7+dOXrMR41+qLCJ91qTwX1reTpdJmAnSm/BTeQVPnZcbXur28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337620; c=relaxed/simple;
	bh=tFC1LjN/c/2WfKnIaEgh2D1GzcV4H+gxaOkYGxItpss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtfqDmo4X+EY4ZtlPUsGyVjXqgz/ULLHXi1P0kXpBgDI2HvbLWKNibNnSRkgtO6w+qVrMVq3uSyOiT+nIZYP7zRjhZC65bW2p93tBb5fK2XxKWQLXSAclMFzJgE9c0iOPG1LMbM/5qtIIxbBvgWVb0w17N/gPdO1ILplSuLPILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qFnVBFU7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710337617;
	bh=tFC1LjN/c/2WfKnIaEgh2D1GzcV4H+gxaOkYGxItpss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFnVBFU7WjNRn7y7twAoCNwkAnDX3XVb3JGj4ip1QqsEeUwoxHisKNyhj2Ih1mAYp
	 yHukGMJo8MfoQ2WGxVRbWyj64as2qvMRqeQStIsxnXD0yQiXuAgd6oTsxDehZDMJld
	 MrDBbYCO4LRaOOpiqbPjMyAXjn1fsdaLlbDyyZP4srCRaxdeKQ3+CLRmL4HzBPEv1H
	 jKnnNuM0i92eOTdO5bheuJXRaWIeXH2YMPhZd5tI0AnyNPIOVwrHtk56eZbcEmsYdn
	 6txf4bfb+juxAa2VKlr8l3wPgD4Z1DG61j+eMDJ86/ILh/cpTH+Q9CArMrkFmMXmaR
	 jurXpxlSMDHsg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3EBB37820C6;
	Wed, 13 Mar 2024 13:46:56 +0000 (UTC)
Date: Wed, 13 Mar 2024 14:46:52 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Nathan Hebert <nhebert@chromium.org>,
	Irui Wang <irui.wang@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3,1/2] media: mediatek: vcodec: adding lock to protect
 decoder context list
Message-ID: <20240313134652.gj4kwlbmiqu5hxdu@basti-XPS-13-9310>
References: <20240222092609.31382-1-yunfei.dong@mediatek.com>
 <20240222092609.31382-2-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240222092609.31382-2-yunfei.dong@mediatek.com>

Hey Yunfei,

On 22.02.2024 17:26, Yunfei Dong wrote:
>The ctx_list will be deleted when scp getting unexpected behavior, then the
>ctx_list->next will be NULL, the kernel driver maybe access NULL pointer in
>function vpu_dec_ipi_handler when going through each context, then reboot.

>
>Need to add lock to protect the ctx_list to make sure the ctx_list->next isn't
>NULL pointer.

Same here as with the encoder changes.

Greetings,
Sebastian

>
>Hardware name: Google juniper sku16 board (DT)
>pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
>pc : vpu_dec_ipi_handler+0x58/0x1f8 [mtk_vcodec_dec]
>lr : scp_ipi_handler+0xd0/0x194 [mtk_scp]
>sp : ffffffc0131dbbd0
>x29: ffffffc0131dbbd0 x28: 0000000000000000
>x27: ffffff9bb277f348 x26: ffffff9bb242ad00
>x25: ffffffd2d440d3b8 x24: ffffffd2a13ff1d4
>x23: ffffff9bb7fe85a0 x22: ffffffc0133fbdb0
>x21: 0000000000000010 x20: ffffff9b050ea328
>x19: ffffffc0131dbc08 x18: 0000000000001000
>x17: 0000000000000000 x16: ffffffd2d461c6e0
>x15: 0000000000000242 x14: 000000000000018f
>x13: 000000000000004d x12: 0000000000000000
>x11: 0000000000000001 x10: fffffffffffffff0
>x9 : ffffff9bb6e793a8 x8 : 0000000000000000
>x7 : 0000000000000000 x6 : 000000000000003f
>x5 : 0000000000000040 x4 : fffffffffffffff0
>x3 : 0000000000000020 x2 : ffffff9bb6e79080
>x1 : 0000000000000010 x0 : ffffffc0131dbc08
>Call trace:
>vpu_dec_ipi_handler+0x58/0x1f8 [mtk_vcodec_dec (HASH:6c3f 2)]
>scp_ipi_handler+0xd0/0x194 [mtk_scp (HASH:7046 3)]
>mt8183_scp_irq_handler+0x44/0x88 [mtk_scp (HASH:7046 3)]
>scp_irq_handler+0x48/0x90 [mtk_scp (HASH:7046 3)]
>irq_thread_fn+0x38/0x94
>irq_thread+0x100/0x1c0
>kthread+0x140/0x1fc
>ret_from_fork+0x10/0x30
>Code: 54000088 f94ca50a eb14015f 54000060 (f9400108)
>---[ end trace ace43ce36cbd5c93 ]---
>Kernel panic - not syncing: Oops: Fatal exception
>SMP: stopping secondary CPUs
>Kernel Offset: 0x12c4000000 from 0xffffffc010000000
>PHYS_OFFSET: 0xffffffe580000000
>CPU features: 0x08240002,2188200c
>Memory Limit: none
>
>Fixes: 655b86e52eac ("media: mediatek: vcodec: Fix possible invalid memory access for decoder")
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 4 ++--
> .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c    | 5 +++++
> .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h    | 2 ++
> drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c | 2 ++
> 4 files changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
>index 9f6e4b59455da..9a11a2c248045 100644
>--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
>+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
>@@ -58,12 +58,12 @@ static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
>
> 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
>
>-	mutex_lock(&dev->dev_mutex);
>+	mutex_lock(&dev->dev_ctx_lock);
> 	list_for_each_entry(ctx, &dev->ctx_list, list) {
> 		ctx->state = MTK_STATE_ABORT;
> 		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx->id);
> 	}
>-	mutex_unlock(&dev->dev_mutex);
>+	mutex_unlock(&dev->dev_ctx_lock);
> }
>
> static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
>index ad9b68380692f..d69c9fe2af6f3 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
>@@ -267,7 +267,9 @@ static int fops_vcodec_open(struct file *file)
>
> 	ctx->dev->vdec_pdata->init_vdec_params(ctx);
>
>+	mutex_lock(&dev->dev_ctx_lock);
> 	list_add(&ctx->list, &dev->ctx_list);
>+	mutex_unlock(&dev->dev_ctx_lock);
> 	mtk_vcodec_dbgfs_create(ctx);
>
> 	mutex_unlock(&dev->dev_mutex);
>@@ -310,7 +312,9 @@ static int fops_vcodec_release(struct file *file)
> 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
>
> 	mtk_vcodec_dbgfs_remove(dev, ctx->id);
>+	mutex_lock(&dev->dev_ctx_lock);
> 	list_del_init(&ctx->list);
>+	mutex_unlock(&dev->dev_ctx_lock);
> 	kfree(ctx);
> 	mutex_unlock(&dev->dev_mutex);
> 	return 0;
>@@ -403,6 +407,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
> 	for (i = 0; i < MTK_VDEC_HW_MAX; i++)
> 		mutex_init(&dev->dec_mutex[i]);
> 	mutex_init(&dev->dev_mutex);
>+	mutex_init(&dev->dev_ctx_lock);
> 	spin_lock_init(&dev->irqlock);
>
> 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
>index 849b89dd205c2..85b2c0d3d8bcd 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
>@@ -241,6 +241,7 @@ struct mtk_vcodec_dec_ctx {
>  *
>  * @dec_mutex: decoder hardware lock
>  * @dev_mutex: video_device lock
>+ * @dev_ctx_lock: the lock of context list
>  * @decode_workqueue: decode work queue
>  *
>  * @irqlock: protect data access by irq handler and work thread
>@@ -282,6 +283,7 @@ struct mtk_vcodec_dec_dev {
> 	/* decoder hardware mutex lock */
> 	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
> 	struct mutex dev_mutex;
>+	struct mutex dev_ctx_lock;
> 	struct workqueue_struct *decode_workqueue;
>
> 	spinlock_t irqlock;
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
>index 82e57ae983d55..da6be556727bb 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
>@@ -77,12 +77,14 @@ static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec_dev *dec_dev, struct vde
> 	struct mtk_vcodec_dec_ctx *ctx;
> 	int ret = false;
>
>+	mutex_lock(&dec_dev->dev_ctx_lock);
> 	list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
> 		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
> 			ret = true;
> 			break;
> 		}
> 	}
>+	mutex_unlock(&dec_dev->dev_ctx_lock);
>
> 	return ret;
> }
>-- 
>2.18.0
>
>

