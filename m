Return-Path: <linux-kernel+bounces-150051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF788A99A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFBFB228EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EB15F404;
	Thu, 18 Apr 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjAxUgu0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357B16078F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442612; cv=none; b=I/N2Sm7jIdA30fjgaUGIWnlrybFQ8KMl4WaB3TILzXLVCMuOpyh6EmQeOv9NeMmKS0l7i+1xrw8J8/AUW3vKoSayAJTl2DWHIyEkRxCBLEnTsePw873TAV8TILMqS9l0zytqmA9Fc81Q3ZDVxy1QXrOifclIBzStVs2zY1h9SGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442612; c=relaxed/simple;
	bh=8hw863a6Ur3cteysMH8aedF25s3o3PxPKtj3uUFQLB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ivuc0O9TGYiQuuD/b8VGCdU/51RLVSPVcldd88xYbZQQM8yArf7xeWAnIOjgd2XyeU+RC0qsvwCJt7ZUmy64Qco+wHhtQ6gsDVS66T5KuFQvw+7eIcWvpBxJ6hmR0gXuDLnVdFG/ktB43xTFTHUYoEBTxnEyPAIwJTl5zfI8X20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjAxUgu0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so1030484a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713442609; x=1714047409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWu8DQdoqbDYC17VK5KbQzPtyY7R1TNzUqPVRafOJms=;
        b=BjAxUgu0POgd9thUDqhG3T0YuRPpFDV4o8mdWnwQDRW7Rd1P8H4+t7yOxsYM2sBEDg
         ZOd8jPzLklPEy9rz4LlIbouQGHxV3tISyCLff+VvzwaqfwcZqcaFw/H2P+QAVEr//Q5O
         oLN0lM6I6aF9pgqKgrMnqgXW9x/om6ELmrOr7z75gwBE6Q9tp64fxH0n+ye4+FmswbX4
         MkPKPMH6HZKUWJutqdO4vnCqs/QfujOHyv5gOoEY3d5vxcITIzj+beC6f6rEJFff0a5V
         B0tzf4PQ9MbbzjulQz4pu6DOEh+zp16z7okb0RJ0u8TY+A1RzGbA53BM8uHp9qq3Abxm
         X30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442609; x=1714047409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWu8DQdoqbDYC17VK5KbQzPtyY7R1TNzUqPVRafOJms=;
        b=grQQpunJ1PTVcGGXeyEVHjZDYTMmD1wApUFvNn8yRT3UaaV1lBkODFxSb7leNvykcX
         nut4KJ2dzdoKzvLxByTMMqRg96AivkzvM8kDjU3FGJsu9ks3I/Igz8jpFgkmAkMKJmvK
         y+KHJYr2HM8Vtq/OPoPhelYvRNS3CldDdeLCZwE3YNJX1zI+Zgm+h3YLnjPd5gz5RZoo
         qxicWYZK9mrGSdyZYeJuc9rNuNucmp6+ZoKET/UaaEDejhXPJjFeM6Z+cMuCvb9i2GBU
         liCTsRH9HedEBlY3wtM0iRbvXWEiWUhSDhs7KbsdlALViXXSO3PsI3347ffzWgyRLAib
         KyPg==
X-Forwarded-Encrypted: i=1; AJvYcCVLkAsAlqF06T2FX8ZhqXdXfmYZVG2o8tJ/wnbmXQ6kjkZoC1VEuh+iEGi9NW5SpxoBNgZFyhrhw4sG720Q6XwAgNNCiQPdcsIanOfE
X-Gm-Message-State: AOJu0YzpqDqZGlUhVyiBSdOEo8U1QUNnil+JCbo3Xo80Hkow5vsqFCDd
	geQWDzbDBZw1rqykgVoxJNfpZPnQVdvIRJ9N9yAwbjQ+dWuVRv9QtBP3Q8RGdOi9VKMg7Kl1PTv
	j+M9+qe2MT64kpK88Z+VPRmM6OVw=
X-Google-Smtp-Source: AGHT+IF1oi0APHTGvoDtEmfzrkDiAuUKqixHOJClJ2ygeR/yLpyCH6mQxQqNJ7QmXFJ1rUirpQOjqqEAfn/Y6VoYH2I=
X-Received: by 2002:a50:d741:0:b0:56e:2a64:8290 with SMTP id
 i1-20020a50d741000000b0056e2a648290mr1571652edj.5.1713442608589; Thu, 18 Apr
 2024 05:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418105750.98866-1-ioworker0@gmail.com> <20240418105750.98866-5-ioworker0@gmail.com>
 <2fdcee93-b8ad-4374-a8ab-7c7bed463813@redhat.com>
In-Reply-To: <2fdcee93-b8ad-4374-a8ab-7c7bed463813@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 20:16:36 +0800
Message-ID: <CAK1f24mtzSWNpjK7Oi=tYtmKHTMfadVcm8p40PN7u6DRsfQ7Mw@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks a lot for taking time to review!

On Thu, Apr 18, 2024 at 8:03=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.04.24 12:57, Lance Yang wrote:
> > This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> > (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> > splitting if the large folio is fully mapped within the target range.
> >
> > If a large folio is locked or shared, or if we fail to split it, we jus=
t
> > leave it in place and advance to the next PTE in the range. But note th=
at
> > the behavior is changed; previously, any failure of this sort would cau=
se
> > the entire operation to give up. As large folios become more common,
> > sticking to the old way could result in wasted opportunities.
> >
> > On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios =
of
> > the same size results in the following runtimes for madvise(MADV_FREE) =
in
> > seconds (shorter is better):
> >
> > Folio Size |   Old    |   New    | Change
> > ------------------------------------------
> >        4KiB | 0.590251 | 0.590259 |    0%
> >       16KiB | 2.990447 | 0.185655 |  -94%
> >       32KiB | 2.547831 | 0.104870 |  -95%
> >       64KiB | 2.457796 | 0.052812 |  -97%
> >      128KiB | 2.281034 | 0.032777 |  -99%
> >      256KiB | 2.230387 | 0.017496 |  -99%
> >      512KiB | 2.189106 | 0.010781 |  -99%
> >     1024KiB | 2.183949 | 0.007753 |  -99%
> >     2048KiB | 0.002799 | 0.002804 |    0%
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com
> >
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   mm/madvise.c | 85 +++++++++++++++++++++++++++------------------------=
-
> >   1 file changed, 44 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 4597a3568e7e..375ab3234603 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -643,6 +643,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
> >                               unsigned long end, struct mm_walk *walk)
> >
> >   {
> > +     const cydp_t cydp_flags =3D CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY;
> >       struct mmu_gather *tlb =3D walk->private;
> >       struct mm_struct *mm =3D tlb->mm;
> >       struct vm_area_struct *vma =3D walk->vma;
> > @@ -697,44 +698,57 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                       continue;
> >
> >               /*
> > -              * If pmd isn't transhuge but the folio is large and
> > -              * is owned by only this process, split it and
> > -              * deactivate all pages.
> > +              * If we encounter a large folio, only split it if it is =
not
> > +              * fully mapped within the range we are operating on. Oth=
erwise
> > +              * leave it as is so that it can be marked as lazyfree. I=
f we
> > +              * fail to split a folio, leave it in place and advance t=
o the
> > +              * next pte in the range.
> >                */
> >               if (folio_test_large(folio)) {
> > -                     int err;
> > +                     bool any_young, any_dirty;
> >
> > -                     if (folio_likely_mapped_shared(folio))
> > -                             break;
> > -                     if (!folio_trylock(folio))
> > -                             break;
> > -                     folio_get(folio);
> > -                     arch_leave_lazy_mmu_mode();
> > -                     pte_unmap_unlock(start_pte, ptl);
> > -                     start_pte =3D NULL;
> > -                     err =3D split_folio(folio);
> > -                     folio_unlock(folio);
> > -                     folio_put(folio);
> > -                     if (err)
> > -                             break;
> > -                     start_pte =3D pte =3D
> > -                             pte_offset_map_lock(mm, pmd, addr, &ptl);
> > -                     if (!start_pte)
> > -                             break;
> > -                     arch_enter_lazy_mmu_mode();
> > -                     pte--;
> > -                     addr -=3D PAGE_SIZE;
> > -                     continue;
> > +                     nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> > +                                                  ptent, &any_young, N=
ULL);
> > +
> > +                     if (nr < folio_nr_pages(folio)) {
> > +                             int err;
> > +
> > +                             if (folio_likely_mapped_shared(folio))
> > +                                     continue;
> > +                             if (!folio_trylock(folio))
> > +                                     continue;
> > +                             folio_get(folio);
> > +                             arch_leave_lazy_mmu_mode();
> > +                             pte_unmap_unlock(start_pte, ptl);
> > +                             start_pte =3D NULL;
> > +                             err =3D split_folio(folio);
> > +                             folio_unlock(folio);
> > +                             folio_put(folio);
> > +                             start_pte =3D pte =3D
> > +                                     pte_offset_map_lock(mm, pmd, addr=
, &ptl);
>
> I'd just put it on a single line.

Got it.

>
> > +                             if (!start_pte)
> > +                                     break;
> > +                             arch_enter_lazy_mmu_mode();
> > +                             if (!err)
> > +                                     nr =3D 0;
> > +                             continue;
> > +                     }
> > +
> > +                     if (any_young)
> > +                             ptent =3D pte_mkyoung(ptent);
> > +                     if (any_dirty)
>
> any_dirty is never set, likely missed to pass it to
> madvise_folio_pte_batch().

Good spot! My bad for the mistake - sorry :(

>
> Apart from that LGTM and this patch is much easier to review now!
>
>
> With above:
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks again for the review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

