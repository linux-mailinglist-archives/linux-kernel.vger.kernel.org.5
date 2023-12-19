Return-Path: <linux-kernel+bounces-5823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84DF818FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB71B1C212C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B239850;
	Tue, 19 Dec 2023 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzk+xM3t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DEA39840
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7b7a9f90edaso362341639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011413; x=1703616213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V86UCq8lgwT/w7ziVKVoJnuBZRSPh3/qDcwMip/KpF8=;
        b=Yzk+xM3tLZAP7UMZwii3g7b9tsFs8ebz1eRuioZqceFhnW6+RMrC0t33Vj9mz6590q
         cGxDHDytUwC8TdBlSbHKPAn06rjJ2CCpaWOdvSai9xKd8qSzRD1nhzD1hhfcuROplITg
         JRsVL5UVNrVcKwplfiNw3OFDSywsb1SCPbnlWLFpZyuyQnpRAv0GOE7yRpcwQpzDi5QX
         M1Ow8+mxs2klKN04Sw2j3YACQrFDvmPIeWqCNe+JLqCKCXHGYff6yTrTwdd2PwUfGYxK
         3eadOOTlCOj0t+xGRq1FkqxszaiZtdnCUrGR/BFdwRgrj+hhanX38HUPIXqxXrS/uQ5Z
         h1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011413; x=1703616213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V86UCq8lgwT/w7ziVKVoJnuBZRSPh3/qDcwMip/KpF8=;
        b=LZaqlfe3xY2cRJdvaCg63i0IokYOirnn4rY+AFgMgYB1MXBvz7MNFvZR5qqNyVYXFY
         kfFt+U4BopalS2kvWpHcVgmXtuqLHVo1TvV9C+nuKn+HxZTmFfHMMSn1u34864jkJQeX
         oQfVay2dD9LYYDW5VS+4m5QxsEe4WfjAq8LzQghQ57cWsvL/uQzeRlZcfp/FiC5YGIuE
         t0ew/eOzmqWm+Psc90sFS9A23Am+pQmNDc80PU/tmtOvSMNFfwqDDO26zNeCYW8zYiW7
         ttXI+DV56nQVSl7IWg3keFC5j+cWpwORyResCtZqVlQMLFsb4It52vL7BBnMuoWLnqNf
         yIkA==
X-Gm-Message-State: AOJu0YxYoTqsnu6A/BaUOHeSOYGJmEYBcPZn92aFhS/9N74GN47PXJm2
	nAUOo1+ZRu9KsXQZXG6BozDF8Ymc9Z/a2q37+ss=
X-Google-Smtp-Source: AGHT+IFnCKZ9TORYCgdxQblq/cHj+3+j5alcYs1gyn4xoaJ2K6xtQxnOfLgtt92ofSgfaQ+Z9qG9Hoe9+7DonTg8F4s=
X-Received: by 2002:a92:c242:0:b0:35e:6ef0:6b04 with SMTP id
 k2-20020a92c242000000b0035e6ef06b04mr28213967ilo.68.1703011412781; Tue, 19
 Dec 2023 10:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com> <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
In-Reply-To: <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 19 Dec 2023 10:43:21 -0800
Message-ID: <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Seth Jennings <sjenning@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:29=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Chengming and Yosry,
>
> On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Since the introduce of reusing the dstmem in the load path, it seems
> > confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
> > now for purposes other than what the naming suggests.
> >
> > Yosry suggested removing these two fields from acomp_ctx, and directly
> > using zswap_dstmem and zswap_mutex in both the load and store paths,
> > rename them, and add proper comments above their definitions that they
> > are for generic percpu buffering on the load and store paths.
> >
> > So this patch remove dstmem and mutex from acomp_ctx, and rename the
> > zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
> > the load and store paths.
>
> Sorry joining this discussion late.
>
> I get the rename of "dstmem" to "buffer". Because the buffer is used
> for both load and store as well. What I don't get is that, why do we
> move it out of the acomp_ctx struct. Now we have 3 per cpu entry:
> buffer, mutex and acomp_ctx. I think we should do the reverse, fold
> this three per cpu entry into one struct the acomp_ctx. Each per_cpu
> load() has a sequence of dance around the cpu id and disable preempt
> etc, while each of the struct member load is just a plan memory load.
> It seems to me it would be more optimal to combine this three per cpu
> entry into acomp_ctx. Just do the per cpu for the acomp_ctx once.

I agree with Chris. From a practicality POV, what Chris says here
makes sense. From a semantic POV, this buffer is only used in
(de)compression contexts - be it in store, load, or writeback - so it
belonging to the orignal struct still makes sense to me. Why separate
it out, without any benefits. Just rename the old field buffer or
zswap_buffer and call it a day? It will be a smaller patch too!

>
> >
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  mm/zswap.c | 69 +++++++++++++++++++++++++++++++++---------------------=
--------
> >  1 file changed, 37 insertions(+), 32 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 2c349fd88904..71bdcd552e5b 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -166,8 +166,6 @@ struct crypto_acomp_ctx {
> >         struct crypto_acomp *acomp;
> >         struct acomp_req *req;
> >         struct crypto_wait wait;
> > -       u8 *dstmem;
> > -       struct mutex *mutex;
> >  };
> >
> >  /*
> > @@ -694,7 +692,7 @@ static void zswap_alloc_shrinker(struct zswap_pool =
*pool)
> >  /*********************************
> >  * per-cpu code
> >  **********************************/
> > -static DEFINE_PER_CPU(u8 *, zswap_dstmem);
> > +static DEFINE_PER_CPU(u8 *, zswap_buffer);
> >  /*
> >   * If users dynamically change the zpool type and compressor at runtim=
e, i.e.
> >   * zswap is running, zswap can have more than one zpool on one cpu, bu=
t they
> > @@ -702,39 +700,39 @@ static DEFINE_PER_CPU(u8 *, zswap_dstmem);
> >   */
> >  static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
> >
> > -static int zswap_dstmem_prepare(unsigned int cpu)
> > +static int zswap_buffer_prepare(unsigned int cpu)
> >  {
> >         struct mutex *mutex;
> > -       u8 *dst;
> > +       u8 *buf;
> >
> > -       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> > -       if (!dst)
> > +       buf =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> > +       if (!buf)
> >                 return -ENOMEM;
> >
> >         mutex =3D kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(=
cpu));
> >         if (!mutex) {
> > -               kfree(dst);
> > +               kfree(buf);
> >                 return -ENOMEM;
> >         }
> >
> >         mutex_init(mutex);
> > -       per_cpu(zswap_dstmem, cpu) =3D dst;
> > +       per_cpu(zswap_buffer, cpu) =3D buf;
> >         per_cpu(zswap_mutex, cpu) =3D mutex;
> >         return 0;
> >  }
> >
> > -static int zswap_dstmem_dead(unsigned int cpu)
> > +static int zswap_buffer_dead(unsigned int cpu)
> >  {
> >         struct mutex *mutex;
> > -       u8 *dst;
> > +       u8 *buf;
> >
> >         mutex =3D per_cpu(zswap_mutex, cpu);
> >         kfree(mutex);
> >         per_cpu(zswap_mutex, cpu) =3D NULL;
> >
> > -       dst =3D per_cpu(zswap_dstmem, cpu);
> > -       kfree(dst);
> > -       per_cpu(zswap_dstmem, cpu) =3D NULL;
> > +       buf =3D per_cpu(zswap_buffer, cpu);
> > +       kfree(buf);
> > +       per_cpu(zswap_buffer, cpu) =3D NULL;
> >
> >         return 0;
> >  }
> > @@ -772,9 +770,6 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
> >         acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> >                                    crypto_req_done, &acomp_ctx->wait);
> >
> > -       acomp_ctx->mutex =3D per_cpu(zswap_mutex, cpu);
> > -       acomp_ctx->dstmem =3D per_cpu(zswap_dstmem, cpu);
> > -
> >         return 0;
> >  }
> >
> > @@ -1397,15 +1392,21 @@ static void __zswap_load(struct zswap_entry *en=
try, struct page *page)
> >         struct zpool *zpool =3D zswap_find_zpool(entry);
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> > -       u8 *src;
> > +       u8 *src, *buf;
> > +       int cpu;
> > +       struct mutex *mutex;
> >
> > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > -       mutex_lock(acomp_ctx->mutex);
> > +       cpu =3D raw_smp_processor_id();
> > +       mutex =3D per_cpu(zswap_mutex, cpu);
> First per cpu call.
> > +       mutex_lock(mutex);
> > +
> > +       acomp_ctx =3D per_cpu_ptr(entry->pool->acomp_ctx, cpu);
> Second per cpu
> >
> >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >         if (!zpool_can_sleep_mapped(zpool)) {
> > -               memcpy(acomp_ctx->dstmem, src, entry->length);
> > -               src =3D acomp_ctx->dstmem;
> > +               buf =3D per_cpu(zswap_buffer, cpu);
>
> Here is the function that does the third per_cpu call. I think doing
> one per_cpu and the rest of them load from the context is more
> optimal.
> Conceptually it is cleaner as well. It is clear what this mutex is
> supposed to protect. It is protecting the compression context struct.
> Move it out as per cpu, it is less clear what is the protection scope
> of the mutex.
>
> What am I missing?
>
> Chris
>
>
> > +               memcpy(buf, src, entry->length);
> > +               src =3D buf;
> >                 zpool_unmap_handle(zpool, entry->handle);
> >         }
> >
> > @@ -1415,7 +1416,7 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
> >         acomp_request_set_params(acomp_ctx->req, &input, &output, entry=
->length, PAGE_SIZE);
> >         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),=
 &acomp_ctx->wait));
> >         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > -       mutex_unlock(acomp_ctx->mutex);
> > +       mutex_unlock(mutex);
> >
> >         if (zpool_can_sleep_mapped(zpool))
> >                 zpool_unmap_handle(zpool, entry->handle);
> > @@ -1551,6 +1552,8 @@ bool zswap_store(struct folio *folio)
> >         u8 *src, *dst;
> >         gfp_t gfp;
> >         int ret;
> > +       int cpu;
> > +       struct mutex *mutex;
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > @@ -1636,11 +1639,13 @@ bool zswap_store(struct folio *folio)
> >         }
> >
> >         /* compress */
> > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > +       cpu =3D raw_smp_processor_id();
> > +       mutex =3D per_cpu(zswap_mutex, cpu);
> > +       mutex_lock(mutex);
> >
> > -       mutex_lock(acomp_ctx->mutex);
> > +       acomp_ctx =3D per_cpu_ptr(entry->pool->acomp_ctx, cpu);
> > +       dst =3D per_cpu(zswap_buffer, cpu);
> >
> > -       dst =3D acomp_ctx->dstmem;
> >         sg_init_table(&input, 1);
> >         sg_set_page(&input, page, PAGE_SIZE, 0);
> >
> > @@ -1683,7 +1688,7 @@ bool zswap_store(struct folio *folio)
> >         buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
> >         memcpy(buf, dst, dlen);
> >         zpool_unmap_handle(zpool, handle);
> > -       mutex_unlock(acomp_ctx->mutex);
> > +       mutex_unlock(mutex);
> >
> >         /* populate entry */
> >         entry->swpentry =3D swp_entry(type, offset);
> > @@ -1726,7 +1731,7 @@ bool zswap_store(struct folio *folio)
> >         return true;
> >
> >  put_dstmem:
> > -       mutex_unlock(acomp_ctx->mutex);
> > +       mutex_unlock(mutex);
> >  put_pool:
> >         zswap_pool_put(entry->pool);
> >  freepage:
> > @@ -1902,10 +1907,10 @@ static int zswap_setup(void)
> >         }
> >
> >         ret =3D cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:=
prepare",
> > -                               zswap_dstmem_prepare, zswap_dstmem_dead=
);
> > +                               zswap_buffer_prepare, zswap_buffer_dead=
);
> >         if (ret) {
> > -               pr_err("dstmem alloc failed\n");
> > -               goto dstmem_fail;
> > +               pr_err("buffer alloc failed\n");
> > +               goto buffer_fail;
> >         }
> >
> >         ret =3D cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
> > @@ -1940,7 +1945,7 @@ static int zswap_setup(void)
> >                 zswap_pool_destroy(pool);
> >  hp_fail:
> >         cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
> > -dstmem_fail:
> > +buffer_fail:
> >         kmem_cache_destroy(zswap_entry_cache);
> >  cache_fail:
> >         /* if built-in, we aren't unloaded on failure; don't allow use =
*/
> >
> > --
> > b4 0.10.1

