Return-Path: <linux-kernel+bounces-143592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1518A3B33
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A5D1F22850
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506751CAB7;
	Sat, 13 Apr 2024 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKTUpq2k"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409B18633
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712987910; cv=none; b=Hcctm3npxat9ixh/eyG1VdU0JhKTbAYrqLg6iq3M7gR7eNt2+2ouSYJyxN12PH1VOAgMqWACAPMB0LDOugO3F3LpuY+t1AR6CmCfuG4v0i4De4DVYKloFyPyBC4bLmXLqkyPSNtZRehYu3jEeUz2Dbq4wMnMrVRfz1X0AFB818g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712987910; c=relaxed/simple;
	bh=HU7thTIYtcC0c7hByVsU2/c6aP4NzI8KDTBbxSEhy5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P61TmSId8AecVeI6G0ZntTdmaOzgUKJIRZt4Sf87CVFWgzQo/5bkzMHk7lj74adSkgyco0uIzAResAtoS6mbdlzPnaBBCnGlPCbaGiVy5X9vjU+3r2MRQ+czy3jU/u4Otc24x+4uT5Na0AmHjIZ0yb50yEhvSv/AgOjN4ttT0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKTUpq2k; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2330f85c2ebso1029301fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712987907; x=1713592707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjFvmkrzi13rpe1gaHU7tj05ZLNOeYzGSqdwOX09dTo=;
        b=IKTUpq2kryWh/Ax17Mtq1fC3aAzKuDAJ3GK5/qPe/ehfbWbRjf5l28nXaXpImXLmNk
         NvOEcgSoEQhNX1MSYN8cRhicuPsqnO+tpJLSKuGJvxQiMlFC6G1+OBXLYlQZksOBAM7i
         4EicSYeSQKG3XQ7E7YhWu3bhHYF97i5J9DAXmiVkJ5wWFGtAdulUjXd85qA1gKomqizj
         yaEujmaQDTFlLXNt0ix1ytq/nHe36EEiUNCSAp4cJuWtBcAepxbbSoGMqmV4KfdNfigQ
         UPGxaKRmaIDhZ21ueBcAbj6/fMzU+9Ahzeeb97Yx+HLjSxrJNIt+Aqis18JIOaiV/Q8u
         zeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712987907; x=1713592707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjFvmkrzi13rpe1gaHU7tj05ZLNOeYzGSqdwOX09dTo=;
        b=izH4RVl3ZwSd59Pcs9NYLSqA9hmg68fgwqRJmTnp3RFhtRNZycqymiRT9n8G1hrMu5
         olvdM1bokMCrjkluNS1VPo/+V/YdUK5Hv92JzvdaoHN1QntJIHoiXCE38YrOnD76yKY/
         kE2GTpew1+Cnc0YSSnWJaVNvMiBJAq1vSdlV2YiPEyuFUudXwgRxhzjfFs4ZRIEW24OJ
         9GwuGKLHRmpVGpqSQM/urT8v5JjA1hgg/7BDQaeI5IMhZE/snoOOnxjIOwz6U+CUbwem
         +QUn2OC5ZKMdBxJMEWeqsuIHTUd0zVGtHfPhucD4aAIi1C6xhvhcu2wm1RmqDNPlL/ux
         eaew==
X-Forwarded-Encrypted: i=1; AJvYcCVQsnwulUHnZakit8vGVzLLxm8xgqWt/dRhH8YhGlCQ0YMvNonyC9l8FGTEGvUCW5/QlGbkKgIlc5kJewrtULUaRfpTnpcbPzWGS08C
X-Gm-Message-State: AOJu0YwN6jMrR8OXeCK6vm0ojbbOwaDgqp7k10733WFKf7lLP5nwoM0a
	PSe8wK2QOMwGqM1ctpnjaeB608lsxljdXe4CRb9ep+JgcY5QOjExvKyZwzriY9KEPOBXNGR1kRh
	cSeQpjvHeySSXXeMo8REsITcFKt9+tHkPB4M=
X-Google-Smtp-Source: AGHT+IFb+k36oaBQOwp8PZ6UyEoUSHB/QVqViPq1CEHfj4ru0PRI5QbdNndx+Q8+hZQNZXKJrDX0dXX3kCOqO5mlx1U=
X-Received: by 2002:a05:6870:430e:b0:221:8a03:6dea with SMTP id
 w14-20020a056870430e00b002218a036deamr5316637oah.38.1712987907512; Fri, 12
 Apr 2024 22:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413015410.30951-1-lipeifeng@oppo.com> <CAGsJ_4yGTcgMnK_81hMUAL0xG06Nmu0kn3bwdQHhSiDV8HQ+ZA@mail.gmail.com>
 <00861870-5c40-4f00-b91f-fc4cfb4a780b@oppo.com>
In-Reply-To: <00861870-5c40-4f00-b91f-fc4cfb4a780b@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 13 Apr 2024 17:58:16 +1200
Message-ID: <CAGsJ_4ynP79dc7j9jQbMgyyTNJzEzyBCiBpqJgeW0QN0NvgOHQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
To: lipeifeng@oppo.com
Cc: akpm@linux-foundation.org, david@fromorbit.com, zhengqi.arch@bytedance.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 5:42=E2=80=AFPM =E6=9D=8E=E5=9F=B9=E9=94=8B <lipeif=
eng@oppo.com> wrote:
>
>
> =E5=9C=A8 2024/4/13 13:19, Barry Song =E5=86=99=E9=81=93:
> > On Sat, Apr 13, 2024 at 1:54=E2=80=AFPM <lipeifeng@oppo.com> wrote:
> >> From: Peifeng Li <lipeifeng@oppo.com>
> >>
> >> In the case of insufficient memory, threads will be in direct_reclaim =
to
> >> reclaim memory, direct_reclaim will call shrink_slab to run sequential=
ly
> >> each shrinker callback. If there is a lock-contention in the shrinker
> >> callback,such as spinlock,mutex_lock and so on, threads may be likely =
to
> >> be stuck in direct_reclaim for a long time, even if the memfree has re=
ached
> >> the high watermarks of the zone, resulting in poor performance of thre=
ads.
> >>
> >> Example 1: shrinker callback may wait for spinlock
> >> static unsigned long mb_cache_shrink(struct mb_cache *cache,
> >>                                       unsigned long nr_to_scan)
> >> {
> >>          struct mb_cache_entry *entry;
> >>          unsigned long shrunk =3D 0;
> >>
> >>          spin_lock(&cache->c_list_lock);
> >>          while (nr_to_scan-- && !list_empty(&cache->c_list)) {
> >>                  entry =3D list_first_entry(&cache->c_list,
> >>                                           struct mb_cache_entry, e_lis=
t);
> >>                  if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
> >>                      atomic_cmpxchg(&entry->e_refcnt, 1, 0) !=3D 1) {
> >>                          clear_bit(MBE_REFERENCED_B, &entry->e_flags);
> >>                          list_move_tail(&entry->e_list, &cache->c_list=
);
> >>                          continue;
> >>                  }
> >>                  list_del_init(&entry->e_list);
> >>                  cache->c_entry_count--;
> >>                  spin_unlock(&cache->c_list_lock);
> >>                  __mb_cache_entry_free(cache, entry);
> >>                  shrunk++;
> >>                  cond_resched();
> >>                  spin_lock(&cache->c_list_lock);
> >>          }
> >>          spin_unlock(&cache->c_list_lock);
> >>
> >>          return shrunk;
> >> }
> >> Example 2: shrinker callback may wait for mutex lock
> >> static
> >> unsigned long kbase_mem_evictable_reclaim_scan_objects(struct shrinker=
 *s,
> >>                  struct shrink_control *sc)
> >> {
> >>          struct kbase_context *kctx;
> >>          struct kbase_mem_phy_alloc *alloc;
> >>          struct kbase_mem_phy_alloc *tmp;
> >>          unsigned long freed =3D 0;
> >>
> >>          kctx =3D container_of(s, struct kbase_context, reclaim);
> >>
> >>          // MTK add to prevent false alarm
> >>          lockdep_off();
> >>
> >>          mutex_lock(&kctx->jit_evict_lock);
> >>
> >>          list_for_each_entry_safe(alloc, tmp, &kctx->evict_list, evict=
_node) {
> >>                  int err;
> >>
> >>                  err =3D kbase_mem_shrink_gpu_mapping(kctx, alloc->reg=
,
> >>                                  0, alloc->nents);
> >>                  if (err !=3D 0) {
> >>                          freed =3D -1;
> >>                          goto out_unlock;
> >>                  }
> >>
> >>                  alloc->evicted =3D alloc->nents;
> >>
> >>                  kbase_free_phy_pages_helper(alloc, alloc->evicted);
> >>                  freed +=3D alloc->evicted;
> >>                  list_del_init(&alloc->evict_node);
> >>
> >>                  kbase_jit_backing_lost(alloc->reg);
> >>
> >>                  if (freed > sc->nr_to_scan)
> >>                          break;
> >>          }
> >> out_unlock:
> >>          mutex_unlock(&kctx->jit_evict_lock);
> >>
> >>          // MTK add to prevent false alarm
> >>          lockdep_on();
> >>
> >>          return freed;
> >> }
> >>
> >> In mobile-phone,threads are likely to be stuck in shrinker callback du=
ring
> >> direct_reclaim, with example like the following:
> >> <...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
> >>                          dynamic_mem_shrink_scan+0x0/0xb8 ... priority=
 2
> >> <...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
> >>                          dynamic_mem_shrink_scan+0x0/0xb8 ...
> >>
> >> For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM =
that
> >> allows driver to set shrinker callback not to be called in direct_recl=
aim
> >> unless sc->priority is 0.
> >>
> >> The reason why sc->priority=3D0 allows shrinker callback to be called =
in
> >> direct_reclaim is for two reasons:
> >> 1.Always call all shrinker callback in drop_slab that priority is 0.
> >> 2.sc->priority is 0 during direct_reclaim, allow direct_reclaim to cal=
l
> >> shrinker callback, to reclaim memory timely.

We already provide current_is_kswapd() and shrinker_control to drivers. If =
you
believe that sc->priority can assist shrinker callbacks in behaving
differently, why
not simply pass it along with the shrinker_control and allow drivers
to decide their
preferred course of action?

I don't find it reasonable to reverse the approach. Allowing drivers
to pass a flag
to the memory management core doesn't seem sensible.

> >>
> >> Note:
> >> 1.shrinker_register() default not to set SHRINKER_NO_DIRECT_RECLAIM, t=
o
> >> maintain the current behavior of the code.
> >> 2.Logic of kswapd and drop_slab to call shrinker callback isn't affect=
ed.
> >>
> >> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
> >> ---
> >> -v2: fix the commit message
> >>   include/linux/shrinker.h |  5 +++++
> >>   mm/shrinker.c            | 38 +++++++++++++++++++++++++++++++++++---
> >>   2 files changed, 40 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> >> index 1a00be90d93a..2d5a8b3a720b 100644
> >> --- a/include/linux/shrinker.h
> >> +++ b/include/linux/shrinker.h
> >> @@ -130,6 +130,11 @@ struct shrinker {
> >>    * non-MEMCG_AWARE shrinker should not have this flag set.
> >>    */
> >>   #define SHRINKER_NONSLAB       BIT(4)
> >> +/*
> >> + * Can shrinker callback be called in direct_relcaim unless
> >> + * sc->priority is 0?
> >> + */
> >> +#define SHRINKER_NO_DIRECT_RECLAIM     BIT(5)
> >>
> > My point is, drivers won't voluntarily stay unreclaimed during direct
> > reclamation. Hence, this approach is unlikely to succeed. Those
> > drivers can't be trusted. Had they been aware of their slowness,
> > they wouldn't have written code in this manner.
>
> Actually, we hope there is a way for us to solve the block of shrinker
> callback,
>
> Because many drivers can't remove their lock in shrinker callback
> timely, with
>
> the flags, we can tell drivers to add it.
>
> > Detecting problematic driver shrinkers and marking them as skipped
> > might prove challenging. I concur with Zhengqi; the priority should
> > be fixing the driver whose shrinker is slow. Do you have a list of
> > slow drivers?
>
> Most of slow drivers hadn't been upstreamed, so that we can not gather
>
> a list of slow drivers.
>
> I am curious if executing do_shrink_slab() asynchronously could be accept=
ed
>
> in Linux? or executing part of shrinker callbacks asynchronously?

That entirely hinges on the type of data we possess. As Zhengqi pointed out=
,
asynchronous slab shrinkers could also impede memory reclamation. If the
data eventually shows that this isn't an issue, asynchronous slab shrinkers
might discover a solution.

>
> In my mind, if the memory-reclaim-path of the kernel would be affected by
>
> the driver, the robustness of the kernel will be greatly reduced.
>
> >
> >
> >>   __printf(2, 3)
> >>   struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt,=
 ...);
> >> diff --git a/mm/shrinker.c b/mm/shrinker.c
> >> index dc5d2a6fcfc4..7a5dffd166cd 100644
> >> --- a/mm/shrinker.c
> >> +++ b/mm/shrinker.c
> >> @@ -4,7 +4,7 @@
> >>   #include <linux/shrinker.h>
> >>   #include <linux/rculist.h>
> >>   #include <trace/events/vmscan.h>
> >> -
> >> +#include <linux/swap.h>
> >>   #include "internal.h"
> >>
> >>   LIST_HEAD(shrinker_list);
> >> @@ -544,7 +544,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_=
mask, int nid,
> >>                          if (!memcg_kmem_online() &&
> >>                              !(shrinker->flags & SHRINKER_NONSLAB))
> >>                                  continue;
> >> -
> >> +                       /*
> >> +                        * SHRINKER_NO_DIRECT_RECLAIM, mean that shrin=
ker callback
> >> +                        * should not be called in direct_reclaim unle=
ss priority
> >> +                        * is 0.
> >> +                        */
> >> +                       if ((shrinker->flags & SHRINKER_NO_DIRECT_RECL=
AIM) &&
> >> +                                       !current_is_kswapd()) {
> >> +                               /*
> >> +                                * 1.Always call shrinker callback in =
drop_slab that
> >> +                                * priority is 0.
> >> +                                * 2.sc->priority is 0 during direct_r=
eclaim, allow
> >> +                                * direct_reclaim to call shrinker cal=
lback, to reclaim
> >> +                                * memory timely.
> >> +                                */
> >> +                               if (priority)
> >> +                                       continue;
> >> +                       }
> >>                          ret =3D do_shrink_slab(&sc, shrinker, priorit=
y);
> >>                          if (ret =3D=3D SHRINK_EMPTY) {
> >>                                  clear_bit(offset, unit->map);
> >> @@ -658,7 +674,23 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid=
, struct mem_cgroup *memcg,
> >>                          continue;
> >>
> >>                  rcu_read_unlock();
> >> -
> >> +               /*
> >> +                * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker call=
back
> >> +                * should not be called in direct_reclaim unless prior=
ity
> >> +                * is 0.
> >> +                */
> >> +               if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
> >> +                               !current_is_kswapd()) {
> >> +                       /*
> >> +                        * 1.Always call shrinker callback in drop_sla=
b that
> >> +                        * priority is 0.
> >> +                        * 2.sc->priority is 0 during direct_reclaim, =
allow
> >> +                        * direct_reclaim to call shrinker callback, t=
o reclaim
> >> +                        * memory timely.
> >> +                        */
> >> +                       if (priority)
> >> +                               continue;
> >> +               }
> >>                  ret =3D do_shrink_slab(&sc, shrinker, priority);
> >>                  if (ret =3D=3D SHRINK_EMPTY)
> >>                          ret =3D 0;
> >> --
> >> 2.34.1
> > Thanks
> > Barry

