Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA477C6554
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377361AbjJLGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347070AbjJLGTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:19:40 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19CDD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:19:38 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ab68ef45e7so260927241.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697091577; x=1697696377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLM4xkY5G5L1mZIDRFqUS5SrNnKzFAKa0pa3/SYT/44=;
        b=ckujpouajMNNKZmCQ7fTW4KB+6vy74LUt4oWzW0chCUTMQAWQQwtF4D2WFbgZ6v7g5
         +za6D7ye1H+4xGHDEWxpE1yxgxWkmNsUaNSim/LA86g4BHSq2BC+1NxrI5XbSif/S4dC
         7IIhluTBEWu1ikQ8+rgpLUrhfv27y4JyibDWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091577; x=1697696377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLM4xkY5G5L1mZIDRFqUS5SrNnKzFAKa0pa3/SYT/44=;
        b=c9HoUdI9FxHwwTcNDmJ60v2wa67vyiMeQL4hSdoYAowJHHUVLpM17ob4+hPOr/Ij88
         N0T6RVKNvTkkROLSBuW4ngYbb+HcYrqOPGM1hNSFBwIZ+Hik9Kxg5ukEwepmB+kZAc5w
         q0U1gx0eRTelZWNp52U+gMTn3LBPrSgxwEpjE+vl8Olj/udzYrKh7fAal87VBce3Yecw
         srYjK0GvhndZpchCUaRqe1awaSJ9j0x90gPkij9wwVEbdtxa3rwVkEbHHjGuBte5yiMD
         V5aLmMPwP54RIYw82mKouH0tS3yjP4gUw6OMC+/uk/V3LIrdsR53As8MM4JJ4okSm6vJ
         olmw==
X-Gm-Message-State: AOJu0Yy07D9CcBW4T+LqEI79/36JkHtboawnrzNkGXBScq0ez8ewQTwF
        fkyXQkOy9ynYY7EJzVdkFz7872hYPDXFuFVFiQYsHw==
X-Google-Smtp-Source: AGHT+IFB1CtuFsLSbYDuPnbQsj71az8sm43JujSFb5anNnOsOoBUaLY+Oi683Xnlfr5Zs+PJZoIaAw==
X-Received: by 2002:a67:f6c3:0:b0:452:9356:ab4e with SMTP id v3-20020a67f6c3000000b004529356ab4emr16157074vso.25.1697091576858;
        Wed, 11 Oct 2023 23:19:36 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id g18-20020a056102159200b004528fa64473sm290529vsv.31.2023.10.11.23.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 23:19:36 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7b5fd0b7522so270392241.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:19:36 -0700 (PDT)
X-Received: by 2002:a1f:c305:0:b0:49a:b737:4df7 with SMTP id
 t5-20020a1fc305000000b0049ab7374df7mr17368863vkf.5.1697091575791; Wed, 11 Oct
 2023 23:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231003092329.3919828-1-make_ruc2021@163.com>
In-Reply-To: <20231003092329.3919828-1-make_ruc2021@163.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 12 Oct 2023 15:19:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AgK0ZmOABxnvtUHLJ7nPzPL7cZp_ezUifpSJWEDVFHWQ@mail.gmail.com>
Message-ID: <CAAFQd5AgK0ZmOABxnvtUHLJ7nPzPL7cZp_ezUifpSJWEDVFHWQ@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: Fix IS_ERR checking in vb2_dc_put_userptr()
To:     Ma Ke <make_ruc2021@163.com>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 3, 2023 at 6:23=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> In order to avoid error pointers from frame_vector_pages(), we could
> use IS_ERR() to check the return value to fix this. This checking
> operation could make sure that vector contains pages.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  .../media/common/videobuf2/videobuf2-dma-contig.c   | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/driv=
ers/media/common/videobuf2/videobuf2-dma-contig.c
> index 2fa455d4a048..5001f2a258dd 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -542,13 +542,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
>                  */
>                 dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
>                                   DMA_ATTR_SKIP_CPU_SYNC);
> -               pages =3D frame_vector_pages(buf->vec);
> -               /* sgt should exist only if vector contains pages... */
> -               BUG_ON(IS_ERR(pages));
>                 if (buf->dma_dir =3D=3D DMA_FROM_DEVICE ||
> -                   buf->dma_dir =3D=3D DMA_BIDIRECTIONAL)
> -                       for (i =3D 0; i < frame_vector_count(buf->vec); i=
++)
> -                               set_page_dirty_lock(pages[i]);
> +                   buf->dma_dir =3D=3D DMA_BIDIRECTIONAL){

Missing space between ) and { .

Otherwise:

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

> +                       pages =3D frame_vector_pages(buf->vec);
> +                       /* sgt should exist only if vector contains pages=
... */
> +                       if (!WARN_ON_ONCE(IS_ERR(pages)))
> +                               for (i =3D 0; i < frame_vector_count(buf-=
>vec); i++)
> +                                       set_page_dirty_lock(pages[i]);
> +               }
>                 sg_free_table(sgt);
>                 kfree(sgt);
>         } else {
> --
> 2.37.2
>
