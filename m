Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081A7E6C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjKIOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjKIOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:12:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BA92D73;
        Thu,  9 Nov 2023 06:12:37 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A7236660739D;
        Thu,  9 Nov 2023 14:12:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699539156;
        bh=bHsPXcPq+RCxN5m6no2vYCXtGthGOFXffIvEuss0WaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NLuvksTyGejXV9sdJMh5tC3X3EILGdZx7JOLHtkjqzvKQ3PL4BSf6mYdIJ7FKI30m
         rMh4dIyDlhnunSIkJ8s6NjI4lfqp/zXcSG28zGAuDeaTLFZPzE40mcEAWUASYHATBa
         QbRzO5gBq0o/kbUh0knpprCOQbTygboTYfIvHGmxhtXd6F6s3FhngHg7en/XzWeJTc
         aQYUVjVNJLT4k7J25i+aaWNgjsKMtcBmEHtLCKaNdFFHxKPC97grku+QB19Tw0N1Yc
         Dy7666VhwjTj4anJuDh1NtIg7zZvVjI5Xz8jN1tn4wDjBKwsEYJtoXGCdhLNQwKPTe
         lcwYPysIvoRSQ==
Message-ID: <9f0edfe5-0bde-43ca-9238-2c84897c56a8@collabora.com>
Date:   Thu, 9 Nov 2023 15:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 48/56] media: verisilicon: Store chroma and motion
 vectors offset
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-49-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-49-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Store computed values of chroma and motion vectors offset because
> they depends on width and height values which change if the resolution
> change.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   drivers/media/platform/verisilicon/hantro.h            | 2 ++
>   drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 0948b04a9f8d..6f5eb975d0e3 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -328,6 +328,8 @@ struct hantro_vp9_decoded_buffer_info {
>   	/* Info needed when the decoded frame serves as a reference frame. */
>   	unsigned short width;
>   	unsigned short height;
> +	size_t chroma_offset;
> +	size_t mv_offset;
>   	u32 bit_depth : 4;
>   };
>   
> diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> index 6fc4b555517f..6db1c32fce4d 100644
> --- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> +++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> @@ -158,9 +158,11 @@ static void config_output(struct hantro_ctx *ctx,
>   
>   	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
>   	hantro_write_addr(ctx->dev, G2_OUT_CHROMA_ADDR, chroma_addr);
> +	dst->vp9.chroma_offset = chroma_offset(ctx, dec_params);
>   
>   	mv_addr = luma_addr + mv_offset(ctx, dec_params);
>   	hantro_write_addr(ctx->dev, G2_OUT_MV_ADDR, mv_addr);
> +	dst->vp9.mv_offset = mv_offset(ctx, dec_params);
>   }
>   
>   struct hantro_vp9_ref_reg {
> @@ -195,7 +197,7 @@ static void config_ref(struct hantro_ctx *ctx,
>   	luma_addr = hantro_get_dec_buf_addr(ctx, &buf->base.vb.vb2_buf);
>   	hantro_write_addr(ctx->dev, ref_reg->y_base, luma_addr);
>   
> -	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
> +	chroma_addr = luma_addr + buf->vp9.chroma_offset;
>   	hantro_write_addr(ctx->dev, ref_reg->c_base, chroma_addr);
>   }
>   
> @@ -238,7 +240,7 @@ static void config_ref_registers(struct hantro_ctx *ctx,
>   	config_ref(ctx, dst, &ref_regs[2], dec_params, dec_params->alt_frame_ts);
>   
>   	mv_addr = hantro_get_dec_buf_addr(ctx, &mv_ref->base.vb.vb2_buf) +
> -		  mv_offset(ctx, dec_params);
> +		  mv_ref->vp9.mv_offset;
>   	hantro_write_addr(ctx->dev, G2_REF_MV_ADDR(0), mv_addr);
>   
>   	hantro_reg_write(ctx->dev, &vp9_last_sign_bias,

