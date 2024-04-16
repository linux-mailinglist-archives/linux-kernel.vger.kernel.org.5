Return-Path: <linux-kernel+bounces-146155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F68A6180
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FA61F21437
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FD179B7;
	Tue, 16 Apr 2024 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHwOYhMg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4A12E4A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237592; cv=none; b=K30DGuR//LetXctiWu4xTSMGxzE5WoPJBBD6Ca0y9m/YiJWGAxMORnbujf4aDCr8GZVaqgb7l40BcmApw6TBWnhl1dAuI1kyzMsq8pFhH0bGN/QPrVO2T/CNGnnfm13TMZs8Chh/q8xFNkgcM/v5EjPMRMhYn/8bUUYl0fxmrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237592; c=relaxed/simple;
	bh=bEdnLUm5EDdzPFP61fhX407TIyf0cdbPD+9lgM1dHX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXaE4McWWe+UagBG/3EFJVAkBk5WiYdx8T3VTrApeVBMAu+X7iVhVF3/Cq6NCJZwKq6pUfkcjpKLjWVXx6pDAQ/7UVdsGehj4e07jIjnaRuKSwpEaM/3CkcDekJ4dhJ6KYa8uray6IXe8KqI+3IK5UhFSZnZ3jNpih1s9W80Xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHwOYhMg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237590; x=1744773590;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=bEdnLUm5EDdzPFP61fhX407TIyf0cdbPD+9lgM1dHX8=;
  b=XHwOYhMghog9FpXwXStMG6mKX2eSU+Ldm/s9iZ9u27p+Sg8tO0s1BjoW
   ZSi7E8gFoQNUv1QE/Yo2+jSL9aqI2ro86ua3hotFHSLxfQnpWU42LVId0
   1amY/7v2C7Cxby/tzKlSVshRoH+lojQZGmwY39BGpNuUFPvK6ZJEVyIkh
   ZvsWbTenybG5HFo31i3HMhBny76kWEBll/rAKZromsqFl0OQFTRngfhD7
   +7JRWI8N+w3G+fnObdvLwoXyHCy1T2Waz9O27EauL11IFfoRzOJexxiPl
   irn9QTdwRmcIC4I9bysdcOi1UsveSnpNiEysmHR6tXpzoF8UQNp0wlBEf
   A==;
X-CSE-ConnectionGUID: ++jHvn/xT1ecNEKTZF125g==
X-CSE-MsgGUID: MpXizW8oQ4+ql3sY5A8KCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12443194"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="12443194"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:19:49 -0700
X-CSE-ConnectionGUID: 3zaIK+QRSBm+gCqMmmVwsg==
X-CSE-MsgGUID: 5967b8lWTRKxRf4cAmYCmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22190042"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:19:45 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,
  david@redhat.com,  hanchuanhua@oppo.com,  hannes@cmpxchg.org,
  hughd@google.com,  kasong@tencent.com,  ryan.roberts@arm.com,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  xiang@kernel.org,  yosryahmed@google.com,  yuzhao@google.com,
  ziy@nvidia.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in
 swapcache
In-Reply-To: <CAGsJ_4xUna=wNNoLw0yCkzjD1d0pfJDKfqmWuA5zrSzWF+-cow@mail.gmail.com>
	(Barry Song's message of "Tue, 16 Apr 2024 14:52:24 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-5-21cnbao@gmail.com>
	<87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
	<8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
	<87y19e115l.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xUna=wNNoLw0yCkzjD1d0pfJDKfqmWuA5zrSzWF+-cow@mail.gmail.com>
Date: Tue, 16 Apr 2024 11:17:52 +0800
Message-ID: <87pluq0zdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Tue, Apr 16, 2024 at 2:41=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Tue, Apr 16, 2024 at 2:27=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >>
>> >> Added Khalid for arch_do_swap_page().
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> [snip]
>> >>
>> >> >>
>> >> >> > +     bool any_swap_shared =3D false;
>> >> >> >
>> >> >> >       if (!pte_unmap_same(vmf))
>> >> >> >               goto out;
>> >> >> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *=
vmf)
>> >> >> >        */
>> >> >> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf=
->address,
>> >> >> >                       &vmf->ptl);
>> >> >>
>> >> >> We should move pte check here.  That is,
>> >> >>
>> >> >>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vm=
f->orig_pte)))
>> >> >>                 goto out_nomap;
>> >> >>
>> >> >> This will simplify the situation for large folio.
>> >> >
>> >> > the plan is moving the whole code block
>> >> >
>> >> > if (start_pte && folio_test_large(folio) && folio_test_swapcache(fo=
lio))
>> >> >
>> >> > after
>> >> >         if (unlikely(!folio_test_uptodate(folio))) {
>> >> >                 ret =3D VM_FAULT_SIGBUS;
>> >> >                 goto out_nomap;
>> >> >         }
>> >> >
>> >> > though we couldn't be !folio_test_uptodate(folio)) for hitting
>> >> > swapcache but it seems
>> >> > logically better for future use.
>> >>
>> >> LGTM, Thanks!
>> >>
>> >> >>
>> >> >> > +
>> >> >> > +     /* We hit large folios in swapcache */
>> >> >>
>> >> >> The comments seems unnecessary because the code tells that already.
>> >> >>
>> >> >> > +     if (start_pte && folio_test_large(folio) && folio_test_swa=
pcache(folio)) {
>> >> >> > +             int nr =3D folio_nr_pages(folio);
>> >> >> > +             int idx =3D folio_page_idx(folio, page);
>> >> >> > +             unsigned long folio_start =3D vmf->address - idx *=
 PAGE_SIZE;
>> >> >> > +             unsigned long folio_end =3D folio_start + nr * PAG=
E_SIZE;
>> >> >> > +             pte_t *folio_ptep;
>> >> >> > +             pte_t folio_pte;
>> >> >> > +
>> >> >> > +             if (unlikely(folio_start < max(vmf->address & PMD_=
MASK, vma->vm_start)))
>> >> >> > +                     goto check_pte;
>> >> >> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address=
, vma->vm_end)))
>> >> >> > +                     goto check_pte;
>> >> >> > +
>> >> >> > +             folio_ptep =3D vmf->pte - idx;
>> >> >> > +             folio_pte =3D ptep_get(folio_ptep);
>> >> >>
>> >> >> It's better to construct pte based on fault PTE via generalizing
>> >> >> pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we can=
 find
>> >> >> inconsistent PTEs quicker.
>> >> >
>> >> > it seems your point is getting the pte of page0 by pte_next_swp_off=
set()
>> >> > unfortunately pte_next_swp_offset can't go back. on the other hand,
>> >> > we have to check the real pte value of the 0nd entry right now beca=
use
>> >> > swap_pte_batch() only really reads pte from the 1st entry. it assum=
es
>> >> > pte argument is the real value for the 0nd pte entry.
>> >> >
>> >> > static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte=
_t pte)
>> >> > {
>> >> >         pte_t expected_pte =3D pte_next_swp_offset(pte);
>> >> >         const pte_t *end_ptep =3D start_ptep + max_nr;
>> >> >         pte_t *ptep =3D start_ptep + 1;
>> >> >
>> >> >         VM_WARN_ON(max_nr < 1);
>> >> >         VM_WARN_ON(!is_swap_pte(pte));
>> >> >         VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
>> >> >
>> >> >         while (ptep < end_ptep) {
>> >> >                 pte =3D ptep_get(ptep);
>> >> >
>> >> >                 if (!pte_same(pte, expected_pte))
>> >> >                         break;
>> >> >
>> >> >                 expected_pte =3D pte_next_swp_offset(expected_pte);
>> >> >                 ptep++;
>> >> >         }
>> >> >
>> >> >         return ptep - start_ptep;
>> >> > }
>> >>
>> >> Yes.  You are right.
>> >>
>> >> But we may check whether the pte of page0 is same as "vmf->orig_pte -
>> >> folio_page_idx()" (fake code).
>> >
>> > right, that is why we are reading and checking PTE0 before calling
>> > swap_pte_batch()
>> > right now.
>> >
>> >   folio_ptep =3D vmf->pte - idx;
>> >   folio_pte =3D ptep_get(folio_ptep);
>> >   if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio=
_pte)) ||
>> >       swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_shared) !=3D=
 nr)
>> >    goto check_pte;
>> >
>> > So, if I understand correctly, you're proposing that we should directl=
y check
>> > PTE0 in swap_pte_batch(). Personally, I don't have any objections to t=
his idea.
>> > However, I'd also like to hear the feedback from Ryan and David :-)
>>
>> I mean that we can replace
>>
>>         !is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio=
_pte))
>>
>> in above code with pte_same() with constructed expected first pte.
>
> Got it. It could be quite tricky, especially with considerations like
> pte_swp_soft_dirty, pte_swp_exclusive, and pte_swp_uffd_wp. We might
> require a helper function similar to pte_next_swp_offset() but capable of
> moving both forward and backward. For instance:
>
> pte_move_swp_offset(pte_t pte, long delta)
>
> pte_next_swp_offset can insteadly call it by:
> pte_move_swp_offset(pte, 1);
>
> Is it what you are proposing?

Yes.  Exactly.

--
Best Regards,
Huang, Ying

>>
>> >>
>> >> You need to check the pte of page 0 anyway.
>> >>
>> >> >>
>> >> >> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pte_=
to_swp_entry(folio_pte)) ||
>> >> >> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &any=
_swap_shared) !=3D nr)
>> >> >> > +                     goto check_pte;
>> >> >> > +
>> >> >> > +             start_address =3D folio_start;
>> >> >> > +             start_pte =3D folio_ptep;
>> >> >> > +             nr_pages =3D nr;
>> >> >> > +             entry =3D folio->swap;
>> >> >> > +             page =3D &folio->page;
>> >> >> > +     }
>> >> >> > +
>> >> >> > +check_pte:
>> >> >> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vm=
f->orig_pte)))
>> >> >> >               goto out_nomap;
>> >> >> >
>> >> >> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *=
vmf)
>> >> >> >                        */
>> >> >> >                       exclusive =3D false;
>> >> >> >               }
>> >> >> > +
>> >> >> > +             /* Reuse the whole large folio iff all entries are=
 exclusive */
>> >> >> > +             if (nr_pages > 1 && any_swap_shared)
>> >> >> > +                     exclusive =3D false;
>> >> >> >       }
>> >> >> >
>>
>> [snip]
>>
>> --
>> Best Regards,
>> Huang, Ying

