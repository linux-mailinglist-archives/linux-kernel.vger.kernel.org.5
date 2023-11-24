Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4906C7F6EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjKXInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjKXInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:43:32 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06609268C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:42:21 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c8872277fcso17206541fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700815339; x=1701420139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH1E9Yiihx2PWEpcKcucZ3CZsR2RWQov3IVdjYVdKl0=;
        b=RHCtPkeqz+NmSWSX2kbwtCMH1GdMvbFYKPUOHUiIu28aZBipjPr9hm33qfe7js2XYj
         PyYKV2IccAH7hdlL05jV6rfQaXkOBUMcSX7vLCJQRW531Xr2LE+wXU8FkjNbkl750e/a
         zarEHvPgi3jftNwSjDCPVzIIeBe0nxN8iyU14bl2P4Eq/Bj1vo9LxOW+E+y7uRUCoTLC
         B1lOKOJ8yU4oVOAbA0gAokbzxEN4/L30Jdzxa5jKIFsBA/W4c7dnJL9zDfvr7e3sWY4w
         0GKf1RZryyBnyQM+1rV8GQWVjgNN7sPrmKVibYnnW0Puy4GgQ2kzfiZixjE1/fnvU8lu
         0i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815339; x=1701420139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH1E9Yiihx2PWEpcKcucZ3CZsR2RWQov3IVdjYVdKl0=;
        b=WhIsflgb/km6mOdqZXEgQz1b9dWqbwvtVdSQ3NsvBK+UxICt99YU/txN28+JOiu57h
         Vh3fsnDwZAFadPaCq1d1Ko1DRmBfgCE2SO5N8Z/HQEHvqMCikFhb9Hv4O4Qbpnx2JzXC
         5Hi+VIylWuvsdYd/W/15QHCqlJOJkPDPDD0IpRhqJDJUcsw2pKtR7A1Bkoprt4LeqtfO
         2UDIX32ynw8BeKrGwzeQ5xY6M0NDd2eKFOFhnSBqL+O2Q+bI8VN1sgmqVU2rQp67s/C1
         UpltFSb/90U3kE292yw0XMvCrSaym9Sy8981nN8sCmPH29RmJHgbIUDMYNjDl3oGQfpq
         PI3Q==
X-Gm-Message-State: AOJu0YyOQ20s7oeK1Gty/E4+YPbqTrbNpuWKfIxiBaS7Xj5asIblkuJg
        45oGwMiy6zpAVWXdPtbw+0C6gfG9U6Ym7063hEk=
X-Google-Smtp-Source: AGHT+IE0xgST11HOt5zFOR9kA3j6Z2IeyY2fjGPyfA5/yarVtW+fG4L0Q8MIwWSzD/URIQnACCJY/nlH5ft3H9+dbE0=
X-Received: by 2002:a2e:9645:0:b0:2c3:e35d:13d with SMTP id
 z5-20020a2e9645000000b002c3e35d013dmr1857701ljh.5.1700815339317; Fri, 24 Nov
 2023 00:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-12-ryncsn@gmail.com>
 <CAF8kJuN+4HswStj4wSZHGQdx9g2tqzCtMA+6CLO7+HmozL6t2Q@mail.gmail.com>
In-Reply-To: <CAF8kJuN+4HswStj4wSZHGQdx9g2tqzCtMA+6CLO7+HmozL6t2Q@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 24 Nov 2023 16:42:00 +0800
Message-ID: <CAMgjq7DpBOYec5FLvByZY8-xMwdWH2HRA9hFvNT3PDyxfaqBYw@mail.gmail.com>
Subject: Re: [PATCH 11/24] mm/swap: also handle swapcache lookup in swapin_readahead
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=89 00:07=E5=86=99=E9=81=93=EF=BC=9A


>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > No feature change, just prepare for later commits.
>
> You need to have a proper commit message why this change needs to happen.
> Preparing is too generic, it does not give any real information.
> For example, it seems you want to reduce one swap cache lookup because
> swap_readahead already has it?
>
> I am a bit puzzled at this patch. It shuffles a lot of sensitive code.
> However I do not get  the value.
> It seems like this patch should be merged with the later patch that
> depends on it to be judged together.
>
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 61 +++++++++++++++++++++++--------------------------
> >  mm/swap.h       | 10 ++++++--
> >  mm/swap_state.c | 26 +++++++++++++--------
> >  mm/swapfile.c   | 30 +++++++++++-------------
> >  4 files changed, 66 insertions(+), 61 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f4237a2e3b93..22af9f3e8c75 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3786,13 +3786,13 @@ static vm_fault_t handle_pte_marker(struct vm_f=
ault *vmf)
> >  vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  {
> >         struct vm_area_struct *vma =3D vmf->vma;
> > -       struct folio *swapcache, *folio =3D NULL;
> > +       struct folio *swapcache =3D NULL, *folio =3D NULL;
> > +       enum swap_cache_result cache_result;
> >         struct page *page;
> >         struct swap_info_struct *si =3D NULL;
> >         rmap_t rmap_flags =3D RMAP_NONE;
> >         bool exclusive =3D false;
> >         swp_entry_t entry;
> > -       bool swapcached;
> >         pte_t pte;
> >         vm_fault_t ret =3D 0;
> >
> > @@ -3850,42 +3850,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         if (unlikely(!si))
> >                 goto out;
> >
> > -       folio =3D swap_cache_get_folio(entry, vma, vmf->address);
> > -       if (folio)
> > -               page =3D folio_file_page(folio, swp_offset(entry));
> > -       swapcache =3D folio;
>
> Is the motivation that swap_readahead() already has a swap cache look up =
so you
> remove this look up here?

Yes, the cache look up can is moved and shared in swapin_readahead,
and this also make it possible to use that look up to return a shadow
when entry is not a page, so another shadow look up can be saved for
sync (ZRAM) swapin path. This can help improve ZRAM performance for
~4% for a 10G ZRAM, and should improves more when the cache tree grows
large.

>
> > -
> > -       if (!folio) {
> > -               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> > -                                       vmf, &swapcached);
> > -               if (page) {
> > -                       folio =3D page_folio(page);
> > -                       if (swapcached)
> > -                               swapcache =3D folio;
> > -               } else {
> > +       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> > +                               vmf, &cache_result);
> > +       if (page) {
> > +               folio =3D page_folio(page);
> > +               if (cache_result !=3D SWAP_CACHE_HIT) {
> > +                       /* Had to read the page from swap area: Major f=
ault */
> > +                       ret =3D VM_FAULT_MAJOR;
> > +                       count_vm_event(PGMAJFAULT);
> > +                       count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > +               }
> > +               if (cache_result !=3D SWAP_CACHE_BYPASS)
> > +                       swapcache =3D folio;
> > +               if (PageHWPoison(page)) {
>
> There is a lot of code shuffle here. From the diff it is hard to tell
> if they are doing the same thing as before.
>
> >                         /*
> > -                        * Back out if somebody else faulted in this pt=
e
> > -                        * while we released the pte lock.
> > +                        * hwpoisoned dirty swapcache pages are kept fo=
r killing
> > +                        * owner processes (which may be unknown at hwp=
oison time)
> >                          */
> > -                       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vm=
f->pmd,
> > -                                       vmf->address, &vmf->ptl);
> > -                       if (likely(vmf->pte &&
> > -                                  pte_same(ptep_get(vmf->pte), vmf->or=
ig_pte)))
> > -                               ret =3D VM_FAULT_OOM;
> > -                       goto unlock;
> > +                       ret =3D VM_FAULT_HWPOISON;
> > +                       goto out_release;
> >                 }
> > -
> > -               /* Had to read the page from swap area: Major fault */
> > -               ret =3D VM_FAULT_MAJOR;
> > -               count_vm_event(PGMAJFAULT);
> > -               count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > -       } else if (PageHWPoison(page)) {
> > +       } else {
> >                 /*
> > -                * hwpoisoned dirty swapcache pages are kept for killin=
g
> > -                * owner processes (which may be unknown at hwpoison ti=
me)
> > +                * Back out if somebody else faulted in this pte
> > +                * while we released the pte lock.
> >                  */
> > -               ret =3D VM_FAULT_HWPOISON;
> > -               goto out_release;
> > +               vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> > +                               vmf->address, &vmf->ptl);
> > +               if (likely(vmf->pte &&
> > +                          pte_same(ptep_get(vmf->pte), vmf->orig_pte))=
)
> > +                       ret =3D VM_FAULT_OOM;
> > +               goto unlock;
> >         }
> >
> >         ret |=3D folio_lock_or_retry(folio, vmf);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index a9a654af791e..ac9136eee690 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -30,6 +30,12 @@ extern struct address_space *swapper_spaces[];
> >         (&swapper_spaces[swp_type(entry)][swp_offset(entry) \
> >                 >> SWAP_ADDRESS_SPACE_SHIFT])
> >
> > +enum swap_cache_result {
> > +       SWAP_CACHE_HIT,
> > +       SWAP_CACHE_MISS,
> > +       SWAP_CACHE_BYPASS,
> > +};
>
> Does any function later care about CACHE_BYPASS?
>
> Again, better introduce it with the function that uses it. Don't
> introduce it for "just in case I might use it later".

Yes,  callers in shmem will also need to know if the page is cached in
swap, and need a value to indicate the bypass case. I can add some
comments here to indicate the usage.

>
> > +
> >  void show_swap_cache_info(void);
> >  bool add_to_swap(struct folio *folio);
> >  void *get_shadow_from_swap_cache(swp_entry_t entry);
> > @@ -55,7 +61,7 @@ struct page *__read_swap_cache_async(swp_entry_t entr=
y, gfp_t gfp_mask,
> >  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> >                                     struct mempolicy *mpol, pgoff_t ilx=
);
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> > -                             struct vm_fault *vmf, bool *swapcached);
> > +                             struct vm_fault *vmf, enum swap_cache_res=
ult *result);
> >
> >  static inline unsigned int folio_swap_flags(struct folio *folio)
> >  {
> > @@ -92,7 +98,7 @@ static inline struct page *swap_cluster_readahead(swp=
_entry_t entry,
> >  }
> >
> >  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp=
_mask,
> > -                       struct vm_fault *vmf, bool *swapcached)
> > +                       struct vm_fault *vmf, enum swap_cache_result *r=
esult)
> >  {
> >         return NULL;
> >  }
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index d87c20f9f7ec..e96d63bf8a22 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -908,8 +908,7 @@ static struct page *swapin_no_readahead(swp_entry_t=
 entry, gfp_t gfp_mask,
> >   * @entry: swap entry of this memory
> >   * @gfp_mask: memory allocation flags
> >   * @vmf: fault information
> > - * @swapcached: pointer to a bool used as indicator if the
> > - *              page is swapped in through swapcache.
> > + * @result: a return value to indicate swap cache usage.
> >   *
> >   * Returns the struct page for entry and addr, after queueing swapin.
> >   *
> > @@ -918,30 +917,39 @@ static struct page *swapin_no_readahead(swp_entry=
_t entry, gfp_t gfp_mask,
> >   * or vma-based(ie, virtual address based on faulty address) readahead=
.
> >   */
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> > -                             struct vm_fault *vmf, bool *swapcached)
> > +                             struct vm_fault *vmf, enum swap_cache_res=
ult *result)
> >  {
> > +       enum swap_cache_result cache_result;
> >         struct swap_info_struct *si;
> >         struct mempolicy *mpol;
> > +       struct folio *folio;
> >         struct page *page;
> >         pgoff_t ilx;
> > -       bool cached;
> > +
> > +       folio =3D swap_cache_get_folio(entry, vmf->vma, vmf->address);
> > +       if (folio) {
> > +               page =3D folio_file_page(folio, swp_offset(entry));
> > +               cache_result =3D SWAP_CACHE_HIT;
> > +               goto done;
> > +       }
> >
> >         si =3D swp_swap_info(entry);
> >         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> >         if (swap_use_no_readahead(si, swp_offset(entry))) {
> >                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx=
, vmf->vma->vm_mm);
> > -               cached =3D false;
> > +               cache_result =3D SWAP_CACHE_BYPASS;
> >         } else if (swap_use_vma_readahead(si)) {
> >                 page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx,=
 vmf);
> > -               cached =3D true;
> > +               cache_result =3D SWAP_CACHE_MISS;
> >         } else {
> >                 page =3D swap_cluster_readahead(entry, gfp_mask, mpol, =
ilx);
> > -               cached =3D true;
> > +               cache_result =3D SWAP_CACHE_MISS;
> >         }
> >         mpol_cond_put(mpol);
> >
> > -       if (swapcached)
> > -               *swapcached =3D cached;
> > +done:
> > +       if (result)
> > +               *result =3D cache_result;
> >
> >         return page;
> >  }
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 01c3f53b6521..b6d57fff5e21 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1822,13 +1822,21 @@ static int unuse_pte_range(struct vm_area_struc=
t *vma, pmd_t *pmd,
> >
> >         si =3D swap_info[type];
> >         do {
> > -               struct folio *folio;
> > +               struct page *page;
> >                 unsigned long offset;
> >                 unsigned char swp_count;
> > +               struct folio *folio =3D NULL;
> >                 swp_entry_t entry;
> >                 int ret;
> >                 pte_t ptent;
> >
> > +               struct vm_fault vmf =3D {
> > +                       .vma =3D vma,
> > +                       .address =3D addr,
> > +                       .real_address =3D addr,
> > +                       .pmd =3D pmd,
> > +               };
>
> Is this code move caused by skipping the swap cache look up here?

Yes.

>
> This is very sensitive code related to swap cache racing. It needs
> very careful reviewing. Better not shuffle it for no good reason.

Thanks for the suggestion, I'll try to avoid these shuffling, but
cache lookup is moved into swappin_readahead so some changes in the
original caller are not avoidable...
