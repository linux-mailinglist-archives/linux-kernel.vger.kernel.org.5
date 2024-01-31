Return-Path: <linux-kernel+bounces-45727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A919A8434B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6420D28A3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43541642A;
	Wed, 31 Jan 2024 03:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SajwtkWK"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82814A92
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673508; cv=none; b=QyveYOuIlHrGOgzCHa9NoApDDW/joQ9fuCMvCCgY2rOTLk49DQF6UgRUMI0Sp1E0UhtXfwZsJs44ZqYePH7PPjqulkYQIQ51n5Br3YBcbXwlFXm36EcS095dMNQ8XWiWXHx6kvJgr6kESlC7Yw0ldzLYfcfjS2suRIbdMCCovNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673508; c=relaxed/simple;
	bh=cEYajP8RyBirthoRohQY86C/2cv/x3jvMZfOxFSK5h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SONrD0EWDdBxPLHi/jizC5Czkbs6BPbW2D+EbWvKJ1oYcEg3RKAFhu/g17HPEUJifSo88TP/IMs7vKq4kkKkXoPLYhKXUMAfazO7QY2Eg34sw0QwixxT8NIh6fipy2g1Fj7x0kUjMYRS6EPX2e4rH+JpHr2/88dgkLoz1G9QKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SajwtkWK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf2fdd518bso45190441fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706673505; x=1707278305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAaSe8+T/arrMk7Fk8cpqOBnHTCzYyLZ2xpob2je3QM=;
        b=SajwtkWKbkMXTPGpZ2NOODNq2oJcM2u0jxIsJAubhZHfE299/ftqqZCa4AfSc6UgNj
         FZDaVdZHvxdRy1ovO0rsD8aHs0VnUPWnQbjoNSMEMSW4yVX/GVNIKropm/xtF2cB8gub
         DiNQr4x0TBMRtI3r9mUDfmswc/tueAUoCEdGhXG6N9AfyHU3edv9Th7y+TBi/1B9DBXL
         riWut3aJytfj+eN1NPd9b+4o8bW0E5yUYU9UOxeo1hRHTAiGB/DPtbiFP0fdpja6lGMW
         xvg8i92c7UzBsdIf/ob6M7M4Zqa0hIuAxNT9BfLtIKJH5ydiMoElFIk0T1etkqiUa4hd
         DBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706673505; x=1707278305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAaSe8+T/arrMk7Fk8cpqOBnHTCzYyLZ2xpob2je3QM=;
        b=bIf5KhVJuV9CwqTeDboFRoc0P7OpkDGzLpDyVebWGQJjkO9ipakipAp6M4aP87Qo5T
         qpzf7ITNtuysdW42Bbo1yNznr1rbBDuP+zQSlRbGGZM8domw3QKVfvuGbDjBH0tUzZ+P
         wSgR3FYVyemIFtVCZ2cFkG8mIwUyiQfTOiPut6p8mh2dJfXVs9UB5GM31dCQ3vpeVqDq
         OG3Ce+iETDTB99/lVB7AMwLDAN9El0/2+FxtxJwBSO8Vogq1syBTAadZ8ySKYc3os78U
         YiDtVMMymrg06SgJWFDTOEfNvoZQyiUly1WCOXRYy6X8ChwehbOGMxYcK/kGi6/Psvse
         2wzw==
X-Gm-Message-State: AOJu0YxtrGP6afjgtxM3hibSK7H11QmV40qI0EwrAMUoS1Og+9nQwioy
	HHbibjecoO5u/VnkgBpREfhK7PAufs2k7lkB9OlDokNYZEpIJ3uAvn8NMEFZlgoveYUsGWELbsg
	VnLCNYTl6A1SqnajJwOFjM7Gp+uM=
X-Google-Smtp-Source: AGHT+IFx5wTKfgGmvdC+6Rl9/qFDcAtDEzcqn7ISt1DggPNFXwBmV3V6bA4AbJS1VgLA+oNiX5rhldCg1vRyBMoZbp8=
X-Received: by 2002:a2e:92cc:0:b0:2d0:50c4:cafe with SMTP id
 k12-20020a2e92cc000000b002d050c4cafemr248168ljh.37.1706673504986; Tue, 30 Jan
 2024 19:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175423.1987-1-ryncsn@gmail.com> <20240129175423.1987-7-ryncsn@gmail.com>
 <87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 31 Jan 2024 11:58:07 +0800
Message-ID: <CAMgjq7DhjeeCehzj5hiO=v+X0Jg5mEpKim3k8abJA20TN63SHA@mail.gmail.com>
Subject: Re: Whether is the race for SWP_SYNCHRONOUS_IO possible? (was Re:
 [PATCH v3 6/7] mm/swap, shmem: use unified swapin helper for shmem)
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

On Wed, Jan 31, 2024 at 10:53=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Hi, Minchan,
>
> When I review the patchset from Kairui, I checked the code to skip swap
> cache in do_swap_page() for swap device with SWP_SYNCHRONOUS_IO.  Is the
> following race possible?  Where a page is swapped out to a swap device
> with SWP_SYNCHRONOUS_IO and the swap count is 1.  Then 2 threads of the
> process runs on CPU0 and CPU1 as below.  CPU0 is running do_swap_page().

Chris raised a similar issue about the shmem path, and I was worrying
about the same issue in previous discussions about do_swap_page:
https://lore.kernel.org/linux-mm/CAMgjq7AwFiDb7cAMkWMWb3vkccie1-tocmZfT7m4W=
Rb_UKPghg@mail.gmail.com/

"""
In do_swap_page path, multiple process could swapin the page at the
same time (a mapped once page can still be shared by sub threads),
they could get different folios. The later pte lock and pte_same check
is not enough, because while one process is not holding the pte lock,
another process could read-in, swap_free the entry, then swap-out the
page again, using same entry, an ABA problem. The race is not likely
to happen in reality but in theory possible.
"""

>
> CPU0                            CPU1
> ----                            ----
> swap_cache_get_folio()
> check sync io and swap count
> alloc folio
> swap_readpage()
> folio_lock_or_retry()
>                                 swap in the swap entry
>                                 write page
>                                 swap out to same swap entry
> pte_offset_map_lock()
> check pte_same()
> swap_free()   <-- new content lost!
> set_pte_at()  <-- stale page!
> folio_unlock()
> pte_unmap_unlock()

Thank you very much for highlighting this!

My concern previously is the same as yours (swapping out using the
same entry is like an ABA issue, where pte_same failed to detect the
page table change), later when working on V3, I mistakenly thought
that's impossible as entry should be pinned until swap_free on CPU0,
and I'm wrong. CPU1 can also just call swap_free, then swap count is
dropped to 0 and it can just swap out using the same entry. Now I
think my patch 6/7 is also affected by this potential race. Seems
nothing can stop it from doing this.

Actually I was trying to make a reproducer locally, due to swap slot
cache, swap allocation algorithm, and the short race window, this is
very unlikely to happen though.

How about we just increase the swap count temporarily in the direct
swap in path (after alloc folio), then drop the count after pte_same
(or shmem_add_to_page_cache in shmem path)? That seems enough to
prevent the entry reuse issue.

