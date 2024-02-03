Return-Path: <linux-kernel+bounces-51234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DE848827
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6773A1C22AEF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444165FB99;
	Sat,  3 Feb 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/6Gzac/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667385F86E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983941; cv=none; b=k+hlvn40Byz8v++xgv8LJ4P9Fd+9gwbut6NUgfgXdyJyMwvmahcRceQtxIUguZ9TVplbbeqcIcKWy0CsHsJ6JJckdWZT9ZQzRt9xgBuMC7aO6eO6HrY+Uj5b0fWfT+Cvh7s3JZKFMr93UAtbT0SdayPwfiBmcYtorSZxoLQ1YOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983941; c=relaxed/simple;
	bh=xaOtEgvN3akIZapWeQD74APO0YpbDflzAhvmzlV2KLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHWE29hIUiMZ1l1pZP204jHRSv+CiDL8n7cA5oJM7fatQHgY+Ju+b/zd8C5BKzMfp4UnUwco1MaU6u2ceK2+TQ31zDQcsW6jCwObrEquBGeKCSqxyPE6wGM30lap/0ocmJnf3hUKkJqK0hG5aD8OccNcSfb4eaBusIG6GW1lChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/6Gzac/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD846C433F1
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706983940;
	bh=xaOtEgvN3akIZapWeQD74APO0YpbDflzAhvmzlV2KLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h/6Gzac/JcVhyQHGSfvAcE+4+ib4Ppb/0eOhpGDh1AOEOuOmIn27WsV300SgggUh/
	 kciTQmDFDkniRaAK6DvrwPE+a0vEA95oS7/9icakiTNk6bapmffpRrsn0ohCfudtsF
	 VstP8xgoDp7wQszlczt/yivQxFOxSGvpRrQ5okxzP0Ke4kD2Ztxnnuati/GAPYa+wg
	 dwPgcKomhR3UTiy54D7ZBy9qbdBJPN8G3I5T8rAximVprX3ns2OgrNc+PbAfrBmGhl
	 /Vtbmd3hDmtW2HdG/TZ3N40H4LZU4e5bYeJT6yur3CbBSFFJC+0Qs8KcwVT9DdKUc9
	 7mjWqPWRbgkBQ==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-363bafdce59so2160795ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:12:20 -0800 (PST)
X-Gm-Message-State: AOJu0YzwEfU6QPUlHriRkkv28cJ4rPnFki+qgUoxOhvPjXjSuggzX73z
	LV7r/Y3dB6Wkn9LLY/UAmhXoeT1rZB1sYfkUxixi4hqgyimHi2LNaqqluSwAPhk3PhMcTWbCg38
	ZgmRq4KMM9DoGHTVrMAccG4I2M21qyjDQpwnE
X-Google-Smtp-Source: AGHT+IEJyzS+d9q6ggvPRYlSBlVSPDHcekseMrxwtMHsWzd9RErX5IT9RVjraEcw0vH/w+czF07qW60n4eP5BHxn1j4=
X-Received: by 2002:a92:c8ce:0:b0:363:c2f8:fd16 with SMTP id
 c14-20020a92c8ce000000b00363c2f8fd16mr779020ilq.21.1706983940202; Sat, 03 Feb
 2024 10:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com> <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
In-Reply-To: <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 3 Feb 2024 10:12:08 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
Message-ID: <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	=?UTF-8?B?WXUgWmhhb++/vA==?= <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	=?UTF-8?B?WW9zcnkgQWhtZWTvv7w=?= <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:21=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.com=
> wrote:
>
> On Thu, 2024-02-01 at 13:33 +0800, Huang, Ying wrote:
> > Chris Li <chrisl@kernel.org> writes:
> >
> > >
> > > Changes in v2:
> > > - Add description of the impact of time changing suggest by Ying.
> > > - Remove create_workqueue() and use schedule_work()
> > > - Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b2=
77992cb0@kernel.org
> > > ---
> > >  include/linux/swap_slots.h |  1 +
> > >  mm/swap_slots.c            | 29 +++++++++++++++++++++--------
> > >  2 files changed, 22 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> > > index 15adfb8c813a..67bc8fa30d63 100644
> > > --- a/include/linux/swap_slots.h
> > > +++ b/include/linux/swap_slots.h
> > > @@ -19,6 +19,7 @@ struct swap_slots_cache {
> > >     spinlock_t      free_lock;  /* protects slots_ret, n_ret */
> > >     swp_entry_t     *slots_ret;
> > >     int             n_ret;
> > > +   struct work_struct async_free;
> > >  };
> > >
> > >  void disable_swap_slots_cache_lock(void);
> > > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > > index 0bec1f705f8e..71d344564e55 100644
> > > --- a/mm/swap_slots.c
> > > +++ b/mm/swap_slots.c
> > > @@ -44,6 +44,7 @@ static DEFINE_MUTEX(swap_slots_cache_mutex);
> > >  static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
> > >
> > >  static void __drain_swap_slots_cache(unsigned int type);
> > > +static void swapcache_async_free_entries(struct work_struct *data);
> > >
> > >  #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cac=
he_enabled)
> > >  #define SLOTS_CACHE 0x1
> > > @@ -149,6 +150,7 @@ static int alloc_swap_slot_cache(unsigned int cpu=
)
> > >             spin_lock_init(&cache->free_lock);
> > >             cache->lock_initialized =3D true;
> > >     }
> > > +   INIT_WORK(&cache->async_free, swapcache_async_free_entries);
> > >     cache->nr =3D 0;
> > >     cache->cur =3D 0;
> > >     cache->n_ret =3D 0;
> > > @@ -269,6 +271,20 @@ static int refill_swap_slots_cache(struct swap_s=
lots_cache *cache)
> > >     return cache->nr;
> > >  }
> > >
> > > +static void swapcache_async_free_entries(struct work_struct *data)
> > > +{
> > > +   struct swap_slots_cache *cache;
> > > +
> > > +   cache =3D container_of(data, struct swap_slots_cache, async_free)=
;
> > > +   spin_lock_irq(&cache->free_lock);
> > > +   /* Swap slots cache may be deactivated before acquiring lock */
> > > +   if (cache->slots_ret) {
> > > +           swapcache_free_entries(cache->slots_ret, cache->n_ret);
> > > +           cache->n_ret =3D 0;
> > > +   }
> > > +   spin_unlock_irq(&cache->free_lock);
> > > +}
> > > +
> > >  void free_swap_slot(swp_entry_t entry)
> > >  {
> > >     struct swap_slots_cache *cache;
> > > @@ -282,17 +298,14 @@ void free_swap_slot(swp_entry_t entry)
> > >                     goto direct_free;
> > >             }
> > >             if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE) {
> > > -                   /*
> > > -                    * Return slots to global pool.
> > > -                    * The current swap_map value is SWAP_HAS_CACHE.
> > > -                    * Set it to 0 to indicate it is available for
> > > -                    * allocation in global pool
> > > -                    */
> > > -                   swapcache_free_entries(cache->slots_ret, cache->n=
_ret);
> > > -                   cache->n_ret =3D 0;
> > > +                   spin_unlock_irq(&cache->free_lock);
> > > +                   schedule_work(&cache->async_free);
> > > +                   goto direct_free;
> > >             }
> > >             cache->slots_ret[cache->n_ret++] =3D entry;
> > >             spin_unlock_irq(&cache->free_lock);
> > > +           if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE)
> > > +                   schedule_work(&cache->async_free);
>
>
> I have some concerns about the current patch with the change above.
> We could hit the direct_free path very often.
>
> By delaying the freeing of entries in the return
> cache, we have to do more freeing of swap entry one at a time. When
> we try to free an entry, we can find the return cache still full, waiting=
 to be freed.

You are describing the async free is not working. In that case it will alwa=
ys
hit the direct free path one by one.

>
> So we have fewer batch free of swap entries, resulting in an increase in
> number of sis->lock acquisitions overall. This could have the
> effect of reducing swap throughput overall when swap is under heavy
> operations and sis->lock is contended.

I  can change the direct free path to free all entries. If the async
free hasn't freed up the batch by the time the next swap fault comes in.
The new swap fault will take the hit, just free the whole batch. It will be=
have
closer to the original batch free behavior in this path.

Chris

