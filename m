Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12C9805F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbjLEUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:16:32 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C28D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:16:38 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4b2e1e2e7cdso819334e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701807397; x=1702412197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9+Wq42pLVrA2d2mGEg2raSlh8pC5hY5dBJM43fq2Fc=;
        b=h0m4WUH5oqSjSkpCRnBqSMUWC9KltfgxgJNJ0SoFY2BM1SE/rpegJErlqxJptdPdf9
         TIpAH7o4ChFf1xGrj6VdAv3h3AftzbNYoSpDQ4w0S8Qfh3fDP5ZyVoxAQxqS4DU8ZFa3
         McCzWJI7qn0TH0UTBhObY179Nz4LfD2xAPAgG0HFbCsERbQ7kRq7Jj1fdY8xr9DwQgbR
         6mHH7XnAGA9AjtebSWEsWy8kOG5QS4s6WkcTVxnhU+gnqvCxKHGvqlpSg6stobmtooK6
         hqoqpHjSR22ie5dJcNF5S/beu82lUfjyoAMn1T0TpIv+zxNx+4lbPuMmYwNrNn6nx6tX
         IwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701807397; x=1702412197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9+Wq42pLVrA2d2mGEg2raSlh8pC5hY5dBJM43fq2Fc=;
        b=Hbu+cAmmFgKtPLuBqDW3iAXuDVvzHrRqh18/LdTguITa1qexkM5lYGu7YaH/Qi25fB
         Ja1NKqhl45aPl4p7tFSNa58GTsHXodTzXONJrpFCge3WIMW08gVPfLf0MNx1p+Hunckr
         bVjX+Lc9DL/ck8Oz1/GwGC2cJZOSxmnM9JugTATh4cNsF4qUZadCK6mdvnql4ddS7F6Y
         XbbZ9+3laXiEwR0d+cA5VY6IP9MkDsuKB30sLrFnTp1RuoqcpQEeiGmRKpdQ+mhM9ldq
         4/6HTvpwzAtFzhvtEcRwEyYFHK9FM2Ev5AhquLYPw6f+c0vtEh3AadLxFwyNwVBACn8v
         57zw==
X-Gm-Message-State: AOJu0Yyj2wmGJwHOqpI8LEXUsWiLiyEILvYOIQmBJDIyoNoZ67BYnUZz
        4cq5RJ4XBxD+TbMk0aHwEE+ProaYaYKJjtNPPjM=
X-Google-Smtp-Source: AGHT+IFsG1wrOHB4MUR7FM6YXg7XOf4tAZGac+r8z69FHrn5twCXmzStWUF4eY6A2G/3TIl1XlHkjQOQEk5gmtMnfbc=
X-Received: by 2002:a1f:e301:0:b0:4b2:7749:aa96 with SMTP id
 a1-20020a1fe301000000b004b27749aa96mr3434041vkh.11.1701807397152; Tue, 05 Dec
 2023 12:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20231204102027.57185-1-ryan.roberts@arm.com> <20231204102027.57185-5-ryan.roberts@arm.com>
 <CAGsJ_4zG6W_Z-u+3QcRDn4ByoeqUXjMusNS0RotfRMSqo8RCHg@mail.gmail.com>
 <CAGsJ_4zYhJWGx1DnHTiDnP3h1m8_rr6ZT6fXt8pO=jzs9QZS-A@mail.gmail.com> <5216caaf-1fcf-4715-99c3-521e2a1cc756@arm.com>
In-Reply-To: <5216caaf-1fcf-4715-99c3-521e2a1cc756@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 6 Dec 2023 09:16:26 +1300
Message-ID: <CAGsJ_4xHib66MP3-o9jpHGzKecmgb-omBXinazBbrCiwHkonEQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 11:48=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/12/2023 01:24, Barry Song wrote:
> > On Tue, Dec 5, 2023 at 9:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> >>
> >> On Mon, Dec 4, 2023 at 6:21=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>>
> >>> Introduce the logic to allow THP to be configured (through the new sy=
sfs
> >>> interface we just added) to allocate large folios to back anonymous
> >>> memory, which are larger than the base page size but smaller than
> >>> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
> >>>
> >>> mTHP continues to be PTE-mapped, but in many cases can still provide
> >>> similar benefits to traditional PMD-sized THP: Page faults are
> >>> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending o=
n
> >>> the configured order), but latency spikes are much less prominent
> >>> because the size of each page isn't as huge as the PMD-sized variant =
and
> >>> there is less memory to clear in each page fault. The number of per-p=
age
> >>> operations (e.g. ref counting, rmap management, lru list management) =
are
> >>> also significantly reduced since those ops now become per-folio.
> >>>
> >>> Some architectures also employ TLB compression mechanisms to squeeze
> >>> more entries in when a set of PTEs are virtually and physically
> >>> contiguous and approporiately aligned. In this case, TLB misses will
> >>> occur less often.
> >>>
> >>> The new behaviour is disabled by default, but can be enabled at runti=
me
> >>> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabl=
ed
> >>> (see documentation in previous commit). The long term aim is to chang=
e
> >>> the default to include suitable lower orders, but there are some risk=
s
> >>> around internal fragmentation that need to be better understood first=
.
> >>>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>  include/linux/huge_mm.h |   6 ++-
> >>>  mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++--=
--
> >>>  2 files changed, 101 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>> index bd0eadd3befb..91a53b9835a4 100644
> >>> --- a/include/linux/huge_mm.h
> >>> +++ b/include/linux/huge_mm.h
> >>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
> >>>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >>>
> >>>  /*
> >>> - * Mask of all large folio orders supported for anonymous THP.
> >>> + * Mask of all large folio orders supported for anonymous THP; all o=
rders up to
> >>> + * and including PMD_ORDER, except order-0 (which is not "huge") and=
 order-1
> >>> + * (which is a limitation of the THP implementation).
> >>>   */
> >>> -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
> >>> +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) =
| BIT(1)))
> >>>
> >>>  /*
> >>>   * Mask of all large folio orders supported for file THP.
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 3ceeb0f45bf5..bf7e93813018 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>         return ret;
> >>>  }
> >>>
> >>> +static bool pte_range_none(pte_t *pte, int nr_pages)
> >>> +{
> >>> +       int i;
> >>> +
> >>> +       for (i =3D 0; i < nr_pages; i++) {
> >>> +               if (!pte_none(ptep_get_lockless(pte + i)))
> >>> +                       return false;
> >>> +       }
> >>> +
> >>> +       return true;
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> >>> +{
> >>> +       gfp_t gfp;
> >>> +       pte_t *pte;
> >>> +       unsigned long addr;
> >>> +       struct folio *folio;
> >>> +       struct vm_area_struct *vma =3D vmf->vma;
> >>> +       unsigned long orders;
> >>> +       int order;
> >>> +
> >>> +       /*
> >>> +        * If uffd is active for the vma we need per-page fault fidel=
ity to
> >>> +        * maintain the uffd semantics.
> >>> +        */
> >>> +       if (userfaultfd_armed(vma))
> >>> +               goto fallback;
> >>> +
> >>> +       /*
> >>> +        * Get a list of all the (large) orders below PMD_ORDER that =
are enabled
> >>> +        * for this vma. Then filter out the orders that can't be all=
ocated over
> >>> +        * the faulting address and still be fully contained in the v=
ma.
> >>> +        */
> >>> +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false=
, true, true,
> >>> +                                         BIT(PMD_ORDER) - 1);
> >>> +       orders =3D thp_vma_suitable_orders(vma, vmf->address, orders)=
;
> >>> +
> >>> +       if (!orders)
> >>> +               goto fallback;
> >>> +
> >>> +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >>> +       if (!pte)
> >>> +               return ERR_PTR(-EAGAIN);
> >>> +
> >>> +       order =3D first_order(orders);
> >>> +       while (orders) {
> >>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order)=
;
> >>> +               vmf->pte =3D pte + pte_index(addr);
> >>> +               if (pte_range_none(vmf->pte, 1 << order))
> >>> +                       break;
> >>> +               order =3D next_order(&orders, order);
> >>> +       }
> >>> +
> >>> +       vmf->pte =3D NULL;
> >>> +       pte_unmap(pte);
> >>> +
> >>> +       gfp =3D vma_thp_gfp_mask(vma);
> >>> +
> >>> +       while (orders) {
> >>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order)=
;
> >>> +               folio =3D vma_alloc_folio(gfp, order, vma, addr, true=
);
> >>> +               if (folio) {
> >>> +                       clear_huge_page(&folio->page, addr, 1 << orde=
r);
> >>
> >> Minor.
> >>
> >> Do we have to constantly clear a huge page? Is it possible to let
> >> post_alloc_hook()
> >> finish this job by using __GFP_ZERO/__GFP_ZEROTAGS as
> >> vma_alloc_zeroed_movable_folio() is doing?
>
> I'm currently following the same allocation pattern as is done for PMD-si=
zed
> THP. In earlier versions of this patch I was trying to be smarter and use=
 the
> __GFP_ZERO/__GFP_ZEROTAGS as you suggest, but I was advised to keep it si=
mple
> and follow the existing pattern.
>
> I have a vague recollection __GFP_ZERO is not preferred for large folios =
because
> of some issue with virtually indexed caches? (Matthew: did I see you ment=
ion
> that in some other context?)
>
> That said, I wasn't aware that Android ships with
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON (I thought it was only used as a debug op=
tion),
> so I can see the potential for some overhead reduction here.
>
> Options:
>
>  1) leave it as is and accept the duplicated clearing
>  2) Pass __GFP_ZERO and remove clear_huge_page()
>  3) define __GFP_SKIP_ZERO even when kasan is not enabled and pass it dow=
n so
>     clear_huge_page() is the only clear
>  4) make clear_huge_page() conditional on !want_init_on_alloc()
>
> I prefer option 4. What do you think?

either 1 and 4 is ok to me if we will finally remove this duplicated
clear_huge_page on top.
4 is even better as it can at least temporarily resolve the problem.

in Android gki_defconfig,
https://android.googlesource.com/kernel/common/+/refs/heads/android14-6.1-l=
ts/arch/arm64/configs/gki_defconfig

Android always has the below,
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy

here is some explanation for the reason,
https://source.android.com/docs/security/test/memory-safety/zero-initialize=
d-memory

>
> As an aside, I've also noticed that clear_huge_page() should take vmf->ad=
dress
> so that it clears the faulting page last to keep the cache hot. If we dec=
ide on
> an option that keeps clear_huge_page(), I'll also make that change.
>
> Thanks,
> Ryan
>
> >>

Thanks
Barry
