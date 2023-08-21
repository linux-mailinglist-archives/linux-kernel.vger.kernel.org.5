Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430D1782CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjHUO5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjHUO5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:57:31 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CCD1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:57:29 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44ae69a6b20so1247156137.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692629849; x=1693234649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLIL9tDKiB9E84SMDyirarsxHFqYSz9ChQ6c4+Yu91Y=;
        b=YvmsvfdR9S4nMYWDtVjmdw2/IaQx4w9dNZhQ9XCUfgjEtxcIZgsLknT55WGetIrGoI
         K2gC+cFFigORLGXORJFHUcQlY8i1B/8M6rlKEi30cImS7bGTT8ol4RWFFRUKP609qB/E
         bGaT0+8I6wc14aMrol0cp2CIPntQXvIpef60KM5m2dFVcohrFkXPCW3zE7D5CqXWSRj7
         rye9HkCp9yIVIZ0WW+aMYwHKYpRsZEcRHcVyvPaNWQfvxN1x+0fp2mLDtp01c0St+/PP
         TP/RAdazsK/kwaSVoG2xtkf9upCpEF1MakU8Qq5hMaeZQa3CxfZZu7zb3NYQ6JLdTCmw
         aDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629849; x=1693234649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLIL9tDKiB9E84SMDyirarsxHFqYSz9ChQ6c4+Yu91Y=;
        b=NsLSK/IpvtUjWGlgRvfdh3AWxgp8DLNTIVDuDYqTZQz7HcKm2mjTzoOMft34Y6ot1e
         3fT4uzW5sieAx9SGsv8156NviNE8yaEgCfQhVaQk7sxzweme981DLq+/dgYpC05IUKrC
         f57zTyxY0UG8QiE0PhY9ijlGAhPSSNbcftLoqyfdjTyqbMQ4U0gYrV8JRA1HQLIMFQrB
         ztfcLgmierMZ1kmeAZ0IhI7NIcW+gbSi8QwJhzCtZlVlkaAHtdqBArDPn6COQKz1hg6c
         5rSXJjUDBzfIpMqqICkLzSUIkC3t8Z9kLB6ZJTTxaCZRwR/qn1O3e6cIEvddpXHHizSm
         3OkQ==
X-Gm-Message-State: AOJu0YwE1UGEQVUnzOkX4Z9BzxZ8k96TGBHUPP9OoPKAUoZ6Bdy2210O
        7D8imq0aqGeFJBi5kKkr42Be914js4ggznVREvw=
X-Google-Smtp-Source: AGHT+IHzSJSubGnf2sksfrV5HKflo5QELCalkpYWSUIb/VAiNxthIV8NoWrXoMop6ham8TxSGrL70EExZwi0sFvobAk=
X-Received: by 2002:a67:e915:0:b0:444:c7fa:1aad with SMTP id
 c21-20020a67e915000000b00444c7fa1aadmr5929948vso.17.1692629848931; Mon, 21
 Aug 2023 07:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230810163627.6206-9-vbabka@suse.cz> <20230810163627.6206-11-vbabka@suse.cz>
In-Reply-To: <20230810163627.6206-11-vbabka@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Mon, 21 Aug 2023 23:57:16 +0900
Message-ID: <CAB=+i9TSMVURktFvr7sAt4T2BdaUvsWFapAjTZNtk0AKS01O9A@mail.gmail.com>
Subject: Re: [RFC v2 2/7] mm, slub: add opt-in slub_percpu_array
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 11, 2023 at 1:36=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> kmem_cache_setup_percpu_array() will allocate a per-cpu array for
> caching alloc/free objects of given size for the cache. The cache
> has to be created with SLAB_NO_MERGE flag.
>
> The array is filled by freeing. When empty for alloc or full for
> freeing, it's simply bypassed by the operation, there's currently no
> batch freeing/allocations.
>
> The locking is copied from the page allocator's pcplists, based on
> embedded spin locks. Interrupts are not disabled, only preemption (cpu
> migration on RT). Trylock is attempted to avoid deadlock due to
> an intnerrupt, trylock failure means the array is bypassed.

nit: s/intnerrupt/interrupt/

>  /*
>   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_al=
loc)
>   * have the fastpath folded into their functions. So no function call
> @@ -3465,7 +3564,11 @@ static __fastpath_inline void *slab_alloc_node(str=
uct kmem_cache *s, struct list
>         if (unlikely(object))
>                 goto out;
>
> -       object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> +       if (s->cpu_array)
> +               object =3D alloc_from_pca(s);
> +
> +       if (!object)
> +               object =3D __slab_alloc_node(s, gfpflags, node, addr, ori=
g_size);
>
>         maybe_wipe_obj_freeptr(s, object);
>         init =3D slab_want_init_on_alloc(gfpflags, s);
> @@ -3715,6 +3818,34 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>         discard_slab(s, slab);
>  }

>  #ifndef CONFIG_SLUB_TINY
>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free =
that
> @@ -3740,6 +3871,11 @@ static __always_inline void do_slab_free(struct km=
em_cache *s,
>         unsigned long tid;
>         void **freelist;
>
> +       if (s->cpu_array && cnt =3D=3D 1) {
> +               if (free_to_pca(s, head))
> +                       return;
> +       }
> +
>  redo:
>         /*
>          * Determine the currently cpus per cpu slab.
> @@ -3793,6 +3929,11 @@ static void do_slab_free(struct kmem_cache *s,
>  {
>         void *tail_obj =3D tail ? : head;
>
> +       if (s->cpu_array && cnt =3D=3D 1) {
> +               if (free_to_pca(s, head))
> +                       return;
> +       }
> +
>         __slab_free(s, slab, head, tail_obj, cnt, addr);
>  }
>  #endif /* CONFIG_SLUB_TINY */

Is this functionality needed for SLUB_TINY?

> @@ -4060,6 +4201,45 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gf=
p_t flags, size_t size,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>
> +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int c=
ount,
> +               gfp_t gfp)
> +{
> +       struct slub_percpu_array *pca;
> +       void *objects[32];
> +       unsigned int used;
> +       unsigned int allocated;
> +
> +       if (!s->cpu_array)
> +               return -EINVAL;
> +
> +       /* racy but we don't care */
> +       pca =3D raw_cpu_ptr(s->cpu_array);
> +
> +       used =3D READ_ONCE(pca->used);

Hmm for the prefill to be meaningful,
remote allocation should be possible, right?

Otherwise it only prefills for the CPU that requested it.

> +       if (used >=3D count)
> +               return 0;
> +
> +       if (pca->count < count)
> +               return -EINVAL;
> +
> +       count -=3D used;
> +
> +       /* TODO fix later */
> +       if (count > 32)
> +               count =3D 32;
> +
> +       for (int i =3D 0; i < count; i++)
> +               objects[i] =3D NULL;
> +       allocated =3D kmem_cache_alloc_bulk(s, gfp, count, &objects[0]);
> +
> +       for (int i =3D 0; i < count; i++) {
> +               if (objects[i]) {
> +                       kmem_cache_free(s, objects[i]);
> +               }
> +       }

nit: why not

for (int i =3D 0; i < allocated; i++) {
    kmem_cache_free(s, objects[i]);
}

and skip objects[i] =3D NULL

> +       return allocated;
> +}

And a question:
Does SLUB still need to maintain per-cpu partial slab lists even when
an opt-in percpu array is used?
