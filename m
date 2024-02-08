Return-Path: <linux-kernel+bounces-57551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360984DA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70087B244F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393B69317;
	Thu,  8 Feb 2024 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hahcaFkf"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402867E95;
	Thu,  8 Feb 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376594; cv=none; b=WTV4pmXNFr3zq0eCuR5rXofzLW4NgRax0wlgl5FBdn2ky7cAyBQwlef+Z1+2Bcfj+qEGnd2vCFWnTQ7yYC9+RaNUIfolfMtN4aRkHo7k7L0SmDH/l573UEgGzfiNrUxLN3RtDforcdOj75oupbJhnZBbM/KR7jROc6ETxFr8s2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376594; c=relaxed/simple;
	bh=Ib6OVStVd0aC8JLIoXGLQFl5vSQdLjWH7QZEehm9uPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw3D3zJDd5MrnTzyXAbFoE1cvjFJQkbA9b34pxNJbxKSu+jODIAxB7eKPudtXeax+hEDy9dAE3dj8vCDZ9+h/VJkw4dB8IzQCMOgqbhCYp1x3Lk+yBcgnxv8G2wOlOiKPQgdWmQZOxoW81BrAn0R5gXK10hQLb66QHg7QuImQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hahcaFkf; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c01a5e85e8so647365e0c.1;
        Wed, 07 Feb 2024 23:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707376591; x=1707981391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEDru1uOefvH1gyRqHIq3eFRXiLRGNPemxxlD4tRTZE=;
        b=hahcaFkfofAUwWFUpli8YK1nDbKFfOly6s/ZWvHetRos1Ctb4u2lcjERiRksN1Ft+x
         DAWyemtA9hBV4I62tZfokwH+yRNyflm/oZTTwKVac7go+WHCyrfLRdmUc9i2Oh7dw5UL
         CtNEsdpdNwf8xoPZfuJLlVtOuIyWCZ7CWJtxxobAWL3iK8FRTMHKRgsA5/dZCJ4gixb2
         w2SAq28Ntuxg0JoCU1qjTESQO6N5V4+SdiIh4IR7CfFXF+kEuTshrUlqGDoIovmEplKm
         XGEojB03bmhSzc1UDYDEko8TEpv4r8QXu9y9vtFu/tFe0JYNX33iCSZGBY8Ho3NQKibn
         8xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707376591; x=1707981391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEDru1uOefvH1gyRqHIq3eFRXiLRGNPemxxlD4tRTZE=;
        b=w49SWV12iPSVf4N6EMNHhmyLl/TqCJouUnKPPMrqHn4lOsJFVOGD8WL08T4JnIZTdz
         Jh188FN+Oa7PJjYoXKlONgydPd/11v+xDYnWQ1qgGxMSH+ctSMX5MsTGcB4sUq7/OY1c
         WsuBW286/XqjBru7PB0DWhqOC+W1qqCXpC46qrnjygsfKRSSApH99gQkDPXemc4MICtD
         FY5PRn/UEuLXmPSe+iGfg4IHGoS3n/sFmvaGSd6uj2c4htWpdMxZCZYdgp/X6WOx2l3N
         8PznCOwXx1FNbmy+19KdCg3P47q+ITT3uqi3rYzqWFsvt5/EvXmcsM83a+hQ/rkU7gEq
         N6iA==
X-Forwarded-Encrypted: i=1; AJvYcCXEe2yIHPhkrEfzUhdFfBJxCVVp74BGo68k4DrHVGfVj8JDZGJLIMOGn8lpVSzQpRSazVfIXg4ZMfKAmmTNYAH5KOFlfP1Dlf6gEAcoDCf2I1LLOyUtFfRN5BASD9QSKfSiIz/Y
X-Gm-Message-State: AOJu0Yz7CeRpUBaAnLI0Y+UMH140hmkZWx7Pjhe518ueiZZje2/IV5/v
	8XI78BXN6xT0CxnLJOq0Y4jMbyv28IBguDAFYbxBW3vDfn/z+eH+gmBqW79qHNkG8Kt44dKBlg1
	8wnsJ9KSCHfAIIOybMDkLqqLCRiQ=
X-Google-Smtp-Source: AGHT+IFhPiVy/9A4ulaNe0IQiQEZrs6a2zPrvNIgCrPdi19kqhDrmWbgQgOOv6JsWNl61QKN6Jmxi5bXpIpc3D/am5g=
X-Received: by 2002:a05:6122:72d:b0:4c0:3b05:75cb with SMTP id
 45-20020a056122072d00b004c03b0575cbmr4895381vki.10.1707376590957; Wed, 07 Feb
 2024 23:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
 <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
 <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
 <ZcPMi6DX5PN4WwHr@google.com> <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
In-Reply-To: <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 8 Feb 2024 15:16:18 +0800
Message-ID: <CAGsJ_4z1nHgQes5jJ9tPMuvVnXJA=AfTiKiRi7Pd+E81BeEmQw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:05=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.org> w=
rote:
> >
> > On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> > > On Wed, Feb 7, 2024 at 12:02=E2=80=AFPM Chris Li <chrisl@kernel.org> =
wrote:
> > > >
> > > > On Tue, Feb 6, 2024 at 6:21=E2=80=AFPM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > > >
> > > > > On Wed, Feb 7, 2024 at 10:03=E2=80=AFAM Chris Li <chrisl@kernel.o=
rg> wrote:
> > > > > >
> > > > > > On Tue, Feb 6, 2024 at 4:43=E2=80=AFPM Barry Song <21cnbao@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kerne=
l.org> wrote:
> > > > > > > >
> > > > > > > > Hi Kairui,
> > > > > > > >
> > > > > > > > Sorry replying to your patch V1 late, I will reply on the V=
2 thread.
> > > > > > > >
> > > > > > > > On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn=
@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > > > > >
> > > > > > > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or=
 more threads
> > > > > > > > > swapin the same entry at the same time, they get differen=
t pages (A, B).
> > > > > > > > > Before one thread (T0) finishes the swapin and installs p=
age (A)
> > > > > > > > > to the PTE, another thread (T1) could finish swapin of pa=
ge (B),
> > > > > > > > > swap_free the entry, then swap out the possibly modified =
page
> > > > > > > > > reusing the same entry. It breaks the pte_same check in (=
T0) because
> > > > > > > > > PTE value is unchanged, causing ABA problem. Thread (T0) =
will
> > > > > > > > > install a stalled page (A) into the PTE and cause data co=
rruption.
> > > > > > > > >
> > > > > > > > > One possible callstack is like this:
> > > > > > > > >
> > > > > > > > > CPU0                                 CPU1
> > > > > > > > > ----                                 ----
> > > > > > > > > do_swap_page()                       do_swap_page() with =
same entry
> > > > > > > > > <direct swapin path>                 <direct swapin path>
> > > > > > > > > <alloc page A>                       <alloc page B>
> > > > > > > > > swap_read_folio() <- read to page A  swap_read_folio() <-=
 read to page B
> > > > > > > > > <slow on later locks or interrupt>   <finished swapin fir=
st>
> > > > > > > > > ...                                  set_pte_at()
> > > > > > > > >                                      swap_free() <- entry=
 is free
> > > > > > > > >                                      <write to page B, no=
w page A stalled>
> > > > > > > > >                                      <swap out page B to =
same swap entry>
> > > > > > > > > pte_same() <- Check pass, PTE seems
> > > > > > > > >               unchanged, but page A
> > > > > > > > >               is stalled!
> > > > > > > > > swap_free() <- page B content lost!
> > > > > > > > > set_pte_at() <- staled page A installed!
> > > > > > > > >
> > > > > > > > > And besides, for ZRAM, swap_free() allows the swap device=
 to discard
> > > > > > > > > the entry content, so even if page (B) is not modified, i=
f
> > > > > > > > > swap_read_folio() on CPU0 happens later than swap_free() =
on CPU1,
> > > > > > > > > it may also cause data loss.
> > > > > > > > >
> > > > > > > > > To fix this, reuse swapcache_prepare which will pin the s=
wap entry using
> > > > > > > > > the cache flag, and allow only one thread to pin it. Rele=
ase the pin
> > > > > > > > > after PT unlocked. Racers will simply busy wait since it'=
s a rare
> > > > > > > > > and very short event.
> > > > > > > > >
> > > > > > > > > Other methods like increasing the swap count don't seem t=
o be a good
> > > > > > > > > idea after some tests, that will cause racers to fall bac=
k to use the
> > > > > > > > > swap cache again. Parallel swapin using different methods=
 leads to
> > > > > > > > > a much more complex scenario.
> > > > > > > > >
> > > > > > > > > Reproducer:
> > > > > > > > >
> > > > > > > > > This race issue can be triggered easily using a well cons=
tructed
> > > > > > > > > reproducer and patched brd (with a delay in read path) [1=
]:
> > > > > > > > >
> > > > > > > > > With latest 6.8 mainline, race caused data loss can be ob=
served easily:
> > > > > > > > > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > > > > > > > >   Polulating 32MB of memory region...
> > > > > > > > >   Keep swapping out...
> > > > > > > > >   Starting round 0...
> > > > > > > > >   Spawning 65536 workers...
> > > > > > > > >   32746 workers spawned, wait for done...
> > > > > > > > >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3=
 data loss!
> > > > > > > > >   Round 0: Error on 0x395200, expected 32746, got 32743, =
3 data loss!
> > > > > > > > >   Round 0: Error on 0x3fd000, expected 32746, got 32737, =
9 data loss!
> > > > > > > > >   Round 0 Failed, 15 data loss!
> > > > > > > > >
> > > > > > > > > This reproducer spawns multiple threads sharing the same =
memory region
> > > > > > > > > using a small swap device. Every two threads updates mapp=
ed pages one by
> > > > > > > > > one in opposite direction trying to create a race, with o=
ne dedicated
> > > > > > > > > thread keep swapping out the data out using madvise.
> > > > > > > > >
> > > > > > > > > The reproducer created a reproduce rate of about once eve=
ry 5 minutes,
> > > > > > > > > so the race should be totally possible in production.
> > > > > > > > >
> > > > > > > > > After this patch, I ran the reproducer for over a few hun=
dred rounds
> > > > > > > > > and no data loss observed.
> > > > > > > > >
> > > > > > > > > Performance overhead is minimal, microbenchmark swapin 10=
G from 32G
> > > > > > > > > zram:
> > > > > > > > >
> > > > > > > > > Before:     10934698 us
> > > > > > > > > After:      11157121 us
> > > > > > > > > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag=
)
> > > > > > > > >
> > > > > > > > > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin=
 of synchronous device")
> > > > > > > > > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > > > > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yh=
uang6-desk2.ccr.corp.intel.com/
> > > > > > > > > Link: https://github.com/ryncsn/emm-test-project/tree/mas=
ter/swap-stress-race [1]
> > > > > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > > > > Acked-by: Yu Zhao <yuzhao@google.com>
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > Update from V1:
> > > > > > > > > - Add some words on ZRAM case, it will discard swap conte=
nt on swap_free so the race window is a bit different but cure is the same.=
 [Barry Song]
> > > > > > > > > - Update comments make it cleaner [Huang, Ying]
> > > > > > > > > - Add a function place holder to fix CONFIG_SWAP=3Dn buil=
t [SeongJae Park]
> > > > > > > > > - Update the commit message and summary, refer to SWP_SYN=
CHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
> > > > > > > > > - Update commit message.
> > > > > > > > > - Collect Review and Acks.
> > > > > > > > >
> > > > > > > > >  include/linux/swap.h |  5 +++++
> > > > > > > > >  mm/memory.c          | 15 +++++++++++++++
> > > > > > > > >  mm/swap.h            |  5 +++++
> > > > > > > > >  mm/swapfile.c        | 13 +++++++++++++
> > > > > > > > >  4 files changed, 38 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > > > > > index 4db00ddad261..8d28f6091a32 100644
> > > > > > > > > --- a/include/linux/swap.h
> > > > > > > > > +++ b/include/linux/swap.h
> > > > > > > > > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp=
_entry_t swp)
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static inline int swapcache_prepare(swp_entry_t swp)
> > > > > > > > > +{
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static inline void swap_free(swp_entry_t swp)
> > > > > > > > >  {
> > > > > > > > >  }
> > > > > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > > > > index 7e1f4849463a..1749c700823d 100644
> > > > > > > > > --- a/mm/memory.c
> > > > > > > > > +++ b/mm/memory.c
> > > > > > > > > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_=
fault *vmf)
> > > > > > > > >         if (!folio) {
> > > > > > > > >                 if (data_race(si->flags & SWP_SYNCHRONOUS=
_IO) &&
> > > > > > > > >                     __swap_count(entry) =3D=3D 1) {
> > > > > > > > > +                       /*
> > > > > > > > > +                        * Prevent parallel swapin from p=
roceeding with
> > > > > > > > > +                        * the cache flag. Otherwise, ano=
ther thread may
> > > > > > > > > +                        * finish swapin first, free the =
entry, and swapout
> > > > > > > > > +                        * reusing the same entry. It's u=
ndetectable as
> > > > > > > > > +                        * pte_same() returns true due to=
 entry reuse.
> > > > > > > > > +                        */
> > > > > > > > > +                       if (swapcache_prepare(entry))
> > > > > > > > > +                               goto out;
> > > > > > > > > +
> > > > > > > >
> > > > > > > > I am puzzled by this "goto out". If I understand this corre=
ctly, you
> > > > > > > > have two threads CPU1 and CPU2 racing to set the flag SWAP_=
HAS_CACHE.
> > > > > > > > The CPU1 will succeed in adding the flag and  the CPU2 will=
 get
> > > > > > > > "-EEXIST" from "swapcache_prepare(entry)".  Am I understand=
ing it
> > > > > > > > correctly so far?
> > > > > > > >
> > > > > > > > Then the goto out seems wrong to me. For the CPU2, the page=
 fault will
> > > > > > > > return *unhandled*. Even worse, the "-EEXIST" error is not =
preserved,
> > > > > > > > CPU2 does not even know the page fault is not handled, it w=
ill resume
> > > > > > > > from the page fault instruction, possibly generate another =
page fault
> > > > > > > > at the exact same location. That page fault loop will repea=
t until
> > > > > > > > CPU1 install the new pte on that faulting virtual address a=
nd pick up
> > > > > > > > by CPU2.
> > > > > > > >
> > > > > > > > Am I missing something obvious there?
> > > > > > >
> > > > > > > I feel you are right. any concurrent page faults at the same =
pte
> > > > > > > will increase the count of page faults for a couple of times =
now.
> > > > > > >
> > > > > > > >
> > > > > > > > I just re-read your comment: "Racers will simply busy wait =
since it's
> > > > > > > > a rare and very short event." That might be referring to th=
e above
> > > > > > > > CPU2 page fault looping situation. I consider the page faul=
t looping
> > > > > > > > on CPU2 not acceptable. For one it will mess up the page fa=
ult
> > > > > > > > statistics.
> > > > > > > > In my mind, having an explicit loop for CPU2 waiting for th=
e PTE to
> > > > > > > > show up is still better than this page fault loop. You can =
have more
> > > > > > > > CPU power friendly loops.
> > > > > > >
> > > > > > > I assume you mean something like
> > > > > > >
> > > > > > > while(!pte_same())
> > > > > > >    cpu_relax();
> > > > > > >
> > > > > > > then we still have a chance to miss the change of B.
> > > > > > >
> > > > > > > For example, another thread is changing pte to A->B->A, our l=
oop can
> > > > > > > miss B. Thus we will trap into an infinite loop. this is even=
 worse.
> > > > > >
> > > > > > Yes. You are right, it is worse. Thanks for catching that. That=
 is why
> > > > > > I say this needs more discussion, I haven't fully thought it th=
rough
> > > > > > :-)
> > > > >
> > > > > Hi Chris and Barry,
> > > > >
> > > > > Thanks for the comments!
> > > > >
> > > > > The worst thing I know of returning in do_swap_page without handl=
ing
> > > > > the swap, is an increase of some statistic counters, note it will=
 not
> > > > > cause major page fault counters to grow, only things like perf co=
unter
> > > > > and vma lock statistic are affected.
> > > > >
> > > > > And actually there are multiple already existing return points in
> > > > > do_swap_page that will return without handling it, which may
> > > > > re-trigger the page fault.
> > > >
> > > > Thanks for pointing that out. I take a look at those, which seems
> > > > different than the case here.  In those cases, it truely can not ma=
ke
> > > > forward progress.
> > > > Here we actually have all the data it needs to complete the page
> > > > fault. Just a data synchronization issue preventing making forward
> > > > progress.
> > > > Ideally we can have some clever data structure to solve the
> > > > synchronization issue and make forward progress.
> > > >
> > > > > When do_swap_page is called, many pre-checks have been applied, a=
nd
> > > > > they could all be invalidated if something raced, simply looping
> > > > > inside here could miss a lot of corner cases, so we have to go th=
rough
> > > > > that again.
> > > >
> > > > Actually, I  think about it. Looping it here seems worse in the sen=
se
> > > > that it is already holding some locks. Return and retry the page fa=
ult
> > > > at least release those locks and let others have a chance to make
> > > > progress.
> > > >
> > > > >
> > > > > This patch did increase the chance of false positive increase of =
some
> > > > > counters, maybe something like returning a VM_FAULT_RETRY could m=
ake
> > > > > it better, but code is more complex and will cause other counters=
 to
> > > > > grow.
> > > >
> > > > This is certainly not ideal. It might upset the feedback loop that
> > > > uses the swap fault statistic as input to adjust the swapping
> > > > behavior.
> > > >
> > > > Chris
> > >
> > > Hi Chris,
> > >
> > > Thanks for the reply.
> > >
> > > So I think the thing is, it's getting complex because this patch
> > > wanted to make it simple and just reuse the swap cache flags.
> >
> > I agree that a simple fix would be the important at this point.
> >
> > Considering your description, here's my understanding of the other idea=
:
> > Other method, such as increasing the swap count, haven't proven effecti=
ve
> > in your tests. The approach risk forcing racers to rely on the swap cac=
he
> > again and the potential performance loss in race scenario.
> >
> > While I understand that simplicity is important, and performance loss
> > in this case may be infrequent, I believe swap_count approach could be =
a
> > suitable solution. What do you think?
>
> Hi Minchan
>
> Yes, my main concern was about simplicity and performance.
>
> Increasing swap_count here will also race with another process from
> releasing swap_count to 0 (swapcache was able to sync callers in other
> call paths but we skipped swapcache here).

Just like a refcount, releasing to 0 should be ok. the last one who sets
refcount to 0 will finally release the swap entry.

Increasing swap_count from 1 to 2 might cause concurrent threads
go into non-sync-io path(full swapcache things), which was Minchan's
original patch wanted to avoid. i am not sure if this will negatively affec=
t
performance. If not, it seems a feasible way.

> So the right step is: 1. Lock the cluster/swap lock; 2. Check if still
> have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
> __swap_duplicate can be modified to support this, it's similar to
> existing logics for SWAP_HAS_CACHE.
>
> And swap freeing path will do more things, swapcache clean up needs to
> be handled even in the bypassing path since the racer may add it to
> swapcache.
>
> Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
> overhead, so I used that way in this patch, the only issue is
> potentially repeated page faults now.
>
> I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm bad
> at naming it) special value, so any racer can just spin on it to avoid
> all the problems, how do you think about this?

Thanks
Barry

