Return-Path: <linux-kernel+bounces-147920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5E8A7B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B5B282897
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44441C85;
	Wed, 17 Apr 2024 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCuS5Tyf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9A41C6C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327432; cv=none; b=qoUiYe+T4ZKzb2aYj2mUtizm8gkg7tIjT4vqMD+9ciCWyrH5cWVkkpn/rCbsXqVr/yp5aWmhG7blKBOsewNv8N2/cDN6CdTzNRR4cgVbeCT28PD0oM420j3P80oQb5QpfIHoO4otK9MRtmAzKw0l7qN48084nehSVqySd6nzbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327432; c=relaxed/simple;
	bh=deU1+x/4WL1Bbey36pzsEZNyZiwdP/z5d5nkPXSFZFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1xwHbnoOo8r0iUkNJRZthWaN463caYHPISIaWZalWt7/btSfbFPQGNf63tVh3qsH0H9cfKnkqrHLo8NzWLPUsUqM5RUBn/qV98f3ViTCyp7t6rJbd069brpLdKfONrWwpOT9K9jcWK/m0DIXF3koDOvNTx9A7KUaPKCHMvKaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCuS5Tyf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51aac16b6eso277579066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713327429; x=1713932229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kelisK8aMrN8LmQjruS7TuvtaX2vL0wajIramXp8jko=;
        b=aCuS5TyfNIuQS5FTFQMRU8HjGGpl2LWwhY4TkClPsD2PmkOGWEvQVSgWqJvZFeEJa7
         MzWF5pxekCD/WmSNfyL+DKqrFMBURa4OUUhGk+K15NBwIBpLniNJxhsV0z9voIe6l0pG
         +LvzMRiS70Cz5SLCcuslLVY36bpZfX0jlRYJ2g+RujNO59VD2DsqIe/WrfuPp7wSI9hF
         GLGpW4ec//Cv51wwExlT+h2ZHsdECc+i28BXyZUX2aNfdM8acpfNGTvnax99nx/p5YCT
         IPWLR4+F9wWXLm7V/hDo8qhwGXUehi4WYEYgzP9ua/khb32do43aszCauSmrrkSsmJMu
         THOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327429; x=1713932229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kelisK8aMrN8LmQjruS7TuvtaX2vL0wajIramXp8jko=;
        b=BUZvLJaO4o9NMKzfBR7uwZdBSOpyUNSV7soEWHR9kL+OJJthmDt+5vM4Etlo/vMN7M
         jBXNxTn+igbA3MTxE000F4jLYrlPSpm+3ljgoG5eq3nmz0Ky6NnncJHD9hykNhImaUlP
         AWuF+AA5/umC+DmG1hTn6anj3rMNfKZe8V/gvqu5fbH2e0QLPPLBLbh8nBTlGOFX6jJi
         lNatkoEB2hwq+N9TD1impEEvj9Fcq020K2kJY+2BVVe8zhkBbTAsHEexvuCNdai2RbQ9
         ckjkkJgffm6Vm9KgDFOFwEKTs5wYc4+Y+lrJ/rbDZw4f6k9gkV7tgePP9/UtdFLqiVWy
         qHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVb6B80DNzbZfouGQYcfazXJLchlijhiQjD9SeM/9leHvCWqGCnd23L3Akdxwf2eFJfVAcx7Y/rqBGzNgessQv83lpLTE589njcvXq0
X-Gm-Message-State: AOJu0YzoQl46OytWi34tZgY9nAwoSkiWIbrnEGF7EZc4VuxCUiTF4jjD
	6qE8zCH+lmikCPLDLO9P2NsmUHLv4UfEK/lk82eN/5MDxikAaQWuyOHrl+MWUyeRvgzeTJ9Ymmy
	cjS7Nk1Q6EJUBilCrLKhx/d3n8JU=
X-Google-Smtp-Source: AGHT+IGb0voqCV585bpnH/J5W+v/xJ2//oAE1LH+cwuaGoFXpWugv68iXzM/VTm06QxP12zL7+mFnbOKAwiQZOkBNuo=
X-Received: by 2002:a50:cd0b:0:b0:56e:3f0:a163 with SMTP id
 z11-20020a50cd0b000000b0056e03f0a163mr13529487edi.14.1713327429158; Tue, 16
 Apr 2024 21:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416033457.32154-1-ioworker0@gmail.com> <20240416033457.32154-3-ioworker0@gmail.com>
 <456de31b-221f-4aeb-a2d3-9bb318526417@arm.com>
In-Reply-To: <456de31b-221f-4aeb-a2d3-9bb318526417@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 17 Apr 2024 12:16:58 +0800
Message-ID: <CAK1f24=anMUTN1n6Q0OV+uwp4Fg=wZmCL2n9pv790i+GS_afKA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] mm/arm64: override clear_young_dirty_ptes() batch helper
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:29=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 16/04/2024 04:34, Lance Yang wrote:
> > The per-pte get_and_clear/modify/set approach would result in
> > unfolding/refolding for contpte mappings on arm64. So we need
> > to override clear_young_dirty_ptes() for arm64 to avoid it.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Barry Song <21cnbao@gmail.com>
> > Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Hey Ryan,

Thanks for taking time to review!

Best,
Lance

>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 55 ++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/contpte.c          | 29 +++++++++++++++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 9fd8613b2db2..1303d30287dc 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1223,6 +1223,46 @@ static inline void __wrprotect_ptes(struct mm_st=
ruct *mm, unsigned long address,
> >               __ptep_set_wrprotect(mm, address, ptep);
> >  }
> >
> > +static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
> > +                                        unsigned long addr, pte_t *pte=
p,
> > +                                        pte_t pte, cydp_t flags)
> > +{
> > +     pte_t old_pte;
> > +
> > +     do {
> > +             old_pte =3D pte;
> > +
> > +             if (flags & CYDP_CLEAR_YOUNG)
> > +                     pte =3D pte_mkold(pte);
> > +             if (flags & CYDP_CLEAR_DIRTY)
> > +                     pte =3D pte_mkclean(pte);
> > +
> > +             pte_val(pte) =3D cmpxchg_relaxed(&pte_val(*ptep),
> > +                                            pte_val(old_pte), pte_val(=
pte));
> > +     } while (pte_val(pte) !=3D pte_val(old_pte));
> > +}
> > +
> > +static inline void __clear_young_dirty_ptes(struct vm_area_struct *vma=
,
> > +                                         unsigned long addr, pte_t *pt=
ep,
> > +                                         unsigned int nr, cydp_t flags=
)
> > +{
> > +     pte_t pte;
> > +
> > +     for (;;) {
> > +             pte =3D __ptep_get(ptep);
> > +
> > +             if (flags =3D=3D (CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY))
> > +                     __set_pte(ptep, pte_mkclean(pte_mkold(pte)));
> > +             else
> > +                     __clear_young_dirty_pte(vma, addr, ptep, pte, fla=
gs);
> > +
> > +             if (--nr =3D=3D 0)
> > +                     break;
> > +             ptep++;
> > +             addr +=3D PAGE_SIZE;
> > +     }
> > +}
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
> >  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> > @@ -1379,6 +1419,9 @@ extern void contpte_wrprotect_ptes(struct mm_stru=
ct *mm, unsigned long addr,
> >  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                               unsigned long addr, pte_t *ptep,
> >                               pte_t entry, int dirty);
> > +extern void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
> > +                             unsigned long addr, pte_t *ptep,
> > +                             unsigned int nr, cydp_t flags);
> >
> >  static __always_inline void contpte_try_fold(struct mm_struct *mm,
> >                               unsigned long addr, pte_t *ptep, pte_t pt=
e)
> > @@ -1603,6 +1646,17 @@ static inline int ptep_set_access_flags(struct v=
m_area_struct *vma,
> >       return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirt=
y);
> >  }
> >
> > +#define clear_young_dirty_ptes clear_young_dirty_ptes
> > +static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> > +                                       unsigned long addr, pte_t *ptep=
,
> > +                                       unsigned int nr, cydp_t flags)
> > +{
> > +     if (likely(nr =3D=3D 1 && !pte_cont(__ptep_get(ptep))))
> > +             __clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
> > +     else
> > +             contpte_clear_young_dirty_ptes(vma, addr, ptep, nr, flags=
);
> > +}
> > +
> >  #else /* CONFIG_ARM64_CONTPTE */
> >
> >  #define ptep_get                             __ptep_get
> > @@ -1622,6 +1676,7 @@ static inline int ptep_set_access_flags(struct vm=
_area_struct *vma,
> >  #define wrprotect_ptes                               __wrprotect_ptes
> >  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> >  #define ptep_set_access_flags                        __ptep_set_access=
_flags
> > +#define clear_young_dirty_ptes                       __clear_young_dir=
ty_ptes
> >
> >  #endif /* CONFIG_ARM64_CONTPTE */
> >
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 1b64b4c3f8bf..9f9486de0004 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -361,6 +361,35 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, =
unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
> >
> > +void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
> > +                                 unsigned long addr, pte_t *ptep,
> > +                                 unsigned int nr, cydp_t flags)
> > +{
> > +     /*
> > +      * We can safely clear access/dirty without needing to unfold fro=
m
> > +      * the architectures perspective, even when contpte is set. If th=
e
> > +      * range starts or ends midway through a contpte block, we can ju=
st
> > +      * expand to include the full contpte block. While this is not
> > +      * exactly what the core-mm asked for, it tracks access/dirty per
> > +      * folio, not per page. And since we only create a contpte block
> > +      * when it is covered by a single folio, we can get away with
> > +      * clearing access/dirty for the whole block.
> > +      */
> > +     unsigned long start =3D addr;
> > +     unsigned long end =3D start + nr;
> > +
> > +     if (pte_cont(__ptep_get(ptep + nr - 1)))
> > +             end =3D ALIGN(end, CONT_PTE_SIZE);
> > +
> > +     if (pte_cont(__ptep_get(ptep))) {
> > +             start =3D ALIGN_DOWN(start, CONT_PTE_SIZE);
> > +             ptep =3D contpte_align_down(ptep);
> > +     }
> > +
> > +     __clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
> > +
> >  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                                       unsigned long addr, pte_t *ptep,
> >                                       pte_t entry, int dirty)
>

