Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D67E6698
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKIJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:23:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC472139;
        Thu,  9 Nov 2023 01:23:07 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA8AD6607410;
        Thu,  9 Nov 2023 09:23:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699521786;
        bh=79QW7iQquBnwYm14N3AIvehKWVXP1fEi05nVMlo3R2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d7i3viPTau1TXKkUDV057Kz7FIJc20TwGqpUXPN+RkCqA1YQ3Tm6xQQbJTKXbrGk7
         vDybVoh3QyJP++z4JQrE7N5ofEZhnFMCP4NPewB8oI6+6QvA2gEWidVxXZh0YackUg
         d3SkTIWIUe3tGLxgwnFadAiSuq0bRQVUQ6OjhZz/JbKfsaUuA4aRa7fhSu4PkrAdP9
         uMZsnimIy3G6B/BMeub95Bk+EN7LtM8m6Q/iKTrnobb2jkAeue+VYticlFOdZlx3Sk
         EGMRuhtS2jn2RN2fJRVWJcyHl7TTombrj3pnJKbUtEHRzuJHDRwWbUW2o+jefxNNVw
         wjGXQQbgfVWrg==
Message-ID: <aca318c9-8d6d-4c04-afdf-8eacb80f79d8@collabora.com>
Date:   Thu, 9 Nov 2023 10:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/56] media: mediatek: vcodec: Stop direct calls to
 queue num_buffers field
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
        kernel@collabora.com, Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-14-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-14-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise, I made a typo in my email address. Resending with a proper one.

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Bin Liu <bin.liu@mediatek.com>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
> index eb381fa6e7d1..181884e798fd 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
> @@ -912,7 +912,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
>   	return 0;
>   
>   err_start_stream:
> -	for (i = 0; i < q->num_buffers; ++i) {
> +	for (i = 0; i < vb2_get_num_buffers(q); ++i) {
>   		struct vb2_buffer *buf = vb2_get_buffer(q, i);
>   
>   		/*

