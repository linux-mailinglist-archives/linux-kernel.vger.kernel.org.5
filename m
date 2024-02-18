Return-Path: <linux-kernel+bounces-70313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C058595EF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456BD1F21A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344512E4C;
	Sun, 18 Feb 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyGPsyzf"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C212B86;
	Sun, 18 Feb 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248047; cv=none; b=q+pnUEb2cH5cbMvRYmQH+R8tRCJb7roaHt7TzyXnd1oB5oTsZTO/rzlgYcUFgT6eaMmodTvcILGqSOTrpLkuIsJU3jJcI7dS+ieD40XSQqJo7jf3qId2deP8SCWX8Ios8qqRVi14T2w0SmnwA3f9LV6s3roKe5jcqHXAMJR5y/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248047; c=relaxed/simple;
	bh=xxwvSdUOh3RGrZh/a3oFYL0pB+CE7Li/sgjGAppT3do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljy+RCk0RaHFZGiwul30Kbb2DeoMNLwd0x8l0pZKz83bNf1bELyS1S4yeZvrvr4jf8KvXInRANhsyyWg+d3o/xsUm56R7UoIt40r243gu2i4EG6cvGnXj4DTI+UDnW+BtEEKEwDUxuYy/ExJaBWbUH0NNKxanBu7nNJ4XiB/v2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyGPsyzf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d208d0b282so43240621fa.0;
        Sun, 18 Feb 2024 01:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708248043; x=1708852843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWKsutbRGzYVGE/Ng+6vm7PeOui1iP0vfYSbJEtQMco=;
        b=PyGPsyzfdKWpvQ6VEQlob7JIXBMHajCTiwjiCxIfSZbac64tNrxDEYqZFQkgfbKbxo
         yZVIu7yBwyZiPa6By9+N3B/CIzW/SAt/OU3j+8CH5bLxkySp7nyk63HK+ctmtbtQ++Z6
         5t/GpBXn4vN/MWt+jCnElOAs5GML+h4lrrYl3EF2eyboR6f7h60APReXIf3Yo+wCTC82
         XN6POsDIE0PuIShHZZjj+y0ESmwnQN+So6HVDxH0ZVsNx9zCWpxZSfREk+cz8pt+dblS
         3U6IOLZNsLVEUWbPsCMW0LfqvktFFmAMzBkhzzHuia2KdcaxqMWQZPW7iSavVFotmNHZ
         ouSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708248043; x=1708852843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWKsutbRGzYVGE/Ng+6vm7PeOui1iP0vfYSbJEtQMco=;
        b=eTM15pMrCyCp0vqAtWjHJRHJe3UFlcBFoL1Pd4ho/chyrcOxH/2M1jlGHkaj043/VW
         qkNtIUccopxaiOSQA0XeoR7OsNpIwpN95vx5RVlxt/EpCZp8cokNoP2Gely8izLrShG2
         Oyz87GjO3RY1V0NYucmAT0LeY+jt4Ej5sjUAXZlwPIeYI1a2rCz35uWH/70l0VXEX4UE
         /tiA2NQBbH7poezCbMCCiizMf9YTgLC2IqaIUqKYMZSCKmwpAVcga4/fdr/vA/azbJfr
         1vjPZs63+RJTxknBV9OY9FFeHJ13HCXXT4SbkFNmrlMEECzcz+6EHpJB9T5FMBbZ43N8
         LpFA==
X-Forwarded-Encrypted: i=1; AJvYcCXvELazN2b6Jy93b6Ud6FndPblMTWqhZDAMkZUFJRo6TNybfUiELcKJaneJ1wuLlc8k8y0tuRA3zXv6E45Bemy7APgq6tLaq4ruCodVJzry1MWIA3FhZind4aK2rTM8onRicllJ
X-Gm-Message-State: AOJu0YwIOFak5MFj4arX5xNqsz4r35bl4tREaeN7dGxxeEO43AFLeLd/
	ONvsGWRS6UJUJvOAHskSf64jnpnQ58EVsEqXKh+wgIAQDZB7uvwe+s6wLPHFmdR6l0F6nZvA67g
	kN95wvDn3Fx5Va/uMGzWoCrvaz9M=
X-Google-Smtp-Source: AGHT+IGRlGEVWsMOZY57fD0eUIGiF047sjI+EeuDIPkLDq4iRf/tNWMpgoWUnVhtIRCxF6GS9jnfMj+VRtKmnM3lnLM=
X-Received: by 2002:a2e:9bcd:0:b0:2d2:3767:ece6 with SMTP id
 w13-20020a2e9bcd000000b002d23767ece6mr449001ljj.14.1708248043042; Sun, 18 Feb
 2024 01:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <87wmr2rx4a.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmr2rx4a.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 18 Feb 2024 17:20:25 +0800
Message-ID: <CAMgjq7CArJDbEev3YR2OB4aZjE9n6PzuzC6WLmsxCKhwq-jb3Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:34=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> > swapin the same entry at the same time, they get different pages (A, B)=
.
> > Before one thread (T0) finishes the swapin and installs page (A)
> > to the PTE, another thread (T1) could finish swapin of page (B),
> > swap_free the entry, then swap out the possibly modified page
> > reusing the same entry. It breaks the pte_same check in (T0) because
> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > install a stalled page (A) into the PTE and cause data corruption.
> >
> > One possible callstack is like this:
> >
> > CPU0                                 CPU1
> > ----                                 ----
> > do_swap_page()                       do_swap_page() with same entry
> > <direct swapin path>                 <direct swapin path>
> > <alloc page A>                       <alloc page B>
> > swap_read_folio() <- read to page A  swap_read_folio() <- read to page =
B
> > <slow on later locks or interrupt>   <finished swapin first>
> > ...                                  set_pte_at()
> >                                      swap_free() <- entry is free
> >                                      <write to page B, now page A stall=
ed>
> >                                      <swap out page B to same swap entr=
y>
> > pte_same() <- Check pass, PTE seems
> >               unchanged, but page A
> >               is stalled!
> > swap_free() <- page B content lost!
> > set_pte_at() <- staled page A installed!
> >
> > And besides, for ZRAM, swap_free() allows the swap device to discard
> > the entry content, so even if page (B) is not modified, if
> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > it may also cause data loss.
> >
> > To fix this, reuse swapcache_prepare which will pin the swap entry usin=
g
> > the cache flag, and allow only one thread to pin it. Release the pin
> > after PT unlocked. Racers will simply wait since it's a rare and very
> > short event. A schedule() call is added to avoid wasting too much CPU
> > or adding too much noise to perf statistics
> >
> > Other methods like increasing the swap count don't seem to be a good
> > idea after some tests, that will cause racers to fall back to use the
> > swap cache again. Parallel swapin using different methods leads to
> > a much more complex scenario.
>
> The swap entry may be put in swap cache by some parallel code path
> anyway.  So, we always need to consider that when reasoning the code.
>
> > Reproducer:
> >
> > This race issue can be triggered easily using a well constructed
> > reproducer and patched brd (with a delay in read path) [1]:
> >
> > With latest 6.8 mainline, race caused data loss can be observed easily:
> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >   Polulating 32MB of memory region...
> >   Keep swapping out...
> >   Starting round 0...
> >   Spawning 65536 workers...
> >   32746 workers spawned, wait for done...
> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> >   Round 0 Failed, 15 data loss!
> >
> > This reproducer spawns multiple threads sharing the same memory region
> > using a small swap device. Every two threads updates mapped pages one b=
y
> > one in opposite direction trying to create a race, with one dedicated
> > thread keep swapping out the data out using madvise.
> >
> > The reproducer created a reproduce rate of about once every 5 minutes,
> > so the race should be totally possible in production.
> >
> > After this patch, I ran the reproducer for over a few hundred rounds
> > and no data loss observed.
> >
> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> > zram:
> >
> > Before:     10934698 us
> > After:      11157121 us
> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >
> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronou=
s device")
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.cc=
r.corp.intel.com/
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: stable@vger.kernel.org
> >
> > ---
> > Update from V2:
> > - Add a schedule() if raced to prevent repeated page faults wasting CPU
> >   and add noise to perf statistics.
> > - Use a bool to state the special case instead of reusing existing
> >   variables fixing error handling [Minchan Kim].
> >
> > V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com=
/
> >
> > Update from V1:
> > - Add some words on ZRAM case, it will discard swap content on swap_fre=
e so the race window is a bit different but cure is the same. [Barry Song]
> > - Update comments make it cleaner [Huang, Ying]
> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae Pa=
rk]
> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO in=
stead of "direct swapin path" [Yu Zhao]
> > - Update commit message.
> > - Collect Review and Acks.
> >
> > V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
> >
> >  include/linux/swap.h |  5 +++++
> >  mm/memory.c          | 20 ++++++++++++++++++++
> >  mm/swap.h            |  5 +++++
> >  mm/swapfile.c        | 13 +++++++++++++
> >  4 files changed, 43 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 4db00ddad261..8d28f6091a32 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
> >       return 0;
> >  }
> >
> > +static inline int swapcache_prepare(swp_entry_t swp)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline void swap_free(swp_entry_t swp)
> >  {
> >  }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7e1f4849463a..7059230d0a54 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       struct page *page;
> >       struct swap_info_struct *si =3D NULL;
> >       rmap_t rmap_flags =3D RMAP_NONE;
> > +     bool need_clear_cache =3D false;
> >       bool exclusive =3D false;
> >       swp_entry_t entry;
> >       pte_t pte;
> > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > +                     /*
> > +                      * Prevent parallel swapin from proceeding with
> > +                      * the cache flag. Otherwise, another thread may
> > +                      * finish swapin first, free the entry, and swapo=
ut
> > +                      * reusing the same entry. It's undetectable as
> > +                      * pte_same() returns true due to entry reuse.
> > +                      */
> > +                     if (swapcache_prepare(entry)) {
> > +                             /* Relax a bit to prevent rapid repeated =
page faults */
> > +                             schedule();
>
> The current task may be chosen in schedule().  So, I think that we
> should use cond_resched() here.
>

I think if we are worried about current task got chosen again we can
use schedule_timeout_uninterruptible(1) here. Isn't cond_resched still
__schedule() and and it can even get omitted, so it should be "weaker"
IIUC.

