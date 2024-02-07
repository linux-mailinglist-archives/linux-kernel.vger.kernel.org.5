Return-Path: <linux-kernel+bounces-56909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCF84D136
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CDD28AAAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0B41C86;
	Wed,  7 Feb 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9fbMgP8"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADA1E4A2;
	Wed,  7 Feb 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330706; cv=none; b=EA67X1ORqY1btEkQrLAbKJpe20Fta+dJCOVzZDVLvBt3Ytgjyrsb65HA1cY8XzNSOHBEvFzh8xys1reem8L2YOUTXd4gHidO7wNvmoursP2t/y3ocjNyuO6pfPKYmODMA9H9FvPWy9GFAb4wIF2WdEbXLMJeEVB/CBYXRTVMDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330706; c=relaxed/simple;
	bh=Kxzqhz4TTsnch2G9gpxUwSGGABgXC77bKBgl/ePHqRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee+faCGOjCpRodmgi9AAfgzYsUNkhGPjgh761QoZN8lH7OSrTcfbslfc9OoPxwd9ixGTJXxIeqwv+DII22+KCu5NrINOE+rF0BLP3vAfycIquijHmX1SwJIqw96DQwUHSePo8VvTFbWFVZTQQRMfBydeP/sVnmfoVPLcdD8uSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9fbMgP8; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59502aa878aso356825eaf.1;
        Wed, 07 Feb 2024 10:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707330703; x=1707935503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YmZ43NB+BehRpaBTVIbrV/YG+RFEqgwiaWaxlRa1fA=;
        b=A9fbMgP88wHE+9+zyjiTAV13oGawyvI5M9+YXNZXCRw307hg+ti9NbXantALJdmfPv
         emb0129NytzuHudgun2tFYZ3n/SixeaX6+aAYNnZsrFVAfxQ3NTGkJZmD9N3GEU4rFjL
         7gKvZBeVdc+KOqbkMWNGJxcRlR4aAt1d5UBGgd60EELZb2qBamQWy/4uzXJxQHj+2egW
         EBWGYRaQjzrzAb15UqzE7lrDK5x0GD8m7rNY9bJRsV1OMbedrQ+gTXDJ4jF1SnLA35Pc
         F7dCY1HD0pP1avZoNOTBcBynVMxyRdGXEbK27+FA6SJrL9x6tHSn3NQp7CKqYGKiwc3f
         JrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330703; x=1707935503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YmZ43NB+BehRpaBTVIbrV/YG+RFEqgwiaWaxlRa1fA=;
        b=iewMkPC+aoI/c8aGscWHMEXhCkjpaRKOI6I60pgthMlh20hqNclOFQTFYkbhjBkJwT
         aeBz22oQ4yyzv/CzWxIfEFhKbehIT5VkjnB/M++wFggi4o6eDqqtnVvUpkKNvsc9l3GH
         nII4E3tYaxV8jn2iL+hb1rjEBVoG3N7a+5pGUj+xguB+Jg0OJHgu9eH6AAZAOxeBP6Jg
         V73EVe+4gOs3f46vS7G1ZBgOhbDTAb1DZb6U9tIUJThRKNlWCci1cHazqNQwx+h9WkWS
         3K42wMsfLMMnDYbhz8RIyYBUO76BSp8jylurdNeIj2PJiU3QnDKwse8mzfVQak/Uh+cY
         H16A==
X-Forwarded-Encrypted: i=1; AJvYcCWhYwOQpo97qmpE/r+BH+hWSMsvhC5xBIa0gqfn6BDkkd6cO0+L+PqTKfLUb65ymBF53S5q5jE53tz+NJ6yRPrPZsdlJ+9suMl4nJkfwCYzgHlXRqsPAgEFSYgTbfR6bdKfOq9R
X-Gm-Message-State: AOJu0YxhvwF1V81sN+q0y3dI6b0kGm/d8ib0eoG/h+T31sVbDhSSCkg9
	wtOPDVfugOwmOMxzhf8JFe1yPGQE6LfZL1tU6uVHbjUoPsoOTm2P
X-Google-Smtp-Source: AGHT+IFH1B5cQy3Fb7aFIqGlFKILTHcEMJVE06JEo/MnfWVfAwssCbv+l6ogS4nbOVnRNYHJ5uGyPg==
X-Received: by 2002:a05:6358:e48c:b0:176:5c73:393b with SMTP id by12-20020a056358e48c00b001765c73393bmr3500280rwb.18.1707330702692;
        Wed, 07 Feb 2024 10:31:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzdyuIwrHaslKrBWZ9q8r0nij6Vvms+3M4/YsEPc+PdXE9Goahy9vFEVoNR0C2B2bAHRCo9Q1X+sLyKMrXuAUEOkb5pE07ttsusVi5QOutQFJf0pTV34UloKIHJ61VTiFOJeChsWEejTIOBuGLn10j7RrfN/HBulboNzcjI+Zig4vgI5TjXhAVcjlGHwV6KcS2qos2IPofebRwMdAI6GiPMMxXrNytPNIw/aTcj7n7uKpS6zqNS2I0XOZBOWAdPl8QC6ancAPvVn2nf7vYtJhY0JcsIdz1+Kl8VNOwIk7wma/k+WavS0+t0GEboP0iT3XGt3QDkCJ8YGTVNxrnz2rLARV9LL8VZN4CLrjHtd1W723J7E5BLo7gdkV9EdIyRRORyONajEWI1nJyoKlXgIUHpTzYlUc9eetsbrr8X7DimBMbYQKgoH/1ZieEB8knH5E+Zk2WcB7ZWF/zJNthGgNHpMWbHkpOUan9Og==
Received: from google.com ([2620:0:1000:8411:af44:f774:c4ae:c82a])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7844c000000b006d9a6039745sm1941051pfn.40.2024.02.07.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:31:42 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Wed, 7 Feb 2024 10:31:39 -0800
From: Minchan Kim <minchan@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Message-ID: <ZcPMi6DX5PN4WwHr@google.com>
References: <20240206182559.32264-1-ryncsn@gmail.com>
 <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
 <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
 <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>

On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> On Wed, Feb 7, 2024 at 12:02 PM Chris Li <chrisl@kernel.org> wrote:
> >
> > On Tue, Feb 6, 2024 at 6:21 PM Kairui Song <ryncsn@gmail.com> wrote:
> > >
> > > On Wed, Feb 7, 2024 at 10:03 AM Chris Li <chrisl@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 6, 2024 at 4:43 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 7, 2024 at 7:18 AM Chris Li <chrisl@kernel.org> wrote:
> > > > > >
> > > > > > Hi Kairui,
> > > > > >
> > > > > > Sorry replying to your patch V1 late, I will reply on the V2 thread.
> > > > > >
> > > > > > On Tue, Feb 6, 2024 at 10:28 AM Kairui Song <ryncsn@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > > >
> > > > > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> > > > > > > swapin the same entry at the same time, they get different pages (A, B).
> > > > > > > Before one thread (T0) finishes the swapin and installs page (A)
> > > > > > > to the PTE, another thread (T1) could finish swapin of page (B),
> > > > > > > swap_free the entry, then swap out the possibly modified page
> > > > > > > reusing the same entry. It breaks the pte_same check in (T0) because
> > > > > > > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > > > > > > install a stalled page (A) into the PTE and cause data corruption.
> > > > > > >
> > > > > > > One possible callstack is like this:
> > > > > > >
> > > > > > > CPU0                                 CPU1
> > > > > > > ----                                 ----
> > > > > > > do_swap_page()                       do_swap_page() with same entry
> > > > > > > <direct swapin path>                 <direct swapin path>
> > > > > > > <alloc page A>                       <alloc page B>
> > > > > > > swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
> > > > > > > <slow on later locks or interrupt>   <finished swapin first>
> > > > > > > ...                                  set_pte_at()
> > > > > > >                                      swap_free() <- entry is free
> > > > > > >                                      <write to page B, now page A stalled>
> > > > > > >                                      <swap out page B to same swap entry>
> > > > > > > pte_same() <- Check pass, PTE seems
> > > > > > >               unchanged, but page A
> > > > > > >               is stalled!
> > > > > > > swap_free() <- page B content lost!
> > > > > > > set_pte_at() <- staled page A installed!
> > > > > > >
> > > > > > > And besides, for ZRAM, swap_free() allows the swap device to discard
> > > > > > > the entry content, so even if page (B) is not modified, if
> > > > > > > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > > > > > > it may also cause data loss.
> > > > > > >
> > > > > > > To fix this, reuse swapcache_prepare which will pin the swap entry using
> > > > > > > the cache flag, and allow only one thread to pin it. Release the pin
> > > > > > > after PT unlocked. Racers will simply busy wait since it's a rare
> > > > > > > and very short event.
> > > > > > >
> > > > > > > Other methods like increasing the swap count don't seem to be a good
> > > > > > > idea after some tests, that will cause racers to fall back to use the
> > > > > > > swap cache again. Parallel swapin using different methods leads to
> > > > > > > a much more complex scenario.
> > > > > > >
> > > > > > > Reproducer:
> > > > > > >
> > > > > > > This race issue can be triggered easily using a well constructed
> > > > > > > reproducer and patched brd (with a delay in read path) [1]:
> > > > > > >
> > > > > > > With latest 6.8 mainline, race caused data loss can be observed easily:
> > > > > > > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > > > > > >   Polulating 32MB of memory region...
> > > > > > >   Keep swapping out...
> > > > > > >   Starting round 0...
> > > > > > >   Spawning 65536 workers...
> > > > > > >   32746 workers spawned, wait for done...
> > > > > > >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> > > > > > >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> > > > > > >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> > > > > > >   Round 0 Failed, 15 data loss!
> > > > > > >
> > > > > > > This reproducer spawns multiple threads sharing the same memory region
> > > > > > > using a small swap device. Every two threads updates mapped pages one by
> > > > > > > one in opposite direction trying to create a race, with one dedicated
> > > > > > > thread keep swapping out the data out using madvise.
> > > > > > >
> > > > > > > The reproducer created a reproduce rate of about once every 5 minutes,
> > > > > > > so the race should be totally possible in production.
> > > > > > >
> > > > > > > After this patch, I ran the reproducer for over a few hundred rounds
> > > > > > > and no data loss observed.
> > > > > > >
> > > > > > > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> > > > > > > zram:
> > > > > > >
> > > > > > > Before:     10934698 us
> > > > > > > After:      11157121 us
> > > > > > > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > > > > > >
> > > > > > > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
> > > > > > > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
> > > > > > > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
> > > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > > Acked-by: Yu Zhao <yuzhao@google.com>
> > > > > > >
> > > > > > > ---
> > > > > > > Update from V1:
> > > > > > > - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
> > > > > > > - Update comments make it cleaner [Huang, Ying]
> > > > > > > - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
> > > > > > > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
> > > > > > > - Update commit message.
> > > > > > > - Collect Review and Acks.
> > > > > > >
> > > > > > >  include/linux/swap.h |  5 +++++
> > > > > > >  mm/memory.c          | 15 +++++++++++++++
> > > > > > >  mm/swap.h            |  5 +++++
> > > > > > >  mm/swapfile.c        | 13 +++++++++++++
> > > > > > >  4 files changed, 38 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > > > index 4db00ddad261..8d28f6091a32 100644
> > > > > > > --- a/include/linux/swap.h
> > > > > > > +++ b/include/linux/swap.h
> > > > > > > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static inline int swapcache_prepare(swp_entry_t swp)
> > > > > > > +{
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static inline void swap_free(swp_entry_t swp)
> > > > > > >  {
> > > > > > >  }
> > > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > > index 7e1f4849463a..1749c700823d 100644
> > > > > > > --- a/mm/memory.c
> > > > > > > +++ b/mm/memory.c
> > > > > > > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > > > > > >         if (!folio) {
> > > > > > >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > > > > > >                     __swap_count(entry) == 1) {
> > > > > > > +                       /*
> > > > > > > +                        * Prevent parallel swapin from proceeding with
> > > > > > > +                        * the cache flag. Otherwise, another thread may
> > > > > > > +                        * finish swapin first, free the entry, and swapout
> > > > > > > +                        * reusing the same entry. It's undetectable as
> > > > > > > +                        * pte_same() returns true due to entry reuse.
> > > > > > > +                        */
> > > > > > > +                       if (swapcache_prepare(entry))
> > > > > > > +                               goto out;
> > > > > > > +
> > > > > >
> > > > > > I am puzzled by this "goto out". If I understand this correctly, you
> > > > > > have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACHE.
> > > > > > The CPU1 will succeed in adding the flag and  the CPU2 will get
> > > > > > "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
> > > > > > correctly so far?
> > > > > >
> > > > > > Then the goto out seems wrong to me. For the CPU2, the page fault will
> > > > > > return *unhandled*. Even worse, the "-EEXIST" error is not preserved,
> > > > > > CPU2 does not even know the page fault is not handled, it will resume
> > > > > > from the page fault instruction, possibly generate another page fault
> > > > > > at the exact same location. That page fault loop will repeat until
> > > > > > CPU1 install the new pte on that faulting virtual address and pick up
> > > > > > by CPU2.
> > > > > >
> > > > > > Am I missing something obvious there?
> > > > >
> > > > > I feel you are right. any concurrent page faults at the same pte
> > > > > will increase the count of page faults for a couple of times now.
> > > > >
> > > > > >
> > > > > > I just re-read your comment: "Racers will simply busy wait since it's
> > > > > > a rare and very short event." That might be referring to the above
> > > > > > CPU2 page fault looping situation. I consider the page fault looping
> > > > > > on CPU2 not acceptable. For one it will mess up the page fault
> > > > > > statistics.
> > > > > > In my mind, having an explicit loop for CPU2 waiting for the PTE to
> > > > > > show up is still better than this page fault loop. You can have more
> > > > > > CPU power friendly loops.
> > > > >
> > > > > I assume you mean something like
> > > > >
> > > > > while(!pte_same())
> > > > >    cpu_relax();
> > > > >
> > > > > then we still have a chance to miss the change of B.
> > > > >
> > > > > For example, another thread is changing pte to A->B->A, our loop can
> > > > > miss B. Thus we will trap into an infinite loop. this is even worse.
> > > >
> > > > Yes. You are right, it is worse. Thanks for catching that. That is why
> > > > I say this needs more discussion, I haven't fully thought it through
> > > > :-)
> > >
> > > Hi Chris and Barry,
> > >
> > > Thanks for the comments!
> > >
> > > The worst thing I know of returning in do_swap_page without handling
> > > the swap, is an increase of some statistic counters, note it will not
> > > cause major page fault counters to grow, only things like perf counter
> > > and vma lock statistic are affected.
> > >
> > > And actually there are multiple already existing return points in
> > > do_swap_page that will return without handling it, which may
> > > re-trigger the page fault.
> >
> > Thanks for pointing that out. I take a look at those, which seems
> > different than the case here.  In those cases, it truely can not make
> > forward progress.
> > Here we actually have all the data it needs to complete the page
> > fault. Just a data synchronization issue preventing making forward
> > progress.
> > Ideally we can have some clever data structure to solve the
> > synchronization issue and make forward progress.
> >
> > > When do_swap_page is called, many pre-checks have been applied, and
> > > they could all be invalidated if something raced, simply looping
> > > inside here could miss a lot of corner cases, so we have to go through
> > > that again.
> >
> > Actually, I  think about it. Looping it here seems worse in the sense
> > that it is already holding some locks. Return and retry the page fault
> > at least release those locks and let others have a chance to make
> > progress.
> >
> > >
> > > This patch did increase the chance of false positive increase of some
> > > counters, maybe something like returning a VM_FAULT_RETRY could make
> > > it better, but code is more complex and will cause other counters to
> > > grow.
> >
> > This is certainly not ideal. It might upset the feedback loop that
> > uses the swap fault statistic as input to adjust the swapping
> > behavior.
> >
> > Chris
> 
> Hi Chris,
> 
> Thanks for the reply.
> 
> So I think the thing is, it's getting complex because this patch
> wanted to make it simple and just reuse the swap cache flags.

I agree that a simple fix would be the important at this point.

Considering your description, here's my understanding of the other idea:
Other method, such as increasing the swap count, haven't proven effective
in your tests. The approach risk forcing racers to rely on the swap cache
again and the potential performance loss in race scenario.

While I understand that simplicity is important, and performance loss
in this case may be infrequent, I believe swap_count approach could be a
suitable solution. What do you think?

