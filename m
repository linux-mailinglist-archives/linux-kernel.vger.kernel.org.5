Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDD7C680B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjJLIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjJLIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:19:58 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569B90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:19:56 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d13ac2796so2772486d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697098795; x=1697703595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt5Q0v/toQJvl1+/6R/c8eFR9P6J4uFEak9/i7kUUvU=;
        b=fMdt9Io9oEqiGjShKuYrDHvdC5Vsht3qwkRq7RhzUpbrnWnGZaUSROpuAv7bEYthS3
         N8oHEYzqpSYKZoHw5MVxD86QcgGItpPgblVYkNVBUvDSfnKc47i/GaQFh8G3dOgwvSzD
         I9qlBuY01jz0SnKCS352/pV/qQudOuFAuZ/x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697098795; x=1697703595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt5Q0v/toQJvl1+/6R/c8eFR9P6J4uFEak9/i7kUUvU=;
        b=AuIt8dmRZvWTPybeNOPLfOHQYSrrpLxZEATEzEM1/hlsT1rGOtPooDviyGueRw83Jp
         z+t1X3wFmAOVm5OxQY+pHozOqb6k2PorAx3Xn3rmTfBllA2xQ6MieFfY+YCFrDIaOZBr
         Q1KL6WH2fqgLV2fHh/CNKDGGNyWht0355qOnQD414YTdZbRe4Oh2o8mgcoYqGvO+qqBH
         dZVjvfhKHkkNOzh+8EAw0KtPqidVxH+k0cHNmV8OofjX/ntJBWdSRow9+nc8CUKGmIKo
         qFp8qEjoVJ5a6JD/m8zhu+Z2pfYtnJPRikBJ26n8p8DGBwMbcpafe1klHLX/0xsjXHmD
         8+KA==
X-Gm-Message-State: AOJu0YwBMbVPTV7GuGy/EuNnKQXs6aK8kNZlc5mqRagdbffTYB2Inyqm
        oIbOvSMaaKwcIHZFSe3DugyNeI8yTVPwO5WnbYMC4Q==
X-Google-Smtp-Source: AGHT+IH4kcQ1fxz5OLClU69tzkeLDibIZ4RXJbeMaLpb79Q59wGCMzWEq6NgMMqCsq0El350LXYD6Q==
X-Received: by 2002:a05:6214:5f07:b0:65b:229e:cb8a with SMTP id lx7-20020a0562145f0700b0065b229ecb8amr21167005qvb.44.1697098795506;
        Thu, 12 Oct 2023 01:19:55 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id lw14-20020a05621457ce00b0063f88855ef2sm364840qvb.101.2023.10.12.01.19.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:19:55 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77575531382so44465985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:19:55 -0700 (PDT)
X-Received: by 2002:ad4:5747:0:b0:66d:1b3c:ad6 with SMTP id
 q7-20020ad45747000000b0066d1b3c0ad6mr285645qvx.38.1697098794651; Thu, 12 Oct
 2023 01:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231012074519.597651-1-make_ruc2021@163.com>
In-Reply-To: <20231012074519.597651-1-make_ruc2021@163.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 12 Oct 2023 17:19:36 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DPD3CikrNibnrp+gqZQdmHkrHK5pmg1RsUHffv2gZTKw@mail.gmail.com>
Message-ID: <CAAFQd5DPD3CikrNibnrp+gqZQdmHkrHK5pmg1RsUHffv2gZTKw@mail.gmail.com>
Subject: Re: [PATCH v2] media: videobuf2: Fix IS_ERR checking in vb2_dc_put_userptr()
To:     Ma Ke <make_ruc2021@163.com>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 12, 2023 at 4:45=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
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
> index 2fa455d4a048..3d4fd4ef5310 100644
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
> +                               buf->dma_dir =3D=3D DMA_BIDIRECTIONAL) {
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

Thanks for fixing it up.

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
