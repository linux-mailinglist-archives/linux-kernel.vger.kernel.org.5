Return-Path: <linux-kernel+bounces-17554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23D824F45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF4F285AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB63A20325;
	Fri,  5 Jan 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Ys391T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC620306
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccec119587so15684911fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 23:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704440603; x=1705045403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE868xNBfi0PhqqrB/NKR+HFo2ZSd9jez98UiAP14BY=;
        b=i/Ys391TpT3YGSUGFQXmf/qoTCaW6bwLI4pgvB/R0OKCNECHLHmfi9QJh/kBLQANU7
         bKi8jb5IkJG/edKqk2Gsj4myTAP+uCYJFNNKGpoCoqt7j5FjVpMor90uLK5o/3IYNHf2
         gdICn58MzriaB0Ex4LY5Ixkmn8XPi+11qXmFvjocZ8DCl6zRy/Z9fWRgR2dihWya0aBW
         mMTPpd5bis6k1c7YR4+tsaikPxRh9z8/NyESNoTxs5GkCZUM8e5EkoB9mfUGa0OPp5bq
         vI4ypjYgoUfYhqj1AaMzqyuF1rXESUcP8prkBq2EUFnqJEx8pM9MnnHYgRtF8UuNBesY
         +Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704440603; x=1705045403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE868xNBfi0PhqqrB/NKR+HFo2ZSd9jez98UiAP14BY=;
        b=rxtx8TinaV+UfvJYKxBjOY8FTo7KTiSGoe3VfzSE+CvHZq/KRBYHYEtmYE3HQ6GE80
         tzMDGQ+PDm0QBHgx2OyLglqa9F/tR6lXfIcV5AhhJkRr9Ayea566K5KTHje8IztjqhBm
         L1KpDcOu/GzZwUVk7MpgnBdwyi+2gDYn5oo0njPsbtQRPE4Vh01i+TZudNnH2S6foyUw
         yTTUZXE7lZXpzqeAMaKZqjZHWjtW0S4etKKNvrdwzr2HWg7ZZtuPJKvALQwsa6sB4paK
         EkDXKQ8/7PCTFRSD7rK7AyxD+2aeIeJJuJ/DT/BlxIfRJgRgDHX79KyTiBdYdnFlq9kT
         ouvA==
X-Gm-Message-State: AOJu0Yw72dKYD1XmFlU0liCdWzxcDb1lD/KL+rKNUvybwBa+hARJ/qZf
	tvWoXXb7xcE4vyyLhYPwDomCCcsNzqp7dAUQCOo=
X-Google-Smtp-Source: AGHT+IFZLpTreRF0zt34oUwZoLpE3HLliez5NT7pNkRznUKhapTmEWa7qM/5DxcHL3uyLeWM70Bg/MX+kVUU8HjPu1s=
X-Received: by 2002:a2e:3502:0:b0:2cc:de79:2b3b with SMTP id
 z2-20020a2e3502000000b002ccde792b3bmr931936ljz.44.1704440603311; Thu, 04 Jan
 2024 23:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-3-ryncsn@gmail.com>
 <87plyhblqe.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87plyhblqe.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 5 Jan 2024 15:43:04 +0800
Message-ID: <CAMgjq7AsPct2rQp-Csg6MtK1DQJCm01UjuoeBcvtxTNhHv7j5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mm/swap: move no readahead swapin code to a
 stand-alone helper
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=9B=9B 15:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > No feature change, simply move the routine to a standalone function to
> > be re-used later. The error path handling is copied from the "out_page"
> > label, to make the code change minimized for easier reviewing.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 32 ++++----------------------------
> >  mm/swap.h       |  8 ++++++++
> >  mm/swap_state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 59 insertions(+), 28 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index a0a50d3754f0..0165c8cad489 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3803,7 +3803,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       swp_entry_t entry;
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> > -     void *shadow =3D NULL;
> >
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> > @@ -3867,33 +3866,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > -                     /* skip swapcache */
> > -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> > -                                             vma, vmf->address, false)=
;
> > -                     page =3D &folio->page;
> > -                     if (folio) {
> > -                             __folio_set_locked(folio);
> > -                             __folio_set_swapbacked(folio);
> > -
> > -                             if (mem_cgroup_swapin_charge_folio(folio,
> > -                                                     vma->vm_mm, GFP_K=
ERNEL,
> > -                                                     entry)) {
> > -                                     ret =3D VM_FAULT_OOM;
> > -                                     goto out_page;
> > -                             }
> > -                             mem_cgroup_swapin_uncharge_swap(entry);
> > -
> > -                             shadow =3D get_shadow_from_swap_cache(ent=
ry);
> > -                             if (shadow)
> > -                                     workingset_refault(folio, shadow)=
;
> > -
> > -                             folio_add_lru(folio);
> > -
> > -                             /* To provide entry to swap_read_folio() =
*/
> > -                             folio->swap =3D entry;
> > -                             swap_read_folio(folio, true, NULL);
> > -                             folio->private =3D NULL;
> > -                     }
> > +                     /* skip swapcache and readahead */
> > +                     folio =3D swapin_direct(entry, GFP_HIGHUSER_MOVAB=
LE, vmf);
> > +                     if (folio)
> > +                             page =3D &folio->page;
> >               } else {
> >                       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOV=
ABLE,
> >                                               vmf);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 758c46ca671e..83eab7b67e77 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -56,6 +56,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entr=
y, gfp_t flag,
> >               struct mempolicy *mpol, pgoff_t ilx);
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> >                             struct vm_fault *vmf);
> > +struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> > +                         struct vm_fault *vmf);
> >
> >  static inline unsigned int folio_swap_flags(struct folio *folio)
> >  {
> > @@ -86,6 +88,12 @@ static inline struct folio *swap_cluster_readahead(s=
wp_entry_t entry,
> >       return NULL;
> >  }
> >
> > +struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> > +                     struct vm_fault *vmf)
> > +{
> > +     return NULL;
> > +}
> > +
> >  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp=
_mask,
> >                       struct vm_fault *vmf)
> >  {
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index e671266ad772..24cb93ed5081 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -861,6 +861,53 @@ static struct folio *swap_vma_readahead(swp_entry_=
t targ_entry, gfp_t gfp_mask,
> >       return folio;
> >  }
> >
> > +/**
> > + * swapin_direct - swap in folios skipping swap cache and readahead
>
> swap in a folio ...
>
> > + * @entry: swap entry of this memory
> > + * @gfp_mask: memory allocation flags
> > + * @vmf: fault information
> > + *
> > + * Returns the struct folio for entry and addr after the swap entry is=
 read
> > + * in.
> > + */
> > +struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> > +                         struct vm_fault *vmf)
> > +{
> > +     struct vm_area_struct *vma =3D vmf->vma;
> > +     struct folio *folio;
> > +     void *shadow =3D NULL;
> > +
> > +     /* skip swapcache */
> > +     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>
> You passed gfp_mask in, but don't use it.
>

Thanks, will fix these.

> --
> Best Regards,
> Huang, Ying

