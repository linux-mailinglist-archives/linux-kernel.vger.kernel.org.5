Return-Path: <linux-kernel+bounces-3254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3FF8169FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D0E283CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18912B75;
	Mon, 18 Dec 2023 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMFP1bpQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7C12B61
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50d176eb382so3477122e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702892274; x=1703497074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPUaHeCOyiJMxg1+wwkeRXEvlqzlbHDzzow5eR6DPqo=;
        b=ZMFP1bpQsk522UVvjSORUfRlYNR2R3ygyrn5DGovUZdD942PHS6WSg1Eahf7m8kw/o
         6YrDOaO1qG41cp7D9xPFjUZ5ha0IUXRXWwbKsMbAXmXO7XOmvWjKW6wDZxmlAllQ2t11
         7MscUpfhMCDgsdqxlklUZZsSOCxO8p6/IYVU6fLMDjaU9JFOIgYK/ajcXMsBW6jnn2Jd
         Wmvf23fBTMIvHxpD8ArpEWIUE0m3aB2FYcfxVyM+rTCEWyLOCDNQaKT4QaD8pbe5umQ3
         qAGyfX437sj6Oh2iHlgPIZmZtD+SSkOB0pa9FDTPD2e1yVkz3vMevNfvsubfpdCyyIwg
         rTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702892274; x=1703497074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPUaHeCOyiJMxg1+wwkeRXEvlqzlbHDzzow5eR6DPqo=;
        b=ArEfYC4SNtlHiLmIEt6NjuDkBz7SDwWJZaBa8ra3O7PVtSiAxU88dudOAEYuDuIy1/
         EQrq+/7uvpiSZp8kPvyfoDAndyNX4VpH4HNKgSRvVy7ZFPw2yetr+OjGTe72KkU4wy8P
         c4bNRaueU99xi22skdRN82+OjFZqsmU85kgwhUdMdgZjk0fjwpTbXZvxDidm+vfqeqpm
         jQQd5rOgHMJdZRqbraISqfBHVu7hSNgFeYr6vVm5A6Yv+GdGsvd4hc9OSqxd3UushOCs
         bQEQMAHGJYVy23yRtA2unWbm6sOC8H3lXt43BIcyQFKH/ooa57HFuLzXIpeNdo/jnup9
         MSfw==
X-Gm-Message-State: AOJu0YxGmD8CzrG3SLUF6fuAkkJcqdGOh1sBGcHfTs80/DySxRkkHI73
	fUdTHleYwrL0xrFw8tySHQF4yzdF/L7sT28jgZO9Qg==
X-Google-Smtp-Source: AGHT+IG25q646NoCMgQ28Iz/K91ENe22swWyfP12kRHt/Tpufnmk8yGkhydNcTa3kml0aEao3Ymz22yVlOy5UViJp3g=
X-Received: by 2002:ac2:5bc6:0:b0:50b:f012:fd18 with SMTP id
 u6-20020ac25bc6000000b0050bf012fd18mr8120557lfn.12.1702892273810; Mon, 18 Dec
 2023 01:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com> <20231213-zswap-dstmem-v2-6-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-6-daa5d9ae41a7@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Dec 2023 01:37:17 -0800
Message-ID: <CAJD7tkZSrd-R-vuVqh29fgZ6bmo3EJxdb2Eahm0Ozg5hkPEjRg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
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
> Since the introduce of reusing the dstmem in the load path, it seems
> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
> now for purposes other than what the naming suggests.
>
> Yosry suggested removing these two fields from acomp_ctx, and directly
> using zswap_dstmem and zswap_mutex in both the load and store paths,
> rename them, and add proper comments above their definitions that they
> are for generic percpu buffering on the load and store paths.
>
> So this patch remove dstmem and mutex from acomp_ctx, and rename the
> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
> the load and store paths. And refactor out __zswap_store() to only
> include the compress & store, since I found zswap_store() is too long.

I am not sure refactoring out __zswap_store() is useful to be honest,
but I am not objecting to it, it mirrors __zswap_load() in a sense.
However, if you want to do so, please do it in a separate patch from
renaming the percpu buffers and mutex. This will make reviewing easier
(and make my Suggested-by correctly scoped).

Also, any reason why raw_smp_processor_id() is used here instead of
smp_processor_id()?

>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 193 +++++++++++++++++++++++++++++++++----------------------=
------
>  1 file changed, 104 insertions(+), 89 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2c349fd88904..b7449294ec3a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -166,8 +166,6 @@ struct crypto_acomp_ctx {
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
>         struct crypto_wait wait;
> -       u8 *dstmem;
> -       struct mutex *mutex;
>  };
>
>  /*
> @@ -694,7 +692,7 @@ static void zswap_alloc_shrinker(struct zswap_pool *p=
ool)
>  /*********************************
>  * per-cpu code
>  **********************************/
> -static DEFINE_PER_CPU(u8 *, zswap_dstmem);
> +static DEFINE_PER_CPU(u8 *, zswap_buffer);
>  /*
>   * If users dynamically change the zpool type and compressor at runtime,=
 i.e.
>   * zswap is running, zswap can have more than one zpool on one cpu, but =
they
> @@ -702,39 +700,39 @@ static DEFINE_PER_CPU(u8 *, zswap_dstmem);
>   */
>  static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
>
> -static int zswap_dstmem_prepare(unsigned int cpu)
> +static int zswap_buffer_prepare(unsigned int cpu)
>  {
>         struct mutex *mutex;
> -       u8 *dst;
> +       u8 *buf;
>
> -       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> -       if (!dst)
> +       buf =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> +       if (!buf)
>                 return -ENOMEM;
>
>         mutex =3D kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(cp=
u));
>         if (!mutex) {
> -               kfree(dst);
> +               kfree(buf);
>                 return -ENOMEM;
>         }
>
>         mutex_init(mutex);
> -       per_cpu(zswap_dstmem, cpu) =3D dst;
> +       per_cpu(zswap_buffer, cpu) =3D buf;
>         per_cpu(zswap_mutex, cpu) =3D mutex;
>         return 0;
>  }
>
> -static int zswap_dstmem_dead(unsigned int cpu)
> +static int zswap_buffer_dead(unsigned int cpu)
>  {
>         struct mutex *mutex;
> -       u8 *dst;
> +       u8 *buf;
>
>         mutex =3D per_cpu(zswap_mutex, cpu);
>         kfree(mutex);
>         per_cpu(zswap_mutex, cpu) =3D NULL;
>
> -       dst =3D per_cpu(zswap_dstmem, cpu);
> -       kfree(dst);
> -       per_cpu(zswap_dstmem, cpu) =3D NULL;
> +       buf =3D per_cpu(zswap_buffer, cpu);
> +       kfree(buf);
> +       per_cpu(zswap_buffer, cpu) =3D NULL;
>
>         return 0;
>  }
> @@ -772,9 +770,6 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>         acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
>                                    crypto_req_done, &acomp_ctx->wait);
>
> -       acomp_ctx->mutex =3D per_cpu(zswap_mutex, cpu);
> -       acomp_ctx->dstmem =3D per_cpu(zswap_dstmem, cpu);
> -
>         return 0;
>  }
>
> @@ -1392,20 +1387,98 @@ static int zswap_enabled_param_set(const char *va=
l,
>         return ret;
>  }
>
> +static int __zswap_store(struct zswap_entry *entry, struct page *page)
> +{
> +       struct scatterlist input, output;
> +       struct crypto_acomp_ctx *acomp_ctx;
> +       struct zpool *zpool;
> +       unsigned long handle;
> +       unsigned int dlen;
> +       u8 *buf, *dst;
> +       gfp_t gfp;
> +       int ret;
> +       int cpu;
> +       struct mutex *mutex;
> +
> +       cpu =3D raw_smp_processor_id();
> +       mutex =3D per_cpu(zswap_mutex, cpu);
> +       mutex_lock(mutex);
> +
> +       acomp_ctx =3D per_cpu_ptr(entry->pool->acomp_ctx, cpu);
> +       buf =3D per_cpu(zswap_buffer, cpu);
> +
> +       sg_init_table(&input, 1);
> +       sg_set_page(&input, page, PAGE_SIZE, 0);
> +       sg_init_one(&output, buf, PAGE_SIZE);
> +       acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, PAGE_SIZE);
> +       /*
> +        * it maybe looks a little bit silly that we send an asynchronous=
 request,
> +        * then wait for its completion synchronously. This makes the pro=
cess look
> +        * synchronous in fact.
> +        * Theoretically, acomp supports users send multiple acomp reques=
ts in one
> +        * acomp instance, then get those requests done simultaneously. b=
ut in this
> +        * case, zswap actually does store and load page by page, there i=
s no
> +        * existing method to send the second page before the first page =
is done
> +        * in one thread doing zwap.
> +        * but in different threads running on different cpu, we have dif=
ferent
> +        * acomp instance, so multiple threads can do (de)compression in =
parallel.
> +        */
> +       ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
> +       dlen =3D acomp_ctx->req->dlen;
> +
> +       if (ret) {
> +               zswap_reject_compress_fail++;
> +               goto unlock;
> +       }
> +
> +       /* store */
> +       zpool =3D zswap_find_zpool(entry);
> +       gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> +       if (zpool_malloc_support_movable(zpool))
> +               gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> +       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> +       if (ret =3D=3D -ENOSPC) {
> +               zswap_reject_compress_poor++;
> +               goto unlock;
> +       }
> +       if (ret) {
> +               zswap_reject_alloc_fail++;
> +               goto unlock;
> +       }
> +       dst =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> +       memcpy(dst, buf, dlen);
> +       zpool_unmap_handle(zpool, handle);
> +       mutex_unlock(mutex);
> +
> +       entry->handle =3D handle;
> +       entry->length =3D dlen;
> +       return 0;
> +
> +unlock:
> +       mutex_unlock(mutex);
> +       return ret;
> +}
> +
>  static void __zswap_load(struct zswap_entry *entry, struct page *page)
>  {
>         struct zpool *zpool =3D zswap_find_zpool(entry);
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src;
> +       u8 *src, *buf;
> +       int cpu;
> +       struct mutex *mutex;
> +
> +       cpu =3D raw_smp_processor_id();
> +       mutex =3D per_cpu(zswap_mutex, cpu);
> +       mutex_lock(mutex);
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
> +       acomp_ctx =3D per_cpu_ptr(entry->pool->acomp_ctx, cpu);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(acomp_ctx->dstmem, src, entry->length);
> -               src =3D acomp_ctx->dstmem;
> +               buf =3D per_cpu(zswap_buffer, cpu);
> +               memcpy(buf, src, entry->length);
> +               src =3D buf;
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> @@ -1415,7 +1488,7 @@ static void __zswap_load(struct zswap_entry *entry,=
 struct page *page)
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
>         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(mutex);
>
>         if (zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
> @@ -1539,18 +1612,11 @@ bool zswap_store(struct folio *folio)
>         struct page *page =3D &folio->page;
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry, *dupentry;
> -       struct scatterlist input, output;
> -       struct crypto_acomp_ctx *acomp_ctx;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         struct zswap_pool *pool;
> -       struct zpool *zpool;
> -       unsigned int dlen =3D PAGE_SIZE;
> -       unsigned long handle, value;
> -       char *buf;
> -       u8 *src, *dst;
> -       gfp_t gfp;
> -       int ret;
> +       u8 *src;
> +       unsigned long value;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1635,60 +1701,11 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       /* compress */
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -
> -       mutex_lock(acomp_ctx->mutex);
> -
> -       dst =3D acomp_ctx->dstmem;
> -       sg_init_table(&input, 1);
> -       sg_set_page(&input, page, PAGE_SIZE, 0);
> -
> -       sg_init_one(&output, dst, PAGE_SIZE);
> -       acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
> -       /*
> -        * it maybe looks a little bit silly that we send an asynchronous=
 request,
> -        * then wait for its completion synchronously. This makes the pro=
cess look
> -        * synchronous in fact.
> -        * Theoretically, acomp supports users send multiple acomp reques=
ts in one
> -        * acomp instance, then get those requests done simultaneously. b=
ut in this
> -        * case, zswap actually does store and load page by page, there i=
s no
> -        * existing method to send the second page before the first page =
is done
> -        * in one thread doing zwap.
> -        * but in different threads running on different cpu, we have dif=
ferent
> -        * acomp instance, so multiple threads can do (de)compression in =
parallel.
> -        */
> -       ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
> -       dlen =3D acomp_ctx->req->dlen;
> -
> -       if (ret) {
> -               zswap_reject_compress_fail++;
> -               goto put_dstmem;
> -       }
> -
> -       /* store */
> -       zpool =3D zswap_find_zpool(entry);
> -       gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> -       if (zpool_malloc_support_movable(zpool))
> -               gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> -       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> -       if (ret =3D=3D -ENOSPC) {
> -               zswap_reject_compress_poor++;
> -               goto put_dstmem;
> -       }
> -       if (ret) {
> -               zswap_reject_alloc_fail++;
> -               goto put_dstmem;
> -       }
> -       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> -       memcpy(buf, dst, dlen);
> -       zpool_unmap_handle(zpool, handle);
> -       mutex_unlock(acomp_ctx->mutex);
> +       if (__zswap_store(entry, page))
> +               goto put_pool;
>
>         /* populate entry */
>         entry->swpentry =3D swp_entry(type, offset);
> -       entry->handle =3D handle;
> -       entry->length =3D dlen;
>
>  insert_entry:
>         entry->objcg =3D objcg;
> @@ -1725,8 +1742,6 @@ bool zswap_store(struct folio *folio)
>
>         return true;
>
> -put_dstmem:
> -       mutex_unlock(acomp_ctx->mutex);
>  put_pool:
>         zswap_pool_put(entry->pool);
>  freepage:
> @@ -1902,10 +1917,10 @@ static int zswap_setup(void)
>         }
>
>         ret =3D cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:pr=
epare",
> -                               zswap_dstmem_prepare, zswap_dstmem_dead);
> +                               zswap_buffer_prepare, zswap_buffer_dead);
>         if (ret) {
> -               pr_err("dstmem alloc failed\n");
> -               goto dstmem_fail;
> +               pr_err("buffer alloc failed\n");
> +               goto buffer_fail;
>         }
>
>         ret =3D cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
> @@ -1940,7 +1955,7 @@ static int zswap_setup(void)
>                 zswap_pool_destroy(pool);
>  hp_fail:
>         cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
> -dstmem_fail:
> +buffer_fail:
>         kmem_cache_destroy(zswap_entry_cache);
>  cache_fail:
>         /* if built-in, we aren't unloaded on failure; don't allow use */
>
> --
> b4 0.10.1

