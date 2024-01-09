Return-Path: <linux-kernel+bounces-20683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6282836C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E128287DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF636093;
	Tue,  9 Jan 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw5RWdGG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C333608B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccbc328744so31638761fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704793381; x=1705398181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeB2WNn4H4jWlw/Xw5gvB0Tvd8i01mZv8HHnVnUvBXo=;
        b=Bw5RWdGGs/6C01cf55UsdZY3Yy8cL+6B7zQITbPK9t5NtSI3jMNPzp76FWzCrhBjPB
         3mFTzxi1yi3g/khEq4L+2X1+Sfon/4OY36oNfMFBBABetIOJ8mvuNknVG+w9UGe5YCsx
         VEuC7w+mNgQ16ao/5blLUCXnDVEs5xfalV0hdct1iZkkF21FLUsPtUCm+OzFXLsWRfFr
         rb/+4thA479/kx/p+qJ98bdmoO+h7wQqTepRukKdhpQvibvv8ivbPIRGW+QhCIc9eYD6
         dDxno4W2K55SX+zlE5myrCiHBmSay5tE1gXq8D4h66zJs9+JjIQieSafrobIUGry4JYM
         Ed3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704793381; x=1705398181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeB2WNn4H4jWlw/Xw5gvB0Tvd8i01mZv8HHnVnUvBXo=;
        b=ryCoZAzPfYqAmx7ppvy2LY4vNg3n4kbsvGekGTqOXeWENWcCtNFWmFEfEVb48M16QO
         0KfC0Hj8n3Bp3aqP7ndXFMgQzfisebPJJUat0eGAnjj+p8puuIwkh7PI9kZr8s7V8jUg
         9C6VqyPOqHSwD/g9k0j3/wQQTk6hFgp2Fg4257ftWotYMuM37sO8plkjUyJOJIsRrAN9
         yZPMjDux7vmog+jCzU1vn9pGkym7iSBpoMpvK6WofD9wj+s/iRLxBFJG1ABX8SLkYyCs
         hMnvAL3xePPAGJSeFyIpIUNSw6bi0azneIcBg+zs5VwVz7Lty0mkI200f3Bt6Elag1f8
         rU9A==
X-Gm-Message-State: AOJu0YzY64t9MRCqQgx9Zps7O75IvTgQD8x0I4/hElou7ng7minUc3GK
	GvOmB7C31N628rSDiEiCdxOMIvpi79v4MQolOug=
X-Google-Smtp-Source: AGHT+IEF77NlmfvikY97ga0rs3UJEAa2FaNio+f/Bwi+B7ECk24W0ukg4RSpGGSwjiEPHtBYUlmz+sjhqHSbbO9+hV0=
X-Received: by 2002:a2e:960a:0:b0:2cd:2ac6:9685 with SMTP id
 v10-20020a2e960a000000b002cd2ac69685mr2293997ljh.92.1704793380802; Tue, 09
 Jan 2024 01:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-5-ryncsn@gmail.com>
 <878r54b6ae.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7B7iShnLaiT-0MBGEMdVS65bupx_NshjM0ssLmhJm0CFQ@mail.gmail.com>
 <87edes9smm.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edes9smm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 9 Jan 2024 17:42:43 +0800
Message-ID: <CAMgjq7AzUOgaJGSZ6BBLvF0j27FAzOpaFYi+WZCrC_7KPYrJNg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mm/swap: always account swapped in page into
 current memcg
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=80 15:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=94 15:16=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Kairui Song <ryncsn@gmail.com> writes:
> >>
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > Currently, mem_cgroup_swapin_charge_folio is always called with
> >> > mm argument as NULL, except in swapin_direct.
> >> >
> >> > swapin_direct is used when swapin should skip readahead and
> >> > swapcache (SWP_SYNCHRONOUS_IO). Other caller paths of
> >> > mem_cgroup_swapin_charge_folio are for swapin that should
> >> > not skip readahead and cache.
> >> >
> >> > This could cause swapin charging to behave differently depending
> >> > on swap device. This currently didn't happen because the only call
> >> > path of swapin_direct is the direct anon page fault path, where mm
> >> > equals to current->mm, but will no longer be true if swapin_direct
> >> > is shared and have other callers (eg, swapoff).
> >> >
> >> > So make swapin_direct also passes NULL for mm, no feature change.
> >> >
> >> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >> > ---
> >> >  mm/swap_state.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> > index 6130de8d5226..d39c5369da21 100644
> >> > --- a/mm/swap_state.c
> >> > +++ b/mm/swap_state.c
> >> > @@ -881,7 +881,7 @@ struct folio *swapin_direct(swp_entry_t entry, g=
fp_t gfp_mask,
> >> >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> >> >                               vma, vmf->address, false);
> >> >       if (folio) {
> >> > -             if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> >> > +             if (mem_cgroup_swapin_charge_folio(folio, NULL,
> >> >                                                  GFP_KERNEL, entry))=
 {
> >> >                       folio_put(folio);
> >> >                       return NULL;
> >>
> >> I think that why not provide "mm" when it's available?  For
> >> swapin_direct() called by do_swap_page(), mm can be provided.  While,
> >> for swapin_direct() called by shmem swapin, mm will be NULL.  We can
> >> even provide "mm" for __read_swap_cache_async() for VMA based swapin a=
nd
> >> for the fault address for cluster swapin.
> >
> > Hi, Ying.
> >
> > Thanks for the comment.
> >
> > Without modifying too much code, providing mm here will change swapin
> > charge behaviour on swapoff, we discussed it previously:
> > https://lkml.org/lkml/2023/11/19/320
>
> It's better to use "lore" for kernel email link, for example,
>
> https://lore.kernel.org/lkml/20231119194740.94101-24-ryncsn@gmail.com/
>
> This is more readable than the above link.

Hi Ying,

Thanks for your advice.

>
> > If we want to avoid the behavior change, we have to extend all direct
> > and indirect callers of mem_cgroup_swapin_charge_folio to accept a
> > standalone mm argument (including swapin_direct, swap_vma_readahead,
> > swap_cluster_readahead, __read_swap_cache_async, swapin_entry_mpol,
> > read_swap_cache_async, and some other path may need more audit), and
> > sort things our case by case. I'm not sure if that's a good idea...
> >
> > Simply dropping it here seems the easiest way to avoid such change.
>
> OK.  Didn't realize that they are related directly.  It appears that we
> always pass NULL as mm to mem_cgroup_swapin_charge_folio().  If so,
> please just remove the parameter.

Yes, that's also what I wanted.

>
> --
> Best Regards,
> Huang, Ying

