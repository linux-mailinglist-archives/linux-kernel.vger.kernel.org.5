Return-Path: <linux-kernel+bounces-35821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28208396F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE691F21305
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3BB811F2;
	Tue, 23 Jan 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+KzfHf7"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C508005F;
	Tue, 23 Jan 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032360; cv=none; b=oBVPcly5qKivQMznct+6EG50Bd2HG4NuyqW5v4ssCkOmDLTRDNwzhDIImk+Qr/3btc31vJQsaYe6cKNKJnMtR2Sc58EDiE3oaomBfKk4jm0iARZjp1mHfkO/uMflEMYncsDOSAIOPznqRkJI7L1SukQPlQnPYsES9o65HDGoSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032360; c=relaxed/simple;
	bh=V90tPfXclyWgYJ8XSgTwtSfsNlq3s+A6d1xZbgWpDwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQmXiqeCcSVhJMMhvr4mjgg8G/qSzpHOq40cO6Ek3AW+QzP4JIudZOH55N5UG6BAB61YIcRwSeQ1WSI7shdLh8K12LzLe54GGc31tVRba/yBRDEaQhhxoPmS72+d8p1MCRXNG0gznSrL1iyKQFwTXbIwy39so2Vd1VUHOSO+6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+KzfHf7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290ec261a61so72535a91.0;
        Tue, 23 Jan 2024 09:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032358; x=1706637158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUhLXTm6NgtNUKfl8Ydcm6SSUWs92JF5Lv5SsIRmk5A=;
        b=I+KzfHf7NfThg7ADn6kDa2xY8SPUUxj/PLLoqL+GYPzP19oNvurIZm92+ffLGZtPWD
         cpf0DQqtePZ2Ynep5/HCRXo18flZmxYwIBhNSOx80DAziAmb/IIlKHGzOn9flYy6Wgdy
         YjCs2tB5rTeVViiMO78ZSavCdGMyhH5qTR5QDbuEiRc+wqX/FN0q2VZQKytQ6K9rZhaf
         2vDw0pIhq4mODdXWgY1vIRaG2eAMcYfvQBPv6Ph/Md/THC3YbT5FhPoGTYmT1+N/VeW0
         hQ5Z8RA6dR30NRzIN5fmP9K9v+t6YVbIG81Mt0QUYNGlynNk4hYGKe8jmkTACSaGXJGs
         E3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032358; x=1706637158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUhLXTm6NgtNUKfl8Ydcm6SSUWs92JF5Lv5SsIRmk5A=;
        b=nQrXWoWLueyu05j2czL6cJ51+9rgaGixlyYxIqm4ZyA56dP9QJnnZLRcTDrf/7IbVW
         zXrt8b4VVC5imR+zkmAaIeOUE/Ttr/yip0/SUXfoRjknttCG80abvHowHP6KgjlVttkr
         1vIby49WUgpeYpHsGK+lKYdmYizW9ciovwTvSO8JP/kzMvcj+GtOXx/uepSjPpcYOZXE
         zFlX0ZymMRIG8rM3ERm3EZICdsZrx0eSK2yhjX4+gG4+NrGDjWVR3yQqmx33Lv4LREgh
         lqt2BsvQ/03KZwLV//xG1Rf1PEGcR1hQT8DzpO2APyl8BpEIi6wUtvp1o7sRjwFlpPC/
         rUHA==
X-Gm-Message-State: AOJu0YzgNr87iwbYT2ITGNEkrEHDIj8DsfTk6OxQt9aDaFmSztw2aKdW
	9btMP2aPgERwE0ekfFLCPOn36+UlaDbD8+KonARPob1yhDwQGhvAaSF6z1ZyepAjxbPIDKGowlt
	7EUKyuss/SiWIMZQR9rSHU1VvLqw=
X-Google-Smtp-Source: AGHT+IFKYmAEAvoatOUmVhLild3TQJSwbKJoH54epWxtSe45P38ktiHvNTzMUkTOygI1dp3hLf6EgylAvHCx2+uNqa0=
X-Received: by 2002:a17:90a:4ce5:b0:28e:7b6b:5d0 with SMTP id
 k92-20020a17090a4ce500b0028e7b6b05d0mr2666444pjh.67.1706032358537; Tue, 23
 Jan 2024 09:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123171420.3970220-1-ryan.roberts@arm.com>
In-Reply-To: <20240123171420.3970220-1-ryan.roberts@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 23 Jan 2024 09:52:26 -0800
Message-ID: <CAHbLzkpXNDJy+p96maDeYa7rrqHUG+Go6epdqeUog-0xabiGiw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: thp_get_unmapped_area must honour topdown preference
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> The addition of commit efa7df3e3bb5 ("mm: align larger anonymous
> mappings on THP boundaries") caused the "virtual_address_range" mm
> selftest to start failing on arm64. Let's fix that regression.
>
> There were 2 visible problems when running the test; 1) it takes much
> longer to execute, and 2) the test fails. Both are related:
>
> The (first part of the) test allocates as many 1GB anonymous blocks as
> it can in the low 256TB of address space, passing NULL as the addr hint
> to mmap. Before the faulty patch, all allocations were abutted and
> contained in a single, merged VMA. However, after this patch, each
> allocation is in its own VMA, and there is a 2M gap between each VMA.
> This causes the 2 problems in the test: 1) mmap becomes MUCH slower
> because there are so many VMAs to check to find a new 1G gap. 2) mmap
> fails once it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting
> this limit then causes a subsequent calloc() to fail, which causes the
> test to fail.
>
> The problem is that arm64 (unlike x86) selects
> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area()
> allocates len+2M then always aligns to the bottom of the discovered gap.
> That causes the 2M hole.
>
> Fix this by detecting cases where we can still achive the alignment goal
> when moved to the top of the allocated area, if configured to prefer
> top-down allocation.
>
> While we are at it, fix thp_get_unmapped_area's use of pgoff, which
> should always be zero for anonymous mappings. Prior to the faulty
> change, while it was possible for user space to pass in pgoff!=3D0, the
> old mm->get_unmapped_area() handler would not use it.
> thp_get_unmapped_area() does use it, so let's explicitly zero it before
> calling the handler. This should also be the correct behavior for arches
> that define their own get_unmapped_area() handler.
>
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundari=
es")
> Closes: https://lore.kernel.org/linux-mm/1e8f5ac7-54ce-433a-ae53-81522b23=
20e1@arm.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks for debugging this. Looks good to me. Reviewed-by: Yang Shi
<shy828301@gmail.com>

> ---
>
> Applies on top of v6.8-rc1. Would be good to get this into the next -rc.

This may have a conflict with my fix (" mm: huge_memory: don't force
huge page alignment on 32 bit") which is on mm-unstable now.

>
> Thanks,
> Ryan
>
>  mm/huge_memory.c | 10 ++++++++--
>  mm/mmap.c        |  6 ++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 94ef5c02b459..8c66f88e71e9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -809,7 +809,7 @@ static unsigned long __thp_get_unmapped_area(struct f=
ile *filp,
>  {
>         loff_t off_end =3D off + len;
>         loff_t off_align =3D round_up(off, size);
> -       unsigned long len_pad, ret;
> +       unsigned long len_pad, ret, off_sub;
>
>         if (off_end <=3D off_align || (off_end - off_align) < size)
>                 return 0;
> @@ -835,7 +835,13 @@ static unsigned long __thp_get_unmapped_area(struct =
file *filp,
>         if (ret =3D=3D addr)
>                 return addr;
>
> -       ret +=3D (off - ret) & (size - 1);
> +       off_sub =3D (off - ret) & (size - 1);
> +
> +       if (current->mm->get_unmapped_area =3D=3D arch_get_unmapped_area_=
topdown &&
> +           !off_sub)
> +               return ret + size;
> +
> +       ret +=3D off_sub;
>         return ret;
>  }
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b78e83d351d2..d89770eaab6b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1825,15 +1825,17 @@ get_unmapped_area(struct file *file, unsigned lon=
g addr, unsigned long len,
>                 /*
>                  * mmap_region() will call shmem_zero_setup() to create a=
 file,
>                  * so use shmem's get_unmapped_area in case it can be hug=
e.
> -                * do_mmap() will clear pgoff, so match alignment.
>                  */
> -               pgoff =3D 0;
>                 get_area =3D shmem_get_unmapped_area;
>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>                 /* Ensures that larger anonymous mappings are THP aligned=
 */
>                 get_area =3D thp_get_unmapped_area;
>         }
>
> +       /* Always treat pgoff as zero for anonymous memory. */
> +       if (!file)
> +               pgoff =3D 0;
> +
>         addr =3D get_area(file, addr, len, pgoff, flags);
>         if (IS_ERR_VALUE(addr))
>                 return addr;
> --
> 2.25.1
>

