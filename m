Return-Path: <linux-kernel+bounces-3245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E28169D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596F3B21A37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778BD11CA7;
	Mon, 18 Dec 2023 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4wkPxTm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36017101F0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a233a60f8feso136581766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702891498; x=1703496298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLu+cBh6WIZkpMvvSxJ1FksEywwC35seFJURn3v2r5A=;
        b=w4wkPxTmpEQADNuD1bAG6Az7L3SMrgeMTe2TGV3iJCR0k/jyKwKcDswAt6HoCQknF8
         Cui0u+t0BCrEGtu/+FGmTNgo4+iKAv4pjXOgCGmLCWb0DHNGJb3fQ7rz81+jI04Z/B0X
         kaw0qXvIYK1OHkIOrDhm92HK0opsHFUZiMZw990Un1SgNNqSePUVHV6kIRipMS4Kkz8i
         2E1m6aRrp1TvxGKt3XsCvdysdsJ8kNX9VYiv4t+atx/rE3HV+sZugw6NEj0KXboyDzOw
         sIUu3r8vAk5a72pEymjbl7hkFfB532Zd5Qefv1myrh+dWYu+MooR0Y8vb1Tofw9hyWUT
         l8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702891498; x=1703496298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLu+cBh6WIZkpMvvSxJ1FksEywwC35seFJURn3v2r5A=;
        b=qDueuFUj5Udjh8ysp6BTpa73rtkt4Na/wluGxXIUS4yFUmZrOjHhbLTfZmpaEdolxQ
         aNVos/kKWhNCbbP+GuRRUHJ0InmwXWuJOnYhpntKmNnSYB0Tw1+0wc/DYrg2ceQoZUU5
         LumeTZO1KmId4H3AYQJUYizqLHoeNyHMfeTfV9n6LTSj8unC/JUK2oH9bySy7hUELI23
         c3I8T+Sg8Ox1zSnMzBMOuXTdPU0l9gsfshKpab8eo+eFCploTptR25K7iiCp5S6tWfDY
         rrHa6sffR7P2Y6MR7h74ZlTjODAdFPPuCFy3pu56PLrjljUHqqMwEmAo9OiDbdR6Jkhf
         XpYw==
X-Gm-Message-State: AOJu0YyKJVL1172IqyEmB02W9Vvh5RxbSOs0V/4AlGw/E74tG/my9hth
	Afvn0FuRIRj3teQwyEJ9kUx+yvXIaUNuDIjsb6sq+Q==
X-Google-Smtp-Source: AGHT+IHCM+JEa3i7KdpJGIOdVJyelePou8FFaiQuBTEratIvDcGaSX2lKFYTit2fUBjLd2A21Q3pEgRecTFj8EqyTN4=
X-Received: by 2002:a17:906:42:b0:a23:195c:8aa7 with SMTP id
 2-20020a170906004200b00a23195c8aa7mr2422048ejg.15.1702891498140; Mon, 18 Dec
 2023 01:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com> <20231213-zswap-dstmem-v2-2-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-2-daa5d9ae41a7@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Dec 2023 01:24:20 -0800
Message-ID: <CAJD7tka3r=gPUDYYpFShUVzyynE0RyKd9Gsk-S8jcexr255_UQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm/zswap: reuse dstmem when decompress
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:22=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
> copy the entry->handle memory to a temporary memory, which is allocated
> using kmalloc.
>
> Obviously we can reuse the per-compressor dstmem to avoid allocating
> every time, since it's percpu-compressor and protected in percpu mutex.
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 44 ++++++++++++--------------------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 976f278aa507..6b872744e962 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1417,19 +1417,13 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct zpool *pool =3D zswap_find_zpool(entry);
>         bool page_was_allocated;
> -       u8 *src, *tmp =3D NULL;
> +       u8 *src;
>         unsigned int dlen;
>         int ret;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
>         };
>
> -       if (!zpool_can_sleep_mapped(pool)) {
> -               tmp =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> -               if (!tmp)
> -                       return -ENOMEM;
> -       }
> -
>         /* try to allocate swap cache page */
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> @@ -1465,15 +1459,15 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         /* decompress */
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>         dlen =3D PAGE_SIZE;
> +       mutex_lock(acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(pool)) {
> -               memcpy(tmp, src, entry->length);
> -               src =3D tmp;
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;
>                 zpool_unmap_handle(pool, entry->handle);
>         }
>
> -       mutex_lock(acomp_ctx->mutex);
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
> @@ -1482,9 +1476,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         dlen =3D acomp_ctx->req->dlen;
>         mutex_unlock(acomp_ctx->mutex);
>
> -       if (!zpool_can_sleep_mapped(pool))
> -               kfree(tmp);
> -       else
> +       if (zpool_can_sleep_mapped(pool))
>                 zpool_unmap_handle(pool, entry->handle);
>
>         BUG_ON(ret);
> @@ -1508,9 +1500,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         return ret;
>
>  fail:
> -       if (!zpool_can_sleep_mapped(pool))
> -               kfree(tmp);
> -
>         /*
>          * If we get here because the page is already in swapcache, a
>          * load may be happening concurrently. It is safe and okay to
> @@ -1771,7 +1760,7 @@ bool zswap_load(struct folio *folio)
>         struct zswap_entry *entry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src, *dst, *tmp;
> +       u8 *src, *dst;
>         struct zpool *zpool;
>         unsigned int dlen;
>         bool ret;
> @@ -1796,26 +1785,19 @@ bool zswap_load(struct folio *folio)
>         }
>
>         zpool =3D zswap_find_zpool(entry);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> -               if (!tmp) {
> -                       ret =3D false;
> -                       goto freeentry;
> -               }
> -       }
>
>         /* decompress */
>         dlen =3D PAGE_SIZE;
> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
>
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(tmp, src, entry->length);
> -               src =3D tmp;
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
> @@ -1826,15 +1808,13 @@ bool zswap_load(struct folio *folio)
>
>         if (zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
> -       else
> -               kfree(tmp);
>
>         ret =3D true;
>  stats:
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
> -freeentry:
> +
>         spin_lock(&tree->lock);
>         if (ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>
> --
> b4 0.10.1

