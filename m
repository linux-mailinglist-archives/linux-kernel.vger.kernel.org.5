Return-Path: <linux-kernel+bounces-149754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008008A9570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB116282383
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34515887E;
	Thu, 18 Apr 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gt95ejSf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D31E498
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430649; cv=none; b=IiiIou3Y3Q6VHQcw2nkY2skXNvGe6y554A3UufycSGVFONIKCgTOJO0+GkPK/xHJBCG9ngovD7i9P0H9unYlKdJwuAuwg1vAzCSRSgsCXGwUv384oqZnxcSApUrr97xDQmw0Ho+RNSGCAf5kl3eKc9ea3m/o/nMylDA0c59umsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430649; c=relaxed/simple;
	bh=ibuEIRA3NzNs6eVaJHLMM5650OJmlfASuidh5sZ4E0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Er9VZ2mpx1WGtIN9sXeo16YXmLhR8B4S6TLaO/vjeTtEfN1PryQOMg5VUo3rDp6qE0kgarFsAENpJywD7ABVG0X8VBKwVRVJbnl/KX1Uq3ZIiC2Z4hXD9K8hKt/i9Uw0wGnX8cJ7K1TD0BaX294U6hyOcI3cFug7Dcf093+8Rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gt95ejSf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713430647; x=1744966647;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ibuEIRA3NzNs6eVaJHLMM5650OJmlfASuidh5sZ4E0o=;
  b=gt95ejSfkwOsYCCH4JHZe+XL/sk+NLx3OX+3fbPjOx2a+/5JSpH6xS5X
   DAS0AGbTYsVYIz7FLEutBhLbBUA/048d+JV4tBuL7ER7ZgqRVZpSWNps2
   AdgCGFQfYBF2QD8iIsDD8Hh+u5/nZ0NmAlmg+bMCd/sEfMq+D1x9nyS3A
   aqDVjM2dOGi0a9EVycH3RItP8F4ejm+BU0OY6QsYIFLxwVFOfjN47LHgM
   nh3AKBq9m3JpuBx74kNJuIHi0XoD47EP7RNkOZsnN4ZhfujabdTzAY+7C
   euKdUwfWYWwZ5Ujm3lTSaMCrhyy0iGO3+OSaftSBgvHEgUUaPZRCqI52q
   g==;
X-CSE-ConnectionGUID: mab3xQzMQP2rRxUgWL33ug==
X-CSE-MsgGUID: BbBIVkPbRZmPHNFTO/u6yA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9513212"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9513212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 01:57:26 -0700
X-CSE-ConnectionGUID: lrHWGTjCT4O2ymnv2VzK5A==
X-CSE-MsgGUID: UOkOnFOgSyCj4qORQxmvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22947148"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 01:57:21 -0700
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
In-Reply-To: <CAGsJ_4ymv-tmpmH0s1D5+GF13UOPv5UdRFrLOxVE5X+xNUHveg@mail.gmail.com>
	(Barry Song's message of "Thu, 18 Apr 2024 17:27:48 +1200")
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
	<87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wTsJe2yK3k+Tif6obgL9LUUuqXEBxhqMSZSFZpbvrzmA@mail.gmail.com>
	<CAGsJ_4ymv-tmpmH0s1D5+GF13UOPv5UdRFrLOxVE5X+xNUHveg@mail.gmail.com>
Date: Thu, 18 Apr 2024 16:55:28 +0800
Message-ID: <87le5bxd6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Apr 17, 2024 at 1:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
>>
>> On Wed, Apr 17, 2024 at 12:34=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >
>> > Barry Song <21cnbao@gmail.com> writes:
>> >
>> > > On Tue, Apr 16, 2024 at 3:13=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
>> > >>
>> > >> Barry Song <21cnbao@gmail.com> writes:
>> > >>
>> > >> > On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
>> > >> >>
>> > >> >> Barry Song <21cnbao@gmail.com> writes:
>> > >> >>
>> > >> >> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huan=
g@intel.com> wrote:
>> > >> >> >>
>> > >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> > >> >> >>
>> > >> >> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.h=
uang@intel.com> wrote:
>> > >> >> >> >>
>> > >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> > >> >> >> >>
>> > >> >> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <yin=
g.huang@intel.com> wrote:
>> > >> >> >> >> >>
>> > >> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> > >> >> >> >> >>
>> > >> >> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
>> > >> >> >> >> >> >
>> > >> >> >> >> >> > While swapping in a large folio, we need to free swap=
s related to the whole
>> > >> >> >> >> >> > folio. To avoid frequently acquiring and releasing sw=
ap locks, it is better
>> > >> >> >> >> >> > to introduce an API for batched free.
>> > >> >> >> >> >> >
>> > >> >> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>> > >> >> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>> > >> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > >> >> >> >> >> > ---
>> > >> >> >> >> >> >  include/linux/swap.h |  5 +++++
>> > >> >> >> >> >> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++=
++++++++++++++++++
>> > >> >> >> >> >> >  2 files changed, 56 insertions(+)
>> > >> >> >> >> >> >
>> > >> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swa=
p.h
>> > >> >> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
>> > >> >> >> >> >> > --- a/include/linux/swap.h
>> > >> >> >> >> >> > +++ b/include/linux/swap.h
>> > >> >> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_=
entry_t);
>> > >> >> >> >> >> >  extern int swap_duplicate(swp_entry_t);
>> > >> >> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
>> > >> >> >> >> >> >  extern void swap_free(swp_entry_t);
>> > >> >> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_p=
ages);
>> > >> >> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entr=
ies, int n);
>> > >> >> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry=
, int nr);
>> > >> >> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
>> > >> >> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp=
_entry_t swp)
>> > >> >> >> >> >> >  {
>> > >> >> >> >> >> >  }
>> > >> >> >> >> >> >
>> > >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> > >> >> >> >> >> > +{
>> > >> >> >> >> >> > +}
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> >  static inline void put_swap_folio(struct folio *foli=
o, swp_entry_t swp)
>> > >> >> >> >> >> >  {
>> > >> >> >> >> >> >  }
>> > >> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > >> >> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
>> > >> >> >> >> >> > --- a/mm/swapfile.c
>> > >> >> >> >> >> > +++ b/mm/swapfile.c
>> > >> >> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t ent=
ry)
>> > >> >> >> >> >> >               __swap_entry_free(p, entry);
>> > >> >> >> >> >> >  }
>> > >> >> >> >> >> >
>> > >> >> >> >> >> > +/*
>> > >> >> >> >> >> > + * Free up the maximum number of swap entries at onc=
e to limit the
>> > >> >> >> >> >> > + * maximum kernel stack usage.
>> > >> >> >> >> >> > + */
>> > >> >> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 =
: SWAPFILE_CLUSTER)
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +/*
>> > >> >> >> >> >> > + * Called after swapping in a large folio,
>> > >> >> >> >> >>
>> > >> >> >> >> >> IMHO, it's not good to document the caller in the funct=
ion definition.
>> > >> >> >> >> >> Because this will discourage function reusing.
>> > >> >> >> >> >
>> > >> >> >> >> > ok. right now there is only one user that is why it is a=
dded. but i agree
>> > >> >> >> >> > we can actually remove this.
>> > >> >> >> >> >
>> > >> >> >> >> >>
>> > >> >> >> >> >> > batched free swap entries
>> > >> >> >> >> >> > + * for this large folio, entry should be for the fir=
st subpage and
>> > >> >> >> >> >> > + * its offset is aligned with nr_pages
>> > >> >> >> >> >>
>> > >> >> >> >> >> Why do we need this?
>> > >> >> >> >> >
>> > >> >> >> >> > This is a fundamental requirement for the existing kerne=
l, folio's
>> > >> >> >> >> > swap offset is naturally aligned from the first moment a=
dd_to_swap
>> > >> >> >> >> > to add swapcache's xa. so this comment is describing the=
 existing
>> > >> >> >> >> > fact. In the future, if we want to support swap-out foli=
o to discontiguous
>> > >> >> >> >> > and not-aligned offsets, we can't pass entry as the para=
meter, we should
>> > >> >> >> >> > instead pass ptep or another different data struct which=
 can connect
>> > >> >> >> >> > multiple discontiguous swap offsets.
>> > >> >> >> >> >
>> > >> >> >> >> > I feel like we only need "for this large folio, entry sh=
ould be for
>> > >> >> >> >> > the first subpage" and drop "and its offset is aligned w=
ith nr_pages",
>> > >> >> >> >> > the latter is not important to this context at all.
>> > >> >> >> >>
>> > >> >> >> >> IIUC, all these are requirements of the only caller now, n=
ot the
>> > >> >> >> >> function itself.  If only part of the all swap entries of =
a mTHP are
>> > >> >> >> >> called with swap_free_nr(), can swap_free_nr() still do it=
s work?  If
>> > >> >> >> >> so, why not make swap_free_nr() as general as possible?
>> > >> >> >> >
>> > >> >> >> > right , i believe we can make swap_free_nr() as general as =
possible.
>> > >> >> >> >
>> > >> >> >> >>
>> > >> >> >> >> >>
>> > >> >> >> >> >> > + */
>> > >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
>> > >> >> >> >> >> > +{
>> > >> >> >> >> >> > +     int i, j;
>> > >> >> >> >> >> > +     struct swap_cluster_info *ci;
>> > >> >> >> >> >> > +     struct swap_info_struct *p;
>> > >> >> >> >> >> > +     unsigned int type =3D swp_type(entry);
>> > >> >> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
>> > >> >> >> >> >> > +     int batch_nr, remain_nr;
>> > >> >> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +     /* all swap entries are within a cluster for mT=
HP */
>> > >> >> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages =
> SWAPFILE_CLUSTER);
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +     if (nr_pages =3D=3D 1) {
>> > >> >> >> >> >> > +             swap_free(entry);
>> > >> >> >> >> >> > +             return;
>> > >> >> >> >> >> > +     }
>> > >> >> >> >> >>
>> > >> >> >> >> >> Is it possible to unify swap_free() and swap_free_nr() =
into one function
>> > >> >> >> >> >> with acceptable performance?  IIUC, the general rule in=
 mTHP effort is
>> > >> >> >> >> >> to avoid duplicate functions between mTHP and normal sm=
all folio.
>> > >> >> >> >> >> Right?
>> > >> >> >> >> >
>> > >> >> >> >> > I don't see why.
>> > >> >> >> >>
>> > >> >> >> >> Because duplicated implementation are hard to maintain in =
the long term.
>> > >> >> >> >
>> > >> >> >> > sorry, i actually meant "I don't see why not",  for some re=
ason, the "not"
>> > >> >> >> > was missed. Obviously I meant "why not", there was a "but" =
after it :-)
>> > >> >> >> >
>> > >> >> >> >>
>> > >> >> >> >> > but we have lots of places calling swap_free(), we may
>> > >> >> >> >> > have to change them all to call swap_free_nr(entry, 1); =
the other possible
>> > >> >> >> >> > way is making swap_free() a wrapper of swap_free_nr() al=
ways using
>> > >> >> >> >> > 1 as the argument. In both cases, we are changing the se=
mantics of
>> > >> >> >> >> > swap_free_nr() to partially freeing large folio cases an=
d have to drop
>> > >> >> >> >> > "entry should be for the first subpage" then.
>> > >> >> >> >> >
>> > >> >> >> >> > Right now, the semantics is
>> > >> >> >> >> > * swap_free_nr() for an entire large folio;
>> > >> >> >> >> > * swap_free() for one entry of either a large folio or a=
 small folio
>> > >> >> >> >>
>> > >> >> >> >> As above, I don't think the these semantics are important =
for
>> > >> >> >> >> swap_free_nr() implementation.
>> > >> >> >> >
>> > >> >> >> > right. I agree. If we are ready to change all those callers=
, nothing
>> > >> >> >> > can stop us from removing swap_free().
>> > >> >> >> >
>> > >> >> >> >>
>> > >> >> >> >> >>
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +     remain_nr =3D nr_pages;
>> > >> >> >> >> >> > +     p =3D _swap_info_get(entry);
>> > >> >> >> >> >> > +     if (p) {
>> > >> >> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batc=
h_nr) {
>> > >> >> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BA=
TCH_NR, remain_nr);
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +                     ci =3D lock_cluster_or_swap_inf=
o(p, offset);
>> > >> >> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++=
) {
>> > >> >> >> >> >> > +                             if (__swap_entry_free_l=
ocked(p, offset + i * SWAP_BATCH_NR + j, 1))
>> > >> >> >> >> >> > +                                     __bitmap_set(us=
age, j, 1);
>> > >> >> >> >> >> > +                     }
>> > >> >> >> >> >> > +                     unlock_cluster_or_swap_info(p, =
ci);
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +                     for_each_clear_bit(j, usage, ba=
tch_nr)
>> > >> >> >> >> >> > +                             free_swap_slot(swp_entr=
y(type, offset + i * SWAP_BATCH_NR + j));
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BAT=
CH_NR);
>> > >> >> >> >> >> > +                     remain_nr -=3D batch_nr;
>> > >> >> >> >> >> > +             }
>> > >> >> >> >> >> > +     }
>> > >> >> >> >> >> > +}
>> > >> >> >> >> >> > +
>> > >> >> >> >> >> >  /*
>> > >> >> >> >> >> >   * Called after dropping swapcache to decrease refcn=
t to swap entries.
>> > >> >> >> >> >> >   */
>> > >> >> >> >> >>
>> > >> >> >> >> >> put_swap_folio() implements batching in another method.=
  Do you think
>> > >> >> >> >> >> that it's good to use the batching method in that funct=
ion here?  It
>> > >> >> >> >> >> avoids to use bitmap operations and stack space.
>> > >> >> >> >> >
>> > >> >> >> >> > Chuanhua has strictly limited the maximum stack usage to=
 several
>> > >> >> >> >> > unsigned long,
>> > >> >> >> >>
>> > >> >> >> >> 512 / 8 =3D 64 bytes.
>> > >> >> >> >>
>> > >> >> >> >> So, not trivial.
>> > >> >> >> >>
>> > >> >> >> >> > so this should be safe. on the other hand, i believe this
>> > >> >> >> >> > implementation is more efficient, as  put_swap_folio() m=
ight lock/
>> > >> >> >> >> > unlock much more often whenever __swap_entry_free_locked=
 returns
>> > >> >> >> >> > 0.
>> > >> >> >> >>
>> > >> >> >> >> There are 2 most common use cases,
>> > >> >> >> >>
>> > >> >> >> >> - all swap entries have usage count =3D=3D 0
>> > >> >> >> >> - all swap entries have usage count !=3D 0
>> > >> >> >> >>
>> > >> >> >> >> In both cases, we only need to lock/unlock once.  In fact,=
 I didn't
>> > >> >> >> >> find possible use cases other than above.
>> > >> >> >> >
>> > >> >> >> > i guess the point is free_swap_slot() shouldn't be called w=
ithin
>> > >> >> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages =
slots,
>> > >> >> >> > we'll have to unlock and lock nr_pages times?  and this is =
the most
>> > >> >> >> > common scenario.
>> > >> >> >>
>> > >> >> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLU=
STER (that
>> > >> >> >> is, nr_pages) or 0.  These are the most common cases.
>> > >> >> >>
>> > >> >> >
>> > >> >> > i am actually talking about the below code path,
>> > >> >> >
>> > >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
>> > >> >> > {
>> > >> >> >         ...
>> > >> >> >
>> > >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
>> > >> >> >         ...
>> > >> >> >         for (i =3D 0; i < size; i++, entry.val++) {
>> > >> >> >                 if (!__swap_entry_free_locked(si, offset + i, =
SWAP_HAS_CACHE)) {
>> > >> >> >                         unlock_cluster_or_swap_info(si, ci);
>> > >> >> >                         free_swap_slot(entry);
>> > >> >> >                         if (i =3D=3D size - 1)
>> > >> >> >                                 return;
>> > >> >> >                         lock_cluster_or_swap_info(si, offset);
>> > >> >> >                 }
>> > >> >> >         }
>> > >> >> >         unlock_cluster_or_swap_info(si, ci);
>> > >> >> > }
>> > >> >> >
>> > >> >> > but i guess you are talking about the below code path:
>> > >> >> >
>> > >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
>> > >> >> > {
>> > >> >> >         ...
>> > >> >> >
>> > >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
>> > >> >> >         if (size =3D=3D SWAPFILE_CLUSTER) {
>> > >> >> >                 map =3D si->swap_map + offset;
>> > >> >> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
>> > >> >> >                         val =3D map[i];
>> > >> >> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
>> > >> >> >                         if (val =3D=3D SWAP_HAS_CACHE)
>> > >> >> >                                 free_entries++;
>> > >> >> >                 }
>> > >> >> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
>> > >> >> >                         unlock_cluster_or_swap_info(si, ci);
>> > >> >> >                         spin_lock(&si->lock);
>> > >> >> >                         mem_cgroup_uncharge_swap(entry, SWAPFI=
LE_CLUSTER);
>> > >> >> >                         swap_free_cluster(si, idx);
>> > >> >> >                         spin_unlock(&si->lock);
>> > >> >> >                         return;
>> > >> >> >                 }
>> > >> >> >         }
>> > >> >> > }
>> > >> >>
>> > >> >> I am talking about both code paths.  In 2 most common cases,
>> > >> >> __swap_entry_free_locked() will return 0 or !0 for all entries i=
n range.
>> > >> >
>> > >> > I grasp your point, but if conditions involving 0 or non-0 values=
 fail, we'll
>> > >> > end up repeatedly unlocking and locking. Picture a scenario with =
a large
>> > >> > folio shared by multiple processes. One process might unmap a por=
tion
>> > >> > while another still holds an entire mapping to it. This could lea=
d to situations
>> > >> > where free_entries doesn't equal 0 and free_entries doesn't equal
>> > >> > nr_pages, resulting in multiple unlock and lock operations.
>> > >>
>> > >> This is impossible in current caller, because the folio is in the s=
wap
>> > >> cache.  But if we move the change to __swap_entry_free_nr(), we may=
 run
>> > >> into this situation.
>> > >
>> > > I don't understand why it is impossible, after try_to_unmap_one() ha=
s done
>> > > on one process, mprotect and munmap called on a part of the large fo=
lio
>> > > pte entries which now have been swap entries, we are removing the PTE
>> > > for this part. Another process can entirely hit the swapcache and ha=
ve
>> > > all swap entries mapped there, and we call swap_free_nr(entry, nr_pa=
ges) in
>> > > do_swap_page. Within those swap entries, some have swapcount=3D1 and=
 others
>> > > have swapcount > 1. Am I missing something?
>> >
>> > For swap entries with swapcount=3D1, its sis->swap_map[] will be
>> >
>> > 1 | SWAP_HAS_CACHE
>> >
>> > so, __swap_entry_free_locked() will return SWAP_HAS_CACHE instead of 0.
>> >
>> > The swap entries will be free in
>> >
>> > folio_free_swap
>> >   delete_from_swap_cache
>> >     put_swap_folio
>> >
>>
>> Yes. I realized this after replying to you yesterday.
>>
>> > >> > Chuanhua has invested significant effort in following Ryan's sugg=
estion
>> > >> > for the current approach, which generally handles all cases, espe=
cially
>> > >> > partial unmapping. Additionally, the widespread use of swap_free_=
nr()
>> > >> > as you suggested across various scenarios is noteworthy.
>> > >> >
>> > >> > Unless there's evidence indicating performance issues or bugs, I =
believe
>> > >> > the current approach remains preferable.
>> > >>
>> > >> TBH, I don't like the large stack space usage (64 bytes).  How abou=
t use
>> > >> a "unsigned long" as bitmap?  Then, we use much less stack space, u=
se
>> > >> bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check the =
most common
>> > >> use cases.  And, we have enough batching.
>> > >
>> > > that is quite a straightforward modification like,
>> > >
>> > > - #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLU=
STER)
>> > > + #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUST=
ER)
>> > >
>> > > there is no necessity to remove the bitmap API and move to raw
>> > > unsigned long operations.
>> > > as bitmap is exactly some unsigned long. on 64bit CPU, we are now one
>> > > unsigned long,
>> > > on 32bit CPU, it is now two unsigned long.
>> >
>> > Yes.  We can still use most bitmap APIs if we use "unsigned long" as
>> > bitmap.  The advantage of "unsigned long" is to guarantee that
>> > bitmap_empty() and bitmap_full() is trivial.  We can use that for
>> > optimization.  For example, we can skip unlock/lock if bitmap_empty().
>>
>> anyway we have avoided lock_cluster_or_swap_info and unlock_cluster_or_s=
wap_info
>> for each individual swap entry.
>>
>> if bitma_empty(), we won't call free_swap_slot() so no chance to
>> further take any lock,
>> right?
>>
>> the optimization of bitmap_full() seems to be more useful only after we =
have
>> void free_swap_slot(swp_entry_t entry, int nr)
>>
>> in which we can avoid many spin_lock_irq(&cache->free_lock);
>>
>> On the other hand, it seems we can directly call
>> swapcache_free_entries() to skip cache if
>> nr_pages >=3D SWAP_BATCH(64) this might be an optimization as we are now
>> having a bitmap exactly equals 64.
>
> Hi ying,
> considering the below code which has changed bitmap to 64 and generally s=
upport
> different nr_pages(1 and ever cross cluster),
>
> #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTER)
>
> void swap_free_nr(swp_entry_t entry, int nr_pages)
> {
>         int i =3D 0, j;
>         struct swap_cluster_info *ci;
>         struct swap_info_struct *p;
>         unsigned int type =3D swp_type(entry);
>         unsigned long offset =3D swp_offset(entry);
>         int batch_nr, remain_nr;
>         DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
>
>         remain_nr =3D nr_pages;
>         p =3D _swap_info_get(entry);
>         if (!p)
>                 return;
>
>         for ( ; ; ) {
>                 batch_nr =3D min3(SWAP_BATCH_NR, remain_nr,
>                                 (int)(SWAPFILE_CLUSTER - (offset %
> SWAPFILE_CLUSTER)));
>
>                 ci =3D lock_cluster_or_swap_info(p, offset);
>                 for (j =3D 0; j < batch_nr; j++) {
>                         if (__swap_entry_free_locked(p, offset + i *
> SWAP_BATCH_NR + j, 1))
>                                 __bitmap_set(usage, j, 1);
>                 }
>                 unlock_cluster_or_swap_info(p, ci);
>
>                 for_each_clear_bit(j, usage, batch_nr)
>                         free_swap_slot(swp_entry(type, offset + i *
> SWAP_BATCH_NR + j));
>
>                 i +=3D batch_nr;
>                 if (i >=3D nr_pages)
>                         break;
>
>                 bitmap_clear(usage, 0, SWAP_BATCH_NR);
>                 remain_nr -=3D batch_nr;
>         }
> }
>
> I still don't see the benefits of using bitmap_full and bitmap_empty over=
 simple
> for_each_clear_bit() unless we begin to support free_swap_slot_nr(), whic=
h,
> I believe, needs a separate incremental patchset.
>
> using bitmap_empty and full, if we want to free all slots, we need
> if (bitmap_empty(usage))
> {
>     for (i=3D0;i<batch_nr;i++)
>               free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR +=
 j));
> }
> This seems just a game replacing for_each_clear_bit by
> bitmap_empty()+another for loop.
>
> if we don't want to free any one, we need
> if(bitmap_full(usage)
>        do_nothing.
>
> in the for_each_clear_bit() case, the loop just simply ends.
>
> What's your proposal code to use bitmap_empty and bitmap_full here?
> Am I missing something?

My idea is something as below.  It's only build tested.

static void cluster_swap_free_nr(struct swap_info_struct *sis,
				 unsigned long offset, int nr_pages)
{
	struct swap_cluster_info *ci;
	DECLARE_BITMAP(to_free, BITS_PER_LONG) =3D { 0 };
	int i, nr;

	ci =3D lock_cluster_or_swap_info(sis, offset);
	while (nr_pages) {
		nr =3D min(BITS_PER_LONG, nr_pages);
		for (i =3D 0; i < nr; i++) {
			if (!__swap_entry_free_locked(sis, offset + i, 1))
				bitmap_set(to_free, i, 1);
		}
		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
			unlock_cluster_or_swap_info(sis, ci);
			for_each_set_bit(i, to_free, BITS_PER_LONG)
				free_swap_slot(swp_entry(sis->type, offset + i));
			if (nr =3D=3D nr_pages)
				return;
			bitmap_clear(to_free, 0, BITS_PER_LONG);
			ci =3D lock_cluster_or_swap_info(sis, offset);
		}
		offset +=3D nr;
		nr_pages -=3D nr;
	}
	unlock_cluster_or_swap_info(sis, ci);
}

void swap_free_nr(swp_entry_t entry, int nr_pages)
{
	int nr;
	struct swap_info_struct *sis;
	unsigned long offset =3D swp_offset(entry);

	sis =3D _swap_info_get(entry);
	if (!sis)
		return;

	while (nr_pages >=3D 0) {
		nr =3D min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
		cluster_swap_free_nr(sis, offset, nr);
		offset +=3D nr;
		nr_pages -=3D nr;
	}
}

--
Best Regards,
Huang, Ying

