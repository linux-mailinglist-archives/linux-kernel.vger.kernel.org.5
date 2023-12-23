Return-Path: <linux-kernel+bounces-10159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF981D0F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92EF284BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98317F5;
	Sat, 23 Dec 2023 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOju58vl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6D17C6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba9c26e14aso27900639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703295871; x=1703900671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DUEi9B9o/uy3by0V8nXmef5g50ozncfvFeYsehJ5rI=;
        b=OOju58vlZAHTv17C/a5xhybNe4+lv3NGXK572TH6qKtWKQnt5isZjsHZttmJ3N2HvN
         ZwJ1iBbN8dM+bNflzT7DEy4C5I/Mba38Zbc/rgPKPFKpJp0remD5vJv2td/tYXIXgiVf
         7HyauytXZlRydowSGNlH60t6d1ygk6NDYsPlym9xNiHUKqXh8mPTvYwbflpXuuEw7VsF
         cqqkIXN9z7FqYWeBlNaAgzkX7XNID2Lk35HHRbXEHeaH7cfXD5FtCs4r8E5mqaWcCRKs
         d+ZgNTNXK5Mxj/uanK7EMgY4Jlv1Yc5pqf5OhY9dYiaWolNa0CADfONPOnKp0wvMwBQS
         0Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703295871; x=1703900671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DUEi9B9o/uy3by0V8nXmef5g50ozncfvFeYsehJ5rI=;
        b=BOgUoL9LYDzxvdIOQfVYl7ka33xF4l4MVGWVYyzuJ8WeLFU25NnvTqF9NNUkrMi72C
         R337rZh2E5D2UbkLsFgQZPvy06olHsGi+gr+eCWHzy2zsLnAzS0KsTcv39YMdD2dihDF
         22pyZVMvqbCTD3L4hRR5fVVY49fZuNKcRXFxJH/fAkONRto2cq+qSu6yfDp6ZeqkImRr
         uR8xeSrAXqWDLYGEsz4S6z5o/cydq3egUSpRkMnKKBvGgvVsBTg8lKtkYXZDZ+YKAosP
         xaFW6dQWMZeI9Ik0o0xpukwNRIIjBafFMp3yp9pvQlEv1vUqvQ9j2FVnLZTu6iU9gPeK
         tQbQ==
X-Gm-Message-State: AOJu0YwpsVf9X9sH/PXnBUB8IlFp9idQk0g4B33H5QqTgBA96cW4DgaR
	4rQ1prGi6eNaXIZFk+WwPu5NvzvCqSktP0lxswM=
X-Google-Smtp-Source: AGHT+IEvHBviqDrNSnGCMxpQAq/VzrupXO+b3Cp4Kv7ICbQq70x1QXYzqxuZTkYpSkZPYHf2SuwZPC8tvvtoZhhlhNk=
X-Received: by 2002:a6b:5008:0:b0:7b6:fa7f:9cd6 with SMTP id
 e8-20020a6b5008000000b007b6fa7f9cd6mr2167316iob.5.1703295870901; Fri, 22 Dec
 2023 17:44:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
In-Reply-To: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 22 Dec 2023 17:44:19 -0800
Message-ID: <CAKEwX=MNWcADDDWMo_V8V=1snAPKWmcxbnKX8jzt4XdNoXiV3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	=?UTF-8?B?WXUgWmhhb++/vA==?= <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	=?UTF-8?B?WW9zcnkgQWhtZWTvv7w=?= <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:25=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
>
> Further investigation show that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
>
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
>
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
>
> Move free_swap_slots() outside of the swapin page fault handler into an
> async work queue to avoid such long tail latencies.
>
> Testing:
>
> Chun-Tse did some benchmark in chromebook, showing that
> zram_wait_metrics improve about 15% with 80% and 95% confidence.
>
> I recently ran some experiments on about 1000 Google production
> machines. It shows swapin latency drops in the long tail
> 100us - 500us bucket dramatically.
>
> platform        (100-500us)             (0-100us)
> A               1.12% -> 0.36%          98.47% -> 99.22%
> B               0.65% -> 0.15%          98.96% -> 99.46%
> C               0.61% -> 0.23%          98.96% -> 99.38%

Nice! Are these values for zram as well, or ordinary (SSD?) swap? I
imagine it will matter less for swap, right?

>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Wei Xu=EF=BF=BC <weixugc@google.com>
> Cc: Yu Zhao=EF=BF=BC <yuzhao@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Chun-Tse Shao <ctshao@google.com>
> Cc: Suren Baghdasaryan=EF=BF=BC <surenb@google.com>
> Cc: Yosry Ahmed=EF=BF=BC <yosryahmed@google.com>
> Cc: Brain Geffon <bgeffon@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap_slots.h |  1 +
>  mm/swap_slots.c            | 37 +++++++++++++++++++++++++++++--------
>  2 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> index 15adfb8c813a..67bc8fa30d63 100644
> --- a/include/linux/swap_slots.h
> +++ b/include/linux/swap_slots.h
> @@ -19,6 +19,7 @@ struct swap_slots_cache {
>         spinlock_t      free_lock;  /* protects slots_ret, n_ret */
>         swp_entry_t     *slots_ret;
>         int             n_ret;
> +       struct work_struct async_free;
>  };
>
>  void disable_swap_slots_cache_lock(void);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..a3b306550732 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -42,8 +42,10 @@ static bool  swap_slot_cache_initialized;
>  static DEFINE_MUTEX(swap_slots_cache_mutex);
>  /* Serialize swap slots cache enable/disable operations */
>  static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
> +static struct workqueue_struct *swap_free_queue;
>
>  static void __drain_swap_slots_cache(unsigned int type);
> +static void swapcache_async_free_entries(struct work_struct *data);
>
>  #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_e=
nabled)
>  #define SLOTS_CACHE 0x1
> @@ -149,6 +151,7 @@ static int alloc_swap_slot_cache(unsigned int cpu)
>                 spin_lock_init(&cache->free_lock);
>                 cache->lock_initialized =3D true;
>         }
> +       INIT_WORK(&cache->async_free, swapcache_async_free_entries);
>         cache->nr =3D 0;
>         cache->cur =3D 0;
>         cache->n_ret =3D 0;
> @@ -269,6 +272,20 @@ static int refill_swap_slots_cache(struct swap_slots=
_cache *cache)
>         return cache->nr;
>  }
>
> +static void swapcache_async_free_entries(struct work_struct *data)
> +{
> +       struct swap_slots_cache *cache;
> +
> +       cache =3D container_of(data, struct swap_slots_cache, async_free)=
;
> +       spin_lock_irq(&cache->free_lock);
> +       /* Swap slots cache may be deactivated before acquiring lock */
> +       if (cache->slots_ret) {
> +               swapcache_free_entries(cache->slots_ret, cache->n_ret);
> +               cache->n_ret =3D 0;
> +       }
> +       spin_unlock_irq(&cache->free_lock);
> +}
> +
>  void free_swap_slot(swp_entry_t entry)
>  {
>         struct swap_slots_cache *cache;
> @@ -282,17 +299,14 @@ void free_swap_slot(swp_entry_t entry)
>                         goto direct_free;
>                 }
>                 if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE) {
> -                       /*
> -                        * Return slots to global pool.
> -                        * The current swap_map value is SWAP_HAS_CACHE.
> -                        * Set it to 0 to indicate it is available for
> -                        * allocation in global pool
> -                        */
> -                       swapcache_free_entries(cache->slots_ret, cache->n=
_ret);
> -                       cache->n_ret =3D 0;
> +                       spin_unlock_irq(&cache->free_lock);
> +                       queue_work(swap_free_queue, &cache->async_free);
> +                       goto direct_free;
>                 }
>                 cache->slots_ret[cache->n_ret++] =3D entry;
>                 spin_unlock_irq(&cache->free_lock);
> +               if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE)
> +                       queue_work(swap_free_queue, &cache->async_free);
>         } else {
>  direct_free:
>                 swapcache_free_entries(&entry, 1);
> @@ -348,3 +362,10 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>         }
>         return entry;
>  }
> +
> +static int __init async_queue_init(void)
> +{
> +       swap_free_queue =3D create_workqueue("async swap cache");

nit(?): isn't create_workqueue() deprecated? from:

https://www.kernel.org/doc/html/latest/core-api/workqueue.html#application-=
programming-interface-api

I think there's a zswap patch proposing fixing that on the zswap side.

> +       return 0;
> +}
> +subsys_initcall(async_queue_init);
>
> ---
> base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
> change-id: 20231216-async-free-bef392015432
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>

