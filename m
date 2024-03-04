Return-Path: <linux-kernel+bounces-91270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0D870C14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CBD283BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9E41C6D;
	Mon,  4 Mar 2024 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COKIpK6A"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0210A36
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586289; cv=none; b=ntqyh6/sdDraTnx3XkDXaKVrXYCjyuE97O+2EH6hCIFu8VXMZkzFP647ooMlcqxG8W7WAfe9xgHcOSmT+Ip79Qy0DQ+LgeS61OfO4BHe54d+rMXqv42KsbgW7R7bZ2PUJ539zKRF0SymwRRwD9pEGZcrBF9eLaXzpT0cR4ITrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586289; c=relaxed/simple;
	bh=wcN0X4D5vAY7Fzi4SXe8LKE3eY9n8Hr99aj0im2D6Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdbCHCh+Le/KyKVULUJNyUyBmT71johK21nOn8nTvAeGDOslIXSwIrQSaSy5QPE0tWslFVo4q5kbeRyqAC8ilKUoVUdboaztsCeapEcRjJz6+2vyWBWRc5ujBcp2T/U01Y2AQDLnSi62y4L9qd+ZLWHafNqv+UF+9hoG8daWhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COKIpK6A; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1f6a387a3so389591b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709586286; x=1710191086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TVmEhSKhlDR6P3G5ys+4kcir1aOuZN32lH8jTi+5V4=;
        b=COKIpK6ASxCm9dIaK4nb2Ijz1oMUXy96fGHOt8iSUP1UkfeodbXY9+McbOtBafb13c
         LIdIuNb5CsqtTTEtk7rTgeaHCZ5sI7WP1dQ5nHFFhNDMWMCUasBLRgP9G5T3N6Vua9F6
         gW6msJ6pHyk2XDkDe5n02eyb+ACt1jbXKqGB9FDgaCq/XC1CntEH1Bj2ivz2fZNdx8fr
         +uSVWUYwC+n7PTBUSq5mwsFnk8FuMRRV3zRGXwBsU8j04+Ei0a+BJrPpG+Wgd3ONEnKE
         CoZTiXMNEoIHtpcCqsAwBphAOUSrR17KWmmnDiS93Yjin3CTdbUhji56Tku5rhf6rcg9
         sJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709586286; x=1710191086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TVmEhSKhlDR6P3G5ys+4kcir1aOuZN32lH8jTi+5V4=;
        b=VRB0P4afDvGFngEp8PegHZWH7mxkQFQ5o7xo7pqSyuH1XNJqzFZ6E+qPRgxkXlTrbs
         pJfBEuRK8kX5llxPVnRNKm23AIkALUHbB1AGog/0owR7bslE0SyXHn8Wl920QXJp35Wr
         N5LUhM3t2uM9t3AUv50P+rJ0U5ynFGleSHzCXmsJ2dsamsJ0vBQetZ0hG1B30m7mxXph
         U6btegJx766FWnJaJJUKsioyaRLyoGDHyDH8WHdpsQg7BghCPzvcnbdJ+3l4rM+8AD/T
         xMGQc3iFCVk5imyjzu/n1DIB8+fK7pGIO+mIjJTu15VqBlJiF5h2/BZIiWhlvD9EOIC1
         GTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoON/zh4ExuXx8CD4j/2pqtBz/zTv42PgQvj/le4xXbHWHRT2iPwXIYbEYXcWqtPBZptCbO63bFVAr+HoeanMl4RKw8KnFgDYk8sDe
X-Gm-Message-State: AOJu0Yx4Mn1zIRgJdjNIUhvbCnZrfaJrFEsdMa05Lxcnj24fxpuNbPhs
	NTgiVAj1b8J2T5O1VmeuMBlA0ixng1KIP+9W+AaSx8p42PfelijL0uRZajeY32BYeqifT7ncjSA
	xolCUmrJ30UU9a6QqTo8i+68pCOI=
X-Google-Smtp-Source: AGHT+IH40sUK7/cQYOFbmLuq2L+jqwEit/A3MGsAyOy/hs1vuPRuz9cQpYooWpOftsRNDh2IOhs4cox54PoSdEH3TvU=
X-Received: by 2002:a05:6808:f04:b0:3c2:66f:8be6 with SMTP id
 m4-20020a0568080f0400b003c2066f8be6mr1223511oiw.43.1709586286341; Mon, 04 Mar
 2024 13:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
In-Reply-To: <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 10:04:34 +1300
Message-ID: <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:41=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.03.24 13:20, Ryan Roberts wrote:
> > Hi Barry,
> >
> > On 04/03/2024 10:37, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> page_vma_mapped_walk() within try_to_unmap_one() races with other
> >> PTEs modification such as break-before-make, while iterating PTEs
> >> of a large folio, it will only begin to acquire PTL after it gets
> >> a valid(present) PTE. break-before-make intermediately sets PTEs
> >> to pte_none. Thus, a large folio's PTEs might be partially skipped
> >> in try_to_unmap_one().
> >
> > I just want to check my understanding here - I think the problem occurs=
 for
> > PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large fol=
ios? Now
> > that I've had a look at the code and have a better understanding, I thi=
nk that
> > must be the case? And therefore this problem exists independently of my=
 work to
> > support swap-out of mTHP? (From your previous report I was under the im=
pression
> > that it only affected mTHP).
> >
> > Its just that the problem is becoming more pronounced because with mTHP=
,
> > PTE-mapped large folios are much more common?
>
> That is my understanding.
>
> >
> >> For example, for an anon folio, after try_to_unmap_one(), we may
> >> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
> >> So folio will be still mapped, the folio fails to be reclaimed.
> >> What=E2=80=99s even more worrying is, its PTEs are no longer in a unif=
ied
> >> state. This might lead to accident folio_split() afterwards. And
> >> since a part of PTEs are now swap entries, accessing them will
> >> incur page fault - do_swap_page.
> >> It creates both anxiety and more expense. While we can't avoid
> >> userspace's unmap to break up unified PTEs such as CONT-PTE for
> >> a large folio, we can indeed keep away from kernel's breaking up
> >> them due to its code design.
> >> This patch is holding PTL from PTE0, thus, the folio will either
> >> be entirely reclaimed or entirely kept. On the other hand, this
> >> approach doesn't increase PTL contention. Even w/o the patch,
> >> page_vma_mapped_walk() will always get PTL after it sometimes
> >> skips one or two PTEs because intermediate break-before-makes
> >> are short, according to test. Of course, even w/o this patch,
> >> the vast majority of try_to_unmap_one still can get PTL from
> >> PTE0. This patch makes the number 100%.
> >> The other option is that we can give up in try_to_unmap_one
> >> once we find PTE0 is not the first entry we get PTL, we call
> >> page_vma_mapped_walk_done() to end the iteration at this case.
> >> This will keep the unified PTEs while the folio isn't reclaimed.
> >> The result is quite similar with small folios with one PTE -
> >> either entirely reclaimed or entirely kept.
> >> Reclaiming large folios by holding PTL from PTE0 seems a better
> >> option comparing to giving up after detecting PTL begins from
> >> non-PTE0.
> >>
>
> I'm sure that wall of text can be formatted in a better way :) . Also, I
> think we can drop some of the details,
>
> If you need some inspiration, I can give it a shot.
>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > Do we need a Fixes tag?

I am not quite sure which commit should be here for a fixes tag.
I think it's more of an optimization.

> >
>
> What would be the description of the problem we are fixing?
>
> 1) failing to unmap?
>
> That can happen with small folios as well IIUC.
>
> 2) Putting the large folio on the deferred split queue?
>
> That sounds more reasonable.

I don't feel it is reasonable. Avoiding this kind of accident splitting
from the kernel's improper code is a more reasonable approach
as there is always a price to pay for splitting and unfolding PTEs
etc.

While we can't avoid splitting coming from userspace's
MADV_DONTNEED, munmap, mprotect, we have a way
to ensure the kernel itself doesn't accidently break up a
large folio.

In OPPO's phones, we ran into some weird bugs due to skipped PTEs
in try_to_unmap_one. hardly could we fix it from the root cause. with
various races, figuring out their timings was really a big pain :-)

But we did "resolve" those bugs by entirely untouching all PTEs if we
found some PTEs were skipped in try_to_unmap_one [1].

While we find we only get the PTL from 2nd, 3rd but not
1st PTE, we entirely give up on try_to_unmap_one, and leave
all PTEs untouched.

/* we are not starting from head */
if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw.pte))) {
                   ret =3D false;
                   atomic64_inc(&perf_stat.mapped_walk_start_from_non_head)=
;
                   set_pte_at(mm, address, pvmw.pte, pteval);
                   page_vma_mapped_walk_done(&pvmw);
                   break;
}
This will ensure all PTEs still have a unified state such as CONT-PTE
after try_to_unmap fails.
I feel this could have some false postive because when racing
with unmap, 1st PTE might really become pte_none. So explicitly
holding PTL from 1st PTE seems a better way.

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplu=
s/sm8550_u_14.0.0_oneplus11/mm/rmap.c#L1730

>
> >> ---
> >>   mm/vmscan.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 0b888a2afa58..e4722fbbcd0c 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct li=
st_head *folio_list,
> >>
> >>                      if (folio_test_pmd_mappable(folio))
> >>                              flags |=3D TTU_SPLIT_HUGE_PMD;
> >> +                    /*
> >> +                     * if page table lock is not held from the first =
PTE of
> >> +                     * a large folio, some PTEs might be skipped beca=
use of
> >> +                     * races with break-before-make, for example, PTE=
s can
> >> +                     * be pte_none intermediately, thus one or more P=
TEs
> >> +                     * might be skipped in try_to_unmap_one, we might=
 result
> >> +                     * in a large folio is partially mapped and parti=
ally
> >> +                     * unmapped after try_to_unmap
> >> +                     */
> >> +                    if (folio_test_large(folio))
> >> +                            flags |=3D TTU_SYNC;
> >
> > This looks sensible to me after thinking about it for a while. But I al=
so have a
> > gut feeling that there might be some more subtleties that are going ove=
r my
> > head, since I'm not expert in this area. So will leave others to provid=
e R-b :)
> >
>
> As we are seeing more such problems with lockless PT walks, maybe we
> really want some other special value (nonswap entry?) to indicate that a
> PTE this is currently ondergoing protection changes. So we'd avoid the
> pte_none() temporarily, if possible.
>
> Without that, TTU_SYNC feels like the right thing to do.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

