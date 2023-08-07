Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9717721E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjHGL0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjHGL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:26:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13B22D6B;
        Mon,  7 Aug 2023 04:23:15 -0700 (PDT)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E93966071C9;
        Mon,  7 Aug 2023 12:22:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691407336;
        bh=EduguPENzSxmgsBewzA4df/6CWp9o9Q0g5H0KphcdYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PDAGssn/jCO3m36zBchc8GjEsbihDqh2oqXN8o8D8f/09JCExEZdtUh+pd7ZejvsM
         4DhEU8GroyfohDAkh7UiOmPk6zcgCvmvo4UP0BUoelKPxF8U+2IRuUK8MYiwfTKfSb
         slr2DaR3dyouk3Vx9P8Vw4ldXVlHotz+kTedSe00JJv+/1m3PFDzTydpIc8dexzoFr
         9vVMrwln6SqvnsZ9oeWxdjxHmngNS5gEaygcigDHwREQaZUXMT9qQegRFK3tjv03Vk
         9M001uC6yhcj7XpicYSVpvbKGc07tZAH35Q0M0lLDUeZOw6o+QzfXwI8IIHV0/AitR
         YbgP+zurEe9hA==
Message-ID: <135d7bc4-c6a0-30fd-428a-20bd886efa58@collabora.com>
Date:   Mon, 7 Aug 2023 13:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] docs: uapi: media: Properly locate NV12MT diagram
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
 <20230804192737.19016-2-nicolas.dufresne@collabora.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230804192737.19016-2-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 4.08.2023 o 21:27, Nicolas Dufresne pisze:
> The diagram have been pushed back at the end of a list of unrelated
> pixels formats. Move it back next its related pixel format.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   .../media/v4l/pixfmt-yuv-planar.rst           | 32 +++++++++----------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 1840224faa41..fb826923ff1d 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -322,6 +322,22 @@ If the vertical resolution is an odd number of tiles, the last row of
>   tiles is stored in linear order. The layouts of the luma and chroma
>   planes are identical.
>   
> +.. _nv12mt:
> +
> +.. kernel-figure:: nv12mt.svg
> +    :alt:    nv12mt.svg
> +    :align:  center
> +
> +    V4L2_PIX_FMT_NV12MT macroblock Z shape memory layout
> +
> +.. _nv12mt_ex:
> +
> +.. kernel-figure:: nv12mt_example.svg
> +    :alt:    nv12mt_example.svg
> +    :align:  center
> +
> +    Example V4L2_PIX_FMT_NV12MT memory layout of tiles
> +
>   ``V4L2_PIX_FMT_NV12_4L4`` stores pixels in 4x4 tiles, and stores
>   tiles linearly in memory. The line stride and image height must be
>   aligned to a multiple of 4. The layouts of the luma and chroma planes are
> @@ -369,22 +385,6 @@ image height must be aligned to a multiple of 32. The number of luma and chroma
>   tiles are identical, even though the tile size differ. The image is formed of
>   two non-contiguous planes.
>   
> -.. _nv12mt:
> -
> -.. kernel-figure:: nv12mt.svg
> -    :alt:    nv12mt.svg
> -    :align:  center
> -
> -    V4L2_PIX_FMT_NV12MT macroblock Z shape memory layout
> -
> -.. _nv12mt_ex:
> -
> -.. kernel-figure:: nv12mt_example.svg
> -    :alt:    nv12mt_example.svg
> -    :align:  center
> -
> -    Example V4L2_PIX_FMT_NV12MT memory layout of tiles
> -
>   .. _V4L2-PIX-FMT-NV15-4L4:
>   
>   Tiled NV15

