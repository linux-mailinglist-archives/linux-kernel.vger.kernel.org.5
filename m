Return-Path: <linux-kernel+bounces-143303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B108A36FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391B21F21279
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751241514D0;
	Fri, 12 Apr 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgmcSj0U"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226714F9C6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953292; cv=none; b=vGH4aHtHx4FuZl7buUJy+2Ptdz+3PHhZFexCWSnPol5PUNIuqfLqB8e7sCYwMgNfm6j32qdvXthdC6yIYPyMGus6YU3tUIEIcEaavCNXu9srLzSLvF8bsVCIh8VWz2XD73RkPs4ERk7+t/G6z8QfklVlxxK85dYL4WIsdi5VZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953292; c=relaxed/simple;
	bh=ksOkMC8e4lDDmMMLQmoxoShjZa1mhZeFYfA/fHRR5ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvwLV/XEzsjMQ7+Ffby+Fd/8aFu2jIq270wCDYzdZCaMOoYN9HLvHkVQqQiMcHP7h1fuWDWwOWgHMporuNd3IdsaTKxUOoOXRaulOF1paYRrzdRNvVr9/gkntMMtyqz7gRy/uXkBuwnwhJ18zglQC7J4fu2mG6uIgNqeetJX6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgmcSj0U; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51b008b3aeso151610766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712953289; x=1713558089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGFW6CnMszNqSWAsUr3yiNIPdWw7VUWE85giIQlsZvc=;
        b=cgmcSj0UZ2NgvDJ/gq1ixSoS/co/uvU1DmfnwL0eEdeLxtBmglZ6B65wlyK9DUOVTH
         vi8OgNF+zPs5cH48pYxWriNyv7aFxKipM5PKx7vC4EdtajHPGFh5djTMsJ2Iq7M0nLrE
         h7eQRH15IK0vBKzgieXRwCpxbmPL7p3A4X1yvXp9m74W/VRLoMyqZDjiRICIVIorqZKL
         yzqf3Vc5adsReAWvLzCTwmrSwIjDMvRq92Qt44kjR6e9aBOEY5EChs5Myjnq6cdajOQX
         C5FoWRMmlrUmdMv22XROC7O8HpOw6N0jkogQv1OxN/xcySFIzJq2iGjcpK186bOCgg2E
         bOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712953289; x=1713558089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGFW6CnMszNqSWAsUr3yiNIPdWw7VUWE85giIQlsZvc=;
        b=iGoZZwiEYXsUGf9VAEHg33pQfVYpGSjNgSzunvs15fSGm37uyUPZ4YwmaGrmupevj7
         m1j2Xuf3y1i2345/TUtMkVGU8ZcX0XiNHA/LOY/MuoNKDkgz7I925U8c9v1UBzCC1x2l
         h6aJZwILhyUV/HFfMzLIq+TtUL/Qqj67T5S6iodrB8yIfcSuNsxCanLsJXH8z8rcEzYs
         EQydqatzXOPh5LHGCT9/eexRrbmxF1Ri/U5sEwvwO2Smha/icekVWno/PJJZ6mmoMcKI
         T89w/8JsFGyziyGHfbNlSzAoPPABJiLHdDmvo2t24X66R1h0h1Ld89DfpzwSU8Bz0mk3
         NxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkCy04AmoeYmnaA0TekrE1sP7ZEhww5W+WraRpCKGBWtMCWkRXmNwBaIOAGR0xXYYdLoTlE+wMoFrjxn8Y62Vkuisowvwx63DDyPYg
X-Gm-Message-State: AOJu0YwNztI15DLEkQY+e2y2o1HCmLlitw8bGhpz25Z/pXDQmccRVlY5
	26rYPv4KPjERfH7ZdIcOv9ekslQqn6YHfvnZo2DOk7RSzEmgf7bmmLTAbg3lEFx8hm7rchPQ5Jq
	amHcJhviWqnVT/oG8nmeSx37c8L0=
X-Google-Smtp-Source: AGHT+IGRIEDvMAPDilSJiq3VU+yXpUrLZRTHOVb1pA2EQjbD3GZ71V+gTDELD+eURh0H50rE8g5cX4Zi5PXxM/1rEEc=
X-Received: by 2002:a17:906:dc8f:b0:a51:af7d:4652 with SMTP id
 cs15-20020a170906dc8f00b00a51af7d4652mr3603557ejc.32.1712953288499; Fri, 12
 Apr 2024 13:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com>
 <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com> <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
 <0A4D2CA1-E156-43E9-A1C9-E09E62E760A3@nvidia.com> <A06608B4-9187-42DD-B9A2-CBBC3D5C9312@nvidia.com>
 <CAHbLzkoxXDwV8H_G2wSPNd3=pCtY-H-A20nBp-fxYNO_RVUTwQ@mail.gmail.com> <9e4516d9-b861-4501-84d3-31f5e8e5dfef@redhat.com>
In-Reply-To: <9e4516d9-b861-4501-84d3-31f5e8e5dfef@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 12 Apr 2024 13:21:17 -0700
Message-ID: <CAHbLzkrwkv5YM2yk_iL_W9ffgYfHkBGug_o=B0n=ocBn4MZsew@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:36=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.04.24 20:29, Yang Shi wrote:
> > On Fri, Apr 12, 2024 at 7:31=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 12 Apr 2024, at 10:21, Zi Yan wrote:
> >>
> >>> On 11 Apr 2024, at 17:59, Yang Shi wrote:
> >>>
> >>>> On Thu, Apr 11, 2024 at 2:15=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 11.04.24 21:01, Yang Shi wrote:
> >>>>>> On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM David Hildenbrand <david@r=
edhat.com> wrote:
> >>>>>>>
> >>>>>>> On 11.04.24 17:32, Zi Yan wrote:
> >>>>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>>>
> >>>>>>>> In __folio_remove_rmap(), a large folio is added to deferred spl=
it list
> >>>>>>>> if any page in a folio loses its final mapping. It is possible t=
hat
> >>>>>>>> the folio is unmapped fully, but it is unnecessary to add the fo=
lio
> >>>>>>>> to deferred split list at all. Fix it by checking folio mapcount=
 before
> >>>>>>>> adding a folio to deferred split list.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>     mm/rmap.c | 9 ++++++---
> >>>>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>>>> index 2608c40dffad..d599a772e282 100644
> >>>>>>>> --- a/mm/rmap.c
> >>>>>>>> +++ b/mm/rmap.c
> >>>>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove=
_rmap(struct folio *folio,
> >>>>>>>>                 enum rmap_level level)
> >>>>>>>>     {
> >>>>>>>>         atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>>>>>>> -     int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>>>>>>> +     int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>>>>>>         enum node_stat_item idx;
> >>>>>>>>
> >>>>>>>>         __folio_rmap_sanity_checks(folio, page, nr_pages, level)=
;
> >>>>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove=
_rmap(struct folio *folio,
> >>>>>>>>                         break;
> >>>>>>>>                 }
> >>>>>>>>
> >>>>>>>> -             atomic_sub(nr_pages, &folio->_large_mapcount);
> >>>>>>>> +             mapcount =3D atomic_sub_return(nr_pages,
> >>>>>>>> +                                          &folio->_large_mapcou=
nt) + 1;
> >>>>>>>
> >>>>>>> That becomes a new memory barrier on some archs. Rather just re-r=
ead it
> >>>>>>> below. Re-reading should be fine here.
> >>>>>>>
> >>>>>>>>                 do {
> >>>>>>>>                         last =3D atomic_add_negative(-1, &page->=
_mapcount);
> >>>>>>>>                         if (last) {
> >>>>>>>> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove=
_rmap(struct folio *folio,
> >>>>>>>>                  * is still mapped.
> >>>>>>>>                  */
> >>>>>>>>                 if (folio_test_large(folio) && folio_test_anon(f=
olio))
> >>>>>>>> -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr=
_pmdmapped)
> >>>>>>>> +                     if ((level =3D=3D RMAP_LEVEL_PTE &&
> >>>>>>>> +                          mapcount !=3D 0) ||
> >>>>>>>> +                         (level =3D=3D RMAP_LEVEL_PMD && nr < n=
r_pmdmapped))
> >>>>>>>>                                 deferred_split_folio(folio);
> >>>>>>>>         }
> >>>>>>>
> >>>>>>> But I do wonder if we really care? Usually the folio will simply =
get
> >>>>>>> freed afterwards, where we simply remove it from the list.
> >>>>>>>
> >>>>>>> If it's pinned, we won't be able to free or reclaim, but it's rat=
her a
> >>>>>>> corner case ...
> >>>>>>>
> >>>>>>> Is it really worth the added code? Not convinced.
> >>>>>>
> >>>>>> It is actually not only an optimization, but also fixed the broken
> >>>>>> thp_deferred_split_page counter in /proc/vmstat.
> >>>>>>
> >>>>>> The counter actually counted the partially unmapped huge pages (so
> >>>>>> they are on deferred split queue), but it counts the fully unmappe=
d
> >>>>>> mTHP as well now. For example, when a 64K THP is fully unmapped, t=
he
> >>>>>> thp_deferred_split_page is not supposed to get inc'ed, but it does
> >>>>>> now.
> >>>>>>
> >>>>>> The counter is also useful for performance analysis, for example,
> >>>>>> whether a workload did a lot of partial unmap or not. So fixing th=
e
> >>>>>> counter seems worthy. Zi Yan should have mentioned this in the com=
mit
> >>>>>> log.
> >>>>>
> >>>>> Yes, all that is information that is missing from the patch descrip=
tion.
> >>>>> If it's a fix, there should be a "Fixes:".
> >>>>>
> >>>>> Likely we want to have a folio_large_mapcount() check in the code b=
elow.
> >>>>> (I yet have to digest the condition where this happens -- can we ha=
ve an
> >>>>> example where we'd use to do the wrong thing and now would do the r=
ight
> >>>>> thing as well?)
> >>>>
> >>>> For example, map 1G memory with 64K mTHP, then unmap the whole 1G or
> >>>> some full 64K areas, you will see thp_deferred_split_page increased,
> >>>> but it shouldn't.
> >>>>
> >>>> It looks __folio_remove_rmap() incorrectly detected whether the mTHP
> >>>> is fully unmapped or partially unmapped by comparing the number of
> >>>> still-mapped subpages to ENTIRELY_MAPPED, which should just work for
> >>>> PMD-mappable THP.
> >>>>
> >>>> However I just realized this problem was kind of workaround'ed by co=
mmit:
> >>>>
> >>>> commit 98046944a1597f3a02b792dbe9665e9943b77f28
> >>>> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> Date:   Fri Mar 29 14:59:33 2024 +0800
> >>>>
> >>>>      mm: huge_memory: add the missing folio_test_pmd_mappable() for =
THP
> >>>> split statistics
> >>>>
> >>>>      Now the mTHP can also be split or added into the deferred list,=
 so add
> >>>>      folio_test_pmd_mappable() validation for PMD mapped THP, to avo=
id
> >>>>      confusion with PMD mapped THP related statistics.
> >>>>
> >>>>      Link: https://lkml.kernel.org/r/a5341defeef27c9ac7b85c97f030f93=
e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com
> >>>>      Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>>      Acked-by: David Hildenbrand <david@redhat.com>
> >>>>      Cc: Muchun Song <muchun.song@linux.dev>
> >>>>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>>>
> >>>> This commit made thp_deferred_split_page didn't count mTHP anymore, =
it
> >>>> also made thp_split_page didn't count mTHP anymore.
> >>>>
> >>>> However Zi Yan's patch does make the code more robust and we don't
> >>>> need to worry about the miscounting issue anymore if we will add
> >>>> deferred_split_page and split_page counters for mTHP in the future.
> >>>
> >>> Actually, the patch above does not fix everything. A fully unmapped
> >>> PTE-mapped order-9 THP is also added to deferred split list and
> >>> counted as THP_DEFERRED_SPLIT_PAGE without my patch, since nr is 512
> >>> (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio(=
)
> >>> the order-9 folio is folio_test_pmd_mappable().
> >>>
> >>> I will add this information in the next version.
> >>
> >> It might
> >> Fixes: b06dc281aa99 ("mm/rmap: introduce folio_remove_rmap_[pte|ptes|p=
md]()"),
> >> but before this commit fully unmapping a PTE-mapped order-9 THP still =
increased
> >> THP_DEFERRED_SPLIT_PAGE, because PTEs are unmapped individually and fi=
rst PTE
> >> unmapping adds the THP into the deferred split list. This means commit=
 b06dc281aa99
> >> did not change anything and before that THP_DEFERRED_SPLIT_PAGE increa=
se is
> >> due to implementation. I will add this to the commit log as well witho=
ut Fixes
> >> tag.
> >
> > Thanks for digging deeper. The problem may be not that obvious before
> > mTHP because PMD-mappable THP is converted to PTE-mapped due to
> > partial unmap in most cases. But mTHP is always PTE-mapped in the
> > first place. The other reason is batched rmap remove was not supported
> > before David's optimization.
>
> Yes.
>
> >
> > Now we do have reasonable motivation to make it precise and it is also
> > easier to do so than before.
>
> If by "precise" you mean "less unreliable in some cases", yes. See my
> other mail.

Yes, definitely. Make the unreliability somehow acceptable.

>
> --
> Cheers,
>
> David / dhildenb
>

