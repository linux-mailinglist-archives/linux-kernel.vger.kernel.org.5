Return-Path: <linux-kernel+bounces-158023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EE8B1A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624F4B21FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EA3B29D;
	Thu, 25 Apr 2024 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeoWFQrj"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85D23CE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022786; cv=none; b=mKY71l8CYrticaI4eB8QV6mTULvEZsEzoZaUm5ADfF/gxj/w1knUax26eIiwmfom83aGCsYm+ITYslKKqkmKG8jkpOF8ehsW6PsZAQwdBoKrqMNdOWh0dLBEzW0Mti6cnjPCWhzXbA7aGwbTACVWLuLOrCBWWmu61BtM5ngGi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022786; c=relaxed/simple;
	bh=9ovT6b7MNfGv/Jda4rDiDUWp3cF6u7GPhmK/OGAJzyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WslBl+W8ljFB4dzQ7PxvJ1JcWtnYeXPzs7AgCLFsl+ZfnhdWypr/5EyAHMklgVd68e8kVoiF6gS8vu4YkrJOL6R/78Ryg2BEJpcV15NwUv9/cA7QyqBKSOgyhaSokvlqGkyfekdA5RldFFo3YbAZs8Kd29rVB2t4+2OtwbjYDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeoWFQrj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db17e8767cso5950361fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714022783; x=1714627583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA3a0+bFXC6l/JW4VkTNie0ZM8xCuh6B/dLkqCRLBy4=;
        b=TeoWFQrjYYnuG7aMHqd4oVfJf9FWWCQ4q9eoSUebiVSoEXKX5T+EnKl8Ixiu3fPdPA
         1A5YbMLp7rzaNU4wxupFVZ8d3upLnnwEViK/TUf3Ra5BxrQO3Uh4vE+C1ukd1JOtUV2m
         bdboAorFuZymlUWv3DZac5HJcFyME2JFQDYYRLDQ4/TLTwFN3jop+4YQcO7a+OqVS7GM
         4YxGiPiP7N/K4+ZPrsmVaIrCwQQHc9Fe2iRHaN8PbKxmtCBQ7C4kyHQiHC9iodzQ53lG
         hPnhspXdLtNFkVF4dbaL56KxSk6edNsZaHFC6gAV51LAm3Qq4rFOc1tUYO4NQgapruH0
         /Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714022783; x=1714627583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA3a0+bFXC6l/JW4VkTNie0ZM8xCuh6B/dLkqCRLBy4=;
        b=QgeKKyBNuzkce751EYpQzCUgyHJkEH67PAuzZ/0sIsSXQZ+sRBRcj+IOCM9QQ1gmW0
         5tBs7/X9ewfx629lI5reTQs8fFsSoPTaKsCa/i/+KG2ojOmaCrqQp9gg+/cQRwNRXXZq
         mROva4MNXaJHO7nSstjvgDEys/eRCKAR58hGjCT9BmHqvPvtZTeXelwQLV6qdh+w0YXN
         KjOC9TkyK1S+qmSAbnaOi5qLTIN6SN7X53iua5B/5F1cVn6+rbUpyEs7Znx54lqbR2fF
         60FvN7/kUGGaaZz2gIlaeWKacmsuOGW+u6+TMMvhrxjchBJB2t3hz4ayszfBbBwE0TIG
         2lmw==
X-Forwarded-Encrypted: i=1; AJvYcCWH1ByKtBae4jS9nnIHWhbdL0rNj4JfhMbkMjlWCGrnKWozhqDY/bJAc7Ymh+Ga/jr8T1xSaif+k2ZGUpOb7uXxSzA9oay+JfkbuPj4
X-Gm-Message-State: AOJu0Yxc7meIBe6IPTWx5bLTI+m6+yPgEfCNESKSFUx0rGfIUJbEDmDW
	sqpYPDmoW3oKH9X/LaqoAzsTyFcinzzzHprvoBUQGkvmAO/kSBRX4rdkmVZkSknz20pInM+FuZd
	4MF+GH7OYd9Iwk/3gIZPlzWKmQiC7RE3n
X-Google-Smtp-Source: AGHT+IFrb67qgSjyeVDAznm63CTsJ9iLCHY+xOxNABSowsOy7o0n1B26sXwESR/OyqGQubsMrQt+Y3jidOq+pOEoYl0=
X-Received: by 2002:a05:6512:40e:b0:518:d4c3:4682 with SMTP id
 u14-20020a056512040e00b00518d4c34682mr2723897lfk.24.1714022782549; Wed, 24
 Apr 2024 22:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-3-ioworker0@gmail.com>
 <0534d647-0753-4c34-943c-e705db1fbddd@arm.com>
In-Reply-To: <0534d647-0753-4c34-943c-e705db1fbddd@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 13:26:11 +0800
Message-ID: <CAK1f24m+k+UpRnq8hP6u4uyLOkGZMt8MtX+k3fS=OTDqdA85uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: add docs for per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, david@redhat.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Ryan,

Thanks for taking time to review!

On Wed, Apr 24, 2024 at 11:34=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 24/04/2024 14:51, Lance Yang wrote:
> > This commit introduces documentation for mTHP split counters in
> > transhuge.rst.
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index f82300b9193f..35d574a531c8 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -475,6 +475,22 @@ anon_swpout_fallback
> >       Usually because failed to allocate some continuous swap space
> >       for the huge page.
> >
> > +split_page
> > +     is incremented every time a huge page is split into base
>
> perhaps "...successfully split into base..." to make it clear that this i=
s only
> incremented on success.

Yep. Your suggestion does make it clearer.

>
> > +     pages. This can happen for a variety of reasons but a common
> > +     reason is that a huge page is old and is being reclaimed.
> > +     This action implies splitting all PMD/PTE mapped with the huge pa=
ge.
>
> What does it mean to "split all PTE"? It's already at its smallest granul=
arity.
> Perhaps "This action implies splitting any block mappings into PTEs."?

Nice. It would be clearer and better!

Thanks again for the suggestions!
Lance

>
> > +
> > +split_page_failed
> > +     is incremented if kernel fails to split huge
> > +     page. This can happen if the page was pinned by somebody.
> > +
> > +deferred_split_page
> > +     is incremented when a huge page is put onto split
> > +     queue. This happens when a huge page is partially unmapped and
> > +     splitting it would free up some memory. Pages on split queue are
> > +     going to be split under memory pressure.
> > +
> >  As the system ages, allocating huge pages may be expensive as the
> >  system uses memory compaction to copy data around memory to free a
> >  huge page for use. There are some counters in ``/proc/vmstat`` to help
>

