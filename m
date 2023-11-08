Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED717E5F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjKHVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:04:32 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8152113
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:04:30 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4abf8ba3e4fso70808e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699477469; x=1700082269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewM9PTqPdI3B1hKS5lr5GhB5pSwRt9mQhtmf5QhLeMs=;
        b=DAj5Ds0ht0F8M05XgtnjQNi5PqoT0TI3gte6a+XLE6opCyA8c+ddi6oQu6nK/mAbV4
         rLNhjyP5FwF4itjkwyqX14QouPe96UpO/ifrwwvOMb8ulmBdCgDgCzQiJ/wPBZ1VtB2S
         nBC1MU2TH86lhcCUGUlAy5JlwGvFx0qFOtegOWJXEksaqY/T55e59I2WWMpCTNEegyTr
         e+l441Z8bKKQzPivi9yqk1uBGgXZY5krOsmNvV1hx/BDormUONq5aZJx+sxEOlkGy8JS
         bvdbrKhdvbn4x16LZglu+rANZDGB9QRrUvpM55VZ/BxKQvjLIqnAi/hYph5RGjKkkj/Q
         ab8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477469; x=1700082269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewM9PTqPdI3B1hKS5lr5GhB5pSwRt9mQhtmf5QhLeMs=;
        b=ISbA4qVOnzWf6lBhHfdFMfPu01BiJMnfvRUy8j5jTMg857g81dl16FCcgDm+QeCUqa
         URxko1DcvG1BuDoDHz7wYGjoha9B88RZvGVOPUfse8D8RxWJjZyNGieI1IBcwmI07jrm
         y89FAWPnGK6YoPbl7UZygjeQwPZdB4ar1SlC2kgmE7f/chQD8GpYMKYdl4h+XyTFfGZb
         aqYAdWZhBURxkzOyAzTrzevLTrimdMyMaz+u/HJMzRiVfs4N12QqmiSAgLrvGxS0fY/v
         9lWiAHStAach2dTZM8kUXIpnv+MuZUo3H2FR7DE+yijP5uU4iuUCx7KYGhmjfeROXbEL
         n1hA==
X-Gm-Message-State: AOJu0YzID0PXxp86vEyQwKSEKCADWO0sUW5ukLSMRgsBSrypO5fjiTsl
        +XK9JnjYYY8HXrX2zEu16xF+9K/Gz7AH/DWaoXQ=
X-Google-Smtp-Source: AGHT+IFXzuUlwphGdjnCmvGUz2HQ8DpSimrXJ60fBe9GegI1mRrvGZNQcokCgFwJGh+Xcz3rAAqKo8pE0DT1j624Tao=
X-Received: by 2002:a1f:244f:0:b0:496:248e:43fc with SMTP id
 k76-20020a1f244f000000b00496248e43fcmr3140932vkk.8.1699477469046; Wed, 08 Nov
 2023 13:04:29 -0800 (PST)
MIME-Version: 1.0
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com> <20231104093423.170054-1-v-songbaohua@oppo.com>
 <b0e4257e-b094-40b6-adb3-923c0d008309@arm.com> <CAGsJ_4zntZ4Drm5jndXamy_4VoVQ3qbCpUqCR9k4vdxLdmMO4Q@mail.gmail.com>
 <CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com> <2c98be67-657e-4c65-bf6b-3d70ff596c64@arm.com>
In-Reply-To: <2c98be67-657e-4c65-bf6b-3d70ff596c64@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 9 Nov 2023 05:04:17 +0800
Message-ID: <CAGsJ_4zG1iVoa-O9f--YLVoNou9XZSY7Qe7Fxq9eToDmWFOUJA@mail.gmail.com>
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

On Thu, Nov 9, 2023 at 4:21=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 08/11/2023 11:23, Barry Song wrote:
> > On Wed, Nov 8, 2023 at 2:05=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> >>
> >> On Tue, Nov 7, 2023 at 8:46=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>>
> >>> On 04/11/2023 09:34, Barry Song wrote:
> >>>>> Yes that's right. mte_save_tags() needs to allocate memory so can f=
ail
> >>>>> and if failing then arch_prepare_to_swap() would need to put things=
 back
> >>>>> how they were with calls to mte_invalidate_tags() (although I think
> >>>>> you'd actually want to refactor to create a function which takes a
> >>>>> struct page *).
> >>>>>
> >>>>> Steve
> >>>>
> >>>> Thanks, Steve. combining all comments from You and Ryan, I made a v2=
.
> >>>> One tricky thing is that we are restoring one page rather than folio
> >>>> in arch_restore_swap() as we are only swapping in one page at this
> >>>> stage.
> >>>>
> >>>> [RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large =
folios
> >>>>
> >>>> This patch makes MTE tags saving and restoring support large folios,
> >>>> then we don't need to split them into base pages for swapping on
> >>>> ARM64 SoCs with MTE.
> >>>>
> >>>> This patch moves arch_prepare_to_swap() to take folio rather than
> >>>> page, as we support THP swap-out as a whole. And this patch also
> >>>> drops arch_thp_swp_supported() as ARM64 MTE is the only one who
> >>>> needs it.
> >>>>
> >>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>> ---
> >>>>  arch/arm64/include/asm/pgtable.h | 21 +++------------
> >>>>  arch/arm64/mm/mteswap.c          | 44 +++++++++++++++++++++++++++++=
+++
> >>>>  include/linux/huge_mm.h          | 12 ---------
> >>>>  include/linux/pgtable.h          |  2 +-
> >>>>  mm/page_io.c                     |  2 +-
> >>>>  mm/swap_slots.c                  |  2 +-
> >>>>  6 files changed, 51 insertions(+), 32 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/a=
sm/pgtable.h
> >>>> index b19a8aee684c..d8f523dc41e7 100644
> >>>> --- a/arch/arm64/include/asm/pgtable.h
> >>>> +++ b/arch/arm64/include/asm/pgtable.h
> >>>> @@ -45,12 +45,6 @@
> >>>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>>>
> >>>> -static inline bool arch_thp_swp_supported(void)
> >>>> -{
> >>>> -     return !system_supports_mte();
> >>>> -}
> >>>> -#define arch_thp_swp_supported arch_thp_swp_supported
> >>>> -
> >>>>  /*
> >>>>   * Outside of a few very special situations (e.g. hibernation), we =
always
> >>>>   * use broadcast TLB invalidation instructions, therefore a spuriou=
s page
> >>>> @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_=
area_struct *vma,
> >>>>  #ifdef CONFIG_ARM64_MTE
> >>>>
> >>>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> >>>> -static inline int arch_prepare_to_swap(struct page *page)
> >>>> -{
> >>>> -     if (system_supports_mte())
> >>>> -             return mte_save_tags(page);
> >>>> -     return 0;
> >>>> -}
> >>>> +#define arch_prepare_to_swap arch_prepare_to_swap
> >>>> +extern int arch_prepare_to_swap(struct folio *folio);
> >>>>
> >>>>  #define __HAVE_ARCH_SWAP_INVALIDATE
> >>>>  static inline void arch_swap_invalidate_page(int type, pgoff_t offs=
et)
> >>>> @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(=
int type)
> >>>>  }
> >>>>
> >>>>  #define __HAVE_ARCH_SWAP_RESTORE
> >>>> -static inline void arch_swap_restore(swp_entry_t entry, struct foli=
o *folio)
> >>>> -{
> >>>> -     if (system_supports_mte())
> >>>> -             mte_restore_tags(entry, &folio->page);
> >>>> -}
> >>>> +#define arch_swap_restore arch_swap_restore
> >>>> +extern void arch_swap_restore(swp_entry_t entry, struct folio *foli=
o);
> >>>>
> >>>>  #endif /* CONFIG_ARM64_MTE */
> >>>>
> >>>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> >>>> index a31833e3ddc5..14a479e4ea8e 100644
> >>>> --- a/arch/arm64/mm/mteswap.c
> >>>> +++ b/arch/arm64/mm/mteswap.c
> >>>> @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset=
)
> >>>>       mte_free_tag_storage(tags);
> >>>>  }
> >>>>
> >>>> +static inline void __mte_invalidate_tags(struct page *page)
> >>>> +{
> >>>> +     swp_entry_t entry =3D page_swap_entry(page);
> >>>> +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> >>>> +}
> >>>> +
> >>>>  void mte_invalidate_tags_area(int type)
> >>>>  {
> >>>>       swp_entry_t entry =3D swp_entry(type, 0);
> >>>> @@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
> >>>>       }
> >>>>       xa_unlock(&mte_pages);
> >>>>  }
> >>>> +
> >>>> +int arch_prepare_to_swap(struct folio *folio)
> >>>> +{
> >>>> +     int err;
> >>>> +     long i;
> >>>> +
> >>>> +     if (system_supports_mte()) {
> >>>> +             long nr =3D folio_nr_pages(folio);
> >>>
> >>> nit: there should be a clear line between variable declarations and l=
ogic.
> >>
> >> right.
> >>
> >>>
> >>>> +             for (i =3D 0; i < nr; i++) {
> >>>> +                     err =3D mte_save_tags(folio_page(folio, i));
> >>>> +                     if (err)
> >>>> +                             goto out;
> >>>> +             }
> >>>> +     }
> >>>> +     return 0;
> >>>> +
> >>>> +out:
> >>>> +     while (--i)
> >>>
> >>> If i is initially > 0, this will fail to invalidate page 0. If i is i=
nitially 0
> >>> then it will wrap and run ~forever. I think you meant `while (i--)`?
> >>
> >> nop. if i=3D0 and we goto out, that means the page0 has failed to save=
 tags,
> >> there is nothing to revert. if i=3D3 and we goto out, that means 0,1,2=
 have
> >> saved, we restore 0,1,2 and we don't restore 3.
> >
> > I am terribly sorry for my previous noise. You are right, Ryan. i
> > actually meant i--.
>
> No problem - it saves me from writing a long response explaining why --i =
is
> wrong, at least!
>
> >
> >>
> >>>
> >>>> +             __mte_invalidate_tags(folio_page(folio, i));
> >>>> +     return err;
> >>>> +}
> >>>> +
> >>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> >>>> +{
> >>>> +     if (system_supports_mte()) {
> >>>> +             /*
> >>>> +              * We don't support large folios swap in as whole yet,=
 but
> >>>> +              * we can hit a large folio which is still in swapcach=
e
> >>>> +              * after those related processes' PTEs have been unmap=
ped
> >>>> +              * but before the swapcache folio  is dropped, in this=
 case,
> >>>> +              * we need to find the exact page which "entry" is map=
ping
> >>>> +              * to. If we are not hitting swapcache, this folio won=
't be
> >>>> +              * large
> >>>> +              */
> >>>
> >>> So the currently defined API allows a large folio to be passed but th=
e caller is
> >>> supposed to find the single correct page using the swap entry? That f=
eels quite
> >>> nasty to me. And that's not what the old version of the function was =
doing; it
> >>> always assumed that the folio was small and passed the first page (wh=
ich also
> >>> doesn't feel 'nice'). If the old version was wrong, I suggest a separ=
ate commit
> >>> to fix that. If the old version is correct, then I guess this version=
 is wrong.
> >>
> >> the original version(mainline) is wrong but it works as once we find t=
he SoCs
> >> support MTE, we will split large folios into small pages. so only smal=
l pages
> >> will be added into swapcache successfully.
> >>
> >> but now we want to swap out large folios even on SoCs with MTE as a wh=
ole,
> >> we don't split, so this breaks the assumption do_swap_page() will alwa=
ys get
> >> small pages.
> >
> > let me clarify this more. The current mainline assumes
> > arch_swap_restore() always
> > get a folio with only one page. this is true as we split large folios
> > if we find SoCs
> > have MTE. but since we are dropping the split now, that means a large
> > folio can be
> > gotten by do_swap_page(). we have a chance that try_to_unmap_one() has =
been done
> > but folio is not put. so PTEs will have swap entry but folio is still
> > there, and do_swap_page()
> > to hit cache directly and the folio won't be released.
> >
> > but after getting the large folio in do_swap_page, it still only takes
> > one basepage particularly
> > for the faulted PTE and maps this 4KB PTE only. so it uses the faulted
> > swap_entry and
> > the folio as parameters to call arch_swap_restore() which can be someth=
ing like:
> >
> > do_swap_page()
> > {
> >         arch_swap_restore(the swap entry for the faulted 4KB PTE, large=
 folio);
> > }
>
> OK, I understand what's going on, but it seems like a bad API decision. I=
 think
> Steve is saying the same thing; If its only intended to operate on a sing=
le
> page, it would be much clearer to pass the actual page rather than the fo=
lio;
> i.e. leave the complexity of figuring out the target page to the caller, =
which
> understands all this.

right.

>
> As a side note, if the folio is still in the cache, doesn't that imply th=
at the
> tags haven't been torn down yet? So perhaps you can avoid even making the=
 call
> in this case?

right. but it is practically very hard as arch_swap_restore() is
always called unconditionally.
it is hard to find a decent condition before calling
arch_swap_restore(). That is why we
actually have been doing redundant arch_swap_restore() lots of times right =
now.

For example, A forks B,C,D,E,F,G. now A,B,C,D,E,F,G will share one
page before CoW. After
the page is swapped out, if B is the first process to swap in, B will
add the page to swapcache,
and restore MTE. After that, A, C, D, E, F,G will directly hit the
page swapped in by B, now they
restore MTE again. so the MTE is restored 7 times but actually only B
needs to do it.

so it seems we can put a condition to only let B do restore.  But it
won't work because we can't
guarrent B is the first process who will do PTE mapping.  A, C, D, E,
F, G can map PTEs earlier than B
even if B is the one who did the I/O swapin. swapin/add swapcache and
PTE mapping are
not done atomically. PTE mapping needs to take PTL. so After B has
done swapin, A, C,E,F,G
can still begin to use the page earlier than B. So it turns out anyone
who first maps the page
should restore MTE, but the question is that: How could A,B,C,D,E,F,G
know if it is the first
one mapping the page to PTE?

>
> >>
> >>>
> >>> Thanks,
> >>> Ryan
> >
> > Thanks
> > Barry
>

Thanks
Barry
