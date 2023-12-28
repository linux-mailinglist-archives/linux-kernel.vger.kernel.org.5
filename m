Return-Path: <linux-kernel+bounces-12724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C417D81F958
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB321F22909
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D6D2F5;
	Thu, 28 Dec 2023 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HvT1wIFX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F0F4E1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-427e59202ceso12677981cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703775732; x=1704380532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/6cBo3Wyb/38nIDe6ydYNszYPe9c+GQu22EYbo95bE=;
        b=HvT1wIFXnGmPPfIw4pul8bn4pcIrhMpX2+0ThYvjubUrTGDDOtBboB9hh2zYQi252F
         Csgmqo7xRoGgz9ey4zyi5taz4w9cqqRf5V6p2AWEuAS7wH/uoPJClDHaKie7Rqq7AOmk
         ll2zT5Tps2c++EFQF0S0c6yCGRdCtZ4w2Fs2jY/QkNgP7pG6gjinZvcRO0kYMJ4cBLD6
         OkKrlmQic921WDXdFW7cKXuxnCGvDn1MOC+0F5LV6wPWh3CSRhHO2wwZglGsa36FFNXl
         V8FQd80V3Hf+zEwulXLwk7FuYPPdiJx1RZZs33rs/AtgJLhViz4bPgpORgu5yQpIHHsw
         0ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703775732; x=1704380532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/6cBo3Wyb/38nIDe6ydYNszYPe9c+GQu22EYbo95bE=;
        b=HBdM6Jz77lWO1CW72AXdIM4hVTeIUY68v2rO1XnOelKctAOP+ETJXK4vpVYmo0fsMu
         xhyCih7wIBY6rdqE+98vsLi1iUohiesGTU4a2xquSdBMU8LyZFcu6U/6OUinV85g/VcZ
         pxzn8BM1cNWZF0Hqef8Nb1FzySLVW9X/bVfKAHGYKTdT77nw6wNuOGnEJG2vfpWaH6x1
         E1G1u0AugJK3Unn3KoWl0J6ZQkC4vtWeWT2kBGd3yuJPMEDjwzX38b3yLgKS/WUT36zH
         7dza79jWdZXaj8mu1h52mhoBB5sIRQfGsY6O8ROwOJ9a6l+Ne4JpxNXjfqYw/cLRggnw
         KdZg==
X-Gm-Message-State: AOJu0Yw5RO0jowoK1XXD4DB3dJ24wZBIB/U7Ono6kgX4cXf6DboJBzOG
	dQRqDwAoSnu1UC61gISv9f+U3JE9ttUW1ETGGULrbay1wxS6ELWrtX5cV2s9kcA=
X-Google-Smtp-Source: AGHT+IGTWqap7OQo2+ut8dqdkZE0j9g7QmI6eM86JzAPMzCq4CrNH+GLlgUN27a0N+PUFgPy7ylZHp/70YRwqbaOozs=
X-Received: by 2002:a05:622a:134a:b0:41e:453a:4dfe with SMTP id
 w10-20020a05622a134a00b0041e453a4dfemr15697224qtk.36.1703775731870; Thu, 28
 Dec 2023 07:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
 <20231221031915.619337-2-pasha.tatashin@soleen.com> <a77781a4-2d3c-403a-88a6-57242c7f0246@intel.com>
In-Reply-To: <a77781a4-2d3c-403a-88a6-57242c7f0246@intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Dec 2023 10:01:35 -0500
Message-ID: <CA+CK2bACOdqYNTPO+EN90L5ZnCYT_UeKaLWp-xDrS8Jg3hMkHQ@mail.gmail.com>
Subject: Re: [RFC 1/3] iommu/intel: Use page->refcount to count number of
 entries in IOMMU
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 9:59=E2=80=AFPM Liu, Jingqi <jingqi.liu@intel.com> =
wrote:
>
> On 12/21/2023 11:19 AM, Pasha Tatashin wrote:
> > In order to be able to efficiently free empty page table levels, count =
the
> > number of entries in each page table my incremeanting and decremeanting
> s/incremeanting/incrementing
> s/decremeanting/decrementing
>
> > refcount every time a PTE is inserted or removed form the page table.
> s/form/from
>
> >
> > For this to work correctly, add two helper function:
> > dma_clear_pte and dma_set_pte where counting is performed,
> >
> > Also, modify the code so every page table entry is always updated using=
 the
> > two new functions.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 40 +++++++++++++++++++++---------------
> >   drivers/iommu/intel/iommu.h | 41 +++++++++++++++++++++++++++++++-----=
-
> >   2 files changed, 58 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 897159dba47d..4688ef797161 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -949,7 +949,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_d=
omain *domain,
> >                       if (domain->use_first_level)
> >                               pteval |=3D DMA_FL_PTE_XD | DMA_FL_PTE_US=
 | DMA_FL_PTE_ACCESS;
> >
> > -                     if (cmpxchg64(&pte->val, 0ULL, pteval))
> > +                     if (dma_set_pte(pte, pteval))
> >                               /* Someone else set it while we were thin=
king; use theirs. */
> >                               free_pgtable_page(tmp_page);
> >                       else
> > @@ -1021,7 +1021,8 @@ static void dma_pte_clear_range(struct dmar_domai=
n *domain,
> >                       continue;
> >               }
> >               do {
> > -                     dma_clear_pte(pte);
> > +                     if (dma_pte_present(pte))
> > +                             dma_clear_pte(pte);
> >                       start_pfn +=3D lvl_to_nr_pages(large_page);
> >                       pte++;
> >               } while (start_pfn <=3D last_pfn && !first_pte_in_page(pt=
e));
> > @@ -1062,7 +1063,8 @@ static void dma_pte_free_level(struct dmar_domain=
 *domain, int level,
> >                */
> >               if (level < retain_level && !(start_pfn > level_pfn ||
> >                     last_pfn < level_pfn + level_size(level) - 1)) {
> > -                     dma_clear_pte(pte);
> > +                     if (dma_pte_present(pte))
> > +                             dma_clear_pte(pte);
> >                       domain_flush_cache(domain, pte, sizeof(*pte));
> >                       free_pgtable_page(level_pte);
> >               }
> > @@ -1093,12 +1095,13 @@ static void dma_pte_free_pagetable(struct dmar_=
domain *domain,
> >       }
> >   }
> >
> > -/* When a page at a given level is being unlinked from its parent, we =
don't
> > -   need to *modify* it at all. All we need to do is make a list of all=
 the
> > -   pages which can be freed just as soon as we've flushed the IOTLB an=
d we
> > -   know the hardware page-walk will no longer touch them.
> > -   The 'pte' argument is the *parent* PTE, pointing to the page that i=
s to
> > -   be freed. */
> > +/*
> > + * A given page at a given level is being unlinked from its parent.
> > + * We need to make a list of all the pages which can be freed just as =
soon as
> > + * we've flushed the IOTLB and we know the hardware page-walk will no =
longer
> > + * touch them. The 'pte' argument is the *parent* PTE, pointing to the=
 page
> > + * that is to be freed.
> > + */
> >   static void dma_pte_list_pagetables(struct dmar_domain *domain,
> >                                   int level, struct dma_pte *pte,
> >                                   struct list_head *freelist)
> > @@ -1106,17 +1109,20 @@ static void dma_pte_list_pagetables(struct dmar=
_domain *domain,
> >       struct page *pg;
> >
> >       pg =3D pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
> > -     list_add_tail(&pg->lru, freelist);
> > -
> > -     if (level =3D=3D 1)
> > -             return;
> > -
> >       pte =3D page_address(pg);
> > +
> >       do {
> > -             if (dma_pte_present(pte) && !dma_pte_superpage(pte))
> > -                     dma_pte_list_pagetables(domain, level - 1, pte, f=
reelist);
> > +             if (dma_pte_present(pte)) {
> > +                     if (level > 1 && !dma_pte_superpage(pte)) {
> > +                             dma_pte_list_pagetables(domain, level - 1=
, pte,
> > +                                                     freelist);
> > +                     }
> > +                     dma_clear_pte(pte);
> > +             }
> >               pte++;
> >       } while (!first_pte_in_page(pte));
> > +
> > +     list_add_tail(&pg->lru, freelist);
> >   }
> >
> How about calculating the page decrement when the pages in the freelist
> are really freed in iommu_free_pgtbl_pages() ?


Hi Jingqi,

Thank you for looking at this.

My understanding is what you are suggesting is to count number of
entries and subtract them from refcount only once before adding page
to the freelist, is this correct?

We could do that, but having dma_clear_pte() for each entry is very
beneficial, as we could extend IOMMU page tables with other debug
technologies, such as page_table_check, if every single entry in the
page table is added and removed via dma_clear_pte() and dma_set_pte(),
since we are alreadying clearing pte, there is no reason not to change
the refcount at the same time.

Pasha

