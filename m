Return-Path: <linux-kernel+bounces-146145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A988A614F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F32282CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A2171D2;
	Tue, 16 Apr 2024 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qaeq2xDc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D44C7E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237233; cv=none; b=ZOzniYwDkRX49Wbyh1zraCAQ7ya2S/4BMSSoX0m18nXHC4GwaEKfPCXkNJSRpLzXI0Ndiq7rAas8IpXwZvf1n//IikzDrEhD1pk9NkInJUH3KCfAXBeC9Exy6dLvZ9H7ClJxjVAkoG4K1HVLxMvvNw59DLxRd9WT1SvdxTu0KW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237233; c=relaxed/simple;
	bh=a3lCO5CRuQ7dH+oGyY4l/JpmVdIjZPWkFTGDcgYnwQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CA8X5KOXzps9R68L1vc9l4EVFEj6JVmxPZN0asJ8mJDOk7cx0HHiBEuQEzsD+sj5eg1xNsBRgiyUbVk20JMQeI7Tlm8RgqM6MAgxLWAUHODfU9zrG6Ghqy2W8jIP1cUnv39rYdmvWKXnfn17g4kLr8E3+B+qIrcRHcpDJFyDgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qaeq2xDc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237231; x=1744773231;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=a3lCO5CRuQ7dH+oGyY4l/JpmVdIjZPWkFTGDcgYnwQo=;
  b=Qaeq2xDcnh+frG9G4Am6fuN2Ir7hKyq85a0nORywHLN3tr+Yhc6ntr0Y
   PV4HJVbfpoAoeNAy2ayG3wCMC1UA721tMw64jqkERv5K3RFgGXNjdrTPA
   pbRq9AmCmAawakF1qzV2UGkMjM4bmQt/lFd6GdirSU2vUSNyBnNayGiy3
   gWdcqXkTMwQkDdl9VxGnb2uh4XeWGTcI7azF31CWPSrABHLbLBpWRP5q5
   HNr/I42pWQVPjwLpeG7pG/ynLlJawkve75tsTizWBnKAo57l1Ngd9Q6FM
   KMYdfvxNICkRkfnPJMBUCfzbN+Fp+Fg17SQD5gfxUO5iYSnGfC7YmC5fT
   w==;
X-CSE-ConnectionGUID: bG3iPpofT6W7pF9ECGPlFA==
X-CSE-MsgGUID: JLlQWrWpT/ehnksCLd8Q7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8533437"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8533437"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:13:49 -0700
X-CSE-ConnectionGUID: CzUKsPNHTGS4XTQx9u+IPQ==
X-CSE-MsgGUID: A8JIzK4SQkKPcRKUNJOqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="45406842"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:13:44 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched
 swap_free()
In-Reply-To: <CAGsJ_4yim-PQW0JBjZD8dpGBG3FQm=xZb1V51+Nr37nJEwEPzA@mail.gmail.com>
	(Barry Song's message of "Tue, 16 Apr 2024 14:08:50 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-2-21cnbao@gmail.com>
	<87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
	<87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
	<87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4zH4RHhZembtXOqzBDL75MA5NiEjMHx7eCN-a1ifnKTBw@mail.gmail.com>
	<877cgy2ifu.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yim-PQW0JBjZD8dpGBG3FQm=xZb1V51+Nr37nJEwEPzA@mail.gmail.com>
Date: Tue, 16 Apr 2024 11:11:51 +0800
Message-ID: <87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@=
intel.com> wrote:
>> >> >> >>
>> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >>
>> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
>> >> >> >> >
>> >> >> >> > While swapping in a large folio, we need to free swaps relate=
d to the whole
>> >> >> >> > folio. To avoid frequently acquiring and releasing swap locks=
, it is better
>> >> >> >> > to introduce an API for batched free.
>> >> >> >> >
>> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> > ---
>> >> >> >> >  include/linux/swap.h |  5 +++++
>> >> >> >> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++=
++++++++++
>> >> >> >> >  2 files changed, 56 insertions(+)
>> >> >> >> >
>> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
>> >> >> >> > --- a/include/linux/swap.h
>> >> >> >> > +++ b/include/linux/swap.h
>> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>> >> >> >> >  extern int swap_duplicate(swp_entry_t);
>> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
>> >> >> >> >  extern void swap_free(swp_entry_t);
>> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int=
 n);
>> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr=
);
>> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
>> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t=
 swp)
>> >> >> >> >  {
>> >> >> >> >  }
>> >> >> >> >
>> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> >> >> >> > +{
>> >> >> >> > +}
>> >> >> >> > +
>> >> >> >> >  static inline void put_swap_folio(struct folio *folio, swp_e=
ntry_t swp)
>> >> >> >> >  {
>> >> >> >> >  }
>> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
>> >> >> >> > --- a/mm/swapfile.c
>> >> >> >> > +++ b/mm/swapfile.c
>> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
>> >> >> >> >               __swap_entry_free(p, entry);
>> >> >> >> >  }
>> >> >> >> >
>> >> >> >> > +/*
>> >> >> >> > + * Free up the maximum number of swap entries at once to lim=
it the
>> >> >> >> > + * maximum kernel stack usage.
>> >> >> >> > + */
>> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFI=
LE_CLUSTER)
>> >> >> >> > +
>> >> >> >> > +/*
>> >> >> >> > + * Called after swapping in a large folio,
>> >> >> >>
>> >> >> >> IMHO, it's not good to document the caller in the function defi=
nition.
>> >> >> >> Because this will discourage function reusing.
>> >> >> >
>> >> >> > ok. right now there is only one user that is why it is added. bu=
t i agree
>> >> >> > we can actually remove this.
>> >> >> >
>> >> >> >>
>> >> >> >> > batched free swap entries
>> >> >> >> > + * for this large folio, entry should be for the first subpa=
ge and
>> >> >> >> > + * its offset is aligned with nr_pages
>> >> >> >>
>> >> >> >> Why do we need this?
>> >> >> >
>> >> >> > This is a fundamental requirement for the existing kernel, folio=
's
>> >> >> > swap offset is naturally aligned from the first moment add_to_sw=
ap
>> >> >> > to add swapcache's xa. so this comment is describing the existing
>> >> >> > fact. In the future, if we want to support swap-out folio to dis=
contiguous
>> >> >> > and not-aligned offsets, we can't pass entry as the parameter, w=
e should
>> >> >> > instead pass ptep or another different data struct which can con=
nect
>> >> >> > multiple discontiguous swap offsets.
>> >> >> >
>> >> >> > I feel like we only need "for this large folio, entry should be =
for
>> >> >> > the first subpage" and drop "and its offset is aligned with nr_p=
ages",
>> >> >> > the latter is not important to this context at all.
>> >> >>
>> >> >> IIUC, all these are requirements of the only caller now, not the
>> >> >> function itself.  If only part of the all swap entries of a mTHP a=
re
>> >> >> called with swap_free_nr(), can swap_free_nr() still do its work? =
 If
>> >> >> so, why not make swap_free_nr() as general as possible?
>> >> >
>> >> > right , i believe we can make swap_free_nr() as general as possible.
>> >> >
>> >> >>
>> >> >> >>
>> >> >> >> > + */
>> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> >> >> >> > +{
>> >> >> >> > +     int i, j;
>> >> >> >> > +     struct swap_cluster_info *ci;
>> >> >> >> > +     struct swap_info_struct *p;
>> >> >> >> > +     unsigned int type =3D swp_type(entry);
>> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
>> >> >> >> > +     int batch_nr, remain_nr;
>> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
>> >> >> >> > +
>> >> >> >> > +     /* all swap entries are within a cluster for mTHP */
>> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFI=
LE_CLUSTER);
>> >> >> >> > +
>> >> >> >> > +     if (nr_pages =3D=3D 1) {
>> >> >> >> > +             swap_free(entry);
>> >> >> >> > +             return;
>> >> >> >> > +     }
>> >> >> >>
>> >> >> >> Is it possible to unify swap_free() and swap_free_nr() into one=
 function
>> >> >> >> with acceptable performance?  IIUC, the general rule in mTHP ef=
fort is
>> >> >> >> to avoid duplicate functions between mTHP and normal small foli=
o.
>> >> >> >> Right?
>> >> >> >
>> >> >> > I don't see why.
>> >> >>
>> >> >> Because duplicated implementation are hard to maintain in the long=
 term.
>> >> >
>> >> > sorry, i actually meant "I don't see why not",  for some reason, th=
e "not"
>> >> > was missed. Obviously I meant "why not", there was a "but" after it=
 :-)
>> >> >
>> >> >>
>> >> >> > but we have lots of places calling swap_free(), we may
>> >> >> > have to change them all to call swap_free_nr(entry, 1); the othe=
r possible
>> >> >> > way is making swap_free() a wrapper of swap_free_nr() always usi=
ng
>> >> >> > 1 as the argument. In both cases, we are changing the semantics =
of
>> >> >> > swap_free_nr() to partially freeing large folio cases and have t=
o drop
>> >> >> > "entry should be for the first subpage" then.
>> >> >> >
>> >> >> > Right now, the semantics is
>> >> >> > * swap_free_nr() for an entire large folio;
>> >> >> > * swap_free() for one entry of either a large folio or a small f=
olio
>> >> >>
>> >> >> As above, I don't think the these semantics are important for
>> >> >> swap_free_nr() implementation.
>> >> >
>> >> > right. I agree. If we are ready to change all those callers, nothing
>> >> > can stop us from removing swap_free().
>> >> >
>> >> >>
>> >> >> >>
>> >> >> >> > +
>> >> >> >> > +     remain_nr =3D nr_pages;
>> >> >> >> > +     p =3D _swap_info_get(entry);
>> >> >> >> > +     if (p) {
>> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
>> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, =
remain_nr);
>> >> >> >> > +
>> >> >> >> > +                     ci =3D lock_cluster_or_swap_info(p, off=
set);
>> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++) {
>> >> >> >> > +                             if (__swap_entry_free_locked(p,=
 offset + i * SWAP_BATCH_NR + j, 1))
>> >> >> >> > +                                     __bitmap_set(usage, j, =
1);
>> >> >> >> > +                     }
>> >> >> >> > +                     unlock_cluster_or_swap_info(p, ci);
>> >> >> >> > +
>> >> >> >> > +                     for_each_clear_bit(j, usage, batch_nr)
>> >> >> >> > +                             free_swap_slot(swp_entry(type, =
offset + i * SWAP_BATCH_NR + j));
>> >> >> >> > +
>> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
>> >> >> >> > +                     remain_nr -=3D batch_nr;
>> >> >> >> > +             }
>> >> >> >> > +     }
>> >> >> >> > +}
>> >> >> >> > +
>> >> >> >> >  /*
>> >> >> >> >   * Called after dropping swapcache to decrease refcnt to swa=
p entries.
>> >> >> >> >   */
>> >> >> >>
>> >> >> >> put_swap_folio() implements batching in another method.  Do you=
 think
>> >> >> >> that it's good to use the batching method in that function here=
?  It
>> >> >> >> avoids to use bitmap operations and stack space.
>> >> >> >
>> >> >> > Chuanhua has strictly limited the maximum stack usage to several
>> >> >> > unsigned long,
>> >> >>
>> >> >> 512 / 8 =3D 64 bytes.
>> >> >>
>> >> >> So, not trivial.
>> >> >>
>> >> >> > so this should be safe. on the other hand, i believe this
>> >> >> > implementation is more efficient, as  put_swap_folio() might loc=
k/
>> >> >> > unlock much more often whenever __swap_entry_free_locked returns
>> >> >> > 0.
>> >> >>
>> >> >> There are 2 most common use cases,
>> >> >>
>> >> >> - all swap entries have usage count =3D=3D 0
>> >> >> - all swap entries have usage count !=3D 0
>> >> >>
>> >> >> In both cases, we only need to lock/unlock once.  In fact, I didn't
>> >> >> find possible use cases other than above.
>> >> >
>> >> > i guess the point is free_swap_slot() shouldn't be called within
>> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages slots,
>> >> > we'll have to unlock and lock nr_pages times?  and this is the most
>> >> > common scenario.
>> >>
>> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUSTER (th=
at
>> >> is, nr_pages) or 0.  These are the most common cases.
>> >>
>> >
>> > i am actually talking about the below code path,
>> >
>> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
>> > {
>> >         ...
>> >
>> >         ci =3D lock_cluster_or_swap_info(si, offset);
>> >         ...
>> >         for (i =3D 0; i < size; i++, entry.val++) {
>> >                 if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS=
_CACHE)) {
>> >                         unlock_cluster_or_swap_info(si, ci);
>> >                         free_swap_slot(entry);
>> >                         if (i =3D=3D size - 1)
>> >                                 return;
>> >                         lock_cluster_or_swap_info(si, offset);
>> >                 }
>> >         }
>> >         unlock_cluster_or_swap_info(si, ci);
>> > }
>> >
>> > but i guess you are talking about the below code path:
>> >
>> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
>> > {
>> >         ...
>> >
>> >         ci =3D lock_cluster_or_swap_info(si, offset);
>> >         if (size =3D=3D SWAPFILE_CLUSTER) {
>> >                 map =3D si->swap_map + offset;
>> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
>> >                         val =3D map[i];
>> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
>> >                         if (val =3D=3D SWAP_HAS_CACHE)
>> >                                 free_entries++;
>> >                 }
>> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
>> >                         unlock_cluster_or_swap_info(si, ci);
>> >                         spin_lock(&si->lock);
>> >                         mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUST=
ER);
>> >                         swap_free_cluster(si, idx);
>> >                         spin_unlock(&si->lock);
>> >                         return;
>> >                 }
>> >         }
>> > }
>>
>> I am talking about both code paths.  In 2 most common cases,
>> __swap_entry_free_locked() will return 0 or !0 for all entries in range.
>
> I grasp your point, but if conditions involving 0 or non-0 values fail, w=
e'll
> end up repeatedly unlocking and locking. Picture a scenario with a large
> folio shared by multiple processes. One process might unmap a portion
> while another still holds an entire mapping to it. This could lead to sit=
uations
> where free_entries doesn't equal 0 and free_entries doesn't equal
> nr_pages, resulting in multiple unlock and lock operations.

This is impossible in current caller, because the folio is in the swap
cache.  But if we move the change to __swap_entry_free_nr(), we may run
into this situation.

> Chuanhua has invested significant effort in following Ryan's suggestion
> for the current approach, which generally handles all cases, especially
> partial unmapping. Additionally, the widespread use of swap_free_nr()
> as you suggested across various scenarios is noteworthy.
>
> Unless there's evidence indicating performance issues or bugs, I believe
> the current approach remains preferable.

TBH, I don't like the large stack space usage (64 bytes).  How about use
a "unsigned long" as bitmap?  Then, we use much less stack space, use
bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check the most com=
mon
use cases.  And, we have enough batching.

>>
>> > we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
>> > or you want to check free_entries =3D=3D "1 << swap_entry_order(folio_=
order(folio))"
>> > instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i++, entr=
y.val++)"
>> > path?
>>
>> Just replace SWAPFILE_CLUSTER with "nr_pages" in your code.
>>
>> >
>> >> >>
>> >> >> And, we should add batching in __swap_entry_free().  That will help
>> >> >> free_swap_and_cache_nr() too.
>> >
>> > Chris Li and I actually discussed it before, while I completely
>> > agree this can be batched. but i'd like to defer this as an incremental
>> > patchset later to keep this swapcache-refault small.
>>
>> OK.
>>
>> >>
>> >> Please consider this too.

--
Best Regards,
Huang, Ying

