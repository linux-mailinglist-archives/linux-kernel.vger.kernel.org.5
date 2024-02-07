Return-Path: <linux-kernel+bounces-55889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FD84C30C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC71B1C21B66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F586FC1E;
	Wed,  7 Feb 2024 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DABTFafu"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56300134A5;
	Wed,  7 Feb 2024 03:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276148; cv=none; b=QopHalN4qX/MeVUq6k6HTbq7tbpKmQ9gjRsw98DCfLB+fEWHHPi7LpkIGIrToSoYl9OVMqCO8orRD7rCRWVtNeB5U/7R72K5P3upoBK0qSbJBEWXBRpncnXiW5lDi9xDpEaLtzzZawTkHLEm61re/hx/0MRNU2ZEDvSkrAWt9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276148; c=relaxed/simple;
	bh=EUwXsAeafvheU34ZYGrPvwqqUg719UaM87XVl6tLgc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jm40nUK5pYnMsnxKjemLq4szc1VFbTsKf+BRRHfQk1U2ngH9SMCz9zb3hqpuZYfa4mo/ULqLlkvMPxCnVSWAmJS9+4aB/ganAQTwdzzBJF4j5cIAjDePfvZvjKpJgXqBD2R1BLFcjVZMJQVLVCFNDTU50MPf33uIVlhu3YCJs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DABTFafu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d073b54359so2182521fa.0;
        Tue, 06 Feb 2024 19:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707276144; x=1707880944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SfjAsyHe78ZWJcJN7VTTvSSClQB6d0Ch4i9jCFCMIU=;
        b=DABTFafu033P12JchNOhA8IwW2Bm6/asDNc3D9Wl6JsJ7Za3TfRHVZWoWHkFq1gy6p
         3vE2n7DBm/z92eRJSsHpBTFPz6U3x90CVXeKSNnhpWLzmXricDl6dvyleTKOGDBXGuAg
         6HjL0uryv/POFNs4gceVw5swFMd7Vg3aaXjnr6GuD73SZOA27Ux7b6kKBTHCx3lWN/IV
         B2QmZ/si9IV7PaBwc5WM5m8LsOMyAgxbBbRW8lyJTrR8ehnq+sbYXM4OT/KcXW4eAkag
         OWtUnliPnxphLFhHhJtdeYeU1wcHDgC4UTdbEeQhc32IyLrnq4srDYv5VxicoKsMl1iJ
         8/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276144; x=1707880944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SfjAsyHe78ZWJcJN7VTTvSSClQB6d0Ch4i9jCFCMIU=;
        b=cVWMDKYm+hsHCumcrrwIprbwwgsi54zU0vgNEBPHWiJWSstkNkSGAmBssEhPElgJAE
         ZLAEONBron7bIkJSXKgF1sjRn9cnaaR/bNcm3kYB18Avs9UCWDRP2eLgY877q7/CBsfN
         3Xbd5EfolX+bJ1p7aF96CJvMcjC25JGMj2ROPN04qBM+y5rSYp9nY+MJsBOI60zFWlhI
         EWIhYOJQvXUgYwu2+wb1KXxRXwb1OSUsPHzA8+qHlR6w0TxjNDtQeKw+X86ccaYP2mnS
         vu+brNQsRfQ0jjpPXfbL7gXrpWUeQ50LWNzYKCNeR9H3n8ICHMXdgyQ1OHpYMUcLc6Uk
         H0GA==
X-Forwarded-Encrypted: i=1; AJvYcCURlpIXFVSsIsRzb9s5Z/8wje/FO5otqOkroRTGCpk0Vt5+gnKI8ox5t9J9bs4103NZbaCBjgtMhrI+4ul6t4bvob03hHaImszxEdWIYfCYA0fbrOSUgiLZ4gsrJPOXBcg2qG1Y
X-Gm-Message-State: AOJu0YwZUOVvz0ZDKiQ8rCZBzCgBhSAt4WRJ/WmkVmKvCE01UYGJlKVI
	1trzNH9nNqxmDwPSaOyMo4z5an9DF/+y9IGziT4LaJCJ6nGioJyQuV5pPoPlof3zmGM5KdfIDx7
	esx0Ke/D6bpvYNEmvXDYWKCahbmk=
X-Google-Smtp-Source: AGHT+IGuCo/YzpCdSBEuSCbLbhhevXbaJ6FAZVtPsU8iP9rnc8AmpdYdhjzYQrwQPM4AktT5rfPdXI8pqSsxvVv9S1c=
X-Received: by 2002:a2e:a273:0:b0:2d0:9322:8d0f with SMTP id
 k19-20020a2ea273000000b002d093228d0fmr2322153ljm.26.1707276143429; Tue, 06
 Feb 2024 19:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <ZcK6bZpGEtgqBeZs@google.com>
In-Reply-To: <ZcK6bZpGEtgqBeZs@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 7 Feb 2024 11:22:05 +0800
Message-ID: <CAMgjq7AgZ6VQH0YnOvfRY8QsNgHSLSciPBkKM046_4gLyZHz7w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:02=E2=80=AFAM Minchan Kim <minchan@kernel.org> wro=
te:
>
> On Wed, Feb 07, 2024 at 02:25:59AM +0800, Kairui Song wrote:
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
>
>                                        ^^^
> nit: From the recent code, I see swap_free is called earlier than set_pte=
_at

Thanks, will update the message.

>
>
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
>
> Thanks for catching the issue, folks!
>
> >
> > To fix this, reuse swapcache_prepare which will pin the swap entry usin=
g
> > the cache flag, and allow only one thread to pin it. Release the pin
> > after PT unlocked. Racers will simply busy wait since it's a rare
> > and very short event.
> >
> > Other methods like increasing the swap count don't seem to be a good
> > idea after some tests, that will cause racers to fall back to use the
> > swap cache again. Parallel swapin using different methods leads to
> > a much more complex scenario.
> >
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
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.cc=
r.corp.intel.com/
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > Acked-by: Yu Zhao <yuzhao@google.com>
> >
> > ---
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
> >  include/linux/swap.h |  5 +++++
> >  mm/memory.c          | 15 +++++++++++++++
> >  mm/swap.h            |  5 +++++
> >  mm/swapfile.c        | 13 +++++++++++++
> >  4 files changed, 38 insertions(+)
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
> > index 7e1f4849463a..1749c700823d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> > +                     if (swapcache_prepare(entry))
> > +                             goto out;
> > +
> >                       /* skip swapcache */
> >                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> >                                               vma, vmf->address, false)=
;
> > @@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  unlock:
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +     /* Clear the swap cache pin for direct swapin after PTL unlock */
> > +     if (folio && !swapcache)
> > +             swapcache_clear(si, entry);
> >  out:
> >       if (si)
> >               put_swap_device(si);
> > @@ -4124,6 +4137,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out_page:
> > +     if (!swapcache)
> > +             swapcache_clear(si, entry);
> >       folio_unlock(folio);
> >  out_release:
> >       folio_put(folio);
>
> What happens?
>
> do_swap_page
>   ..
>   swapcache_prepare() <- tured the cache flag on
>
>   folio =3D vma_alloc_folio <- failed to allocate the folio
>   page =3D &foio->page; <- crash but it's out of scope from this patch
>
>   ..
>   if (!folio)
>      goto unlock;
>
> ..
> unlock:
>   swapcache_clear(si, entry) <- it's skipped this time.
>
>
> Can we simply introduce a boolean flag to state the special case and
> clear the cache state based on the flag?

Good idea, that should make the code easier to understand.

