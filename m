Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF955793829
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjIFJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIFJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:27:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDE1709
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:26:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-412989e3b7bso23108411cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693992413; x=1694597213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pCX1oZ3eFiSfNs1c5IHP1nlIw9t7N2mrZFK7pynm2s=;
        b=gEEoyx8SDrGQRE0BGSxsFwpQY2ykDQ/dEQcuKzq/+QYd0nWZCWaLbSibLrFGhx0XE3
         UMl47gO63aeTYZR3DmIh9STHcZUtQL12Bugo1v7aQOlV1X2HQRQcsQYf7OZEDSKyPpdp
         +7JXZU4Tse5kO7Rn7wIXXVwL4TJkXch39/lI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992413; x=1694597213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pCX1oZ3eFiSfNs1c5IHP1nlIw9t7N2mrZFK7pynm2s=;
        b=kF3X2pGoc7YKjq/qs6bYcjFpdjnZxGtTQwDRNV9Xic/0XBAfBjcuV2QN7jB2heRyb8
         44aWng19TzUDM5dvEfKSKst3fbzvZl4aKMIT8p7V1Ef/bd9GnIX8eeIqLYzaWh7/Er7T
         44MUFNyCdug6WrM4xg2nRGtleYGiqRF+Ko601oL3R+u67HSpDp6VwUPwi0q3Tc7qTzWQ
         ftZWMknpbEnF/CHDB0IsmRAHxzOH5uNI2gylCH1MXXp2bAJAluJGKt+sF8P3gbmssF3F
         NnuvHYexOYQ9ZJnOs7SjF9xqA+V8/lT/hUdSrGw3GefRupsKkYtMcfb+zBPZ1a6mMJim
         V/4A==
X-Gm-Message-State: AOJu0YwbXo79ZFsRP5PhX4MPnQM3Vwaa/XevyIN0xtSoBZjfnRdPEZtM
        /75rOar+/Pr34wRrVE4g5ve+q1qqzrL+1o9vOfYn4w==
X-Google-Smtp-Source: AGHT+IEUINw46ohU1ntoKhuUg3SbGFu8hQkvNwzdULJwd4xbfYWjfUO0e1F2DwnVwuo+mnUdvR8QCA==
X-Received: by 2002:a0c:f28a:0:b0:633:45e2:5603 with SMTP id k10-20020a0cf28a000000b0063345e25603mr16661705qvl.60.1693992412731;
        Wed, 06 Sep 2023 02:26:52 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce0cc000000b0063f7a2847bcsm5293572qvk.51.2023.09.06.02.26.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:26:52 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-64c5f5d6f04so20092056d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:26:51 -0700 (PDT)
X-Received: by 2002:a0c:f011:0:b0:61f:ace6:e94e with SMTP id
 z17-20020a0cf011000000b0061face6e94emr14122058qvk.0.1693992411459; Wed, 06
 Sep 2023 02:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com> <8085c44d-2c58-82c5-185b-2bde75a07044@xs4all.nl>
In-Reply-To: <8085c44d-2c58-82c5-185b-2bde75a07044@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 6 Sep 2023 18:26:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cmk7NP4RjQ2N54RVFpLhqY0wpRwbn2piSZkZJSvJi6hg@mail.gmail.com>
Message-ID: <CAAFQd5Cmk7NP4RjQ2N54RVFpLhqY0wpRwbn2piSZkZJSvJi6hg@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Robin Murphy <robin.murphy@arm.com>, Anle Pan <anle.pan@nxp.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 5:52=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> Hi all,
>
> On 29/08/2023 13:14, Robin Murphy wrote:
> > On 2023-08-29 11:03, Tomasz Figa wrote:
> >> Hi Anle,
> >>
> >> On Mon, Aug 28, 2023 at 8:57=E2=80=AFAM Anle Pan <anle.pan@nxp.com> wr=
ote:
> >>>
> >>> When allocating from pages, the size of the sg segment is unlimited a=
nd
> >>> the default is UINT_MAX. This will cause the DMA stream mapping faile=
d
> >>> later with a "swiotlb buffer full" error.
> >>
> >> Thanks for the patch. Good catch.
> >>
> >>> The default maximum mapping
> >>> size is 128 slots x 2K =3D 256K, determined by "IO_TLB_SEGSIZE".
> >>> To fix the issue, limit the sg segment size according to
> >>> "dma_max_mapping_size" to match the mapping limit.
> >>>
> >>> Signed-off-by: Anle Pan <anle.pan@nxp.com>
> >>> ---
> >>>   drivers/media/common/videobuf2/videobuf2-dma-sg.c | 9 +++++++--
> >>>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/driv=
ers/media/common/videobuf2/videobuf2-dma-sg.c
> >>> index fa69158a65b1..b608a7c5f240 100644
> >>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >>> @@ -105,6 +105,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *=
vb, struct device *dev,
> >>>          struct sg_table *sgt;
> >>>          int ret;
> >>>          int num_pages;
> >>> +       size_t max_segment =3D 0;
> >>>
> >>>          if (WARN_ON(!dev) || WARN_ON(!size))
> >>>                  return ERR_PTR(-EINVAL);
> >>> @@ -134,8 +135,12 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer =
*vb, struct device *dev,
> >>>          if (ret)
> >>>                  goto fail_pages_alloc;
> >>>
> >>> -       ret =3D sg_alloc_table_from_pages(buf->dma_sgt, buf->pages,
> >>> -                       buf->num_pages, 0, size, GFP_KERNEL);
> >>> +       if (dev)
> >
> > dev can't be NULL, see the context above.
> >
> >>> +               max_segment =3D dma_max_mapping_size(dev);
> >>> +       if (max_segment =3D=3D 0)
> >>> +               max_segment =3D UINT_MAX;
> >>> +       ret =3D sg_alloc_table_from_pages_segment(buf->dma_sgt, buf->=
pages,
> >>> +               buf->num_pages, 0, size, max_segment, GFP_KERNEL);
> >>
> >> One thing that I'm not sure about here is that we use
> >> sg_alloc_table_from_pages_segment(), but we actually don't pass the
> >> max segment size (as returned by dma_get_max_seg_size()) to it.
> >> I'm also not exactly sure what's the difference between "max mapping
> >> size" and "max seg size".
> >> +Robin Murphy +Christoph Hellwig I think we could benefit from your
> >> expertise here.
> >
> > dma_get_max_seg_size() represents a capability of the device itself, na=
mely the largest contiguous range it can be programmed to access in a singl=
e DMA descriptor/register/whatever. Conversely,
> > dma_max_mapping_size() is a capablity of the DMA API implementation, an=
d represents the largest contiguous mapping it is guaranteed to be able to =
handle (each segment in the case of dma_map_sg(), or
> > the whole thing for dma_map_page()). Most likely the thing you want her=
e is min_not_zero(max_seg_size, max_mapping_size).
> >
> >> Generally looking at videobuf2-dma-sg, I feel like we would benefit
> >> from some kind of dma_alloc_table_from_pages() that simply takes the
> >> struct dev pointer and does everything necessary.
> >
> > Possibly; this code already looks lifted from drm_prime_pages_to_sg(), =
and if it's needed here then presumably vb2_dma_sg_get_userptr() also needs=
 it, at the very least.
>
> I also see sg_alloc_table_from_pages being called in vb2_dc_get_userptr i=
n videobuf2-dma-contig.c,
> presumably that needs the same fix?
>
> From what I gather from this thread there are no improved helpers on the =
immediate
> horizon, so this issue has to be fixed in videobuf2 for now.

Agreed. (Although I suspect the real issue that NXP is having isn't
really this and this is just a side effect.)

>
> So this requires a v2 that fixes this also in vb2_dma_sg_get_userptr and =
vb2_dc_get_userptr,
> correct? If so, then it would be nice if Anle can post a v2 with those ch=
anges.

If we need to fix 3 different callers, could we at least add an
internal vb2 helper for this (e.g. vb2_asg_alloc_table_from_pages())?

>
> Note that when I grepped for sg_alloc_table_from_pages_segment users, I n=
oticed that
> in most cases dma_max_mapping_size is used, but in one case it uses dma_g=
et_max_seg_size
> (drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c). I have no idea what the dif=
ference is
> between the two.

FWIW, Robin explained that earlier in the thread. To be fully correct,
we need to consider both...

>
> One small change that would make sg_alloc_table_from_pages_segment() a bi=
t easier
> to work with is if it would replace a max_segment value of 0 with UINT_MA=
X. Then
> you can just stick in dma_max_mapping_size(dev) as the argument.
>
> Alternatively, if we can be certain that dma_max_mapping_size(dev) never =
returns 0,
> then that 'if (max_segment =3D=3D 0)' part can just be dropped.

That's also the reason I wanted a helper. Not sure if it's so easy to
change the calling convention now.

>
> I also wonder if any of the other (non-media) users of sg_alloc_table_fro=
m_pages
> would need to use sg_alloc_table_from_pages_segment as well. Is this real=
ly
> media specific? Or is media just the most likely subsystem to hit this is=
sue due
> to the large amounts of memory it uses?

I don't think it's media-specific, but also as I said earlier, it
should be really rare to hit it - swiotlb isn't normally expected for
reasonably capable systems and buffer allocation being done correctly.

Best regards,
Tomasz
