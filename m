Return-Path: <linux-kernel+bounces-145679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA318A596C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75FF1F22C13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF8137757;
	Mon, 15 Apr 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFAKTbzn"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769851E877
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203694; cv=none; b=JFAe8IvMcSMYhZ3fqrXyoKlaf/v+dgf4/74jDIaXWBuJcbLMKZZ0CmGohOggS3mFDzpDvD9tervHw150rIFYAJkbq8PQg/25J+lnXSQ4vbc91XMPzblWUqINJdB4icnbCU7Qo22RDqTSfs09v/B2y373CgjzJQ6iv77I7p/odIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203694; c=relaxed/simple;
	bh=bLPvMGBz6/NjmL2c52lMxC/NOmxKQ2zboTI9+GkeZi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9K4gK3JpUw/XDueaczYYdAPsJnRojRThmVR+oFFBY0uA4raenmWiVL+EVnNJYTlia8Fd4wa5JGnFpmfnw/soXFwcoEgF40xMJmmN6GSiMc1gXQR9lAhPY6FF7y01bV/DLyTJb1BAfw1NBog03N92hgbo/go8RrBi8/6bT+STC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFAKTbzn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so4347728e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713203690; x=1713808490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5yI4YGbKBikU8AcE9UGGcfp9pwh4H8/pFo+VhmnALw=;
        b=EFAKTbznG+YIKj+rvo6Rv/99VzcWeEkgNJX9FaTsZIfEhKmcFcrV4NJzKfSFXvz/eB
         KjtVLYU8nowOOoTEUp5oI1/nCtmMTXyrsTppu5XTGMWokFTQ88FOf5Od5jxlwTmL+13J
         GmOOwDvTI8/IZesKMBUasu4/PdmCV1smWO4g1XXd/kYaz8JoeNrgddlHIEFg/XhOX635
         1WhJ5PS1YgbbBTw7MqvdCvgof/8cR9HC/AVRH2Dlr+ZBVkBSVPBMBanTkBJr/4X11L1z
         zBEWCi7FszQrNGQkz53Bd9tR4gxDFBXEqp86/tPPMXWhuyLodaTFIbxGwO/saHzLxT0s
         woMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713203690; x=1713808490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5yI4YGbKBikU8AcE9UGGcfp9pwh4H8/pFo+VhmnALw=;
        b=R9M96CCRZC8roPm6m2ZZNpJxiUCe7tsqpCbjVJFtmJicDG3aduf/XWFx31eRFLiSzY
         HhrHbrjOOxsXskoAT5d04QQOgZuwbleMGdOm35PXllmdv6ozhDoyozVuqXZ8aqvUCXlp
         vRcJ+RLck82scnO5nriA8Zu63qaOZiU25jCdJS4HFuf4/2pNYJHn2wcv3fTJYX4CXs14
         05g2BcNhs5FxBxu6IdN9Ymm5aS5XX3z71GgqgExBYq04rjydOfdB1HwkBQhzB+H93WUl
         g7J6LQkXINGdeUFdd2ZTbvA9hU1xMiN75gnJ/03eeQ8Sj1LxgSEGCFVs8ysdS3dNQUej
         WIEw==
X-Forwarded-Encrypted: i=1; AJvYcCUAB0DOgWIQWod1JTP5G2TUB57X6NAZCYBc/U/NXs5J1m88cK6Dd1vY8eWAKt6quuh0IvFJJRqw5y0+xbQ1CXI653clxqEH+05x5s+5
X-Gm-Message-State: AOJu0Yz1vWdqeE9sQdJ1DweWrVYMAsaxQ3iy3Mr/hBlQ2n/MJUCNGp3r
	LzRMv/y0Qc41T107mQKmk3xp+L0sMSS/7M7Hf/ozlPfGS9JgTIysR1TFz5N27B98QcqMopVyfhf
	O4x9DiE3Fej74GvYAt5WB8cXrSb0=
X-Google-Smtp-Source: AGHT+IFnySQ7OQBwXRANZblJ5BSLCbR+oIRObEDkGHfVRnB9X/PiogR7rMPhTtVWXYXLGE39Qj4dY8it4GcT/uw7PdA=
X-Received: by 2002:a05:6512:401b:b0:516:9e97:d3ee with SMTP id
 br27-20020a056512401b00b005169e97d3eemr8377040lfb.53.1713203690360; Mon, 15
 Apr 2024 10:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com> <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com> <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
 <60049ec1-df14-4c3f-b3dd-5d771c2ceac4@redhat.com>
In-Reply-To: <60049ec1-df14-4c3f-b3dd-5d771c2ceac4@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 15 Apr 2024 10:54:38 -0700
Message-ID: <CAHbLzkpMjSUpB2gsYH+4kkEtPuyS4bP7ord+nSgR9xcp3fyVFQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:40=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.04.24 00:29, Yang Shi wrote:
> > On Fri, Apr 12, 2024 at 2:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 12 Apr 2024, at 15:32, David Hildenbrand wrote:
> >>
> >>> On 12.04.24 16:35, Zi Yan wrote:
> >>>> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
> >>>>
> >>>>> On 11.04.24 17:32, Zi Yan wrote:
> >>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>
> >>>>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
> >>>>>> if any page in a folio loses its final mapping. It is possible tha=
t
> >>>>>> the folio is unmapped fully, but it is unnecessary to add the foli=
o
> >>>>>> to deferred split list at all. Fix it by checking folio mapcount b=
efore
> >>>>>> adding a folio to deferred split list.
> >>>>>>
> >>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>> ---
> >>>>>>     mm/rmap.c | 9 ++++++---
> >>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>> index 2608c40dffad..d599a772e282 100644
> >>>>>> --- a/mm/rmap.c
> >>>>>> +++ b/mm/rmap.c
> >>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                     enum rmap_level level)
> >>>>>>     {
> >>>>>>             atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>>>>> -  int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>>>>> +  int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>>>>             enum node_stat_item idx;
> >>>>>>             __folio_rmap_sanity_checks(folio, page, nr_pages, leve=
l);
> >>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                             break;
> >>>>>>                     }
> >>>>>>    -                atomic_sub(nr_pages, &folio->_large_mapcount);
> >>>>>> +          mapcount =3D atomic_sub_return(nr_pages,
> >>>>>> +                                       &folio->_large_mapcount) +=
 1;
> >>>>>
> >>>>> That becomes a new memory barrier on some archs. Rather just re-rea=
d it below. Re-reading should be fine here.
> >>>>
> >>>> Would atomic_sub_return_relaxed() work? Originally I was using atomi=
c_read(mapped)
> >>>> below, but to save an atomic op, I chose to read mapcount here.
> >>>
> >>> Some points:
> >>>
> >>> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
> >>> RMW that return a value -- and how they interact with memory barriers=
.
> >>> Further, how relaxed variants are only optimized on some architecture=
s.
> >>>
> >>> atomic_read() is usually READ_ONCE(), which is just an "ordinary" mem=
ory
> >>> access that should not be refetched. Usually cheaper than most other =
stuff
> >>> that involves atomics.
> >>
> >> I should have checked the actual implementation instead of being foole=
d
> >> by the name. Will read about it. Thanks.
> >>
> >>>
> >>> (2) We can either use folio_large_mapcount() =3D=3D 0 or !atomic_read=
(mapped)
> >>> to figure out if the folio is now completely unmapped.
> >>>
> >>> (3) There is one fundamental issue: if we are not batch-unmapping the=
 whole
> >>> thing, we will still add the folios to the deferred split queue. Migr=
ation
> >>> would still do that, or if there are multiple VMAs covering a folio.
> >>>
> >>> (4) We should really avoid making common operations slower only to ma=
ke
> >>> some unreliable stats less unreliable.
> >>>
> >>>
> >>> We should likely do something like the following, which might even be=
 a bit
> >>> faster in some cases because we avoid a function call in case we unma=
p
> >>> individual PTEs by checking _deferred_list ahead of time
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 2608c40dffad..356598b3dc3c 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
> >>>                   * page of the folio is unmapped and at least one pa=
ge
> >>>                   * is still mapped.
> >>>                   */
> >>> -               if (folio_test_large(folio) && folio_test_anon(folio)=
)
> >>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pm=
dmapped)
> >>> -                               deferred_split_folio(folio);
> >>> +               if (folio_test_large(folio) && folio_test_anon(folio)=
 &&
> >>> +                   (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped=
) &&
> >>> +                   atomic_read(mapped) &&
> >>> +                   data_race(list_empty(&folio->_deferred_list)))
> >>
> >> data_race() might not be needed, as Ryan pointed out[1]
> >>
> >>> +                       deferred_split_folio(folio);
> >>>          }
> >>>
> >>> I also thought about handling the scenario where we unmap the whole
> >>> think in smaller chunks. We could detect "!atomic_read(mapped)" and
> >>> detect that it is on the deferred split list, and simply remove it
> >>> from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
> >>>
> >>> But it would be racy with concurrent remapping of the folio (might ha=
ppen with
> >>> anon folios in corner cases I guess).
> >>>
> >>> What we can do is the following, though:
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index dc30139590e6..f05cba1807f2 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *f=
olio)
> >>>          ds_queue =3D get_deferred_split_queue(folio);
> >>>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >>>          if (!list_empty(&folio->_deferred_list)) {
> >>> +               if (folio_test_pmd_mappable(folio))
> >>> +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
> >>>                  ds_queue->split_queue_len--;
> >>>                  list_del_init(&folio->_deferred_list);
> >>>          }
> >>>
> >>> Adding the right event of course.
> >>>
> >>>
> >>> Then it's easy to filter out these "temporarily added to the list, bu=
t never split
> >>> before the folio was freed" cases.
> >>
> >> So instead of making THP_DEFERRED_SPLIT_PAGE precise, use
> >> THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE instead? That s=
hould work.
> >
> > It is definitely possible that the THP on the deferred split queue are
> > freed instead of split. For example, 1M is unmapped for a 2M THP, then
> > later the remaining 1M is unmapped, or the process exits before memory
> > pressure happens. So how come we can tell it is "temporarily added to
> > list"? Then THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE
> > actually just counts how many pages are still on deferred split queue.
>
> Not quite I think. I don't think we have a counter that counts how many
> large folios on the deferred list were split. I think we only have
> THP_SPLIT_PAGE.

Yes, we just count how many THP were split regardless of why they got
split. They may be split from a deferred split queue due to memory
pressure, migration, etc.

>
> We could have
> * THP_DEFERRED_SPLIT_PAGE
> * THP_UNDO_DEFERRED_SPLIT_PAGE
> * THP_PERFORM_DEFERRED_SPLIT_PAGE
>
> Maybe that would catch more cases (not sure if all, though). Then, you
> could tell how many are still on that list. THP_DEFERRED_SPLIT_PAGE -
> THP_UNDO_DEFERRED_SPLIT_PAGE - THP_PERFORM_DEFERRED_SPLIT_PAGE.
>
> That could give one a clearer picture how deferred split interacts with
> actual splitting (possibly under memory pressure), the whole reason why
> deferred splitting was added after all.

I'm not quite sure whether there is a solid usecase or not. If we
have, we could consider this. But a simpler counter may be more
preferred.

>
> > It may be useful. However the counter is typically used to estimate
> > how many THP are partially unmapped during a period of time.
>
> I'd say it's a bit of an abuse of that counter; well, or interpreting
> something into the counter that that counter never reliably represented.

It was way more reliable than now.

>
> I can easily write a program that keeps sending your counter to infinity
> simply by triggering that behavior in a loop, so it's all a bit shaky.

I don't doubt that. But let's get back to reality. The counter used to
stay reasonable and reliable with most real life workloads before
mTHP. There may be over-counting, for example, when unmapping a
PTE-mapped THP which was not on a deferred split queue before. But
such a case is not common for real life workloads because the huge PMD
has to be split by partial unmap for most cases. And the partial unmap
will add the THP to deferred split queue.

But now a common workload, for example, just process exit, may
probably send the counter to infinity.

>
> Something like Ryans script makes more sense, where you get a clearer
> picture of what's mapped where and how. Because that information can be
> much more valuable than just knowing if it's mapped fully or partially
> (again, relevant for handling with memory waste).

Ryan's script is very helpful. But the counter has been existing and
used for years, and it is a quick indicator and much easier to monitor
in a large-scale fleet.

If we think the reliability of the counter is not worth fixing, why
don't we just remove it. No counter is better than a broken counter.

>
> --
> Cheers,
>
> David / dhildenb
>

