Return-Path: <linux-kernel+bounces-168392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB328BB7E6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA481F23FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E6839F5;
	Fri,  3 May 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD0SB3vm"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416782492
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777669; cv=none; b=tNOPUs4bd9B5zagT1UkUkiA3iWDEi2BkgrTYlCMtfs74LOwnC4NRfMt+aJXu5uH5y1LQn8AV+5wdNt2QIWzUcp74bDq33Qj48hUOnG0JEX/YVj26mM+FqvKjUoF4j/dMu/Ss5EzLbaeLLCZDB5uExQQaZNxV/PRTt5y1JD5yh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777669; c=relaxed/simple;
	bh=/5ybaxvOeG6MsqwtGjXvR6veNzdA6jN8o68EjpUR0Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzuWit6rjxq+QTXVt5A5bSw8ePfJK0t4xd2+E5ENWUhZSc2JsDUxCKwKgYkvtJPbNPj+I1yNB2HxG4jiNxRrgEa6SSuc+35pGDo7eJkGyV33F/TL3X4etFf7cwlYiAjBoF+WdG7sk4blD5y1f6I1h+EJaSb2Ke/+iOrANfV1hqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD0SB3vm; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df214fdc37so115146e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714777667; x=1715382467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUbOS6D2g2gENRNkXqTKMUx8StRDzYw0mjTF4N3SPA8=;
        b=CD0SB3vmKSFJM4emADDNVWGp3AbFN/n5YwvZDMUJgGGGR91OWEleyQOU1rN39ahcYk
         emZvWW75+w0d2jypOZQrOIzE1j9BAgxLKnnOZ0/TyzlcqVc6xYY5HNEmH4z951LBzPuu
         rsENt02fyo5XS4uPRilbcYEaw3lKs/E9bmFS56V36KSzaSYi/wlP1gltCZmqEaS08Sn6
         Q5VoW+clOSBYBZd9ZCl+lKz9GV772T8ztLCqADFsLNXwk6jx76HmbyQlD3aqQoWKERy/
         wu5zz6ImrNAg3ZBc5dsYTjdAnQZ1IlIT5KX4gc0wNArY/ka+NxEqRM3yyGu7AjtUHmNh
         6diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714777667; x=1715382467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUbOS6D2g2gENRNkXqTKMUx8StRDzYw0mjTF4N3SPA8=;
        b=Z3T25DQXTPK5/+jBELFAJ0uBNZmOtYPuYGF9/2h7dO720i5s7sJ4ByllzlhBrz+KiZ
         d7HFsdcHqh6xkO6gA3fNd32JMAz7qJ7B1cWYMfrum9T2q8Up+5Q5+Z5nJYZK9eYPvw1D
         0Rfscl+v1YWrWXczP/eCKOidnxlsG8yvbOwwfAmfv67qNETlcN39LT27M6h3/Fpjxtrx
         yrwsmF6Wc4boRrWPb0Gzq3hbe/ip+4JGI75QJSGpFGQXSrd/v46RfeQElP6g0MAhkYAa
         SDR/Bn12S8TlNrI2AGy3r52ov/1eZSQ8eYIgv4vdUx5RomRmWrpI/W0muyJndDSbQvQ9
         Xa+A==
X-Forwarded-Encrypted: i=1; AJvYcCX0rd1kP5BiY1qv+wdfEJhkqQbUMpQVzfs4zG8jqYfIEoyja0mVa7a1QvyJIsN4mqwz3GQxIxn6bQ2Stav+SZEUdDlD4HnIhWZiA7Jm
X-Gm-Message-State: AOJu0YxUyzrJhQosYRxxQvicskwboP5i5Z9aMWctclemnD2OcL2EBaT8
	oJJw0f8KxXBNm1a9OiEAYmHybiICv0mkBTranTa089/QLZNdfxYnOWAe19cBsIkkNj2qQYXPEQG
	D5h/JI7vh58DUldf3R0YpnZlBmGs=
X-Google-Smtp-Source: AGHT+IF1hr1CJo+evRVIfzH2sj7nOEmf2zzNTCkvZD7vuBhTgtU6J/x32S+gYuXY6SfIXfRbzCHeZEw6zbHjqo+ebls=
X-Received: by 2002:a1f:4883:0:b0:4da:ddb4:feca with SMTP id
 v125-20020a1f4883000000b004daddb4fecamr7980943vka.8.1714777666946; Fri, 03
 May 2024 16:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-4-21cnbao@gmail.com>
 <CANeU7Q=RFC7i6q=BjK3cXG+J0U2KeGMDuz0sV1K2sG2ifvpYcw@mail.gmail.com>
In-Reply-To: <CANeU7Q=RFC7i6q=BjK3cXG+J0U2KeGMDuz0sV1K2sG2ifvpYcw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 4 May 2024 07:07:35 +0800
Message-ID: <CAGsJ_4yfe1m-BENu1vLW240+Cg0mY-0igV-LxJTj-S71bq5ibA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, david@redhat.com, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 4:51=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, May 2, 2024 at 5:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > There could arise a necessity to obtain the first pte_t from a swap
> > pte_t located in the middle. For instance, this may occur within the
> > context of do_swap_page(), where a page fault can potentially occur in
> > any PTE of a large folio. To address this, the following patch introduc=
es
> > pte_move_swp_offset(), a function capable of bidirectional movement by
> > a specified delta argument. Consequently, pte_increment_swp_offset()
> > will directly invoke it with delta =3D 1.
>
> BTW, this patch has conflict with the latest mm-unstable. You might
> need to refresh it.
>
> I do not see the delta =3D -1 usage case here. Maybe merge the patch
> with the follow up patch that uses the delta =3D -1?
> Does delta only make sense as 1 and -1?

nop. delta can be any value from -1 to -(nr_pages - 1). This is used to
get the first pte from vmf->pte in patdh6.

it might be better to be a separate patch as it is introducing a new
helper? do_swap_page() might not be the only user in the future?

>
> This patch doesn't seem straightly necessary to me.
>
> Chris
>
>
> Chris
>
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
> > + *      forward or backward by delta
> >   * @pte: The initial pte state; is_swap_pte(pte) must be true and
> >   *      non_swap_entry() must be false.
> > + * @delta: The direction and the offset we are moving; forward if delt=
a
> > + *      is positive; backward if delta is negative
> >   *
> > - * Increments the swap offset, while maintaining all other fields, inc=
luding
> > + * Moves the swap offset, while maintaining all other fields, includin=
g
> >   * swap type, and any swp pte bits. The resulting pte is returned.
> >   */
> > -static inline pte_t pte_next_swp_offset(pte_t pte)
> > +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
> >  {
> >         swp_entry_t entry =3D pte_to_swp_entry(pte);
> >         pte_t new =3D __swp_entry_to_pte(__swp_entry(swp_type(entry),
> > -                                                  (swp_offset(entry) +=
 1)));
> > +                                                  (swp_offset(entry) +=
 delta)));
> >
> >         if (pte_swp_soft_dirty(pte))
> >                 new =3D pte_swp_mksoft_dirty(new);
> > @@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
> >         return new;
> >  }
> >
> > +
> > +/**
> > + * pte_next_swp_offset - Increment the swap entry offset field of a sw=
ap pte.
> > + * @pte: The initial pte state; is_swap_pte(pte) must be true and
> > + *      non_swap_entry() must be false.
> > + *
> > + * Increments the swap offset, while maintaining all other fields, inc=
luding
> > + * swap type, and any swp pte bits. The resulting pte is returned.
> > + */
> > +static inline pte_t pte_next_swp_offset(pte_t pte)
> > +{
> > +       return pte_move_swp_offset(pte, 1);
> > +}
> > +
> >  /**
> >   * swap_pte_batch - detect a PTE batch for a set of contiguous swap en=
tries
> >   * @start_ptep: Page table pointer for the first entry.
> > --
> > 2.34.1

Thanks
Barry

