Return-Path: <linux-kernel+bounces-68158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29828857697
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CD41F21C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0414F62;
	Fri, 16 Feb 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5z2gy63"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606F1758E;
	Fri, 16 Feb 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067487; cv=none; b=sgwJv9+KLGQQ27M4QY7PSN9YYFw7FsM98BBQC4m3/h1oT9RMQS+Y9sFRhe4rbVs3aUxYpS7b4KV8Ba25v3Jz1S+/qykfctHSz3UJvmB1Sq0/jP/iPdwSjeaF7HaYSealeKsg9lECC+CsmCw2IP4FWPpuENiPAgcFmGvvUmOt6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067487; c=relaxed/simple;
	bh=cPzyVvrViCFfYvoRcW3tMnqyU+id4xUBMa+tldMRJDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKgLzmpdCWf0MrRyjBt25yyNl8M2OkBtACai/pA7QRC3fe1K35FJLYwjDlmFGxwXNMvOMjcybbOklRCsfeCNp3KHyhnmxQDQMWbE+uTfQlGMLb6Q2Q6XjBkuaZL0KChFZNBTlsLUAafKPAU7hKkSySygbjhulZpbM00zO8bQKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5z2gy63; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d11d17dddeso5873571fa.3;
        Thu, 15 Feb 2024 23:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708067483; x=1708672283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJAG8j4WuyvYsbGCpUa99IwpurCE+NNIMpfkIsgPt5M=;
        b=f5z2gy63kA25jvxSyiRNUdv07Lz1rtRa6TRS1MJ+DgF+e6+8tM9BBnTQVxOA+6K35U
         /L7stJtTrIdlNxvqgsLcoUVO7APdihzi4ScJXIT3LsRGm9huJ+BeK7akg6YMP8D3xvMe
         EfuxEM8deJD/jjLvlNduUtWTsXlvtxIeRDl7rCn1uDkZrCAfryJAX/akRE5eO5lEFRvC
         EZXBoqGDGUb+grqjYCAov0nscNfy9ztdkCHKoyo4C34Qc7XNTx7Ct6R8tRtCTFnEdKJR
         X8g8BSSeKU88AY8dQlwAoGwLz+w4eS4YBRtVkYraShg4UlIzKbQ7GQhNlhdlOVyB7tp/
         +fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067483; x=1708672283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJAG8j4WuyvYsbGCpUa99IwpurCE+NNIMpfkIsgPt5M=;
        b=M05ERAmOOzxGclx5Qwf79DdKbmkrC0wiMRJtS3dkBYdRJQBhebQCWQirUpof9QEyQ/
         tzisNV2ULc6AKrNrTSl4VyG4x7P6z69pBfM+ETSJvbPP4iYkinkS81OKCx3Qi/vyyAkK
         5kugfxQhU8yaIi6/gr6X/gVH9nMoy42kFGj0DYGJt9ewk9qIUzkmSko5xb3oXxIKwHy0
         BwRreqjha4XH/TgWvLdBuKs0CkNiERoPHQnbEJD3EFZlOt3HK4QNx+CLxJGArqq/1bAG
         u/6Xd6j9sBBGhEBNJ20IOVloO0UMV9qXJfyk4vgTenbs34vzqHaHRVhiJ8vhXQnSORmT
         WMCw==
X-Forwarded-Encrypted: i=1; AJvYcCV/cO0zmwqo+t34MuHUBZwurQxopkytiJaCKpZ4LQli44E+bdHFjzd6I8kg/gE3RCjBgoRxe/dR3pYgvi4p6OaBexb8NGgxEv/VY7628CrydBnjnqbhexyUpQU06tSenvtPca6Q
X-Gm-Message-State: AOJu0YxZand0rGnRNN5886+fmojX61Ip1gwpum09RvmWyCZfBqbmFlUx
	sILJJBLywTJzcXUgv/6r0Cqz1juUsl9uDlIqxa3fxUGmySuhYQaUmMM6oNEix/xp1ipk6gYCAX0
	dSoiZYNXSYncLhyoTO2X3cLrPkzI=
X-Google-Smtp-Source: AGHT+IFrch5kSDlAX6/l4NZU3fCDTXh7J6c6UeQGbLlsL+99+GtwsWsB2WJba27xzYs0AaWtwWlxc2sMMZYhe6UDvSE=
X-Received: by 2002:a2e:2416:0:b0:2d0:f265:4412 with SMTP id
 k22-20020a2e2416000000b002d0f2654412mr2808505ljk.2.1708067483046; Thu, 15 Feb
 2024 23:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
 <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com> <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>
In-Reply-To: <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Feb 2024 15:11:03 +0800
Message-ID: <CAMgjq7CtLrzkO0kBEsqRDyu+GoGbzdgii3_dj7pfo-3-maQU8A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:03=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> On 15.02.24 19:49, Kairui Song wrote:
> > On Thu, Feb 15, 2024 at 11:36=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >> On 06.02.24 19:25, Kairui Song wrote:
> >>> From: Kairui Song <kasong@tencent.com>
> >>>
> >>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more thread=
s
> >>> swapin the same entry at the same time, they get different pages (A, =
B).
> >>> Before one thread (T0) finishes the swapin and installs page (A)
> >>> to the PTE, another thread (T1) could finish swapin of page (B),
> >>> swap_free the entry, then swap out the possibly modified page
> >>> reusing the same entry. It breaks the pte_same check in (T0) because
> >>> PTE value is unchanged, causing ABA problem. Thread (T0) will
> >>> install a stalled page (A) into the PTE and cause data corruption.
> >>>
> >>> One possible callstack is like this:
> >>>
> >>> CPU0                                 CPU1
> >>> ----                                 ----
> >>> do_swap_page()                       do_swap_page() with same entry
> >>> <direct swapin path>                 <direct swapin path>
> >>> <alloc page A>                       <alloc page B>
> >>> swap_read_folio() <- read to page A  swap_read_folio() <- read to pag=
e B
> >>> <slow on later locks or interrupt>   <finished swapin first>
> >>> ...                                  set_pte_at()
> >>>                                        swap_free() <- entry is free
> >>>                                        <write to page B, now page A s=
talled>
> >>>                                        <swap out page B to same swap =
entry>
> >>> pte_same() <- Check pass, PTE seems
> >>>                 unchanged, but page A
> >>>                 is stalled!
> >>> swap_free() <- page B content lost!
> >>> set_pte_at() <- staled page A installed!
> >>>
> >>> And besides, for ZRAM, swap_free() allows the swap device to discard
> >>> the entry content, so even if page (B) is not modified, if
> >>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> >>> it may also cause data loss.
> >>>
> >>> To fix this, reuse swapcache_prepare which will pin the swap entry us=
ing
> >>> the cache flag, and allow only one thread to pin it. Release the pin
> >>> after PT unlocked. Racers will simply busy wait since it's a rare
> >>> and very short event.
> >>>
> >>> Other methods like increasing the swap count don't seem to be a good
> >>> idea after some tests, that will cause racers to fall back to use the
> >>> swap cache again. Parallel swapin using different methods leads to
> >>> a much more complex scenario.
> >>>
> >>> Reproducer:
> >>>
> >>> This race issue can be triggered easily using a well constructed
> >>> reproducer and patched brd (with a delay in read path) [1]:
> >>>
> >>> With latest 6.8 mainline, race caused data loss can be observed easil=
y:
> >>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >>>     Polulating 32MB of memory region...
> >>>     Keep swapping out...
> >>>     Starting round 0...
> >>>     Spawning 65536 workers...
> >>>     32746 workers spawned, wait for done...
> >>>     Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss=
!
> >>>     Round 0: Error on 0x395200, expected 32746, got 32743, 3 data los=
s!
> >>>     Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data los=
s!
> >>>     Round 0 Failed, 15 data loss!
> >>>
> >>> This reproducer spawns multiple threads sharing the same memory regio=
n
> >>> using a small swap device. Every two threads updates mapped pages one=
 by
> >>> one in opposite direction trying to create a race, with one dedicated
> >>> thread keep swapping out the data out using madvise.
> >>>
> >>> The reproducer created a reproduce rate of about once every 5 minutes=
,
> >>> so the race should be totally possible in production.
> >>>
> >>> After this patch, I ran the reproducer for over a few hundred rounds
> >>> and no data loss observed.
> >>>
> >>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> >>> zram:
> >>>
> >>> Before:     10934698 us
> >>> After:      11157121 us
> >>> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >>>
> >>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchron=
ous device")
> >>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.=
ccr.corp.intel.com/
> >>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-str=
ess-race [1]
> >>> Signed-off-by: Kairui Song <kasong@tencent.com>
> >>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >>> Acked-by: Yu Zhao <yuzhao@google.com>
> >>>
> >>> ---
> >>> Update from V1:
> >>> - Add some words on ZRAM case, it will discard swap content on swap_f=
ree so the race window is a bit different but cure is the same. [Barry Song=
]
> >>> - Update comments make it cleaner [Huang, Ying]
> >>> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae =
Park]
> >>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO =
instead of "direct swapin path" [Yu Zhao]
> >>> - Update commit message.
> >>> - Collect Review and Acks.
> >>>
> >>>    include/linux/swap.h |  5 +++++
> >>>    mm/memory.c          | 15 +++++++++++++++
> >>>    mm/swap.h            |  5 +++++
> >>>    mm/swapfile.c        | 13 +++++++++++++
> >>>    4 files changed, 38 insertions(+)
> >>>
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index 4db00ddad261..8d28f6091a32 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp=
)
> >>>        return 0;
> >>>    }
> >>>
> >>> +static inline int swapcache_prepare(swp_entry_t swp)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>>    static inline void swap_free(swp_entry_t swp)
> >>>    {
> >>>    }
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 7e1f4849463a..1749c700823d 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        if (!folio) {
> >>>                if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >>>                    __swap_count(entry) =3D=3D 1) {
> >>> +                     /*
> >>> +                      * Prevent parallel swapin from proceeding with
> >>> +                      * the cache flag. Otherwise, another thread ma=
y
> >>> +                      * finish swapin first, free the entry, and swa=
pout
> >>> +                      * reusing the same entry. It's undetectable as
> >>> +                      * pte_same() returns true due to entry reuse.
> >>> +                      */
> >>> +                     if (swapcache_prepare(entry))
> >>> +                             goto out;
> >>> +
> >>
> >> Is there anything that guarantees that the following won't
> >> happen concurrently, and if it would happen, could it be a problem?
> >>
> >> Other thread MADV_DONTNEED's the swap entry, swap slot is freed.
> >> Some other page gets swapped out, reuses that swap slot.
> >
> > Hi David,
> >
> > Thanks for adding more comments and sharing your thoughts!
> >
> > I'm not sure what you mean by "reuses that swap slot" here, I think
> > you just mean reuse that swap entry (and the actual content on swap
> > device)?
>
> I tried to be precise but I think that caused more confusion :)
>
> entry =3D device + offset into swap_map
>
> I called a "swap slot" the metadata that is identified by device +
> offset (swap_map).
>
> I recall that's what we used to call these things [1], e.g., "Allocating
> swap slots ... All page sized slots are tracked by the array
> swap_info_struct=E2=86=92swap_map."
>
> [1] https://www.kernel.org/doc/gorman/html/understand/understand014.html
>
> Anyhow, you got what I mean :)

Hi David,

That's good, I was confused about the naming of swap related things :)

> >
> >> We call swapcache_prepare() on that slot that is being reused
> >> elsewhere. (possibly some other thread in the context of the reuses
> >> swap slot might do the same!)
> >
> > I think this kind of swapcache_prepare() or false swapin read is
> > already happening quite frequently by swap readaheads. I've seen swap
> > cluster readahead mess up working set activation and memory policy
> > already. Swap cluster readahead simply read in nearby entries of
> > target entry, regardless of whether they are owned by the reader or
> > not.
>
> Okay, thanks for the confirmation!
> >
> > For this patch, similar issues also exist, I think it only hurts the
> > performance, but that's a really rare thing to happen, so should not
> > be a problem.
>
> Okay, good.
>
> >
> >>
> >> We would detect later, that the PTE changed, but we would temporarily
> >> mess with that swap slot that we might no longer "own".
> >>
> >> I was thinking about alternatives, it's tricky because of the concurre=
nt
> >> MADV_DONTNEED possibility. Something with another fake-swap entry type
> >> (similar to migration entries) might work, but would require more chan=
ges.
> >
> > Yeah, in the long term I also think more work is needed for the swap su=
bsystem.
> >
> > In my opinion, for this particular issue, or, for cache bypassed
> > swapin, a new swap map value similar to SWAP_MAP_BAD/SWAP_MAP_SHMEM
> > might be needed, that may even help to simplify the swap count release
> > routine for cache bypassed swapin, and improve the performance.
>
> The question is if we really want to track that in the swapcache and not
> rather in the page table.
>
> Imagine the following:
>
> (1) allocate the folio and lock it (we do that already)
>
> (2) take the page table lock. If the PTE is still the same, insert a new
> "swapin_in_process" fake swp entry that references the locked folio.
..>
> (3) read the folio from swap. This will unlock the folio IIUC. (we do
> that already)
>
> (4) relock the folio. (we do that already, might not want to fail)
>
> (4) take the PTE lock. If the PTE did not change, turn it into a present
> PTE entry. Otherwise, cleanup.

Very interesting idea!

I'm just not sure what actual benefit it brings. The only concern
about reusing swapcache_prepare so far is repeated page faults that
may hurt performance or statistics, this issue is basically gone after
adding a schedule().

We can't drop all the operations around swap cache and map anyway. It
doesn't know if it should skip the swapcache until swapcache lookup
and swap count look up are all done. So I think it can be done more
naturally here with a special value, making things simpler, robust,
and improving performance a bit more.

And in another series [1] I'm working on making shmem make use of
cache bypassed swapin as well, following this approach I'll have to
implement another shmem map based synchronization too.

After all it's only a rare race, I think a simpler solution might be better=
.

[1] https://lore.kernel.org/all/20240129175423.1987-1-ryncsn@gmail.com/

