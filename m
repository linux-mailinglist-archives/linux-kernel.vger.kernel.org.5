Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990378C1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjH2KDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjH2KDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:03:22 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60AB4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:03:19 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bbb4bde76dso2789938fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693303398; x=1693908198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLWqkTlNXuRNXbpkTdz35i9a7RBHR+eFx1IjM/IAypg=;
        b=LdCMcbSsZ3UvW8tljVi3UYEYPSPI3Bew8q6SSIOdgpfPDu3meW0/W5+Ove7WSddYDL
         CewHmiAHxoacy8hoxqnLXGc95BR03EWAWibLuwrffvQVITvYUbTz9auDy5tuv0pPNYha
         bjTrFjDB951+U+zWooqc1/XIlj6lmb7my++5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303398; x=1693908198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLWqkTlNXuRNXbpkTdz35i9a7RBHR+eFx1IjM/IAypg=;
        b=RaUSxloozmYZjPc5HZ5kOE55LnZH0Fmh2o1xl76zCqFWUEDo9UsX7lgG9vINPjKX0M
         tHz5r4hS0AQDxziGEvp+Fxtm1q6gKzSo48fjXW/i67m2Q+waG6BjGJLA8FrZIicz0VUz
         lfVdBQJk2YTmJSHlmsuegZQE9ZW2DtUCTtGA7zL4G37fhH3DLSuAEpNn0XVoy/sP6QJS
         iVKw1sSSPCjP5uUtsCs8Do1AMKGYUMHiK50DBPdXnVKV0YJH307adY8Dtj8BNHSUUzr+
         oPK1pyn6lD4Z7Li10INa6FSKAza0BRQ7+3DyAoR+bjlUJfTZhpn+koPdYvwYWICW6KXu
         5sQg==
X-Gm-Message-State: AOJu0YzP5QD6hmtm43r5LzBkDIAUH6Taw1BbCagMk7bmb9nZhfDjUAzV
        rtm/3LKPfNZXrxg0xNNlPP3a956rtasJUHoIQJE=
X-Google-Smtp-Source: AGHT+IGhqVRy4qTPpsprTKNecL1pK8N3NwJn9qhw7+9XF/s8YL+zOpK0RB0tSIB2h6Mi+tGM4+3/bw==
X-Received: by 2002:a05:6870:a687:b0:1b7:4a32:4ac6 with SMTP id i7-20020a056870a68700b001b74a324ac6mr15355098oam.31.1693303398138;
        Tue, 29 Aug 2023 03:03:18 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id kr2-20020a0568719ec200b001b390c6e00bsm5291335oac.56.2023.08.29.03.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:03:17 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a76d882052so3086934b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:03:17 -0700 (PDT)
X-Received: by 2002:a05:6808:2022:b0:3a8:5133:483b with SMTP id
 q34-20020a056808202200b003a85133483bmr15064159oiw.31.1693303396856; Tue, 29
 Aug 2023 03:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com>
In-Reply-To: <20230828075420.2009568-1-anle.pan@nxp.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 29 Aug 2023 19:03:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
Message-ID: <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Anle Pan <anle.pan@nxp.com>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hui.fang@nxp.com
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

Hi Anle,

On Mon, Aug 28, 2023 at 8:57=E2=80=AFAM Anle Pan <anle.pan@nxp.com> wrote:
>
> When allocating from pages, the size of the sg segment is unlimited and
> the default is UINT_MAX. This will cause the DMA stream mapping failed
> later with a "swiotlb buffer full" error.

Thanks for the patch. Good catch.

> The default maximum mapping
> size is 128 slots x 2K =3D 256K, determined by "IO_TLB_SEGSIZE".
> To fix the issue, limit the sg segment size according to
> "dma_max_mapping_size" to match the mapping limit.
>
> Signed-off-by: Anle Pan <anle.pan@nxp.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/=
media/common/videobuf2/videobuf2-dma-sg.c
> index fa69158a65b1..b608a7c5f240 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -105,6 +105,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, =
struct device *dev,
>         struct sg_table *sgt;
>         int ret;
>         int num_pages;
> +       size_t max_segment =3D 0;
>
>         if (WARN_ON(!dev) || WARN_ON(!size))
>                 return ERR_PTR(-EINVAL);
> @@ -134,8 +135,12 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb,=
 struct device *dev,
>         if (ret)
>                 goto fail_pages_alloc;
>
> -       ret =3D sg_alloc_table_from_pages(buf->dma_sgt, buf->pages,
> -                       buf->num_pages, 0, size, GFP_KERNEL);
> +       if (dev)
> +               max_segment =3D dma_max_mapping_size(dev);
> +       if (max_segment =3D=3D 0)
> +               max_segment =3D UINT_MAX;
> +       ret =3D sg_alloc_table_from_pages_segment(buf->dma_sgt, buf->page=
s,
> +               buf->num_pages, 0, size, max_segment, GFP_KERNEL);

One thing that I'm not sure about here is that we use
sg_alloc_table_from_pages_segment(), but we actually don't pass the
max segment size (as returned by dma_get_max_seg_size()) to it.
I'm also not exactly sure what's the difference between "max mapping
size" and "max seg size".
+Robin Murphy +Christoph Hellwig I think we could benefit from your
expertise here.

Generally looking at videobuf2-dma-sg, I feel like we would benefit
from some kind of dma_alloc_table_from_pages() that simply takes the
struct dev pointer and does everything necessary.

Best regards,
Tomasz
