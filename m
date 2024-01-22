Return-Path: <linux-kernel+bounces-34107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86383739E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089901C27AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E640BF8;
	Mon, 22 Jan 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er0lMKV+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EDE40BE2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954839; cv=none; b=al6UNAe/c2nGRoK6uLdCGNHmQ7UMJJySz2JgySFrBnws/w7hYc3u+nfVuS3iq2LCqt+vkIpGH+F4cN7G7nqXJ+1sSLlQm8oh0CWyc0sofWv3Tzwjw/Eoi9/6p55xzEnHKQEZJWJ24rODqROlFw5rMmjRWi6m9aMNpyB9hRiKj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954839; c=relaxed/simple;
	bh=dLNOfAM0vOpUBKxzAhGg/x8vkLaHHzSIuzvAfx08kxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSZ2tGMX7J68wDEjqoUzow7vsM56f4s/p5mJ3KhXhGPDgCU9V/23O8QAP2ls6zXKnU56hE+dnxcdzqIg1InwoKlVO56qwbbBiVIlC85QC1K7oJBNuupWi+bS15HlIpy0zP0YVoTXbXYqCCuq1f9/bYMG9O6PMjqcFIadTuiZdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er0lMKV+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1743431a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705954837; x=1706559637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yiVnaa7fFjiQFr9rzWcLPD6FI515d8YZDTG1m7LqNw=;
        b=er0lMKV+uatFmbQ2Uyr9WBWkwnSKQrATqtESwvBkyu9+i9XtJSWDI/FnzFbUnMV4/7
         xlpb6WZFAji+LTQzdlXx3v99rL2594zNgrx5ILEe2edqQHT4pxsgrfNGZ6giNrO2DEnD
         XX71kusHQ14yHTk6ABQWRqGezJGho+A0z/zSdLKAxDQFzZ/131RKcXJlU5XuB2pRdQ5u
         KBENT6H0Sv00Etb5+8103Fi8EvgD1mFR2mtY/HKDw5BzcK70FvVTciuUgMIvSQrTDwAR
         7wxOSpqmIEi3Hc7pHxhmad27Qwu75o6xKbNfdKoVDeRk+ebSP7zdpXJJHIgKYfxkKbHC
         2TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705954837; x=1706559637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yiVnaa7fFjiQFr9rzWcLPD6FI515d8YZDTG1m7LqNw=;
        b=LwIvzioKr8gXf0EIwUGZgsDNaLymfY5E83IgbHZ/NPKTTkVg7I9A4pmvpqKNcMeyJH
         Z1c1lYAJnERwjthghj2Fw8cywbDFUEulStZqc7QfCGemNWSMkRV+vkCXQNLMD8TPbM0G
         ytkCSKiJD6fueI+BgR2BJ1clrYBmxcVnovp4qjz/78inSxcEUU28iBPsGRJ0GKtJspaA
         Fiv8vGflnThIEzzNbVtiKf4iwKzqbGHSs/3mZq605QrbOX/+EERreymQ/xIla62BYNjW
         icgJM06jz9w+Ti5zuREK56dXhEvEFaIyA7cmdqhXO83yR3cgI7hBgvhHOF9L8+I/JvHL
         J09g==
X-Gm-Message-State: AOJu0YxYbVj3rSpNLElOw8EUlOHhsNXzHwrk0rpnbTy4TN+YskHwZW7K
	QWV9kmpPICJtxh2tTuu23nQG5MJjHqDx/M6aS7agdWxs7e4FfH2eNiamjA7zZS+5d/8g6ecfT91
	3sLbpxoB0Texq9y8rYpqbSg19qso=
X-Google-Smtp-Source: AGHT+IGfRRLp0QpMJf2c6UALTE0QEAbr/CTZWAiG37n+VmoEXFSobckpPUKU+13in2atzfiDB52SqVvM9/NXvWp1kUI=
X-Received: by 2002:a17:90a:65c5:b0:290:a1c8:91e5 with SMTP id
 i5-20020a17090a65c500b00290a1c891e5mr1193537pjs.61.1705954837336; Mon, 22 Jan
 2024 12:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
In-Reply-To: <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 22 Jan 2024 12:20:25 -0800
Message-ID: <CAHbLzko2+v0Urf3BxavV9tRvJ4+zyx6=nhKNN9OdFnB7auSrqg@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 20/01/2024 16:39, Matthew Wilcox wrote:
> > On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
> >> However, after this patch, each allocation is in its own VMA, and ther=
e is a 2M
> >> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slo=
wer
> >> because there are so many VMAs to check to find a new 1G gap. 2) It fa=
ils once
> >> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit=
 then
> >> causes a subsequent calloc() to fail, which causes the test to fail.
> >>
> >> Looking at the code, I think the problem is that arm64 selects
> >> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area() a=
llocates
> >> len+2M then always aligns to the bottom of the discovered gap. That ca=
uses the
> >> 2M hole. As far as I can see, x86 allocates bottom up, so you don't ge=
t a hole.
> >
> > As a quick hack, perhaps
> > #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > take-the-top-half
> > #else
> > current-take-bottom-half-code
> > #endif
> >
> > ?
>
> There is a general problem though that there is a trade-off between abutt=
ing
> VMAs, and aligning them to PMD boundaries. This patch has decided that in
> general the latter is preferable. The case I'm hitting is special though,=
 in
> that both requirements could be achieved but currently are not.
>
> The below fixes it, but I feel like there should be some bitwise magic th=
at
> would give the correct answer without the conditional - but my head is go=
ne and
> I can't see it. Any thoughts?
>
> Beyond this, though, there is also a latent bug where the offset provided=
 to
> mmap() is carried all the way through to the get_unmapped_area()
> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should be
> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, for arc=
hes
> that use the default get_unmapped_area(), any non-zero offset would not h=
ave
> been used. But this change starts using it, which is incorrect. That said=
, there
> are some arches that override the default get_unmapped_area() and do use =
the
> offset. So I'm not sure if this is a bug or a feature that user space can=
 pass
> an arbitrary value to the implementation for anon memory??
>
> Finally, the second test failure I reported (ksm_tests) is actually cause=
d by a
> bug in the test code, but provoked by this change. So I'll send out a fix=
 for
> the test code separately.

Thanks for figuring this out.

>
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4f542444a91f..68ac54117c77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(struct f=
ile *filp,
>  {
>         loff_t off_end =3D off + len;
>         loff_t off_align =3D round_up(off, size);
> -       unsigned long len_pad, ret;
> +       unsigned long len_pad, ret, off_sub;
>
>         if (off_end <=3D off_align || (off_end - off_align) < size)
>                 return 0;
> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(struct =
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

