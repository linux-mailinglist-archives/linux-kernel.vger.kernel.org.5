Return-Path: <linux-kernel+bounces-159811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629F8B3467
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159231F23395
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E250913F436;
	Fri, 26 Apr 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irggxz+O"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05F13F420
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124777; cv=none; b=rgUlunrUHpxnV2gzBT+qhYWKaA8xXQZaEB0wRrxOUt19CwSGbUugNadWqxUz5nPVhmj44Elwcf2IIE0ZFxD6IETqaraUjak0Gt5D5U1pZCZ1v73N4VXcGeVkgDAZq4QO6an7p4nsG0N+dQbkotWGJLuwT2eilx/TjLMISgqBJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124777; c=relaxed/simple;
	bh=jXM7Ok6jB6oCe4y9joHPmVL04bb4gFV5x/qKAN2nhEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsfhQDDTWLQgGxBp8qUxJjYMrGiPhbPgr0bgWC4BdZDDHKUpHXt15Ryg9+HCLbwsHh/wv7bXFDRXAPUTuxpyHiTnOjvU1uwh2uiQyA7WPNLPhe9sV51bde3RKIp/OvHcXHuZ1cfEATzZoi5RsHsflZXfXnLsH28wHWuQ9GM4OkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irggxz+O; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479e12bde9fso823764137.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714124774; x=1714729574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVOougTKR2E63G5I1kT79Wg3Gm+lmkU4LrYVubtdS5o=;
        b=irggxz+OzlsZ+ozLr+2hJwV16ByA0Zjt9n9VDy0z9b6HXYZHR8CFbiBrlyRY7JUloJ
         j3jkUggj7cnOWfavyYroJ76jvaBOlpeZnRBQFKcyYleymhRvXcmXHSKDoWGSgtCr3VLx
         HoAtbfGt/F+j/4NWePxWK4QTfpIzq1nHVqR3GDcwtP/3Of9/9YjL1JqaLMdO3gfXWgGo
         aBaI0dPL1e3AOQc/Vv/Ftbx4542/tyDPeSyjosOMY3/PBjlV+VGGeB4iGkqvcIlAdyIe
         5ZjksKwmJf6VrVig4Qsc+CYi8KKxuod7/32iK9EMi/R4sbUSwaWTi4MVNUmLbLU19q32
         bI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124774; x=1714729574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVOougTKR2E63G5I1kT79Wg3Gm+lmkU4LrYVubtdS5o=;
        b=YF4qC0h6lwrmRVwJUQyG6Jy1cjcLPd1eCu+k03+NFrPqZiYU/ZSaNl0yw7FzcfXg8t
         TyPfOl0MrYRZDcUlhnBtXloKxrwFrtd8vX62oSB5Gc2/zqu1pn8NkpLfzFQ4j19/0tOz
         Mx901eIBLMVQz8gdN0CQf1Dij+U8XCyuXV4Lmw/UaLTmu8xW0rotV6nQnxjQM9L8sBtp
         AYkEmf0JKuOiZOUDDAahkICZTSspP/Seek/byvK53njFbc6BQRUSX+1CBS/P9C5ROu/6
         7dsdD2p/iP0r1/h/5PVCZnTiCINhlosCQBDTmViw4y9mAUfcODTPOk++qOVhcFQfffXi
         +DlA==
X-Forwarded-Encrypted: i=1; AJvYcCXa9EdlnMKIh2LN651DaTtbBpG/fC4lQ0eRGj+LpX9GGQoVsNud5mXXGqHW+kVW837aia4qPcY4nJvpNuWeviUYWe/hyPPTpk2NuS1c
X-Gm-Message-State: AOJu0YzNrWIjGK4TvY4eTGk9432TPJc+cKhZt0hm21rNjRtgSpOamZSU
	HO6YzSTito70YgcLDFeNra8L9OnBBVaXo2IjUME33DPFdH+aqcJEJeoedN/nhjgTI31NblZ04V+
	k+CddMGoK23LwtCuIPXjO0ChzUKo=
X-Google-Smtp-Source: AGHT+IH58NJkrUWm0u8dX1JxeSV3i50SJdOXfy/TMRuL7cqe2OlgLT61w+ULPg2fuH1Bw+QOfGAUGozg/klLtLMqFyw=
X-Received: by 2002:a05:6102:6d1:b0:47b:976d:8374 with SMTP id
 m17-20020a05610206d100b0047b976d8374mr2487387vsg.29.1714124774146; Fri, 26
 Apr 2024 02:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
In-Reply-To: <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 17:46:02 +0800
Message-ID: <CAGsJ_4xO2tyb3sqSZJbfN6=a3L+=1Erd2MqGyuvusK8261DfCQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.04.24 23:11, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> >
> > In __folio_remove_rmap(), a large folio is added to deferred split list
> > if any page in a folio loses its final mapping. But it is possible that
> > the folio is fully unmapped and adding it to deferred split list is
> > unnecessary.
> >
> > For PMD-mapped THPs, that was not really an issue, because removing the
> > last PMD mapping in the absence of PTE mappings would not have added th=
e
> > folio to the deferred split queue.
> >
> > However, for PTE-mapped THPs, which are now more prominent due to mTHP,
> > they are always added to the deferred split queue. One side effect
> > is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> > unintentionally increased, making it look like there are many partially
> > mapped folios -- although the whole folio is fully unmapped stepwise.
> >
> > Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> > where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> > folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapp=
ed
> > folio is unmapped in one go and can avoid being added to deferred split
> > list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still =
be
> > noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> > -- or where this type of batching is not implemented yet, e.g., migrati=
on.
> >
> > To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> > to tell if the whole folio is unmapped. If the folio is already on
> > deferred split list, it will be skipped, too.
> >
> > Note: commit 98046944a159 ("mm: huge_memory: add the missing
> > folio_test_pmd_mappable() for THP split statistics") tried to exclude
> > mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> > fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> > added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> > since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> > deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> >
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Yang Shi <shy828301@gmail.com>
> > ---
> >   mm/rmap.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a7913a454028..220ad8a83589 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >                * page of the folio is unmapped and at least one page
> >                * is still mapped.
> >                */
> > -             if (folio_test_large(folio) && folio_test_anon(folio))
> > -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> > -                             deferred_split_folio(folio);
> > +             if (folio_test_large(folio) && folio_test_anon(folio) &&
> > +                 list_empty(&folio->_deferred_list) &&
> > +                 ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped))=
 ||
> > +                  (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
> > +                     deferred_split_folio(folio);
> >       }
> >
> >       /*
> >
> > base-commit: 66313c66dd90e8711a8b63fc047ddfc69c53636a
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> But maybe we can really improve the code:
>
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffade..e310b6c4221d7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>   {
>          atomic_t *mapped =3D &folio->_nr_pages_mapped;
>          int last, nr =3D 0, nr_pmdmapped =3D 0;
> +       bool partially_mapped =3D false;
>          enum node_stat_item idx;
>
>          __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                                          nr++;
>                          }
>                  } while (page++, --nr_pages > 0);
> +
> +               partially_mapped =3D nr && atomic_read(mapped);

nice!

>                  break;
>          case RMAP_LEVEL_PMD:
>                  atomic_dec(&folio->_large_mapcount);
> @@ -1532,6 +1535,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                                  nr =3D 0;
>                          }
>                  }
> +               partially_mapped =3D nr < nr_pmdmapped;
>                  break;
>          }
>
> @@ -1553,9 +1557,9 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                   * page of the folio is unmapped and at least one page
>                   * is still mapped.
>                   */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
> +                   list_empty(&folio->_deferred_list) && partially_mappe=
d)
> +                       deferred_split_folio(folio);
>          }
>
>          /*
>
> The compiler should be smart enough to optimize it all -- most likely ;)
>
> --
> Cheers,
>
> David / dhildenb
>

