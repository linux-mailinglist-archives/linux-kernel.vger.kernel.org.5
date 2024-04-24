Return-Path: <linux-kernel+bounces-157808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0E8B168D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C26E1C24271
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86516E88D;
	Wed, 24 Apr 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob10iC0x"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89355155A50
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999244; cv=none; b=ED7drTbHGhbK3Tx31PLr9+5GekXgNUwX9sY9/8MdZJ4OL4paKjDK1Ve1lQOUmItI7Sb6sqAv9RWLJeZVMbTB8GkOccQv075keeym36DQbXDi+1D+EVXDcnvpkqxp4oWSGQDj8V6u3N41bE210I+I2n5XXOG8OJdTTdvw9gzQvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999244; c=relaxed/simple;
	bh=Kh7fWr/B2gC1eRXO9RG1mDnwJJNJ4XU8IhCKHcg1cLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6gcJ425WvbyYi3AIu9XH11UqspYWQUruReilbVDTCs0SyrGnWmHpWbxGFhcdI7CqNmyAHRivYOZd1yBBOBpCay85tG19D1mDieHU7wGUjj2ZZPuFDFhpD2cFN2Mkjjf3SRlKkaNMzjijVEA+FefQoIZiiEfkHFEKOkE8Fqy/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob10iC0x; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso68509066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713999241; x=1714604041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJi/6ZbgsCRKx4Q6zOyEHKPgI+OhF6v0Pc//Y/rMQp8=;
        b=Ob10iC0xk3Wk7wWa1g79QsYATgmHNlbeicKAhY4rTL58NosKswLaq/zaFOLoVRcY7W
         pBH+jOSoPY5GcYHfH2MhDKbjoygoFE4cM6Y5JOhNOncilgCQMRvkkEjSpb1wDE4fyk3U
         x92SHnEiLURZWKSudxAR6waQI5fn52c+jKQZO5cfSDTFi/gK5q76T6j7WCi6+zQ4lgYs
         +QC2C8ctTRexA9NCG7o1+RGqo/FqKtrwxGbMh7CCYqYeiTnMIBwdVoTmYRO+iyHMkIBC
         im87CaceRlmV0VDzX6V4s4/huGOw3NiwMdul5cPjMATWdCO3udTRpaOaGiv5qkyWaw2g
         8zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999241; x=1714604041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJi/6ZbgsCRKx4Q6zOyEHKPgI+OhF6v0Pc//Y/rMQp8=;
        b=fdK21TP5ogPA+xYx05POk6mw6hMXKzsLLV+8Cm77HiOfW6i+qtJ0hkZJsgSKtWWBKb
         KLjJEeskAtzCSYtbmIZCaqF4cDTQAUbgJu4HVko8+x04SBHGfmN+G/wTo8firj1ejeVe
         9z93f4Nb1fIYDc/qgI6dmtqBztZnw1QwWq7pAlG6MnAmUQmXSLoeIWos4FgrNVQDPYTA
         PwwbTsM45v1fCu8oUNd2kdQbpp81+5vlHq7/ypfL/ZMg0SkjYvSsmrjTEBpLcPkxcWHD
         FzfDcY+79HjWGJ+3quuPn/uGNFF2cK2ZRB2PymvJJN4fAZtNTAh+LpNEAJSQ3ToLHjtk
         TEXw==
X-Forwarded-Encrypted: i=1; AJvYcCUcUm7xPRNRy0PeZmsQi+PIzyMc9K3Cahtirj4CXMq+j6GDGSCdZLwK5t1En3JAY4kA1pQ8CniruN7EL/+JKChr4VOBj4HFApZFzw8Q
X-Gm-Message-State: AOJu0YzKPDxl5LUEv3POWT+HpgyIcQGoSivfsHlHmpN1M8V0oYGTZ5Eq
	evDrAiOqTq9Le4JNJjR5wGW3STYDAe9G/zZiZvTe2At4V9IVJXz9uJ+m6dXZS+sI6bNW73F7oUE
	EOtMszHyZ9BpZIZrNfx6riThH9QY=
X-Google-Smtp-Source: AGHT+IEZ891rraTxlBvdc8Xh810q1gNQTPyKDj8fGIbEgybN0Ns5tKOnk8FNwJxjf5bGR6IV5Itlwbg2iMClemaJ2H0=
X-Received: by 2002:a17:906:2c4e:b0:a55:b25e:a2df with SMTP id
 f14-20020a1709062c4e00b00a55b25ea2dfmr835570ejh.37.1713999240792; Wed, 24 Apr
 2024 15:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424211031.475756-1-zi.yan@sent.com> <CAHbLzkq61sTeRxU23gg3kMNBunxXH3GpkL6D56xcaepsDzFCJA@mail.gmail.com>
 <C617533C-4926-4FBA-8275-4446FDF48F31@nvidia.com>
In-Reply-To: <C617533C-4926-4FBA-8275-4446FDF48F31@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 24 Apr 2024 15:53:49 -0700
Message-ID: <CAHbLzkpOTtRViNRwZYCS+0wePFEQFep30AB77uJk-CvFU_0wwg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:39=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 24 Apr 2024, at 18:32, Yang Shi wrote:
>
> > On Wed, Apr 24, 2024 at 2:10=E2=80=AFPM Zi Yan <zi.yan@sent.com> wrote:
> >>
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
> >> if any page in a folio loses its final mapping. It is possible that
> >> the folio is unmapped fully, but it is unnecessary to add the folio
> >> to deferred split list at all. Fix it by checking folio->_nr_pages_map=
ped
> >> before adding a folio to deferred split list. If the folio is already
> >> on the deferred split list, it will be skipped.
> >>
> >> Commit 98046944a159 ("mm: huge_memory: add the missing
> >> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> >> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
> >> fix everything. A fully unmapped PTE-mapped order-9 THP was also added=
 to
> >> deferred split list and counted as THP_DEFERRED_SPLIT_PAGE, since nr i=
s
> >> 512 (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_fol=
io()
> >> the order-9 folio is folio_test_pmd_mappable(). However, this miscount
> >> was present even earlier due to implementation, since PTEs are unmappe=
d
> >> individually and first PTE unmapping adds the THP into the deferred sp=
lit
> >> list.
> >
> > Shall you mention the miscounting for mTHP too? There is another patch
> > series adding the counter support for mTHP.
>
> OK, will add it.
> >
> >>
> >> With commit b06dc281aa99 ("mm/rmap: introduce
> >> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapp=
ed
> >> folios in one shot without causing the miscount, hence this patch.
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
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
> >
> > Do we really need this check? deferred_split_folio() does the same
> > check too. Bailing out earlier sounds ok too, but there may not be too
> > much gain.
>
> Sure, I can remove it.
>
> >
> >> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mappe=
d)) ||
> >> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped=
)))
> >
> > IIUC, this line is used to cover the case which has both partial
> > PTE-mapping and PMD-mapping, then PMD mapping is unmapped fully. IIRC
> > this case was not handled correctly before, the THP actually skipped
> > deferred split queue. If so please add some description in the commit
> > log.
>
> It is properly handled before, since the original code is
> (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped), meaning
> if either level is RMAP_LEVEL_PTE or
> (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped), the folio
> is added to the deferred split list. So only level =3D=3D RMAP_LEVEL_PTE
> part of logic needs to be fixed.

Oh, yes. I misread "||" to "&&". Thanks for correcting me and fixing
the problem.

>
> >
> > Otherwise the patch looks good to me. Reviewed-by: Yang Shi
> > <shy828301@gmail.com>
> >
>
> Thanks.
> >> +                       deferred_split_folio(folio);
> >>         }
> >>
> >>         /*
> >>
> >> base-commit: 2541ee5668b019c486dd3e815114130e35c1495d
> >> --
> >> 2.43.0
> >>
>
>
> --
> Best Regards,
> Yan, Zi

