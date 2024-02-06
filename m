Return-Path: <linux-kernel+bounces-54429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C389484AF21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3978E1F23F84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A212883F;
	Tue,  6 Feb 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gakFgU7O"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C7128837
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205154; cv=none; b=Srb2FVg2fpjGIcNK9+xhvTA7ByBRBOn5gBT+qS0aaIjwpDGv9Jq3fA9UBMabrFnEGRcpYe55uyW1DQDPrQ0Z4RVRTifbfaLFUIqS2RrRxFhuz6uklhtvD94x4H56KKbokBXTo/xXukXgXXr0A6UObTkOwaVi02gdCvpWAnHKOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205154; c=relaxed/simple;
	bh=BWWMFVM2s4Ox494CaC5CyZo0UajFxda/MzFAPnh2eVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2xm4IdxDl5PEjmCV6EoodO+9n8aMptD2iMq4CigOSuEoW5IHSuX9R/394Ch/kMippbDJO+UzxRTrp3grp4+yAZlNLIJAWvEnh08gaNkZI+lOlICbgAhRLGjpOi5Q12O6UZlUerOpDv7pessWR8TyZIbNXgP+D+OEpQSiXABCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gakFgU7O; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d093cb1ef3so38028471fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707205150; x=1707809950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEm7mOJ011S0VyrqJbaw++p65z5dZn5VqwG07p5sWdU=;
        b=gakFgU7ORmv2Te5egLHZ7PGFhuafM3OtC2ZQoz6mvGtt910MMGWBkzYuENP0DUcXZ1
         H6egPQWD2iDNHkCkS24zNB9rfpkmGwxobZo7QSTTraVeOMyVLrn0jNWtGpWcdyQkQSpp
         KdqGxqatNXNF5whSf1zSBKfrPATDAkMJVW1Uh07EvhjumvKeaCiQnE/LDpRmbl8vIaAM
         mO4bt2hyjMFEZ+3ngZ16BNQ7CvNM4vjUSorVpjMU8JjQkm+lWT6ykpp94fm/Rw4dYqVz
         GKH0pN6kHFohpTAWE/x/3eQ/oNZ59Sl2Sx/lW4rB20n83XrEPi6dS+6s8hubT4e/pAdy
         3+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205150; x=1707809950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEm7mOJ011S0VyrqJbaw++p65z5dZn5VqwG07p5sWdU=;
        b=VaOPhoHUw+aoTDwroDY8RRqG2KmVrCxx8kSDc4S0g1ZN63VZsIVgxE5fuSNFfRRBDp
         I1AXDf2ay1MyP79KXBzklUrD0vSwvsEwGwDuAgoZG93QlvG1VP7AJ4Dj8h1tbQqiNALB
         seK+OPjLRa/7oyeqonhbHztU+vFdeTi413v91saYyu+Fx1m3X2Pi03Eu69maoloLKGV9
         tF4l45Vze25xQVU7HZJzUMdYq6dDjNb7ZKX36cX+khZYvihQfF0++goCquYorSvQDRow
         VsTKQTI8e1s39bTJGtIZNwD0FpJ45jJEapMz2h6TOWi8jo6L3E/qgNcNU9lYYgi3opNY
         5wPQ==
X-Gm-Message-State: AOJu0Yx8QlHSCmvywTTrRSjZ7mX84kIqupaLkxc4v3jJzDgf/Xzs5lqd
	rFK6EgO9MKd/dbTSoNLtQ4umbBSVyQYaNpO949Cnq64rFTFC57/l0BAJvN94UVOmaWVEbrXqOMK
	AatHQD06TdWgYa+wV6vbXC0uLUEU=
X-Google-Smtp-Source: AGHT+IHzLBDl5xvhebPGq0XGAgn7QlfFsf14RlJNyjGTura3QNWPW72aHbwGFBgkdYfHOouaEaBHb4FASTpHpHSaKUY=
X-Received: by 2002:a2e:be23:0:b0:2d0:bf7f:a964 with SMTP id
 z35-20020a2ebe23000000b002d0bf7fa964mr503930ljq.32.1707205150041; Mon, 05 Feb
 2024 23:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110959.4021-1-ryncsn@gmail.com> <CAOUHufYYoW6Nn26YsdBwxDw8iNLRf2c6ZLoF530YCgYZ2uvikQ@mail.gmail.com>
In-Reply-To: <CAOUHufYYoW6Nn26YsdBwxDw8iNLRf2c6ZLoF530YCgYZ2uvikQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 6 Feb 2024 15:38:51 +0800
Message-ID: <CAMgjq7ALbFbmQDnt8KPwB0h9j5E5SBEJn7bC+NVMhX__U8w12Q@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:03=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Feb 5, 2024 at 4:10=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > In the direct swapin path, when two or more threads swapin the same ent=
ry
>
> There is no other places referring to that path as "direct" swapin.
>
> I'd rephrase it as: "When skipping swapcache for SWP_SYNCHRONOUS_IO,
> ...", and similarly for the subject: "mm: fix race when skipping
> swapcache".

Good suggestion.

>
> > at the same time, they get different pages (A, B) because swap cache is
> > skipped. Before one thread (T0) finishes the swapin and installs page (=
A)
> > to the PTE, another thread (T1) could finish swapin of page (B),
> > swap_free the entry, then modify and swap-out the page again, using the
> > same entry. It break the pte_same check because PTE value is unchanged,
> > causing ABA problem. Then thread (T0) will then install the stalled pag=
e
> > (A) into the PTE so new data in page (B) is lost, one possible callstac=
k
> > is like this:
> >
> > CPU0                                CPU1
> > ----                                ----
> > do_swap_page()                      do_swap_page() with same entry
> > <direct swapin path>                <direct swapin path>
> > <alloc page A>                      <alloc page B>
> > swap_readpage() <- read to page A   swap_readpage() <- read to page B
> > <slow on later locks or interrupt>  <finished swapin first>
> > ...                                 set_pte_at()
> >                                     swap_free() <- Now the entry is fre=
ed.
> >                                     <write to page B, now page A stalle=
d>
> >                                     <swap out page B using same swap en=
try>
> > pte_same() <- Check pass, PTE seems
> >               unchanged, but page A
> >               is stalled!
> > swap_free() <- page B content lost!
> > set_pte_at() <- staled page A installed!
> >
> > To fix this, reuse swapcache_prepare which will pin the swap entry usin=
g
> > the cache flag, and allow only one thread to pin it. Release the pin
> > after PT unlocked. Racers will simply busy wait since it's a rare
> > and very short event.
> >
> > Other methods like increasing the swap count don't seem to be a good
> > idea after some tests, that will cause racers to fall back to the
> > cached swapin path, two swapin path being used at the same time
> > leads to a much more complex scenario.
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
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Cc: stable@vger.kernel.org
>
> Acked-by: Yu Zhao <yuzhao@google.com>

Thanks!

