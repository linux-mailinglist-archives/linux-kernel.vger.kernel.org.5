Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF587734E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjHGXWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjHGXW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:22:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D137411A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:22:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so73271cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 16:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691450547; x=1692055347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swLSUgFLaxa4N7BAczGvHXSMYRHrV5rTU/t8/5qG4hg=;
        b=rEAbaSeNz7rPrROTZ/b6DLXG9ZC+tQouGJSbiklTitKb+gv6nx0/WYqgsQZiYPC9Hb
         0mjPHoKMxqLHEpXN6n6Dp7swTFtxi7tj31XpQT22vD5Hrwgb+YmIsggfL/ivLNJZs4hC
         ROPQFWHNpk9FDX7ke3sF3+QeQUzePJ0pHqx4woKF5Y7fK2VUrVuImRhFToXKkQYVH6XC
         Z3jPkWMfPMcbr5gAs69Xkuu0m5x/OI36xT5GGC6cBMsQoxxyX45ScE+FK26krpnq5o5/
         /lF2nVjqZ4HV0CPTxcwjO6cXFbz0SqFEJxV3NBHNLDejo2b65rx6/vLMiz29raNpZ2zZ
         xIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450547; x=1692055347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swLSUgFLaxa4N7BAczGvHXSMYRHrV5rTU/t8/5qG4hg=;
        b=UMgzc+e/8sa+RP8nJtZ86zlf0gUJMg2pcdMi2MlAfFBgLqe+/lTjtCvvLAeqZ2sZkj
         sfi4dB64P4p7cW4lN38CqaeAwaFVj+iKCc6iRyCkafi+mI3UFp+LKd20MP0LXb1+iAj1
         puBy9F0II1EAO353qkmpf8VJf8id2LUk5aq0X5s/jOkQo0wf2g2I5TgwnJ2ypAbQ6VBK
         77zZ6msXpBLlwE+Geu5NyBXiCB1DwtbfGqjegFBHc2wkPSjhxOV0sbnaa+5jz/3MQ9GN
         k9ty83RZGoSTiMicmj8QEbu4orj2DZciWamhXhx4WHY6EIbPtwhIfAfcpji1ZqnZI5YH
         g32w==
X-Gm-Message-State: AOJu0YxKdixt2s2n42s9W2JQvlufbJwX4nYV3PH72do9fdGzE6Aqvqka
        p6WyEohyb8wZEohqUQ5Sz18A3zLQMmpFf9yE0u4KKw==
X-Google-Smtp-Source: AGHT+IH62sRCjccjCNHN3/DQozzhg3oibdwtxf2vCi0GlyvZLht7jOYlgX75h/84FhuqjR5RrCCBDVu9Z3uekbSsn+I=
X-Received: by 2002:a05:622a:1983:b0:3f6:97b4:1a4d with SMTP id
 u3-20020a05622a198300b003f697b41a4dmr526792qtc.23.1691450546848; Mon, 07 Aug
 2023 16:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufbdbeFhpXw_w4z62=PwCjCa-yuvE6Brhpd3AOxiswa_2Q@mail.gmail.com>
 <433fb8de-f5c0-d150-ac7b-5d73e9958e02@arm.com>
In-Reply-To: <433fb8de-f5c0-d150-ac7b-5d73e9958e02@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 7 Aug 2023 17:21:50 -0600
Message-ID: <CAOUHufZwyNrNbnpgTR=o5O8__QE4NdNG=LTgUoB26bVvDfgBkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 1:07=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 07/08/2023 06:24, Yu Zhao wrote:
> > On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to b=
e
> >> allocated in large folios of a determined order. All pages of the larg=
e
> >> folio are pte-mapped during the same page fault, significantly reducin=
g
> >> the number of page faults. The number of per-page operations (e.g. ref
> >> counting, rmap management lru list management) are also significantly
> >> reduced since those ops now become per-folio.
> >>
> >> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >> which defaults to disabled for now; The long term aim is for this to
> >> defaut to enabled, but there are some risks around internal
> >> fragmentation that need to be better understood first.
> >>
> >> When enabled, the folio order is determined as such: For a vma, proces=
s
> >> or system that has explicitly disabled THP, we continue to allocate
> >> order-0. THP is most likely disabled to avoid any possible internal
> >> fragmentation so we honour that request.
> >>
> >> Otherwise, the return value of arch_wants_pte_order() is used. For vma=
s
> >> that have not explicitly opted-in to use transparent hugepages (e.g.
> >> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> >> bigger). This allows for a performance boost without requiring any
> >> explicit opt-in from the workload while limitting internal
> >> fragmentation.
> >>
> >> If the preferred order can't be used (e.g. because the folio would
> >> breach the bounds of the vma, or because ptes in the region are alread=
y
> >> mapped) then we fall back to a suitable lower order; first
> >> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>
> >> arch_wants_pte_order() can be overridden by the architecture if desire=
d.
> >> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguo=
us
> >> set of ptes map physically contigious, naturally aligned memory, so th=
is
> >> mechanism allows the architecture to optimize as required.
> >>
> >> Here we add the default implementation of arch_wants_pte_order(), used
> >> when the architecture does not define it, which returns -1, implying
> >> that the HW has no preference. In this case, mm will choose it's own
> >> default order.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  include/linux/pgtable.h |  13 ++++
> >>  mm/Kconfig              |  10 +++
> >>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++---=
-
> >>  3 files changed, 172 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >> index 5063b482e34f..2a1d83775837 100644
> >> --- a/include/linux/pgtable.h
> >> +++ b/include/linux/pgtable.h
> >> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
> >>  }
> >>  #endif
> >>
> >> +#ifndef arch_wants_pte_order
> >> +/*
> >> + * Returns preferred folio order for pte-mapped memory. Must be in ra=
nge [0,
> >> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires l=
arge folios
> >> + * to be at least order-2. Negative value implies that the HW has no =
preference
> >> + * and mm will choose it's own default order.
> >> + */
> >> +static inline int arch_wants_pte_order(void)
> >> +{
> >> +       return -1;
> >> +}
> >> +#endif
> >> +
> >>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>                                        unsigned long address,
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 09130434e30d..fa61ea160447 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> >>
> >>  source "mm/damon/Kconfig"
> >>
> >> +config LARGE_ANON_FOLIO
> >> +       bool "Allocate large folios for anonymous memory"
> >> +       depends on TRANSPARENT_HUGEPAGE
> >> +       default n
> >> +       help
> >> +         Use large (bigger than order-0) folios to back anonymous mem=
ory where
> >> +         possible, even for pte-mapped memory. This reduces the numbe=
r of page
> >> +         faults, as well as other per-page overheads to improve perfo=
rmance for
> >> +         many workloads.
> >> +
> >>  endmenu
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 01f39e8144ef..64c3f242c49a 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>         return ret;
> >>  }
> >>
> >> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> >> +{
> >> +       int i;
> >> +
> >> +       if (nr_pages =3D=3D 1)
> >> +               return vmf_pte_changed(vmf);
> >> +
> >> +       for (i =3D 0; i < nr_pages; i++) {
> >> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> >> +                       return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +#ifdef CONFIG_LARGE_ANON_FOLIO
> >> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE=
_SHIFT)
> >> +
> >> +static int anon_folio_order(struct vm_area_struct *vma)
> >> +{
> >> +       int order;
> >> +
> >> +       /*
> >> +        * If THP is explicitly disabled for either the vma, the proce=
ss or the
> >> +        * system, then this is very likely intended to limit internal
> >> +        * fragmentation; in this case, don't attempt to allocate a la=
rge
> >> +        * anonymous folio.
> >> +        *
> >> +        * Else, if the vma is eligible for thp, allocate a large foli=
o of the
> >> +        * size preferred by the arch. Or if the arch requested a very=
 small
> >> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_O=
RDER,
> >> +        * which still meets the arch's requirements but means we stil=
l take
> >> +        * advantage of SW optimizations (e.g. fewer page faults).
> >> +        *
> >> +        * Finally if thp is enabled but the vma isn't eligible, take =
the
> >> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UN=
HINTED.
> >> +        * This ensures workloads that have not explicitly opted-in ta=
ke benefit
> >> +        * while capping the potential for internal fragmentation.
> >> +        */
> >> +
> >> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >> +           !hugepage_flags_enabled())
> >> +               order =3D 0;
> >> +       else {
> >> +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTL=
Y_ORDER);
> >> +
> >> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, tru=
e, true))
> >> +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHI=
NTED);
> >> +       }
> >> +
> >> +       return order;
> >> +}
> >> +
> >> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **foli=
o)
> >> +{
> >> +       int i;
> >> +       gfp_t gfp;
> >> +       pte_t *pte;
> >> +       unsigned long addr;
> >> +       struct vm_area_struct *vma =3D vmf->vma;
> >> +       int prefer =3D anon_folio_order(vma);
> >> +       int orders[] =3D {
> >> +               prefer,
> >> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_O=
RDER : 0,
> >> +               0,
> >> +       };
> >> +
> >> +       *folio =3D NULL;
> >> +
> >> +       if (vmf_orig_pte_uffd_wp(vmf))
> >> +               goto fallback;
> >
> > Per the discussion, we need to check hugepage_vma_check() for
> > correctness of VM LM. I'd just check it here and fall back to order 0
> > if that helper returns false.
>
> I'm not sure if either you haven't noticed the logic in anon_folio_order(=
)
> above, or whether you are making this suggestion because you disagree wit=
h the
> subtle difference in my logic?

The latter, or more generally the policy you described earlier.

> My logic is deliberately not calling hugepage_vma_check() because that wo=
uld
> return false for the thp=3Dmadvise,mmap=3Dunhinted case, whereas the poli=
cy I'm
> implementing wants to apply LAF in that case.
>
>
> My intended policy:
>
>                 | never     | madvise   | always
> ----------------|-----------|-----------|-----------
> no hint         | S         | LAF>S     | THP>LAF>S
> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S         | S
>
>
> What your suggestion would give:
>
>                 | never     | madvise   | always
> ----------------|-----------|-----------|-----------
> no hint         | S         | S         | THP>LAF>S
> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S         | S

This is not what I'm suggesting.

Let me reiterate [1]:
  My impression is we only agreed on one thing: at the current stage, we
  should respect things we absolutely have to. We didn't agree on what
  "never" means ("never 2MB" or "never >4KB"), and we didn't touch on
  how "always" should behave at all.

And [2]:
  (Thanks to David, now I agree that) we have to interpret MADV_NOHUGEPAGE
  as nothing >4KB.

My final take [3]:
  I agree these points require more discussion. But I don't think we
  need to conclude them now, unless they cause correctness issues like
  ignoring MADV_NOHUGEPAGE would.

But I should have been clear about the parameters to
hugepage_vma_check(): enforce_sysfs=3Dfalse.

[1] https://lore.kernel.org/linux-mm/CAOUHufYQTcOdKU=3D1mPq-fdLV7a66sHx1=3D=
EJpPpMVogciCNKO9A@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc=
6t+ZOphwgw7tw@mail.gmail.com/
[3] https://lore.kernel.org/linux-mm/CAOUHufYQTcOdKU=3D1mPq-fdLV7a66sHx1=3D=
EJpPpMVogciCNKO9A@mail.gmail.com/
