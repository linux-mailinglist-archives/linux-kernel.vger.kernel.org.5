Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C67E2FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjKFWne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjKFWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:43:33 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9471D6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:43:29 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba8e3107c9so1918617241.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699310609; x=1699915409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G91RqLPHyzBB6So+n/9gpI/px/Gha0CvH/a8ASBTrpE=;
        b=ZI+TUEJuoQoFm7gg/jq7IgkRHvfEa6rJrtCOcw15jPwbgmmNldYTWI/Xd9JbOyCadH
         +1KcmEELAEEr9MoUfZ8KfKVu0AEcPXZ+KYi8yVUzdzlsV4McdaJkNtYe3ups3PjsOIg7
         DFp95sIXD7f5pewqiq5aS2BErTh2b/JeV1rOtf1OPu8//ZtmumCsxbqat5M9T3SyRCx/
         s66J6gMvmlnhW+Ow5JlQdbW+830obiSBC2wI7CruQz6isFF/q9xzp6ZE7ALOIj6wUc4B
         eTd4Rm/qKCOi71/q+meJdn9h9nYF9vhP5livcVdz9Dg+EOu+w/BIX5IGnPdTptREUaoA
         BWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310609; x=1699915409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G91RqLPHyzBB6So+n/9gpI/px/Gha0CvH/a8ASBTrpE=;
        b=Qp+n65B8tbHea1VPTLY5O2U13AkiuUHKEOvVRVqHGMKshEVsYEiNDKa+b2x1rWPmnr
         oW8lzaH5j8EMS2Q4ae9r662zDSdMrs9iV96MCYHLkhiIx5juk0ZBQmrUS+twslXUaHHd
         iX0ju7eWTHf3I7g1oAwozhNEMncfgWnRTJW/DN05y01acB2g+rvXeP3VyEJk3Wof3Fol
         1GYoze4D21fMNnckCp8UlzA3jyGYASzLCpGi2gTvWt+e//MJUgHn5urO/kJUzljhXH1d
         dAGRDHoEKfBYSp8OVccxjWb9SWn+P/1Odk/Gymrcb51dSSkLdiHyO04spPe1LOWlRSG4
         VlWA==
X-Gm-Message-State: AOJu0YxaoagX12mcMD1SQwu07DAYBKr6oGQ8UMxC9qcMINZaHkkVlchh
        nmVzQKJouR2wGYktPuW0Fjc4tSqv1oMjLLX4ad0=
X-Google-Smtp-Source: AGHT+IH7Qnvq5uOsoGrYFHeP4mxLgQ8FqMEO/nTDNq3szgK4S2O3ZAC4r7aMqgRCi8DYLPvpX0lij6cQ233UzuMrdww=
X-Received: by 2002:a67:c00c:0:b0:45e:f8af:79cc with SMTP id
 v12-20020a67c00c000000b0045ef8af79ccmr5408821vsi.8.1699310608988; Mon, 06 Nov
 2023 14:43:28 -0800 (PST)
MIME-Version: 1.0
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com> <20231104093423.170054-1-v-songbaohua@oppo.com>
 <e84ae266-6de4-4b40-babc-ce4777b4c3fa@arm.com>
In-Reply-To: <e84ae266-6de4-4b40-babc-ce4777b4c3fa@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 7 Nov 2023 05:39:10 +0800
Message-ID: <CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To:     Steven Price <steven.price@arm.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com,
        Barry Song <v-songbaohua@oppo.com>
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

On Mon, Nov 6, 2023 at 6:12=E2=80=AFPM Steven Price <steven.price@arm.com> =
wrote:
>
> On 04/11/2023 09:34, Barry Song wrote:
> >> Yes that's right. mte_save_tags() needs to allocate memory so can fail
> >> and if failing then arch_prepare_to_swap() would need to put things ba=
ck
> >> how they were with calls to mte_invalidate_tags() (although I think
> >> you'd actually want to refactor to create a function which takes a
> >> struct page *).
> >>
> >> Steve
> >
> > Thanks, Steve. combining all comments from You and Ryan, I made a v2.
> > One tricky thing is that we are restoring one page rather than folio
> > in arch_restore_swap() as we are only swapping in one page at this
> > stage.
> >
> > [RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large fol=
ios
> >
> > This patch makes MTE tags saving and restoring support large folios,
> > then we don't need to split them into base pages for swapping on
> > ARM64 SoCs with MTE.
> >
> > This patch moves arch_prepare_to_swap() to take folio rather than
> > page, as we support THP swap-out as a whole. And this patch also
> > drops arch_thp_swp_supported() as ARM64 MTE is the only one who
> > needs it.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 21 +++------------
> >  arch/arm64/mm/mteswap.c          | 44 ++++++++++++++++++++++++++++++++
> >  include/linux/huge_mm.h          | 12 ---------
> >  include/linux/pgtable.h          |  2 +-
> >  mm/page_io.c                     |  2 +-
> >  mm/swap_slots.c                  |  2 +-
> >  6 files changed, 51 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index b19a8aee684c..d8f523dc41e7 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -45,12 +45,6 @@
> >       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > -static inline bool arch_thp_swp_supported(void)
> > -{
> > -     return !system_supports_mte();
> > -}
> > -#define arch_thp_swp_supported arch_thp_swp_supported
> > -
> >  /*
> >   * Outside of a few very special situations (e.g. hibernation), we alw=
ays
> >   * use broadcast TLB invalidation instructions, therefore a spurious p=
age
> > @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_are=
a_struct *vma,
> >  #ifdef CONFIG_ARM64_MTE
> >
> >  #define __HAVE_ARCH_PREPARE_TO_SWAP
> > -static inline int arch_prepare_to_swap(struct page *page)
> > -{
> > -     if (system_supports_mte())
> > -             return mte_save_tags(page);
> > -     return 0;
> > -}
> > +#define arch_prepare_to_swap arch_prepare_to_swap
> > +extern int arch_prepare_to_swap(struct folio *folio);
> >
> >  #define __HAVE_ARCH_SWAP_INVALIDATE
> >  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> > @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int=
 type)
> >  }
> >
> >  #define __HAVE_ARCH_SWAP_RESTORE
> > -static inline void arch_swap_restore(swp_entry_t entry, struct folio *=
folio)
> > -{
> > -     if (system_supports_mte())
> > -             mte_restore_tags(entry, &folio->page);
> > -}
> > +#define arch_swap_restore arch_swap_restore
> > +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
> >
> >  #endif /* CONFIG_ARM64_MTE */
> >
> > diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > index a31833e3ddc5..14a479e4ea8e 100644
> > --- a/arch/arm64/mm/mteswap.c
> > +++ b/arch/arm64/mm/mteswap.c
> > @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
> >       mte_free_tag_storage(tags);
> >  }
> >
> > +static inline void __mte_invalidate_tags(struct page *page)
> > +{
> > +     swp_entry_t entry =3D page_swap_entry(page);
> > +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> > +}
> > +
> >  void mte_invalidate_tags_area(int type)
> >  {
> >       swp_entry_t entry =3D swp_entry(type, 0);
> > @@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
> >       }
> >       xa_unlock(&mte_pages);
> >  }
> > +
> > +int arch_prepare_to_swap(struct folio *folio)
> > +{
> > +     int err;
> > +     long i;
> > +
> > +     if (system_supports_mte()) {
> > +             long nr =3D folio_nr_pages(folio);
> > +             for (i =3D 0; i < nr; i++) {
> > +                     err =3D mte_save_tags(folio_page(folio, i));
> > +                     if (err)
> > +                             goto out;
> > +             }
> > +     }
> > +     return 0;
> > +
> > +out:
> > +     while (--i)
> > +             __mte_invalidate_tags(folio_page(folio, i));
> > +     return err;
> > +}
> > +
> > +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> > +{
> > +     if (system_supports_mte()) {
> > +             /*
> > +              * We don't support large folios swap in as whole yet, bu=
t
> > +              * we can hit a large folio which is still in swapcache
> > +              * after those related processes' PTEs have been unmapped
> > +              * but before the swapcache folio  is dropped, in this ca=
se,
> > +              * we need to find the exact page which "entry" is mappin=
g
> > +              * to. If we are not hitting swapcache, this folio won't =
be
> > +              * large
> > +              */
>
> Does it make sense to keep arch_swap_restore taking a folio? I'm not
> sure I understand why the change was made in the first place. It just
> seems odd to have a function taking a struct folio but making the
> assumption that it's actually only a single page (and having to use
> entry to figure out which page).

Steve, let me give an example. in case we have a large anon folios with
16 pages.

while reclaiming, we do add_to_swap(), this folio is added to swapcache
as a whole; then we unmap the folio; in the last step,  we try to release
the folio.

we have a good chance some processes might access the virtual address
after the folio is unmapped but before the folio is finally released. thus,
do_swap_page() will find the large folio in swapcache, there is no I/O need=
ed.

Let's assume processes read the 3rd page of the unmapped folio, in
do_swap_page(), the code is like,

vm_fault_t do_swap_page(struct vm_fault *vmf)
{
     swp_entry_t entry;
     ...
     entry =3D pte_to_swp_entry(vmf->orig_pte);

     folio =3D swap_cache_get_folio(entry, vma, vmf->address);
     if (folio)
           page =3D folio_file_page(folio, swp_offset(entry));

     arch_swap_restore(entry, folio);
}

entry points to the 3rd page, but folio points to the head page. so we
can't use the entry parameter to restore the whole folio in
arch_swap_restore()

then we have two choices in arch_swap_restore()
1. we get the 1st page's swap entry and restore all 16 tags in this large f=
olio.
2. we restore the 3rd tag only by getting the right page in the folio

if we choose 1, in all 16 page faults of do_swap_page for the 16 unmapped
PTEs, we will restore 16*16=3D256 tags. One pte will have one page fault
since we don't restore 16 PTEs in do_swap_page().

if we choose 2, in all 16 pages fault of do_swap_page for the 16 unmapped
PTEs, we will only restore 16 *1=3D16 tags.

>
> It seems particularly broken in the case of unuse_pte() which calls
> page_folio() to get the folio in the first place.
>
> Other than that it looks correct to me.
>
> Thanks,
>
> Steve
>
> > +             struct page *page =3D folio_file_page(folio, swp_offset(e=
ntry));
> > +             mte_restore_tags(entry, page);
> > +     }
> > +}
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index fa0350b0812a..f83fb8d5241e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -400,16 +400,4 @@ static inline int split_folio(struct folio *folio)
> >       return split_folio_to_list(folio, NULL);
> >  }
> >
> > -/*
> > - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due=
 to
> > - * limitations in the implementation like arm64 MTE can override this =
to
> > - * false
> > - */
> > -#ifndef arch_thp_swp_supported
> > -static inline bool arch_thp_swp_supported(void)
> > -{
> > -     return true;
> > -}
> > -#endif
> > -
> >  #endif /* _LINUX_HUGE_MM_H */
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index af7639c3b0a3..33ab4ddd91dd 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -897,7 +897,7 @@ static inline int arch_unmap_one(struct mm_struct *=
mm,
> >   * prototypes must be defined in the arch-specific asm/pgtable.h file.
> >   */
> >  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> > -static inline int arch_prepare_to_swap(struct page *page)
> > +static inline int arch_prepare_to_swap(struct folio *folio)
> >  {
> >       return 0;
> >  }
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index cb559ae324c6..0fd832474c1d 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeb=
ack_control *wbc)
> >        * Arch code may have to preserve more data than just the page
> >        * contents, e.g. memory tags.
> >        */
> > -     ret =3D arch_prepare_to_swap(&folio->page);
> > +     ret =3D arch_prepare_to_swap(folio);
> >       if (ret) {
> >               folio_mark_dirty(folio);
> >               folio_unlock(folio);
> > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > index 0bec1f705f8e..2325adbb1f19 100644
> > --- a/mm/swap_slots.c
> > +++ b/mm/swap_slots.c
> > @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
> >       entry.val =3D 0;
> >
> >       if (folio_test_large(folio)) {
> > -             if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported=
())
> > +             if (IS_ENABLED(CONFIG_THP_SWAP))
> >                       get_swap_pages(1, &entry, folio_nr_pages(folio));
> >               goto out;
> >       }
>

Thanks
Barry
