Return-Path: <linux-kernel+bounces-112213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308F8876F6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950CA283960
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976D4A15;
	Sat, 23 Mar 2024 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2V4CP9/"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08511138A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711165846; cv=none; b=F/SXC44lC31GuO1rW3xevwt1RppyTROumN5DHmtpRcx6Ian9yUuYC9aXTzEdOMP0zI2ceHiqmOnquOzzLhAiHFUd+DKEIdBFhoGPanEThV2JARMY/M6LNC5qOYamCWxxxsdIAuweKOGYs86AYWd9sK5fpo5aijYfX2UyA33UV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711165846; c=relaxed/simple;
	bh=h2p2s+ylXc8pvgYi/ondQV8b/LNGPK2M+grUPPkxZvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN3XH2UrcjH0EV6hYoW41LIo+mGTHjyZjEn7mpJ7+Sbf4KBssGt0QBsJyy5qpM5T7dq0wFYUDXCkxfeqLekF+WGrpJFFszj9TrJs20diDQHVExjdOXmrO1KzihqD7IXczQMFtaVTFm6pZbg2k1jLl0l6U2HQNAENj3iAydYgZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2V4CP9/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d44fb48077so1121492e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711165843; x=1711770643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjMQo5R7NIMHB3tcFRBK4D4Wkkx1HnfUBooP8J2eHWk=;
        b=m2V4CP9/P1xlhy4+HWh7Sg6d8CZ6XkuIErqt9UxJIhWBaRilIxixP2aBvenE15V1/R
         u76CMZ8p1voCD/f96guSfs8UYwqcqlWx2GI6HD1O0D1YKM17TO9Fpee1j/i1qSLjZGwB
         Zr5QsWjSU33/z0jLbPFa8d5vX563MXn9rS17qhMmWpKQEchH137kIPqFMSu8eGCC21i0
         +LXRREqd/+YpXNlDVBjsomjXUfhd0Pz4eygslxfnt91GZOeMIzy7Y9TrcaUg6EdrThQa
         Ooz5bEu/5qmXYMrr5jNvsk1WEsvuyxmPmLM2PEg3UFdUOaKV79e1d6LPylzxrY26h1cS
         ljvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711165843; x=1711770643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjMQo5R7NIMHB3tcFRBK4D4Wkkx1HnfUBooP8J2eHWk=;
        b=HKwZB4JWp9cDpMaODUboTY7jkwf7kUWgBk3XaQmwypnAilIr8TM49XAr6wfZpzPWr3
         47KFOp4zyMvXUeH5wY/ugPSJyXmjQnQUTh3ORllKeSpNcrCS6xiGyO0Nsdq98QinOqnT
         1XHcOaE2DcBMIxWu9JNYgXuAfNS2jKD943+mUp4RtANHtIcVhNphAK5NBGp+52rB1qqd
         wo/N18J6wxnIdR1jPbjk00gx5gkqi5sBmi1RKEBake6n8rjcopRaZN5ZS4BbrfnnpE19
         MsOot10S2O0zzn/gqWWQoiiJsvTv/9lZ04j4l5fFoFeAhSpP3ftYBjz41PBZ/f29752E
         lffQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7RUCVOz/asniEFUtHmRAXnhG1JscVoWDI+4r3DeQ7Q9vkO0OM3DrQGT7OSxCmvUlwyGD6T50mNgu4Ukp00huO/La4wfoc1c1FZ7ID
X-Gm-Message-State: AOJu0YxYt0hk9nP0VSHhEfXghuR/VqXSJZJLcw7uTnBKWUvgS3jbgslT
	AcckTXbcgwh27wcZTnAoSEr5irbXRUtnxQUOLOoAowDR7Os9+52gx6FO1QhocsNULiGQDIq7flO
	2E5D5mo9dCKtNSSnZV3jzQNbieqw=
X-Google-Smtp-Source: AGHT+IHBBgVjK+9IcpDz4AkZrHf3eFA7ChlAEKXO/RYVm9keDb/W/LrsG00LfM8Vm7YU3OreOIfrtF5+HT/2FvZKbKQ=
X-Received: by 2002:a05:6102:1627:b0:476:a58f:736c with SMTP id
 cu39-20020a056102162700b00476a58f736cmr1699473vsb.4.1711165842849; Fri, 22
 Mar 2024 20:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-2-21cnbao@gmail.com>
 <01c61b90-df90-4819-978b-414bb717ef64@arm.com> <CAGsJ_4z5xDtBj-nyvPXfgv+ZVmzPQzvptyBrf=kB49Q3=Dmq-Q@mail.gmail.com>
 <e77c18df-2796-4fd1-b589-57f0569587e8@arm.com> <CAGsJ_4zT5YCkSLthCGDe5t3B4dR2syJa_MA3ytZ3YmSCERn_TQ@mail.gmail.com>
 <CAGsJ_4wRNRbdXGV-2LUNNP2Dgi6JZ4fZbC2VGPS4ui8HdvuxnQ@mail.gmail.com>
 <2e9ddc16-b6e7-46d4-8dd7-61977f61f2d0@arm.com> <CAF8kJuNurcw5ufRZ=roNA01xpSNKDhq7dRF91sFQ_KfBNwNPcg@mail.gmail.com>
In-Reply-To: <CAF8kJuNurcw5ufRZ=roNA01xpSNKDhq7dRF91sFQ_KfBNwNPcg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 23 Mar 2024 16:50:31 +1300
Message-ID: <CAGsJ_4xwXdUUCNzmnnTBQvMbFQT4jXrLZyB26QYaUn0HFLzviw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] arm64: mm: swap: support THP_SWAP on hardware
 with MTE
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	Barry Song <v-songbaohua@oppo.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Peter Collingbourne <pcc@google.com>, Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 3:15=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Mar 22, 2024 at 3:19=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > On 22/03/2024 07:41, Barry Song wrote:
> > > On Fri, Mar 22, 2024 at 3:51=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > >>
> > >> On Thu, Mar 21, 2024 at 11:31=E2=80=AFPM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> > >>>
> > >>> On 21/03/2024 08:42, Barry Song wrote:
> > >>>> Hi Ryan,
> > >>>> Sorry for the late reply.
> > >>>
> > >>> No problem!
> > >>>
> > >>>>
> > >>>> On Tue, Mar 12, 2024 at 5:56=E2=80=AFAM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
> > >>>>>
> > >>>>> On 04/03/2024 08:13, Barry Song wrote:
> > >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> > >>>>>>
> > >>>>>> Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings=
 up
> > >>>>>> THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware wit=
h
> > >>>>>> MTE as the MTE code works with the assumption tags save/restore =
is
> > >>>>>> always handling a folio with only one page.
> > >>>>>>
> > >>>>>> The limitation should be removed as more and more ARM64 SoCs hav=
e
> > >>>>>> this feature. Co-existence of MTE and THP_SWAP becomes more and
> > >>>>>> more important.
> > >>>>>>
> > >>>>>> This patch makes MTE tags saving support large folios, then we d=
on't
> > >>>>>> need to split large folios into base pages for swapping out on A=
RM64
> > >>>>>> SoCs with MTE any more.
> > >>>>>>
> > >>>>>> arch_prepare_to_swap() should take folio rather than page as par=
ameter
> > >>>>>> because we support THP swap-out as a whole. It saves tags for al=
l
> > >>>>>> pages in a large folio.
> > >>>>>>
> > >>>>>> As now we are restoring tags based-on folio, in arch_swap_restor=
e(),
> > >>>>>> we may increase some extra loops and early-exitings while refaul=
ting
> > >>>>>> a large folio which is still in swapcache in do_swap_page(). In =
case
> > >>>>>> a large folio has nr pages, do_swap_page() will only set the PTE=
 of
> > >>>>>> the particular page which is causing the page fault.
> > >>>>>> Thus do_swap_page() runs nr times, and each time, arch_swap_rest=
ore()
> > >>>>>> will loop nr times for those subpages in the folio. So right now=
 the
> > >>>>>> algorithmic complexity becomes O(nr^2).
> > >>>>>>
> > >>>>>> Once we support mapping large folios in do_swap_page(), extra lo=
ops
> > >>>>>> and early-exitings will decrease while not being completely remo=
ved
> > >>>>>> as a large folio might get partially tagged in corner cases such=
 as,
> > >>>>>> 1. a large folio in swapcache can be partially unmapped, thus, M=
TE
> > >>>>>> tags for the unmapped pages will be invalidated;
> > >>>>>> 2. users might use mprotect() to set MTEs on a part of a large f=
olio.
> > >>>>>>
> > >>>>>> arch_thp_swp_supported() is dropped since ARM64 MTE was the only=
 one
> > >>>>>> who needed it.
> > >>>
> > >>> I think we should decouple this patch from your swap-in series. I s=
uspect this
> > >>> one could be ready and go in sooner than the swap-in series based o=
n the current
> > >>> discussions :)
> > >>>
> > >>>>>>
> > >>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >>>>>> Cc: Will Deacon <will@kernel.org>
> > >>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
> > >>>>>> Cc: David Hildenbrand <david@redhat.com>
> > >>>>>> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> > >>>>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > >>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > >>>>>> Cc: Peter Collingbourne <pcc@google.com>
> > >>>>>> Cc: Steven Price <steven.price@arm.com>
> > >>>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
> > >>>>>> Cc: Peter Xu <peterx@redhat.com>
> > >>>>>> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > >>>>>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > >>>>>> Cc: Hugh Dickins <hughd@google.com>
> > >>>>>> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > >>>>>> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > >>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > >>>>>> Reviewed-by: Steven Price <steven.price@arm.com>
> > >>>>>> Acked-by: Chris Li <chrisl@kernel.org>
> > >>>>>> ---
> > >>>>>>  arch/arm64/include/asm/pgtable.h | 19 ++------------
> > >>>>>>  arch/arm64/mm/mteswap.c          | 43 +++++++++++++++++++++++++=
+++++++
> > >>>>>>  include/linux/huge_mm.h          | 12 ---------
> > >>>>>>  include/linux/pgtable.h          |  2 +-
> > >>>>>>  mm/page_io.c                     |  2 +-
> > >>>>>>  mm/swap_slots.c                  |  2 +-
> > >>>>>>  6 files changed, 48 insertions(+), 32 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/inclu=
de/asm/pgtable.h
> > >>>>>> index 401087e8a43d..7a54750770b8 100644
> > >>>>>> --- a/arch/arm64/include/asm/pgtable.h
> > >>>>>> +++ b/arch/arm64/include/asm/pgtable.h
> > >>>>>> @@ -45,12 +45,6 @@
> > >>>>>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> > >>>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > >>>>>>
> > >>>>>> -static inline bool arch_thp_swp_supported(void)
> > >>>>>> -{
> > >>>>>> -     return !system_supports_mte();
> > >>>>>> -}
> > >>>>>> -#define arch_thp_swp_supported arch_thp_swp_supported
> > >>>>>> -
> > >>>>>>  /*
> > >>>>>>   * Outside of a few very special situations (e.g. hibernation),=
 we always
> > >>>>>>   * use broadcast TLB invalidation instructions, therefore a spu=
rious page
> > >>>>>> @@ -1095,12 +1089,7 @@ static inline pmd_t pmdp_establish(struct=
 vm_area_struct *vma,
> > >>>>>>  #ifdef CONFIG_ARM64_MTE
> > >>>>>>
> > >>>>>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> > >>>>>> -static inline int arch_prepare_to_swap(struct page *page)
> > >>>>>> -{
> > >>>>>> -     if (system_supports_mte())
> > >>>>>> -             return mte_save_tags(page);
> > >>>>>> -     return 0;
> > >>>>>> -}
> > >>>>>> +extern int arch_prepare_to_swap(struct folio *folio);
> > >>>>>>
> > >>>>>>  #define __HAVE_ARCH_SWAP_INVALIDATE
> > >>>>>>  static inline void arch_swap_invalidate_page(int type, pgoff_t =
offset)
> > >>>>>> @@ -1116,11 +1105,7 @@ static inline void arch_swap_invalidate_a=
rea(int type)
> > >>>>>>  }
> > >>>>>>
> > >>>>>>  #define __HAVE_ARCH_SWAP_RESTORE
> > >>>>>> -static inline void arch_swap_restore(swp_entry_t entry, struct =
folio *folio)
> > >>>>>> -{
> > >>>>>> -     if (system_supports_mte())
> > >>>>>> -             mte_restore_tags(entry, &folio->page);
> > >>>>>> -}
> > >>>>>> +extern void arch_swap_restore(swp_entry_t entry, struct folio *=
folio);
> > >>>>>>
> > >>>>>>  #endif /* CONFIG_ARM64_MTE */
> > >>>>>>
> > >>>>>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > >>>>>> index a31833e3ddc5..295836fef620 100644
> > >>>>>> --- a/arch/arm64/mm/mteswap.c
> > >>>>>> +++ b/arch/arm64/mm/mteswap.c
> > >>>>>> @@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t of=
fset)
> > >>>>>>       mte_free_tag_storage(tags);
> > >>>>>>  }
> > >>>>>>
> > >>>>>> +static inline void __mte_invalidate_tags(struct page *page)
> > >>>>>> +{
> > >>>>>> +     swp_entry_t entry =3D page_swap_entry(page);
> > >>>>>> +
> > >>>>>> +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> > >>>>>> +}
> > >>>>>> +
> > >>>>>>  void mte_invalidate_tags_area(int type)
> > >>>>>>  {
> > >>>>>>       swp_entry_t entry =3D swp_entry(type, 0);
> > >>>>>> @@ -83,3 +90,39 @@ void mte_invalidate_tags_area(int type)
> > >>>>>>       }
> > >>>>>>       xa_unlock(&mte_pages);
> > >>>>>>  }
> > >>>>>> +
> > >>>>>> +int arch_prepare_to_swap(struct folio *folio)
> > >>>>>> +{
> > >>>>>> +     long i, nr;
> > >>>>>> +     int err;
> > >>>>>> +
> > >>>>>> +     if (!system_supports_mte())
> > >>>>>> +             return 0;
> > >>>>>> +
> > >>>>>> +     nr =3D folio_nr_pages(folio);
> > >>>>>> +
> > >>>>>> +     for (i =3D 0; i < nr; i++) {
> > >>>>>> +             err =3D mte_save_tags(folio_page(folio, i));
> > >>>>>> +             if (err)
> > >>>>>> +                     goto out;
> > >>>>>> +     }
> > >>>>>> +     return 0;
> > >>>>>> +
> > >>>>>> +out:
> > >>>>>> +     while (i--)
> > >>>>>> +             __mte_invalidate_tags(folio_page(folio, i));
> > >>>>>> +     return err;
> > >>>>>> +}
> > >>>>>> +
> > >>>>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> > >>>>>
> > >>>>> I'm still not a fan of the fact that entry could be anywhere with=
in folio.
> > >>>>>
> > >>>>>> +{
> > >>>>>> +     if (system_supports_mte()) {
> > >>>>>
> > >>>>> nit: if you do:
> > >>>>>
> > >>>>> if (!system_supports_mte())
> > >>>>>         return;
> > >>>>
> > >>>> Acked
> > >>>>
> > >>>>>
> > >>>>> It will be consistent with arch_prepare_to_swap() and reduce the =
indentation of
> > >>>>> the main body.
> > >>>>>
> > >>>>>> +             long i, nr =3D folio_nr_pages(folio);
> > >>>>>> +
> > >>>>>> +             entry.val -=3D swp_offset(entry) & (nr - 1);
> > >>>>>
> > >>>>> This assumes that folios are always stored in swap with natural a=
lignment. Is
> > >>>>> that definitely a safe assumption? My swap-out series is currentl=
y ensuring that
> > >>>>> folios are swapped-out naturally aligned, but that is an implemen=
tation detail.
> > >>>>>
> > >>>>
> > >>>> I concur that this is an implementation detail. However, we should=
 be
> > >>>> bold enough
> > >>>> to state that swap slots will be contiguous, considering we are
> > >>>> currently utilizing
> > >>>> folio->swap instead of subpage->swap ?
> > >>>
> > >>> Yes, I agree about contiguity. My objection is about assuming natur=
al alignment
> > >>> though. It can still be contiguous while not naturally aligned in s=
wap.
> > >>
> > >> Hi Ryan,
> > >>
> > >> While working on the new version of this patch, I've come to recogni=
ze
> > >> that, for the time being, it's
> > >> imperative to maintain a natural alignment. The following code
> > >> operates on the basis of this
> > >> assumption.
> > >>
> > >> /**
> > >>  * folio_file_page - The page for a particular index.
> > >>  * @folio: The folio which contains this index.
> > >>  * @index: The index we want to look up.
> > >>  *
> > >>  * Sometimes after looking up a folio in the page cache, we need to
> > >>  * obtain the specific page for an index (eg a page fault).
> > >>  *
> > >>  * Return: The page containing the file data for this index.
> > >>  */
> > >> static inline struct page *folio_file_page(struct folio *folio, pgof=
f_t index)
> > >> {
> > >>         return folio_page(folio, index & (folio_nr_pages(folio) - 1)=
);
> > >> }
> > >>
> > >>
> > >> It's invoked everywhere, particularly within do_swap_page(). Nonethe=
less,
> > >> I remain confident that I can consistently pass the first entry to
> > >> arch_swap_restore().
> > >
> > > After grappling for a couple of hours, I've realized that the only
> > > viable approach
> > > is as follows: shifting the task of obtaining the first entry from th=
e
> > > callee to the
> > > callers( looks silly). This is necessary due to various scenarios lik=
e
> > > swap cache,
> > > non-swap cache, and KSM, each presenting different cases. Since there=
's no
> > > assurance of folio->swap being present, forcibly setting folio->swap =
could pose
> > > risks (There might not even be any risk involved, but the associated
> > > task getting
> > > the first entry still cannot be overlooked by callers).
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 7e486f2c502c..94d5b4b5a5da 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -76,6 +76,20 @@ static inline int folio_nr_pages_mapped(struct fol=
io *folio)
> > >         return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MA=
PPED;
> > >  }
> > >
> > > +/*
> > > + * Retrieve the first entry of a folio based on a provided entry wit=
hin the
> > > + * folio. We cannot rely on folio->swap as there is no guarantee tha=
t it has
> > > + * been initialized. Used by arch_swap_restore()
> > > + */
> > > +static inline swp_entry_t folio_swap(swp_entry_t entry, struct folio=
 *folio)
> > > +{
> > > +       swp_entry_t swap =3D {
> > > +               .val =3D entry.val & (folio_nr_pages(folio) - 1),
> > > +       };
> > > +
> > > +       return swap;
> > > +}
> > > +
> > >  static inline void *folio_raw_mapping(struct folio *folio)
> > >  {
> > >         unsigned long mapping =3D (unsigned long)folio->mapping;
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index f2bc6dd15eb8..b7cab8be8632 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4188,7 +4188,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >          * when reading from swap. This metadata may be indexed by sw=
ap entry
> > >          * so this must be called before swap_free().
> > >          */
> > > -       arch_swap_restore(entry, folio);
> > > +       arch_swap_restore(folio_swap(entry, folio), folio);
> > >
> > >         /*
> > >          * Remove the swap entry and conditionally try to free up the=
 swapcache.
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 0aad0d9a621b..82c9df4628f2 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1913,7 +1913,7 @@ static int shmem_swapin_folio(struct inode
> > > *inode, pgoff_t index,
> > >          * Some architectures may have to restore extra metadata to t=
he
> > >          * folio after reading from swap.
> > >          */
> > > -       arch_swap_restore(swap, folio);
> > > +       arch_swap_restore(folio_swap(entry, folio), folio);
> > >
> > >         if (shmem_should_replace_folio(folio, gfp)) {
> > >                 error =3D shmem_replace_folio(&folio, gfp, info, inde=
x);
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 4919423cce76..5e6d2304a2a4 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1806,7 +1806,7 @@ static int unuse_pte(struct vm_area_struct *vma=
,
> > > pmd_t *pmd,
> > >          * when reading from swap. This metadata may be indexed by sw=
ap entry
> > >          * so this must be called before swap_free().
> > >          */
> > > -       arch_swap_restore(entry, folio);
> > > +       arch_swap_restore(folio_swap(entry, folio), folio);
> > >
> > >         dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > >         inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > >
> > >
> > > Meanwhile, natural alignment is essential even during the execution o=
f
> > > add_to_swap(), as failure to
> > > do so will trigger the VM_BUG_ON condition below.
> > >
> > > int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> > >                         gfp_t gfp, void **shadowp)
> > > {
> > >         struct address_space *address_space =3D swap_address_space(en=
try);
> > >         pgoff_t idx =3D swp_offset(entry);
> > >         XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order=
(folio));
> > >         unsigned long i, nr =3D folio_nr_pages(folio);
> > >         ...
> > >         folio_set_swapcache(folio);
> > >         folio->swap =3D entry;
> > >
> > >         do {
> > >                 xas_lock_irq(&xas);
> > >                 xas_create_range(&xas);
> > >                 if (xas_error(&xas))
> > >                         goto unlock;
> > >                 for (i =3D 0; i < nr; i++) {
> > >                         VM_BUG_ON_FOLIO(xas.xa_index !=3D idx + i, fo=
lio);
>
> Here swap_cache assue swap entry + i match folio + i subpage. The swap
> entry of a folio must be continuous. If we want to allow folio write

even more than this. XA_STATE_ORDER ensures that
xas.xa_index is already naturally aligned by having
(index >> order) << order.

#define XA_STATE_ORDER(name, array, index, order)               \
        struct xa_state name =3D __XA_STATE(array,                \
                        (index >> order) << order,              \
                        order - (order % XA_CHUNK_SHIFT),       \
                        (1U << (order % XA_CHUNK_SHIFT)) - 1)


> out to the discontiguous offset of the swap device, this aspect of the
> swap cache will need to change as well. Do you see a problem having
> all pte entries of  a folio point to the same large swap entry? Of
> course, the large swap entry internally will track the offset of sub
> page + i. The swap cache will only have one index for the large swap
> entry (the head entry).

I do see two problems(or difficulties).

1. A specific page table entry (PTE) may not always be aware of its
position. For instance,
the second PTE of a large folio might not identify itself as such,
particularly if the virtual
address of the large folio is not aligned with the size of the large
folio due to operations
like mremap.

2. We also need to consider the complexity arising from partial
unmapping or DONTNEED
operations if we allow all PTEs to reference a 'large' swap entry.
Given that userspace
typically operates at 4KiB granularity, numerous partial unmappings
may be expected
for a single large swap entry.

>
>
> > >                         if (shadowp) {
> > >                                 old =3D xas_load(&xas);
> > >                                 if (xa_is_value(old))
> > >                                         *shadowp =3D old;
> > >                         }
> > >                         xas_store(&xas, folio);
> > >                         xas_next(&xas);
> > >                 }
> > > }
> > >
> > >
> > > Based on the information provided, Ryan, would it be feasible to reta=
in the task
> > > of obtaining the first entry within the callee? Or, are you in favor
> > > of utilizing the
> > > new folio_swap() helper?
> >
> > My opinion still remains that either:
> >
> >  - This should be a per-page interface - i.e. call it for each page to =
restore
> > tags. If we don't want to pass `struct page *` then perhaps we can pass=
 a folio
>
> Can you clarify that by "tag" you mean the MTE tags, not swap cache
> xarray tags, right? From the email context I assume that is the MTE
> tag. Please let me know if I assume incorrectly.
>
> > and the index of the page we want to restore? In this case, entry refer=
s the the
> > precise page we are operating on.
> >
> > OR
> >
> >  - Make it a per-folio interface - i.e. it restores tags for all pages =
in the
> > folio. But in this case, entry must refer to the first page in the foli=
o.
> > Anything else is confusing.
>
> As long as you refer to the subpage as folilo + i, restoring a subset
> of the folio should be permitted?

That was my approach in those older versions -  passing subpage
rather than folio.

In recent versions, we've transitioned to always restoring a folio during
swap operations. While this approach is acceptable, it can lead to some
redundant idle loops. For instance, if we swap out a large folio with
nr_pages and subsequently encounter a refault while the folio is still
in the swapcache, the first do_swap_page() call will restore all tags.
Subsequent do_swap_page() calls for the remaining nr_pages-1 PTEs
will perform the same checks, realizing that the restoration has already
been completed and thus skipping the process. However, they still
redundantly execute checks.

I propose extracting a separate patch from "[RFC PATCH v3 5/5] mm:
support large folios swapin as a whole" specifically to handle refaults.
This patch would essentially remove these redundant loops. The
swap-in patch currently addresses both refaults and newly allocated
large folios. If we prioritize addressing refaults sooner, I believe
this extraction would be beneficial.


>
> On the swap entry side, I would like to avoid assuming the swap entry
> is contingues. The swap entry should have an API to fetch the swap
> offset of the head entry + i. For the simple continuous swap entry,
> this mapping is just linear. For non continuous swap offset, it would
> need to go through some lookup table to find the offset for i.

The implementation of this approach necessitates a significant overhaul
of existing infrastructure. Currently, the entire codebase operates under
the assumption of contiguous and naturally aligned swap entries. As such,
adapting the system to support non-contiguous or non-naturally aligned
swap entries will require substantial modifications across various
components.

>
> Chris
>
> >
> > So if going for the latter approach, then I vote for fixing it up in th=
e callee.
> > But I'm just one guy with one opinion!
> >
> >
> > >
> > >>
> > >>>
> > >>>>
> > >>>>> Your cover note for swap-in says that you could technically swap =
in a large
> > >>>>> folio without it having been swapped-out large. If you chose to d=
o that in
> > >>>>> future, this would break, right? I don't think it's good to coupl=
e the swap
> > >>>>
> > >>>> Right. technically I agree. Given that we still have many tasks in=
volving even
> > >>>> swapping in contiguous swap slots, it's unlikely that swapping in =
large folios
> > >>>> for non-contiguous entries will occur in the foreseeable future :-=
)
> > >>>>
> > >>>>> storage layout to the folio order that you want to swap into. Per=
haps that's an
> > >>>>> argument for passing each *page* to this function with its exact,=
 corresponding
> > >>>>> swap entry?
> > >>>>
> > >>>> I recall Matthew Wilcox strongly objected to using "page" as the
> > >>>> parameter, so I've
> > >>>> discarded that approach. Alternatively, it appears I can consisten=
tly pass
> > >>>> folio->swap to this function and ensure the function always retrie=
ves
> > >>>> the first entry?
> > >>>
> > >>> Yes, if we must pass a folio here, I'd prefer that entry always cor=
responds to
> > >>> the first entry for the folio. That will remove the need for this f=
unction to do
> > >>> the alignment above too. So win-win.
> > >>>
> > >>>>
> > >>>>>
> > >>>>>> +             for (i =3D 0; i < nr; i++) {
> > >>>>>> +                     mte_restore_tags(entry, folio_page(folio, =
i));
> > >>>>>> +                     entry.val++;
> > >>>>>> +             }
> > >>>>>> +     }
> > >>>>>> +}
> > >>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > >>>>>> index de0c89105076..e04b93c43965 100644
> > >>>>>> --- a/include/linux/huge_mm.h
> > >>>>>> +++ b/include/linux/huge_mm.h
> > >>>>>> @@ -535,16 +535,4 @@ static inline int split_folio_to_order(stru=
ct folio *folio, int new_order)
> > >>>>>>  #define split_folio_to_list(f, l) split_folio_to_list_to_order(=
f, l, 0)
> > >>>>>>  #define split_folio(f) split_folio_to_order(f, 0)
> > >>>>>>
> > >>>>>> -/*
> > >>>>>> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_=
SWP due to
> > >>>>>> - * limitations in the implementation like arm64 MTE can overrid=
e this to
> > >>>>>> - * false
> > >>>>>> - */
> > >>>>>> -#ifndef arch_thp_swp_supported
> > >>>>>> -static inline bool arch_thp_swp_supported(void)
> > >>>>>> -{
> > >>>>>> -     return true;
> > >>>>>> -}
> > >>>>>> -#endif
> > >>>>>> -
> > >>>>>>  #endif /* _LINUX_HUGE_MM_H */
> > >>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > >>>>>> index e1b22903f709..bfcfe3386934 100644
> > >>>>>> --- a/include/linux/pgtable.h
> > >>>>>> +++ b/include/linux/pgtable.h
> > >>>>>> @@ -1106,7 +1106,7 @@ static inline int arch_unmap_one(struct mm=
_struct *mm,
> > >>>>>>   * prototypes must be defined in the arch-specific asm/pgtable.=
h file.
> > >>>>>>   */
> > >>>>>>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> > >>>>>> -static inline int arch_prepare_to_swap(struct page *page)
> > >>>>>> +static inline int arch_prepare_to_swap(struct folio *folio)
> > >>>>>>  {
> > >>>>>>       return 0;
> > >>>>>>  }
> > >>>>>> diff --git a/mm/page_io.c b/mm/page_io.c
> > >>>>>> index ae2b49055e43..a9a7c236aecc 100644
> > >>>>>> --- a/mm/page_io.c
> > >>>>>> +++ b/mm/page_io.c
> > >>>>>> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct=
 writeback_control *wbc)
> > >>>>>>        * Arch code may have to preserve more data than just the =
page
> > >>>>>>        * contents, e.g. memory tags.
> > >>>>>>        */
> > >>>>>> -     ret =3D arch_prepare_to_swap(&folio->page);
> > >>>>>> +     ret =3D arch_prepare_to_swap(folio);
> > >>>>>>       if (ret) {
> > >>>>>>               folio_mark_dirty(folio);
> > >>>>>>               folio_unlock(folio);
> > >>>>>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > >>>>>> index 90973ce7881d..53abeaf1371d 100644
> > >>>>>> --- a/mm/swap_slots.c
> > >>>>>> +++ b/mm/swap_slots.c
> > >>>>>> @@ -310,7 +310,7 @@ swp_entry_t folio_alloc_swap(struct folio *f=
olio)
> > >>>>>>       entry.val =3D 0;
> > >>>>>>
> > >>>>>>       if (folio_test_large(folio)) {
> > >>>>>> -             if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_su=
pported())
> > >>>>>> +             if (IS_ENABLED(CONFIG_THP_SWAP))
> > >>>>>>                       get_swap_pages(1, &entry, folio_nr_pages(f=
olio));
> > >>>>>>               goto out;
> > >>>>>>       }
> > >>>>>
> > >>>>
> > >>>> Thanks
> > >>>> Barry

Thanks
Barry

