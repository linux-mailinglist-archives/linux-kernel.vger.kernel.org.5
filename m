Return-Path: <linux-kernel+bounces-11760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFA81EB46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633BE1F218AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968F442F;
	Wed, 27 Dec 2023 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clBnt+NX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD35440E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78154d66311so95479085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703640292; x=1704245092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfuCt8I3FTyO4PHh22WUCv8PJBxImS7SQ55iEqCIIY0=;
        b=clBnt+NXfIe7JBzx2ghaaJvnRNpYywhjSybLM58cz2o1ipzP7sdVWpyvu11v17is+E
         mW/TNCLP0sAUSLsb9iGImf2XCt4MTQ5FA+8mbGrjrBBSKLu9LRcYqr3ODZsA9jXPcFtR
         agag8uzUOBAPL1ezTE/BzsKZxtlG914HL0+fYR28I5dQkkPvCfJspcNfhEZyJJpQBox6
         vaZYRNBuN4hxC74JEiPGroG3LezzMFhVgsBQCu1y256ZcD7mZPa0RjF64JHkY7i7qjxi
         rwcgRObnEuRq9kmZ0zBETrojkobc425WksdQAXmZjR63FQfuWhM8nfQhod/61tJVul8w
         44mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703640292; x=1704245092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfuCt8I3FTyO4PHh22WUCv8PJBxImS7SQ55iEqCIIY0=;
        b=fV0Y9KfQIHgQ/r9P61xGfSFLqAoANWnuxoX4iDZt70w42kVuB5gvVcXEsXwXCHWrQO
         FAn6n2UuQ7Fw5yZ0rfZpjZRvOhyanNfhNqeRAtSYC0RjAPiV/hIMXT/Hfco+IlpF4u88
         9KXjm2gvC9oODmBoFJzPVIeI7Hm5t2sk+Y+g2ZJ8gHu9gmVhJMUYxXc1InamXG6hhfR9
         DTZC8aWjHGY1q7q2pQGnh8C3FIE/x8zQIfb+hduSCaYUTk8gn90QhllNmYmET1I90JbK
         ao1WKazEOVXNl/cr4EOvwOIfRSJnL9wuAaWWFgXmQww4mJJNFgWH+ddso1K7M9BZ6mpO
         8LPw==
X-Gm-Message-State: AOJu0Yy5xgC2Ixhv2azE6BcclOf7siRnEVPcjeaEk5XIOgu39dgLQpAq
	if950H7vSBV6g+HjtEiBKvF19fOvdpn+ry+1oZk=
X-Google-Smtp-Source: AGHT+IG6fIvxb1VMwVtohs5cdNlNMamULfjTF0tOTE0r0M0heVXZYXhVV8YDBRbw5vRZaGTcOuxSypUo29Hnrxg/BSY=
X-Received: by 2002:a05:620a:66d:b0:781:58df:3743 with SMTP id
 a13-20020a05620a066d00b0078158df3743mr1309493qkh.0.1703640292241; Tue, 26 Dec
 2023 17:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com> <20231213-zswap-dstmem-v4-2-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-2-f228b059dd89@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Dec 2023 14:24:41 +1300
Message-ID: <CAGsJ_4yUCQrGKQD-oxSAhyvJ+fY_KXUoiVBXE_i0jDAhWiNGzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 4:56=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
> copy the entry->handle memory to a temporary memory, which is allocated
> using kmalloc.
>
> Obviously we can reuse the per-compressor dstmem to avoid allocating
> every time, since it's percpu-compressor and protected in percpu mutex.

what is the benefit of this since we are actually increasing lock contentio=
n
by reusing this buffer between multiple compression and decompression
threads?

this mainly affects zsmalloc which can't sleep? do we have performance
data?

and it seems this patch is also negatively affecting z3fold and zbud.c
which actually don't need to allocate a tmp buffer.

>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
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
>

