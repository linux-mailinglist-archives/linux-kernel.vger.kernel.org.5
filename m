Return-Path: <linux-kernel+bounces-147807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D38A79E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5F1C212BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B44C63;
	Wed, 17 Apr 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfRDgpC6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA54685
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314094; cv=none; b=apxAf1yu2wpxy5CNvhvrB/rfDlhpFNUVdkyPI6jnP+cHIAY2v/kgMXAfnaUcIrRvHaudJGVtCJC4RxJwk2K3IVMCc8CfX4y/sFwCh9f760qWCEL3B83uiSaGBuleIB9HR2xQwXtL3mmwK2/tiPlzJx+VIcecJiggw/Po9C2dmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314094; c=relaxed/simple;
	bh=ZC6g4oznpiFDs5ZbEy9v9MahjcM0skdGkMNc4EjXnEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThtmlbEQUk7nuzJxeWJ1BIo2wfFl8IGhdNrVifE09Mpu782z/TtKMlTu5Y41UA1GJjPS/00g61UUqaH19LEBB3SBeCkHImSz4IKvuuq4KM2XDc3bSog8Rxgi/UsyLgVg4qPvyctz+ESiHmQDwmS8gmjgN4adJkO1tPgJgK9zrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfRDgpC6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713314093; x=1744850093;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ZC6g4oznpiFDs5ZbEy9v9MahjcM0skdGkMNc4EjXnEY=;
  b=TfRDgpC6oFEdW7nXeJjCbY43LE/olzwJPxmHvSeYATKX548JkOROwDRS
   YAuwOHF/J/gMdOg30Fm65Q1zv0bIV247u+KANplxunXPuLkQUsO7L3WZW
   KlmPtquv7I5Pz8uDp3tuR6BBS8GwlZWstBUrOm6AR5nwVrYkpp7Wu4H2D
   5QWBQGhSZ+khg3XKldu+jWtUejp1630F3YnP7flBwOR7yZGiHtP3WNQrx
   qf8Nw97EmazgCOPVNiTthmmDxIbzqM3nH0nAHnduy3Wo+Le8DDb8h1YEu
   AyPBUW9+uaNr9J/XKHqCaoCZziCIUB+rdg8FDxNKYOx96otneuO13IZCs
   A==;
X-CSE-ConnectionGUID: Qtm0RgcRS/WnbkD6ckqSfg==
X-CSE-MsgGUID: h7oxXHAJRQC1o7hSfs6L+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8711629"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8711629"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:34:52 -0700
X-CSE-ConnectionGUID: D5JByUUbTYi5StUADXQLNA==
X-CSE-MsgGUID: 4nklnT3PSlms9EpxJY7tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27115890"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:34:47 -0700
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
In-Reply-To: <CAGsJ_4xigDba15o9K84z9nR_ZW1nXsUWa0LRNmUAfDdxcqsddw@mail.gmail.com>
	(Barry Song's message of "Tue, 16 Apr 2024 16:32:54 +1200")
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
	<87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xigDba15o9K84z9nR_ZW1nXsUWa0LRNmUAfDdxcqsddw@mail.gmail.com>
Date: Wed, 17 Apr 2024 08:32:54 +0800
Message-ID: <87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Tue, Apr 16, 2024 at 3:13=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huang@=
intel.com> wrote:
>> >> >> >>
>> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >>
>> >> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.hua=
ng@intel.com> wrote:
>> >> >> >> >>
>> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >> >>
>> >> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
>> >> >> >> >> >
>> >> >> >> >> > While swapping in a large folio, we need to free swaps rel=
ated to the whole
>> >> >> >> >> > folio. To avoid frequently acquiring and releasing swap lo=
cks, it is better
>> >> >> >> >> > to introduce an API for batched free.
>> >> >> >> >> >
>> >> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>> >> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >> > ---
>> >> >> >> >> >  include/linux/swap.h |  5 +++++
>> >> >> >> >> >  mm/swapfile.c        | 51 +++++++++++++++++++++++++++++++=
+++++++++++++
>> >> >> >> >> >  2 files changed, 56 insertions(+)
>> >> >> >> >> >
>> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> >> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
>> >> >> >> >> > --- a/include/linux/swap.h
>> >> >> >> >> > +++ b/include/linux/swap.h
>> >> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry=
_t);
>> >> >> >> >> >  extern int swap_duplicate(swp_entry_t);
>> >> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
>> >> >> >> >> >  extern void swap_free(swp_entry_t);
>> >> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>> >> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, =
int n);
>> >> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int=
 nr);
>> >> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
>> >> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entr=
y_t swp)
>> >> >> >> >> >  {
>> >> >> >> >> >  }
>> >> >> >> >> >
>> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> >> >> >> >> > +{
>> >> >> >> >> > +}
>> >> >> >> >> > +
>> >> >> >> >> >  static inline void put_swap_folio(struct folio *folio, sw=
p_entry_t swp)
>> >> >> >> >> >  {
>> >> >> >> >> >  }
>> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> >> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
>> >> >> >> >> > --- a/mm/swapfile.c
>> >> >> >> >> > +++ b/mm/swapfile.c
>> >> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
>> >> >> >> >> >               __swap_entry_free(p, entry);
>> >> >> >> >> >  }
>> >> >> >> >> >
>> >> >> >> >> > +/*
>> >> >> >> >> > + * Free up the maximum number of swap entries at once to =
limit the
>> >> >> >> >> > + * maximum kernel stack usage.
>> >> >> >> >> > + */
>> >> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWA=
PFILE_CLUSTER)
>> >> >> >> >> > +
>> >> >> >> >> > +/*
>> >> >> >> >> > + * Called after swapping in a large folio,
>> >> >> >> >>
>> >> >> >> >> IMHO, it's not good to document the caller in the function d=
efinition.
>> >> >> >> >> Because this will discourage function reusing.
>> >> >> >> >
>> >> >> >> > ok. right now there is only one user that is why it is added.=
 but i agree
>> >> >> >> > we can actually remove this.
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> > batched free swap entries
>> >> >> >> >> > + * for this large folio, entry should be for the first su=
bpage and
>> >> >> >> >> > + * its offset is aligned with nr_pages
>> >> >> >> >>
>> >> >> >> >> Why do we need this?
>> >> >> >> >
>> >> >> >> > This is a fundamental requirement for the existing kernel, fo=
lio's
>> >> >> >> > swap offset is naturally aligned from the first moment add_to=
_swap
>> >> >> >> > to add swapcache's xa. so this comment is describing the exis=
ting
>> >> >> >> > fact. In the future, if we want to support swap-out folio to =
discontiguous
>> >> >> >> > and not-aligned offsets, we can't pass entry as the parameter=
, we should
>> >> >> >> > instead pass ptep or another different data struct which can =
connect
>> >> >> >> > multiple discontiguous swap offsets.
>> >> >> >> >
>> >> >> >> > I feel like we only need "for this large folio, entry should =
be for
>> >> >> >> > the first subpage" and drop "and its offset is aligned with n=
r_pages",
>> >> >> >> > the latter is not important to this context at all.
>> >> >> >>
>> >> >> >> IIUC, all these are requirements of the only caller now, not the
>> >> >> >> function itself.  If only part of the all swap entries of a mTH=
P are
>> >> >> >> called with swap_free_nr(), can swap_free_nr() still do its wor=
k?  If
>> >> >> >> so, why not make swap_free_nr() as general as possible?
>> >> >> >
>> >> >> > right , i believe we can make swap_free_nr() as general as possi=
ble.
>> >> >> >
>> >> >> >>
>> >> >> >> >>
>> >> >> >> >> > + */
>> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> >> >> >> >> > +{
>> >> >> >> >> > +     int i, j;
>> >> >> >> >> > +     struct swap_cluster_info *ci;
>> >> >> >> >> > +     struct swap_info_struct *p;
>> >> >> >> >> > +     unsigned int type =3D swp_type(entry);
>> >> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
>> >> >> >> >> > +     int batch_nr, remain_nr;
>> >> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
>> >> >> >> >> > +
>> >> >> >> >> > +     /* all swap entries are within a cluster for mTHP */
>> >> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWA=
PFILE_CLUSTER);
>> >> >> >> >> > +
>> >> >> >> >> > +     if (nr_pages =3D=3D 1) {
>> >> >> >> >> > +             swap_free(entry);
>> >> >> >> >> > +             return;
>> >> >> >> >> > +     }
>> >> >> >> >>
>> >> >> >> >> Is it possible to unify swap_free() and swap_free_nr() into =
one function
>> >> >> >> >> with acceptable performance?  IIUC, the general rule in mTHP=
 effort is
>> >> >> >> >> to avoid duplicate functions between mTHP and normal small f=
olio.
>> >> >> >> >> Right?
>> >> >> >> >
>> >> >> >> > I don't see why.
>> >> >> >>
>> >> >> >> Because duplicated implementation are hard to maintain in the l=
ong term.
>> >> >> >
>> >> >> > sorry, i actually meant "I don't see why not",  for some reason,=
 the "not"
>> >> >> > was missed. Obviously I meant "why not", there was a "but" after=
 it :-)
>> >> >> >
>> >> >> >>
>> >> >> >> > but we have lots of places calling swap_free(), we may
>> >> >> >> > have to change them all to call swap_free_nr(entry, 1); the o=
ther possible
>> >> >> >> > way is making swap_free() a wrapper of swap_free_nr() always =
using
>> >> >> >> > 1 as the argument. In both cases, we are changing the semanti=
cs of
>> >> >> >> > swap_free_nr() to partially freeing large folio cases and hav=
e to drop
>> >> >> >> > "entry should be for the first subpage" then.
>> >> >> >> >
>> >> >> >> > Right now, the semantics is
>> >> >> >> > * swap_free_nr() for an entire large folio;
>> >> >> >> > * swap_free() for one entry of either a large folio or a smal=
l folio
>> >> >> >>
>> >> >> >> As above, I don't think the these semantics are important for
>> >> >> >> swap_free_nr() implementation.
>> >> >> >
>> >> >> > right. I agree. If we are ready to change all those callers, not=
hing
>> >> >> > can stop us from removing swap_free().
>> >> >> >
>> >> >> >>
>> >> >> >> >>
>> >> >> >> >> > +
>> >> >> >> >> > +     remain_nr =3D nr_pages;
>> >> >> >> >> > +     p =3D _swap_info_get(entry);
>> >> >> >> >> > +     if (p) {
>> >> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr)=
 {
>> >> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH_N=
R, remain_nr);
>> >> >> >> >> > +
>> >> >> >> >> > +                     ci =3D lock_cluster_or_swap_info(p, =
offset);
>> >> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++) {
>> >> >> >> >> > +                             if (__swap_entry_free_locked=
(p, offset + i * SWAP_BATCH_NR + j, 1))
>> >> >> >> >> > +                                     __bitmap_set(usage, =
j, 1);
>> >> >> >> >> > +                     }
>> >> >> >> >> > +                     unlock_cluster_or_swap_info(p, ci);
>> >> >> >> >> > +
>> >> >> >> >> > +                     for_each_clear_bit(j, usage, batch_n=
r)
>> >> >> >> >> > +                             free_swap_slot(swp_entry(typ=
e, offset + i * SWAP_BATCH_NR + j));
>> >> >> >> >> > +
>> >> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR=
);
>> >> >> >> >> > +                     remain_nr -=3D batch_nr;
>> >> >> >> >> > +             }
>> >> >> >> >> > +     }
>> >> >> >> >> > +}
>> >> >> >> >> > +
>> >> >> >> >> >  /*
>> >> >> >> >> >   * Called after dropping swapcache to decrease refcnt to =
swap entries.
>> >> >> >> >> >   */
>> >> >> >> >>
>> >> >> >> >> put_swap_folio() implements batching in another method.  Do =
you think
>> >> >> >> >> that it's good to use the batching method in that function h=
ere?  It
>> >> >> >> >> avoids to use bitmap operations and stack space.
>> >> >> >> >
>> >> >> >> > Chuanhua has strictly limited the maximum stack usage to seve=
ral
>> >> >> >> > unsigned long,
>> >> >> >>
>> >> >> >> 512 / 8 =3D 64 bytes.
>> >> >> >>
>> >> >> >> So, not trivial.
>> >> >> >>
>> >> >> >> > so this should be safe. on the other hand, i believe this
>> >> >> >> > implementation is more efficient, as  put_swap_folio() might =
lock/
>> >> >> >> > unlock much more often whenever __swap_entry_free_locked retu=
rns
>> >> >> >> > 0.
>> >> >> >>
>> >> >> >> There are 2 most common use cases,
>> >> >> >>
>> >> >> >> - all swap entries have usage count =3D=3D 0
>> >> >> >> - all swap entries have usage count !=3D 0
>> >> >> >>
>> >> >> >> In both cases, we only need to lock/unlock once.  In fact, I di=
dn't
>> >> >> >> find possible use cases other than above.
>> >> >> >
>> >> >> > i guess the point is free_swap_slot() shouldn't be called within
>> >> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages slots,
>> >> >> > we'll have to unlock and lock nr_pages times?  and this is the m=
ost
>> >> >> > common scenario.
>> >> >>
>> >> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUSTER =
(that
>> >> >> is, nr_pages) or 0.  These are the most common cases.
>> >> >>
>> >> >
>> >> > i am actually talking about the below code path,
>> >> >
>> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
>> >> > {
>> >> >         ...
>> >> >
>> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
>> >> >         ...
>> >> >         for (i =3D 0; i < size; i++, entry.val++) {
>> >> >                 if (!__swap_entry_free_locked(si, offset + i, SWAP_=
HAS_CACHE)) {
>> >> >                         unlock_cluster_or_swap_info(si, ci);
>> >> >                         free_swap_slot(entry);
>> >> >                         if (i =3D=3D size - 1)
>> >> >                                 return;
>> >> >                         lock_cluster_or_swap_info(si, offset);
>> >> >                 }
>> >> >         }
>> >> >         unlock_cluster_or_swap_info(si, ci);
>> >> > }
>> >> >
>> >> > but i guess you are talking about the below code path:
>> >> >
>> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
>> >> > {
>> >> >         ...
>> >> >
>> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
>> >> >         if (size =3D=3D SWAPFILE_CLUSTER) {
>> >> >                 map =3D si->swap_map + offset;
>> >> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
>> >> >                         val =3D map[i];
>> >> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
>> >> >                         if (val =3D=3D SWAP_HAS_CACHE)
>> >> >                                 free_entries++;
>> >> >                 }
>> >> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
>> >> >                         unlock_cluster_or_swap_info(si, ci);
>> >> >                         spin_lock(&si->lock);
>> >> >                         mem_cgroup_uncharge_swap(entry, SWAPFILE_CL=
USTER);
>> >> >                         swap_free_cluster(si, idx);
>> >> >                         spin_unlock(&si->lock);
>> >> >                         return;
>> >> >                 }
>> >> >         }
>> >> > }
>> >>
>> >> I am talking about both code paths.  In 2 most common cases,
>> >> __swap_entry_free_locked() will return 0 or !0 for all entries in ran=
ge.
>> >
>> > I grasp your point, but if conditions involving 0 or non-0 values fail=
, we'll
>> > end up repeatedly unlocking and locking. Picture a scenario with a lar=
ge
>> > folio shared by multiple processes. One process might unmap a portion
>> > while another still holds an entire mapping to it. This could lead to =
situations
>> > where free_entries doesn't equal 0 and free_entries doesn't equal
>> > nr_pages, resulting in multiple unlock and lock operations.
>>
>> This is impossible in current caller, because the folio is in the swap
>> cache.  But if we move the change to __swap_entry_free_nr(), we may run
>> into this situation.
>
> I don't understand why it is impossible, after try_to_unmap_one() has done
> on one process, mprotect and munmap called on a part of the large folio
> pte entries which now have been swap entries, we are removing the PTE
> for this part. Another process can entirely hit the swapcache and have
> all swap entries mapped there, and we call swap_free_nr(entry, nr_pages) =
in
> do_swap_page. Within those swap entries, some have swapcount=3D1 and othe=
rs
> have swapcount > 1. Am I missing something?

For swap entries with swapcount=3D1, its sis->swap_map[] will be

1 | SWAP_HAS_CACHE

so, __swap_entry_free_locked() will return SWAP_HAS_CACHE instead of 0.

The swap entries will be free in

folio_free_swap
  delete_from_swap_cache
    put_swap_folio

>> > Chuanhua has invested significant effort in following Ryan's suggestion
>> > for the current approach, which generally handles all cases, especially
>> > partial unmapping. Additionally, the widespread use of swap_free_nr()
>> > as you suggested across various scenarios is noteworthy.
>> >
>> > Unless there's evidence indicating performance issues or bugs, I belie=
ve
>> > the current approach remains preferable.
>>
>> TBH, I don't like the large stack space usage (64 bytes).  How about use
>> a "unsigned long" as bitmap?  Then, we use much less stack space, use
>> bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check the most =
common
>> use cases.  And, we have enough batching.
>
> that is quite a straightforward modification like,
>
> - #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER)
> + #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTER)
>
> there is no necessity to remove the bitmap API and move to raw
> unsigned long operations.
> as bitmap is exactly some unsigned long. on 64bit CPU, we are now one
> unsigned long,
> on 32bit CPU, it is now two unsigned long.

Yes.  We can still use most bitmap APIs if we use "unsigned long" as
bitmap.  The advantage of "unsigned long" is to guarantee that
bitmap_empty() and bitmap_full() is trivial.  We can use that for
optimization.  For example, we can skip unlock/lock if bitmap_empty().

>>
>> >>
>> >> > we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
>> >> > or you want to check free_entries =3D=3D "1 << swap_entry_order(fol=
io_order(folio))"
>> >> > instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i++, e=
ntry.val++)"
>> >> > path?
>> >>
>> >> Just replace SWAPFILE_CLUSTER with "nr_pages" in your code.
>> >>
>> >> >
>> >> >> >>
>> >> >> >> And, we should add batching in __swap_entry_free().  That will =
help
>> >> >> >> free_swap_and_cache_nr() too.
>> >> >
>> >> > Chris Li and I actually discussed it before, while I completely
>> >> > agree this can be batched. but i'd like to defer this as an increme=
ntal
>> >> > patchset later to keep this swapcache-refault small.
>> >>
>> >> OK.
>> >>
>> >> >>
>> >> >> Please consider this too.

--
Best Regards,
Huang, Ying

