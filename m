Return-Path: <linux-kernel+bounces-120720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F588DBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2759F1F2CD40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB955762;
	Wed, 27 Mar 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+9DzooR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35F54F8E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537505; cv=none; b=G+b4SDY2KWBJPTfLQzmNMUJL1ZktzlQexgLYoyLHTAM5llrTH3KOOEs2Y67r/X13O2smnBxGEVzzTTVwJ7oShuSOvzoTK+IOmuZ3gGVvNut+IL2xVxluIzjbdN89nTeRjnDM/UBwcFFGdvmyOA2vEUUjk4qk+lzptyKjFgigWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537505; c=relaxed/simple;
	bh=upv0HrU+fAJIXtKJgHf30BzfpxrYE164Sk0/vOZDB2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqocWj5qLlds/7QdF2F3MI/2jL2oL/ryKw/Xu4IKExb+jl/w3Ue/c6AqBRNoh/BmeRv3X4VxzPa1+ECjcIS+nkGOxEIAy5MkMtEt/VX4PCe1Kr5dLHyUxkAeWHab4TlSkf8i+vp+coidcZ7UuPznj8nfk2rwtsdsXLokUKlPpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+9DzooR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so2243941fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537502; x=1712142302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifymdw0r8QQrsy/jrDgRy80PrPmMAwYeA7nyVuXGI4A=;
        b=U+9DzooRBZ4xrCXQo/PaxI5sjVHA5IY+Lunf/RZe549AHh+5597a8CmCcgSSVkQO1O
         MiXqpx/Cc639dl8bZM/LSEfWKRE1tj/7P6vx03bYHeAaJuLVz5LrpkQgscHtVQaaxWTV
         YfZA/zZXrpePjt4LzN/KhDeW9uc6TCYM4pSRJopZ8NzCXjVCjKcsUp65ZaCdk76hmHrK
         +PcDye9Ika7PDq11EPrNR+sWtiFotquBzNi0fdM8mGC/uMPYPfAIP0n8BeGSC9d/AIaT
         3gBANIO15ixpPnneR7nCvj+WT1UryFPuulORQTBOn/iJBawsETBg214ZKLV0YUc/8oLh
         3/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537502; x=1712142302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifymdw0r8QQrsy/jrDgRy80PrPmMAwYeA7nyVuXGI4A=;
        b=trnWdinFAQoF6ZcEnVnGF8Ow3z7Lg3FwtlJVs9lr3TpSyQTwwfjFGQSPZXi70KsxzR
         uoeQUwCL+J62UcQ4EHQnfl8QlpWV8KwSH8kDfeSGb8u2x2Mli/Q1y6jbLf/FFkA/JFuf
         KpnTlCkZraCyCLlckwRKQK+sr7WLyhxcv3AJj/rC9IknXG6TII/o/2vnsNJ/e1YiwgMw
         OAFjsh0/E2JwygLKI7nxZXr4vjG49vGQGXJ3fmXFP6HtfMHVAFW0rm5RnI5Vzh0pifj8
         bcLaTHF59FrXm61HUqNjDh0HvV2uwprjr7OOUdP3dLsItTTRPXZZSvKyK7LCUylsryCc
         9sbg==
X-Forwarded-Encrypted: i=1; AJvYcCVQMf7tqdeA9KSRcB3TQUTEV1VmR2i/08+26b9jtlZqOynEPxTjPCbwjL/7dKsNhQwV3Q2w4RfbKzS9RiWo7nDD6suip3e+XUcW+hrd
X-Gm-Message-State: AOJu0YwMpzcsPBsuUQvgyI6lRIs/SVCkRUu3AV9eTcJHscz45c1eCa3J
	pe6DFoEg/2eaumYV/kAAjz9kgctAN8dKK0vAADdCPkjVDZBg9/77LKzNPwwUWCjrLSD/Z6nK1ZD
	OR+zkGMVrN5neqSaEHNCaMNFTDNc=
X-Google-Smtp-Source: AGHT+IFCtkun3aPv+TBFVnO2BQPj2UIM3665xmoS96Pe49jk/wc3sInWORK0KjckV4jOamBqI8twv7VVwZQ6tmPl69c=
X-Received: by 2002:a2e:9f4a:0:b0:2d2:4108:72a with SMTP id
 v10-20020a2e9f4a000000b002d24108072amr621779ljk.12.1711537501678; Wed, 27 Mar
 2024 04:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <878r24o07p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7B4Aejv16XK-zm9zPFrtVV1YutYWk5Ywzy8GwfMsTAXgA@mail.gmail.com> <58e4f0c2-99d1-42b9-ab70-907cf35ac1a7@arm.com>
In-Reply-To: <58e4f0c2-99d1-42b9-ab70-907cf35ac1a7@arm.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 19:04:45 +0800
Message-ID: <CAMgjq7D0XA=rd5CuonrYnHYeSJR3tqC1O49vj7Cr+su0MgOQ8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] mm/swap: always use swap cache for synchronization
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> [...]
>
> >>> Test 1, sequential swapin/out of 30G zero page on ZRAM:
> >>>
> >>>                Before (us)        After (us)
> >>> Swapout:       33619409           33886008
> >>> Swapin:        32393771           32465441 (- 0.2%)
> >>> Swapout (THP): 7817909            6899938  (+11.8%)
> >>> Swapin (THP) : 32452387           33193479 (- 2.2%)
> >>
> >> If my understanding were correct, we don't have swapin (THP) support,
> >> yet.  Right?
> >
> > Yes, this series doesn't change how swapin/swapout works with THP in
> > general, but now THP swapout will leave shadows with large order, so
> > it needs to be splitted upon swapin, that will slow down later swapin
> > by a little bit but I think that's worth it.
> >
> > If we can do THP swapin in the future, this split on swapin can be
> > saved to make the performance even better.
>
> I'm confused by this (clearly my understanding of how this works is incor=
rect).
> Perhaps you can help me understand:
>
> When you talk about "shadows" I assume you are referring to the swap cach=
e? It
> was my understanding that swapping out a THP would always leave the large=
 folio
> in the swap cache, so this is nothing new?
>
> And on swap-in, if the target page is in the swap cache, even if part of =
a large
> folio, why does it need to be split? I assumed the single page would just=
 be
> mapped? (and if all the other pages subsequently fault, then you end up w=
ith a
> fully mapped large folio back in the process)?
>
> Perhaps I'm misunderstanding what "shadows" are?

Hi Ryan

My bad I haven't made this clear.

Ying have posted the link to the commit that added "shadow" support
for anon pages, it has become a very important part for LRU activation
/ workingset tracking. Basically when folios are removed from the
cache xarray (eg. after swap writeback is done), instead of releasing
the xarray slot, an unsigned long / void * is stored to it, recording
some info that will be used when refault happens, to decide how to
handle the folio from LRU / workingset side.

And about large folio in swapcahce: if you look at the current version
of add_to_swap_cache in mainline (it adds a folio of any order into
swap cache), it calls xas_create_range(&xas) which fill all xarray
slots in entire range covered by the folio. But xarray supports
multi-index storing, making use of the nature of the radix tree to
save a lot of slots. eg. for a 2M THP page, previously 8 + 512 slots
(8 extra xa nodes) is needed to store it, after this series it only
needs 8 slots by using a multi-index store. (not sure if I did the
math right).

Same for shadow, when folio is being deleted, __delete_from_swap_cache
will currently walk the xarray with xas_next update all 8 + 512 slots
one by one, after this series only 8 stores are needed (ignoring
fragmentation).

And upon swapin, I was talking about swapin 1 sub page of a THP folio,
and the folio is gone, leaving a few multi-index shadow slots. The
multi-index slots need to be splitted (multi-index slot have to be
updated as a whole or split first, __filemap_add_folio handles such
split), I optimize and reused routine in __filemap_add_folio in this
series so without too much work it works perfectly for swapcache.

