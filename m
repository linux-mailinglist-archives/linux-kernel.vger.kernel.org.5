Return-Path: <linux-kernel+bounces-146125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D68A6109
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AAE6B21B17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152211C83;
	Tue, 16 Apr 2024 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItsGOAfq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24261400A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234448; cv=none; b=HI2Ib1fJNOe7JoJGNPeO4MjtBcZv6yhJQEy5i9RE+/oaOBvHIv/ck3RgXUFR1c0EdoFotwiClQTlFJgRSKpunDlHdeO0S5oHyO8Et1ZX4fayq+1RSYCpEYpSYxnwK0hpa5JXOFFHbfDdKanXMDfsJb+Mh7qGR9DdFcfJkoc19p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234448; c=relaxed/simple;
	bh=OKWSvDO+q6Qz+jQcpTX6IWn2EWSBS83MXyqzFUsaTug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iyd/vJ5KFls38vABVvtk1rD8dmfOrXF5ac+ORw/0yZlBNaoQ+2lPz0ziwtxtoqQBGDBkJycOiyvur0tBSN14pQSIcDTI5OpcgCacxApAKyaiQMcR4nNLGucOPCYOliuliZs1rUZYlZlPP0dyCRPaa8GPQirHxdZv50u+9gPMDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItsGOAfq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713234447; x=1744770447;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=OKWSvDO+q6Qz+jQcpTX6IWn2EWSBS83MXyqzFUsaTug=;
  b=ItsGOAfqo3YFeLW4UGZmsUqL0mWYwaCT172RVe0hTJjboKlneVhd9U0R
   h9DV2kibAYzVaYqkBOhn7AIs45NQH0B8UAaKlO9bTN2L5thrPqDuJag7X
   qjlf0fcrfuYCIV9zZqtrFSUMq83Fnnz3UHzCVC7qyWpY+53+VRzsm+Ip4
   Qx23QirZihRVvhIBHQUoYQdufFiwhwakqyUX5H953r7fFXWhBF9o31zHp
   aqKcVA06EkqunK446EUq1L1zotxaLzgqDU0NZKzKUInltV2F+BcwaQb6k
   zf5pQtK7Ziyn1MVz259rAzkOpc+po0dCpThdfzGx3Z6U97lKxcJG7IFIQ
   g==;
X-CSE-ConnectionGUID: rYTlmD4GRQOy8mGYEjO9ew==
X-CSE-MsgGUID: 9MTrHlMKRvu6jLR8al+oCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="11595350"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="11595350"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:27:26 -0700
X-CSE-ConnectionGUID: wOa/CSkCR+OOCqOgWjFYlA==
X-CSE-MsgGUID: R8Ojtr1xTkWny5SomzSv8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26888492"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:27:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in
 swapcache
In-Reply-To: <CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
	(Barry Song's message of "Mon, 15 Apr 2024 20:53:53 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-5-21cnbao@gmail.com>
	<87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
Date: Tue, 16 Apr 2024 10:25:28 +0800
Message-ID: <8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Added Khalid for arch_do_swap_page().

Barry Song <21cnbao@gmail.com> writes:

> On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:

[snip]

>>
>> > +     bool any_swap_shared =3D false;
>> >
>> >       if (!pte_unmap_same(vmf))
>> >               goto out;
>> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >        */
>> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->addr=
ess,
>> >                       &vmf->ptl);
>>
>> We should move pte check here.  That is,
>>
>>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->ori=
g_pte)))
>>                 goto out_nomap;
>>
>> This will simplify the situation for large folio.
>
> the plan is moving the whole code block
>
> if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio))
>
> after
>         if (unlikely(!folio_test_uptodate(folio))) {
>                 ret =3D VM_FAULT_SIGBUS;
>                 goto out_nomap;
>         }
>
> though we couldn't be !folio_test_uptodate(folio)) for hitting
> swapcache but it seems
> logically better for future use.

LGTM, Thanks!

>>
>> > +
>> > +     /* We hit large folios in swapcache */
>>
>> The comments seems unnecessary because the code tells that already.
>>
>> > +     if (start_pte && folio_test_large(folio) && folio_test_swapcache=
(folio)) {
>> > +             int nr =3D folio_nr_pages(folio);
>> > +             int idx =3D folio_page_idx(folio, page);
>> > +             unsigned long folio_start =3D vmf->address - idx * PAGE_=
SIZE;
>> > +             unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
>> > +             pte_t *folio_ptep;
>> > +             pte_t folio_pte;
>> > +
>> > +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, =
vma->vm_start)))
>> > +                     goto check_pte;
>> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma-=
>vm_end)))
>> > +                     goto check_pte;
>> > +
>> > +             folio_ptep =3D vmf->pte - idx;
>> > +             folio_pte =3D ptep_get(folio_ptep);
>>
>> It's better to construct pte based on fault PTE via generalizing
>> pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we can find
>> inconsistent PTEs quicker.
>
> it seems your point is getting the pte of page0 by pte_next_swp_offset()
> unfortunately pte_next_swp_offset can't go back. on the other hand,
> we have to check the real pte value of the 0nd entry right now because
> swap_pte_batch() only really reads pte from the 1st entry. it assumes
> pte argument is the real value for the 0nd pte entry.
>
> static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
> {
>         pte_t expected_pte =3D pte_next_swp_offset(pte);
>         const pte_t *end_ptep =3D start_ptep + max_nr;
>         pte_t *ptep =3D start_ptep + 1;
>
>         VM_WARN_ON(max_nr < 1);
>         VM_WARN_ON(!is_swap_pte(pte));
>         VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
>
>         while (ptep < end_ptep) {
>                 pte =3D ptep_get(ptep);
>
>                 if (!pte_same(pte, expected_pte))
>                         break;
>
>                 expected_pte =3D pte_next_swp_offset(expected_pte);
>                 ptep++;
>         }
>
>         return ptep - start_ptep;
> }

Yes.  You are right.

But we may check whether the pte of page0 is same as "vmf->orig_pte -
folio_page_idx()" (fake code).

You need to check the pte of page 0 anyway.

>>
>> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp=
_entry(folio_pte)) ||
>> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_=
shared) !=3D nr)
>> > +                     goto check_pte;
>> > +
>> > +             start_address =3D folio_start;
>> > +             start_pte =3D folio_ptep;
>> > +             nr_pages =3D nr;
>> > +             entry =3D folio->swap;
>> > +             page =3D &folio->page;
>> > +     }
>> > +
>> > +check_pte:
>> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->ori=
g_pte)))
>> >               goto out_nomap;
>> >
>> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >                        */
>> >                       exclusive =3D false;
>> >               }
>> > +
>> > +             /* Reuse the whole large folio iff all entries are exclu=
sive */
>> > +             if (nr_pages > 1 && any_swap_shared)
>> > +                     exclusive =3D false;
>> >       }
>> >
>> >       /*
>> > @@ -4204,12 +4241,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >        * We're already holding a reference on the page but haven't map=
ped it
>> >        * yet.
>> >        */
>> > -     swap_free(entry);
>> > +     swap_free_nr(entry, nr_pages);
>> >       if (should_try_to_free_swap(folio, vma, vmf->flags))
>> >               folio_free_swap(folio);
>> >
>> > -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>> > -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>> > +     folio_ref_add(folio, nr_pages - 1);
>> > +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>> > +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>> > +
>> >       pte =3D mk_pte(page, vma->vm_page_prot);
>> >
>> >       /*
>> > @@ -4219,33 +4258,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >        * exclusivity.
>> >        */
>> >       if (!folio_test_ksm(folio) &&
>> > -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
>> > +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
>> > +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
>> >               if (vmf->flags & FAULT_FLAG_WRITE) {
>> >                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
>> >                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
>> >               }
>> >               rmap_flags |=3D RMAP_EXCLUSIVE;
>> >       }
>> > -     flush_icache_page(vma, page);
>> > +     flush_icache_pages(vma, page, nr_pages);
>> >       if (pte_swp_soft_dirty(vmf->orig_pte))
>> >               pte =3D pte_mksoft_dirty(pte);
>> >       if (pte_swp_uffd_wp(vmf->orig_pte))
>> >               pte =3D pte_mkuffd_wp(pte);
>> > -     vmf->orig_pte =3D pte;
>> >
>> >       /* ksm created a completely new copy */
>> >       if (unlikely(folio !=3D swapcache && swapcache)) {
>> > -             folio_add_new_anon_rmap(folio, vma, vmf->address);
>> > +             folio_add_new_anon_rmap(folio, vma, start_address);
>> >               folio_add_lru_vma(folio, vma);
>> >       } else {
>> > -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
>> > -                                     rmap_flags);
>> > +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, sta=
rt_address,
>> > +                                      rmap_flags);
>> >       }
>> >
>> >       VM_BUG_ON(!folio_test_anon(folio) ||
>> >                       (pte_write(pte) && !PageAnonExclusive(page)));
>> > -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>> > -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_=
pte);
>> > +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
>> > +     vmf->orig_pte =3D ptep_get(vmf->pte);
>> > +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
>>
>> Do we need to call arch_do_swap_page() for each subpage?  IIUC, the
>> corresponding arch_unmap_one() will be called for each subpage.
>
> i actually thought about this very carefully, right now, the only one who
> needs this is sparc and it doesn't support THP_SWAPOUT at all. and
> there is no proof doing restoration one by one won't really break sparc.
> so i'd like to defer this to when sparc really needs THP_SWAPOUT.

Let's ask SPARC developer (Cced) for this.

IMHO, even if we cannot get help, we need to change code with our
understanding instead of deferring it.

> on the other hand, it seems really bad we have both
> arch_swap_restore  - for this, arm64 has moved to using folio
> and
> arch_do_swap_page
>
> we should somehow unify them later if sparc wants THP_SWPOUT.
>
>>
>> >       folio_unlock(folio);
>> >       if (folio !=3D swapcache && swapcache) {
>> > @@ -4269,7 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       }
>> >
>> >       /* No need to invalidate - it was non-present before */
>> > -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>> > +     update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pa=
ges);
>> >  unlock:
>> >       if (vmf->pte)
>> >               pte_unmap_unlock(vmf->pte, vmf->ptl);

--
Best Regards,
Huang, Ying

