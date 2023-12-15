Return-Path: <linux-kernel+bounces-1666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E08151DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71219286D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1847F6B;
	Fri, 15 Dec 2023 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HK1zOnPQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AF47F5E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5cd81e76164so10109547b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702675092; x=1703279892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeTFEhw4NcnQUq7P2MBeYuMcPwPpR45ERNA9sxKzlgA=;
        b=HK1zOnPQR0OWE6luVK8BDZXkXWfuju8UK31z8KDwvPjiRVpPWarxAx8qa7OIkNHLTt
         Yxi/1DB3qXDloJQIPhuB83NuUPAv4bMSK6FkqKgQFsLfld+Bsr5U8ndNOlhPJgOQRs8p
         878VzrO/nuQbArmEIWnA/n+VmSv0evwrt8IrP4xFd+OnvzXWFR7sNNG+gfv43+2xi0QG
         Ihse1V4AUAwXqCO+VDdx719nYGElZDqfM/B1UhI5Vo3kFPG294wWo8PANYWJhnsoE4Bz
         e7dGRYs5DvkiYHY5gGU3g/4Fow3tNGD5nxrCnMBbBHK+noO6eqWA2ajQ9e1JSynCrbag
         7XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675092; x=1703279892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeTFEhw4NcnQUq7P2MBeYuMcPwPpR45ERNA9sxKzlgA=;
        b=uEoeVKt82Via6noozF3M3sLCx06mdsDwZkaCBfu8ZKnxBrti4rZj+ji29GLSO+NT1I
         jOKFRLooy4//jCEXUbkH1YmPgLolTpKL46J/8IQcA+I4WrzN/b+P4v5xO+KuXuKurc/J
         cnunwyW0iYGNac8qdxXSCPdNquoJm5o+47QM+QRlnt0cDhKOj9jcDbOmWz45Ra2Ygy9B
         NJI01+rmC9vj29zSUm4MTu/HfbcDyUBK2Yx1Vj2Ppa8J6GmdQwOJlvKd97rH9Y613o1p
         OXqAkiELT4CENv9kU1yZfth1jtwodz6ztsxoX9lqlEt28lmHmRtilOf46cT/6jVokfib
         ubHw==
X-Gm-Message-State: AOJu0Yz7z+lY7Ajp7JVyJL+37tVheJW8uXl8QSdOQSQV9FJSRC3F1Vrj
	n0eEKYDSQN6e0Tqr+fdNa1G1N1uflG57MlnoMu5M8A==
X-Google-Smtp-Source: AGHT+IE0BS5vdSz0trxNHjKLB5//ZcXTllQHn42IzSOfdEKo/iiNTMfVcrIFa78V9k80UsT/bybsxYWrZB8J6rlbpVg=
X-Received: by 2002:a0d:e6c3:0:b0:5e4:8956:a86e with SMTP id
 p186-20020a0de6c3000000b005e48956a86emr1181117ywe.24.1702675091222; Fri, 15
 Dec 2023 13:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
 <20231129-slub-percpu-caches-v3-5-6bcf536772bc@suse.cz> <CAJuCfpGeDEacej1grKJOBghtrh+qr6vOTRUh7NziTDaBxS9AAg@mail.gmail.com>
In-Reply-To: <CAJuCfpGeDEacej1grKJOBghtrh+qr6vOTRUh7NziTDaBxS9AAg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Dec 2023 13:17:58 -0800
Message-ID: <CAJuCfpEXWrH=KUsj2FfOw9aEc8A07=NwoosUqKb3s0Sg7geJAg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 5/9] mm/slub: add opt-in percpu array cache of objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:28=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Wed, Nov 29, 2023 at 1:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > kmem_cache_setup_percpu_array() will allocate a per-cpu array for
> > caching alloc/free objects of given size for the cache. The cache
> > has to be created with SLAB_NO_MERGE flag.
> >
> > When empty, half of the array is filled by an internal bulk alloc
> > operation. When full, half of the array is flushed by an internal bulk
> > free operation.
> >
> > The array does not distinguish NUMA locality of the cached objects. If
> > an allocation is requested with kmem_cache_alloc_node() with numa node
> > not equal to NUMA_NO_NODE, the array is bypassed.
> >
> > The bulk operations exposed to slab users also try to utilize the array
> > when possible, but leave the array empty or full and use the bulk
> > alloc/free only to finish the operation itself. If kmemcg is enabled an=
d
> > active, bulk freeing skips the array completely as it would be less
> > efficient to use it.
> >
> > The locking scheme is copied from the page allocator's pcplists, based
> > on embedded spin locks. Interrupts are not disabled, only preemption
> > (cpu migration on RT). Trylock is attempted to avoid deadlock due to an
> > interrupt; trylock failure means the array is bypassed.
> >
> > Sysfs stat counters alloc_cpu_cache and free_cpu_cache count objects
> > allocated or freed using the percpu array; counters cpu_cache_refill an=
d
> > cpu_cache_flush count objects refilled or flushed form the array.
> >
> > kmem_cache_prefill_percpu_array() can be called to ensure the array on
> > the current cpu to at least the given number of objects. However this i=
s
> > only opportunistic as there's no cpu pinning between the prefill and
> > usage, and trylocks may fail when the usage is in an irq handler.
> > Therefore allocations cannot rely on the array for success even after
> > the prefill. But misses should be rare enough that e.g. GFP_ATOMIC
> > allocations should be acceptable after the refill.
> >
> > When slub_debug is enabled for a cache with percpu array, the objects i=
n
> > the array are considered as allocated from the slub_debug perspective,
> > and the alloc/free debugging hooks occur when moving the objects betwee=
n
> > the array and slab pages. This means that e.g. an use-after-free that
> > occurs for an object cached in the array is undetected. Collected
> > alloc/free stacktraces might also be less useful. This limitation could
> > be changed in the future.
> >
> > On the other hand, KASAN, kmemcg and other hooks are executed on actual
> > allocations and frees by kmem_cache users even if those use the array,
> > so their debugging or accounting accuracy should be unaffected.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/slab.h     |   4 +
> >  include/linux/slub_def.h |  12 ++
> >  mm/Kconfig               |   1 +
> >  mm/slub.c                | 457 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  4 files changed, 468 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index d6d6ffeeb9a2..fe0c0981be59 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -197,6 +197,8 @@ struct kmem_cache *kmem_cache_create_usercopy(const=
 char *name,
> >  void kmem_cache_destroy(struct kmem_cache *s);
> >  int kmem_cache_shrink(struct kmem_cache *s);
> >
> > +int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int c=
ount);
> > +
> >  /*
> >   * Please use this macro to create slab caches. Simply specify the
> >   * name of the structure and maybe some flags that are listed above.
> > @@ -512,6 +514,8 @@ void kmem_cache_free(struct kmem_cache *s, void *ob=
jp);
> >  void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)=
;
> >  int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t si=
ze, void **p);
> >
> > +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int=
 count, gfp_t gfp);
> > +
> >  static __always_inline void kfree_bulk(size_t size, void **p)
> >  {
> >         kmem_cache_free_bulk(NULL, size, p);
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index deb90cf4bffb..2083aa849766 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -13,8 +13,10 @@
> >  #include <linux/local_lock.h>
> >
> >  enum stat_item {
> > +       ALLOC_PCA,              /* Allocation from percpu array cache *=
/
> >         ALLOC_FASTPATH,         /* Allocation from cpu slab */
> >         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab=
 */
> > +       FREE_PCA,               /* Free to percpu array cache */
> >         FREE_FASTPATH,          /* Free to cpu slab */
> >         FREE_SLOWPATH,          /* Freeing not to cpu slab */
> >         FREE_FROZEN,            /* Freeing to frozen slab */
> > @@ -39,6 +41,8 @@ enum stat_item {
> >         CPU_PARTIAL_FREE,       /* Refill cpu partial on free */
> >         CPU_PARTIAL_NODE,       /* Refill cpu partial from node partial=
 */
> >         CPU_PARTIAL_DRAIN,      /* Drain cpu partial to node partial */
> > +       PCA_REFILL,             /* Refilling empty percpu array cache *=
/
> > +       PCA_FLUSH,              /* Flushing full percpu array cache */
> >         NR_SLUB_STAT_ITEMS
> >  };
> >
> > @@ -66,6 +70,13 @@ struct kmem_cache_cpu {
> >  };
> >  #endif /* CONFIG_SLUB_TINY */
> >
> > +struct slub_percpu_array {
> > +       spinlock_t lock;
> > +       unsigned int count;
> > +       unsigned int used;
> > +       void * objects[];
> > +};
> > +
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >  #define slub_percpu_partial(c)         ((c)->partial)
> >
> > @@ -99,6 +110,7 @@ struct kmem_cache {
> >  #ifndef CONFIG_SLUB_TINY
> >         struct kmem_cache_cpu __percpu *cpu_slab;
> >  #endif
> > +       struct slub_percpu_array __percpu *cpu_array;
> >         /* Used for retrieving partial slabs, etc. */
> >         slab_flags_t flags;
> >         unsigned long min_partial;
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 89971a894b60..aa53c51bb4a6 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -237,6 +237,7 @@ choice
> >  config SLAB_DEPRECATED
> >         bool "SLAB (DEPRECATED)"
> >         depends on !PREEMPT_RT
> > +       depends on BROKEN
> >         help
> >           Deprecated and scheduled for removal in a few cycles. Replace=
d by
> >           SLUB.
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 59912a376c6d..f08bd71c244f 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -188,6 +188,79 @@ do {                                       \
> >  #define USE_LOCKLESS_FAST_PATH()       (false)
> >  #endif
> >
> > +/* copy/pasted  from mm/page_alloc.c */
> > +
> > +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
> > +/*
> > + * On SMP, spin_trylock is sufficient protection.
> > + * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
> > + */
> > +#define pcp_trylock_prepare(flags)     do { } while (0)
> > +#define pcp_trylock_finish(flag)       do { } while (0)
> > +#else
> > +
> > +/* UP spin_trylock always succeeds so disable IRQs to prevent re-entra=
ncy. */
> > +#define pcp_trylock_prepare(flags)     local_irq_save(flags)
> > +#define pcp_trylock_finish(flags)      local_irq_restore(flags)
> > +#endif
> > +
> > +/*
> > + * Locking a pcp requires a PCP lookup followed by a spinlock. To avoi=
d
> > + * a migration causing the wrong PCP to be locked and remote memory be=
ing
> > + * potentially allocated, pin the task to the CPU for the lookup+lock.
> > + * preempt_disable is used on !RT because it is faster than migrate_di=
sable.
> > + * migrate_disable is used on RT because otherwise RT spinlock usage i=
s
> > + * interfered with and a high priority task cannot preempt the allocat=
or.
> > + */
> > +#ifndef CONFIG_PREEMPT_RT
> > +#define pcpu_task_pin()                preempt_disable()
> > +#define pcpu_task_unpin()      preempt_enable()
> > +#else
> > +#define pcpu_task_pin()                migrate_disable()
> > +#define pcpu_task_unpin()      migrate_enable()
> > +#endif
> > +
> > +/*
> > + * Generic helper to lookup and a per-cpu variable with an embedded sp=
inlock.
> > + * Return value should be used with equivalent unlock helper.
> > + */
> > +#define pcpu_spin_lock(type, member, ptr)                             =
 \
> > +({                                                                    =
 \
> > +       type *_ret;                                                    =
 \
> > +       pcpu_task_pin();                                               =
 \
> > +       _ret =3D this_cpu_ptr(ptr);                                    =
   \
> > +       spin_lock(&_ret->member);                                      =
 \
> > +       _ret;                                                          =
 \
> > +})
> > +
> > +#define pcpu_spin_trylock(type, member, ptr)                          =
 \
> > +({                                                                    =
 \
> > +       type *_ret;                                                    =
 \
> > +       pcpu_task_pin();                                               =
 \
> > +       _ret =3D this_cpu_ptr(ptr);                                    =
   \
> > +       if (!spin_trylock(&_ret->member)) {                            =
 \
> > +               pcpu_task_unpin();                                     =
 \
> > +               _ret =3D NULL;                                         =
   \
> > +       }                                                              =
 \
> > +       _ret;                                                          =
 \
> > +})
> > +
> > +#define pcpu_spin_unlock(member, ptr)                                 =
 \
> > +({                                                                    =
 \
> > +       spin_unlock(&ptr->member);                                     =
 \
> > +       pcpu_task_unpin();                                             =
 \
> > +})
> > +
> > +/* struct slub_percpu_array specific helpers. */
> > +#define pca_spin_lock(ptr)                                            =
 \
> > +       pcpu_spin_lock(struct slub_percpu_array, lock, ptr)
> > +
> > +#define pca_spin_trylock(ptr)                                         =
 \
> > +       pcpu_spin_trylock(struct slub_percpu_array, lock, ptr)
> > +
> > +#define pca_spin_unlock(ptr)                                          =
 \
> > +       pcpu_spin_unlock(lock, ptr)
> > +
> >  #ifndef CONFIG_SLUB_TINY
> >  #define __fastpath_inline __always_inline
> >  #else
> > @@ -3454,6 +3527,78 @@ static __always_inline void maybe_wipe_obj_freep=
tr(struct kmem_cache *s,
> >                         0, sizeof(void *));
> >  }
> >
> > +static bool refill_pca(struct kmem_cache *s, unsigned int count, gfp_t=
 gfp);
> > +
> > +static __fastpath_inline
> > +void *alloc_from_pca(struct kmem_cache *s, gfp_t gfp)
> > +{
> > +       unsigned long __maybe_unused UP_flags;
> > +       struct slub_percpu_array *pca;
> > +       void *object;
> > +
> > +retry:
> > +       pcp_trylock_prepare(UP_flags);
> > +       pca =3D pca_spin_trylock(s->cpu_array);
> > +
> > +       if (unlikely(!pca)) {
> > +               pcp_trylock_finish(UP_flags);
> > +               return NULL;
> > +       }
> > +
> > +       if (unlikely(pca->used =3D=3D 0)) {
> > +               unsigned int batch =3D pca->count / 2;
> > +
> > +               pca_spin_unlock(pca);
> > +               pcp_trylock_finish(UP_flags);
> > +
> > +               if (!gfpflags_allow_blocking(gfp) || in_irq())
> > +                       return NULL;
> > +
> > +               if (refill_pca(s, batch, gfp))
> > +                       goto retry;
> > +
> > +               return NULL;
> > +       }
> > +
> > +       object =3D pca->objects[--pca->used];
> > +
> > +       pca_spin_unlock(pca);
> > +       pcp_trylock_finish(UP_flags);
> > +
> > +       stat(s, ALLOC_PCA);
> > +
> > +       return object;
> > +}
> > +
> > +static __fastpath_inline
> > +int alloc_from_pca_bulk(struct kmem_cache *s, size_t size, void **p)
> > +{
> > +       unsigned long __maybe_unused UP_flags;
> > +       struct slub_percpu_array *pca;
> > +
> > +       pcp_trylock_prepare(UP_flags);
> > +       pca =3D pca_spin_trylock(s->cpu_array);
> > +
> > +       if (unlikely(!pca)) {
> > +               size =3D 0;
> > +               goto failed;
> > +       }
> > +
> > +       if (pca->used < size)
> > +               size =3D pca->used;
> > +
> > +       for (int i =3D size; i > 0;) {
> > +               p[--i] =3D pca->objects[--pca->used];
> > +       }
> > +
> > +       pca_spin_unlock(pca);
> > +       stat_add(s, ALLOC_PCA, size);
> > +
> > +failed:
> > +       pcp_trylock_finish(UP_flags);
> > +       return size;
> > +}
> > +
> >  /*
> >   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_=
alloc)
> >   * have the fastpath folded into their functions. So no function call
> > @@ -3479,7 +3624,11 @@ static __fastpath_inline void *slab_alloc_node(s=
truct kmem_cache *s, struct list
> >         if (unlikely(object))
> >                 goto out;
> >
> > -       object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_size=
);
> > +       if (s->cpu_array && (node =3D=3D NUMA_NO_NODE))
> > +               object =3D alloc_from_pca(s, gfpflags);
> > +
> > +       if (!object)
> > +               object =3D __slab_alloc_node(s, gfpflags, node, addr, o=
rig_size);
> >
> >         maybe_wipe_obj_freeptr(s, object);
> >         init =3D slab_want_init_on_alloc(gfpflags, s);
> > @@ -3726,6 +3875,81 @@ static void __slab_free(struct kmem_cache *s, st=
ruct slab *slab,
> >         discard_slab(s, slab);
> >  }
> >
> > +static bool flush_pca(struct kmem_cache *s, unsigned int count);
> > +
> > +static __fastpath_inline
> > +bool free_to_pca(struct kmem_cache *s, void *object)
> > +{
> > +       unsigned long __maybe_unused UP_flags;
> > +       struct slub_percpu_array *pca;
> > +
> > +retry:
> > +       pcp_trylock_prepare(UP_flags);
> > +       pca =3D pca_spin_trylock(s->cpu_array);
> > +
> > +       if (!pca) {
> > +               pcp_trylock_finish(UP_flags);
> > +               return false;
> > +       }
> > +
> > +       if (pca->used =3D=3D pca->count) {
> > +               unsigned int batch =3D pca->count / 2;
> > +
> > +               pca_spin_unlock(pca);
> > +               pcp_trylock_finish(UP_flags);
> > +
> > +               if (in_irq())
> > +                       return false;
> > +
> > +               if (!flush_pca(s, batch))
> > +                       return false;
> > +
> > +               goto retry;
> > +       }
> > +
> > +       pca->objects[pca->used++] =3D object;
> > +
> > +       pca_spin_unlock(pca);
> > +       pcp_trylock_finish(UP_flags);
> > +
> > +       stat(s, FREE_PCA);
> > +
> > +       return true;
> > +}
> > +
> > +static __fastpath_inline
> > +size_t free_to_pca_bulk(struct kmem_cache *s, size_t size, void **p)
> > +{
> > +       unsigned long __maybe_unused UP_flags;
> > +       struct slub_percpu_array *pca;
> > +       bool init;
> > +
> > +       pcp_trylock_prepare(UP_flags);
> > +       pca =3D pca_spin_trylock(s->cpu_array);
> > +
> > +       if (unlikely(!pca)) {
> > +               size =3D 0;
> > +               goto failed;
> > +       }
> > +
> > +       if (pca->count - pca->used < size)
> > +               size =3D pca->count - pca->used;
> > +
> > +       init =3D slab_want_init_on_free(s);
> > +
> > +       for (size_t i =3D 0; i < size; i++) {
> > +               if (likely(slab_free_hook(s, p[i], init)))
> > +                       pca->objects[pca->used++] =3D p[i];
> > +       }
> > +
> > +       pca_spin_unlock(pca);
> > +       stat_add(s, FREE_PCA, size);
> > +
> > +failed:
> > +       pcp_trylock_finish(UP_flags);
> > +       return size;
> > +}
> > +
> >  #ifndef CONFIG_SLUB_TINY
> >  /*
> >   * Fastpath with forced inlining to produce a kfree and kmem_cache_fre=
e that
> > @@ -3811,7 +4035,12 @@ void slab_free(struct kmem_cache *s, struct slab=
 *slab, void *object,
> >  {
> >         memcg_slab_free_hook(s, slab, &object, 1);
> >
> > -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))=
))
> > +       if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(=
s))))
> > +               return;
> > +
> > +       if (s->cpu_array)
> > +               free_to_pca(s, object);
>
> free_to_pca() can return false and leave the object alive. I think you
> need to handle the failure case here to avoid leaks.
>
> > +       else
> >                 do_slab_free(s, slab, object, object, 1, addr);
> >  }
> >
> > @@ -3956,6 +4185,26 @@ void kmem_cache_free_bulk(struct kmem_cache *s, =
size_t size, void **p)
> >         if (!size)
> >                 return;
> >
> > +       /*
> > +        * In case the objects might need memcg_slab_free_hook(), skip =
the array
> > +        * because the hook is not effective with single objects and be=
nefits
> > +        * from groups of objects from a single slab that the detached =
freelist
> > +        * builds. But once we build the detached freelist, it's wastef=
ul to
> > +        * throw it away and put the objects into the array.
> > +        *
> > +        * XXX: This test could be cache-specific if it was not possibl=
e to use
> > +        * __GFP_ACCOUNT with caches that are not SLAB_ACCOUNT
> > +        */
> > +       if (s && s->cpu_array && !memcg_kmem_online()) {
> > +               size_t pca_freed =3D free_to_pca_bulk(s, size, p);
> > +
> > +               if (pca_freed =3D=3D size)
> > +                       return;
> > +
> > +               p +=3D pca_freed;
> > +               size -=3D pca_freed;
> > +       }
> > +
> >         do {
> >                 struct detached_freelist df;
> >
> > @@ -4073,7 +4322,8 @@ static int __kmem_cache_alloc_bulk(struct kmem_ca=
che *s, gfp_t flags,
> >  int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t si=
ze,
> >                           void **p)
> >  {
> > -       int i;
> > +       int from_pca =3D 0;
> > +       int allocated =3D 0;
> >         struct obj_cgroup *objcg =3D NULL;
> >
> >         if (!size)
> > @@ -4084,19 +4334,147 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s=
, gfp_t flags, size_t size,
> >         if (unlikely(!s))
> >                 return 0;
> >
> > -       i =3D __kmem_cache_alloc_bulk(s, flags, size, p);
> > +       if (s->cpu_array)
> > +               from_pca =3D alloc_from_pca_bulk(s, size, p);
> > +
> > +       if (from_pca < size) {
> > +               allocated =3D __kmem_cache_alloc_bulk(s, flags, size-fr=
om_pca,
> > +                                                   p+from_pca);
> > +               if (allocated =3D=3D 0 && from_pca > 0) {
> > +                       __kmem_cache_free_bulk(s, from_pca, p);
> > +               }
> > +       }
> > +
> > +       allocated +=3D from_pca;
> >
> >         /*
> >          * memcg and kmem_cache debug support and memory initialization=
.
> >          * Done outside of the IRQ disabled fastpath loop.
> >          */
> > -       if (i !=3D 0)
> > +       if (allocated !=3D 0)
> >                 slab_post_alloc_hook(s, objcg, flags, size, p,
> >                         slab_want_init_on_alloc(flags, s), s->object_si=
ze);
> > -       return i;
> > +       return allocated;
> >  }
> >  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> >
> > +static bool refill_pca(struct kmem_cache *s, unsigned int count, gfp_t=
 gfp)
> > +{
> > +       void *objects[32];
> > +       unsigned int batch, allocated;
> > +       unsigned long __maybe_unused UP_flags;
> > +       struct slub_percpu_array *pca;
> > +
> > +bulk_alloc:
> > +       batch =3D min(count, 32U);
>
> Do you cap each batch at 32 to avoid overshooting too much (same in
> flush_pca())? If so, it would be good to have a comment here. Also,
> maybe this hardcoded 32 should be a function of pca->count instead? If
> we set up a pca array with pca->count larger than 64 then the refill
> count of pca->count/2 will always end up higher than 32, so at the end
> we will have to loop back (goto bulk_alloc) to allocate more objects.

Ah, I just noticed that you are using objects[32] and that's forcing
this limitation. Please ignore my previous comment.

>
> > +
> > +       allocated =3D __kmem_cache_alloc_bulk(s, gfp, batch, &objects[0=
]);
> > +       if (!allocated)
> > +               return false;
> > +
> > +       pcp_trylock_prepare(UP_flags);
> > +       pca =3D pca_spin_trylock(s->cpu_array);
> > +       if (!pca) {
> > +               pcp_trylock_finish(UP_flags);
> > +               return false;
> > +       }
> > +
> > +       batch =3D min(allocated, pca->count - pca->used);
> > +
> > +       for (unsigned int i =3D 0; i < batch; i++) {
> > +               pca->objects[pca->used++] =3D objects[i];
> > +       }
> > +
> > +       pca_spin_unlock(pca);
> > +       pcp_trylock_finish(UP_flags);
> > +
> > +       stat_add(s, PCA_REFILL, batch);
> > +
> > +       /*
> > +        * We could have migrated to a different cpu or somebody else f=
reed to the
> > +        * pca while we were bulk allocating, and now we have too many =
objects
> > +        */
> > +       if (batch < allocated) {
> > +               __kmem_cache_free_bulk(s, allocated - batch, &objects[b=
atch]);
> > +       } else {
> > +               count -=3D batch;
> > +               if (count > 0)
> > +                       goto bulk_alloc;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +static bool flush_pca(struct kmem_cache *s, unsigned int count)
> > +{
> > +       void *objects[32];
> > +       unsigned int batch, remaining;
> > +       unsigned long __maybe_unused UP_flags;
> > +       struct slub_percpu_array *pca;
> > +
> > +next_batch:
> > +       batch =3D min(count, 32);
> > +
> > +       pcp_trylock_prepare(UP_flags);
> > +       pca =3D pca_spin_trylock(s->cpu_array);
> > +       if (!pca) {
> > +               pcp_trylock_finish(UP_flags);
> > +               return false;
> > +       }
> > +
> > +       batch =3D min(batch, pca->used);
> > +
> > +       for (unsigned int i =3D 0; i < batch; i++) {
> > +               objects[i] =3D pca->objects[--pca->used];
> > +       }
> > +
> > +       remaining =3D pca->used;
> > +
> > +       pca_spin_unlock(pca);
> > +       pcp_trylock_finish(UP_flags);
> > +
> > +       __kmem_cache_free_bulk(s, batch, &objects[0]);
> > +
> > +       stat_add(s, PCA_FLUSH, batch);
> > +
> > +       if (batch < count && remaining > 0) {
> > +               count -=3D batch;
> > +               goto next_batch;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +/* Do not call from irq handler nor with irqs disabled */
> > +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int=
 count,
> > +                                   gfp_t gfp)
> > +{
> > +       struct slub_percpu_array *pca;
> > +       unsigned int used;
> > +
> > +       lockdep_assert_no_hardirq();
> > +
> > +       if (!s->cpu_array)
> > +               return -EINVAL;
> > +
> > +       /* racy but we don't care */
> > +       pca =3D raw_cpu_ptr(s->cpu_array);
> > +
> > +       used =3D READ_ONCE(pca->used);
> > +
> > +       if (used >=3D count)
> > +               return 0;
> > +
> > +       if (pca->count < count)
> > +               return -EINVAL;
> > +
> > +       count -=3D used;
> > +
> > +       if (!refill_pca(s, count, gfp))
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> >
> >  /*
> >   * Object placement in a slab is made very easy because we always star=
t at
> > @@ -5167,6 +5545,65 @@ int __kmem_cache_create(struct kmem_cache *s, sl=
ab_flags_t flags)
> >         return 0;
> >  }
> >
> > +/**
> > + * kmem_cache_setup_percpu_array - Create a per-cpu array cache for th=
e cache
> > + * @s: The cache to add per-cpu array. Must be created with SLAB_NO_ME=
RGE flag.
> > + * @count: Size of the per-cpu array.
> > + *
> > + * After this call, allocations from the cache go through a percpu arr=
ay. When
> > + * it becomes empty, half is refilled with a bulk allocation. When it =
becomes
> > + * full, half is flushed with a bulk free operation.
> > + *
> > + * Using the array cache is not guaranteed, i.e. it can be bypassed if=
 its lock
> > + * cannot be obtained. The array cache also does not distinguish NUMA =
nodes, so
> > + * allocations via kmem_cache_alloc_node() with a node specified other=
 than
> > + * NUMA_NO_NODE will bypass the cache.
> > + *
> > + * Bulk allocation and free operations also try to use the array.
> > + *
> > + * kmem_cache_prefill_percpu_array() can be used to pre-fill the array=
 cache
> > + * before e.g. entering a restricted context. It is however not guaran=
teed that
> > + * the caller will be able to subsequently consume the prefilled cache=
. Such
> > + * failures should be however sufficiently rare so after the prefill,
> > + * allocations using GFP_ATOMIC | __GFP_NOFAIL are acceptable for obje=
cts up to
> > + * the prefilled amount.
> > + *
> > + * Limitations: when slub_debug is enabled for the cache, all relevant=
 actions
> > + * (i.e. poisoning, obtaining stacktraces) and checks happen when obje=
cts move
> > + * between the array cache and slab pages, which may result in e.g. no=
t
> > + * detecting a use-after-free while the object is in the array cache, =
and the
> > + * stacktraces may be less useful.
> > + *
> > + * Return: 0 if OK, -EINVAL on caches without SLAB_NO_MERGE or with th=
e array
> > + * already created, -ENOMEM when the per-cpu array creation fails.
> > + */
> > +int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int c=
ount)
> > +{
> > +       int cpu;
> > +
> > +       if (WARN_ON_ONCE(!(s->flags & SLAB_NO_MERGE)))
> > +               return -EINVAL;
> > +
> > +       if (s->cpu_array)
> > +               return -EINVAL;
> > +
> > +       s->cpu_array =3D __alloc_percpu(struct_size(s->cpu_array, objec=
ts, count),
> > +                                       sizeof(void *));
>
> Maybe I missed it, but where do you free s->cpu_array? I see
> __kmem_cache_release() freeing s->cpu_slab but s->cpu_array seems to
> be left alive...
>
> > +
> > +       if (!s->cpu_array)
> > +               return -ENOMEM;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               struct slub_percpu_array *pca =3D per_cpu_ptr(s->cpu_ar=
ray, cpu);
> > +
> > +               spin_lock_init(&pca->lock);
> > +               pca->count =3D count;
> > +               pca->used =3D 0;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  #ifdef SLAB_SUPPORTS_SYSFS
> >  static int count_inuse(struct slab *slab)
> >  {
> > @@ -5944,8 +6381,10 @@ static ssize_t text##_store(struct kmem_cache *s=
,                \
> >  }                                                              \
> >  SLAB_ATTR(text);                                               \
> >
> > +STAT_ATTR(ALLOC_PCA, alloc_cpu_cache);
> >  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
> >  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> > +STAT_ATTR(FREE_PCA, free_cpu_cache);
> >  STAT_ATTR(FREE_FASTPATH, free_fastpath);
> >  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
> >  STAT_ATTR(FREE_FROZEN, free_frozen);
> > @@ -5970,6 +6409,8 @@ STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
> >  STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
> >  STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> >  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
> > +STAT_ATTR(PCA_REFILL, cpu_cache_refill);
> > +STAT_ATTR(PCA_FLUSH, cpu_cache_flush);
> >  #endif /* CONFIG_SLUB_STATS */
> >
> >  #ifdef CONFIG_KFENCE
> > @@ -6031,8 +6472,10 @@ static struct attribute *slab_attrs[] =3D {
> >         &remote_node_defrag_ratio_attr.attr,
> >  #endif
> >  #ifdef CONFIG_SLUB_STATS
> > +       &alloc_cpu_cache_attr.attr,
> >         &alloc_fastpath_attr.attr,
> >         &alloc_slowpath_attr.attr,
> > +       &free_cpu_cache_attr.attr,
> >         &free_fastpath_attr.attr,
> >         &free_slowpath_attr.attr,
> >         &free_frozen_attr.attr,
> > @@ -6057,6 +6500,8 @@ static struct attribute *slab_attrs[] =3D {
> >         &cpu_partial_free_attr.attr,
> >         &cpu_partial_node_attr.attr,
> >         &cpu_partial_drain_attr.attr,
> > +       &cpu_cache_refill_attr.attr,
> > +       &cpu_cache_flush_attr.attr,
> >  #endif
> >  #ifdef CONFIG_FAILSLAB
> >         &failslab_attr.attr,
> >
> > --
> > 2.43.0
> >
> >

