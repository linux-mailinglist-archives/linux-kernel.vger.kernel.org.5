Return-Path: <linux-kernel+bounces-70318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FFC8595F9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BAF1F214E6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305E13FF8;
	Sun, 18 Feb 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HimcQkrL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2471CA6B;
	Sun, 18 Feb 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248654; cv=none; b=prdUgpyBUlch34yt+8B/3IKMq9k4CHLsEisZXCSDXsU6XDT02CiNa9zSnegaW+sAPYgtgW9dv/xtzpDGPnpgXYbocnK91/DUrCrKNuwA/6pCZY6rYwTLlSxwAyLkLDbyJUcdlWS3Mp9Mua2W8SjSAxOz3sRWgiixjGDPYxHqKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248654; c=relaxed/simple;
	bh=NOj9U+8c52m3s2mJTpkvQnm1f6bMdNv47gTFTWDz1bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9+8dm1S++vND7YLtRq7eloJs2jc8ZHn6ilI5F5bTs/jRKtIvvmhZAiISTBJpRUWIjrKfAYlXF/6kPOFYoaSTw9tvSJtrrK73Tgzu00rWeEGYAfGjmPtyWwJLd/tovjn3epnRDy1zQhHZWf2IUlhytJ5iQALbTFYNtwhNPRow3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HimcQkrL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso23619921fa.2;
        Sun, 18 Feb 2024 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708248650; x=1708853450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo+4QrQ4CM0pua+KSEc6KEfdbFdR1MIGsKnwgT02Mdw=;
        b=HimcQkrL+3Ayi0AQmfzXDhRFs3zJo0/THokLCshRip72bsQa/LuMORzOlNw90yqEtr
         poKWtUI3tGdZ947F5FecE+nUOF8Bo4iyXBvqVPciyPBoHAauQ5UQ3qG8A7IRdJSlWolk
         OPlax1zE48vjCaBR7ZjPL6Yo6MCqyQrWApehLXxFeJhWbDO7CB0L0CM0idcKb+R+Jhb5
         82bojdmjOHIMi9OKr5nVpi2WJM8EtsFQd3kDA2UKG7YRibF6GKLByIWXG5ojePvAcUKy
         yqz2gVYhxJdXI0QzrU/9YSyxYuoyjZTSafn7GTynxzBhV+NCh0z1vH2vJnA4mdzS0p+F
         J8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708248650; x=1708853450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo+4QrQ4CM0pua+KSEc6KEfdbFdR1MIGsKnwgT02Mdw=;
        b=lQvPvzISHMTQtSQt8Hm+tyzb5ZgEg+G/Ahloy4/nsPIrzpHqgjPTvzwFC/8PqyvUPl
         Lt7KRBeKKfZcl/job1hXDs7CymX54ARwg0T1hrTtD7j0Sy/RGB2O9Lxfv5wHONcR9ah1
         xywZzXKVnomONFJNbU2wT7+R8SMKCkASl0mlOs1mkJWiPrZS4uO4RLdecaNBfYw1HF8U
         JhpgQbOD4xBpmn08GT4eq3XOnqoeGrPRKCScxFHYpn2yOKY47tw/qGBnkDyvebY/LSrE
         PM7k+QS2Wa+KQNgB8O/PJelb7jK28SRkogs6XPGk27VofBKswFmtxM8FwOLRQcz6k7/O
         uNIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4IVtDndFgsWvr9kOmPKIm7KKVl0kzk4SytsByK73BvosfiDkUtH3MchheM0crIn8ev/6F9dCYn81Od0yiWUvC3HrA5Ci95xQU+S6gYphhJoavwvvFfkworBt87whiWrht581l
X-Gm-Message-State: AOJu0YzPhJSXU/vdMf9j/+cpvUV72Ct2z4EDvnERHatwvzHSIZa8TDQ3
	NEBCx/Jv7PvplYre7y1EEyiHsnxbF8NQzQJI26uTxDrdOk0V18nKk+ACqiicQAGNI+3rf9Jq8sG
	kFjFWpzbFtsJ8QOPfJ4u3gldBFI72SP4xhe2LQ4Zi
X-Google-Smtp-Source: AGHT+IFtOayIVwtGp1bjTnkrRHkS85aKhqtkk1XkYOaNQumHP8oFHSqJfXCY3LOdwMreZWTpWqkGHBWmAMRC8q3mE98=
X-Received: by 2002:a2e:b60a:0:b0:2d2:31b0:4f64 with SMTP id
 r10-20020a2eb60a000000b002d231b04f64mr1132584ljn.34.1708248649759; Sun, 18
 Feb 2024 01:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
 <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4y6u0MgfpwSoqa38wKiD5Vko=PbKAGrH_xPdChebgeOqQ@mail.gmail.com>
 <87sf1qrwsw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yJj_SBrgRvNA7UjVEHFhLaA90-+aGp8GD3uj7AnR1eEA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yJj_SBrgRvNA7UjVEHFhLaA90-+aGp8GD3uj7AnR1eEA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 18 Feb 2024 17:30:31 +0800
Message-ID: <CAMgjq7CG_QnL5v_=omOSqQ7+j9+oMtW7GiFkJRdrFs-PnAjZnQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sun, Feb 18, 2024 at 9:41=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Sun, Feb 18, 2024 at 9:02=E2=80=AFPM Huang, Ying <ying.huang@intel=
com> wrote:
> > >>
> > >> David Hildenbrand <david@redhat.com> writes:
> > >>
> > >> > On 16.02.24 10:51, Kairui Song wrote:
> > >> >> From: Kairui Song <kasong@tencent.com>
> > >> >> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more
> > >> >> threads
> > >> >> swapin the same entry at the same time, they get different pages =
(A, B).
> > >> >> Before one thread (T0) finishes the swapin and installs page (A)
> > >> >> to the PTE, another thread (T1) could finish swapin of page (B),
> > >> >> swap_free the entry, then swap out the possibly modified page
> > >> >> reusing the same entry. It breaks the pte_same check in (T0) beca=
use
> > >> >> PTE value is unchanged, causing ABA problem. Thread (T0) will
> > >> >> install a stalled page (A) into the PTE and cause data corruption=
.
> > >> >> One possible callstack is like this:
> > >> >> CPU0                                 CPU1
> > >> >> ----                                 ----
> > >> >> do_swap_page()                       do_swap_page() with same ent=
ry
> > >> >> <direct swapin path>                 <direct swapin path>
> > >> >> <alloc page A>                       <alloc page B>
> > >> >> swap_read_folio() <- read to page A  swap_read_folio() <- read to=
 page B
> > >> >> <slow on later locks or interrupt>   <finished swapin first>
> > >> >> ...                                  set_pte_at()
> > >> >>                                       swap_free() <- entry is fre=
e
> > >> >>                                       <write to page B, now page =
A stalled>
> > >> >>                                       <swap out page B to same sw=
ap entry>
> > >> >> pte_same() <- Check pass, PTE seems
> > >> >>                unchanged, but page A
> > >> >>                is stalled!
> > >> >> swap_free() <- page B content lost!
> > >> >> set_pte_at() <- staled page A installed!
> > >> >> And besides, for ZRAM, swap_free() allows the swap device to disc=
ard
> > >> >> the entry content, so even if page (B) is not modified, if
> > >> >> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > >> >> it may also cause data loss.
> > >> >> To fix this, reuse swapcache_prepare which will pin the swap entr=
y
> > >> >> using
> > >> >> the cache flag, and allow only one thread to pin it. Release the =
pin
> > >> >> after PT unlocked. Racers will simply wait since it's a rare and =
very
> > >> >> short event. A schedule() call is added to avoid wasting too much=
 CPU
> > >> >> or adding too much noise to perf statistics
> > >> >> Other methods like increasing the swap count don't seem to be a g=
ood
> > >> >> idea after some tests, that will cause racers to fall back to use=
 the
> > >> >> swap cache again. Parallel swapin using different methods leads t=
o
> > >> >> a much more complex scenario.
> > >> >> Reproducer:
> > >> >> This race issue can be triggered easily using a well constructed
> > >> >> reproducer and patched brd (with a delay in read path) [1]:
> > >> >> With latest 6.8 mainline, race caused data loss can be observed
> > >> >> easily:
> > >> >> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > >> >>    Polulating 32MB of memory region...
> > >> >>    Keep swapping out...
> > >> >>    Starting round 0...
> > >> >>    Spawning 65536 workers...
> > >> >>    32746 workers spawned, wait for done...
> > >> >>    Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data l=
oss!
> > >> >>    Round 0: Error on 0x395200, expected 32746, got 32743, 3 data =
loss!
> > >> >>    Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data =
loss!
> > >> >>    Round 0 Failed, 15 data loss!
> > >> >> This reproducer spawns multiple threads sharing the same memory
> > >> >> region
> > >> >> using a small swap device. Every two threads updates mapped pages=
 one by
> > >> >> one in opposite direction trying to create a race, with one dedic=
ated
> > >> >> thread keep swapping out the data out using madvise.
> > >> >> The reproducer created a reproduce rate of about once every 5
> > >> >> minutes,
> > >> >> so the race should be totally possible in production.
> > >> >> After this patch, I ran the reproducer for over a few hundred rou=
nds
> > >> >> and no data loss observed.
> > >> >> Performance overhead is minimal, microbenchmark swapin 10G from 3=
2G
> > >> >> zram:
> > >> >> Before:     10934698 us
> > >> >> After:      11157121 us
> > >> >> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > >> >> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of
> > >> >> synchronous device")
> > >> >> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap=
-stress-race [1]
> > >> >> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > >> >> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-de=
sk2.ccr.corp.intel.com/
> > >> >> Signed-off-by: Kairui Song <kasong@tencent.com>
> > >> >> Cc: stable@vger.kernel.org
> > >> >> ---
> > >> >> Update from V2:
> > >> >> - Add a schedule() if raced to prevent repeated page faults wasti=
ng CPU
> > >> >>    and add noise to perf statistics.
> > >> >> - Use a bool to state the special case instead of reusing existin=
g
> > >> >>    variables fixing error handling [Minchan Kim].
> > >> >> V2:
> > >> >> https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.c=
om/
> > >> >> Update from V1:
> > >> >> - Add some words on ZRAM case, it will discard swap content on sw=
ap_free so the race window is a bit different but cure is the same. [Barry =
Song]
> > >> >> - Update comments make it cleaner [Huang, Ying]
> > >> >> - Add a function place holder to fix CONFIG_SWAP=3Dn built [Seong=
Jae Park]
> > >> >> - Update the commit message and summary, refer to SWP_SYNCHRONOUS=
_IO instead of "direct swapin path" [Yu Zhao]
> > >> >> - Update commit message.
> > >> >> - Collect Review and Acks.
> > >> >> V1:
> > >> >> https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.co=
m/
> > >> >>   include/linux/swap.h |  5 +++++
> > >> >>   mm/memory.c          | 20 ++++++++++++++++++++
> > >> >>   mm/swap.h            |  5 +++++
> > >> >>   mm/swapfile.c        | 13 +++++++++++++
> > >> >>   4 files changed, 43 insertions(+)
> > >> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> > >> >> index 4db00ddad261..8d28f6091a32 100644
> > >> >> --- a/include/linux/swap.h
> > >> >> +++ b/include/linux/swap.h
> > >> >> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t=
 swp)
> > >> >>      return 0;
> > >> >>   }
> > >> >>   +static inline int swapcache_prepare(swp_entry_t swp)
> > >> >> +{
> > >> >> +    return 0;
> > >> >> +}
> > >> >> +
> > >> >>   static inline void swap_free(swp_entry_t swp)
> > >> >>   {
> > >> >>   }
> > >> >> diff --git a/mm/memory.c b/mm/memory.c
> > >> >> index 7e1f4849463a..7059230d0a54 100644
> > >> >> --- a/mm/memory.c
> > >> >> +++ b/mm/memory.c
> > >> >> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> > >> >>      struct page *page;
> > >> >>      struct swap_info_struct *si =3D NULL;
> > >> >>      rmap_t rmap_flags =3D RMAP_NONE;
> > >> >> +    bool need_clear_cache =3D false;
> > >> >>      bool exclusive =3D false;
> > >> >>      swp_entry_t entry;
> > >> >>      pte_t pte;
> > >> >> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> > >> >>      if (!folio) {
> > >> >>              if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > >> >>                  __swap_count(entry) =3D=3D 1) {
> > >> >> +                    /*
> > >> >> +                     * Prevent parallel swapin from proceeding w=
ith
> > >> >> +                     * the cache flag. Otherwise, another thread=
 may
> > >> >> +                     * finish swapin first, free the entry, and =
swapout
> > >> >> +                     * reusing the same entry. It's undetectable=
 as
> > >> >> +                     * pte_same() returns true due to entry reus=
e.
> > >> >> +                     */
> > >> >> +                    if (swapcache_prepare(entry)) {
> > >> >> +                            /* Relax a bit to prevent rapid repe=
ated page faults */
> > >> >> +                            schedule();
> > >> >> +                            goto out;
> > >> >> +                    }
> > >> >> +                    need_clear_cache =3D true;
> > >> >> +
> > >> >
> > >> > I took a closer look at __read_swap_cache_async() and it essential=
ly
> > >> > does something similar.
> > >> >
> > >> > Instead of returning, it keeps retrying until it finds that
> > >> > swapcache_prepare() fails for another reason than -EEXISTS (e.g.,
> > >> > freed concurrently) or it finds the entry in the swapcache.
> > >> >
> > >> > So if you would succeed here on a freed+reused swap entry,
> > >> > __read_swap_cache_async() would simply retry.
> > >> >
> > >> > It spells that out:
> > >> >
> > >> >               /*
> > >> >                * We might race against __delete_from_swap_cache(),=
 and
> > >> >                * stumble across a swap_map entry whose SWAP_HAS_CA=
CHE
> > >> >                * has not yet been cleared.  Or race against anothe=
r
> > >> >                * __read_swap_cache_async(), which has set SWAP_HAS=
_CACHE
> > >> >                * in swap_map, but not yet added its folio to swap =
cache.
> > >> >                */
> > >> >
> > >> > Whereby we could not race against this code here as well where we
> > >> > speculatively set SWAP_HAS_CACHE and might never add something to =
the swap
> > >> > cache.
> > >> >
> > >> >
> > >> > I'd probably avoid the wrong returns and do something even closer =
to
> > >> > __read_swap_cache_async().
> > >> >
> > >> > while (true) {
> > >> >       /*
> > >> >        * Fake that we are trying to insert a page into the swapcac=
he, to
> > >> >        * serialize against concurrent threads wanting to do the sa=
me.
> > >> >        * [more from your description]
> > >> >        */
> > >> >       ret =3D swapcache_prepare(entry);
> > >> >       if (likely(!ret)
> > >> >               /*
> > >> >                * Move forward with swapin, we'll recheck if the PT=
E hasn't
> > >> >                * changed later.
> > >> >                */
> > >> >               break;
> > >> >       else if (ret !=3D -EEXIST)
> > >> >               goto out;
> > >>
> > >> The swap entry may be kept in swap cache for long time.  For example=
, it
> > >> may be read into swap cache via MADV_WILLNEED.
> > >
> > > This seems fine.
> > >
> > > if swapcache has data from WILLNEED, the new page fault will hit it. =
Thus,
> > > we won't go into the SYNC_IO path any more?
> >
> > They may happen in parallel.  That is, one task is busy looping, while
> > another task read the swap entry into swap cache.
>
> do_swap_page isn't busy looping swapcache_prepare, if it fails, it exits,
> then we have a completely new page fault. this new page fault will
> lookup swapcache and find it, going into the path to set swapcache
> to ptes. so the new page fault won't do swapcache_prepare any more.
>

Hi Barry

The issue here with this code snip is that we could have
swapcache_prepare(entry) =3D=3D -EEXIST and pte_same =3D=3D true, not
necessarily WILLNEED, a concurrent fault and swapout could cause that.
Then we are stuck with while(true) here.

It can be fixed, but still there are other potential issues, we end up
with a similar loop in swap_state.c, may still need to bail out the
fault for some cases, things seem not improved here.

