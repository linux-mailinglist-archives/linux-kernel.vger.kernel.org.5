Return-Path: <linux-kernel+bounces-55931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9135484C389
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4608928B7AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB8A11C94;
	Wed,  7 Feb 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IynztR3k"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D412E5D;
	Wed,  7 Feb 2024 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279880; cv=none; b=prU63Yn/0cDzxpJz5j1VB0Yq7yrRrKjQ6Ds1tFHK7uEg6LCUDPSC+6IfW8rpDOkjfAP0dUipr8zz0klLOaQHcpczK/b0UUzlxNOHjGnpqPFhq+zpNVUCvminOUyq51gP70z5cfQ2znESrdyCFf0wQrUi8Fkw5KPVMqGXIRJuMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279880; c=relaxed/simple;
	bh=P56cDDcL7CT0vkcOG8uRlL/dZKiGPdjv3qnBx1weE7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuFJm9sJ2s6H1eVVRLBgWXNc3HNplKMi+f9UkbBTbVHY5fHd2Ulh+U/kNGZL94zGrOhBoXrhGChgOattaOlSvY/cHSQguQsGBIoXIhEC2/8qjJjaJsLSff5BHEpoIktnVzxrq1o+knACj0OB6ca0WbHjX9tkxyEq1lb1E787Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IynztR3k; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-46d2c1077easo21947137.1;
        Tue, 06 Feb 2024 20:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707279877; x=1707884677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/T7vVoY4dyYhFaTQIcRmFULAzM3zlFgpAUZpk74xD4=;
        b=IynztR3klVYZORv/X5/+47c3nlNPFgceOQuRB8XdxnWfuEN7RJSidJucp1DB5RT5nC
         ymyN53dQYBgEICjU4vvUg3hi8FxUescgdjPMKPRHlZSwxI1XBfm3Qg9VtIjm8uBKsg28
         I+9J6wOUoxR/iX9OF4XYm/psGfl4ZxEcxZO3644KhYSqjtD9eIQbYMHCVALvMsx12u3o
         3R3v7XS/dBZ6I23Mm3H+kEErNm182Yw/E/+edfxkwxQhVEEa8cZoaTDL15DZhMH4eROZ
         RurQWKjxrH/FqRlFGAZE3wu9aOgv0xpbPZUQaqgnaUeMMecVj3HBeyTvEpSAaLDo1fMs
         5Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279877; x=1707884677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/T7vVoY4dyYhFaTQIcRmFULAzM3zlFgpAUZpk74xD4=;
        b=X2S98iUo66gntfnv2GiL86dqYExiTo/X4AjIxNKgdMvMl06uwkwzmPpZy5qF690zWS
         uY1Eg/ugi49niiQEbwMDkObV+fxm5zQC17trc5qSb1ewloulyfN+7/yE0oEDcxmCcC7Z
         akn2u5r8ctDmpm01WbWKn65K8Ksb/34wZKEy24pjg03hDwKDIxG4yZTLcrpEJ6D4RIjR
         YYPXcXKORJ83yNUPK5VRvkDmSWX8RlLGaZFmyDAfCSSOeO3JLsl8a8jlhXGKmlpxDYu2
         BZUyDLI1A8Z/sEO2fl6pRWt+YOlEcxTPFOdW6Z8vz0mNAYLEY1Yesw1kxlOdMgrgA7c8
         Qq4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNHD/njqIzmKu/MOmOMbPjHF4SM1Hz8xGHJYuW458feuZPDGLXf9kkhhk++o3cGUm07fPFDwKJviImlildhJX/74vHlKdFR9Hu154s+BKtQc0xMo4H/U/veo5aRELuJjSZiBHz
X-Gm-Message-State: AOJu0YwZm6RzA0ods35icgE9bnsZqtUdY7oW235T67WnIvsC//50buQa
	EhhEgZmZ7V3tENAv+Fuz9lLpfQeSaGtEXaYW0I5QmU6N/FVhXjNOwvNgmvUJklFyFQpbRmbG5IF
	1dpJzUwQXYMBVq2kd0Eagdc8yCNA=
X-Google-Smtp-Source: AGHT+IEWdX498cscZTub6vjfa1EzMDhGIzoxxIvqsYbA9ZU/9pBf5f+mh/eas6G4qz2Uzmameoq4wEv3jML5JGHfEW0=
X-Received: by 2002:a05:6102:32c2:b0:46c:f612:9515 with SMTP id
 o2-20020a05610232c200b0046cf6129515mr1925982vss.15.1707279876997; Tue, 06 Feb
 2024 20:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <87sf25yqj2.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DbE=L24m8dhU7Bu324Ym=34LyZFB8Df32NYwKVapLGKQ@mail.gmail.com>
 <CAGsJ_4wc920zQ8niaQgn9V48P1S_KX2F5To9et+enJx8iR7+Bg@mail.gmail.com> <874jekzz6e.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874jekzz6e.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Feb 2024 17:24:25 +1300
Message-ID: <CAGsJ_4wBE7LZSJo=gA6Y+9aQwyy7o27OheYqxcaT8N54x4CFrQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:18=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Feb 7, 2024 at 3:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >>
> >> On Wed, Feb 7, 2024 at 10:10=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> >> >
> >> > Barry Song <21cnbao@gmail.com> writes:
> >> >
> >> > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org=
> wrote:
> >> > >>
> >> > >> Hi Kairui,
> >> > >>
> >> > >> Sorry replying to your patch V1 late, I will reply on the V2 thre=
ad.
> >> > >>
> >> > >> On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail=
com> wrote:
> >> > >> >
> >> > >> > From: Kairui Song <kasong@tencent.com>
> >> > >> >
> >> > >> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more =
threads
> >> > >> > swapin the same entry at the same time, they get different page=
s (A, B).
> >> > >> > Before one thread (T0) finishes the swapin and installs page (A=
)
> >> > >> > to the PTE, another thread (T1) could finish swapin of page (B)=
,
> >> > >> > swap_free the entry, then swap out the possibly modified page
> >> > >> > reusing the same entry. It breaks the pte_same check in (T0) be=
cause
> >> > >> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> >> > >> > install a stalled page (A) into the PTE and cause data corrupti=
on.
> >> > >> >
> >> > >> > One possible callstack is like this:
> >> > >> >
> >> > >> > CPU0                                 CPU1
> >> > >> > ----                                 ----
> >> > >> > do_swap_page()                       do_swap_page() with same e=
ntry
> >> > >> > <direct swapin path>                 <direct swapin path>
> >> > >> > <alloc page A>                       <alloc page B>
> >> > >> > swap_read_folio() <- read to page A  swap_read_folio() <- read =
to page B
> >> > >> > <slow on later locks or interrupt>   <finished swapin first>
> >> > >> > ...                                  set_pte_at()
> >> > >> >                                      swap_free() <- entry is fr=
ee
> >> > >> >                                      <write to page B, now page=
 A stalled>
> >> > >> >                                      <swap out page B to same s=
wap entry>
> >> > >> > pte_same() <- Check pass, PTE seems
> >> > >> >               unchanged, but page A
> >> > >> >               is stalled!
> >> > >> > swap_free() <- page B content lost!
> >> > >> > set_pte_at() <- staled page A installed!
> >> > >> >
> >> > >> > And besides, for ZRAM, swap_free() allows the swap device to di=
scard
> >> > >> > the entry content, so even if page (B) is not modified, if
> >> > >> > swap_read_folio() on CPU0 happens later than swap_free() on CPU=
1,
> >> > >> > it may also cause data loss.
> >> > >> >
> >> > >> > To fix this, reuse swapcache_prepare which will pin the swap en=
try using
> >> > >> > the cache flag, and allow only one thread to pin it. Release th=
e pin
> >> > >> > after PT unlocked. Racers will simply busy wait since it's a ra=
re
> >> > >> > and very short event.
> >> > >> >
> >> > >> > Other methods like increasing the swap count don't seem to be a=
 good
> >> > >> > idea after some tests, that will cause racers to fall back to u=
se the
> >> > >> > swap cache again. Parallel swapin using different methods leads=
 to
> >> > >> > a much more complex scenario.
> >> > >> >
> >> > >> > Reproducer:
> >> > >> >
> >> > >> > This race issue can be triggered easily using a well constructe=
d
> >> > >> > reproducer and patched brd (with a delay in read path) [1]:
> >> > >> >
> >> > >> > With latest 6.8 mainline, race caused data loss can be observed=
 easily:
> >> > >> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >> > >> >   Polulating 32MB of memory region...
> >> > >> >   Keep swapping out...
> >> > >> >   Starting round 0...
> >> > >> >   Spawning 65536 workers...
> >> > >> >   32746 workers spawned, wait for done...
> >> > >> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data =
loss!
> >> > >> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data=
 loss!
> >> > >> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data=
 loss!
> >> > >> >   Round 0 Failed, 15 data loss!
> >> > >> >
> >> > >> > This reproducer spawns multiple threads sharing the same memory=
 region
> >> > >> > using a small swap device. Every two threads updates mapped pag=
es one by
> >> > >> > one in opposite direction trying to create a race, with one ded=
icated
> >> > >> > thread keep swapping out the data out using madvise.
> >> > >> >
> >> > >> > The reproducer created a reproduce rate of about once every 5 m=
inutes,
> >> > >> > so the race should be totally possible in production.
> >> > >> >
> >> > >> > After this patch, I ran the reproducer for over a few hundred r=
ounds
> >> > >> > and no data loss observed.
> >> > >> >
> >> > >> > Performance overhead is minimal, microbenchmark swapin 10G from=
 32G
> >> > >> > zram:
> >> > >> >
> >> > >> > Before:     10934698 us
> >> > >> > After:      11157121 us
> >> > >> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >> > >> >
> >> > >> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of sy=
nchronous device")
> >> > >> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >> > >> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-=
desk2.ccr.corp.intel.com/
> >> > >> > Link: https://github.com/ryncsn/emm-test-project/tree/master/sw=
ap-stress-race [1]
> >> > >> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >> > >> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >> > >> > Acked-by: Yu Zhao <yuzhao@google.com>
> >> > >> >
> >> > >> > ---
> >> > >> > Update from V1:
> >> > >> > - Add some words on ZRAM case, it will discard swap content on =
swap_free so the race window is a bit different but cure is the same. [Barr=
y Song]
> >> > >> > - Update comments make it cleaner [Huang, Ying]
> >> > >> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [Seo=
ngJae Park]
> >> > >> > - Update the commit message and summary, refer to SWP_SYNCHRONO=
US_IO instead of "direct swapin path" [Yu Zhao]
> >> > >> > - Update commit message.
> >> > >> > - Collect Review and Acks.
> >> > >> >
> >> > >> >  include/linux/swap.h |  5 +++++
> >> > >> >  mm/memory.c          | 15 +++++++++++++++
> >> > >> >  mm/swap.h            |  5 +++++
> >> > >> >  mm/swapfile.c        | 13 +++++++++++++
> >> > >> >  4 files changed, 38 insertions(+)
> >> > >> >
> >> > >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> > >> > index 4db00ddad261..8d28f6091a32 100644
> >> > >> > --- a/include/linux/swap.h
> >> > >> > +++ b/include/linux/swap.h
> >> > >> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry=
_t swp)
> >> > >> >         return 0;
> >> > >> >  }
> >> > >> >
> >> > >> > +static inline int swapcache_prepare(swp_entry_t swp)
> >> > >> > +{
> >> > >> > +       return 0;
> >> > >> > +}
> >> > >> > +
> >> > >> >  static inline void swap_free(swp_entry_t swp)
> >> > >> >  {
> >> > >> >  }
> >> > >> > diff --git a/mm/memory.c b/mm/memory.c
> >> > >> > index 7e1f4849463a..1749c700823d 100644
> >> > >> > --- a/mm/memory.c
> >> > >> > +++ b/mm/memory.c
> >> > >> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> >> > >> >         if (!folio) {
> >> > >> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &=
&
> >> > >> >                     __swap_count(entry) =3D=3D 1) {
> >> > >> > +                       /*
> >> > >> > +                        * Prevent parallel swapin from proceed=
ing with
> >> > >> > +                        * the cache flag. Otherwise, another t=
hread may
> >> > >> > +                        * finish swapin first, free the entry,=
 and swapout
> >> > >> > +                        * reusing the same entry. It's undetec=
table as
> >> > >> > +                        * pte_same() returns true due to entry=
 reuse.
> >> > >> > +                        */
> >> > >> > +                       if (swapcache_prepare(entry))
> >> > >> > +                               goto out;
> >> > >> > +
> >> > >>
> >> > >> I am puzzled by this "goto out". If I understand this correctly, =
you
> >> > >> have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CA=
CHE.
> >> > >> The CPU1 will succeed in adding the flag and  the CPU2 will get
> >> > >> "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
> >> > >> correctly so far?
> >> > >>
> >> > >> Then the goto out seems wrong to me. For the CPU2, the page fault=
 will
> >> > >> return *unhandled*. Even worse, the "-EEXIST" error is not preser=
ved,
> >> > >> CPU2 does not even know the page fault is not handled, it will re=
sume
> >> > >> from the page fault instruction, possibly generate another page f=
ault
> >> > >> at the exact same location. That page fault loop will repeat unti=
l
> >> > >> CPU1 install the new pte on that faulting virtual address and pic=
k up
> >> > >> by CPU2.
> >> > >>
> >> > >> Am I missing something obvious there?
> >> > >
> >> > > I feel you are right. any concurrent page faults at the same pte
> >> > > will increase the count of page faults for a couple of times now.
> >> > >
> >> > >>
> >> > >> I just re-read your comment: "Racers will simply busy wait since =
it's
> >> > >> a rare and very short event." That might be referring to the abov=
e
> >> > >> CPU2 page fault looping situation. I consider the page fault loop=
ing
> >> > >> on CPU2 not acceptable. For one it will mess up the page fault
> >> > >> statistics.
> >> > >> In my mind, having an explicit loop for CPU2 waiting for the PTE =
to
> >> > >> show up is still better than this page fault loop. You can have m=
ore
> >> > >> CPU power friendly loops.
> >> > >
> >> > > I assume you mean something like
> >> > >
> >> > > while(!pte_same())
> >> > >    cpu_relax();
> >> > >
> >> > > then we still have a chance to miss the change of B.
> >> > >
> >> > > For example, another thread is changing pte to A->B->A, our loop c=
an
> >> > > miss B. Thus we will trap into an infinite loop. this is even wors=
e.
> >> > >
> >> > > is it possible to loop for the success of swapcache_prepare(entry)
> >> > > instead?
> >> >
> >> > This doesn't work too.  The swap count can increase to > 1 and be pu=
t in
> >> > swap cache for long time.
> >> >
> >> > Another possibility is to move swapcache_prepare() after
> >> > vma_alloc_folio() to reduce the race window.
> >
> > what about we make everything go as it is. I mean, we only need to
> > record we have failed on swapcache_prepare, but we don't goto out.
> >
> > bool swapcache_prepare_failed =3D  swapcache_prepare();
> > .... // don't change any code
> >
> >
> > but we only change the last code to set pte from the below
> >    ptl
> >    if(pte_same)
> >        set_pte
> >
> > to
> >
> >    ptl
> >    if(pte_same && !swapcache_prepare_failed)
> >         set_pte
> >
> > as the chance is close to 0%, the increased count should be very minor.
>
> IIUC, if (!swapcache_prepare_failed), it will always fail.  If so, why
> bother wasting CPU cycles?  If you return directly, and the first thread
> runs quickly enough, you can use the installed PTE directly.
>

you are right. i thought the actual probability of the race this patch is t=
rying
to fix is 0%. so we fix the final place of setting pte, we stop setting pte=
 once
we detect one race. but i was wrong because the one who fails on
swapcache_prepare could be the one who first gets PTL.

> --
> Best Regards,
> Huang, Ying
>
> >>
> >> Reducing the race window seems like a good way. Or maybe we can just
> >> add a cpu_relax() so raced swapins will just slow down, and won't loop
> >> too much time and so the side effect (counter or power consumption)
> >> should be much smaller?
> >
Thanks
Barry

