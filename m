Return-Path: <linux-kernel+bounces-163258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15D8B67D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9EAB22852
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C43C152;
	Tue, 30 Apr 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIuuspMI"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0B8C07
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443234; cv=none; b=nrNyVe+sciqqzPuqCY32UJ0YfKMK8P2qgjcYbWZ0J30UIgXtAjIvi0jHXvtBsqbzE28e6w8xwlKzn2sLGCocTgl4yudgxdkwUD3Rt7S1MY4U6/DqNavDdjk1hOWHjo0E60+E6Vqfc+bxuZWbhHyblTVrvdCWwV92ba+PGmF4gX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443234; c=relaxed/simple;
	bh=z5UFqnrkRJzrIthf/1ZlgFduKbwTcOmGQ3ZVTiOu7Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp7MGVFPV0U4Wi/RmLMicnuWe9o18qdlT+S2oZZjocATqxShdB/zCDzORWB43JSc0Sdj4FKFod36w+g6ALrZ263uH1Pz5AVM/irMCwya2LrfX6xnJolrN/bS6dkS1X+6vc+IOihWMp/2f8OE2gjqxDS3ONo1te2R4wkIl5qgXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIuuspMI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so5541527a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714443231; x=1715048031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWExLD5ARGmSPYsKb1Jv6jWFNXY7UPECUkAyh7Qq9Hc=;
        b=eIuuspMICUOo0XI46tFlTF90lHHokyoX+YnuA4YBqkDOGBgEp/XSJvi9GtXj1Ojq9F
         W5YO8ABdB8Lzaa/3U0ewrrydHQWvhxPIWDP1nu6iNQDuR0Bp8zN45/GANdZXJLB2eB+F
         MGnAQwsanSHQLFOLQ5TjHUCy3IqhoKyRwBNfb6ROiJmEBc982SNQXR0Tk6xHaBluWaCr
         N9JREL+cKZW9mcZ8VdUP4VuXK41cewnol3t1toOGwgSHLA8hXFcAEgW70FhiY3d8YJaV
         IAfW5f90zxy6lV7tQF1/NdO2/z4RmNQzG44Q/IXtVV0smXDC9R/9hLmZVvaA3q5sALAX
         URng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714443231; x=1715048031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWExLD5ARGmSPYsKb1Jv6jWFNXY7UPECUkAyh7Qq9Hc=;
        b=JabzpLPGnpZ4+ZeYfFBX8prlFCt9rhzlldfsD2l6wq2+kdSmcrkq6HNeWWLD/OND2i
         3KH+hleSjp2Ty+bRAasMjY4MxDeN3u/a0NmlYyax1lJO2qL9UMV5ZL4dCggAWUR10OFA
         fKxShhqC6sGHZuiPVSJ5RzWCNx6bGj2wQWBJCGkLUiutGPSMPI2b4CtCIAPwPApX/azQ
         rxGxroFNpwKv13Lew9dFPLhFr2SsHZmRqkHS18ia1rLGoYgI/sRv3WbXRdqsFK3ZR71C
         yQ+6uB4ox9Ky6pSwh9UpxEGZ5SNP9D97sqTxhFgM5jUMcrjs1lDRhsoavkYeAyqRPw9X
         tzig==
X-Forwarded-Encrypted: i=1; AJvYcCVesfyi0CTitSZ+b6K9IR9zkZeEVvLPCpwGwMrMkbjOErbKNOdtzeUt052tyM6LX4MHuo7Jn1DlWi4WCBRCNogmPyaMjc4/4QooBdiL
X-Gm-Message-State: AOJu0YztR8pg8oR9FNxOwrTJIMGB/H9ZjezyfT5tJVu+zu1Ds5FcDKSC
	J+dhiR4c18SSGRMjuztyEH4KrnAwl2AWNsvU/GOpwnbrrdZAUdnZqcsdqJTjB6vtWrg5ML8uxNX
	Ef/LRF7sFRigQgJ/lvNHURoa5iAs=
X-Google-Smtp-Source: AGHT+IHQOOpa1TEXXVWdv/lx6hpGrJhugscR6HJwDLIOVRu212k+yL7MTatAbLul1X6stK3NsU/kxP5q6qZGI6CB300=
X-Received: by 2002:a50:9f61:0:b0:572:6aaf:e0d1 with SMTP id
 b88-20020a509f61000000b005726aafe0d1mr8522623edf.14.1714443231067; Mon, 29
 Apr 2024 19:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429132308.38794-3-ioworker0@gmail.com> <20240429202040.187453-1-sj@kernel.org>
 <CAK1f24=y3S_=ABUtzet9d2gftnb2j107Y-t+J8KzYR5ttcMgpg@mail.gmail.com>
In-Reply-To: <CAK1f24=y3S_=ABUtzet9d2gftnb2j107Y-t+J8KzYR5ttcMgpg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Apr 2024 10:13:39 +0800
Message-ID: <CAK1f24mf3oq7_V5Mk9NaRvgmsOTPRT5JvS7OJqz_oE7S0vRkBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, willy@infradead.org, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:03=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hey SJ,
>
> Thanks a lot for reporting!
>
> On Tue, Apr 30, 2024 at 4:20=E2=80=AFAM SeongJae Park <sj@kernel.org> wro=
te:
> >
> > Hi Lance,
> >
> > On Mon, 29 Apr 2024 21:23:07 +0800 Lance Yang <ioworker0@gmail.com> wro=
te:
> >
> > > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > > folios, start the pagewalk first, then call split_huge_pmd_address()
> > > to split the folio.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > ---
> > >  include/linux/huge_mm.h |  2 ++
> > >  mm/huge_memory.c        | 42 +++++++++++++++++++++------------------=
--
> > >  mm/rmap.c               | 26 +++++++++++++++++++------
> > >  3 files changed, 44 insertions(+), 26 deletions(-)
> > >
> > [...]
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 7e2575d669a9..e42f436c7ff3 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> > >       if (flags & TTU_SYNC)
> > >               pvmw.flags =3D PVMW_SYNC;
> > >
> > > -     if (flags & TTU_SPLIT_HUGE_PMD)
> > > -             split_huge_pmd_address(vma, address, false, folio);
> > > -
> > >       /*
> > >        * For THP, we have to assume the worse case ie pmd for invalid=
ation.
> > >        * For hugetlb, it could be much worse if we need to do pud
> > > @@ -1650,6 +1647,10 @@ static bool try_to_unmap_one(struct folio *fol=
io, struct vm_area_struct *vma,
> > >       range.end =3D vma_address_end(&pvmw);
> > >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm=
,
> > >                               address, range.end);
> > > +     if (flags & TTU_SPLIT_HUGE_PMD) {
> > > +             range.start =3D address & HPAGE_PMD_MASK;
> > > +             range.end =3D (address & HPAGE_PMD_MASK) + HPAGE_PMD_SI=
ZE;
> > > +     }
> >
> > I found the latest mm-unstable fails one[1] of my build configuration
> > with below error message.  And 'git bisect' points this patch.
>
> Thanks for taking time to 'git bisect' and identify this bug!
>
> >
> >       CC      mm/rmap.o
> >     In file included from <command-line>:
> >     .../linux/mm/rmap.c: In function 'try_to_unmap_one':
> >     .../linux/include/linux/compiler_types.h:460:38: error: call to '__=
compiletime_assert_455' declared with attribute error: BUILD_BUG failed
> >       460 |  _compiletime_assert(condition, msg, __compiletime_assert_,=
 __COUNTER__)
> >           |                                      ^
> >     .../linux/include/linux/compiler_types.h:441:4: note: in definition=
 of macro '__compiletime_assert'
> >       441 |    prefix ## suffix();    \
> >           |    ^~~~~~
> >     .../linux/include/linux/compiler_types.h:460:2: note: in expansion =
of macro '_compiletime_assert'
> >       460 |  _compiletime_assert(condition, msg, __compiletime_assert_,=
 __COUNTER__)
> >           |  ^~~~~~~~~~~~~~~~~~~
> >     .../linux/include/linux/build_bug.h:39:37: note: in expansion of ma=
cro 'compiletime_assert'
> >        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(co=
nd), msg)
> >           |                                     ^~~~~~~~~~~~~~~~~~
> >     .../linux/include/linux/build_bug.h:59:21: note: in expansion of ma=
cro 'BUILD_BUG_ON_MSG'
> >        59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >           |                     ^~~~~~~~~~~~~~~~
> >     .../linux/include/linux/huge_mm.h:97:28: note: in expansion of macr=
o 'BUILD_BUG'
> >        97 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> >           |                            ^~~~~~~~~
> >     .../linux/include/linux/huge_mm.h:104:34: note: in expansion of mac=
ro 'HPAGE_PMD_SHIFT'
> >       104 | #define HPAGE_PMD_SIZE ((1UL) << HPAGE_PMD_SHIFT)
> >           |                                  ^~~~~~~~~~~~~~~
> >     .../linux/include/linux/huge_mm.h:103:27: note: in expansion of mac=
ro 'HPAGE_PMD_SIZE'
> >       103 | #define HPAGE_PMD_MASK (~(HPAGE_PMD_SIZE - 1))
> >           |                           ^~~~~~~~~~~~~~
> >     .../linux/mm/rmap.c:1651:27: note: in expansion of macro 'HPAGE_PMD=
_MASK'
> >      1651 |   range.start =3D address & HPAGE_PMD_MASK;
> >           |                           ^~~~~~~~~~~~~~
> >
> > I haven't looked into the code yet, but seems this code need to handle
> > CONFIG_PGTABLE_HAS_HUGE_LEAVES undefined case?  May I ask your opinion?
> >
> > [1] https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_a=
rm64.sh
>
> I'll fix this bug and rebuild using the config you've provided above.

Hey Andrew,

Could you please temporarily drop this series from the mm tree?
I'll fix this bug in the next version.

Thanks,
Lance

>
> Thanks again for reporting!
> Lance
>
> >
> >
> > Thanks,
> > SJ
> > [...]

