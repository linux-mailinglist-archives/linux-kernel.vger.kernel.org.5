Return-Path: <linux-kernel+bounces-70286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30A859597
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DB51F21C7A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD3FBEA;
	Sun, 18 Feb 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dus60HgN"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE5F4F5;
	Sun, 18 Feb 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244365; cv=none; b=hgBEiDhupRT5y89++gg2qx0Grp0ZQqWXKzGOUw5hubspZRYiorbVjBKrQEGLaMsilYAtG8nxMX/x624tY3ITDf9pPUbWZHmved5VkYXo/5EdYt3bxclJxIYGMY/0PGTfyzbVyqQZT4WFESt9VJl3ht0+4FVfzNEIfzWHQd1hwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244365; c=relaxed/simple;
	bh=4vO1XRrgx2GQeNn/pHbYDtM+bkkQEm8yndN6b7X2Nj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOht/12iNjG05xSesd8l/Q2muJth0znfzof/V1A2KeuNU869QXoQRiZRgbdShcSMcpTKLT4fZIP+KyKUZPkiRdHvOgr9M0FUbCShKQZTzExeoBDoQR6u+HKRgDhIcZoYmN93SEnKEhw5Z/zez1j7RaV4op0M6Xz2aKj4wuoaq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dus60HgN; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d625a3ace6so2497055241.0;
        Sun, 18 Feb 2024 00:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708244363; x=1708849163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sgs38sah8JNtd5cqryin8897qLEvPqqBTuZJcRIJhE=;
        b=dus60HgN6wUJwePsIZSydLD/+tleNFt43Kqv5xEenQ+9RpZTTNRiEvvtpNlYGZ4IZv
         LDDwsHnSzLL30W42qKuM4DZpAo0wgs1UpJaMxJcE3vYNUVrxhqh3t7kAHjdnlK69OuxY
         uhQEw+/s37L8S1E3NBYPXx+i0kY4O4mC+6c/kzSk67jA5eASXcIY9vnJKcKt2mcZ1LZg
         BCEdWT2yebkmJ9NvuhoX3ufyv0Kx2G5GLfNeHcGcvyAieBQbr83bcOj+EM2WuKZBv9Pi
         wuP1OAcgqTvwxyzmOf/1YHR+2KkEWJzFoPs5ZWtUbl12F+gL5npF8CLFpjDyv1kNTqdw
         ReLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708244363; x=1708849163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sgs38sah8JNtd5cqryin8897qLEvPqqBTuZJcRIJhE=;
        b=HVn86ivItLpzr+dxfhNxWvfQ9RE81AO801UUbYczbxi3P2qq4VTWH3qgL24187OQk9
         2zUZh1FE0oz2XY9H93KpmNsN5y9GBMpgU+R4EDv8NM8w+juTlWjV+y8V597lWfOvdiy/
         gN4plsRlgBE4F10EL+fs1fsMhfIlU74uCXeRRC83rdlNmP5cwPfl28Dpj/KbxkBor4zv
         7y7LU3gKer826cXP9OHbPjSb2AGUyscWQCjsNg2HeNGjTtAfbhCIrw5nMw++yw05NoT5
         9IGEJk3Gqcmih644qpVb8m9b4NS6XnIjx3yRJNhJJKMXDXBxARFEblsI3O5KFZOPFYyr
         oH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8o6gssXLehTO7xthy/tSF/xl3eY9wL5jX99NpDu15kQmNg2NqYAr5sGNikjV/QDi9JrF5r1fboYWJznY+k2740a4avjZpyU522uIR3KLQTF3JoXp3318rx3DUUdl0aADT2SG
X-Gm-Message-State: AOJu0YysvmyLIZ31RqATHBanNh2dWUHcIbFrOl8GhWTxi+u2cHMPqZYP
	6vkcZPo9zwlinDuPw+fgfDD2TAlyJPW5u2Qa1nzJQy8MXGrinGrtMuqwKVbnWvKBXKPGMxfPqaw
	JQd2PEK1b3l3oOaht0t/dxudsBZg=
X-Google-Smtp-Source: AGHT+IHAI4cU/bVCVp18PqRh9poxzBrihOxjklB9kSzrPzNxlvu0zFbH9g48wHNQIeON47OouQ5zyUeM1h8gNjqNaA4=
X-Received: by 2002:a05:6122:d91:b0:4c7:6d00:767d with SMTP id
 bc17-20020a0561220d9100b004c76d00767dmr3281648vkb.0.1708244362547; Sun, 18
 Feb 2024 00:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
 <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Feb 2024 21:19:10 +1300
Message-ID: <CAGsJ_4y6u0MgfpwSoqa38wKiD5Vko=PbKAGrH_xPdChebgeOqQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 9:02=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> David Hildenbrand <david@redhat.com> writes:
>
> > On 16.02.24 10:51, Kairui Song wrote:
> >> From: Kairui Song <kasong@tencent.com>
> >> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more
> >> threads
> >> swapin the same entry at the same time, they get different pages (A, B=
).
> >> Before one thread (T0) finishes the swapin and installs page (A)
> >> to the PTE, another thread (T1) could finish swapin of page (B),
> >> swap_free the entry, then swap out the possibly modified page
> >> reusing the same entry. It breaks the pte_same check in (T0) because
> >> PTE value is unchanged, causing ABA problem. Thread (T0) will
> >> install a stalled page (A) into the PTE and cause data corruption.
> >> One possible callstack is like this:
> >> CPU0                                 CPU1
> >> ----                                 ----
> >> do_swap_page()                       do_swap_page() with same entry
> >> <direct swapin path>                 <direct swapin path>
> >> <alloc page A>                       <alloc page B>
> >> swap_read_folio() <- read to page A  swap_read_folio() <- read to page=
 B
> >> <slow on later locks or interrupt>   <finished swapin first>
> >> ...                                  set_pte_at()
> >>                                       swap_free() <- entry is free
> >>                                       <write to page B, now page A sta=
lled>
> >>                                       <swap out page B to same swap en=
try>
> >> pte_same() <- Check pass, PTE seems
> >>                unchanged, but page A
> >>                is stalled!
> >> swap_free() <- page B content lost!
> >> set_pte_at() <- staled page A installed!
> >> And besides, for ZRAM, swap_free() allows the swap device to discard
> >> the entry content, so even if page (B) is not modified, if
> >> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> >> it may also cause data loss.
> >> To fix this, reuse swapcache_prepare which will pin the swap entry
> >> using
> >> the cache flag, and allow only one thread to pin it. Release the pin
> >> after PT unlocked. Racers will simply wait since it's a rare and very
> >> short event. A schedule() call is added to avoid wasting too much CPU
> >> or adding too much noise to perf statistics
> >> Other methods like increasing the swap count don't seem to be a good
> >> idea after some tests, that will cause racers to fall back to use the
> >> swap cache again. Parallel swapin using different methods leads to
> >> a much more complex scenario.
> >> Reproducer:
> >> This race issue can be triggered easily using a well constructed
> >> reproducer and patched brd (with a delay in read path) [1]:
> >> With latest 6.8 mainline, race caused data loss can be observed
> >> easily:
> >> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >>    Polulating 32MB of memory region...
> >>    Keep swapping out...
> >>    Starting round 0...
> >>    Spawning 65536 workers...
> >>    32746 workers spawned, wait for done...
> >>    Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >>    Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> >>    Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> >>    Round 0 Failed, 15 data loss!
> >> This reproducer spawns multiple threads sharing the same memory
> >> region
> >> using a small swap device. Every two threads updates mapped pages one =
by
> >> one in opposite direction trying to create a race, with one dedicated
> >> thread keep swapping out the data out using madvise.
> >> The reproducer created a reproduce rate of about once every 5
> >> minutes,
> >> so the race should be totally possible in production.
> >> After this patch, I ran the reproducer for over a few hundred rounds
> >> and no data loss observed.
> >> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> >> zram:
> >> Before:     10934698 us
> >> After:      11157121 us
> >> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of
> >> synchronous device")
> >> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stre=
ss-race [1]
> >> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.c=
cr.corp.intel.com/
> >> Signed-off-by: Kairui Song <kasong@tencent.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >> Update from V2:
> >> - Add a schedule() if raced to prevent repeated page faults wasting CP=
U
> >>    and add noise to perf statistics.
> >> - Use a bool to state the special case instead of reusing existing
> >>    variables fixing error handling [Minchan Kim].
> >> V2:
> >> https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
> >> Update from V1:
> >> - Add some words on ZRAM case, it will discard swap content on swap_fr=
ee so the race window is a bit different but cure is the same. [Barry Song]
> >> - Update comments make it cleaner [Huang, Ying]
> >> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae P=
ark]
> >> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO i=
nstead of "direct swapin path" [Yu Zhao]
> >> - Update commit message.
> >> - Collect Review and Acks.
> >> V1:
> >> https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
> >>   include/linux/swap.h |  5 +++++
> >>   mm/memory.c          | 20 ++++++++++++++++++++
> >>   mm/swap.h            |  5 +++++
> >>   mm/swapfile.c        | 13 +++++++++++++
> >>   4 files changed, 43 insertions(+)
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index 4db00ddad261..8d28f6091a32 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
> >>      return 0;
> >>   }
> >>   +static inline int swapcache_prepare(swp_entry_t swp)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >>   static inline void swap_free(swp_entry_t swp)
> >>   {
> >>   }
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 7e1f4849463a..7059230d0a54 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>      struct page *page;
> >>      struct swap_info_struct *si =3D NULL;
> >>      rmap_t rmap_flags =3D RMAP_NONE;
> >> +    bool need_clear_cache =3D false;
> >>      bool exclusive =3D false;
> >>      swp_entry_t entry;
> >>      pte_t pte;
> >> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>      if (!folio) {
> >>              if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >>                  __swap_count(entry) =3D=3D 1) {
> >> +                    /*
> >> +                     * Prevent parallel swapin from proceeding with
> >> +                     * the cache flag. Otherwise, another thread may
> >> +                     * finish swapin first, free the entry, and swapo=
ut
> >> +                     * reusing the same entry. It's undetectable as
> >> +                     * pte_same() returns true due to entry reuse.
> >> +                     */
> >> +                    if (swapcache_prepare(entry)) {
> >> +                            /* Relax a bit to prevent rapid repeated =
page faults */
> >> +                            schedule();
> >> +                            goto out;
> >> +                    }
> >> +                    need_clear_cache =3D true;
> >> +
> >
> > I took a closer look at __read_swap_cache_async() and it essentially
> > does something similar.
> >
> > Instead of returning, it keeps retrying until it finds that
> > swapcache_prepare() fails for another reason than -EEXISTS (e.g.,
> > freed concurrently) or it finds the entry in the swapcache.
> >
> > So if you would succeed here on a freed+reused swap entry,
> > __read_swap_cache_async() would simply retry.
> >
> > It spells that out:
> >
> >               /*
> >                * We might race against __delete_from_swap_cache(), and
> >                * stumble across a swap_map entry whose SWAP_HAS_CACHE
> >                * has not yet been cleared.  Or race against another
> >                * __read_swap_cache_async(), which has set SWAP_HAS_CACH=
E
> >                * in swap_map, but not yet added its folio to swap cache=
.
> >                */
> >
> > Whereby we could not race against this code here as well where we
> > speculatively set SWAP_HAS_CACHE and might never add something to the s=
wap
> > cache.
> >
> >
> > I'd probably avoid the wrong returns and do something even closer to
> > __read_swap_cache_async().
> >
> > while (true) {
> >       /*
> >        * Fake that we are trying to insert a page into the swapcache, t=
o
> >        * serialize against concurrent threads wanting to do the same.
> >        * [more from your description]
> >        */
> >       ret =3D swapcache_prepare(entry);
> >       if (likely(!ret)
> >               /*
> >                * Move forward with swapin, we'll recheck if the PTE has=
n't
> >                * changed later.
> >                */
> >               break;
> >       else if (ret !=3D -EEXIST)
> >               goto out;
>
> The swap entry may be kept in swap cache for long time.  For example, it
> may be read into swap cache via MADV_WILLNEED.

This seems fine.

if swapcache has data from WILLNEED, the new page fault will hit it. Thus,
we won't go into the SYNC_IO path any more?

>
> --
> Best Regards,
> Huang, Ying
>
> >
> >       /*
> >          * See __read_swap_cache_async(). We might either have raced ag=
ainst
> >          * another thread, or the entry could have been freed and reuse=
d in the
> >        * meantime. Make sure that the PTE did not change, to detect fre=
eing.
> >        */
> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> >                                      vmf->address, &vmf->ptl);
> >       if (!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))
> >               goto unlock;
> >
> >
> >       schedule();
> > }
> >
> >
> >
> > I was skeptical about the schedule(), but __read_swap_cache_async() doe=
s it
> > already because there is no better way to wait for the event to happen.
> >
> > With something like above you would no longer depend on the speed of sc=
hedule() to
> > determine how often you would retry the fault, which would likely make =
sense.
> >
> > I do wonder about the schedule() vs. schedule_timeout_uninterruptible()=
, though.
> > No expert on that area, do you have any idea?
>

