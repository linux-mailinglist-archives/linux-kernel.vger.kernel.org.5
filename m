Return-Path: <linux-kernel+bounces-101275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61887A4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61BFAB2105A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6813225CB;
	Wed, 13 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8g8FsSh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A52225A9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321889; cv=none; b=QR6fsye22Q37fIL4s4BdqS9VoVk4xNa1ORWutz9E17iKLSpZQCh/Wf02x9xcfYvRwGpHpa4lSx3SMp8ycSBK8OVxLxAm1Qt8BR/LWqB75IL53hxImopQNP1LYGtaXoui0hj53nvoVI4TIKz46lKtC3gb7GX4+Fgd8vhBMvqQ2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321889; c=relaxed/simple;
	bh=SbhoT3EgfOWatK99Mmjz4V7DOPij7jfKKuuXN4xhnwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+89tludvXqI4Iwc9RowIj6RsgJHrqeN9oPS2T+df18VHwWeICMLoZZqtLrfnJU9xU+rlNihbJm9dN9qRRA8AbEAPKSP9U5b1jb5lmIhBrAUVaftxO7C39egix8n0Otc0VzQa4Zbs6r4UWYhE5wjH16PNpzrLQEKkU5PIVRpthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8g8FsSh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so8033067a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710321886; x=1710926686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPD+cxv+0qUBoucY+ZqtBX2TszFOHU0DupeB2/oO4k0=;
        b=Y8g8FsShs+eaiVtMkHTwXOrS68WnGQkLYwDRUdN4hQphVfdi3BcaSOAMXn1Djpz07O
         XcWpQG4Li4cC7I8uJhZCLDbhub+L0UIMAOwi7ptoDjZIP4O2ZrKVTfO8xfLBW8G0c58P
         pszJQsLp0SO/XoLBX/gnHamLF17axs4Ioyg0hSpi0M8sQfAzhNMjsDoQa8FcdR8cJG7n
         y/dUTeJ/jVMO7zl2b1JnyconpLKprmIdh0GHzihbzzWK5/DLsJkslp3zF85Vx/qKYCr3
         F/mCOQdplhZytshhWKnhMvyIVN76AyEFSeEZBEvLuL/nY/mtH87zqaR7zEhCqFMrEk5x
         WVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321886; x=1710926686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPD+cxv+0qUBoucY+ZqtBX2TszFOHU0DupeB2/oO4k0=;
        b=eVxiOufGccynJTJHGojUNxUjej79rMMq1XgiPo4I+5ZarX3DOTVlW+EPw/toQd9Wty
         QFiUBGlkL5LTYkf5vEzyodqJB2ATWLcXPEmTudMCpmkgWup+mi4r7FaJ1Gq0SDhT7ztt
         q/X4eKP0Y67LaekI08LuMLmoPhUQQOLos6iCx3AaDhDv90AyAMUixTdHBdvYdJzwRDY6
         dzvMgT8DWN2Li9lt4Qfi2JzXpazYNR2xnguROVdosfyHN3nPAbOU7zPEEx1wa81PYQaL
         ujP5lVMx1UNKgFrv0YwslZmWQletL3auK6ViYIkMEmXpy+7Wqjo1uNCylJ3HZ36gmm3/
         e+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsZq5YSy1eoq5pN3gv5Vu2lhWjZxRTTX1E/EseoR8mRtopi91ACCFCpV9qEU9stsYMBm43TS7v53d0PFOjuHmWytawnnhiM6fTA/Hn
X-Gm-Message-State: AOJu0Yy4GiSbj0/YgzhjRMRLXRfUVKZ/ecNduIutlE+V5geWZ1umkQdX
	wjGgCYCSC1qzIL8E+9gQC1QT3/mJ1P/B1+7xAFki32/hglBmPeLennGAKeazizTzscIvW+NA2W8
	LhCLlFlQlYvhD3zJH47CshfBG/C4=
X-Google-Smtp-Source: AGHT+IFD54pe1kRDZc3skthbk+PAXH90rU1buFJKLdAnOrx/jHLKY+yJZGAokd4mO7aP2jrPKgE4eb/8Fb3Vx4SnwGA=
X-Received: by 2002:a50:c01b:0:b0:566:43ab:8b78 with SMTP id
 r27-20020a50c01b000000b0056643ab8b78mr7925871edb.30.1710321885387; Wed, 13
 Mar 2024 02:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-4-21cnbao@gmail.com>
 <e73c12ff-5234-44d5-a2b3-99cdc61a9c37@arm.com> <24dc6251-8582-790f-bbd3-465deed946f5@oppo.com>
 <f880135f-e113-4d42-b3a0-8b0b9eebcbf4@arm.com>
In-Reply-To: <f880135f-e113-4d42-b3a0-8b0b9eebcbf4@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Wed, 13 Mar 2024 17:24:33 +0800
Message-ID: <CANzGp4+w-e+Xg8B=1pSbdoTuftPiYRvFMKr9GiOXUs44B5SLig@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] mm: swap: make should_try_to_free_swap()
 support large-folio
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,
Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=89 17:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13/03/2024 02:21, Chuanhua Han wrote:
> > hi, Ryan Roberts
> >
> > =E5=9C=A8 2024/3/12 20:34, Ryan Roberts =E5=86=99=E9=81=93:
> >> On 04/03/2024 08:13, Barry Song wrote:
> >>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>
> >>> should_try_to_free_swap() works with an assumption that swap-in is al=
ways done
> >>> at normal page granularity, aka, folio_nr_pages =3D 1. To support lar=
ge folio
> >>> swap-in, this patch removes the assumption.
> >>>
> >>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> Acked-by: Chris Li <chrisl@kernel.org>
> >>> ---
> >>>  mm/memory.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index abd4f33d62c9..e0d34d705e07 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -3837,7 +3837,7 @@ static inline bool should_try_to_free_swap(stru=
ct folio *folio,
> >>>      * reference only in case it's likely that we'll be the exlusive =
user.
> >>>      */
> >>>     return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio)=
 &&
> >>> -           folio_ref_count(folio) =3D=3D 2;
> >>> +           folio_ref_count(folio) =3D=3D (1 + folio_nr_pages(folio))=
;
> >> I don't think this is correct; one reference has just been added to th=
e folio in
> >> do_swap_page(), either by getting from swapcache (swap_cache_get_folio=
()) or by
> >> allocating. If it came from the swapcache, it could be a large folio, =
because we
> >> swapped out a large folio and never removed it from swapcache. But in =
that case,
> >> others may have partially mapped it, so the refcount could legitimatel=
y equal
> >> the number of pages while still not being exclusively mapped.
> >>
> >> I'm guessing this logic is trying to estimate when we are likely exclu=
sive so
> >> that we remove from swapcache (release ref) and can then reuse rather =
than CoW
> >> the folio? The main CoW path currently CoWs page-by-page even for larg=
e folios,
> >> and with Barry's recent patch, even the last page gets copied. So not =
sure what
> >> this change is really trying to achieve?
> >>
> > First, if it is a large folio in the swap cache, then its refcont is at
> > least folio_nr_pages(folio) :
>
> Ahh! Sorry, I had it backwards - was thinking there would be 1 ref for th=
e swap
> cache, and you were assuming 1 ref per page taken by do_swap_page(). I
> understand now. On this basis:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thank you for your review!
>
> >
> >
> > For example, in add_to_swap_cache path:
> >
> > int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> >                         gfp_t gfp, void **shadowp)
> > {
> >         struct address_space *address_space =3D swap_address_space(entr=
y);
> >         pgoff_t idx =3D swp_offset(entry);
> >         XA_STATE_ORDER(xas, &address_space->i_pages, idx,
> > folio_order(folio));
> >         unsigned long i, nr =3D folio_nr_pages(folio); <---
> >         void *old;
> >         ...
> >         folio_ref_add(folio, nr); <---
> >         folio_set_swapcache(folio);
> >         ...
> > }
> >
> >
> >   *
> >
> >     Then in the do_swap_page path:
> >
> >   * if (should_try_to_free_swap(folio, vma, vmf->flags))
> >             folio_free_swap(folio);
> >   *
> >
> >   * It also indicates that only folio in the swap cache will call
> >     folio_free_swap
> >   * to delete it from the swap cache, So I feel like this patch is
> >     necessary!? =F0=9F=98=81
> >
> >>>  }
> >>>
> >>>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> >
> > Thanks,
> >
> > Chuanhua
> >
>
>
Thanks,
Chuanhua

