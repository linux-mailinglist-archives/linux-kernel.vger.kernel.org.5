Return-Path: <linux-kernel+bounces-9945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CDF81CDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE97DB23DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14928DC9;
	Fri, 22 Dec 2023 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcL02M2N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194D24B4D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-594019698b8so1402742eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703266682; x=1703871482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5n3huQU5lWBUr8Rz2OnID+02fDHGMZrkL0eteOMUa8=;
        b=YcL02M2Nx97O0yYKt8gainEm1f6ZgisUe/dVcGkHI32aaJteajejwrnnb+xgBusQ2J
         TModvwiaej+aAMJFHVKg7DlAHZ6xvXO9NsinwHmOACdQFFk6kJt0VxupBviL5j66vjlp
         MJJf8iV+7dWJdUGOnVer/YSRglGr9xAx/lqnNaA260lEG1dBEBxpo3biPqKaAlIUkAhy
         Q6YHK7JqUWPpbGp9IY+DWnMXwAnsXREPSt2qKBqcr/Mwz9CgQjEDoEVJdMeya3ugmeKQ
         Cva+Z+eVZBYrost92dbm52TDVpOwvuAHKC7KqpekZC66CS89M8F74d2ktEplXAbcWGFX
         10Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266682; x=1703871482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5n3huQU5lWBUr8Rz2OnID+02fDHGMZrkL0eteOMUa8=;
        b=RDiqKi77+LG0oBAP7uYvGG81AvpHsQzVDbLJ4iHBwDgqd9kDQsGzX0lykbhsBOml1j
         Gzw3mOdQ7TRlHD7N0MzZrNMffOyk633Je6YXBb5JBbHe1Drk+fKPjngWETiPgba3SEH7
         KBTUvf/kOsJbRdQzH1kipNTPW6YOCe4LUd1GarFsd29zbF7zsh6FmYxgj6Z0D77NdIOL
         zQLtbLCEU54dOaaEuHa++iq86ouGz4mR64bbd96RMVsrfaeSjHFt2sW/rskiUfabCPQK
         4ZdaTiD0o+4j5kMXGIcDYkT79GenoZX8xzXKwAi5rgiKztL/3N4USU+CZBObSPDX1NmK
         FvbQ==
X-Gm-Message-State: AOJu0Yyikp0tOH9NvdqnRqjhVYYcz7yIvxbtKZ+uiAIV5OjR8smocTyo
	99r2mb3+c83RtTuGM7YEmC5hwVNDwSVJyImFq1CmEkAHDksZ
X-Google-Smtp-Source: AGHT+IEd7rO4QQp3uc4cnmz5R0Xp817l34JKN7OhVMrNW0RwUM9Q2PeqO0H8gBh9lpdECakIloV+ZAXDTmf4/YTOGzo=
X-Received: by 2002:a05:6359:630f:b0:172:f38f:876e with SMTP id
 sf15-20020a056359630f00b00172f38f876emr1266970rwb.28.1703266681434; Fri, 22
 Dec 2023 09:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com> <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
 <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com> <2a22e9b5-dc8c-4c4d-81c2-2f4e1850cf3d@bytedance.com>
In-Reply-To: <2a22e9b5-dc8c-4c4d-81c2-2f4e1850cf3d@bytedance.com>
From: Chris Li <chriscli@google.com>
Date: Fri, 22 Dec 2023 09:37:50 -0800
Message-ID: <CAF8kJuPe3njSJhii92xOefCjyqRrWC3nSA=Dv7BQ6=Mf=6gKAQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengming,

The patch looks good to me.

Acked-by: Chris Li <chrisl@kernel.org> (Google)

On Wed, Dec 20, 2023 at 4:21=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/20 05:39, Yosry Ahmed wrote:
> > On Tue, Dec 19, 2023 at 10:43=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> >>
> >> On Tue, Dec 19, 2023 at 5:29=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> >>>
> >>> Hi Chengming and Yosry,
> >>>
> >>> On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
> >>> <zhouchengming@bytedance.com> wrote:
> >>>>
> >>>> Since the introduce of reusing the dstmem in the load path, it seems
> >>>> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mut=
ex
> >>>> now for purposes other than what the naming suggests.
> >>>>
> >>>> Yosry suggested removing these two fields from acomp_ctx, and direct=
ly
> >>>> using zswap_dstmem and zswap_mutex in both the load and store paths,
> >>>> rename them, and add proper comments above their definitions that th=
ey
> >>>> are for generic percpu buffering on the load and store paths.
> >>>>
> >>>> So this patch remove dstmem and mutex from acomp_ctx, and rename the
> >>>> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
> >>>> the load and store paths.
> >>>
> >>> Sorry joining this discussion late.
> >>>
> >>> I get the rename of "dstmem" to "buffer". Because the buffer is used
> >>> for both load and store as well. What I don't get is that, why do we
> >>> move it out of the acomp_ctx struct. Now we have 3 per cpu entry:
> >>> buffer, mutex and acomp_ctx. I think we should do the reverse, fold
> >>> this three per cpu entry into one struct the acomp_ctx. Each per_cpu
> >>> load() has a sequence of dance around the cpu id and disable preempt
> >>> etc, while each of the struct member load is just a plan memory load.
> >>> It seems to me it would be more optimal to combine this three per cpu
> >>> entry into acomp_ctx. Just do the per cpu for the acomp_ctx once.
> >>
> >> I agree with Chris. From a practicality POV, what Chris says here
> >> makes sense. From a semantic POV, this buffer is only used in
> >> (de)compression contexts - be it in store, load, or writeback - so it
> >> belonging to the orignal struct still makes sense to me. Why separate
> >> it out, without any benefits. Just rename the old field buffer or
> >> zswap_buffer and call it a day? It will be a smaller patch too!
> >>
> >
> > My main concern is that the struct name is specific for the crypto
> > acomp stuff, but that buffer and mutex are not.
> > How about we keep it in the struct, but refactor the struct as follows:
> >
> > struct zswap_ctx {
> >     struct {
> >         struct crypto_acomp *acomp;
> >         struct acomp_req *req;
> >         struct crypto_wait wait;
> >     }  acomp_ctx;
> >     u8 *dstmem;
> >     struct mutex *mutex;
> > };
> >
> > , and then rename zswap_pool.acomp_ctx to zswap_pool.ctx?
>
> I think there are two viewpoints here, both works ok to me.
>
> The first is from ownship or lifetime, these percpu mutex and dstmem
> are shared between all pools, so no one pool own the mutex and dstmem,
> nor does the percpu acomp_ctx in each pool.
>
> The second is from usage, these percpu mutex and dstmem are used by
> the percpu acomp_ctx in each pool, so it's easy to use to put pointers
> to them in the percpu acomp_ctx.
>
> Actually I think it's simpler to let the percpu acomp_ctx has its own
> mutex and dstmem, which in fact are the necessary parts when it use
> the acomp interfaces.

Agree, that is why I prefer to keep the struct together. I am fine
with what Yosry suggested and the anonymous struct, just consider it
is not critically necessary.

>
> This way, we could delete the percpu mutex and dstmem, and its hotplugs,

That is the real value of this patch. Thanks for doing that.

> and not shared anymore between all pools. Maybe we would have many pools
> at the same time in the future, like different compression algorithm or
> different zpool for different memcg workloads. Who knows? :-)

As long as the zswap is not re-enterable, e.g. never have the nested
page fault that causes zswap_load within another zswap_load, I think
we are fine having more than one pool share the buffer. In fact, if we
trigger the nested zswap load, I expect the kernel will dead lock on
the nested mutex acquire because the mutex is already taken. We will
know about kernel panic rather than selient memory corruption.

>
> So how about this patch below? Just RFC.
>
> Subject: [PATCH] mm/zswap: make each acomp_ctx has its own mutex and dstm=
em

Thank you for doing that, you can consider submitting it as the real
patch instead of the RFC. I see real value in this patch removing some
per CPU fields.

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  include/linux/cpuhotplug.h |  1 -
>  mm/zswap.c                 | 86 ++++++++++++--------------------------
>  2 files changed, 26 insertions(+), 61 deletions(-)
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
> index 2c349fd88904..37301f1a80a9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -694,63 +694,31 @@ static void zswap_alloc_shrinker(struct zswap_pool =
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

Nice!

Chris

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
> +       int ret =3D 0;
> +
> +       acomp_ctx->dstmem =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_=
node(cpu));
> +       if (!acomp_ctx->dstmem)
> +               return -ENOMEM;
> +
> +       acomp_ctx->mutex =3D kmalloc_node(sizeof(struct mutex), GFP_KERNE=
L, cpu_to_node(cpu));
> +       if (!acomp_ctx->mutex) {
> +               ret =3D -ENOMEM;
> +               goto mutex_fail;
> +       }
> +       mutex_init(acomp_ctx->mutex);
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
> @@ -758,8 +726,8 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
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
> @@ -772,10 +740,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
>         acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
>                                    crypto_req_done, &acomp_ctx->wait);
>
> -       acomp_ctx->mutex =3D per_cpu(zswap_mutex, cpu);
> -       acomp_ctx->dstmem =3D per_cpu(zswap_dstmem, cpu);
> -
>         return 0;
> +req_fail:
> +       crypto_free_acomp(acomp_ctx->acomp);
> +acomp_fail:
> +       kfree(acomp_ctx->mutex);
> +mutex_fail:
> +       kfree(acomp_ctx->dstmem);
> +
> +       return ret;
>  }
>
>  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node=
)
> @@ -788,6 +761,8 @@ static int zswap_cpu_comp_dead(unsigned int cpu, stru=
ct hlist_node *node)
>                         acomp_request_free(acomp_ctx->req);
>                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>                         crypto_free_acomp(acomp_ctx->acomp);
> +               kfree(acomp_ctx->mutex);
> +               kfree(acomp_ctx->dstmem);
>         }
>
>         return 0;
> @@ -1901,13 +1876,6 @@ static int zswap_setup(void)
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
> @@ -1939,8 +1907,6 @@ static int zswap_setup(void)
>         if (pool)
>                 zswap_pool_destroy(pool);
>  hp_fail:
> -       cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
> -dstmem_fail:
>         kmem_cache_destroy(zswap_entry_cache);
>  cache_fail:
>         /* if built-in, we aren't unloaded on failure; don't allow use */
> --
> 2.20.1
>
>

