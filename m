Return-Path: <linux-kernel+bounces-141713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8177F8A224C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF508B21490
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52423481C0;
	Thu, 11 Apr 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an4rGEIt"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8309224FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878225; cv=none; b=Z2UL+CP06JoSBH4agjOT5WTS6KtBzCFHbIOJvJ3odBZEmDh0Mho36dDRKWnevOz8VOh0mEtCjFLMiHQUeZiCOeGEB2WBpXtNXevoR+yDQY4vHjlV4ib4ptvkD0SDd+Ir0LHFan1FiOexfcj9rpoErFNgevylItPJ4K8CEhn3c4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878225; c=relaxed/simple;
	bh=KgEx7reX3m2HXQbpm5aWA51XsiEKkfUpeaYk0+pFyFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+NMPNJEs5bZK7vyZAGsP03K2PsTCgnPoibt0iXx91kXwGKvgY/f7w4NEXsvUgpdmLzE+Qs1Rqio7AM3GiHXguytyn4mX0scPHW/2KxIhanaKHD9ebIKD1lDdg1GyLVgRGgbskyGSOQycilkSzD8sOUGH4JySpzokEP8sWtNSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an4rGEIt; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so92445241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878222; x=1713483022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX95sbNIGqEL2oXbznTMfqgObAXwNNFvu8ksu6wMXdA=;
        b=an4rGEItFoi6ZYHWXBxPA6OqIrZeRPDX9RTuS9Mo23Luy35zNdIi5pguu0om5+VlaR
         3mpqI1FMbzmio5AL7mozb7P79qPxVESEC/cZqAECkwFTVjWjqKxfxpVKT+uswiL5kZjY
         aorjvtFrdkZosA2FW45vjHQyq/q1fxVpYtQdhnEYSOFxWSUpjDVQljQRPmJVsctBwPiA
         gwh/rDKGr4U7Xwqr6tRYSEq84UbY1uxuWDRJ+b6g9hHdI8B73lB/MMxp4QrMMsAd8B4f
         uWgkO33Cm2xSbnvH0oTmUKp4k9Pqs5OVMCgPGVlciAtW2z1Y1zal6o0RcBchOmG3dIya
         YMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878222; x=1713483022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX95sbNIGqEL2oXbznTMfqgObAXwNNFvu8ksu6wMXdA=;
        b=tCuvu2EnpIU9IVNA48jzXTCCvRYxVAS+E6BG7Bs9NLGJQHUwDeLHg4SyMAIH2qd+ct
         6FnnqPgL3aZBtxQ+Mfhow3s1LDV6Z38zSycbfuyn//ZmoutiNa3pXXUXrn8f9CvGwHp1
         Q/8OABGFgLiRsh6FSTUOKVs3RZDqupbFn100gOW2l0S/dvA481hGyGB1vBtLcFelh76/
         lHFYwxvIm/LBoPd3V1okD1PWOraTnq6TAEl617mfZLdK7Oa50IkR5DTtD6uhgAR41Q+d
         StfzYjPhsFx6TzimmhRW0aUbL75ci+qzNbkxU+5ZuUMWizGFKtad2CXayxlAEIqN7Ofs
         JJDw==
X-Forwarded-Encrypted: i=1; AJvYcCW+eeXat/je8AoFoOD2zpBhS27JQyPfqXtiYvZKIPl3uVzKTDBi6RF2FJUGwsOsCehSgpCaGH8qAiqlu70bmwTzOjm2/MKfKbADJ3Zs
X-Gm-Message-State: AOJu0YyRmLwt7xmvH+xcqUg54hAA7WYv9v4+XK8HYQNds73nMFntY3Xu
	Ya9eBJdKpUBBsd3TnRtoie7BNar2X/It8+Yk2UcuI02Jq/ckc8JN+I2paQFab/ihS3Cn7pzaVQ7
	pBgUmSE1MYWbn/6SYf8u82ZTUChc=
X-Google-Smtp-Source: AGHT+IG65nLyjXLTbizTwC9fB1uaqNkf/57nOGQ72lR25Qet0x65uQYMsbI6qyHYcifWEbnoJP/O8gsqgofdOVgk3lU=
X-Received: by 2002:a05:6122:4687:b0:4d4:2fbc:e61f with SMTP id
 di7-20020a056122468700b004d42fbce61fmr1242301vkb.14.1712878222538; Thu, 11
 Apr 2024 16:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-5-21cnbao@gmail.com>
 <1008d688-757a-4c2d-86bd-793f5e787d30@arm.com>
In-Reply-To: <1008d688-757a-4c2d-86bd-793f5e787d30@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 11:30:10 +1200
Message-ID: <CAGsJ_4wqXFcS=WnfTSuS1osPh-NGtUF_izA2U3VVEv3wEhsudA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in swapcache
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:33=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 09/04/2024 09:26, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > When a large folio is found in the swapcache, the current implementatio=
n
> > requires calling do_swap_page() nr_pages times, resulting in nr_pages
> > page faults. This patch opts to map the entire large folio at once to
> > minimize page faults. Additionally, redundant checks and early exits
> > for ARM64 MTE restoring are removed.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/memory.c | 64 +++++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 52 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c4a52e8d740a..9818dc1893c8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3947,6 +3947,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> >       void *shadow =3D NULL;
> > +     int nr_pages =3D 1;
> > +     unsigned long start_address =3D vmf->address;
> > +     pte_t *start_pte =3D vmf->pte;
>
> possible bug?: there are code paths that assign to vmf-pte below in this
> function, so couldn't start_pte be stale in some cases? I'd just do the
> assignment (all 4 of these variables in fact) in an else clause below, af=
ter any
> messing about with them is complete.
>
> nit: rename start_pte -> start_ptep ?

Agreed.

>
> > +     bool any_swap_shared =3D false;
>
> Suggest you defer initialization of this to your "We hit large folios in
> swapcache" block below, and init it to:
>
>         any_swap_shared =3D !pte_swp_exclusive(vmf->pte);
>
> Then the any_shared semantic in swap_pte_batch() can be the same as for
> folio_pte_batch().
>
> >
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        */
> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->addre=
ss,
> >                       &vmf->ptl);
>
> bug: vmf->pte may be NULL and you are not checking it until check_pte:. B=
yt you
> are using it in this block. It also seems odd to do all the work in the b=
elow
> block under the PTL but before checking if the pte has changed. Suggest m=
oving
> both checks here.

agreed.

>
> > +
> > +     /* We hit large folios in swapcache */
> > +     if (start_pte && folio_test_large(folio) && folio_test_swapcache(=
folio)) {
>
> What's the start_pte check protecting?

This is exactly protecting the case vmf->pte=3D=3DNULL but for some reason =
it was
assigned in the beginning of the function incorrectly. The intention of the=
 code
was actually doing start_pte =3D vmf->pte after "vmf->pte =3D pte_offset_ma=
p_lock".

>
> > +             int nr =3D folio_nr_pages(folio);
> > +             int idx =3D folio_page_idx(folio, page);
> > +             unsigned long folio_start =3D vmf->address - idx * PAGE_S=
IZE;
> > +             unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
> > +             pte_t *folio_ptep;
> > +             pte_t folio_pte;
> > +
> > +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, v=
ma->vm_start)))
> > +                     goto check_pte;
> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->=
vm_end)))
> > +                     goto check_pte;
> > +
> > +             folio_ptep =3D vmf->pte - idx;
> > +             folio_pte =3D ptep_get(folio_ptep);
> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_=
entry(folio_pte)) ||
> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_s=
hared) !=3D nr)
> > +                     goto check_pte;
> > +
> > +             start_address =3D folio_start;
> > +             start_pte =3D folio_ptep;
> > +             nr_pages =3D nr;
> > +             entry =3D folio->swap;
> > +             page =3D &folio->page;
> > +     }
> > +
> > +check_pte:
> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig=
_pte)))
> >               goto out_nomap;
> >
> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                        */
> >                       exclusive =3D false;
> >               }
> > +
> > +             /* Reuse the whole large folio iff all entries are exclus=
ive */
> > +             if (nr_pages > 1 && any_swap_shared)
> > +                     exclusive =3D false;
>
> If you init any_shared with the firt pte as I suggested then you could ju=
st set
> exclusive =3D !any_shared at the top of this if block without needing thi=
s
> separate fixup.

Since your swap_pte_batch() function checks that all PTEs have the same
exclusive bits, I'll be removing any_shared first in version 3 per David's
suggestions. We could potentially develop "any_shared" as an incremental
patchset later on .

> >       }
> >
> >       /*
> > @@ -4204,12 +4241,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * We're already holding a reference on the page but haven't mapp=
ed it
> >        * yet.
> >        */
> > -     swap_free(entry);
> > +     swap_free_nr(entry, nr_pages);
> >       if (should_try_to_free_swap(folio, vma, vmf->flags))
> >               folio_free_swap(folio);
> >
> > -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > +     folio_ref_add(folio, nr_pages - 1);
> > +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > +
> >       pte =3D mk_pte(page, vma->vm_page_prot);
> >
> >       /*
> > @@ -4219,33 +4258,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * exclusivity.
> >        */
> >       if (!folio_test_ksm(folio) &&
> > -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> > +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
> >               if (vmf->flags & FAULT_FLAG_WRITE) {
> >                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >               }
> >               rmap_flags |=3D RMAP_EXCLUSIVE;
> >       }
> > -     flush_icache_page(vma, page);
> > +     flush_icache_pages(vma, page, nr_pages);
> >       if (pte_swp_soft_dirty(vmf->orig_pte))
> >               pte =3D pte_mksoft_dirty(pte);
> >       if (pte_swp_uffd_wp(vmf->orig_pte))
> >               pte =3D pte_mkuffd_wp(pte);
>
> I'm not sure about all this... you are smearing these SW bits from the fa=
ulting
> PTE across all the ptes you are mapping. Although I guess actually that's=
 ok
> because swap_pte_batch() only returns a batch with all these bits the sam=
e?

Initially, I didn't recognize the issue at all because the tested
architecture arm64
didn't include these bits. However, after reviewing your latest swpout seri=
es,
which verifies the consistent bits for soft_dirty and uffd_wp, I now
feel  its safety
even for platforms with these bits.

>
> > -     vmf->orig_pte =3D pte;
>
> Instead of doing a readback below, perhaps:
>
>         vmf->orig_pte =3D pte_advance_pfn(pte, nr_pages);

Nice !

>
> >
> >       /* ksm created a completely new copy */
> >       if (unlikely(folio !=3D swapcache && swapcache)) {
> > -             folio_add_new_anon_rmap(folio, vma, vmf->address);
> > +             folio_add_new_anon_rmap(folio, vma, start_address);
> >               folio_add_lru_vma(folio, vma);
> >       } else {
> > -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> > -                                     rmap_flags);
> > +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, star=
t_address,
> > +                                      rmap_flags);
> >       }
> >
> >       VM_BUG_ON(!folio_test_anon(folio) ||
> >                       (pte_write(pte) && !PageAnonExclusive(page)));
> > -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> > +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> > +     vmf->orig_pte =3D ptep_get(vmf->pte);
> > +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
> >
> >       folio_unlock(folio);
> >       if (folio !=3D swapcache && swapcache) {
> > @@ -4269,7 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       }
> >
> >       /* No need to invalidate - it was non-present before */
> > -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> > +     update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pag=
es);
> >  unlock:
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
>

Thanks
Barry

