Return-Path: <linux-kernel+bounces-146126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D48A6112
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2071C20EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3833D8;
	Tue, 16 Apr 2024 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Me/8kt"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F67A34
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234981; cv=none; b=l3JJDB4Lh7ZnweYNudpi2pSN60f79T/MZ4d2zvyHPiElqG2G2tSE53ONtcV2eFRHIiio3w0vLqO5dz6jMuOtlVyqGi2EoI0FSgHLSXVqO9nlUxd1NcvQw0pTb0+C88OryLQnFrPLgaMIXdwEk+Xbp7fv51tH3UBOR5aQEtI+BnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234981; c=relaxed/simple;
	bh=Lan8JzO995QsLvLLcrrzYESBGdkFPYrca0mCi18bM/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o37GZBV9utLF7VT/30ZdTHGkraGdT8mEYBdPF+FVSCDOs2C+nXUc/B1fR+eL7HDmlljyM0u93FO0E3fJCC/x6nLslJyA5PYp4pahh/5gQzO0j0NsNR5dJ4bwuwlMEN9H7DKRJFt3Am6/vF1AVUPnw+w2wk8cP0iYXUcOkvXY3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Me/8kt; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4dacb2ad01dso1690740e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713234979; x=1713839779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq4U0Tp6kyjk4hccTjIpN9kg7kEYO/hCNjlkdetKms0=;
        b=j8Me/8ktkgEBFLNlv8gsQSD+igE71avZvaixNfhN52+fqPdSlDZQB+W4SyKvsnReps
         4th2lW2Epd4/Cq93HOh8mOU7iO49H3tiZmwyOMQcGRaFE7XNam9Vt+i2UG9SXAQhuOW8
         ZPCB+m9dlkOsEqFLD+nfR+sFmNBARAjO6FiJT0I8V+SVpNBjNNLQkHQYxV57ZLurRrp+
         XmRpOh+adYtTNbWrmK2hzpr1AN4/xi2RG956P8ymQFYQhbK4B4OS+QbIVnmYV68Av4tU
         IXNbzUMqh6+CYrFH4AWPCY8A+SMfOU01bz1kEDNnF94eJG19DQsKVS1Y93a5u0OrO6n0
         xHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713234979; x=1713839779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq4U0Tp6kyjk4hccTjIpN9kg7kEYO/hCNjlkdetKms0=;
        b=gh8VJ0nWLNatdt5uBa5AGIuvXFUjRpN66Z9c/dw8L5uSfAVSz/3Yf/tLQ1wqztUFXY
         w9ijmiGXbwylC6e1gS9EVm8mXmbnj5PZvyMjY2vbCysWP7BACoNeUmjKnCgQHH6mevy1
         q7mzGBkYoQZZKtBLeFMLAJuYeSFdloaHmlfFOv/gkkbedMmwc1Vnyxcd8HfEOg5qiQ14
         ai0TPA5hFo6U0BA4vLmW6u1whlaGPzsdSJq5dvnea7OzB9ji2i0moiN5YsjW3hCAgj9D
         c61VPWVx82afStV32iPEynyZkqyBtiP1DlERk+DNMPg2pABfmTgxlBJCFDnT872VSGBV
         RYdg==
X-Forwarded-Encrypted: i=1; AJvYcCXN5lzi12wn23z2YYAIu+2z4lQexI5YPUpPyCpaprbgWRn3eI3PuoOU2EOStv0dMr3lVVdkj4JtKazZbUa5/KYfb7NnONiMS8KigG/K
X-Gm-Message-State: AOJu0YxnyyMWrMLlK4vD1Vt6oXdaSOj98U+EPCfDavfU2obmZ9wDY8eZ
	d36wvNls9PIUeAyP2xkoK0uqYh5zSXVALY0qbypVBrX6wMgkr6RzOkj6y8vnwwKhlocA3Gei2WB
	rGi8H9T3eapK1we7Rm7Lv7AYTRNQ=
X-Google-Smtp-Source: AGHT+IEp3nz2cb2A/wAMV4V2iVSMB5XIwdoWzJxBFCKJc0T4AW2hkoolYglVM+sLPe+0iIb/mwjdTPSIKv7T9Z06+u0=
X-Received: by 2002:a05:6122:d8e:b0:4d8:74cb:e3c2 with SMTP id
 bc14-20020a0561220d8e00b004d874cbe3c2mr9379297vkb.9.1713234979213; Mon, 15
 Apr 2024 19:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-5-21cnbao@gmail.com>
 <87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
 <8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 16 Apr 2024 14:36:08 +1200
Message-ID: <CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:27=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
>
> Added Khalid for arch_do_swap_page().
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
>
> [snip]
>
> >>
> >> > +     bool any_swap_shared =3D false;
> >> >
> >> >       if (!pte_unmap_same(vmf))
> >> >               goto out;
> >> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >        */
> >> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->ad=
dress,
> >> >                       &vmf->ptl);
> >>
> >> We should move pte check here.  That is,
> >>
> >>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->o=
rig_pte)))
> >>                 goto out_nomap;
> >>
> >> This will simplify the situation for large folio.
> >
> > the plan is moving the whole code block
> >
> > if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio)=
)
> >
> > after
> >         if (unlikely(!folio_test_uptodate(folio))) {
> >                 ret =3D VM_FAULT_SIGBUS;
> >                 goto out_nomap;
> >         }
> >
> > though we couldn't be !folio_test_uptodate(folio)) for hitting
> > swapcache but it seems
> > logically better for future use.
>
> LGTM, Thanks!
>
> >>
> >> > +
> >> > +     /* We hit large folios in swapcache */
> >>
> >> The comments seems unnecessary because the code tells that already.
> >>
> >> > +     if (start_pte && folio_test_large(folio) && folio_test_swapcac=
he(folio)) {
> >> > +             int nr =3D folio_nr_pages(folio);
> >> > +             int idx =3D folio_page_idx(folio, page);
> >> > +             unsigned long folio_start =3D vmf->address - idx * PAG=
E_SIZE;
> >> > +             unsigned long folio_end =3D folio_start + nr * PAGE_SI=
ZE;
> >> > +             pte_t *folio_ptep;
> >> > +             pte_t folio_pte;
> >> > +
> >> > +             if (unlikely(folio_start < max(vmf->address & PMD_MASK=
, vma->vm_start)))
> >> > +                     goto check_pte;
> >> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vm=
a->vm_end)))
> >> > +                     goto check_pte;
> >> > +
> >> > +             folio_ptep =3D vmf->pte - idx;
> >> > +             folio_pte =3D ptep_get(folio_ptep);
> >>
> >> It's better to construct pte based on fault PTE via generalizing
> >> pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we can fin=
d
> >> inconsistent PTEs quicker.
> >
> > it seems your point is getting the pte of page0 by pte_next_swp_offset(=
)
> > unfortunately pte_next_swp_offset can't go back. on the other hand,
> > we have to check the real pte value of the 0nd entry right now because
> > swap_pte_batch() only really reads pte from the 1st entry. it assumes
> > pte argument is the real value for the 0nd pte entry.
> >
> > static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t p=
te)
> > {
> >         pte_t expected_pte =3D pte_next_swp_offset(pte);
> >         const pte_t *end_ptep =3D start_ptep + max_nr;
> >         pte_t *ptep =3D start_ptep + 1;
> >
> >         VM_WARN_ON(max_nr < 1);
> >         VM_WARN_ON(!is_swap_pte(pte));
> >         VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
> >
> >         while (ptep < end_ptep) {
> >                 pte =3D ptep_get(ptep);
> >
> >                 if (!pte_same(pte, expected_pte))
> >                         break;
> >
> >                 expected_pte =3D pte_next_swp_offset(expected_pte);
> >                 ptep++;
> >         }
> >
> >         return ptep - start_ptep;
> > }
>
> Yes.  You are right.
>
> But we may check whether the pte of page0 is same as "vmf->orig_pte -
> folio_page_idx()" (fake code).

right, that is why we are reading and checking PTE0 before calling
swap_pte_batch()
right now.

  folio_ptep =3D vmf->pte - idx;
  folio_pte =3D ptep_get(folio_ptep);
  if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio_pte)=
) ||
      swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_shared) !=3D nr)
   goto check_pte;

So, if I understand correctly, you're proposing that we should directly che=
ck
PTE0 in swap_pte_batch(). Personally, I don't have any objections to this i=
dea.
However, I'd also like to hear the feedback from Ryan and David :-)

>
> You need to check the pte of page 0 anyway.
>
> >>
> >> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_s=
wp_entry(folio_pte)) ||
> >> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &any_swa=
p_shared) !=3D nr)
> >> > +                     goto check_pte;
> >> > +
> >> > +             start_address =3D folio_start;
> >> > +             start_pte =3D folio_ptep;
> >> > +             nr_pages =3D nr;
> >> > +             entry =3D folio->swap;
> >> > +             page =3D &folio->page;
> >> > +     }
> >> > +
> >> > +check_pte:
> >> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->o=
rig_pte)))
> >> >               goto out_nomap;
> >> >
> >> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >                        */
> >> >                       exclusive =3D false;
> >> >               }
> >> > +
> >> > +             /* Reuse the whole large folio iff all entries are exc=
lusive */
> >> > +             if (nr_pages > 1 && any_swap_shared)
> >> > +                     exclusive =3D false;
> >> >       }
> >> >
> >> >       /*
> >> > @@ -4204,12 +4241,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >> >        * We're already holding a reference on the page but haven't m=
apped it
> >> >        * yet.
> >> >        */
> >> > -     swap_free(entry);
> >> > +     swap_free_nr(entry, nr_pages);
> >> >       if (should_try_to_free_swap(folio, vma, vmf->flags))
> >> >               folio_free_swap(folio);
> >> >
> >> > -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >> > -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >> > +     folio_ref_add(folio, nr_pages - 1);
> >> > +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >> > +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >> > +
> >> >       pte =3D mk_pte(page, vma->vm_page_prot);
> >> >
> >> >       /*
> >> > @@ -4219,33 +4258,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >> >        * exclusivity.
> >> >        */
> >> >       if (!folio_test_ksm(folio) &&
> >> > -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >> > +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> >> > +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
> >> >               if (vmf->flags & FAULT_FLAG_WRITE) {
> >> >                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >> >                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >> >               }
> >> >               rmap_flags |=3D RMAP_EXCLUSIVE;
> >> >       }
> >> > -     flush_icache_page(vma, page);
> >> > +     flush_icache_pages(vma, page, nr_pages);
> >> >       if (pte_swp_soft_dirty(vmf->orig_pte))
> >> >               pte =3D pte_mksoft_dirty(pte);
> >> >       if (pte_swp_uffd_wp(vmf->orig_pte))
> >> >               pte =3D pte_mkuffd_wp(pte);
> >> > -     vmf->orig_pte =3D pte;
> >> >
> >> >       /* ksm created a completely new copy */
> >> >       if (unlikely(folio !=3D swapcache && swapcache)) {
> >> > -             folio_add_new_anon_rmap(folio, vma, vmf->address);
> >> > +             folio_add_new_anon_rmap(folio, vma, start_address);
> >> >               folio_add_lru_vma(folio, vma);
> >> >       } else {
> >> > -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address=
,
> >> > -                                     rmap_flags);
> >> > +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, s=
tart_address,
> >> > +                                      rmap_flags);
> >> >       }
> >> >
> >> >       VM_BUG_ON(!folio_test_anon(folio) ||
> >> >                       (pte_write(pte) && !PageAnonExclusive(page)));
> >> > -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> >> > -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->ori=
g_pte);
> >> > +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> >> > +     vmf->orig_pte =3D ptep_get(vmf->pte);
> >> > +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
> >>
> >> Do we need to call arch_do_swap_page() for each subpage?  IIUC, the
> >> corresponding arch_unmap_one() will be called for each subpage.
> >
> > i actually thought about this very carefully, right now, the only one w=
ho
> > needs this is sparc and it doesn't support THP_SWAPOUT at all. and
> > there is no proof doing restoration one by one won't really break sparc=
.
> > so i'd like to defer this to when sparc really needs THP_SWAPOUT.
>
> Let's ask SPARC developer (Cced) for this.
>
> IMHO, even if we cannot get help, we need to change code with our
> understanding instead of deferring it.

ok. Thanks for Ccing sparc developers.

>
> > on the other hand, it seems really bad we have both
> > arch_swap_restore  - for this, arm64 has moved to using folio
> > and
> > arch_do_swap_page
> >
> > we should somehow unify them later if sparc wants THP_SWPOUT.
> >
> >>
> >> >       folio_unlock(folio);
> >> >       if (folio !=3D swapcache && swapcache) {
> >> > @@ -4269,7 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >       }
> >> >
> >> >       /* No need to invalidate - it was non-present before */
> >> > -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> >> > +     update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_=
pages);
> >> >  unlock:
> >> >       if (vmf->pte)
> >> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

