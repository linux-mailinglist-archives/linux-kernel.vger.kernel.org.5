Return-Path: <linux-kernel+bounces-11625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FB81E920
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2317E2822D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B78FED8;
	Tue, 26 Dec 2023 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBAANCqy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB21643
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so362725439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617736; x=1704222536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEwFqu7N4pNQgqlZY6e4yXz3XTwyP/U0e2i9AKk6T1I=;
        b=bBAANCqyiyc3z/MQmtCuXMUAufGJ1pW+VusDvnP4GcsP3ylQoutgmVfUk1HIxXmGvB
         krY4OTp1APdOdFD5B77/ly+NqyA44+77hFNXW/rjB/+4hOBYmM8+n99ilp/j341QVpb5
         82QFbf1osAX1hnvtaUUXuFtgl/YHjhRxDs+Ju7BrrAXymb91bzDWxsR+E8V9P7yqLVqC
         UUNXxKsIOy9Zqs88Iwt5R/PCyAavy9aI8QF3/ZLt6+qGxxFcwHenRStc2EXFg/wVcvgA
         OfvJtwROwSX5ZShB3re5VLUSW6K6VnApd0AMqhHHVKji4DOf9eI/KyudXKx2D6KPoGyl
         skFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617736; x=1704222536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEwFqu7N4pNQgqlZY6e4yXz3XTwyP/U0e2i9AKk6T1I=;
        b=hY9gp45C3JgQlap5VWDW15EkLAF3ZnCGdeG2+E9jwZgo9IZxsrMNhzYSjPKvMTrvp0
         TAoTYXGiP+LMhMv0+Re49Z55xMLCgM4vCehbpL5Q3y54jCRYe6F4ifUgCLfO6mBpAboQ
         PRsqKre1OaQcoSss4lyUP0tD2ktRQYpwbW3DLjmC/zyeVtYE5XmvM2ITgIIiRF5Eo+yT
         eiDhqOKEeLoQg1o3eow6+/gpzsfvYb1AfUKhWuw6MwyF0bSUEOoyoe0aUCSSwa2rGkyT
         6oeSh2ggG3hSJozSfvjd+kHMOQWkwdmJ4RyWdbi4ewqk6ntuLDreLpLeNzl7eJ7G3rSo
         h4jw==
X-Gm-Message-State: AOJu0YxMk3MO+9xAo1Wsi1Uryui03wOyGCVBJVWOXOhgvl8tF2T2W4Ft
	bFnPeDN0BAqWsKs95I7lEOuhZXLifEqB/3vYnhI=
X-Google-Smtp-Source: AGHT+IEc2tnxi8AhY9xmeAfznon68lgbaeDPJEoJiZpZsZIqajrzVe4QRk2p2BLDNGb+8Ux0fooWoFhMyMKkfmdtDcU=
X-Received: by 2002:a05:6602:4995:b0:7b7:846e:564b with SMTP id
 eg21-20020a056602499500b007b7846e564bmr12094964iob.26.1703617735752; Tue, 26
 Dec 2023 11:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com> <20231213-zswap-dstmem-v4-6-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-6-f228b059dd89@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Dec 2023 11:08:44 -0800
Message-ID: <CAKEwX=NzGF5K=6jbUO87hG3VE2Ou+h5zF6wRy-tuJV-ar1+xzQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm/zswap: change per-cpu mutex and buffer to per-acomp_ctx
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Chris Li <chriscli@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 7:55=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> First of all, we need to rename acomp_ctx->dstmem field to buffer,
> since we are now using for purposes other than compression.
>
> Then we change per-cpu mutex and buffer to per-acomp_ctx, since
> them belong to the acomp_ctx and are necessary parts when used
> in the compress/decompress contexts.
>
> So we can remove the old per-cpu mutex and dstmem.
>
> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Fairly straightforward, and actually delete some code :) LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  include/linux/cpuhotplug.h |  1 -
>  mm/zswap.c                 | 98 +++++++++++++---------------------------=
------
>  2 files changed, 28 insertions(+), 71 deletions(-)
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index efc0c0b07efb..c3e06e21766a 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -124,7 +124,6 @@ enum cpuhp_state {
>         CPUHP_ARM_BL_PREPARE,
>         CPUHP_TRACE_RB_PREPARE,
>         CPUHP_MM_ZS_PREPARE,
> -       CPUHP_MM_ZSWP_MEM_PREPARE,
>         CPUHP_MM_ZSWP_POOL_PREPARE,
>         CPUHP_KVM_PPC_BOOK3S_PREPARE,
>         CPUHP_ZCOMP_PREPARE,
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 40ee9f109f98..8014509736ad 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -166,8 +166,8 @@ struct crypto_acomp_ctx {
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
>         struct crypto_wait wait;
> -       u8 *dstmem;
> -       struct mutex *mutex;
> +       u8 *buffer;
> +       struct mutex mutex;
>  };
>
>  /*
> @@ -694,63 +694,26 @@ static void zswap_alloc_shrinker(struct zswap_pool =
*pool)
>  /*********************************
>  * per-cpu code
>  **********************************/
> -static DEFINE_PER_CPU(u8 *, zswap_dstmem);
> -/*
> - * If users dynamically change the zpool type and compressor at runtime,=
 i.e.
> - * zswap is running, zswap can have more than one zpool on one cpu, but =
they
> - * are sharing dtsmem. So we need this mutex to be per-cpu.
> - */
> -static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
> -
> -static int zswap_dstmem_prepare(unsigned int cpu)
> -{
> -       struct mutex *mutex;
> -       u8 *dst;
> -
> -       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> -       if (!dst)
> -               return -ENOMEM;
> -
> -       mutex =3D kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(cp=
u));
> -       if (!mutex) {
> -               kfree(dst);
> -               return -ENOMEM;
> -       }
> -
> -       mutex_init(mutex);
> -       per_cpu(zswap_dstmem, cpu) =3D dst;
> -       per_cpu(zswap_mutex, cpu) =3D mutex;
> -       return 0;
> -}
> -
> -static int zswap_dstmem_dead(unsigned int cpu)
> -{
> -       struct mutex *mutex;
> -       u8 *dst;
> -
> -       mutex =3D per_cpu(zswap_mutex, cpu);
> -       kfree(mutex);
> -       per_cpu(zswap_mutex, cpu) =3D NULL;
> -
> -       dst =3D per_cpu(zswap_dstmem, cpu);
> -       kfree(dst);
> -       per_cpu(zswap_dstmem, cpu) =3D NULL;
> -
> -       return 0;
> -}
> -
>  static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *n=
ode)
>  {
>         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
>         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ct=
x, cpu);
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
> +       int ret;
> +
> +       mutex_init(&acomp_ctx->mutex);
> +
> +       acomp_ctx->buffer =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_=
node(cpu));
> +       if (!acomp_ctx->buffer)
> +               return -ENOMEM;
>
>         acomp =3D crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_no=
de(cpu));
>         if (IS_ERR(acomp)) {
>                 pr_err("could not alloc crypto acomp %s : %ld\n",
>                                 pool->tfm_name, PTR_ERR(acomp));
> -               return PTR_ERR(acomp);
> +               ret =3D PTR_ERR(acomp);
> +               goto acomp_fail;
>         }
>         acomp_ctx->acomp =3D acomp;
>
> @@ -758,8 +721,8 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>         if (!req) {
>                 pr_err("could not alloc crypto acomp_request %s\n",
>                        pool->tfm_name);
> -               crypto_free_acomp(acomp_ctx->acomp);
> -               return -ENOMEM;
> +               ret =3D -ENOMEM;
> +               goto req_fail;
>         }
>         acomp_ctx->req =3D req;
>
> @@ -772,10 +735,13 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
>         acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
>                                    crypto_req_done, &acomp_ctx->wait);
>
> -       acomp_ctx->mutex =3D per_cpu(zswap_mutex, cpu);
> -       acomp_ctx->dstmem =3D per_cpu(zswap_dstmem, cpu);
> -
>         return 0;
> +
> +req_fail:
> +       crypto_free_acomp(acomp_ctx->acomp);
> +acomp_fail:
> +       kfree(acomp_ctx->buffer);
> +       return ret;
>  }
>
>  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node=
)
> @@ -788,6 +754,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, stru=
ct hlist_node *node)
>                         acomp_request_free(acomp_ctx->req);
>                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>                         crypto_free_acomp(acomp_ctx->acomp);
> +               kfree(acomp_ctx->buffer);
>         }
>
>         return 0;
> @@ -1400,12 +1367,12 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
>         u8 *src;
>
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
> +       mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(acomp_ctx->dstmem, src, entry->length);
> -               src =3D acomp_ctx->dstmem;
> +               memcpy(acomp_ctx->buffer, src, entry->length);
> +               src =3D acomp_ctx->buffer;
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> @@ -1415,7 +1382,7 @@ static void __zswap_load(struct zswap_entry *entry,=
 struct page *page)
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
>         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(&acomp_ctx->mutex);
>
>         if (zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
> @@ -1636,9 +1603,9 @@ bool zswap_store(struct folio *folio)
>         /* compress */
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>
> -       mutex_lock(acomp_ctx->mutex);
> +       mutex_lock(&acomp_ctx->mutex);
>
> -       dst =3D acomp_ctx->dstmem;
> +       dst =3D acomp_ctx->buffer;
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
>
> @@ -1681,7 +1648,7 @@ bool zswap_store(struct folio *folio)
>         buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>         memcpy(buf, dst, dlen);
>         zpool_unmap_handle(zpool, handle);
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(&acomp_ctx->mutex);
>
>         /* populate entry */
>         entry->swpentry =3D swp_entry(type, offset);
> @@ -1724,7 +1691,7 @@ bool zswap_store(struct folio *folio)
>         return true;
>
>  put_dstmem:
> -       mutex_unlock(acomp_ctx->mutex);
> +       mutex_unlock(&acomp_ctx->mutex);
>  put_pool:
>         zswap_pool_put(entry->pool);
>  freepage:
> @@ -1899,13 +1866,6 @@ static int zswap_setup(void)
>                 goto cache_fail;
>         }
>
> -       ret =3D cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:pr=
epare",
> -                               zswap_dstmem_prepare, zswap_dstmem_dead);
> -       if (ret) {
> -               pr_err("dstmem alloc failed\n");
> -               goto dstmem_fail;
> -       }
> -
>         ret =3D cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
>                                       "mm/zswap_pool:prepare",
>                                       zswap_cpu_comp_prepare,
> @@ -1937,8 +1897,6 @@ static int zswap_setup(void)
>         if (pool)
>                 zswap_pool_destroy(pool);
>  hp_fail:
> -       cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
> -dstmem_fail:
>         kmem_cache_destroy(zswap_entry_cache);
>  cache_fail:
>         /* if built-in, we aren't unloaded on failure; don't allow use */
>
> --
> b4 0.10.1

