Return-Path: <linux-kernel+bounces-147916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BBA8A7B41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60E628291C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD544C7A;
	Wed, 17 Apr 2024 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjVoxK41"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A444C71
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327177; cv=none; b=L52SUMhMT8/OP0phGdi0ENhryTv6C1bUbn8B07mYbQ2SzCUjAMSpvw4MpQd2rZL06HhXmZBZIzSVR6/4hWukaOlApsU4O4im9bxSix+8oe/K1PRj/vYkJDsT9SQBTE5tqgSpf/5sK4sRDWVI/vwGEqUkk7JTBjuNCJRaC8xIuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327177; c=relaxed/simple;
	bh=K+zqEUpF/L/an46sf/3Id+nCNOdiTsllKIRWtM44/lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRGMMwoR5wbDd1HVS1Fz9zewUb77JANah+Kkk+g/aiXw6E4yTw5xNFqU+5kBwaORCEQeaftPWFPTVQqyfGqNzTQjFI19bAOfJpVdNBblzLznet4vCSFPeM0jsvf09qRouvumVLVfhaYMBE4ia4lo1TnYocZSmXR1nMeSzpFCPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjVoxK41; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518b9527c60so4089457e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713327174; x=1713931974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbM+atGM0bP5DsV5av6JoMWaz9VGX/GLnWohTfwxNTg=;
        b=KjVoxK41loP4tgE0+1pEFAzcsggP3bsfJ9ZHy/n12yE6tDjjTpwtofWhnpj8kjkc84
         m5GBynOtPt/HTTpzo72DOCI87sNmkuMygLqYw9eYlqXoXYLd9FgeAMpYqi0XOEwAmGP4
         iYAktCFqwdsWLmSBgmKdPNmIROwAZBkOhWtKLfP9MbdCO8YWwRLYtOUA7/7MulKzt7qA
         T+R8gdoVYc11Cl/zM8aOhGe6fkYK5y2mYl6P9LfHGn/gVTTEuNA4p5RaZBAVI7DA76Mo
         Y2dF0iLAa4D5m12WqAPLid+bgM+Rwp93i+vYQpTFCPnuJpwSZfu77+a2XeeVyq3qx4O/
         GVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327174; x=1713931974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbM+atGM0bP5DsV5av6JoMWaz9VGX/GLnWohTfwxNTg=;
        b=eoDK9p/iBvRebqQHS6IXLwce+Di8V/fe9N0N67Esz+iHa22twDJH3fw45dN+SyTghS
         sU54V8C7QhPTDotP0I6bgTImH3yP1UD4uGXBCSw4kHE0e4uacRdf89ClitGGn21F4GAt
         ZEhl6NnhkqKFjA/Bl2OODTfpwM75f8mod8D5qq+1hjHbA2MQvTKqRcZNHsQ6MJbM0DhW
         hAhQvk2z/kZ8H59BEPeqfjtprkQ9zXd3lK5wDgocEdEF4c8mfphqd7j0/CIp6pyL2g+E
         48nWlYaPmqiUwu/NWb59QW6dcmUZyZNdN3xxtDIxm4e6ozk6rkBmLb3pws1IqsBvBTUy
         N+wg==
X-Forwarded-Encrypted: i=1; AJvYcCVEAkAm66msMeQ6L/l5vfyx/+NgXZW8xxWSJ1wzilacbmnFuzcwjm/7m2mH5di9NicJ2sGzGOSo7k1ySeO0oAWG3vfDLmAiUsL9gug5
X-Gm-Message-State: AOJu0YwdXlfVSs9QvEgzxiMx87PzriJKegp7dSFDtnsC/+23b4mBj6B6
	VNkY0r6h6e3MyAJJ0kHBNTpYmenOfj/ruSXmIIyOtMObQBlZJGMjmaEASqGecMYhqSIQaFySz8h
	00ZDUg1Xxc4OgzVP5nD5jlR/0yTA=
X-Google-Smtp-Source: AGHT+IEXhAei6YA3Yla+z/ZdXWycBTAs8rpQGprqrg7rozCvrqCz3ONmnc3xFi4+3ai+rdgZclOmocY1zlZ0tetOWRM=
X-Received: by 2002:a05:6512:3109:b0:516:c8e5:db35 with SMTP id
 n9-20020a056512310900b00516c8e5db35mr11927150lfb.18.1713327173383; Tue, 16
 Apr 2024 21:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416033457.32154-1-ioworker0@gmail.com> <20240416033457.32154-2-ioworker0@gmail.com>
 <a0d9e198-8799-47b9-ac20-8460b984afee@redhat.com>
In-Reply-To: <a0d9e198-8799-47b9-ac20-8460b984afee@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 17 Apr 2024 12:12:42 +0800
Message-ID: <CAK1f24mEoC_Pg7-49G=y7dMUaGhzW11_A5sK0EWVhH6K1kjMMA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:03=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 16.04.24 05:34, Lance Yang wrote:
> > This commit introduces clear_young_dirty_ptes() to replace mkold_ptes()=
.
> > By doing so, we can use the same function for both use cases
> > (madvise_pageout and madvise_free), and it also provides the flexibilit=
y
> > to only clear the dirty flag in the future if needed.
> >
> > Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/mm_types.h |  9 +++++
> >   include/linux/pgtable.h  | 74 ++++++++++++++++++++++++---------------=
-
> >   mm/madvise.c             |  3 +-
> >   3 files changed, 55 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index c432add95913..28822cd65d2a 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1367,6 +1367,15 @@ enum fault_flag {
> >
> >   typedef unsigned int __bitwise zap_flags_t;
> >
> > +/* Flags for clear_young_dirty_ptes(). */
> > +typedef int __bitwise cydp_t;
> > +
> > +/* Clear the access bit */
> > +#define CYDP_CLEAR_YOUNG             ((__force cydp_t)BIT(0))
> > +
> > +/* Clear the dirty bit */
> > +#define CYDP_CLEAR_DIRTY             ((__force cydp_t)BIT(1))
> > +
> >   /*
> >    * FOLL_PIN and FOLL_LONGTERM may be used in various combinations wit=
h each
> >    * other. Here is what they mean, and how to use them:
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index e2f45e22a6d1..18019f037bae 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -361,36 +361,6 @@ static inline int ptep_test_and_clear_young(struct=
 vm_area_struct *vma,
> >   }
> >   #endif
> >
> > -#ifndef mkold_ptes
> > -/**
> > - * mkold_ptes - Mark PTEs that map consecutive pages of the same folio=
 as old.
> > - * @vma: VMA the pages are mapped into.
> > - * @addr: Address the first page is mapped at.
> > - * @ptep: Page table pointer for the first entry.
> > - * @nr: Number of entries to mark old.
> > - *
> > - * May be overridden by the architecture; otherwise, implemented as a =
simple
> > - * loop over ptep_test_and_clear_young().
> > - *
> > - * Note that PTE bits in the PTE range besides the PFN can differ. For=
 example,
> > - * some PTEs might be write-protected.
> > - *
> > - * Context: The caller holds the page table lock.  The PTEs map consec=
utive
> > - * pages that belong to the same folio.  The PTEs are all in the same =
PMD.
> > - */
> > -static inline void mkold_ptes(struct vm_area_struct *vma, unsigned lon=
g addr,
> > -             pte_t *ptep, unsigned int nr)
> > -{
> > -     for (;;) {
> > -             ptep_test_and_clear_young(vma, addr, ptep);
> > -             if (--nr =3D=3D 0)
> > -                     break;
> > -             ptep++;
> > -             addr +=3D PAGE_SIZE;
> > -     }
> > -}
> > -#endif
> > -
> >   #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> >   #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_N=
ONLEAF_PMD_YOUNG)
> >   static inline int pmdp_test_and_clear_young(struct vm_area_struct *vm=
a,
> > @@ -489,6 +459,50 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
> >   }
> >   #endif
> >
> > +#ifndef clear_young_dirty_ptes
> > +/**
> > + * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of th=
e
> > + *           same folio as old/clean.
> > + * @mm: Address space the pages are mapped into.
> > + * @addr: Address the first page is mapped at.
> > + * @ptep: Page table pointer for the first entry.
> > + * @nr: Number of entries to mark old/clean.
> > + * @flags: Flags to modify the PTE batch semantics.
> > + *
> > + * May be overridden by the architecture; otherwise, implemented by
> > + * get_and_clear/modify/set for each pte in the range.
> > + *
> > + * Note that PTE bits in the PTE range besides the PFN can differ. For=
 example,
> > + * some PTEs might be write-protected.
> > + *
> > + * Context: The caller holds the page table lock.  The PTEs map consec=
utive
> > + * pages that belong to the same folio.  The PTEs are all in the same =
PMD.
> > + */
> > +static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> > +                                       unsigned long addr, pte_t *ptep=
,
> > +                                       unsigned int nr, cydp_t flags)
> > +{
> > +     pte_t pte;
> > +
> > +     for (;;) {
> > +             if (flags =3D=3D CYDP_CLEAR_YOUNG)
> > +                     ptep_test_and_clear_young(vma, addr, ptep);
> > +             else {
> > +                     pte =3D ptep_get_and_clear(vma->vm_mm, addr, ptep=
);
> > +                     if (flags & CYDP_CLEAR_YOUNG)
> > +                             pte =3D pte_mkold(pte);
> > +                     if (flags & CYDP_CLEAR_DIRTY)
> > +                             pte =3D pte_mkclean(pte);
> > +                     set_pte_at(vma->vm_mm, addr, ptep, pte);
> > +             }
> > +             if (--nr =3D=3D 0)
> > +                     break;
> > +             ptep++;
> > +             addr +=3D PAGE_SIZE;
> > +     }
> > +}
>

Hey David,

Thanks for taking time to review!

> The complier *might* generate a bit faster code if you check for
> CYDP_CLEAR_YOUNG outside of the loop, so you don't have to recheck on
> each loop iteration.

Nice! I think moving the CYDP_CLEAR_YOUNG check outside of the loop
could speed up the code. I'll make this change in the next version.

>
> For now, nothing to lose sleep about
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks again for the review!

Best,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

