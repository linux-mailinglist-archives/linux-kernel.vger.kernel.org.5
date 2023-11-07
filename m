Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FA7E47CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjKGSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjKGSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:05:26 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F796120
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:05:24 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so1969876241.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380323; x=1699985123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+1P2//NPs95uvJ40Wugt3wsb49Wb+X9arHs/+Yfz/I=;
        b=ED63HLanCL8pL+5y4IlTdTJx7lqqYDNzyUks3FFqI3RM4P0KN+riWQ5/DZiP8NUUOR
         OK1iORnx84splUWr7oCmIfngVNhqXDQdPNJJrqyHnrR6gCj6LUkpzJw9kDkGmu3znbdU
         oSMN+YvHzWZU/4oPrWjq53aH+5aIza0pS53POCYdvXv0AVgGhYK1BII/YKZ1m//K46bq
         ndpT3/4yTZMOnM7yOsV4rwDnpG6S0qMR+bbdMSC6z9GtyXYTjaR55lPwWfOag36iV3mg
         F+mzGXME3WmrJ5M2yiWtQv4hWfhivcLbfMm0KaXkhdCzjsb2XT7BhmaxIUxiT9UpT9AY
         Q4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380323; x=1699985123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+1P2//NPs95uvJ40Wugt3wsb49Wb+X9arHs/+Yfz/I=;
        b=eoz2vD4M5D6m3JpYQhMrIIKf6DLv63LPrb2FE1fnnzc+wNHNZdVCa+3TXpRPmqob4T
         eVCy/ar0tOQFzysYkIVQihHrii60sNfz98IDxQU3dBIQoh8LGRRWXzMcAL3N1We42QcW
         cZkEI5HHE2Xk4dC2XmZ3oeUQagjSN2iXWIjkuDkRpqjFV1NkisNO2qR9H5/cJ1IakEKq
         aeRy1MmVDDUR9zxpCCiJSdPozOu0Nv0jQwkuOg23RT3dgR3WrxU7jERMeOFGoE0vVQh9
         HpipVLjlcv97QpFujp00g3439rbUqNkprWsHoVD7Oh1Wa88RYL1w9RJRz1nK/eXZcnb9
         tQ6A==
X-Gm-Message-State: AOJu0YxcSVg4cBmMZox/Kn5KJiyikihc+9xofYDPNFcxce7gjf6ge/sj
        vMHR1T10OmHd1vf40dq+4hzNAAwgrD5S2iQLE1g=
X-Google-Smtp-Source: AGHT+IHPOAr0OWH4neWcIAK2nZDZzXADgsGsFuNSRc/+iZmRMC1iFUys65v2ln/lmuB+nNGAKxhNl8fApv5We6Nl60g=
X-Received: by 2002:a1f:9bc6:0:b0:4ac:5a8:f45b with SMTP id
 d189-20020a1f9bc6000000b004ac05a8f45bmr10038129vke.5.1699380323347; Tue, 07
 Nov 2023 10:05:23 -0800 (PST)
MIME-Version: 1.0
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com> <20231104093423.170054-1-v-songbaohua@oppo.com>
 <b0e4257e-b094-40b6-adb3-923c0d008309@arm.com>
In-Reply-To: <b0e4257e-b094-40b6-adb3-923c0d008309@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 8 Nov 2023 02:05:10 +0800
Message-ID: <CAGsJ_4zntZ4Drm5jndXamy_4VoVQ3qbCpUqCR9k4vdxLdmMO4Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     steven.price@arm.com, akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 8:46=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
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
>
> nit: there should be a clear line between variable declarations and logic=
.

right.

>
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
>
> If i is initially > 0, this will fail to invalidate page 0. If i is initi=
ally 0
> then it will wrap and run ~forever. I think you meant `while (i--)`?

nop. if i=3D0 and we goto out, that means the page0 has failed to save tags=
,
there is nothing to revert. if i=3D3 and we goto out, that means 0,1,2 have
saved, we restore 0,1,2 and we don't restore 3.

>
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
> So the currently defined API allows a large folio to be passed but the ca=
ller is
> supposed to find the single correct page using the swap entry? That feels=
 quite
> nasty to me. And that's not what the old version of the function was doin=
g; it
> always assumed that the folio was small and passed the first page (which =
also
> doesn't feel 'nice'). If the old version was wrong, I suggest a separate =
commit
> to fix that. If the old version is correct, then I guess this version is =
wrong.

the original version(mainline) is wrong but it works as once we find the So=
Cs
support MTE, we will split large folios into small pages. so only small pag=
es
will be added into swapcache successfully.

but now we want to swap out large folios even on SoCs with MTE as a whole,
we don't split, so this breaks the assumption do_swap_page() will always ge=
t
small pages.

>
> Thanks,
> Ryan
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
