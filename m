Return-Path: <linux-kernel+bounces-168420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF78BB85C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4371C2291A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156484D03;
	Fri,  3 May 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxEEZzG2"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894880038
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779629; cv=none; b=Om3lgh6+5B1sPkBUQXgw2hmDaovp7Gbs/BAOQDdS2c0rqXVj49QkVC1NSHhD40fTttagw4qMqxdQHqbt1x/2T97msYxIt2fcLytMaKXe6qirmIbDGca9BkqVdp9Z/OleBKtXlLQyX/PdgKLEGR9LcmBjh7y5eqPneMbWmKiMXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779629; c=relaxed/simple;
	bh=lC80pCmO4KDPk3+H/Rise4KLSOe8YKki1PooEe4a0E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5TUBdwE01gL0faBli4rBVb+j0EOxoB33am24li0KKD3b+QBx5RNF+++uBc+eWtvqYoXOZQ/rcc2g6LJEftwv4JBZn3nFQSy/VhpHlMTfT4jP+y7KAsRfyVpJcJl6TnhwkurgjWuxIud6h0tumSDyTD+L8h+6ERs1o2Jd3HaKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxEEZzG2; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47ef9a05d6fso36439137.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714779627; x=1715384427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TYUHC6HPzfKj5/YyTSFNqCrAmae5EIR8KoLZK/tZ24=;
        b=MxEEZzG26GznVQhyuZrhOpf02BYn3e6VrjYvqYi1MWQuZ/ER49cR8V47s2DptZjV56
         6QM37nWpoYBnMZLwIlFUTx0ZOUvU5K7opL6UO+vLatSE5XEM7zoXvScN8lgVAihA7+b4
         c5ctXT/DoNeaFcTYsTrh93irYoO0GvQGfAqc4Lbg7jeFW4LB0WxsN39d+E+LXyuwDxnP
         EMILPJdElOEdwl+ZvkSDzgRHtvRZuJsO4zCrsTGDmv5zcZdNOKhBNASMdyBqnzJwVjOp
         IikV6TLOFDwi3MDH1Ydcmg2TG5aSy3RYXYUBKI2BxY2CgrKHkppm0kw+anO0YoEwnnaX
         dQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779627; x=1715384427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TYUHC6HPzfKj5/YyTSFNqCrAmae5EIR8KoLZK/tZ24=;
        b=XlNFQ6BPxi5yS9SuP4VjRwqa6GX3VAOQDjU9l8UrAGxQ1by4/EF24OBdxZNfF57cK2
         EYHHLG+OiJbI/QxYmqhjNpH2CyLyRu1sLqNb+/XnwKht/Gp9SNqa4KPPI6O2ct5AbQ0p
         3OKKCX2yjLK4yYw4jBy3CmPOADhh73Pb7AAgwZksyA+nPDn8c4w5MvpcrxZW19AAx0UZ
         Fm0Fn0PM0AtFTK6QxNCUexwv0U5MFHUeU3Y/q7ZxcoycZlho9FhTX/GFwkj6TNmWrnRf
         yqpaN0gETJTW0W7XZVrnlQtT+Tzm2121f262mO6sn7ycBnNDlhgpNIvS36voBwvnxnv1
         cdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt1yURoM9vqygqwsBtlZJF60jL1u98Xo7qoGO1eVx+qgyjUyIyL0yqBLPfi1oLhPhY4bwWv6IrApKaWJ6n99nHjEgPV0dr4m/5+z1D
X-Gm-Message-State: AOJu0YyIxtcbwY3fqP1DTBwfhoy5iZkELX30otpcq7B0jvgUdTQ/C1LQ
	R4CSihh9BAfs1e7RKCpr/6KY8Mhu0azyoXD7a9awKKlQxM17AEsLfmH56qi8yUTrbx76ITGtYKf
	6x8mF+ypt45yZooTb8I9MmTuILIk=
X-Google-Smtp-Source: AGHT+IGD/mAI021NpH5gkdvFb7aB6rdsm9wOJM0UduAXo8B49idF9sHO+qdSiU4GCUTJbaRdleo4EpOZ/oU1upg4jbM=
X-Received: by 2002:a05:6122:1826:b0:4da:e977:1fb7 with SMTP id
 ay38-20020a056122182600b004dae9771fb7mr4342098vkb.15.1714779626868; Fri, 03
 May 2024 16:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-4-21cnbao@gmail.com>
 <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com>
In-Reply-To: <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 4 May 2024 07:40:16 +0800
Message-ID: <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 5:41=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 03/05/2024 01:50, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > There could arise a necessity to obtain the first pte_t from a swap
> > pte_t located in the middle. For instance, this may occur within the
> > context of do_swap_page(), where a page fault can potentially occur in
> > any PTE of a large folio. To address this, the following patch introduc=
es
> > pte_move_swp_offset(), a function capable of bidirectional movement by
> > a specified delta argument. Consequently, pte_increment_swp_offset()
>
> You mean pte_next_swp_offset()?

yes.

>
> > will directly invoke it with delta =3D 1.
> >
> > Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/internal.h | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index c5552d35d995..cfe4aed66a5c 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *f=
olio, unsigned long addr,
> >  }
> >
> >  /**
> > - * pte_next_swp_offset - Increment the swap entry offset field of a sw=
ap pte.
> > + * pte_move_swp_offset - Move the swap entry offset field of a swap pt=
e
> > + *    forward or backward by delta
> >   * @pte: The initial pte state; is_swap_pte(pte) must be true and
> >   *    non_swap_entry() must be false.
> > + * @delta: The direction and the offset we are moving; forward if delt=
a
> > + *    is positive; backward if delta is negative
> >   *
> > - * Increments the swap offset, while maintaining all other fields, inc=
luding
> > + * Moves the swap offset, while maintaining all other fields, includin=
g
> >   * swap type, and any swp pte bits. The resulting pte is returned.
> >   */
> > -static inline pte_t pte_next_swp_offset(pte_t pte)
> > +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
>
> We have equivalent functions for pfn:
>
>   pte_next_pfn()
>   pte_advance_pfn()
>
> Although the latter takes an unsigned long and only moves forward current=
ly. I
> wonder if it makes sense to have their naming and semantics match? i.e. c=
hange
> pte_advance_pfn() to pte_move_pfn() and let it move backwards too.
>
> I guess we don't have a need for that and it adds more churn.

we might have a need in the below case.
A forks B, then A and B share large folios. B unmap/exit, then large
folios of process
A become single-mapped.
Right now, while writing A's folios, we are CoWing A's large folios
into many small
folios. I believe we can reuse the entire large folios instead of doing nr_=
pages
CoW and page faults.
In this case, we might want to get the first PTE from vmf->pte.

Another case, might be
A forks B, and we write either A or B, we might CoW an entire large
folios instead
CoWing nr_pages small folios.

case 1 seems more useful, I might have a go after some days. then we might
see pte_move_pfn().

>
> Anyway:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

thanks!

>
>
> >  {
> >       swp_entry_t entry =3D pte_to_swp_entry(pte);
> >       pte_t new =3D __swp_entry_to_pte(__swp_entry(swp_type(entry),
> > -                                                (swp_offset(entry) + 1=
)));
> > +                                                (swp_offset(entry) + d=
elta)));
> >
> >       if (pte_swp_soft_dirty(pte))
> >               new =3D pte_swp_mksoft_dirty(new);
> > @@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
> >       return new;
> >  }
> >
> > +
> > +/**
> > + * pte_next_swp_offset - Increment the swap entry offset field of a sw=
ap pte.
> > + * @pte: The initial pte state; is_swap_pte(pte) must be true and
> > + *    non_swap_entry() must be false.
> > + *
> > + * Increments the swap offset, while maintaining all other fields, inc=
luding
> > + * swap type, and any swp pte bits. The resulting pte is returned.
> > + */
> > +static inline pte_t pte_next_swp_offset(pte_t pte)
> > +{
> > +     return pte_move_swp_offset(pte, 1);
> > +}
> > +
> >  /**
> >   * swap_pte_batch - detect a PTE batch for a set of contiguous swap en=
tries
> >   * @start_ptep: Page table pointer for the first entry.
>

Barry

