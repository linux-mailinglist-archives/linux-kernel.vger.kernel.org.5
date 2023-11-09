Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F77E6748
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjKIKDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjKIKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:03:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAF2D64;
        Thu,  9 Nov 2023 02:03:40 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 656A56607435;
        Thu,  9 Nov 2023 10:03:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699524219;
        bh=pwEpx+MGypxzSwA28V6syRhlcHgpJof7RIF00c+aBRM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aJ/8xGCiHJjm+CzwAabNyyU/GTAjIxeHX99hblXV4BHBd4DHnYLUXAHjuLAR6v0i7
         QL7RBgs8tyojA/aKIufbltXnwa7w59cKRCLfV/QgUlRA+wXk5HUUfepBmry8bswQYO
         bjo4LBDFceemSp6R8A7bvU2n+7Ed3HM1h523gk4NH3YhQAYFJg3lWse9xPpZg1xTYT
         1aQ08/atj10VsG8cKnvSWSzWwEe9C/ctDajHI3q3u6dfKbERJYbTZKip/ZUC+5Mmjp
         A+IY/TDJyhvEW1/Rslkz2tnF2aC7YSgYlCvEIULsIpTmqXw/gSFbiw57kj6cEy9yhv
         iRGES/Swt2qEQ==
Message-ID: <11b22d60-3a83-4385-ab1a-d8c2e672e24a@collabora.com>
Date:   Thu, 9 Nov 2023 11:03:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/56] media: pci: dt3155: Remove useless check
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
 <20231031163104.112469-22-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-22-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> min_buffers_needed is already set to 2 so remove this useless
> check.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/media/pci/dt3155/dt3155.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
> index 548156b199cc..d09cde2f6ee4 100644
> --- a/drivers/media/pci/dt3155/dt3155.c
> +++ b/drivers/media/pci/dt3155/dt3155.c
> @@ -128,8 +128,6 @@ dt3155_queue_setup(struct vb2_queue *vq,
>   	struct dt3155_priv *pd = vb2_get_drv_priv(vq);
>   	unsigned size = pd->width * pd->height;
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
>   	if (*num_planes)
>   		return sizes[0] < size ? -EINVAL : 0;
>   	*num_planes = 1;

