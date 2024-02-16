Return-Path: <linux-kernel+bounces-67914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C38572F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EB2281589
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CEDDA3;
	Fri, 16 Feb 2024 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah0iwxQx"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC0EED0;
	Fri, 16 Feb 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044907; cv=none; b=ffSECIBoNk06S+8RDUdTw0+NIOQ6YxgVBIF1lolD4O+jMoHS9pdbQu+iidQwbstZnIY44C2BqqEHCJtfwiF+QH7VaVMC6Sf9oMBB1NicWMi5oaF8uGtDFSfz98V+xSNaJMd+8OGErNZyZznmObqK/bR5cSNz3fxtGa4r9wva8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044907; c=relaxed/simple;
	bh=ddesYT4XQr11/rtaxFEdCapDULoaSnmAM+At9SXzucQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMEaQoNBjXdpEsOeVKRB51uNH4fIEMFTrhxlHkB3Bk0/fTn/qL77uDj0APL+IkGdpYu17r3awTN/FVt9sfYsXExjXwlJjQlHU4Fd2dl29plBKWhFT9fU4eaQMEMg2aTuxdsnwfUr3j+7ArGYT7IHn4hbFfYyL/xOg1cKseucJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah0iwxQx; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b7fc7642fcso559184e0c.0;
        Thu, 15 Feb 2024 16:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708044904; x=1708649704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5PvNCoNaVzSn1KWSSHRN6qq6/fi4dbZsoq+fVag2SU=;
        b=ah0iwxQxSNt5X0Zg5L+paLZJG+cbTYaYG20ttr/+dSKzWOezoBD77IcCRkpq/NJViJ
         OlGdL/vd7bmE4C+h/b0Sz669QhBrkkzNwqQq+E7EXRte9KbdQK1Jw/Xm1ZO0MsQy3CWx
         gsqEk2ql7IB43b28GTRG5SpNPF+Xb59wPNWlLf2dNGmb/NZO/PBmRdIUGWm6xcwp1EfT
         3ETSIe9q2XD0XhTsNQb/tTqpGRKHZYcaCcIi/NkNOYMZSQKCe3x/wqe4gmbhhvtB8bWa
         lyT/2FHUfcalIJbBNquyF8bslnlBXXyjPq+ArwIxGjekJhnHxJ74VmHxYlsN4/Ps79xV
         KPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044904; x=1708649704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5PvNCoNaVzSn1KWSSHRN6qq6/fi4dbZsoq+fVag2SU=;
        b=B3yGy7mVa8R+89FlOSlih5ndnf4wGVuQrO1uXQnNki7DmsTmKCZTNdlnwaPtq2gLmb
         qw9aVHJLDyTCSu+EjVCI0jf9YZG5bY7j/i2qxjNksVw1hnmRKtrbEBeB0Lsbj7gQ1OBd
         2pMV0Nb0mM4LD1Iz3pqyNsuMeVfFYG1mzYsWMyg71i70n5SYz/VaF1imNr/w+2OqRc0u
         CVLJlFN3ucHdlhYy2wbltS/KV8CUHF0uSc0v9L8V3LOrZDaxJClvKxNxBP1G7I71Nkhb
         FpwbXQYa4ZNui16AAcsfgb5Ok6U7G1pNfZ+HmAkYe03XkkWy/vdpqw3UHHgptu/MfNdY
         UGxA==
X-Forwarded-Encrypted: i=1; AJvYcCXh+OBoiNmX5UqQ/l+qYXo4em/Co6f7tjLVmvLukO8WhX6d4Oe1+bOrv/ETvKB4rQ6AJTujnfjUIOP49kNdqaTYP5B4CWkVyayj5AJmZvMeiQjBHQ6dctlloSpra/gaoLO/WG+k
X-Gm-Message-State: AOJu0YzwKSH7usp1NajTF50mfEFU/k2amtnWaO55BwgnOkt1unLE6xyy
	MQlhgQURW0kQjLkmF2nx0TezUssDVuGUENJW5F5Vcvu9ifOH8ItgvPTIYb/jRz+PFf5rf1lLiev
	Vs3u3RwgVhVmWWLeou736uSAcc7I=
X-Google-Smtp-Source: AGHT+IHlzkU7fPMbM+GNcS0ZtqGq4f48lK75G6GAmHqrpQrqlz1l1uxawJHUb7eDMwT6taar+Hitjur5wcpWEI6Fu+Q=
X-Received: by 2002:a1f:ed41:0:b0:4c0:292d:193d with SMTP id
 l62-20020a1fed41000000b004c0292d193dmr3599937vkh.12.1708044904012; Thu, 15
 Feb 2024 16:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
 <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
 <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com> <Zc56L6oL4JmxqaFN@google.com>
 <20240215145836.6db8f62824e1547f0608591c@linux-foundation.org>
In-Reply-To: <20240215145836.6db8f62824e1547f0608591c@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Feb 2024 13:54:51 +1300
Message-ID: <CAGsJ_4zK-txkqJzg6vgRuCC+boJ_P+zx9_WPUiCBGB8Cf+K_Xw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	linux-mm@kvack.org, "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:58=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 15 Feb 2024 12:55:11 -0800 Minchan Kim <minchan@kernel.org> wrote=
:
>
> > Only concern of the approach is that it would be harder to have the fix
> > in the stable tree. If there isn't strong objection, I prefer the
> > Kairui's orginal solution(with some tweak of scheduler if it's
> > necessary) first and then pursue your idea on latest tree.
>
> Do we agree that this fix is needed in -stable?  For some reason I
> don't have a cc:stable in the changelog.
>
> I'd like to move this patch into mm-hotfixes-stable in order to get it
> upstream very soon.  Are we all agreeable with that?  I don't have an
> Acked-by: David?
>
> I have a note (which dates back to an earlier version) that Barry would
> be performing runtime testing.  Has that occurred?

yep. i wanted to check if Kairui's patch can also take a positive affection
on my problem, a race between large folios swap-in and madvise pageout
i reported here[1]

but unfortunately I failed as Kairui's patch can only handle normal folio
with one page as  if (swapcache_prepare(entry)) supports only one
entry.

so please consider my test irrelevant for this moment. if Kairui's approach
is accepted, I think I need to somehow make a batched API like
swapcache_prepare_nr(entries, nr) afterwards.

[1] https://lore.kernel.org/linux-mm/20240205095155.7151-1-v-songbaohua@opp=
o.com/

>
> Thanks.
>
>
> Here's what is presently in mm-hotfixes-unstable:
>
>
>
> From: Kairui Song <kasong@tencent.com>
> Subject: mm/swap: fix race when skipping swapcache
> Date: Wed, 7 Feb 2024 02:25:59 +0800
>
> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> swapin the same entry at the same time, they get different pages (A, B).
> Before one thread (T0) finishes the swapin and installs page (A) to the
> PTE, another thread (T1) could finish swapin of page (B), swap_free the
> entry, then swap out the possibly modified page reusing the same entry.
> It breaks the pte_same check in (T0) because PTE value is unchanged,
> causing ABA problem.  Thread (T0) will install a stalled page (A) into th=
e
> PTE and cause data corruption.
>
> One possible callstack is like this:
>
> CPU0                                 CPU1
> ----                                 ----
> do_swap_page()                       do_swap_page() with same entry
> <direct swapin path>                 <direct swapin path>
> <alloc page A>                       <alloc page B>
> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
> <slow on later locks or interrupt>   <finished swapin first>
> ..                                  set_pte_at()
>                                      swap_free() <- entry is free
>                                      <write to page B, now page A stalled=
>
>                                      <swap out page B to same swap entry>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> And besides, for ZRAM, swap_free() allows the swap device to discard the
> entry content, so even if page (B) is not modified, if swap_read_folio()
> on CPU0 happens later than swap_free() on CPU1, it may also cause data
> loss.
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it.  Release the pin
> after PT unlocked.  Racers will simply busy wait since it's a rare and
> very short event.
>
> Other methods like increasing the swap count don't seem to be a good idea
> after some tests, that will cause racers to fall back to use the swap
> cache again.  Parallel swapin using different methods leads to a much mor=
e
> complex scenario.
>
> Reproducer:
>
> This race issue can be triggered easily using a well constructed
> reproducer and patched brd (with a delay in read path) [1]:
>
> With latest 6.8 mainline, race caused data loss can be observed easily:
> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>   Polulating 32MB of memory region...
>   Keep swapping out...
>   Starting round 0...
>   Spawning 65536 workers...
>   32746 workers spawned, wait for done...
>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>   Round 0 Failed, 15 data loss!
>
> This reproducer spawns multiple threads sharing the same memory region
> using a small swap device. Every two threads updates mapped pages one by
> one in opposite direction trying to create a race, with one dedicated
> thread keep swapping out the data out using madvise.
>
> The reproducer created a reproduce rate of about once every 5 minutes,
> so the race should be totally possible in production.
>
> After this patch, I ran the reproducer for over a few hundred rounds
> and no data loss observed.
>
> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> zram:
>
> Before:     10934698 us
> After:      11157121 us
> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>
> Link: https://lkml.kernel.org/r/20240206182559.32264-1-ryncsn@gmail.com
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous =
device")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.=
corp.intel.com/
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-=
race [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/swap.h |    5 +++++
>  mm/memory.c          |   15 +++++++++++++++
>  mm/swap.h            |    5 +++++
>  mm/swapfile.c        |   13 +++++++++++++
>  4 files changed, 38 insertions(+)
>
> --- a/include/linux/swap.h~mm-swap-fix-race-when-skipping-swapcache
> +++ a/include/linux/swap.h
> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_ent
>         return 0;
>  }
>
> +static inline int swapcache_prepare(swp_entry_t swp)
> +{
> +       return 0;
> +}
> +
>  static inline void swap_free(swp_entry_t swp)
>  {
>  }
> --- a/mm/memory.c~mm-swap-fix-race-when-skipping-swapcache
> +++ a/mm/memory.c
> @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> +                       /*
> +                        * Prevent parallel swapin from proceeding with
> +                        * the cache flag. Otherwise, another thread may
> +                        * finish swapin first, free the entry, and swapo=
ut
> +                        * reusing the same entry. It's undetectable as
> +                        * pte_same() returns true due to entry reuse.
> +                        */
> +                       if (swapcache_prepare(entry))
> +                               goto out;
> +
>                         /* skip swapcache */
>                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
>                                                 vma, vmf->address, false)=
;
> @@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault
>  unlock:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> +       /* Clear the swap cache pin for direct swapin after PTL unlock */
> +       if (folio && !swapcache)
> +               swapcache_clear(si, entry);
>  out:
>         if (si)
>                 put_swap_device(si);
> @@ -4124,6 +4137,8 @@ out_nomap:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> +       if (!swapcache)
> +               swapcache_clear(si, entry);
>         folio_unlock(folio);
>  out_release:
>         folio_put(folio);
> --- a/mm/swapfile.c~mm-swap-fix-race-when-skipping-swapcache
> +++ a/mm/swapfile.c
> @@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
>         return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +       struct swap_cluster_info *ci;
> +       unsigned long offset =3D swp_offset(entry);
> +       unsigned char usage;
> +
> +       ci =3D lock_cluster_or_swap_info(si, offset);
> +       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> +       unlock_cluster_or_swap_info(si, ci);
> +       if (!usage)
> +               free_swap_slot(entry);
> +}
> +
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  {
>         return swap_type_to_swap_info(swp_type(entry));
> --- a/mm/swap.h~mm-swap-fix-race-when-skipping-swapcache
> +++ a/mm/swap.h
> @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct fol
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -97,6 +98,10 @@ static inline int swap_writepage(struct
>         return 0;
>  }
>
> +static inline void swapcache_clear(struct swap_info_struct *si, swp_entr=
y_t entry)
> +{
> +}
> +
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr)
>  {
> _
>
>

Thanks
Barry

