Return-Path: <linux-kernel+bounces-101267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C287A4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75756B20AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308691D6A5;
	Wed, 13 Mar 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUlQgh5x"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF41BDD9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321582; cv=none; b=O1ORftvPQ2gjR8BWkRcBO1REPRNp41/pUQDo3h8AiJatGd1mRL0J8kTPVbm8TNNvJ8YL//gsRYWmxNCljAvWglCs9n8+3+qIBSs63zC96NTvnlxigseYUET4IUIi/5xPLZC4mZFApsRtSJ3uzJQQ1y7Q5RS2LNeqeAR7v8mBdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321582; c=relaxed/simple;
	bh=wNiRmL0ww3AYFM6+GJeSpkFDamnDnX6fnMdH3sqe20c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz3p177HDp15r1vTEQylEN5GGQjEIGFZ2YzGn5thPaUhhr2ASOcykNOKYW2mRr/BxDvKZUk3+h5u/UWt3Zlu/aL2JAOUP5k2mtwuefoOvgvDB3LrucSI3X3XOMN3eM/4JNLx1jzCNaKX0SJRpAtBKJTlxyk3BwcBcC2Nb+VWcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUlQgh5x; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f359b7b1so69540507b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710321579; x=1710926379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byrgibNpCPgvs0VjxR8ixo3YcvPfmoIHBrOfCYQ1v7w=;
        b=bUlQgh5xCTNSlh3dLCx1wceJN+rvRhEfOShz7EATtqu1DYfYVgswaxFhImWbb4oNnS
         3Ap/yCpQMMM1aL9FbqHKrVkjhA6iXF1pKSVlW82mlR8dzq9x0ph7oUq63gkyS5kjmgxT
         w+nSbmtrCUbARjle7Ixql9KZnEIRJhyams4InrC3ifzo5//4tWkhqS9ahzOVzJQlk8sw
         xcmFj3pJoooUjSym0T1vb4RRmGfSFEz1SB5XRxuNjuFhkTObrvBCnkFcrwtp6CLrwZ7t
         XuS0XN7I7RFo4KT1BAFHXpMjOM+rGLN26KFlEcOm/hBkktBvPC8fajTDRKyXNgnj3Vdp
         LD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321579; x=1710926379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byrgibNpCPgvs0VjxR8ixo3YcvPfmoIHBrOfCYQ1v7w=;
        b=g0Mo4Brs4lqPlIksN4y2OpdlIcVZhrDEcbWFZxvOW51tQHH8MaYDdLKsQ2d5pD0ILq
         u1iTmtXjjawbCPqj3BvZayhlLSKfSAqPO4TbnLQiwZyiSv6zrIvqXcHp33TH10T+ai9D
         F+aVV9Qy5hZYu9uXvUctuRvt04tWihLnRmIW1hcCoBnEv9RHOt8lJrKiJC4nDyOpSL7x
         43HqHH7js7Sh2gx++1etu0gpKNNRAkbI6azbkdbc/h/SknZKQXDJNIOHy9utHKh3ywcF
         wTU2f1bCEkuX1zSN/iUhfzER/RYYjgM93ri7jaG89M3qJgzc4Hi9aSIU1yavdiMzs0Yc
         6CbA==
X-Forwarded-Encrypted: i=1; AJvYcCWGE469dJadbeyWUhR/IMrm9cQjNUD8XjialKbLahBHxn1E/aJocNxvVr41WMTTYnQca0wwmypHs+97ZEoBcU10xyYTN7weNMOWPmev
X-Gm-Message-State: AOJu0YxNwU5DX5AbRUv8uhZDaGp4LbyV2HLyxN75hMTHDbY9Tca18wb5
	L0ZZIBMuqmZ/sEGOdgAb34yyMJifW5k7wHwDM4zZk87zIlfc3rTuxbscP0T2Qh08Ji7EGeDoi2t
	KzTJkQ3Tj5SIq2C4jNJYZ5PBZ8cNUt4LGL28e6Vk3
X-Google-Smtp-Source: AGHT+IHoC7z1DfEvHDZgGApKmQBizeiAz+vhVlh1IGEGjHTO8li7DuWkTIapgNV4fRB6spOiUCyAq9xpeyEsXA+3N/c=
X-Received: by 2002:a81:690b:0:b0:60a:4a:a668 with SMTP id e11-20020a81690b000000b0060a004aa668mr2015733ywc.27.1710321579292;
 Wed, 13 Mar 2024 02:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com>
In-Reply-To: <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 13 Mar 2024 17:19:26 +0800
Message-ID: <CAK1f24k2+x1g3pK5dVPP3dEBfhaNr2M0Twy=-44-eh_oXJFCbw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 5:03=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 13/03/2024 07:19, Barry Song wrote:
> > On Tue, Mar 12, 2024 at 4:01=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any larg=
e
> >> folio that is fully and contiguously mapped in the pageout/cold vm
> >> range. This change means that large folios will be maintained all the
> >> way to swap storage. This both improves performance during swap-out, b=
y
> >> eliding the cost of splitting the folio, and sets us up nicely for
> >> maintaining the large folio when it is swapped back in (to be covered =
in
> >> a separate series).
> >>
> >> Folios that are not fully mapped in the target range are still split,
> >> but note that behavior is changed so that if the split fails for any
> >> reason (folio locked, shared, etc) we now leave it as is and move to t=
he
> >> next pte in the range and continue work on the proceeding folios.
> >> Previously any failure of this sort would cause the entire operation t=
o
> >> give up and no folios mapped at higher addresses were paged out or mad=
e
> >> cold. Given large folios are becoming more common, this old behavior
> >> would have likely lead to wasted opportunities.
> >>
> >> While we are at it, change the code that clears young from the ptes to
> >> use ptep_test_and_clear_young(), which is more efficent than
> >> get_and_clear/modify/set, especially for contpte mappings on arm64,
> >> where the old approach would require unfolding/refolding and the new
> >> approach can be done in place.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >
> > This looks so much better than our initial RFC.
> > Thank you for your excellent work!
>
> Thanks - its a team effort - I had your PoC and David's previous batching=
 work
> to use as a template.
>
> >
> >> ---
> >>  mm/madvise.c | 89 ++++++++++++++++++++++++++++++---------------------=
-
> >>  1 file changed, 51 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 547dcd1f7a39..56c7ba7bd558 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>         LIST_HEAD(folio_list);
> >>         bool pageout_anon_only_filter;
> >>         unsigned int batch_count =3D 0;
> >> +       int nr;
> >>
> >>         if (fatal_signal_pending(current))
> >>                 return -EINTR;
> >> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>                 return 0;
> >>         flush_tlb_batched_pending(mm);
> >>         arch_enter_lazy_mmu_mode();
> >> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> >> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> >> +               nr =3D 1;
> >>                 ptent =3D ptep_get(pte);
> >>
> >>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >> @@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range(pmd=
_t *pmd,
> >>                         continue;
> >>
> >>                 /*
> >> -                * Creating a THP page is expensive so split it only i=
f we
> >> -                * are sure it's worth. Split it if we are only owner.
> >> +                * If we encounter a large folio, only split it if it =
is not
> >> +                * fully mapped within the range we are operating on. =
Otherwise
> >> +                * leave it as is so that it can be swapped out whole.=
 If we
> >> +                * fail to split a folio, leave it in place and advanc=
e to the
> >> +                * next pte in the range.
> >>                  */
> >>                 if (folio_test_large(folio)) {
> >> -                       int err;
> >> -
> >> -                       if (folio_estimated_sharers(folio) > 1)
> >> -                               break;
> >> -                       if (pageout_anon_only_filter && !folio_test_an=
on(folio))
> >> -                               break;
> >> -                       if (!folio_trylock(folio))
> >> -                               break;
> >> -                       folio_get(folio);
> >> -                       arch_leave_lazy_mmu_mode();
> >> -                       pte_unmap_unlock(start_pte, ptl);
> >> -                       start_pte =3D NULL;
> >> -                       err =3D split_folio(folio);
> >> -                       folio_unlock(folio);
> >> -                       folio_put(folio);
> >> -                       if (err)
> >> -                               break;
> >> -                       start_pte =3D pte =3D
> >> -                               pte_offset_map_lock(mm, pmd, addr, &pt=
l);
> >> -                       if (!start_pte)
> >> -                               break;
> >> -                       arch_enter_lazy_mmu_mode();
> >> -                       pte--;
> >> -                       addr -=3D PAGE_SIZE;
> >> -                       continue;
> >> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> >> +                                               FPB_IGNORE_SOFT_DIRTY;
> >> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> >> +
> >> +                       nr =3D folio_pte_batch(folio, addr, pte, ptent=
, max_nr,
> >> +                                            fpb_flags, NULL);
> >
> > I wonder if we have a quick way to avoid folio_pte_batch() if users
> > are doing madvise() on a portion of a large folio.
>
> Good idea. Something like this?:
>
>         if (pte_pfn(pte) =3D=3D folio_pfn(folio)
>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr,
>                                      fpb_flags, NULL);
>
> If we are not mapping the first page of the folio, then it can't be a ful=
l
> mapping, so no need to call folio_pte_batch(). Just split it.
>
> >
> >> +
> >> +                       if (nr < folio_nr_pages(folio)) {
> >> +                               int err;
> >> +
> >> +                               if (folio_estimated_sharers(folio) > 1=
)
> >> +                                       continue;
> >> +                               if (pageout_anon_only_filter && !folio=
_test_anon(folio))
> >> +                                       continue;
> >> +                               if (!folio_trylock(folio))
> >> +                                       continue;
> >> +                               folio_get(folio);
> >> +                               arch_leave_lazy_mmu_mode();
> >> +                               pte_unmap_unlock(start_pte, ptl);
> >> +                               start_pte =3D NULL;
> >> +                               err =3D split_folio(folio);
> >> +                               folio_unlock(folio);
> >> +                               folio_put(folio);
> >> +                               if (err)
> >> +                                       continue;
> >> +                               start_pte =3D pte =3D
> >> +                                       pte_offset_map_lock(mm, pmd, a=
ddr, &ptl);
> >> +                               if (!start_pte)
> >> +                                       break;
> >> +                               arch_enter_lazy_mmu_mode();
> >> +                               nr =3D 0;
> >> +                               continue;
> >> +                       }
> >>                 }
> >>
> >>                 /*
> >>                  * Do not interfere with other mappings of this folio =
and
> >> -                * non-LRU folio.
> >> +                * non-LRU folio. If we have a large folio at this poi=
nt, we
> >> +                * know it is fully mapped so if its mapcount is the s=
ame as its
> >> +                * number of pages, it must be exclusive.
> >>                  */
> >> -               if (!folio_test_lru(folio) || folio_mapcount(folio) !=
=3D 1)
> >> +               if (!folio_test_lru(folio) ||
> >> +                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
> >>                         continue;
> >
> > This looks so perfect and is exactly what I wanted to achieve.
> >
> >>
> >>                 if (pageout_anon_only_filter && !folio_test_anon(folio=
))
> >>                         continue;
> >>
> >> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >> -
> >> -               if (!pageout && pte_young(ptent)) {
> >> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pt=
e,
> >> -                                                       tlb->fullmm);
> >> -                       ptent =3D pte_mkold(ptent);
> >> -                       set_pte_at(mm, addr, pte, ptent);
> >> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >> +               if (!pageout) {
> >> +                       for (; nr !=3D 0; nr--, pte++, addr +=3D PAGE_=
SIZE) {
> >> +                               if (ptep_test_and_clear_young(vma, add=
r, pte))
> >> +                                       tlb_remove_tlb_entry(tlb, pte,=
 addr);
> >> +                       }
> >
> > This looks so smart. if it is not pageout, we have increased pte
> > and addr here; so nr is 0 and we don't need to increase again in
> > for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >
> > otherwise, nr won't be 0. so we will increase addr and
> > pte by nr.
>
> Indeed. I'm hoping that Lance is able to follow a similar pattern for
> madvise_free_pte_range().

Thanks a lot, Ryan!
I'll make sure to follow a similar pattern for madvise_free_pte_range().

Best,
Lance

>
>
> >
> >
> >>                 }
> >>
> >>                 /*
> >> --
> >> 2.25.1
> >>
> >
> > Overall, LGTM,
> >
> > Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>
> Thanks!
>
>

