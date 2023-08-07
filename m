Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784A7772252
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjHGLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjHGLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:31:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE35B8E;
        Mon,  7 Aug 2023 04:29:16 -0700 (PDT)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEFCA66071C9;
        Mon,  7 Aug 2023 12:28:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691407687;
        bh=56gVYcaazTrYHIsA62HDQJBwlVRjju6wr+3l6jBJIO8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HnjuxLv1rnNTd4l05rPxR/wWm8WHB2/x4L9dapjnflads/l+tW5yfjevSBkKfa6SF
         GWwVr8FnMQlz0F75R2JD5omvQxSgsmHCdtMAIG1IhfZFFR83lIdZ+50xYym5LdQDXn
         mtNa4bAsO4EWedDeR8s8/fHo4Zv/dN1vIQQM/V2gI9i5vyxWu8Iueqlkekmp8sje71
         FVNrpBMH37Yf1NbaUXx96yTPxAEpd6O7P4LD4YYU2BnmDEumJu8tXU62DqEec+zRSn
         B7CDKoo0woT+35IN6QBEtz+uu9s+S4slRgOkeXrCnvuZviGFG2dL139EIAmNw4yDiZ
         rV4sli6X2HnDg==
Message-ID: <fa3fd17d-570b-fd5f-1c35-3e4004333383@collabora.com>
Date:   Mon, 7 Aug 2023 13:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] docs: uapi: media: Move NV12_10BE_8L128 to NV15
 section
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
 <20230804192737.19016-3-nicolas.dufresne@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230804192737.19016-3-nicolas.dufresne@collabora.com>
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
> This is a 15 bits per pixel (or packed 10 bit format), so move it
> into the relevant section.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   .../media/v4l/pixfmt-yuv-planar.rst           | 36 ++++++++++---------
>   1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index fb826923ff1d..1d43532095c0 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -295,8 +295,6 @@ of the luma plane.
>   .. _V4L2-PIX-FMT-NV12-32L32:
>   .. _V4L2-PIX-FMT-NV12M-8L128:
>   .. _V4L2-PIX-FMT-NV12-8L128:
> -.. _V4L2-PIX-FMT-NV12M-10BE-8L128:
> -.. _V4L2-PIX-FMT-NV12-10BE-8L128:
>   .. _V4L2-PIX-FMT-MM21:
>   
>   Tiled NV12
> @@ -361,6 +359,25 @@ The layouts of the luma and chroma planes are identical.
>   ``V4L2_PIX_FMT_NV12_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_8L128`` but stores
>   two planes in one memory.
>   
> +``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
> +in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
> +image height must be aligned to a multiple of 32. The number of luma and chroma
> +tiles are identical, even though the tile size differ. The image is formed of
> +two non-contiguous planes.
> +
> +
> +.. _V4L2-PIX-FMT-NV15-4L4:
> +.. _V4L2-PIX-FMT-NV12M-10BE-8L128:
> +.. _V4L2-PIX-FMT-NV12-10BE-8L128:
> +
> +Tiled NV15
> +----------
> +
> +``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
> +All components are packed without any padding between each other.
> +As a side-effect, each group of 4 components are stored over 5 bytes
> +(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
> +
>   ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
>   10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
>   the data is arranged in big endian order.
> @@ -379,21 +396,6 @@ byte 4: Y3(bits 7-0)
>   ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
>   two planes in one memory.
>   
> -``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
> -in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
> -image height must be aligned to a multiple of 32. The number of luma and chroma
> -tiles are identical, even though the tile size differ. The image is formed of
> -two non-contiguous planes.
> -
> -.. _V4L2-PIX-FMT-NV15-4L4:
> -
> -Tiled NV15
> -----------
> -
> -Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
> -All components are packed without any padding between each other.
> -As a side-effect, each group of 4 components are stored over 5 bytes
> -(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
>   
>   .. _V4L2-PIX-FMT-NV16:
>   .. _V4L2-PIX-FMT-NV61:

