Return-Path: <linux-kernel+bounces-21657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0B582927B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B095FB24D68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250423D5;
	Wed, 10 Jan 2024 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNpAYwef"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C31870
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso40968711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704854572; x=1705459372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXULnq8EtuYD6LUrDYxS8b5tNVvlnXvFWRcJbWSVsnA=;
        b=YNpAYwefyt4HybGkbghREjWKNNhlQzRxncHojCygI1b2h0lelkqGJovEhfZL7pT9Ey
         w/FnqIw/NU9nC0uSMiYJO5JFa1FNN580iQ8vGVzh99UmdgbgyeAiGGR6Lkk12MXNltrv
         LRWV+c987LSHGgqdFMJwtqH9y4y0Fgy6gGZUxFwkRlVjiKvNfZYQUphidrq7CPrCY4dh
         13M+sBmCJ2iOsMzVsSZ79lnE6ZxAh6X7HoHlC/oZOLDwKRGVXt59mgjsYI9S7IPTUrZ/
         76HbPZbjZSBUve+oZUCbfQfEO+mbQ6b3pZlj34nkdmuQI4jEhRm60SX2PcV2VDXT2LRo
         PEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704854572; x=1705459372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXULnq8EtuYD6LUrDYxS8b5tNVvlnXvFWRcJbWSVsnA=;
        b=cOb85R0CCqK+mQzsKFTLwiIwUyMJtnyyvOrbz9hUIysijKskYqfkTx1c75M+r/dFAD
         eKyCDPEFCxE7e7d8euyOa62kzCYUxsuEk8DA56qsbfHn/pobPCQZOWtQmbkhJfdg1XRA
         b7oe3o6l917be5GFUvlgOl1kkUhuP1fxyQadUixxMtwd3oxFrRl9w1ls9tlu/4f3OXUr
         XjrL/fQyBj/h4Uhl2xCWN5HW4ZrupK687uygjcGOBX6D3OpqE4aQujNeai8O6A7Kkx+M
         r2kS7Ic7W1ZMN5JHGgYdC22HmDxPWkXrsSTOGoPJMvF7tHLOo8MRL5Mi+tiqfxBs4O7F
         vxdg==
X-Gm-Message-State: AOJu0YxaA/eQ2vEO+w339Nt7grFNt9zf+BngSRqMXUA4E3UJfqhCerYW
	HHl/AoeMn+0GMV9EP59YV3+X2dtxb/EqozQTxv0=
X-Google-Smtp-Source: AGHT+IEdtPM26vsITjx82N7/TcKXK24Kpo1dwf5yQJsQmQqh4q+wappqJu4K8uNLZa6YfIen/cJGtgm0YB3BeviXsmk=
X-Received: by 2002:a2e:8648:0:b0:2cd:477f:9126 with SMTP id
 i8-20020a2e8648000000b002cd477f9126mr131819ljj.104.1704854572117; Tue, 09 Jan
 2024 18:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-6-ryncsn@gmail.com>
 <8734vcb5nx.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734vcb5nx.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 10 Jan 2024 10:42:34 +0800
Message-ID: <CAMgjq7Asotx_mWV-1aLJck_iwcOYi7=P22CT5ZKzrnAi10=nwQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mm/swap: introduce swapin_entry for unified
 readahead policy
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=94 15:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Introduce swapin_entry which merges swapin_readahead and swapin_direct
> > making it the main entry for swapin pages, and use a unified swapin
> > policy.
> >
> > This commit makes swapoff make use of this new helper and now swapping
> > off a 10G ZRAM (lzo-rle) is faster since readahead is skipped.
> >
> > Before:
> > time swapoff /dev/zram0
> > real    0m12.337s
> > user    0m0.001s
> > sys     0m12.329s
> >
> > After:
> > time swapoff /dev/zram0
> > real    0m9.728s
> > user    0m0.001s
> > sys     0m9.719s
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 21 +++++++--------------
> >  mm/swap.h       | 16 ++++------------
> >  mm/swap_state.c | 49 +++++++++++++++++++++++++++++++++----------------
> >  mm/swapfile.c   |  7 ++-----
> >  4 files changed, 46 insertions(+), 47 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0165c8cad489..b56254a875f8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3801,6 +3801,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       rmap_t rmap_flags =3D RMAP_NONE;
> >       bool exclusive =3D false;
> >       swp_entry_t entry;
> > +     bool swapcached;
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> >
> > @@ -3864,21 +3865,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       swapcache =3D folio;
> >
> >       if (!folio) {
> > -             if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > -                 __swap_count(entry) =3D=3D 1) {
> > -                     /* skip swapcache and readahead */
> > -                     folio =3D swapin_direct(entry, GFP_HIGHUSER_MOVAB=
LE, vmf);
> > -                     if (folio)
> > -                             page =3D &folio->page;
> > +             folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> > +                                  vmf, &swapcached);
> > +             if (folio) {
> > +                     page =3D folio_file_page(folio, swp_offset(entry)=
);
> > +                     if (swapcached)
> > +                             swapcache =3D folio;
> >               } else {
> > -                     page =3D swapin_readahead(entry, GFP_HIGHUSER_MOV=
ABLE,
> > -                                             vmf);
> > -                     if (page)
> > -                             folio =3D page_folio(page);
> > -                     swapcache =3D folio;
> > -             }
> > -
> > -             if (!folio) {
> >                       /*
> >                        * Back out if somebody else faulted in this pte
> >                        * while we released the pte lock.
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 83eab7b67e77..502a2801f817 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -54,10 +54,8 @@ struct folio *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_flags,
> >               bool skip_if_exists);
> >  struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> >               struct mempolicy *mpol, pgoff_t ilx);
> > -struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> > -                           struct vm_fault *vmf);
> > -struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> > -                         struct vm_fault *vmf);
> > +struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
> > +                         struct vm_fault *vmf, bool *swapcached);
> >
> >  static inline unsigned int folio_swap_flags(struct folio *folio)
> >  {
> > @@ -88,14 +86,8 @@ static inline struct folio *swap_cluster_readahead(s=
wp_entry_t entry,
> >       return NULL;
> >  }
> >
> > -struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> > -                     struct vm_fault *vmf)
> > -{
> > -     return NULL;
> > -}
> > -
> > -static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp=
_mask,
> > -                     struct vm_fault *vmf)
> > +static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_ma=
sk,
> > +                     struct vm_fault *vmf, bool *swapcached)
> >  {
> >       return NULL;
> >  }
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index d39c5369da21..66ff187aa5d3 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -316,6 +316,11 @@ void free_pages_and_swap_cache(struct encoded_page=
 **pages, int nr)
> >       release_pages(pages, nr);
> >  }
> >
> > +static inline bool swap_use_no_readahead(struct swap_info_struct *si, =
swp_entry_t entry)
> > +{
> > +     return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(=
entry) =3D=3D 1;
> > +}
> > +

Hi Ying,

Thanks for the review.

>
> It appears that there's only one caller of the function in the same
> file?  Why add a function?

Later patch will extend the checker function.
I can defer this change so it won't cause confusion for reviewers.

>
> >  static inline bool swap_use_vma_readahead(void)
> >  {
> >       return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate=
_swap);
> > @@ -870,8 +875,8 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
> >   * Returns the struct folio for entry and addr after the swap entry is=
 read
> >   * in.
> >   */
> > -struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> > -                         struct vm_fault *vmf)
> > +static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> > +                               struct vm_fault *vmf)
> >  {
> >       struct vm_area_struct *vma =3D vmf->vma;
> >       struct folio *folio;
> > @@ -908,33 +913,45 @@ struct folio *swapin_direct(swp_entry_t entry, gf=
p_t gfp_mask,
> >  }
> >
> >  /**
> > - * swapin_readahead - swap in pages in hope we need them soon
> > + * swapin_entry - swap in a page from swap entry
> >   * @entry: swap entry of this memory
> >   * @gfp_mask: memory allocation flags
> >   * @vmf: fault information
> > + * @swapcached: pointer to a bool used as indicator if the
> > + *              page is swapped in through swapcache.
> >   *
> >   * Returns the struct page for entry and addr, after queueing swapin.
> >   *
> > - * It's a main entry function for swap readahead. By the configuration=
,
> > + * It's a main entry function for swap in. By the configuration,
> >   * it will read ahead blocks by cluster-based(ie, physical disk based)
> > - * or vma-based(ie, virtual address based on faulty address) readahead=
.
> > + * or vma-based(ie, virtual address based on faulty address) readahead=
,
> > + * or skip the readahead (ie, ramdisk based swap device).
> >   */
> > -struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> > -                             struct vm_fault *vmf)
> > +struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
> > +                        struct vm_fault *vmf, bool *swapcached)
>
> May be better to use
>
> struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
>                            struct vm_fault *vmf, struct folio **swapcache=
)
>
> In this way, we can reduce the number of source lines in the caller.

Following commit will rewrite this part to return a enum instead of
bool, so this is just a intermediate change. And do_swap_page is the
only caller that can benefit from this, not helpful for swapoff/shmem.
I think we can just keep it this way here.

