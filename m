Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796447E6A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjKIMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:32:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9192590;
        Thu,  9 Nov 2023 04:32:19 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E413F660748C;
        Thu,  9 Nov 2023 12:32:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699533138;
        bh=CpA/2/kD4qcNpyp13EzsdiW7+wPb7nwcHMs4TrdTlPY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VG9jaJfee09CBJlAsZ9G49FVSwS4gpIKvGJFvz3xSVO3nMCiJfugB529ZIWo307Xg
         nc/YsgO0JJwm2JXNB0NnhUy4RYA3ABKWSa5HBMBLXy8ZeFyoUBYlOTXUCScK+Fq93d
         kUX49yZPZCCdjHK/+5kMctDTiQkaZ1+hHGRaM31Xf6k8iU6ftXiryfPvVLdl5J8PzZ
         qcXODVgm0KCNN39qFheU2gxHiwHVuObEyEqJmWyfTikgjwgPAKIRV4L99omHetcXVh
         Psedi0mR+cu0udL9bEg936s7TgxzxLiz7PEwzspq8++ezuuI7Px9ls4A6P2dTU/wSo
         Fqr/FMwUFbwig==
Message-ID: <38319779-41ba-4e1e-9e05-1bd1b6c595ef@collabora.com>
Date:   Thu, 9 Nov 2023 13:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 46/56] media: test-drivers: vicodec: Increase max
 supported capture queue buffers
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
 <20231031163104.112469-47-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-47-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Allow to allocated up to 64 buffers on capture queue.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/media/test-drivers/vicodec/vicodec-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
> index 6f0e20df74e9..69cbe2c094e1 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -1718,6 +1718,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
>   			V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
>   			V4L2_BUF_TYPE_VIDEO_CAPTURE);
>   	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
> +	dst_vq->max_num_buffers = 64;
>   	dst_vq->drv_priv = ctx;
>   	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
>   	dst_vq->ops = &vicodec_qops;

