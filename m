Return-Path: <linux-kernel+bounces-128809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D451895FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B7E1F23BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553952E3FD;
	Tue,  2 Apr 2024 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV8eDMF9"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479F446B2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098455; cv=none; b=MEzRyW5AiuFkZ8gn0z7CJ8IRxmhC8Z37TXfbT1UeM93pmGUuRaTmjjg9ehX1GxbCYwGg29GgN4FTGQ9uPWOp+kwAHfOT8N9xhrx9dRWM88lbPXD1GgECJgv4OfJApQjMS+s23UClg+oIu7Sa/KtimR2w+qRJU7tyE1f7Zv6R748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098455; c=relaxed/simple;
	bh=oE5cGC5+qAva31AZHfiX83A07qWDi6p4+h0YURYmUP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhv6lqI8BsGRQFQIPyGZotZOn2eNb+sA0rAnOzpBWMjo0Rl5jCe7RHankXcpdRq1WohnDxaQyL0bTVRclDnBbKWPyHzpYg+n76aZwput/AGF4ZlAWbRmu/8qVKkeKe/HDeJVHC5w52mzFhtLdgUGNkNLrgIx8DBzQoydWIJDOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV8eDMF9; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d8804a553dso2123319e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 15:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712098452; x=1712703252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaCsSLFI4AruxYR7+hfoQQpqqA7CBzp2msWt+WkiOg8=;
        b=kV8eDMF9f32PMHi5AGnNs2mY6R0FbI/ZNN+Jn7U2Ba9v0i3eVGn9tyMFM3J9SLLJFv
         xnMpJt8DTdxRcbY6muyIcLrZWcz47TqwL7taA6dpY65O8O8TqVJX+3wUQXXXYwUFmQs2
         z7cu6o7bEaHFYclpGcCuLFKWm09lpvWRAeBN2NddBtEcMPnVuchsB2LlRxAiKfnl6Xve
         Ez2NYup4QJ2QhP/ulD9/7bs2lVt/JzlRNttBUTenRAtVKAVCkl6SFPsEu27VYMVddlNn
         4EEQYgIBCABnn+J+gPlu3spg/FbP3Gaz9O9pnHhjsaa+qzpCfHY6/OiNh7jg3OoeLzHi
         C8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712098452; x=1712703252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaCsSLFI4AruxYR7+hfoQQpqqA7CBzp2msWt+WkiOg8=;
        b=Rt+wUxHP+1+9/CyIBM6GKapTvukIQ29HCYzNM4poFt1wUnLjlg509hpbZk5vXr7TnS
         529PdgSfSoXXB7LhHlbKR1eSSVgKswR3iHMldKU+xaJW4lKC/F3Og12dEofWkDQgH4gr
         WLSe4yB9P2kmh7nxGy/JLvqzp7bNlgxBoQ71vWg+BAz1s5oj31IGeo4PoV8+S36S7CLi
         nKBFmUZbnKWop0SKqIPgR1LKuh5E84NGyY+cINw0dnxO5stgmg1ZON4Ed1efWZZVS1LV
         wMWDlG5tHzXKXkB4dUT0MpFP1l03/rdN3emVIcTMQEcaMpuXhox0p+hdKdgLNamdWYM3
         yuwg==
X-Forwarded-Encrypted: i=1; AJvYcCVI7VhS6XPGOlt2wd7+vANX/lcIAeP2js8RRXLwew1MRlhyV4SsIX7MLUpfAfF1NWWbHUZwRgJquvk8GcOVFun7r3jLpr3wyH0ydE9M
X-Gm-Message-State: AOJu0Yzh1qfFD21ygLVU/PEu7n+NRsWsg8HQ9QKPKebjcQenLIBGFkGO
	1NmcfGfMvy+Vse/OSbwXg3eJL70FAbQrq6BO1u4Elow0136YlCXrLxsKRWz1S8C8+PQPzcbrgEw
	V/kIs9yrpwqE/STRHxk7RV5K88ug=
X-Google-Smtp-Source: AGHT+IE5SK/agCNDVab7BHES6qcv591Nd7QR6gkm6qmDioTB9cVi3cwpH7mQGMdj+CBA1CJT15i4BkHwDz+j8E0j254=
X-Received: by 2002:a05:6122:1d93:b0:4d3:45a2:ae4f with SMTP id
 gg19-20020a0561221d9300b004d345a2ae4fmr11937500vkb.14.1712098452014; Tue, 02
 Apr 2024 15:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-6-ryan.roberts@arm.com> <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
 <63c9caf4-3af4-4149-b3c2-e677788cb11f@arm.com> <47fa11db-3c26-48a6-bb7e-5ea59739b691@arm.com>
In-Reply-To: <47fa11db-3c26-48a6-bb7e-5ea59739b691@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Apr 2024 11:54:00 +1300
Message-ID: <CAGsJ_4zCTLjJOX3Cs-KDVgqytUykzRJQncHbOEHzyEbyVmt2=g@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:22=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 02/04/2024 14:10, Ryan Roberts wrote:
> > On 28/03/2024 08:18, Barry Song wrote:
> >> On Thu, Mar 28, 2024 at 3:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>>
> >>> Now that swap supports storing all mTHP sizes, avoid splitting large
> >>> folios before swap-out. This benefits performance of the swap-out pat=
h
> >>> by eliding split_folio_to_list(), which is expensive, and also sets u=
s
> >>> up for swapping in large folios in a future series.
> >>>
> >>> If the folio is partially mapped, we continue to split it since we wa=
nt
> >>> to avoid the extra IO overhead and storage of writing out pages
> >>> uneccessarily.
> >>>
> >>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>  mm/vmscan.c | 9 +++++----
> >>>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 00adaf1cb2c3..293120fe54f3 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct =
list_head *folio_list,
> >>>                                         if (!can_split_folio(folio, N=
ULL))
> >>>                                                 goto activate_locked;
> >>>                                         /*
> >>> -                                        * Split folios without a PMD=
 map right
> >>> -                                        * away. Chances are some or =
all of the
> >>> -                                        * tail pages can be freed wi=
thout IO.
> >>> +                                        * Split partially mapped fol=
ios right
> >>> +                                        * away. We can free the unma=
pped pages
> >>> +                                        * without IO.
> >>>                                          */
> >>> -                                       if (!folio_entire_mapcount(fo=
lio) &&
> >>> +                                       if (data_race(!list_empty(
> >>> +                                               &folio->_deferred_lis=
t)) &&
> >>>                                             split_folio_to_list(folio=
,
> >>>                                                                 folio=
_list))
> >>>                                                 goto activate_locked;
> >>
> >> Hi Ryan,
> >>
> >> Sorry for bringing up another minor issue at this late stage.
> >
> > No problem - I'd rather take a bit longer and get it right, rather than=
 rush it
> > and get it wrong!
> >
> >>
> >> During the debugging of thp counter patch v2, I noticed the discrepanc=
y between
> >> THP_SWPOUT_FALLBACK and THP_SWPOUT.
> >>
> >> Should we make adjustments to the counter?
> >
> > Yes, agreed; we want to be consistent here with all the other existing =
THP
> > counters; they only refer to PMD-sized THP. I'll make the change for th=
e next
> > version.
> >
> > I guess we will eventually want equivalent counters for per-size mTHP u=
sing the
> > framework you are adding.
> >
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 293120fe54f3..d7856603f689 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1241,8 +1241,10 @@ static unsigned int shrink_folio_list(struct
> >> list_head *folio_list,
> >>                                                                 folio_=
list))
> >>                                                 goto activate_locked;
> >>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> -
> >> count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> >> -                                       count_vm_event(THP_SWPOUT_FALL=
BACK);
> >> +                                       if (folio_test_pmd_mappable(fo=
lio)) {
>
> This doesn't quite work because we have already split the folio here, so =
this
> will always return false. I've changed it to:
>
> if (nr_pages >=3D HPAGE_PMD_NR) {

make sense to me.

>
>
> >> +
> >> count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> >> +
> >> count_vm_event(THP_SWPOUT_FALLBACK);
> >> +                                       }
> >>  #endif
> >>                                         if (!add_to_swap(folio))
> >>                                                 goto activate_locked_s=
plit;
> >>
> >>
> >> Because THP_SWPOUT is only for pmd:
> >>
> >> static inline void count_swpout_vm_event(struct folio *folio)
> >> {
> >> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>         if (unlikely(folio_test_pmd_mappable(folio))) {
> >>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
> >>                 count_vm_event(THP_SWPOUT);
> >>         }
> >> #endif
> >>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
> >> }
> >>
> >> I can provide per-order counters for this in my THP counter patch.
> >>
> >>> --
> >>> 2.25.1
> >>>
> >>

Thanks
Barry

