Return-Path: <linux-kernel+bounces-143582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851C8A3B17
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D03284B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192651C6B8;
	Sat, 13 Apr 2024 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltstJaU/"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D781BC41
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712985599; cv=none; b=pr+VNviAZjQ83ZN0375MtufuwU879L0phjPK5zE1tj/IhD25LEtBH0EZPZoILfoHyWRrKrFOrCcyitmtM6KepqypE87V2yUBt/cb8bCyIOMcs2RKzH4og484CEHvvpjA9ZNR/Fn1Ob8/btHdfn0VWU77iHl5k5JE+iAV+y6yKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712985599; c=relaxed/simple;
	bh=VFh8G5Lzu+KZrcNdIjpd5WvPhWHRIgfCLe/mXA0Jmzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTovO9RdTjaB7GVaLUsIEyTo56r5hecST093AOd3w33GR5hPRRROW+nQq7ySbOY4zejnyqTr8mTX+ZmFNal81rd567KBNa2qD5IoEbxsFO+1vMZFWKWlfxsvdrRptszBufJB2hKkVJUYDiqeyXNXuwZpq7ocqeD7719uV4gwBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltstJaU/; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4dc9f17c27bso470100e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712985596; x=1713590396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z033l8aBmpmazijIqdn4X3dK8gfkoX6WQoDM/KTSRrM=;
        b=ltstJaU/uvPapfFAL3dato6qhrlRNtFzkqwavS6F9AqyILlNGhCS+A3B/hzfdL2DKk
         fvkjv3N89P8UYtCGUtOIwG+IYkMp0vsNJRDNI1ZWx0U4V8HiYT4aHXJJHhWdDI2i6Pra
         oIthISyU/16H7lW7VI1tGKMTbiu6i9MI/VTVbtzpa1LjX18Xtt1+eHnxSYYH6y+BNN1y
         jxxmc2kDO/yvnB+kDrziQa8jmF2LeOMK7LaIPCxP0eh9yAf9yR5Cwy4L1ovP5+7TyWqj
         OlWf/YpIO8HDo0/mS1ceGbZphxf2XhDGEcxIVPVG1uPK+479I90tX0TGrrpFOaOZ2zT0
         rW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712985596; x=1713590396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z033l8aBmpmazijIqdn4X3dK8gfkoX6WQoDM/KTSRrM=;
        b=NgP8hLzMIDI8dIMHo6fMvbisBL0Lw3nRznTr4cuiTrih/VU/NU+xVkxK9+K22wTmoJ
         LxY455r4FNk6WfF0rGuyd1DeNJafMWp3Z2AC/t1jirdjL7NjRSW/W5frDsalb6cW5nUM
         yytWh+IX6yKC51lMQZZjh7R34od+9v3sf4+spJ8prIq7Qi2wgJAfHoPqcuVLgxgXyLkw
         CeFppgF7v/yDoj0lqFeNnasltd8l7EsB3BqMImOKQ4K0d3aSij9joTqgzx9LqDVRolrX
         LlvKmRUZG3tgi2ylZstOopAPZ8oXJU+gW/FVKATILXoZVysMm7S7HVLBCTc/UmTu9vRa
         MoYA==
X-Forwarded-Encrypted: i=1; AJvYcCXzCjgpAucy7m5JMpHMxlVco1AugEkCuUmV38t4Pi+GuKx14nT0v1EDOwRLBNxnot/XkmQ3XO+6DK7EOVflN5U0BW9r8sNge2WEK8hB
X-Gm-Message-State: AOJu0YxsMhoqKR7YquYxZ/z3TfM3dNEE6Xmkf1t/I+sMie1uQ8FYAwaj
	faXHva4VFb267ztGq0BWopH/DpmodD1JzQ3teXAUWaYzYzRoVrymTsBCaCyfXKOyqIoz122c8kw
	UhYiECR4U4QUU+otv0Qzjzbx5qVg=
X-Google-Smtp-Source: AGHT+IGmXMo7rIWI2XQN4+oSlAn7GwLHqPD1oNcVmQbFVLAVgpKcOrn+79N1muwSp3oBCu0MbkXGP0QIxmZEVIopPCk=
X-Received: by 2002:a05:6122:c9f:b0:4d3:3a8c:13ad with SMTP id
 ba31-20020a0561220c9f00b004d33a8c13admr4533302vkb.8.1712985596121; Fri, 12
 Apr 2024 22:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413015410.30951-1-lipeifeng@oppo.com>
In-Reply-To: <20240413015410.30951-1-lipeifeng@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 13 Apr 2024 17:19:44 +1200
Message-ID: <CAGsJ_4yGTcgMnK_81hMUAL0xG06Nmu0kn3bwdQHhSiDV8HQ+ZA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
To: lipeifeng@oppo.com
Cc: akpm@linux-foundation.org, david@fromorbit.com, zhengqi.arch@bytedance.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 1:54=E2=80=AFPM <lipeifeng@oppo.com> wrote:
>
> From: Peifeng Li <lipeifeng@oppo.com>
>
> In the case of insufficient memory, threads will be in direct_reclaim to
> reclaim memory, direct_reclaim will call shrink_slab to run sequentially
> each shrinker callback. If there is a lock-contention in the shrinker
> callback,such as spinlock,mutex_lock and so on, threads may be likely to
> be stuck in direct_reclaim for a long time, even if the memfree has reach=
ed
> the high watermarks of the zone, resulting in poor performance of threads=
.
>
> Example 1: shrinker callback may wait for spinlock
> static unsigned long mb_cache_shrink(struct mb_cache *cache,
>                                      unsigned long nr_to_scan)
> {
>         struct mb_cache_entry *entry;
>         unsigned long shrunk =3D 0;
>
>         spin_lock(&cache->c_list_lock);
>         while (nr_to_scan-- && !list_empty(&cache->c_list)) {
>                 entry =3D list_first_entry(&cache->c_list,
>                                          struct mb_cache_entry, e_list);
>                 if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
>                     atomic_cmpxchg(&entry->e_refcnt, 1, 0) !=3D 1) {
>                         clear_bit(MBE_REFERENCED_B, &entry->e_flags);
>                         list_move_tail(&entry->e_list, &cache->c_list);
>                         continue;
>                 }
>                 list_del_init(&entry->e_list);
>                 cache->c_entry_count--;
>                 spin_unlock(&cache->c_list_lock);
>                 __mb_cache_entry_free(cache, entry);
>                 shrunk++;
>                 cond_resched();
>                 spin_lock(&cache->c_list_lock);
>         }
>         spin_unlock(&cache->c_list_lock);
>
>         return shrunk;
> }
> Example 2: shrinker callback may wait for mutex lock
> static
> unsigned long kbase_mem_evictable_reclaim_scan_objects(struct shrinker *s=
,
>                 struct shrink_control *sc)
> {
>         struct kbase_context *kctx;
>         struct kbase_mem_phy_alloc *alloc;
>         struct kbase_mem_phy_alloc *tmp;
>         unsigned long freed =3D 0;
>
>         kctx =3D container_of(s, struct kbase_context, reclaim);
>
>         // MTK add to prevent false alarm
>         lockdep_off();
>
>         mutex_lock(&kctx->jit_evict_lock);
>
>         list_for_each_entry_safe(alloc, tmp, &kctx->evict_list, evict_nod=
e) {
>                 int err;
>
>                 err =3D kbase_mem_shrink_gpu_mapping(kctx, alloc->reg,
>                                 0, alloc->nents);
>                 if (err !=3D 0) {
>                         freed =3D -1;
>                         goto out_unlock;
>                 }
>
>                 alloc->evicted =3D alloc->nents;
>
>                 kbase_free_phy_pages_helper(alloc, alloc->evicted);
>                 freed +=3D alloc->evicted;
>                 list_del_init(&alloc->evict_node);
>
>                 kbase_jit_backing_lost(alloc->reg);
>
>                 if (freed > sc->nr_to_scan)
>                         break;
>         }
> out_unlock:
>         mutex_unlock(&kctx->jit_evict_lock);
>
>         // MTK add to prevent false alarm
>         lockdep_on();
>
>         return freed;
> }
>
> In mobile-phone,threads are likely to be stuck in shrinker callback durin=
g
> direct_reclaim, with example like the following:
> <...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
>                         dynamic_mem_shrink_scan+0x0/0xb8 ... priority 2
> <...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
>                         dynamic_mem_shrink_scan+0x0/0xb8 ...
>
> For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM tha=
t
> allows driver to set shrinker callback not to be called in direct_reclaim
> unless sc->priority is 0.
>
> The reason why sc->priority=3D0 allows shrinker callback to be called in
> direct_reclaim is for two reasons:
> 1.Always call all shrinker callback in drop_slab that priority is 0.
> 2.sc->priority is 0 during direct_reclaim, allow direct_reclaim to call
> shrinker callback, to reclaim memory timely.
>
> Note:
> 1.shrinker_register() default not to set SHRINKER_NO_DIRECT_RECLAIM, to
> maintain the current behavior of the code.
> 2.Logic of kswapd and drop_slab to call shrinker callback isn't affected.
>
> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
> ---
> -v2: fix the commit message
>  include/linux/shrinker.h |  5 +++++
>  mm/shrinker.c            | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1a00be90d93a..2d5a8b3a720b 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -130,6 +130,11 @@ struct shrinker {
>   * non-MEMCG_AWARE shrinker should not have this flag set.
>   */
>  #define SHRINKER_NONSLAB       BIT(4)
> +/*
> + * Can shrinker callback be called in direct_relcaim unless
> + * sc->priority is 0?
> + */
> +#define SHRINKER_NO_DIRECT_RECLAIM     BIT(5)
>

My point is, drivers won't voluntarily stay unreclaimed during direct
reclamation. Hence, this approach is unlikely to succeed. Those
drivers can't be trusted. Had they been aware of their slowness,
they wouldn't have written code in this manner.

Detecting problematic driver shrinkers and marking them as skipped
might prove challenging. I concur with Zhengqi; the priority should
be fixing the driver whose shrinker is slow. Do you have a list of
slow drivers?


>  __printf(2, 3)
>  struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...=
);
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..7a5dffd166cd 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -4,7 +4,7 @@
>  #include <linux/shrinker.h>
>  #include <linux/rculist.h>
>  #include <trace/events/vmscan.h>
> -
> +#include <linux/swap.h>
>  #include "internal.h"
>
>  LIST_HEAD(shrinker_list);
> @@ -544,7 +544,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mas=
k, int nid,
>                         if (!memcg_kmem_online() &&
>                             !(shrinker->flags & SHRINKER_NONSLAB))
>                                 continue;
> -
> +                       /*
> +                        * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker=
 callback
> +                        * should not be called in direct_reclaim unless =
priority
> +                        * is 0.
> +                        */
> +                       if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM=
) &&
> +                                       !current_is_kswapd()) {
> +                               /*
> +                                * 1.Always call shrinker callback in dro=
p_slab that
> +                                * priority is 0.
> +                                * 2.sc->priority is 0 during direct_recl=
aim, allow
> +                                * direct_reclaim to call shrinker callba=
ck, to reclaim
> +                                * memory timely.
> +                                */
> +                               if (priority)
> +                                       continue;
> +                       }
>                         ret =3D do_shrink_slab(&sc, shrinker, priority);
>                         if (ret =3D=3D SHRINK_EMPTY) {
>                                 clear_bit(offset, unit->map);
> @@ -658,7 +674,23 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, s=
truct mem_cgroup *memcg,
>                         continue;
>
>                 rcu_read_unlock();
> -
> +               /*
> +                * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callbac=
k
> +                * should not be called in direct_reclaim unless priority
> +                * is 0.
> +                */
> +               if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
> +                               !current_is_kswapd()) {
> +                       /*
> +                        * 1.Always call shrinker callback in drop_slab t=
hat
> +                        * priority is 0.
> +                        * 2.sc->priority is 0 during direct_reclaim, all=
ow
> +                        * direct_reclaim to call shrinker callback, to r=
eclaim
> +                        * memory timely.
> +                        */
> +                       if (priority)
> +                               continue;
> +               }
>                 ret =3D do_shrink_slab(&sc, shrinker, priority);
>                 if (ret =3D=3D SHRINK_EMPTY)
>                         ret =3D 0;
> --
> 2.34.1

Thanks
Barry

