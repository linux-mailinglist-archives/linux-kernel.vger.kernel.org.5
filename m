Return-Path: <linux-kernel+bounces-146128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096B8A6119
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6721B2170D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699310A14;
	Tue, 16 Apr 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6RvZjS+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677E8485
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235295; cv=none; b=XrOfrv8J+L2g6cZ+IqINe0bB6/Ny+WH14Heu8axVmz3aaWL9f3otsStvI5iVY64k4msbh720/cUR3+GpoqvmFXA/F2bGnG/dwX7yhuX1BNv3QCx5BNlu4w2NlUSVjToyV/L0kgmu5YLENrwt5XDt/Q6dBcJ3WOe0KQczUXkghTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235295; c=relaxed/simple;
	bh=AF47lIYi7jUHNQdyQADHspwYl4p62TwwbeI5R4cu2sY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0gk6FutZnBr4evNkKGad2tkIJgQZIr4kQmCPY1m3ivrbBJhQDkFfaWuJsXAnV0b2LwoA+To41q7lS50qw9Fe0FKO8RuSzjESBpjLiCGwcFYNpe+AjUBk2f/PHjTCcjb++933yfU9oSFGoof4D3tgzNx1d8sNCuAGD1aum1Expc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6RvZjS+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713235294; x=1744771294;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=AF47lIYi7jUHNQdyQADHspwYl4p62TwwbeI5R4cu2sY=;
  b=O6RvZjS+NDqzAYyeU93SrwDu7u0T9+ScRcuVU7RxGEq82Z//G5w0tWJR
   D76BiTod0IiZJq//pVwws1lQTKnNSP+ADATYcx/yICXGgsHbN5lbEWvTw
   n40y7gZtl8hq9H7yXInkjm2HIF+tToERVI8ftdN5PJ2KUZCzi72Mn3wmI
   eYu3e/1nUE0tEFFMMC47eBBW4B5nVj859IzXpsAGbflWrgKFm25cClynP
   Y+WJBeW2AkxnimSJkKD0o8cS8AlME4Cx8+6wmUOCYyQYk5v65m5CpdLIc
   7Izm0mBwO92fNL4uA6OlnqUPF9CQ2MF9x4qIjRUOC70asjSL1/BqWHo/j
   A==;
X-CSE-ConnectionGUID: 3+EM1bE2Ru66xKJpLm1QqA==
X-CSE-MsgGUID: S60cezNuSVumHAscCt9smg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="9205602"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="9205602"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:41:33 -0700
X-CSE-ConnectionGUID: we6sQxMVTBua8dKd6KhhLQ==
X-CSE-MsgGUID: G5IGqF7NRJiZww5sVUapIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="59553320"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:41:28 -0700
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
In-Reply-To: <CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
	(Barry Song's message of "Tue, 16 Apr 2024 14:36:08 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-5-21cnbao@gmail.com>
	<87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
	<8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
Date: Tue, 16 Apr 2024 10:39:34 +0800
Message-ID: <87y19e115l.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Tue, Apr 16, 2024 at 2:27=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>>
>> Added Khalid for arch_do_swap_page().
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>>
>> [snip]
>>
>> >>
>> >> > +     bool any_swap_shared =3D false;
>> >> >
>> >> >       if (!pte_unmap_same(vmf))
>> >> >               goto out;
>> >> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >> >        */
>> >> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->a=
ddress,
>> >> >                       &vmf->ptl);
>> >>
>> >> We should move pte check here.  That is,
>> >>
>> >>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->=
orig_pte)))
>> >>                 goto out_nomap;
>> >>
>> >> This will simplify the situation for large folio.
>> >
>> > the plan is moving the whole code block
>> >
>> > if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio=
))
>> >
>> > after
>> >         if (unlikely(!folio_test_uptodate(folio))) {
>> >                 ret =3D VM_FAULT_SIGBUS;
>> >                 goto out_nomap;
>> >         }
>> >
>> > though we couldn't be !folio_test_uptodate(folio)) for hitting
>> > swapcache but it seems
>> > logically better for future use.
>>
>> LGTM, Thanks!
>>
>> >>
>> >> > +
>> >> > +     /* We hit large folios in swapcache */
>> >>
>> >> The comments seems unnecessary because the code tells that already.
>> >>
>> >> > +     if (start_pte && folio_test_large(folio) && folio_test_swapca=
che(folio)) {
>> >> > +             int nr =3D folio_nr_pages(folio);
>> >> > +             int idx =3D folio_page_idx(folio, page);
>> >> > +             unsigned long folio_start =3D vmf->address - idx * PA=
GE_SIZE;
>> >> > +             unsigned long folio_end =3D folio_start + nr * PAGE_S=
IZE;
>> >> > +             pte_t *folio_ptep;
>> >> > +             pte_t folio_pte;
>> >> > +
>> >> > +             if (unlikely(folio_start < max(vmf->address & PMD_MAS=
K, vma->vm_start)))
>> >> > +                     goto check_pte;
>> >> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, v=
ma->vm_end)))
>> >> > +                     goto check_pte;
>> >> > +
>> >> > +             folio_ptep =3D vmf->pte - idx;
>> >> > +             folio_pte =3D ptep_get(folio_ptep);
>> >>
>> >> It's better to construct pte based on fault PTE via generalizing
>> >> pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we can fi=
nd
>> >> inconsistent PTEs quicker.
>> >
>> > it seems your point is getting the pte of page0 by pte_next_swp_offset=
()
>> > unfortunately pte_next_swp_offset can't go back. on the other hand,
>> > we have to check the real pte value of the 0nd entry right now because
>> > swap_pte_batch() only really reads pte from the 1st entry. it assumes
>> > pte argument is the real value for the 0nd pte entry.
>> >
>> > static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t =
pte)
>> > {
>> >         pte_t expected_pte =3D pte_next_swp_offset(pte);
>> >         const pte_t *end_ptep =3D start_ptep + max_nr;
>> >         pte_t *ptep =3D start_ptep + 1;
>> >
>> >         VM_WARN_ON(max_nr < 1);
>> >         VM_WARN_ON(!is_swap_pte(pte));
>> >         VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
>> >
>> >         while (ptep < end_ptep) {
>> >                 pte =3D ptep_get(ptep);
>> >
>> >                 if (!pte_same(pte, expected_pte))
>> >                         break;
>> >
>> >                 expected_pte =3D pte_next_swp_offset(expected_pte);
>> >                 ptep++;
>> >         }
>> >
>> >         return ptep - start_ptep;
>> > }
>>
>> Yes.  You are right.
>>
>> But we may check whether the pte of page0 is same as "vmf->orig_pte -
>> folio_page_idx()" (fake code).
>
> right, that is why we are reading and checking PTE0 before calling
> swap_pte_batch()
> right now.
>
>   folio_ptep =3D vmf->pte - idx;
>   folio_pte =3D ptep_get(folio_ptep);
>   if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio_pt=
e)) ||
>       swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_shared) !=3D nr)
>    goto check_pte;
>
> So, if I understand correctly, you're proposing that we should directly c=
heck
> PTE0 in swap_pte_batch(). Personally, I don't have any objections to this=
 idea.
> However, I'd also like to hear the feedback from Ryan and David :-)

I mean that we can replace=20

        !is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio_pt=
e))

in above code with pte_same() with constructed expected first pte.

>>
>> You need to check the pte of page 0 anyway.
>>
>> >>
>> >> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_=
swp_entry(folio_pte)) ||
>> >> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &any_sw=
ap_shared) !=3D nr)
>> >> > +                     goto check_pte;
>> >> > +
>> >> > +             start_address =3D folio_start;
>> >> > +             start_pte =3D folio_ptep;
>> >> > +             nr_pages =3D nr;
>> >> > +             entry =3D folio->swap;
>> >> > +             page =3D &folio->page;
>> >> > +     }
>> >> > +
>> >> > +check_pte:
>> >> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->=
orig_pte)))
>> >> >               goto out_nomap;
>> >> >
>> >> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >> >                        */
>> >> >                       exclusive =3D false;
>> >> >               }
>> >> > +
>> >> > +             /* Reuse the whole large folio iff all entries are ex=
clusive */
>> >> > +             if (nr_pages > 1 && any_swap_shared)
>> >> > +                     exclusive =3D false;
>> >> >       }
>> >> >

[snip]

--
Best Regards,
Huang, Ying

