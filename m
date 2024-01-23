Return-Path: <linux-kernel+bounces-34805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7AB8387AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36F61F23C35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512750276;
	Tue, 23 Jan 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvqSuqLE"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4E8C04
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705992562; cv=none; b=cG061N2A/pPxaNd32ZPlehlZP6Pkh8UuO6Bh9kgeulQP0gVDkAsfLlpC7sSl4TSAwHJBFxR3GEdKEhj1WhAhAbK9yJ7OGgMHO5bffUc4EEMbYFlSQ6500jd0/gOPgxgRUoGTRBKgpqQbXIVGdW2p3KHWVk6tqAUQIrj9Ls0aQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705992562; c=relaxed/simple;
	bh=lrKf7co4dZd/i5bdvHclIGgfH9Ox1JQUyqlDDpHyH8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqsjnxjkOmaay0ZtDAiilnm9hjwojbELwr9p6k3Z5qNyjmtqcZVC75jbd9Ou1MKka8eS/h9ud22WGW/ZUS6fkSrRdZhGjc2NIl1901poqv8pnCtn0uKh+GU9Q8eBM7bwvhf2BBcl8bCK3bpN5+pUKLOAh4SCvdfuUSGlNP/Cvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvqSuqLE; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2dfe840f2so1111874241.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705992560; x=1706597360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umePHjAi6OPcq1K6nxeQmgi5O1MnXjNUe9aGL0eZ2Jk=;
        b=RvqSuqLEr6xIBI0DtoxuR+JeO7VpjAWQi7fOsAxDPOZxF3SPw5MAmYk6HQPa3iNGAK
         aUFbawn45yiEdYS52mbGmvdi0C/aUHw1LPpx2ysYcNYQT7eAcvBrQIQeB5AzInRNYTVw
         0SrmYRnnkhKmjpEMFjHO2qqpmR7W3LJCd3mOzr7XW871YvBsrvVTUZeHhbilS3+VfLUn
         0s212o5SqbwR0Uc6uZH81kXWltXGxpTgrp3wKR4OWX9YuL8XY9E89/AOx7KfGpt0qBQt
         f+yNu2W6jV5c82t8qo76ziLajtCRTDSFnFPt8g3IQPLJ28Gd8S+hJxt4HDTSLawcNBRc
         uFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705992560; x=1706597360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umePHjAi6OPcq1K6nxeQmgi5O1MnXjNUe9aGL0eZ2Jk=;
        b=w98xzdQQdrvJKgyuUGtKL0sz51w+/IhBe9zW9iTbtQGOayuuoAEChE6kO2ffQlU5Dh
         S27ixV/O+s+eVLPLvkjLG12oT+mqPs1UyMR9Y/nIdA6CRWO+o9tWYGQeflpS2v8F/UTH
         PYg6LVZo43+d5PtIcq0bEkItT6VrKdkGOYHgL3B+TaGeucwHUkZQevvpihQlvAvXW+AW
         V62JitfaXkk8uAeQDFWAVhAw8mX1QyOxM3m63+w6yyMvG9ogyfoviDA71f2SiN/aQ6s6
         39bTzWvUXGwyI1GcL9tku8nkRwg/tym4O3g8/yCoy5xoF6xu8cSKGpGJacvpVSMg+q9y
         ihjw==
X-Gm-Message-State: AOJu0YzvrJ45P1xYeBcbiJXC5VA+co9P9eXQ4esdJZHG3Zskqs7ciSAn
	dX3wfHOUuEmSxqvd0JwPJT0e4xbK8ESyv3dob9zq2Fm7MsK9tbzTkfpoAKhGyLFm2uSpmp8qblr
	MzCDxZjaPjX8FWHYvwyvRlw9vo4E=
X-Google-Smtp-Source: AGHT+IE2gMzDvsTBt/j6Qclci7KJi+JTAtAmsONKwyB9uLVGQi6YpN/0FchdLV+oVbhdXEzPwYtrCtI9lZqnYkgSMTI=
X-Received: by 2002:a1f:4a07:0:b0:4b8:ce85:1e97 with SMTP id
 x7-20020a1f4a07000000b004b8ce851e97mr1885512vka.20.1705992559918; Mon, 22 Jan
 2024 22:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com> <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
In-Reply-To: <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Jan 2024 14:49:08 +0800
Message-ID: <CAGsJ_4zwUpL7LihRBOefg-cmY2mgNjMm-MPkq9VFBdXS_4b=uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:54=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.01.24 12:10, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > In do_swap_page(), while supporting large folio swap-in, we are using t=
he helper
> > folio_add_anon_rmap_ptes. This is triggerring a WARN_ON in __folio_add_=
anon_rmap.
> > We can make the warning quiet by two ways
> > 1. in do_swap_page, we call folio_add_new_anon_rmap() if we are sure th=
e large
> > folio is new allocated one; we call folio_add_anon_rmap_ptes() if we fi=
nd the
> > large folio in swapcache.
> > 2. we always call folio_add_anon_rmap_ptes() in do_swap_page but weaken=
 the
> > WARN_ON in __folio_add_anon_rmap() by letting the WARN_ON less sensitiv=
e.
> >
> > Option 2 seems to be better for do_swap_page() as it can use unified co=
de for
> > all cases.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Tested-by: Chuanhua Han <hanchuanhua@oppo.com>
> > ---
> >   mm/rmap.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index f5d43edad529..469fcfd32317 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1304,7 +1304,10 @@ static __always_inline void __folio_add_anon_rma=
p(struct folio *folio,
> >                * page.
> >                */
> >               VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> > -                              level !=3D RMAP_LEVEL_PMD, folio);
> > +                              level !=3D RMAP_LEVEL_PMD &&
> > +                              (!IS_ALIGNED(address, nr_pages * PAGE_SI=
ZE) ||
> > +                              (folio_test_swapcache(folio) && !IS_ALIG=
NED(folio->index, nr_pages)) ||
> > +                              page !=3D &folio->page), folio);
> >               __folio_set_anon(folio, vma, address,
> >                                !!(flags & RMAP_EXCLUSIVE));
> >       } else if (likely(!folio_test_ksm(folio))) {
>
>
> I have on my todo list to move all that !anon handling out of
> folio_add_anon_rmap_ptes(), and instead make swapin code call add
> folio_add_new_anon_rmap(), where we'll have to pass an exclusive flag
> then (-> whole new folio exclusive).
>
> That's the cleaner approach.
>

one tricky thing is that sometimes it is hard to know who is the first
one to add rmap and thus should
call folio_add_new_anon_rmap.
especially when we want to support swapin_readahead(), the one who
allocated large filio might not
be that one who firstly does rmap.
is it an acceptable way to do the below in do_swap_page?
if (!folio_test_anon(folio))
      folio_add_new_anon_rmap()
else
      folio_add_anon_rmap_ptes()

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

