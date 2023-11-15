Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A97ED808
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjKOXSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:18:48 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C512618A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:18:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc30de471dso61295ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700090324; x=1700695124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cDX2/TcLZZv47keVH9izOB2UPw4wXcT8INdh+8le7A=;
        b=FC7t38K75g8lhQh4y09fpGMdAlJXSt1aM9rMOfFsyrTZR4DEk9Hh/9bYlx+J6cAXLz
         qmRCOF9dibmNHJqZ9u2mQTD0ge/pVaCWOyipJQ+/ew+jjDIteod3s0ttbQQzbpfqNrEl
         FlChnLSxf+2bwE4BAyzEnRf5LFocB3PMFlKqhMlsT4P5XLEQIQu+DP6rQhyegLTSSlqp
         C+5YZ3iK9F3vy5VquYLinQPIHGxv23ju76VcuUqdeVEjTaOsDAw6WGYXLC9WbQCTYN2I
         WT22g54scfIrLbgktRVtm7/591lyAY8g7en5dLsxgO8stZFfBCLYU8hrnG4jxMfXZZ7l
         rWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700090324; x=1700695124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cDX2/TcLZZv47keVH9izOB2UPw4wXcT8INdh+8le7A=;
        b=C0cnN4aDkyo/Gr0lBEzaJllvSWG/BK1o/B7CwQLjLUoUSiIwb+10ULn3Oms2mr0d5x
         vZp6X4aHZHpHHG4YRu8ZEMPKWVra70E+bNuZTJP7Mk0vxsGoikW1SZ6Ug4aUXCNoAftC
         0kVI+YWFWu3cNMM3zt+3sN7sDUmjIpXG73scjEBKvVMj43pEYvu1gD0cHmhGWASyHOi+
         wBL6X9p0vUdEXDaGHzdBr+x/cU50V8oFi1WvZzdnTTmdi8M41N6mpK5IZVfTjRVgGhne
         KqkHemGYeVmg8JvCvkVU6L3cDxIiqKZ0cNSr6PkCF7rABd9SGkkqlKruw/zBRdOJFxPX
         OU1A==
X-Gm-Message-State: AOJu0Yy4taJC7wheWZ2IikASsFcHHxq53YE5ryq9w++gbrn8i6qJ99rv
        dr+LACgaFH0xQI+4Dx5d7GW/t1XqRcVS7meN7Eku0cQcikrNcyBwf7fN
X-Google-Smtp-Source: AGHT+IGyoRxZw5ygDqLDB76eixVmV7Sl9Rg99pJFDrY1646vTJd9/k/9IdlRgQQs8vDIsMVb3PqED09pUEuJwebdqxU=
X-Received: by 2002:a17:902:d50f:b0:1cc:ff0:213f with SMTP id
 b15-20020a170902d50f00b001cc0ff0213fmr66975plg.2.1700090323863; Wed, 15 Nov
 2023 15:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20231111111559.8218-1-yong.wu@mediatek.com> <20231111111559.8218-2-yong.wu@mediatek.com>
In-Reply-To: <20231111111559.8218-2-yong.wu@mediatek.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 15 Nov 2023 15:18:32 -0800
Message-ID: <CA+ddPcMQan85Q8KDdDub=aDe0HB3vy9dBj33ofEoM2WUhFu8Zw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dma-buf: heaps: Initialize a secure heap
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 3:16=E2=80=AFAM Yong Wu <yong.wu@mediatek.com> wrot=
e:
>
> Initialize a secure heap. Currently just add a null heap, Prepare for
> the later patches.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/dma-buf/heaps/Kconfig       |  7 +++
>  drivers/dma-buf/heaps/Makefile      |  1 +
>  drivers/dma-buf/heaps/secure_heap.c | 98 +++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/secure_heap.c
>
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> index a5eef06c4226..e358bf711145 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -12,3 +12,10 @@ config DMABUF_HEAPS_CMA
>           Choose this option to enable dma-buf CMA heap. This heap is bac=
ked
>           by the Contiguous Memory Allocator (CMA). If your system has th=
ese
>           regions, you should say Y here.
> +
> +config DMABUF_HEAPS_SECURE
> +       bool "DMA-BUF Secure Heap"
> +       depends on DMABUF_HEAPS && TEE
> +       help
> +         Choose this option to enable dma-buf secure heap. This heap is =
backed by
> +         TEE client interfaces or CMA. If in doubt, say N.

Remove the mention of TEE and CMA from this.

You should probably add two KConfig options. One is for
DMABUF_HEAPS_SECURE which is for the framework for secure heaps. The
other one should be:

config MTK_DMABUF_HEAPS_SECURE
    bool "Mediatek DMA-BUF Secure Heap"
    depends on DMABUF_HEAPS_SECURE && TEE
    help
        Enables secure dma-buf heaps for Mediatek platforms.


> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makef=
ile
> index 974467791032..b1ad9d1f2fbe 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_DMABUF_HEAPS_SECURE)      +=3D secure_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_CMA)         +=3D cma_heap.o
> diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/=
secure_heap.c
> new file mode 100644
> index 000000000000..a634051a0a67
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/secure_heap.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF secure heap exporter
> + *
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +enum secure_memory_type {
> +       /*
> +        * MediaTek static chunk memory carved out for TrustZone. The mem=
ory
> +        * management is inside the TEE.
> +        */
> +       SECURE_MEMORY_TYPE_MTK_CM_TZ    =3D 1,

Mediatek specific code for secure dma heaps should go into a new file
(maybe secure_heap_mtk.c which the MTK_DMABUF_HEAPS_SECURE option
enables).

> +};
> +
> +struct secure_buffer {
> +       struct dma_heap                 *heap;
> +       size_t                          size;
> +};
> +
> +struct secure_heap {
> +       const char                      *name;
> +       const enum secure_memory_type   mem_type;
secure_memory_type is going to be in the vendor specific
implementation, I don't think you need it in the framework.

> +};

You should probably move these to a <linux/dma-heap-secure.h> file so
they can be shared by the framework and the specific implementation
(in this case vendor specific).

> +
> +static struct dma_buf *
> +secure_heap_allocate(struct dma_heap *heap, unsigned long size,
> +                    unsigned long fd_flags, unsigned long heap_flags)
> +{
> +       struct secure_buffer *sec_buf;
> +       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +       struct dma_buf *dmabuf;
> +       int ret;
> +
> +       sec_buf =3D kzalloc(sizeof(*sec_buf), GFP_KERNEL);
> +       if (!sec_buf)
> +               return ERR_PTR(-ENOMEM);
> +
> +       sec_buf->size =3D ALIGN(size, PAGE_SIZE);
> +       sec_buf->heap =3D heap;
> +
> +       exp_info.exp_name =3D dma_heap_get_name(heap);
> +       exp_info.size =3D sec_buf->size;
> +       exp_info.flags =3D fd_flags;
> +       exp_info.priv =3D sec_buf;
> +
> +       dmabuf =3D dma_buf_export(&exp_info);
> +       if (IS_ERR(dmabuf)) {
> +               ret =3D PTR_ERR(dmabuf);
> +               goto err_free_buf;
> +       }
> +
> +       return dmabuf;
> +
> +err_free_buf:
> +       kfree(sec_buf);
> +       return ERR_PTR(ret);
> +}
> +
> +static const struct dma_heap_ops sec_heap_ops =3D {
> +       .allocate =3D secure_heap_allocate,
> +};
> +
> +static struct secure_heap secure_heaps[] =3D {
> +       {
> +               .name           =3D "secure_mtk_cm",
> +               .mem_type       =3D SECURE_MEMORY_TYPE_MTK_CM_TZ,
> +       },
> +};

Move this to the vendor specific implementation.

> +
> +static int secure_heap_init(void)
> +{
> +       struct secure_heap *sec_heap =3D secure_heaps;
> +       struct dma_heap_export_info exp_info;
> +       struct dma_heap *heap;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(secure_heaps); i++, sec_heap++) {
> +               exp_info.name =3D sec_heap->name;
> +               exp_info.ops =3D &sec_heap_ops;
> +               exp_info.priv =3D (void *)sec_heap;
> +
> +               heap =3D dma_heap_add(&exp_info);
> +               if (IS_ERR(heap))
> +                       return PTR_ERR(heap);
> +       }
> +       return 0;
> +}

secure_heap_init should take a 'struct secure_heap*' as an argument
and be defined in dma-heap-secure.h.

> +
> +module_init(secure_heap_init);
> +MODULE_DESCRIPTION("Secure Heap Driver");
> +MODULE_LICENSE("GPL");

Remove from this file, it should go in the specific implementations.

> --
> 2.25.1
>
