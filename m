Return-Path: <linux-kernel+bounces-163254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A98B67C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BCD1F22B40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2568F5C;
	Tue, 30 Apr 2024 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mslh7tIg"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC38BE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442627; cv=none; b=lBOvHq6j7MLez0e49k1Bbel1qbu+EyTGrGs/lKay9R3L1rwx2NMcDby8fXD2KnwgntPsbyqEQTflqkFGtEfpGdU2nhfgqbik7ptRMyxJ607GzLiK5g4mlq34nlwUJ0mtu9cNl/ivFiD1X9gHH8TCGb+NkYAVNxBD/N8pUvAhvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442627; c=relaxed/simple;
	bh=XUU7dcQ/CbYbaTdQzEDJigo74xbZTNnUQ0xqBFrnHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlE20i+q1gdDyOhfhv/DQNMMmhMMOAzwIoCxW4rkDRhBdvsT3sF3NZQJ4Gjei/junWEeD0bGabpjQ2qPJ9Wy6arArF6PTDcOiDC3O8yVKuFg/6OfKYOoSeHk3RywZyDoS+hOrIQ9hTecP+CYdzOXwyUwdiW3igG9hzsGsHPyNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mslh7tIg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso17054981fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714442623; x=1715047423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkbeCDHpeb40dQXG63pjG1WzOO/A5FvGS55H+EtxGQU=;
        b=Mslh7tIgqoEEh2tJ8jdMKRgSUfQwPuCNFBkX7MHWyuE7FB4gb9YkfeKHDzbOTb5rw0
         7WOyEPtHb+G6+utjsqWBp6wZ38hBrqA/Yi21IJWNcc8DFK8I4Po7g7v3maG9YY58CqMQ
         MzLSSDD9G5+gM/8Uu8ol/U/bE0Nl21WxfNi1G2Iw5gqwXK2A8Jmw3MiBuxzJl276I8Qh
         c2uk1KmzIKm0MjuZX9vH8wKGrUYjAUxjt4b3IFGXX5C4tkBV7K4wsksyJ79KYkjNIW/d
         bRZQkyFy2d71S33AuHDVe16QvIs7uOGoAJ80Y6KHzoe+C8gDD0ke3P7hSPvBoxphXk1l
         GYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714442623; x=1715047423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkbeCDHpeb40dQXG63pjG1WzOO/A5FvGS55H+EtxGQU=;
        b=At2oeWBVBHel6PeG701/J/NJKWsDUnfiG057dIBpRn7NYcGCDsTqlWNVb38508ATxi
         tiKgxv1WXE7TCgLSLakRbUnq/E8mo/sDfFlnREOG6t586N7RHtRFh7OGt/AFRKjih/ip
         oXNwQ19DosGYnNLfJoNshzl1XcU+xLix6hEjzk2q58nf9+EO9cxJaWZ0Ypl+ZeuRAk/6
         wTsoZq7fr+0eM4tEcTF4KAmG6hmEG0lNadO3ciBmswAYbX2Xma+fbEQDrtwfdFdM4swf
         Odv7EYQL9cKL8uXdlCLQe4k1tBLgIG5rGVRYQV2jKdAFhi8tm46LwzLhvlojupGqIxTU
         8ztw==
X-Forwarded-Encrypted: i=1; AJvYcCXWkLdjHm0eVbtcS9aDnbd/8vqs2G4snwt+rwrWgqk/vb/98IsNgYEHPz9GUU+58lz/idnNk75XOEC2HqMbxs2FVnFvbqB94t3I5oZJ
X-Gm-Message-State: AOJu0YxKGzu6JzM4k9fC/1WVLGClJoV8CqWIMGZFtiFJKMtYNKgTClrO
	iY/wIKe8Wnwt1lrlitAu1MN/ygjEpTl3ncfUPWQ6Eo4+lPSHRB4+K7qjXDm49Tm0MAVrWoqJCAC
	LN4vtugs75I8s+htAxEIlCDT+4FQ=
X-Google-Smtp-Source: AGHT+IF3M4ytIaAlEmox1+ZvisbCNBrscqG/EtpJssVNF8vRNkzyovromWG+z2mbr9aOPGdpuV1sk2wCKvsGgEn5JSM=
X-Received: by 2002:a2e:93d0:0:b0:2df:b076:972a with SMTP id
 p16-20020a2e93d0000000b002dfb076972amr5630120ljh.3.1714442623165; Mon, 29 Apr
 2024 19:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429132308.38794-3-ioworker0@gmail.com> <20240429202040.187453-1-sj@kernel.org>
In-Reply-To: <20240429202040.187453-1-sj@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Apr 2024 10:03:31 +0800
Message-ID: <CAK1f24=y3S_=ABUtzet9d2gftnb2j107Y-t+J8KzYR5ttcMgpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey SJ,

Thanks a lot for reporting!

On Tue, Apr 30, 2024 at 4:20=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Lance,
>
> On Mon, 29 Apr 2024 21:23:07 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address()
> > to split the folio.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  2 ++
> >  mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
> >  mm/rmap.c               | 26 +++++++++++++++++++------
> >  3 files changed, 44 insertions(+), 26 deletions(-)
> >
> [...]
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 7e2575d669a9..e42f436c7ff3 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >       if (flags & TTU_SYNC)
> >               pvmw.flags =3D PVMW_SYNC;
> >
> > -     if (flags & TTU_SPLIT_HUGE_PMD)
> > -             split_huge_pmd_address(vma, address, false, folio);
> > -
> >       /*
> >        * For THP, we have to assume the worse case ie pmd for invalidat=
ion.
> >        * For hugetlb, it could be much worse if we need to do pud
> > @@ -1650,6 +1647,10 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >       range.end =3D vma_address_end(&pvmw);
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
> >                               address, range.end);
> > +     if (flags & TTU_SPLIT_HUGE_PMD) {
> > +             range.start =3D address & HPAGE_PMD_MASK;
> > +             range.end =3D (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE=
;
> > +     }
>
> I found the latest mm-unstable fails one[1] of my build configuration
> with below error message.  And 'git bisect' points this patch.

Thanks for taking time to 'git bisect' and identify this bug!

>
>       CC      mm/rmap.o
>     In file included from <command-line>:
>     .../linux/mm/rmap.c: In function 'try_to_unmap_one':
>     .../linux/include/linux/compiler_types.h:460:38: error: call to '__co=
mpiletime_assert_455' declared with attribute error: BUILD_BUG failed
>       460 |  _compiletime_assert(condition, msg, __compiletime_assert_, _=
_COUNTER__)
>           |                                      ^
>     .../linux/include/linux/compiler_types.h:441:4: note: in definition o=
f macro '__compiletime_assert'
>       441 |    prefix ## suffix();    \
>           |    ^~~~~~
>     .../linux/include/linux/compiler_types.h:460:2: note: in expansion of=
 macro '_compiletime_assert'
>       460 |  _compiletime_assert(condition, msg, __compiletime_assert_, _=
_COUNTER__)
>           |  ^~~~~~~~~~~~~~~~~~~
>     .../linux/include/linux/build_bug.h:39:37: note: in expansion of macr=
o 'compiletime_assert'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond=
), msg)
>           |                                     ^~~~~~~~~~~~~~~~~~
>     .../linux/include/linux/build_bug.h:59:21: note: in expansion of macr=
o 'BUILD_BUG_ON_MSG'
>        59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>           |                     ^~~~~~~~~~~~~~~~
>     .../linux/include/linux/huge_mm.h:97:28: note: in expansion of macro =
'BUILD_BUG'
>        97 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>           |                            ^~~~~~~~~
>     .../linux/include/linux/huge_mm.h:104:34: note: in expansion of macro=
 'HPAGE_PMD_SHIFT'
>       104 | #define HPAGE_PMD_SIZE ((1UL) << HPAGE_PMD_SHIFT)
>           |                                  ^~~~~~~~~~~~~~~
>     .../linux/include/linux/huge_mm.h:103:27: note: in expansion of macro=
 'HPAGE_PMD_SIZE'
>       103 | #define HPAGE_PMD_MASK (~(HPAGE_PMD_SIZE - 1))
>           |                           ^~~~~~~~~~~~~~
>     .../linux/mm/rmap.c:1651:27: note: in expansion of macro 'HPAGE_PMD_M=
ASK'
>      1651 |   range.start =3D address & HPAGE_PMD_MASK;
>           |                           ^~~~~~~~~~~~~~
>
> I haven't looked into the code yet, but seems this code need to handle
> CONFIG_PGTABLE_HAS_HUGE_LEAVES undefined case?  May I ask your opinion?
>
> [1] https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_arm=
64.sh

I'll fix this bug and rebuild using the config you've provided above.

Thanks again for reporting!
Lance

>
>
> Thanks,
> SJ
> [...]

