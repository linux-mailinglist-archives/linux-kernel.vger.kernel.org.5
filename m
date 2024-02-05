Return-Path: <linux-kernel+bounces-52592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED45849A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F79F283A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801231BC2A;
	Mon,  5 Feb 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ65P7hK"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62941B962
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135944; cv=none; b=aO2QkeyyAfi32jNxj+aLVUUL1V4nT8/Hpq2KiF7c0p3XTH/5RP7nf1pYJmNFUMa/m5TBRbRAhRLTKYZ7waD0nwfqKiRemRn0VZKkj+GAF/ZyTN257gwmRsWf2DFhWBXTCc1lDtrVqXLLZA29RsP99/d1BS0YkWUPJzmEi6/9qhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135944; c=relaxed/simple;
	bh=OSmaamTDtpKVOufS5020Byq41aTMyWjzJia5hOkGcuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYOM2EyEB/rjXIC8z9aUz7R1zGz4z7gp1YWo0rgeNxbspHvs9h5eOTOu9ByxNLuynMWvc5KDoJNjWBfL5D24BC1hv2ADpQcMWBz2kZy+AKdwRFSAqIvtYSiGwE6gbVf/YN5p35LY1SHJpLN2OAR9WAj1joz2hrTPbvlxXZE/BDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ65P7hK; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so1205727241.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707135941; x=1707740741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhpyPAiOlxVOuQdirm3kdFMpnHsavNXmNifVphDhXig=;
        b=TQ65P7hKTDwLGmpR4OrXijYK105shacgto/7scBX+kt/tyVvj+1KV1jjpQTHqrKslL
         4A6VGgs+aj05j4pYahUEPXQ7bZg9nf2mawSxtZipjElXEDDb2apVd58MiCjWzhFSmDmV
         SuEQqqjBmOVu6GAAUttFxEfFazY4LCOzSLLZxaR1DAmzlFSKpqJdM6kQd9Sa1jhPYKn+
         VG6nbg9hQFriwG2yo+d7Oy9553SKUJwt+jXlS0rhYmDHCv9AhhqbVrtP/QJuD/O2+KyC
         tiLNt3wCtTtLZNGs38ICqkJ6cOPCUSoqqiA9AYwpQMFShymUA+HByTe7gFB7jlq3ZCIc
         hjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707135941; x=1707740741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhpyPAiOlxVOuQdirm3kdFMpnHsavNXmNifVphDhXig=;
        b=uPoollkuxjz4pJnl+gDsXOlwnawB3Z6l2GN5rtkt05xmcoNn2te4KmK1+he/g5z4Xf
         0/nBKJJjwrL/CsY/olSPitvoufpyEtn9DkrUPJZvbQcnLbXNJdGO+j4rvE4FRqOXXOkR
         wj11Tm8Tr3oh0pRHwdu7+T77I8EGNtc7eMRDXSUwGp42cNimZ5eNzUYVuJVknCu0PBfk
         nk8b9UbLJ0vZdd4NH8WKBMTHF6IoGxBbGSl69wojql2qktYWtGL907e1FUR7bffWVfiA
         GAeN9kpKwEFu/isdXtxBRtlV/PwboKVll8nvdeV6Tghhxc8F0P2KdfGrlVg7ylhomUbL
         +JZQ==
X-Gm-Message-State: AOJu0Ywl8GHBHapNAVF1hWpqiBMoDW/gnfKChwDr0C03rLPITQoJztZ3
	zStAVa4sspwcfciWJu01rKaVTA3ikNKe5wMA1TjM0YQntcvkJWDtu+Ty2qwfYBFJxuH3eUHvhZP
	IjdnKfkuKrPVBzyGwn2ITDQB8hwc=
X-Google-Smtp-Source: AGHT+IFZpyepxiGRB197zrpnSsou5H6aL4bj+7sXdNlF+UATXmWg6Om4zqXCRwtnCgMslHK2/fU5MKyPwmy7pq8Ckwo=
X-Received: by 2002:a05:6102:2a66:b0:46d:13a3:721 with SMTP id
 hp6-20020a0561022a6600b0046d13a30721mr2544541vsb.29.1707135941456; Mon, 05
 Feb 2024 04:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110959.4021-1-ryncsn@gmail.com>
In-Reply-To: <20240205110959.4021-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 5 Feb 2024 20:25:29 +0800
Message-ID: <CAGsJ_4zyQk4fFnUL77TVt2p=XHzmai1e0xtMEy++GT2sMjQxpg@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:10=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> In the direct swapin path, when two or more threads swapin the same entry
> at the same time, they get different pages (A, B) because swap cache is
> skipped. Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then modify and swap-out the page again, using the

Even if T0's  swap_read_folio is later than T1, problems can still happen.
after T1 swaps in and sets ptes, then frees the swap entry. T0 reads zRAM
later. it will get zero as zRAM will fill zero for freed slot,

static int zram_read_from_zspool(struct zram *zram, struct page *page,
                                 u32 index)
{
       ...


                 value =3D handle ? zram_get_element(zram, index) : 0;
                mem =3D kmap_local_page(page);
               zram_fill_page(mem, PAGE_SIZE, value);
                 kunmap_local(mem);
                return 0;
         }
 }

Even though nobody modifies the data before the page is swapped out to the
same swap offset as before tT0's orig_pte, T0's pte_same check is still tru=
e
and T0 will map filled zeroed page to pte.

so there is more than one risk besides modified data losses.

> same entry. It break the pte_same check because PTE value is unchanged,
> causing ABA problem. Then thread (T0) will then install the stalled page
> (A) into the PTE so new data in page (B) is lost, one possible callstack
> is like this:
>
> CPU0                                CPU1
> ----                                ----
> do_swap_page()                      do_swap_page() with same entry
> <direct swapin path>                <direct swapin path>
> <alloc page A>                      <alloc page B>
> swap_readpage() <- read to page A   swap_readpage() <- read to page B
> <slow on later locks or interrupt>  <finished swapin first>
> ..                                 set_pte_at()
>                                     swap_free() <- Now the entry is freed=
.
>                                     <write to page B, now page A stalled>
>                                     <swap out page B using same swap entr=
y>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply busy wait since it's a rare
> and very short event.
>
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to the
> cached swapin path, two swapin path being used at the same time
> leads to a much more complex scenario.
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

i am also reading these codes recently. It is quite unbelievable this
is really happening
now. as freeing swaps is returning slot to slots_ret, but allocating
swap is from slots.
so if swapfile is large, the chance that the newly allocated swap was
a recently freed swap
is close to 0%. but yes, the code does have the risk.

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
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous =
device")
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-=
race [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>

I will also run your patch on my problem I reported today[1]. will update
the result to you this week.

[1] https://lore.kernel.org/linux-mm/d4f602db-403b-4b1f-a3de-affeb40bc499@a=
rm.com/T/#m41701d0c0e127cdae636e97a13ab521364a810f4

> ---
> Huge thanks to Huang Ying and Chris Li for help finding this issue!
>
>  mm/memory.c   | 19 +++++++++++++++++++
>  mm/swap.h     |  5 +++++
>  mm/swapfile.c | 16 ++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..fd7c55a292f1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3867,6 +3867,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> +                       /*
> +                        * With swap count =3D=3D 1, after we read the en=
try,
> +                        * other threads could finish swapin first, free
> +                        * the entry, then swapout the modified page usin=
g
> +                        * the same entry. Now the content we just read i=
s
> +                        * stalled, and it's undetectable as pte_same()
> +                        * returns true due to entry reuse.
> +                        *
> +                        * So pin the swap entry using the cache flag eve=
n
> +                        * cache is not used.
> +                        */
> +                       if (swapcache_prepare(entry))
> +                               goto out;
> +
>                         /* skip swapcache */
>                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
>                                                 vma, vmf->address, false)=
;
> @@ -4116,6 +4130,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> +       /* Clear the swap cache pin for direct swapin after PTL unlock */
> +       if (folio && !swapcache)
> +               swapcache_clear(si, entry);
>  out:
>         if (si)
>                 put_swap_device(si);
> @@ -4124,6 +4141,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> +       if (!swapcache)
> +               swapcache_clear(si, entry);
>         folio_unlock(folio);
>  out_release:
>         folio_put(folio);
> diff --git a/mm/swap.h b/mm/swap.h
> index 758c46ca671e..fc2f6ade7f80 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struc=
t writeback_control *wbc)
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
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..f7d4ad152a7f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3365,6 +3365,22 @@ int swapcache_prepare(swp_entry_t entry)
>         return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>
> +/*
> + * Clear the cache flag and release pinned entry.
> + */
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
> --
> 2.43.0
>
>

Thanks
Barry

