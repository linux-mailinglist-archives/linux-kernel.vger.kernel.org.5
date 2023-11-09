Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510387E66F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjKIJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKIJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:43:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D620271F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:43:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso601092a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699522995; x=1700127795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCWyDTFOKGrYpot7V/hX2yRpK+Z5vWvoNFrsFbdVsv0=;
        b=B6xqL+hwoL4oDY24Il/UQLaNo/w4pYCmNkKjIzKU0zpC0z0KEdc+cmJAOmDNaknign
         VOg7O4qqisrFi9iZOSDWDNXWERm/DWCTNjohHLK70IS+HKDCPtQ91H/L5KJK9sbj25ss
         6A14HwXItQURpqjOz7+U3Umy3U+GgwWyEjRFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699522995; x=1700127795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCWyDTFOKGrYpot7V/hX2yRpK+Z5vWvoNFrsFbdVsv0=;
        b=H7OQJQ+WyaVbmjorIe6xZObEr3xrsF88l8X6F6C0Vkk7WUPqUO3R5tRQOMmOVhh5nx
         cdkryoxv90eQD1eKfTblKTTBgddUvdClUjWLq69qwmfcVL1eq5smWiNQlDYM3iG/ZvIA
         JUUuZ9j9669vxdLtmyRqbidzE4LsszLN2H4kii4TKJ1ZEWnrMjcWP4W0uV0J5C9yfC4/
         Evu6dCVImUoAhOx4ZBMptrKhj7C1hOeode2rQVFM24nbvmaIzmFX1z4c64DvwB9gLiRH
         XhuoRkhyXtawLEQq9NuMkq+ySVgwaLhtMtYSIw11MMqaBMmHCInun8ZhEh9Pvm+eXHen
         cSnw==
X-Gm-Message-State: AOJu0YwNBEQIGBERVFOyQs2vflVh2MnpNBrniKc6huoqQyNSM1gfE+94
        +QFEHFAFVrmb5wQjCZp9D9MWhQ==
X-Google-Smtp-Source: AGHT+IHYEn5vCWOVKWVvobQ08zsd30PXF4KGgrclxpMN4A+BTWHHxdRtGwc4VhxQDlQqRAmCiOe3vQ==
X-Received: by 2002:a17:90b:4b4f:b0:280:a27d:e897 with SMTP id mi15-20020a17090b4b4f00b00280a27de897mr1185437pjb.8.1699522995680;
        Thu, 09 Nov 2023 01:43:15 -0800 (PST)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b0027d0adf653bsm986244pjd.7.2023.11.09.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:43:15 -0800 (PST)
Date:   Thu, 9 Nov 2023 09:43:11 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v14 56/56] media: test-drivers: Use helper for
 DELETE_BUFS ioctl
Message-ID: <20231109094311.yzmmn4vvskmrk4tk@chromium.org>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-57-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031163104.112469-57-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:31:04PM +0100, Benjamin Gaignard wrote:
> Allow test drivers to use DELETE_BUFS by adding vb2_ioctl_delete_bufs() helper.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/test-drivers/vicodec/vicodec-core.c |  2 ++
>  drivers/media/test-drivers/vimc/vimc-capture.c    |  2 ++
>  drivers/media/test-drivers/visl/visl-video.c      |  2 ++
>  drivers/media/test-drivers/vivid/vivid-core.c     | 13 ++++++++++---
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
> index 69cbe2c094e1..f14a8fd506d0 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -1339,6 +1339,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
>  	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
>  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
> +	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
>  
>  	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
>  	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
> @@ -1725,6 +1726,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
>  	dst_vq->mem_ops = &vb2_vmalloc_memops;
>  	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	dst_vq->lock = src_vq->lock;
> +	dst_vq->supports_delete_bufs = true;

Since we have to explicitly provide the vidioc_delete_bufs callback anyway,
is there any value in having a separate supports_delete_bufs flag? Or we
envision that some drivers would support deleting buffers only for some
queues?

Best regards,
Tomasz
