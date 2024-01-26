Return-Path: <linux-kernel+bounces-40816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7983E668
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976721F21934
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B215820F;
	Fri, 26 Jan 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVODDONb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE560265
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310855; cv=none; b=stoERry22wk3OxXfusLENy8juOcb+lVw+Yi6oVUbyzIllaHp5uKtJahJW0crsRum5oBOib942Fr1WWgHoocpJptluKOOYcJZyY69D7MICvcM9VheK8UJP4706YoWscQs5XQZJFrlBiRo/ZCt4MLNiHYfDpGpvxRtoBwvsZg/vyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310855; c=relaxed/simple;
	bh=+oKDDKRyI7OKfps5tA+D5MorjH0m9ZM8s5XpTUsGro0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvRTQfY+by/ja56J4OLEDSIoGm3oqCM4+RLv4IhoNRpVmg1nJ/YfApJsS5haCcrxKqCXgd9EaCIvW41peGOpP1KH0P9iWAbEjPQakVgQdOXq/PriIz2eeY/m7gtDj3x9vGPV8/AuxzvdUuuVsuesCFf5BwPpxwZO9XtFwd8Lavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVODDONb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D353C43390
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706310854;
	bh=+oKDDKRyI7OKfps5tA+D5MorjH0m9ZM8s5XpTUsGro0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LVODDONbKwu7vS3Qgtbid/id8fJCVdzwnOCvJu2V00gQKgEj3KCMnC0E7qB2yB++v
	 V3kBwMCeYdwCnIkrRhM4PqT3opt1zrhbhaGyd3caeFD3fcWpAbE5J7PE+u2Vk9red8
	 O9VSYXMNtu0bAxrDZTgjOCh/039zLgRdMQKEWWNGy6aBRWNHTHlFJapyaKQ4M3+74H
	 4Vf/idtgROLs0sq6GlHXob/EUWrX1ZhcHYANNOUy1N4iE3zvdvUt8rcbw6cOyQDKY7
	 G2PWPL1zWRX9rA99b0/dbxXDx8E3r1xwJapLe+Bg3Fu1Sc/QpUvoKSjSsbeI4CmVlJ
	 I7SRHZCZd2d4g==
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bf2ab2c4caso28578639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:14:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxqFmISJcySWVQPeO6WS6gesnOlq5nBgFbZKEbJHUwmSYLtOHw3
	GlsgbPFIVRYn3ixQiW9DIYcWxvac91PIF87+8kLgIlaAcKajGPRI/qLa37NZJb/zxpgh+WrqhYW
	qlGocMcKnQH+Ks7MwlV4TD35X6D7by0zTzpDV
X-Google-Smtp-Source: AGHT+IGA6N1e/CyyIzJme2fJkdHFac4vf9+ga8MksY50ZoNX6thbVbpAbovQQz5SoZ19Vc5J8LFk5U2XoevmRmyTW+Q=
X-Received: by 2002:a05:6e02:1523:b0:361:9538:e440 with SMTP id
 i3-20020a056e02152300b003619538e440mr691723ilu.21.1706310853872; Fri, 26 Jan
 2024 15:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-2-21cnbao@gmail.com>
In-Reply-To: <20240118111036.72641-2-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jan 2024 15:14:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPtR86rhZ1-8Y96w36-+J2qgzJh=tWJCtCmVjaqYHJqqA@mail.gmail.com>
Message-ID: <CAF8kJuPtR86rhZ1-8Y96w36-+J2qgzJh=tWJCtCmVjaqYHJqqA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] arm64: mm: swap: support THP_SWAP on hardware
 with MTE
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
> THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
> MTE as the MTE code works with the assumption tags save/restore is
> always handling a folio with only one page.
>
> The limitation should be removed as more and more ARM64 SoCs have
> this feature. Co-existence of MTE and THP_SWAP becomes more and
> more important.
>
> This patch makes MTE tags saving support large folios, then we don't
> need to split large folios into base pages for swapping out on ARM64
> SoCs with MTE any more.
>
> arch_prepare_to_swap() should take folio rather than page as parameter
> because we support THP swap-out as a whole. It saves tags for all
> pages in a large folio.
>
> As now we are restoring tags based-on folio, in arch_swap_restore(),
> we may increase some extra loops and early-exitings while refaulting
> a large folio which is still in swapcache in do_swap_page(). In case
> a large folio has nr pages, do_swap_page() will only set the PTE of
> the particular page which is causing the page fault.
> Thus do_swap_page() runs nr times, and each time, arch_swap_restore()
> will loop nr times for those subpages in the folio. So right now the
> algorithmic complexity becomes O(nr^2).
>
> Once we support mapping large folios in do_swap_page(), extra loops
> and early-exitings will decrease while not being completely removed
> as a large folio might get partially tagged in corner cases such as,
> 1. a large folio in swapcache can be partially unmapped, thus, MTE
> tags for the unmapped pages will be invalidated;
> 2. users might use mprotect() to set MTEs on a part of a large folio.
>
> arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> who needed it.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 21 +++-------------
>  arch/arm64/mm/mteswap.c          | 42 ++++++++++++++++++++++++++++++++
>  include/linux/huge_mm.h          | 12 ---------
>  include/linux/pgtable.h          |  2 +-
>  mm/page_io.c                     |  2 +-
>  mm/swap_slots.c                  |  2 +-
>  6 files changed, 49 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 79ce70fbb751..9902395ca426 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -45,12 +45,6 @@
>         __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> -static inline bool arch_thp_swp_supported(void)
> -{
> -       return !system_supports_mte();
> -}
> -#define arch_thp_swp_supported arch_thp_swp_supported
> -
>  /*
>   * Outside of a few very special situations (e.g. hibernation), we alway=
s
>   * use broadcast TLB invalidation instructions, therefore a spurious pag=
e
> @@ -1042,12 +1036,8 @@ static inline pmd_t pmdp_establish(struct vm_area_=
struct *vma,
>  #ifdef CONFIG_ARM64_MTE
>
>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> -{
> -       if (system_supports_mte())
> -               return mte_save_tags(page);
> -       return 0;
> -}
> +#define arch_prepare_to_swap arch_prepare_to_swap

This seems a noop, define "arch_prepare_to_swap" back to itself.
What am I missing?

I see. Answer my own question, I guess you want to allow someone to
overwrite the arch_prepare_to_swap.
Wouldn't testing against  __HAVE_ARCH_PREPARE_TO_SWAP enough to support tha=
t?

Maybe I need to understand better how you want others to extend this
code to make suggestions.
As it is, this looks strange.

> +extern int arch_prepare_to_swap(struct folio *folio);
>
>  #define __HAVE_ARCH_SWAP_INVALIDATE
>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> @@ -1063,11 +1053,8 @@ static inline void arch_swap_invalidate_area(int t=
ype)
>  }
>
>  #define __HAVE_ARCH_SWAP_RESTORE
> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *fo=
lio)
> -{
> -       if (system_supports_mte())
> -               mte_restore_tags(entry, &folio->page);
> -}
> +#define arch_swap_restore arch_swap_restore

Same here.

> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
>
>  #endif /* CONFIG_ARM64_MTE */
>
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index a31833e3ddc5..b9ca1b35902f 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offset)
>         mte_free_tag_storage(tags);
>  }
>
> +static inline void __mte_invalidate_tags(struct page *page)
> +{
> +       swp_entry_t entry =3D page_swap_entry(page);
> +
> +       mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> +}
> +
>  void mte_invalidate_tags_area(int type)
>  {
>         swp_entry_t entry =3D swp_entry(type, 0);
> @@ -83,3 +90,38 @@ void mte_invalidate_tags_area(int type)
>         }
>         xa_unlock(&mte_pages);
>  }
> +
> +int arch_prepare_to_swap(struct folio *folio)
> +{
> +       int err;
> +       long i;
> +
> +       if (system_supports_mte()) {
Very minor nitpick.

You can do
if (!system_supports_mte())
    return 0;

Here and the for loop would have less indent. The function looks flatter.

> +               long nr =3D folio_nr_pages(folio);
> +
> +               for (i =3D 0; i < nr; i++) {
> +                       err =3D mte_save_tags(folio_page(folio, i));
> +                       if (err)
> +                               goto out;
> +               }
> +       }
> +       return 0;
> +
> +out:
> +       while (i--)
> +               __mte_invalidate_tags(folio_page(folio, i));
> +       return err;
> +}
> +
> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> +{
> +       if (system_supports_mte()) {

Same here.

Looks good otherwise. None of the nitpicks are deal breakers.

Acked-by: Chris Li <chrisl@kernel.org>


Chris

> +               long i, nr =3D folio_nr_pages(folio);
> +
> +               entry.val -=3D swp_offset(entry) & (nr - 1);
> +               for (i =3D 0; i < nr; i++) {
> +                       mte_restore_tags(entry, folio_page(folio, i));
> +                       entry.val++;
> +               }
> +       }
> +}
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 5adb86af35fc..67219d2309dd 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -530,16 +530,4 @@ static inline int split_folio(struct folio *folio)
>         return split_folio_to_list(folio, NULL);
>  }
>
> -/*
> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due t=
o
> - * limitations in the implementation like arm64 MTE can override this to
> - * false
> - */
> -#ifndef arch_thp_swp_supported
> -static inline bool arch_thp_swp_supported(void)
> -{
> -       return true;
> -}
> -#endif
> -
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f6d0e3513948..37fe83b0c358 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -925,7 +925,7 @@ static inline int arch_unmap_one(struct mm_struct *mm=
,
>   * prototypes must be defined in the arch-specific asm/pgtable.h file.
>   */
>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> -static inline int arch_prepare_to_swap(struct page *page)
> +static inline int arch_prepare_to_swap(struct folio *folio)
>  {
>         return 0;
>  }
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ae2b49055e43..a9a7c236aecc 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writebac=
k_control *wbc)
>          * Arch code may have to preserve more data than just the page
>          * contents, e.g. memory tags.
>          */
> -       ret =3D arch_prepare_to_swap(&folio->page);
> +       ret =3D arch_prepare_to_swap(folio);
>         if (ret) {
>                 folio_mark_dirty(folio);
>                 folio_unlock(folio);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..2325adbb1f19 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>         entry.val =3D 0;
>
>         if (folio_test_large(folio)) {
> -               if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported=
())
> +               if (IS_ENABLED(CONFIG_THP_SWAP))
>                         get_swap_pages(1, &entry, folio_nr_pages(folio));
>                 goto out;
>         }
> --
> 2.34.1
>
>

