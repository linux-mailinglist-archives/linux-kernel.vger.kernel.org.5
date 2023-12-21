Return-Path: <linux-kernel+bounces-7685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32781AB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D41281E57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228462912;
	Thu, 21 Dec 2023 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPxz0u4l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9107928E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a269a271b5bso25199666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703117991; x=1703722791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuiGIGRCemwNH8PWp5epsekKJJKgPaBxQM1YEsDyA0M=;
        b=yPxz0u4l8veIy8FticoO04hxfTh0thXOdzxcZ8Bls2Kba03Opp5rCd0mljXameqfZu
         ekv2X/l4SoPwbuxgsfJ3syLflGdH5+70hf5IkWtgck+4mUIH8eCKEj569jC1SpBNiQS+
         XAYwqp65mTmtIuarpBmwehH12a0rJbZ+xTTnYN3ftEqpRDIs6zz5KQauzJIrsv0rWPh7
         eY7o07/GPy4Rl0940/CxCcijqBFpn5DHHfjMTJHUeZNvnHOlnppC+HzdpQtXfzundCKw
         yAfxvwZxJfppdHAqkdkfgw6+zGy7sURG2WzIodlVoO6sAEopCTPExaj/2F0V0hih0/am
         Otrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703117991; x=1703722791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuiGIGRCemwNH8PWp5epsekKJJKgPaBxQM1YEsDyA0M=;
        b=Ztp0ebyXg5VT8jLtB4sE9lvc5BatIju3ewa80D5NaVDqxvPVaB39zwrizAZHBY6co9
         YLHUBu+Yxl9M6JNmaT1Xk8Bj/85DbDHneQypGce5+IQhHgnVvp45RHimuoZZrfZNdUBH
         cbgctkZtTYXg1pu3rf34ZLkRh/hvWDq8Qk52KAbSljMxRz0boaWF6gNPH5VjinAgOGn+
         XDp8k3Zm/VByt+yVNgbaSG66qaxj7XQSJQgutojlrQnc/hup6B3S3VxLUTATtdSbZmBp
         tYONWrwrGjVg8suM+3rxOJ8HCWPjeOI6YOxdTlfN/lxPm/expG3YprPtOLlI2sCzsZnl
         hyeQ==
X-Gm-Message-State: AOJu0YyPN0x1NwERoINTmJyz8BoS4onEWS+oJv8QLbgdvNPmU9k6N3lz
	G+6GBWakyQCFnABdsPUraKJDS0STobLWN9rPPDkrVQ==
X-Google-Smtp-Source: AGHT+IGCUEqkemJZ+j/E16kaAot3yn8ee9J81XvCCoUDLEhPnbkXG/xvpLfo9Bb0s56i6+X1dN14NlonUC3H+ZcWGgg=
X-Received: by 2002:a17:906:49:b0:a23:f50:6cff with SMTP id
 9-20020a170906004900b00a230f506cffmr6167990ejg.111.1703117990663; Wed, 20 Dec
 2023 16:19:50 -0800 (PST)
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
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 20 Dec 2023 16:19:14 -0800
Message-ID: <CAJD7tkb_F9FH=HxnU9pOEfh=r_34ZT6-aff+KBVimNh8V1E1jA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 4:20=E2=80=AFAM Chengming Zhou
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
>
> This way, we could delete the percpu mutex and dstmem, and its hotplugs,
> and not shared anymore between all pools. Maybe we would have many pools
> at the same time in the future, like different compression algorithm or
> different zpool for different memcg workloads. Who knows? :-)
>
> So how about this patch below? Just RFC.

The general approach looks fine to me, although I still prefer we
reorganize the struct as Chris and I discussed: rename
crypto_acomp_ctx to a generic name, add a (anonymous) struct for the
crypto_acomp stuff, rename dstmem to buffer or so.

I think we can also make the mutex a static part of the struct, any
advantage to dynamically allocating it?

>
> Subject: [PATCH] mm/zswap: make each acomp_ctx has its own mutex and dstm=
em
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

