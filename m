Return-Path: <linux-kernel+bounces-84811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253186ABE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08836286669
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A640B3714C;
	Wed, 28 Feb 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Skew+2LO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396136B0A;
	Wed, 28 Feb 2024 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114968; cv=none; b=fRl6vDZRnh95QoipNGIBfgmPOuNVyAuc3XONiTTELTrFqPfUpkwqtFgPFkZXAxBj2N6K6Q8g18CpW+Hy9UqmdvokfVa1ofC41mpVUp0btHgbHFmr/Z1SPPxucF99AtQAcnvUQsf7EfstIHRhTDatZq7JqDBuqqoWZRWmz2MXzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114968; c=relaxed/simple;
	bh=S66s19ilvDHTNIulMAImsMB6AkaPAi9N9/xnkhBU13k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJuFBAxaFhYtqKLTRw5R2q00CGHqDWOZXEg/JaN6LOjU+fXO0WEZ3AY8sdMXWVKy2Rnggj/TRajCkZextXqYN9DYIpUJxtyljLmLN6XNXMs6AKPteOzZ8SLLxUoBra5dn552v+kAZhY0QxahaMUTIDEV7lQKalGRLBLffVJFG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Skew+2LO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709114964;
	bh=S66s19ilvDHTNIulMAImsMB6AkaPAi9N9/xnkhBU13k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Skew+2LOY7JbHwKpTbn8YnEJTYP2G50KkkHUgi6mQv0GLQVie8KLptOh2ijMyWp25
	 4aFi6QD8QSXodCbY/qyo7t1nSTF1XHcmytnnAhaZ+x3pc3pKGKasqgVigmzCsjnEHr
	 kolcyRw7M+mEU5aA+Ta1zv4ft/DYLLt5LDgcVRDfXcz4h7TAyeoGZSO0q8lnnzZabE
	 DhEeUV14LG5nJLEbnE4d793Dy1nRzHAuFkEtFTrHF6BWWdEzU6s7ZZnRDpscnsjjS3
	 FiZ6L7D4Xsqe7aCd2SJPdL9WPxmDh5y7n5NSzqGrKJg4u3AB1n4ckYgq87Y2/+A8qh
	 Ggcq2RaJdmgAw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE5D937820CB;
	Wed, 28 Feb 2024 10:09:23 +0000 (UTC)
Message-ID: <e7d57472-08f9-4e71-8c42-2f95d9a81f75@collabora.com>
Date: Wed, 28 Feb 2024 11:09:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mediatek: vcodec: Fix oops when HEVC init fails
Content-Language: en-US
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: kernel@collabora.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240226211954.400891-1-nicolas.dufresne@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226211954.400891-1-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 22:19, Nicolas Dufresne ha scritto:
> In stateless HEVC case, the instance pointer was saved in the
> context regardless if the initialization worked. As the pointer
> is freed in failure, this resulted in use after free in the
> deinit function.
> 

 From what I understand, "the pointer" that is freed is struct vdec_vpu_inst; is
that correct?

Since you do have a way to easily reproduce the issue on your side, can we resolve
the safety/reliability root issue as well as making this correct?

The idea is being able to avoid a kernel panic in the situation that you describe
in this fix, but throw an error message (read: throw a big "wtf!") when this does
happen, and handle that with returning an error code (avoiding a kernel crash).

Let's cut it short - please try this:

In functions
   - int vpu_vdec_start()
   - int vpu_dec_get_param()
   - int vcodec_send_ap_ipi()

at the beginning, perform this check:

	if (unlikely(!vpu)) {
		/* Write a scarier message if this is not scary enough */
		mtk_vdec_err("FIXME!! - VPU is NULL. This is unexpected.\n");
		return -EINVAL; /* or something else if more meaningful */
	}

Unless I've misunderstood what's NULL, that'll work. :-)


Meanwhile, for this fix:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

>   Hardware name: Acer Tomato (rev3 - 4) board (DT)
>   pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : vcodec_vpu_send_msg+0x4c/0x190 [mtk_vcodec_dec]
>   lr : vcodec_send_ap_ipi+0x78/0x170 [mtk_vcodec_dec]
>   sp : ffff80008750bc20
>   x29: ffff80008750bc20 x28: ffff1299f6d70000 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>   x23: ffff80008750bc98 x22: 000000000000a003 x21: ffffd45c4cfae000
>   x20: 0000000000000010 x19: ffff1299fd668310 x18: 000000000000001a
>   x17: 000000040044ffff x16: ffffd45cb15dc648 x15: 0000000000000000
>   x14: ffff1299c08da1c0 x13: ffffd45cb1f87a10 x12: ffffd45cb2f5fe80
>   x11: 0000000000000001 x10: 0000000000001b30 x9 : ffffd45c4d12b488
>   x8 : 1fffe25339380d81 x7 : 0000000000000001 x6 : ffff1299c9c06c00
>   x5 : 0000000000000132 x4 : 0000000000000000 x3 : 0000000000000000
>   x2 : 0000000000000010 x1 : ffff80008750bc98 x0 : 0000000000000000
>   Call trace:
>    vcodec_vpu_send_msg+0x4c/0x190 [mtk_vcodec_dec]
>    vcodec_send_ap_ipi+0x78/0x170 [mtk_vcodec_dec]
>    vpu_dec_deinit+0x1c/0x30 [mtk_vcodec_dec]
>    vdec_hevc_slice_deinit+0x30/0x98 [mtk_vcodec_dec]
>    vdec_if_deinit+0x38/0x68 [mtk_vcodec_dec]
>    mtk_vcodec_dec_release+0x20/0x40 [mtk_vcodec_dec]
>    fops_vcodec_release+0x64/0x118 [mtk_vcodec_dec]
>    v4l2_release+0x7c/0x100
>    __fput+0x80/0x2d8
>    __fput_sync+0x58/0x70
>    __arm64_sys_close+0x40/0x90
>    invoke_syscall+0x50/0x128
>    el0_svc_common.constprop.0+0x48/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x38/0xd8
>    el0t_64_sync_handler+0xc0/0xc8
>    el0t_64_sync+0x1a8/0x1b0
>   Code: d503201f f9401660 b900127f b900227f (f9400400)
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Fixes: 2674486aac7d ("media: mediatek: vcodec: support stateless hevc decoder")
> ---
>   .../mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c       | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
> index 06ed47df693bf..21836dd6ef85a 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
> @@ -869,7 +869,6 @@ static int vdec_hevc_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>   	inst->vpu.codec_type = ctx->current_codec;
>   	inst->vpu.capture_type = ctx->capture_fourcc;
>   
> -	ctx->drv_handle = inst;
>   	err = vpu_dec_init(&inst->vpu);
>   	if (err) {
>   		mtk_vdec_err(ctx, "vdec_hevc init err=%d", err);
> @@ -898,6 +897,7 @@ static int vdec_hevc_slice_init(struct mtk_vcodec_dec_ctx *ctx)
>   	mtk_vdec_debug(ctx, "lat hevc instance >> %p, codec_type = 0x%x",
>   		       inst, inst->vpu.codec_type);
>   
> +	ctx->drv_handle = inst;
>   	return 0;
>   error_free_inst:
>   	kfree(inst);


