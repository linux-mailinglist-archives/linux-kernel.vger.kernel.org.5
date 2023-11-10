Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1C7E8062
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjKJSKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbjKJSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F89E887F;
        Fri, 10 Nov 2023 01:24:22 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D05AD66073D3;
        Fri, 10 Nov 2023 09:24:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699608260;
        bh=28TPHHA9Iel9THKWFs6QPU/6HNkFryi8SVAuj58Nqhc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QQOWpE7gIbxb1eJj9TsBokiPp9dEbYBqhq9+G9cWRilgRPrpk7MU02BYltetkXSk/
         5BBflBVkUunL9iALpYBxuao1sPI0Q0aS7A0aSPgxS3KNLTAY3f9q5HtWtekNxdlxCs
         b4lmWmO8/xeay6hrctKOJk0Qv8XfGGXooG5le9Z+9I3CrQLYy74zgbELoURGK0G//+
         iqC05s4VtTHUOGJNffRiYcrzcVzRWRVKhJwofs7otFKZfQZ1z4NpEOH7yOH5sU9xgT
         48U8RLJYNt70Rz2PYT97PxMuKcO62szxM11D+7mQTbZzq2j11OxJg4LrzXKj92tSZW
         6OUcHPZhSbbjw==
Message-ID: <8e7629ca-eb6c-41d4-af3e-9938397a08c0@collabora.com>
Date:   Fri, 10 Nov 2023 10:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 14/56] media: sti: hva: Remove useless check
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
        kernel@collabora.com,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
 <20231109163512.179524-15-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231109163512.179524-15-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 9.11.2023 o 17:34, Benjamin Gaignard pisze:
> Remove index range test since it is done by vb2_get_buffer().
> vb2_get_buffer() can return a NULL pointer so we need the return
> value.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
> ---
>   drivers/media/platform/st/sti/hva/hva-v4l2.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
> index 3a848ca32a0e..cfe83e9dc01b 100644
> --- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
> +++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
> @@ -569,14 +569,11 @@ static int hva_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>   		struct vb2_buffer *vb2_buf;
>   
>   		vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, buf->type);
> -
> -		if (buf->index >= vq->num_buffers) {
> -			dev_dbg(dev, "%s buffer index %d out of range (%d)\n",
> -				ctx->name, buf->index, vq->num_buffers);
> +		vb2_buf = vb2_get_buffer(vq, buf->index);
> +		if (!vb2_buf) {
> +			dev_dbg(dev, "%s buffer index %d not found\n", ctx->name, buf->index);
>   			return -EINVAL;
>   		}
> -
> -		vb2_buf = vb2_get_buffer(vq, buf->index);
>   		stream = to_hva_stream(to_vb2_v4l2_buffer(vb2_buf));
>   		stream->bytesused = buf->bytesused;
>   	}

