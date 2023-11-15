Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD157ED84F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjKOXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjKOXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:45:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9161B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:45:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc411be7e5so25695ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700091942; x=1700696742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIH2dT5rBnZFjhKTkiDOQvxWWMxsCvDK0b0vzyQ0+X8=;
        b=NKxxqgsiQH2IDHPVm0sTRwOKQMSN8I8yMg1G1hPQ1fFBDYD1GLq/eM7om3nW+FMBKD
         m5RiE8HRh2LJKrfsyiUxlpfEGGuFXK/JDxtcyO9Hd8+DkPufNmwqBiHmhRo23ExmgSjA
         4pmwiDUHNOfWUgj3LXe3m7ZLOqcdKo1HQyWivMlxW/a+mF8qH70CRUxd7AXk/BmjeslX
         7mJsrObmsJ6LxADzpfpnNyP7IiSCI9aoJUYMnvWQX8BJJLyb2LPOp7hmv+2edKiQJ+T3
         DlGwX9rlajocDTIPfhbKC0Ch4svzdDl+WCR+xTUVr7JNdlhmtmB9J8GEKy917MJxyWYc
         r5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700091942; x=1700696742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIH2dT5rBnZFjhKTkiDOQvxWWMxsCvDK0b0vzyQ0+X8=;
        b=Ylr1nIWyXleyFqjhgATwejAOMkJ6Erxi5rP1pGb6juS03nLmUfJ9GDwF5nHe/KDZ5h
         2wZ5YY1+2VoBFyhI8DkM24W9L8mUZw8IDlH6CIjQJuhslkpqkYSHMmgxt3MnVH7W8i7f
         19ktyebysFAtRSUaf0VLRRUoSsLb+bOnc/15aKNTo1dh3rdSMRs3fi76hPrBWVQxQWlm
         jCFdfDoJg9dCtTQDSDy8Sct5Magn5vtvGAUqsqLYmQFFzBIVelLW/4LOgN6vDVTN8p7t
         XHBlgH+LEM0TBF4yBUf2lnAymaHu1ZVVhHNlzGKstQOW/bzwARzsK9NTvKH06nNmQ7v5
         81TQ==
X-Gm-Message-State: AOJu0Yzyyum01JdLmD39EoRAw87I1cCB//+2Nf3crypoPSII1njm+xwi
        +Pr5d1MdpHYiNSo4ISq53KrQDbK8ZfX+UT8/8k88
X-Google-Smtp-Source: AGHT+IFvaq+a3HVgNlcWB8G0UvgbXEFSxTfLrN/9hWim6vKKnIqWcSHLeWYNY3t7rR2xLuNg/XZcLVowUmtLGfVqu6Q=
X-Received: by 2002:a17:902:db0b:b0:1c2:446:5259 with SMTP id
 m11-20020a170902db0b00b001c204465259mr67088plx.19.1700091941779; Wed, 15 Nov
 2023 15:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20231111111559.8218-1-yong.wu@mediatek.com> <20231111111559.8218-9-yong.wu@mediatek.com>
In-Reply-To: <20231111111559.8218-9-yong.wu@mediatek.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 15 Nov 2023 15:45:30 -0800
Message-ID: <CA+ddPcNLbyS1WRANo7fm13pYyibD_DS3uAxc6ouULWS+kBxNHQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] dma-buf: heaps: secure_heap: Add normal CMA heap
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should drop this patch completely.

On Sat, Nov 11, 2023 at 3:18=E2=80=AFAM Yong Wu <yong.wu@mediatek.com> wrot=
e:
>
> Add a normal CMA heap which use the standard cma allocate.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Vijay and Jaskaran,
>
> For this heap,
> 1) It uses sec_heap_buf_ops currently. I guess we cann't use the
> cma_heap_buf_ops. since if it is secure buffer, some operations such
> as mmap should not be allowed.
> 2) I didn't add how to protect/secure the buffer.
>
> Please feel free to change to meet your requirements.
> Thanks.
> ---
>  drivers/dma-buf/heaps/secure_heap.c | 38 ++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/=
secure_heap.c
> index f8b84fd16288..8989ad5d03e9 100644
> --- a/drivers/dma-buf/heaps/secure_heap.c
> +++ b/drivers/dma-buf/heaps/secure_heap.c
> @@ -43,6 +43,8 @@ enum secure_buffer_tee_cmd { /* PARAM NUM always is 4. =
*/
>  };
>
>  enum secure_memory_type {
> +       /* CMA for the secure memory, Use the normal cma ops to alloc/fre=
e. */
> +       SECURE_MEMORY_TYPE_CMA          =3D 0,
>         /*
>          * MediaTek static chunk memory carved out for TrustZone. The mem=
ory
>          * management is inside the TEE.
> @@ -65,6 +67,7 @@ struct secure_buffer {
>          * a value got from TEE.
>          */
>         u32                             sec_handle;
> +       struct page                     *cma_page;
>  };
>
>  #define TEE_MEM_COMMAND_ID_BASE_MTK    0x10000
> @@ -287,6 +290,33 @@ const struct secure_heap_prv_data mtk_sec_mem_data =
=3D {
>         .unsecure_the_memory    =3D secure_heap_tee_unsecure_memory,
>  };
>
> +static int cma_secure_memory_allocate(struct secure_heap *sec_heap,
> +                                     struct secure_buffer *sec_buf)
> +{
> +       if (!sec_heap->cma)
> +               return -EINVAL;
> +
> +       sec_buf->cma_page =3D cma_alloc(sec_heap->cma, sec_buf->size >> P=
AGE_SHIFT,
> +                                     get_order(PAGE_SIZE), false);
> +       if (!sec_buf->cma_page)
> +               return -ENOMEM;
> +
> +       memset(page_address(sec_buf->cma_page), 0, sec_buf->size);
> +       return 0;
> +}
> +
> +static void cma_secure_memory_free(struct secure_heap *sec_heap,
> +                                  struct secure_buffer *sec_buf)
> +{
> +       cma_release(sec_heap->cma, sec_buf->cma_page, sec_buf->size >> PA=
GE_SHIFT);
> +}
> +
> +const struct secure_heap_prv_data cma_sec_mem_data =3D {
> +       .memory_alloc   =3D cma_secure_memory_allocate,
> +       .memory_free    =3D cma_secure_memory_free,
> +       /* TODO : secure the buffer. */
> +};
> +
>  static int secure_heap_secure_memory_allocate(struct secure_heap *sec_he=
ap,
>                                               struct secure_buffer *sec_b=
uf)
>  {
> @@ -496,6 +526,11 @@ static const struct dma_heap_ops sec_heap_ops =3D {
>  };
>
>  static struct secure_heap secure_heaps[] =3D {
> +       {
> +               .name           =3D "secure_cma",
> +               .mem_type       =3D SECURE_MEMORY_TYPE_CMA,
> +               .data           =3D &cma_sec_mem_data,
> +       },
>         {
>                 .name           =3D "secure_mtk_cm",
>                 .mem_type       =3D SECURE_MEMORY_TYPE_MTK_CM_TZ,
> @@ -522,7 +557,8 @@ static int __init secure_cma_init(struct reserved_mem=
 *rmem)
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(secure_heaps); i++, sec_heap++) {
> -               if (sec_heap->mem_type !=3D SECURE_MEMORY_TYPE_MTK_CM_CMA=
)
> +               if (sec_heap->mem_type !=3D SECURE_MEMORY_TYPE_MTK_CM_CMA=
 &&
> +                   sec_heap->mem_type !=3D SECURE_MEMORY_TYPE_CMA)
>                         continue;
>
>                 sec_heap->cma =3D sec_cma;
> --
> 2.25.1
>
