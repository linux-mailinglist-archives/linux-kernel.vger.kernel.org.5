Return-Path: <linux-kernel+bounces-127661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A89894F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4B1B22679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13D5914C;
	Tue,  2 Apr 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="35rLm1S5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DE17C8D;
	Tue,  2 Apr 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051459; cv=none; b=IpGQ7kY39cna5b8FLxSI4O7VmzFcxuOn2G/jftzZ6ANgZf/dZx6uWA6znTJ5xD3k750Ue8SAykbM7YFMzppASffx5QypaUfh4X8WBIkTSMjzxm9PWoo6ICi6+jB42KH6+fnNyjybeQEN1ss2A82T8jGdCfH196S8QYbBiDhscyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051459; c=relaxed/simple;
	bh=vw9cJNl0LdiDuqpsolVN3qVEokjCyQNhVMfH1BeHA1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S73zKO9AyYUvIDvL4C9wU0IjDnGXSV1DfvXoV1akSCHaiRHplx+KLLYMmSUbOPPRW8sK6brM3cQImMT6zhqpiPVo23T/bvf71A/+8rSmM/UBesmYhD5OxgILHURqXlXjLPbZ+1GtLLSX+EtI+HGu0ChrJBVGryJrXOoMp3BYjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=35rLm1S5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712051455;
	bh=vw9cJNl0LdiDuqpsolVN3qVEokjCyQNhVMfH1BeHA1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=35rLm1S57yMgRE+kXJmLpYmkm6SUggu4hiypnYM7pxO4Qzz9MUkxoEoG37wJDSR6Z
	 I8BjXG4rZv7tpL4/HMeydnOgGt0ywMPEuDn11KRvHZRlJA7NhpvZfYTrjiV5/T/m13
	 2HD16VV0x41MOn+n1To3JOlICC43sCB0n0bH0hAIRBSAvH16r+yKjZi8o+m/+mavOx
	 69yABYjYrxphibinRyMHdWhSbfS/EbQaN0yWq2DFey5Kd4xJVO5OEDRCqDu9CYTVIe
	 gVnRQusPVg3hFVlyOBPtEtBJdiqTGIwN2X4A4JUTkh2jWt+y+9xfXbF3M4ah0i0/gZ
	 mXMBr2WexXVpQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D7B0737820EF;
	Tue,  2 Apr 2024 09:50:53 +0000 (UTC)
Message-ID: <4949bd54-8c32-4490-ab19-d38796d29ac1@collabora.com>
Date: Tue, 2 Apr 2024 11:50:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: mediatek: vcodec: fix h264 multi statless
 decoder smatch warning
To: Yunfei Dong <yunfei.dong@mediatek.com>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240229095611.6698-1-yunfei.dong@mediatek.com>
 <20240229095611.6698-2-yunfei.dong@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240229095611.6698-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/02/24 10:56, Yunfei Dong ha scritto:
> Fix smatch static checker warning for vdec_h264_req_multi_if.c.
> Leading to kernel crash when fb is NULL.
> 
> Fixes: 397edc703a10 ("media: mediatek: vcodec: add h264 decoder")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c         | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
> index 0e741e0dc8ba..ab8e708e0df1 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
> @@ -724,11 +724,16 @@ static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
>   		return vpu_dec_reset(vpu);
>   
>   	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
> +	if (!fb) {
> +		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
> +		return -EBUSY;
> +	}
> +
>   	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
>   	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
>   
> -	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
> -	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;

You're changing the behavior here, can you please explain why this change is valid
into the commit description?

Thanks,
Angelo

> +	y_fb_dma = (u64)fb->base_y.dma_addr;
> +	c_fb_dma = (u64)fb->base_c.dma_addr;
>   	mtk_vdec_debug(inst->ctx, "[h264-dec] [%d] y_dma=%llx c_dma=%llx",
>   		       inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
>   



