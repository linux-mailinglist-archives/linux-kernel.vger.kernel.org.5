Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3AC7E5540
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbjKHLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbjKHLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:23:21 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FFD1FE5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:23:15 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ba7b361b22so3013468241.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699442594; x=1700047394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdl3merjrptXUASgrpht4NSAgLlAIGFWmIZzjIyUklk=;
        b=kxbnMIrq6aPAHK7GT8aDqBykNS1l136YElLvTZrCgnMs1ijng0wOPxbQZh2fXf3maF
         03aKsVpxBGzJqhu5huJqqs43x/sgvRUqqdNiBzSgBUJFHRVmbspPLzLtuqW3pC5IL4e5
         QS44j0dAUq7yrDFzQcd9Hc8PZiR4XxU6JYJcIP3Q8Vz53O5c8EYNHe0sQ/eeXMUDrTDR
         5EoX8MIF6SzKYgCcGzTol9XF0sgGW+VvyMzI2Nu/KpQNRvOYz8DehQZ5lf1O1x1Hrdim
         hXzxabUDG9rbeZPXMiHlexkoB0nbqloMibQZEqpKZu4FVBxHP3PRIvJLBVytooLq5mVh
         tuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699442594; x=1700047394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdl3merjrptXUASgrpht4NSAgLlAIGFWmIZzjIyUklk=;
        b=uqycoU3PUrNYVEG54xx1bM5RyuvmfJHSYIkEJVJzfTRgDsvU1JmjmryIhl1ChBlrkc
         TnmSqF2t5Bjc0T/ArEDnIVOLUv1PrATlF3JJoVtdEyN9zs2GtFWjAErgcjt2A0txbPkv
         eocMmpa/SIWPCeQuoYTFMmX7L7sHUVt0HZsSSf2e1H+G/70ZyMkc42Jkg6+TgZ0A6X48
         /n21woTu8Q8tasXLq7uggMHWrASqA2jiqY/oNZUCSkKO7CKFrsghsNibgYn2yPPxm6mN
         MJ7RE1243aCFTEqASAZwUfI/j9Hd28Hyy2YfWM1SjhCS3jIdcyZgMIqRWKI8WP/8JxMp
         0zOw==
X-Gm-Message-State: AOJu0YwuRAWGbV3VeZLpD1c8iihsU66Mf21ucgv9+xDcqcrHOkM/06p3
        0B/1nSZ83Y94JbuAGMqVryxDoNFsKgi8Ewcn8I8=
X-Google-Smtp-Source: AGHT+IHMG9dH5WEmglE8Cu+skrspZOAZn3j9/d7FqEIIAE7y530fgJamBENFMT5DlvKQBlg95v7GodM2POH9L1rjPo0=
X-Received: by 2002:a67:e1ca:0:b0:45d:ab58:b6b with SMTP id
 p10-20020a67e1ca000000b0045dab580b6bmr1363025vsl.6.1699442594149; Wed, 08 Nov
 2023 03:23:14 -0800 (PST)
MIME-Version: 1.0
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com> <20231104093423.170054-1-v-songbaohua@oppo.com>
 <b0e4257e-b094-40b6-adb3-923c0d008309@arm.com> <CAGsJ_4zntZ4Drm5jndXamy_4VoVQ3qbCpUqCR9k4vdxLdmMO4Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4zntZ4Drm5jndXamy_4VoVQ3qbCpUqCR9k4vdxLdmMO4Q@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 8 Nov 2023 19:23:01 +0800
Message-ID: <CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com>
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

On Wed, Nov 8, 2023 at 2:05=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Tue, Nov 7, 2023 at 8:46=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
> >
> > On 04/11/2023 09:34, Barry Song wrote:
> > >> Yes that's right. mte_save_tags() needs to allocate memory so can fa=
il
> > >> and if failing then arch_prepare_to_swap() would need to put things =
back
> > >> how they were with calls to mte_invalidate_tags() (although I think
> > >> you'd actually want to refactor to create a function which takes a
> > >> struct page *).
> > >>
> > >> Steve
> > >
> > > Thanks, Steve. combining all comments from You and Ryan, I made a v2.
> > > One tricky thing is that we are restoring one page rather than folio
> > > in arch_restore_swap() as we are only swapping in one page at this
> > > stage.
> > >
> > > [RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large f=
olios
> > >
> > > This patch makes MTE tags saving and restoring support large folios,
> > > then we don't need to split them into base pages for swapping on
> > > ARM64 SoCs with MTE.
> > >
> > > This patch moves arch_prepare_to_swap() to take folio rather than
> > > page, as we support THP swap-out as a whole. And this patch also
> > > drops arch_thp_swp_supported() as ARM64 MTE is the only one who
> > > needs it.
> > >
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  arch/arm64/include/asm/pgtable.h | 21 +++------------
> > >  arch/arm64/mm/mteswap.c          | 44 ++++++++++++++++++++++++++++++=
++
> > >  include/linux/huge_mm.h          | 12 ---------
> > >  include/linux/pgtable.h          |  2 +-
> > >  mm/page_io.c                     |  2 +-
> > >  mm/swap_slots.c                  |  2 +-
> > >  6 files changed, 51 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/as=
m/pgtable.h
> > > index b19a8aee684c..d8f523dc41e7 100644
> > > --- a/arch/arm64/include/asm/pgtable.h
> > > +++ b/arch/arm64/include/asm/pgtable.h
> > > @@ -45,12 +45,6 @@
> > >       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> > >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > >
> > > -static inline bool arch_thp_swp_supported(void)
> > > -{
> > > -     return !system_supports_mte();
> > > -}
> > > -#define arch_thp_swp_supported arch_thp_swp_supported
> > > -
> > >  /*
> > >   * Outside of a few very special situations (e.g. hibernation), we a=
lways
> > >   * use broadcast TLB invalidation instructions, therefore a spurious=
 page
> > > @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_a=
rea_struct *vma,
> > >  #ifdef CONFIG_ARM64_MTE
> > >
> > >  #define __HAVE_ARCH_PREPARE_TO_SWAP
> > > -static inline int arch_prepare_to_swap(struct page *page)
> > > -{
> > > -     if (system_supports_mte())
> > > -             return mte_save_tags(page);
> > > -     return 0;
> > > -}
> > > +#define arch_prepare_to_swap arch_prepare_to_swap
> > > +extern int arch_prepare_to_swap(struct folio *folio);
> > >
> > >  #define __HAVE_ARCH_SWAP_INVALIDATE
> > >  static inline void arch_swap_invalidate_page(int type, pgoff_t offse=
t)
> > > @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(i=
nt type)
> > >  }
> > >
> > >  #define __HAVE_ARCH_SWAP_RESTORE
> > > -static inline void arch_swap_restore(swp_entry_t entry, struct folio=
 *folio)
> > > -{
> > > -     if (system_supports_mte())
> > > -             mte_restore_tags(entry, &folio->page);
> > > -}
> > > +#define arch_swap_restore arch_swap_restore
> > > +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio=
);
> > >
> > >  #endif /* CONFIG_ARM64_MTE */
> > >
> > > diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > > index a31833e3ddc5..14a479e4ea8e 100644
> > > --- a/arch/arm64/mm/mteswap.c
> > > +++ b/arch/arm64/mm/mteswap.c
> > > @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
> > >       mte_free_tag_storage(tags);
> > >  }
> > >
> > > +static inline void __mte_invalidate_tags(struct page *page)
> > > +{
> > > +     swp_entry_t entry =3D page_swap_entry(page);
> > > +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> > > +}
> > > +
> > >  void mte_invalidate_tags_area(int type)
> > >  {
> > >       swp_entry_t entry =3D swp_entry(type, 0);
> > > @@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
> > >       }
> > >       xa_unlock(&mte_pages);
> > >  }
> > > +
> > > +int arch_prepare_to_swap(struct folio *folio)
> > > +{
> > > +     int err;
> > > +     long i;
> > > +
> > > +     if (system_supports_mte()) {
> > > +             long nr =3D folio_nr_pages(folio);
> >
> > nit: there should be a clear line between variable declarations and log=
ic.
>
> right.
>
> >
> > > +             for (i =3D 0; i < nr; i++) {
> > > +                     err =3D mte_save_tags(folio_page(folio, i));
> > > +                     if (err)
> > > +                             goto out;
> > > +             }
> > > +     }
> > > +     return 0;
> > > +
> > > +out:
> > > +     while (--i)
> >
> > If i is initially > 0, this will fail to invalidate page 0. If i is ini=
tially 0
> > then it will wrap and run ~forever. I think you meant `while (i--)`?
>
> nop. if i=3D0 and we goto out, that means the page0 has failed to save ta=
gs,
> there is nothing to revert. if i=3D3 and we goto out, that means 0,1,2 ha=
ve
> saved, we restore 0,1,2 and we don't restore 3.

I am terribly sorry for my previous noise. You are right, Ryan. i
actually meant i--.

>
> >
> > > +             __mte_invalidate_tags(folio_page(folio, i));
> > > +     return err;
> > > +}
> > > +
> > > +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> > > +{
> > > +     if (system_supports_mte()) {
> > > +             /*
> > > +              * We don't support large folios swap in as whole yet, =
but
> > > +              * we can hit a large folio which is still in swapcache
> > > +              * after those related processes' PTEs have been unmapp=
ed
> > > +              * but before the swapcache folio  is dropped, in this =
case,
> > > +              * we need to find the exact page which "entry" is mapp=
ing
> > > +              * to. If we are not hitting swapcache, this folio won'=
t be
> > > +              * large
> > > +              */
> >
> > So the currently defined API allows a large folio to be passed but the =
caller is
> > supposed to find the single correct page using the swap entry? That fee=
ls quite
> > nasty to me. And that's not what the old version of the function was do=
ing; it
> > always assumed that the folio was small and passed the first page (whic=
h also
> > doesn't feel 'nice'). If the old version was wrong, I suggest a separat=
e commit
> > to fix that. If the old version is correct, then I guess this version i=
s wrong.
>
> the original version(mainline) is wrong but it works as once we find the =
SoCs
> support MTE, we will split large folios into small pages. so only small p=
ages
> will be added into swapcache successfully.
>
> but now we want to swap out large folios even on SoCs with MTE as a whole=
,
> we don't split, so this breaks the assumption do_swap_page() will always =
get
> small pages.

let me clarify this more. The current mainline assumes
arch_swap_restore() always
get a folio with only one page. this is true as we split large folios
if we find SoCs
have MTE. but since we are dropping the split now, that means a large
folio can be
gotten by do_swap_page(). we have a chance that try_to_unmap_one() has been=
 done
but folio is not put. so PTEs will have swap entry but folio is still
there, and do_swap_page()
to hit cache directly and the folio won't be released.

but after getting the large folio in do_swap_page, it still only takes
one basepage particularly
for the faulted PTE and maps this 4KB PTE only. so it uses the faulted
swap_entry and
the folio as parameters to call arch_swap_restore() which can be something =
like:

do_swap_page()
{
        arch_swap_restore(the swap entry for the faulted 4KB PTE, large fol=
io);
}
>
> >
> > Thanks,
> > Ryan

Thanks
Barry
