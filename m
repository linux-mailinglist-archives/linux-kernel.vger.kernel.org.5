Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67EB802240
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjLCJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:27:50 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5DE8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:27:56 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77d6b28aa9aso244147885a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701595675; x=1702200475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1nd80FvNU9S8heBOzPnXo9sLSNVZ9o4GqZdFqx5GxE=;
        b=HpQ2BRvnoNDvvfbHLXC0XLzoh67gJ/TsfFm//OFxayGnbZDscd+A2vKL0deatXuN8W
         FGJyDu3U7QEZvYmj5sbE3YHfCU9W09fy9MQKc2P4oe4M2FJQ0t6JKhvSMTFKNSjVUTQr
         MA5u/VR8cEmo2pSwNxUONim9t5qnaMGZEyjWBh4U+5oZ8rWmjMXi2TyKmEs3BbBbGnxi
         Wa+sTKfLZ8S7THvaPbDjbiiT7T0C5XM+MOi5G/QG57EFmOsanyRHOECI+weVLpAbU4X3
         Maql56F+dgPX/uZC3iUuEduQDOiArok48R83sG6r/vSpCWna/hkoBcxXoD/RwLacKDjv
         gf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701595675; x=1702200475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1nd80FvNU9S8heBOzPnXo9sLSNVZ9o4GqZdFqx5GxE=;
        b=AZDEcK5dYGbgl2ZpOkEhMx9i2aPXbkZXpWiVOkg7z95hUFO9hEB+CqmKTNWbzlpSip
         dPTuGIjj2Ce1MSlMRwC7mDNBGy74LtN0fb19Hd684BM9M3edMxWY3RCQCfpXJ17HFfSK
         oWZknI1h9PKCnSDoUYMPEjpsQPfBHM3qGOKsNPfFXbkW7g4pXXx8iXQ/byJNnEa7iPW/
         t7fSlsH1QV2R/1K4N9M1Y5PxxTpB/QTHtLBXEiRS1ji/NhE8c9O9V0eI2zUO9g7+NdNN
         JXsfolrTf9w4vWey0BF2s2HcIzLjh8vww9/K+1Ur9Ih6tLGMpFwYZvE/6bN/0iR0+yrE
         YXWA==
X-Gm-Message-State: AOJu0Yw3cZzsWXn0/w+50sy8BvcMnXj6Kh3PZ9T7oR9uFKbg0ojxjClT
        h8l+KW85ESWNWDp1fH33lXJlbSmNnsUYLHuAy90=
X-Google-Smtp-Source: AGHT+IEa1n5Vs9QJzh+fABTyJLcDN+dVv9IFFWxfGvy72U6gSL6cIPQpSrNpWo5ikUt523q594OHn4fG+qozBuSE9fw=
X-Received: by 2002:a05:620a:890a:b0:77e:fba3:8204 with SMTP id
 ql10-20020a05620a890a00b0077efba38204mr2949111qkn.154.1701595675344; Sun, 03
 Dec 2023 01:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-9-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-9-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 18:27:43 +0900
Message-ID: <CAB=+i9Sm7Q6rBm0eQ4gVeToc1Lx8RWSWTaiBUwK1vPSrksCgpg@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] slub: Rename all *unfreeze_partials* functions to *put_partials*
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:25=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> Since all partial slabs on the CPU partial list are not frozen anymore,
> we don't unfreeze when moving cpu partial slabs to node partial list,
> it's better to rename these functions.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d137468fe4b9..c20bdf5dab0f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2546,7 +2546,7 @@ static void deactivate_slab(struct kmem_cache *s, s=
truct slab *slab,
>  }
>
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void __unfreeze_partials(struct kmem_cache *s, struct slab *parti=
al_slab)
> +static void __put_partials(struct kmem_cache *s, struct slab *partial_sl=
ab)
>  {
>         struct kmem_cache_node *n =3D NULL, *n2 =3D NULL;
>         struct slab *slab, *slab_to_discard =3D NULL;
> @@ -2588,9 +2588,9 @@ static void __unfreeze_partials(struct kmem_cache *=
s, struct slab *partial_slab)
>  }
>
>  /*
> - * Unfreeze all the cpu partial slabs.
> + * Put all the cpu partial slabs to the node partial list.
>   */
> -static void unfreeze_partials(struct kmem_cache *s)
> +static void put_partials(struct kmem_cache *s)
>  {
>         struct slab *partial_slab;
>         unsigned long flags;
> @@ -2601,11 +2601,11 @@ static void unfreeze_partials(struct kmem_cache *=
s)
>         local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>
>         if (partial_slab)
> -               __unfreeze_partials(s, partial_slab);
> +               __put_partials(s, partial_slab);
>  }
>
> -static void unfreeze_partials_cpu(struct kmem_cache *s,
> -                                 struct kmem_cache_cpu *c)
> +static void put_partials_cpu(struct kmem_cache *s,
> +                            struct kmem_cache_cpu *c)
>  {
>         struct slab *partial_slab;
>
> @@ -2613,7 +2613,7 @@ static void unfreeze_partials_cpu(struct kmem_cache=
 *s,
>         c->partial =3D NULL;
>
>         if (partial_slab)
> -               __unfreeze_partials(s, partial_slab);
> +               __put_partials(s, partial_slab);
>  }
>
>  /*
> @@ -2626,7 +2626,7 @@ static void unfreeze_partials_cpu(struct kmem_cache=
 *s,
>  static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int=
 drain)
>  {
>         struct slab *oldslab;
> -       struct slab *slab_to_unfreeze =3D NULL;
> +       struct slab *slab_to_put =3D NULL;
>         unsigned long flags;
>         int slabs =3D 0;
>
> @@ -2641,7 +2641,7 @@ static void put_cpu_partial(struct kmem_cache *s, s=
truct slab *slab, int drain)
>                          * per node partial list. Postpone the actual unf=
reezing
>                          * outside of the critical section.
>                          */
> -                       slab_to_unfreeze =3D oldslab;
> +                       slab_to_put =3D oldslab;
>                         oldslab =3D NULL;
>                 } else {
>                         slabs =3D oldslab->slabs;
> @@ -2657,17 +2657,17 @@ static void put_cpu_partial(struct kmem_cache *s,=
 struct slab *slab, int drain)
>
>         local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>
> -       if (slab_to_unfreeze) {
> -               __unfreeze_partials(s, slab_to_unfreeze);
> +       if (slab_to_put) {
> +               __put_partials(s, slab_to_put);
>                 stat(s, CPU_PARTIAL_DRAIN);
>         }
>  }
>
>  #else  /* CONFIG_SLUB_CPU_PARTIAL */
>
> -static inline void unfreeze_partials(struct kmem_cache *s) { }
> -static inline void unfreeze_partials_cpu(struct kmem_cache *s,
> -                                 struct kmem_cache_cpu *c) { }
> +static inline void put_partials(struct kmem_cache *s) { }
> +static inline void put_partials_cpu(struct kmem_cache *s,
> +                                   struct kmem_cache_cpu *c) { }
>
>  #endif /* CONFIG_SLUB_CPU_PARTIAL */
>
> @@ -2709,7 +2709,7 @@ static inline void __flush_cpu_slab(struct kmem_cac=
he *s, int cpu)
>                 stat(s, CPUSLAB_FLUSH);
>         }
>
> -       unfreeze_partials_cpu(s, c);
> +       put_partials_cpu(s, c);
>  }
>
>  struct slub_flush_work {
> @@ -2737,7 +2737,7 @@ static void flush_cpu_slab(struct work_struct *w)
>         if (c->slab)
>                 flush_slab(s, c);
>
> -       unfreeze_partials(s);
> +       put_partials(s);
>  }
>
>  static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> @@ -3168,7 +3168,7 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>                 if (unlikely(!node_match(slab, node) ||
>                              !pfmemalloc_match(slab, gfpflags))) {
>                         slab->next =3D NULL;
> -                       __unfreeze_partials(s, slab);
> +                       __put_partials(s, slab);
>                         continue;
>                 }
>
> --

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> 2.20.1
>
