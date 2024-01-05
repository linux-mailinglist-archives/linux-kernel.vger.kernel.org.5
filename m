Return-Path: <linux-kernel+bounces-17548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF1824F33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C99B2370D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2520314;
	Fri,  5 Jan 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQcWpoGN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F690200AC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd1aeb1bf3so2939501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 23:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704440006; x=1705044806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHicSr6rOWVvMTesmGW7ZwN5Nw8dTnXVRJbiDId9Yc8=;
        b=kQcWpoGNxwa3rf3VEYrYbUjpW4zVJao3Rn1TYj7TLuUHttxDRZEv6aKX28LYFkjLaz
         uTXGt3eSyuuywgQb8eMD3dEwVca6snrWcXKegsmJUUh3uDQrLAxO+Mz5urbAfzuWY+NK
         oI4tunZuIIdxuTME7YNtSNOSvlWX4WhfQluXEDnMqYGDNT+4maf8lTrwPSLHKUplpIFv
         jSQ6RHn45kDVdwdIvoFH4in1fHvh/zwD1iDF+2bSEIQLixwL4VGPBITJWlSv6/GXdILQ
         ogQXQY0wagqVqcbFUk9xjtdv3cwrz6dF1gRcsLo3GOjAJIjMNa0+MCUIGwBE5OkXSyrg
         JRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704440006; x=1705044806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHicSr6rOWVvMTesmGW7ZwN5Nw8dTnXVRJbiDId9Yc8=;
        b=w+S90AUsoGNhvXRxh1A2xSP+GC0S8sFrclEIZg9rMHuEmvGEzPAH1ZsiC67JXf1XLQ
         7Oi6BMIeSOj+FsQnssJI5gm1QaZ7ef0vUVodiuR/2sBtsbCJlW76p1in/ZeCvQagsgS2
         kTM7kzJaJ/NaWeGjt6k4TdUmkRgp6R9B7VBCIY7MwcjMuvlFID6K0XNjOTtQ3QsQf39C
         1kWNootI14/qjr0KAFsql8VqBKuPb+meou9h571hQbM+GbDzFVw6CRccNNYrSDHX+04Q
         UNLMhNViRqgWVgvUiblEA5jGlhFRXDYjyNYRVGuAN80XF4MDP2VipALWeWb+M/0Yz8S3
         vo3A==
X-Gm-Message-State: AOJu0YzHEpNOycZm8iXCWiZPOD8SbaafQRkq4uMo5RKOMD9krhkGJbeT
	CavL7S8yjWlgJ1G4pd/cIDslqZvBoSrWQ/7f95A=
X-Google-Smtp-Source: AGHT+IEF8eNazSeWcZCLl5J4WikEWT2ApmNtS2OD3iw0mE1zKSuViISACLJ+zY7W88Oo6QnO5yCoRcVVwHxU7fNbT00=
X-Received: by 2002:a05:651c:b2c:b0:2cd:1aa5:db82 with SMTP id
 b44-20020a05651c0b2c00b002cd1aa5db82mr979627ljr.21.1704440006026; Thu, 04 Jan
 2024 23:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-5-ryncsn@gmail.com>
 <878r54b6ae.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878r54b6ae.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 5 Jan 2024 15:33:08 +0800
Message-ID: <CAMgjq7B7iShnLaiT-0MBGEMdVS65bupx_NshjM0ssLmhJm0CFQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mm/swap: always account swapped in page into
 current memcg
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=94 15:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently, mem_cgroup_swapin_charge_folio is always called with
> > mm argument as NULL, except in swapin_direct.
> >
> > swapin_direct is used when swapin should skip readahead and
> > swapcache (SWP_SYNCHRONOUS_IO). Other caller paths of
> > mem_cgroup_swapin_charge_folio are for swapin that should
> > not skip readahead and cache.
> >
> > This could cause swapin charging to behave differently depending
> > on swap device. This currently didn't happen because the only call
> > path of swapin_direct is the direct anon page fault path, where mm
> > equals to current->mm, but will no longer be true if swapin_direct
> > is shared and have other callers (eg, swapoff).
> >
> > So make swapin_direct also passes NULL for mm, no feature change.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 6130de8d5226..d39c5369da21 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -881,7 +881,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_=
t gfp_mask,
> >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> >                               vma, vmf->address, false);
> >       if (folio) {
> > -             if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> > +             if (mem_cgroup_swapin_charge_folio(folio, NULL,
> >                                                  GFP_KERNEL, entry)) {
> >                       folio_put(folio);
> >                       return NULL;
>
> I think that why not provide "mm" when it's available?  For
> swapin_direct() called by do_swap_page(), mm can be provided.  While,
> for swapin_direct() called by shmem swapin, mm will be NULL.  We can
> even provide "mm" for __read_swap_cache_async() for VMA based swapin and
> for the fault address for cluster swapin.

Hi, Ying.

Thanks for the comment.

Without modifying too much code, providing mm here will change swapin
charge behaviour on swapoff, we discussed it previously:
https://lkml.org/lkml/2023/11/19/320

If we want to avoid the behavior change, we have to extend all direct
and indirect callers of mem_cgroup_swapin_charge_folio to accept a
standalone mm argument (including swapin_direct, swap_vma_readahead,
swap_cluster_readahead, __read_swap_cache_async, swapin_entry_mpol,
read_swap_cache_async, and some other path may need more audit), and
sort things our case by case. I'm not sure if that's a good idea...

Simply dropping it here seems the easiest way to avoid such change.

