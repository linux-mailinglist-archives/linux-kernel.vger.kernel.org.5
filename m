Return-Path: <linux-kernel+bounces-159442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685D8B2EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AD4B21F28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E5747F;
	Fri, 26 Apr 2024 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdr2IVA/"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AB6FA8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098248; cv=none; b=jrJ9BiS091SPSxt2IRchvGZFqhx+nw7rBTLK7lS1G2Ovuo4yQ/EqXKnzm6eANKaxm7lJSVzN7ceDwe0ynrQ7A/N0ACugT4P2jT5DaFv78GQUCSwb/RaN7LmQbyqWkKcgLdp0kN6EkQXlTjMYmts3M83Nm5psbi+65BrUVX+sMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098248; c=relaxed/simple;
	bh=eoDAHt8ivDKhG0WoqZdZR5asjWvjbITWcz+C132mmc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvsV0MeFZOms3MiZg9WPXM7SlFsDXRm7q80k7gmX2DKw8UScZphj49WRPz9FyXf3q4NpLRbMEwkn1zPwPJIwDfwVIzaO5M4hrj9EvQr+n/NvdMScaqrbobklcmca8XtC9J6rVuB6LCJq3MiMh9suPrYhiMXDnRNOgV8bHRba6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdr2IVA/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dac6802e7aso406692e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714098246; x=1714703046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Va3i2u53YtnbZkMZaQ2D1OE9VZfq4BKwsKRX5GT8Uk=;
        b=Fdr2IVA/eX/VnpciqGW+4+EfZuxxnkiw5d8mSGNftCyWUZBKyEvFzQXohC45ZFagG1
         dOBCVYHCnWGK+k0x9L7Flr7jPgALY1aQlVjBt6NqyfAPIHiwaLb6uAr3SwWQAE9DWrqD
         4QI3tg/50GD52j+YVQaajeVzSw1SVRMMORKq1/636qVZNJAvX+JlsroIr4lvqhNbKXrK
         Qekc4JIx4d7ux1IQfkjxCI4Q/1F4J3XqokosEaHJBQxqNuQqwsYSpKxih+IQda30Jn/p
         BwyDeOZpL5P6lZkddrndRl+RSORLe3m7kbex2fSHFm8GcsXQRq27B/4z+49Ydxpnt1Hs
         cLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714098246; x=1714703046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Va3i2u53YtnbZkMZaQ2D1OE9VZfq4BKwsKRX5GT8Uk=;
        b=Y363cNNb1uSd13d+EIN9fGMV8VyLneTy8p6hs5IY/1p/bjlLYKjNzj8J0Etw7+WZrj
         p8oMtxDzPTp/C9VEzbZNqyNAxxVDs7Fe74LSMjqZunnYM8KLqz6pjrey8wnfjkhNQ9xX
         3Mfy2VQGLTdRsY4h25S77eoNLys5ZKzKofEW2z0qigSmR9rPy95t63NsLCLn2UYy6KHG
         PD4v4NF9P6GqE+kSg6kzPs9EaQpPvNlnAUgtSfKprx/lGqK8FEwz2VacN7FTDFhVkI+o
         w300f45nbWdvwqEZ0EjR7kfOv5wqg5O/nKHa0NSpqF9Afsuw4VbiCSgL/sJgKyymirqw
         G/XA==
X-Forwarded-Encrypted: i=1; AJvYcCU3+MfsDm+wfNNVVAa0O7RAcpc60H5BFy9uDlEMdllgnpPvty0AXqNis7+9UNr2h3iFujnv65ERWH2Cq/O4WxWWY5IXPd4nJorgFJYG
X-Gm-Message-State: AOJu0Yy14pOUy4+c4dQ53pc/ISEwb7grdNLgu+lWmfAyjxcM+o7dNZla
	/14RLbYCBU95YLtlfGzlZBt6b+h7WVC4zoXKxeT25FtYd71H2yFQwEcZhEGOr6WietFxUFqpPAK
	4EHjONPqZ8e5CTLQqHwGxksL9GtI=
X-Google-Smtp-Source: AGHT+IFCI8cDM7NSN3tGF52wxpWlhL9r7hkVw5VxcV+XVlBe9j1X9yr0KV+NZ95M5SMCLJkcXr0uN6q3TrkKs2EJJhg=
X-Received: by 2002:a05:6122:a1a:b0:4d4:1cca:1a72 with SMTP id
 26-20020a0561220a1a00b004d41cca1a72mr1369489vkn.6.1714098245867; Thu, 25 Apr
 2024 19:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
 <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com>
In-Reply-To: <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 10:23:54 +0800
Message-ID: <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 25 Apr 2024, at 21:45, Barry Song wrote:
>
> > On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
> >>
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
> >> if any page in a folio loses its final mapping. But it is possible tha=
t
> >> the folio is fully unmapped and adding it to deferred split list is
> >> unnecessary.
> >>
> >> For PMD-mapped THPs, that was not really an issue, because removing th=
e
> >> last PMD mapping in the absence of PTE mappings would not have added t=
he
> >> folio to the deferred split queue.
> >>
> >> However, for PTE-mapped THPs, which are now more prominent due to mTHP=
,
> >> they are always added to the deferred split queue. One side effect
> >> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> >> unintentionally increased, making it look like there are many partiall=
y
> >> mapped folios -- although the whole folio is fully unmapped stepwise.
> >>
> >> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> >> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> >> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-map=
ped
> >> folio is unmapped in one go and can avoid being added to deferred spli=
t
> >> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still=
 be
> >> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> >> -- or where this type of batching is not implemented yet, e.g., migrat=
ion.
> >>
> >> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> >> to tell if the whole folio is unmapped. If the folio is already on
> >> deferred split list, it will be skipped, too.
> >>
> >> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> >> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> >> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
> >> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> >> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> >> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >> ---
> >>  mm/rmap.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index a7913a454028..220ad8a83589 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>                  * page of the folio is unmapped and at least one page
> >>                  * is still mapped.
> >>                  */
> >> -               if (folio_test_large(folio) && folio_test_anon(folio))
> >> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmd=
mapped)
> >> -                               deferred_split_folio(folio);
> >> +               if (folio_test_large(folio) && folio_test_anon(folio) =
&&
> >> +                   list_empty(&folio->_deferred_list) &&
> >> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mappe=
d)) ||
> >> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped=
)))
> >> +                       deferred_split_folio(folio);
> >
> > Hi Zi Yan,
> > in case a mTHP is mapped by two processed (forked but not CoW yet), if =
we
> > unmap the whole folio by pte level in one process only, are we still ad=
ding this
> > folio into deferred list?
>
> No. Because the mTHP is still fully mapped by the other process. In terms=
 of code,
> nr will be 0 in that case and this if condition is skipped. nr is only in=
creased
> from 0 when one of the subpages in the mTHP has no mapping, namely page->=
_mapcount
> becomes negative and last is true in the case RMAP_LEVEL_PTE.

Ok. i see, so "last" won't be true?

case RMAP_LEVEL_PTE:
do {
last =3D atomic_add_negative(-1, &page->_mapcount);
   if (last && folio_test_large(folio)) {
       last =3D atomic_dec_return_relaxed(mapped);
       last =3D (last < ENTIRELY_MAPPED);
}

if (last)
     nr++;
} while (page++, --nr_pages > 0);
break;



>
>
> --
> Best Regards,
> Yan, Zi

