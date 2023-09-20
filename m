Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1377A7474
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjITHll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjITHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:41:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A997
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:41:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-773e8a62b05so78594585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695195691; x=1695800491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP+e5yTNMQ0UK6TWKcNmH7iV1dhFExt2WXPYDJ8BwIE=;
        b=MNNsePBDOCzn7X/8BK3suQssV+/TwpoQkcpxQrdoBHiuL26TYy+3/B9T/BRgtXNVry
         1wiTnEf8Zm1G5JryrXTKxC8mZej26x6RK3c+6uAPQNR4qUP8POMVAjAOwZjpNlvvwklR
         v/6+JRSIn2VWcf3S7g2LXmGJp65g3eGxxoERk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195691; x=1695800491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP+e5yTNMQ0UK6TWKcNmH7iV1dhFExt2WXPYDJ8BwIE=;
        b=Uoy2yRDtaa1Z40OFqXpPw4p8ZpDxr2PYMRX2rgb9S+GvHeD1FrHlJfSWjXbhYASjW9
         9/jDz6VVqas+0M4zeePEmw2gfiCdhu/EH7Gki5vpFXnrS+ctJ490egex5lFdbGhKoa2z
         v+9RjPkolz61g6ohWrB2oR2UJsqAxQ69xj3JigoZIDqRjsj6HDMXPnyyc9BvTlY8OdSj
         HmXRfxhFKsRo7N3cbN2Y46jiS31spoPEq2xLuASkI6xKdRCRd61ObGgNuTPg96WkpRgX
         wt0hFqd5892y2Sm6a9R8ZmH360869uZDhGgEEjWv2RFsXcP3SnZvpb1FVji639v+PqDF
         K6lQ==
X-Gm-Message-State: AOJu0YyBFeuaTTcih74+2AIGHwB9xVvlROnMvwwSx9kxhIQzc/ux1ke6
        kH9QYZBHwItArMwRY6qQB5mZgIlKf0p4kIqtdX0=
X-Google-Smtp-Source: AGHT+IH5C66KXpjquBmPwQmig21XNfajAOrZiOJ0pH2qkAfsG4RSyhLOGtsgjACCQwd2X8LEQ5uQLQ==
X-Received: by 2002:a0c:aa8d:0:b0:658:95e9:111d with SMTP id f13-20020a0caa8d000000b0065895e9111dmr124571qvb.12.1695195691088;
        Wed, 20 Sep 2023 00:41:31 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0064f741d2a97sm5074528qvd.40.2023.09.20.00.41.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 00:41:30 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-65631aa8b93so31000406d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:41:29 -0700 (PDT)
X-Received: by 2002:a0c:f8c9:0:b0:62f:f6ed:857e with SMTP id
 h9-20020a0cf8c9000000b0062ff6ed857emr1539387qvo.55.1695195688994; Wed, 20 Sep
 2023 00:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230914145812.12851-1-hui.fang@nxp.com>
In-Reply-To: <20230914145812.12851-1-hui.fang@nxp.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 20 Sep 2023 16:41:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
Message-ID: <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in vb2_dma_sg_alloc_compacted
To:     Fang Hui <hui.fang@nxp.com>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        anle.pan@nxp.com, xuegang.liu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fang,

On Thu, Sep 14, 2023 at 4:41=E2=80=AFPM Fang Hui <hui.fang@nxp.com> wrote:
>
> On system with "CONFIG_ZONE_DMA32=3Dy", if the allocated physical address=
 is

First of all, thanks a lot for the patch! Please check my review comments b=
elow.

Is CONFIG_ZONE_DMA32 really the factor that triggers the problem? My
understanding was that the problem was that the hardware has 32-bit
DMA, but the system has physical memory at addresses beyond the first
4G.

> greater than 4G, swiotlb will be used. It will lead below defects.
> 1) Impact performance due to an extra memcpy.
> 2) May meet below error due to swiotlb_max_mapping_size()
>    is 256K (IO_TLB_SIZE * IO_TLB_SEGSIZE).
> "swiotlb buffer is full (sz: 393216 bytes), total 65536 (slots),
> used 2358 (slots)"
>
> To avoid those defects, use dma_alloc_pages() instead of alloc_pages()
> in vb2_dma_sg_alloc_compacted().
>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Fang Hui <hui.fang@nxp.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>

Please remove MA-21654 from the subject and prefix it with the right
tags for the path (`git log drivers/media/common/videobuf2` should be
helpful to find the right one).

> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/=
media/common/videobuf2/videobuf2-dma-sg.c
> index 28f3fdfe23a2..b938582c68f4 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -58,7 +58,7 @@ struct vb2_dma_sg_buf {
>  static void vb2_dma_sg_put(void *buf_priv);
>
>  static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
> -               gfp_t gfp_flags)
> +               gfp_t gfp_flags, struct device *dev)

FWIW buf->dev already points to the right device - although we would
need to move the assignment in vb2_dma_sg_alloc() to a place higher in
that function before calling this function.

>  {
>         unsigned int last_page =3D 0;
>         unsigned long size =3D buf->size;
> @@ -67,6 +67,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg=
_buf *buf,
>                 struct page *pages;
>                 int order;
>                 int i;
> +               dma_addr_t dma_handle;
>
>                 order =3D get_order(size);
>                 /* Don't over allocate*/
> @@ -75,8 +76,9 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg=
_buf *buf,
>
>                 pages =3D NULL;
>                 while (!pages) {
> -                       pages =3D alloc_pages(GFP_KERNEL | __GFP_ZERO |
> -                                       __GFP_NOWARN | gfp_flags, order);
> +                       pages =3D dma_alloc_pages(dev, PAGE_SIZE << order=
, &dma_handle,

Hmm, when I was proposing dma_alloc_pages(), I missed that it returns
a DMA handle. That on its own can be handled by saving the returned
handles somewhere in struct vb2_dma_sg_buf, but there is a bigger
problem - the function would actually create a mapping if the DMA
device requires some mapping management (e.g. is behind an IOMMU),
which is undesirable, because we create the mapping ourselves below
anyway...

@Christoph Hellwig @Robin Murphy  I need your thoughts on this as
well. Would it make sense to have a variant of dma_alloc_pages() that
only allocates the pages, but doesn't perform the mapping? (Or a flag
that tells the implementation to skip creating a mapping.)

> +                               DMA_BIDIRECTIONAL,

The right value should be already available in buf->dma_dir.

> +                               GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | =
gfp_flags);
>                         if (pages)
>                                 break;
>
> @@ -96,6 +98,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg=
_buf *buf,
>         }
>
>         return 0;
> +

Unnecessary blank line.

>  }
>
>  static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
> @@ -130,7 +133,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, =
struct device *dev,
>         if (!buf->pages)
>                 goto fail_pages_array_alloc;
>
> -       ret =3D vb2_dma_sg_alloc_compacted(buf, vb->vb2_queue->gfp_flags)=
;
> +       ret =3D vb2_dma_sg_alloc_compacted(buf, vb->vb2_queue->gfp_flags,=
 dev);
>         if (ret)
>                 goto fail_pages_alloc;
>
> --
> 2.17.1
>

We also need to use dma_free_pages() to free the memory.

Best regards,
Tomasz
