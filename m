Return-Path: <linux-kernel+bounces-101554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F287A8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F4B20FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9004205B;
	Wed, 13 Mar 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5cBLAAh+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BF43AAF;
	Wed, 13 Mar 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337502; cv=none; b=umCUVeldyYnvCwq3S6IMlbKMx+UBUbXslDXcsWiOMQo4rlWiA0TiY4IcpHrQfiNMkguXRNrLFo2DxGdMrPxp0kjQojVxFmNcJlgMLt3z/JhY5rHfZFT5zZeQcLE2NX4Pr6XWqDhxLB8qPcL4gZQQLbZbvI9yRFDFOxGwvmjQ6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337502; c=relaxed/simple;
	bh=VrDvKziGbkVXCGwa6UA7DRHxzR12jtWLeeoDQJ0I6oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3sA9O6eTh9WQqHNANi/VZUegbBXx0GgqR78P04ufMG4Z2sb2/TC0wYq72c0azVQQdRthqE+7gQuek/lbfvJzNpz7IK3vAIEzePecKdrRekyE1FqdN+WTKJa9fmyIVeghzPxSskfAMgNqttEt+1PepAnzw96jNJ+skz5c2/dWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5cBLAAh+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710337499;
	bh=VrDvKziGbkVXCGwa6UA7DRHxzR12jtWLeeoDQJ0I6oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5cBLAAh+64ylKAHP3XHFb/VKg/Zh4uf60TrrLXqZV5TlC5dllbM8od/kttPsUfbqq
	 8KvlfcpV7A/SH87WxVPAcTTIx3hPPyOcoVX1Gf2TuLy1UTIS9eivi02CiPGt879mes
	 UKmX0yycdsewfAONQaXmh/Irozzd9DW5pP3b+5Gvlf7tlKklEN1c3WiXuGiU98j/W+
	 IyCQzu/si+fJVID394W9B31B89pEdVilSx61uu0UBOwZTH2A0A63tbx81GttYkAjdl
	 JHIQmFebWnzwCdx240rSiQqnaHYk9AoNXyiAeIqlficSEII5RK/qDqlY/qT7zwEKHd
	 FPN6DFLqrjAkw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A0BF33782079;
	Wed, 13 Mar 2024 13:44:58 +0000 (UTC)
Date: Wed, 13 Mar 2024 14:44:56 +0100
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
Subject: Re: [PATCH v3,2/2] media: mediatek: vcodec: adding lock to protect
 encoder context list
Message-ID: <20240313134456.7dov7dztcwsxr74d@basti-XPS-13-9310>
References: <20240222092609.31382-1-yunfei.dong@mediatek.com>
 <20240222092609.31382-3-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240222092609.31382-3-yunfei.dong@mediatek.com>

Hey Yunfei,

On 22.02.2024 17:26, Yunfei Dong wrote:
>The ctx_list will be deleted when scp getting unexpected behavior, then the
>ctx_list->next will be NULL, the kernel driver maybe access NULL pointer in
>function vpu_enc_ipi_handler when going through each context, then reboot.
>
>Need to add lock to protect the ctx_list to make sure the ctx_list->next isn't
>NULL pointer.

Can we reword this slightly to make it grammatically correct?

My suggestion:
```
Add a lock for the ctx_list, to avoid accessing a NULL pointer within
the `vpu_enc_ipi_handler` function, when the ctx_list has been deleted
due to an unexpected behavior on the SCP IP block.
```

Greetings,
Sebastian

>
>Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 4 ++--
> .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c    | 5 +++++
> .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h    | 2 ++
> drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c | 2 ++
> 4 files changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
>index 9a11a2c248045..8d578b6902148 100644
>--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
>+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
>@@ -73,12 +73,12 @@ static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
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
> static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
>diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
>index 5db2bf3db4c54..29524cd59ce8b 100644
>--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
>+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
>@@ -177,7 +177,9 @@ static int fops_vcodec_open(struct file *file)
> 	mtk_v4l2_venc_dbg(2, ctx, "Create instance [%d]@%p m2m_ctx=%p ",
> 			  ctx->id, ctx, ctx->m2m_ctx);
>
>+	mutex_lock(&dev->dev_ctx_lock);
> 	list_add(&ctx->list, &dev->ctx_list);
>+	mutex_unlock(&dev->dev_ctx_lock);
>
> 	mutex_unlock(&dev->dev_mutex);
> 	mtk_v4l2_venc_dbg(0, ctx, "%s encoder [%d]", dev_name(&dev->plat_dev->dev),
>@@ -212,7 +214,9 @@ static int fops_vcodec_release(struct file *file)
> 	v4l2_fh_exit(&ctx->fh);
> 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
>
>+	mutex_lock(&dev->dev_ctx_lock);
> 	list_del_init(&ctx->list);
>+	mutex_unlock(&dev->dev_ctx_lock);
> 	kfree(ctx);
> 	mutex_unlock(&dev->dev_mutex);
> 	return 0;
>@@ -294,6 +298,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>
> 	mutex_init(&dev->enc_mutex);
> 	mutex_init(&dev->dev_mutex);
>+	mutex_init(&dev->dev_ctx_lock);
> 	spin_lock_init(&dev->irqlock);
>
> 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
>diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
>index a042f607ed8d1..0bd85d0fb379a 100644
>--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
>+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
>@@ -178,6 +178,7 @@ struct mtk_vcodec_enc_ctx {
>  *
>  * @enc_mutex: encoder hardware lock.
>  * @dev_mutex: video_device lock
>+ * @dev_ctx_lock: the lock of context list
>  * @encode_workqueue: encode work queue
>  *
>  * @enc_irq: h264 encoder irq resource
>@@ -205,6 +206,7 @@ struct mtk_vcodec_enc_dev {
> 	/* encoder hardware mutex lock */
> 	struct mutex enc_mutex;
> 	struct mutex dev_mutex;
>+	struct mutex dev_ctx_lock;
> 	struct workqueue_struct *encode_workqueue;
>
> 	int enc_irq;
>diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
>index 84ad1cc6ad171..51bb7ee141b9e 100644
>--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
>+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
>@@ -47,12 +47,14 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc_dev *enc_dev, struct ven
> 	struct mtk_vcodec_enc_ctx *ctx;
> 	int ret = false;
>
>+	mutex_lock(&enc_dev->dev_ctx_lock);
> 	list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
> 		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
> 			ret = true;
> 			break;
> 		}
> 	}
>+	mutex_unlock(&enc_dev->dev_ctx_lock);
>
> 	return ret;
> }
>-- 
>2.18.0
>
>

