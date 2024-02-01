Return-Path: <linux-kernel+bounces-48264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A1845942
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E1B1F2712C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AF5CDE3;
	Thu,  1 Feb 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtaRQWGz"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CE5339F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795401; cv=none; b=qLSSjcTI4OLyU2fBxnH7FNiVDISXkQr49OsfCNVVrABW1BPNT1Kt/1v7VFAQrbgYfO7rzgwXQiBouXR4/bc1GPlbbnAxvqjzh3tG+1Oi4XF8DuaqSPEqhBiR7VVsffU4mn9NfXyHOtJEehcahWhut38ZSZuep5cKSkwU5zVEQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795401; c=relaxed/simple;
	bh=A7q7dngtZQ5X9XCAxm/FHS/MVGl/uIDzqSXQPejvulE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYfym91CgpzG1ILy1wG+6osvaiB8/puYa10iC49XHzJ1ryFVrFyoRygVxInylzALOIkeK0YHHtQiT/WLBt93xpJWfm4dyxBcqU/7YltwoAZhdWCFed428R7atpMiGAhxwZIM+nR94ZUvS2DIVKYP9xP6qq1zQJqFHOwhZhY7RG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtaRQWGz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso937756276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706795398; x=1707400198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhhpValrnXg9wEmbJjid2X14ibj0VJ0zXjyvvq0lkME=;
        b=YtaRQWGzDJBZRhoVfQKAJYZPF/w1amwiYRsIAcLfSttVW3TtQoeVZ9u0QRZekPLg8a
         xwvgo2zLhq958a4a0kiabk3cAbjMAHNxnqyteY0lHCSOr/VjvAmNXrDY6OWKk6ZdPEQR
         UueRXhsfObnWVAdXBzy2Q9OPJnQTTMRTQyTBeslQIXzJ68I6Tj5MlKIVXLIUcTku1Rt7
         cPUlzJt/ZWZ75pTkdTL3YU6O9npA+Vbs78/XX21gH/lCNBhelTtHdaSt75mlESyiy3wn
         LcTa6NDCffH/ao2fD8rEEK6YQIsuJvXrRFt9cVcyqN/fkAqEtGHXB4CGSGOjrmpKX0ir
         ShCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795398; x=1707400198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhhpValrnXg9wEmbJjid2X14ibj0VJ0zXjyvvq0lkME=;
        b=ai7nKT+WxJ5waKe29KlMC79iVG2+vpngLj/D0adYVH3DtwmAPcajzPvyVS/ai0LmUV
         Kvw9eMVZN71tBMvB2ImAxUmdmQfi8xKw/D/7DBndEvlgX8TEoXrznzfYmle635nAt+Kg
         +StC/Pe7K4fVz6Q8q9Mn5ENFHzhDeZwBGfismNHBhbsuGlvVGR9fe5jaLfQZHte30t1z
         Ns1XmAPBuvc8tSPllwRfkJQEnUjLz+GBmbhx6ATqRLsVWc2f1KUafdMqHL7Q5af3J2JO
         I6BxjTMq2ETk61eAVHhxPAYOgYWoWoqnZmQN131DkXI00X0nxtHY0KsGTG9Ol+ZNFhH1
         OeVg==
X-Gm-Message-State: AOJu0YzExIJM/pFfRrXnyZHeKv+KAkRpGuuN2rspfa4iXOJOyQF6z6BT
	fZuKmmhNcxpoQkUbjjlgRcLcEdBSjQGpjf6tJaG/SIpjPr9OgABwYrwyqzdWgSk5M/Uo+SkgVx7
	syny1r+L2F5kh8RpxGE3fI81gYyI=
X-Google-Smtp-Source: AGHT+IGjTaMc5KjjiL3/0HwpFMHOhMgLuhuLwIv43KYtBIRreoAaNLZkjmD+IzgcJCeZN9iWJORu44qhuEEAStymN7k=
X-Received: by 2002:a25:acc1:0:b0:db9:8670:5a7f with SMTP id
 x1-20020a25acc1000000b00db986705a7fmr4926802ybd.14.1706795398274; Thu, 01 Feb
 2024 05:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com>
In-Reply-To: <20240201125226.28372-1-ioworker0@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 1 Feb 2024 21:49:47 +0800
Message-ID: <CAK1f24nt+FyOnuMYOJeaafJjEiw7JXWtFYkqwNkbwOT7t8s0Hw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Minchan Kim <minchan@kernel.org>, 
	"Zach O'Keefe" <zokeefe@google.com>, Peter Xu <peterx@redhat.com>, 
	Muchun Song <songmuchun@bytedance.com>, Yang Shi <shy828301@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

THP:
enable=3Dmadivse
defrag=3Ddefer
max_ptes_none=3D511
scan_sleep_millisecs=3D1000
alloc_sleep_millisecs=3D1000

Test code:

// allocate a 2MB chunk using mmap and later
// release it by MADV_FRE
Link: https://github.com/ioworker0/mmapvsmprotect/blob/main/test5.c

root@x:/tmp# ./a.out | grep -B 23 hg
7f762a200000-7f762a400000 rw-p 00000000 00:00 0
Size:                     2048 kB
Anonymous:         2048 kB
LazyFree:             2048 kB
AnonHugePages:       0 kB
THPeligible:    1
VmFlags: rd wr mr mw me ac sd hg

// allocate a 2MB chunk using mmap and later
// some pages marked as lazyfree with MADV_FREE
Link: https://github.com/ioworker0/mmapvsmprotect/blob/main/test4.c

root@x:/tmp# ./a.out | grep -B 23 hg
7f762a200000-7f762a400000 rw-p 00000000 00:00 0
Size:                     2048 kB
Anonymous:         2048 kB
LazyFree:                   0 kB
AnonHugePages: 2048 kB
THPeligible:    1
VmFlags: rd wr mr mw me ac sd hg

root@x:/tmp# ./a.out
[...]
root@x:/tmp# echo $?
2



On Thu, Feb 1, 2024 at 8:53=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> The collapsing behavior of khugepaged with pages
> marked using MADV_FREE might cause confusion
> among users.
>
> For instance, allocate a 2MB chunk using mmap and
> later release it by MADV_FREE. Khugepaged will not
> collapse this chunk. From the user's perspective,
> it treats lazyfree pages as pte_none. However,
> for some pages marked as lazyfree with MADV_FREE,
> khugepaged might collapse this chunk and copy
> these pages to a new huge page. This inconsistency
> in behavior could be confusing for users.
>
> After a successful MADV_FREE operation, if there is
> no subsequent write, the kernel can free the pages
> at any time. Therefore, in my opinion, counting
> lazyfree pages in max_pte_none seems reasonable.
>
> Perhaps treating MADV_FREE like MADV_DONTNEED, not
> copying lazyfree pages when khugepaged collapses
> huge pages in the background better aligns with
> user expectations.
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/khugepaged.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..6cbf46d42c6a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -777,6 +777,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
>                                      pmd_t orig_pmd,
>                                      struct vm_area_struct *vma,
>                                      unsigned long address,
> +                                    struct collapse_control *cc,
>                                      spinlock_t *ptl,
>                                      struct list_head *compound_pagelist)
>  {
> @@ -797,6 +798,13 @@ static int __collapse_huge_page_copy(pte_t *pte,
>                         continue;
>                 }
>                 src_page =3D pte_page(pteval);
> +
> +               if (cc->is_khugepaged
> +                               && !folio_test_swapbacked(page_folio(src_=
page))) {
> +                       clear_user_highpage(page, _address);
> +                       continue;
> +               }
> +
>                 if (copy_mc_user_highpage(page, src_page, _address, vma) =
> 0) {
>                         result =3D SCAN_COPY_MC;
>                         break;
> @@ -1205,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct *mm,=
 unsigned long address,
>         anon_vma_unlock_write(vma->anon_vma);
>
>         result =3D __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
> -                                          vma, address, pte_ptl,
> +                                          vma, address, cc, pte_ptl,
>                                            &compound_pagelist);
>         pte_unmap(pte);
>         if (unlikely(result !=3D SCAN_SUCCEED))
> --
> 2.33.1
>

