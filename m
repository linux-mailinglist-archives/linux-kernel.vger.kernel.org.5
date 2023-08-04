Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8A76F689
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHDA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDA3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:29:24 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2843AB2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:29:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so73991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691108961; x=1691713761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBkxm9IfsqmG4lz9TY6dpOW+s8a1rPrTxuBJihg8BqM=;
        b=W8YUVgRiZFnZV509lKfNU5Zj6KHUBOTpDsBr2gKQQkvABj3qvIWhfze/f+hZd8JaH3
         LuwhgfRXE3n1Xkh5XvxVr8uUQKEf++ds+7BZdCW0KJu8qY/l3KI2uMOU1N2CUjmYyjdn
         Jp+XO1BmqSXh/HX+4NUqAjUMQtzuRgnwChcaNau+RBZoe0no2NP9+62fPqaBH/ZlPyCg
         NHXf4isSLYw36sKj8DI1mrGtsUbuktHWBASdWRH74l4S3+gLdCMQMJmqR6+U1QBUsYZl
         CfkA+pqfss1fP5i8FCGPWgSN08cFoS4Ex9XIRLFMVNKBbQsvevqoEAGVzqIR+Lhg8Dr5
         p6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691108961; x=1691713761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBkxm9IfsqmG4lz9TY6dpOW+s8a1rPrTxuBJihg8BqM=;
        b=C7y67rn7FhldnsABFwwU6Ps3q1e+8qpLvKS+gOP2gqMHYzn87s7gnWZkOFd+gSOMpZ
         zPAMMLvIU71V18vPoZfdClHroLbbgGXwp+JWJn8nlXWZpEbp8MUkrYLAbu/D6g9k7/97
         bTuL4+5LeFfU2gWsol9nIiZ5AJd0J970c17pHDaucmMfY8496Y0/pNH91iu44t6SHgiv
         QbZwBP9HXEXHIu0qEg7egTiayWDtsSOVdmMhGyv7W/0c/1vOy7NRsAVlL1FmONXW6Y+V
         Uzl/U5in7nEO9ib0p9ce4MCY6dlXPsG9kuQzDNmB/iZKvF62U4B37hSV1W+HObeQ78v1
         Iu+A==
X-Gm-Message-State: AOJu0Yx2IVC4JUdjDxTzUNWR8Eb4OMn8MiGpdTBM1jlQpnfHTt1NfQV2
        XtDiOhibmZQLcojUYruPxhPPCqFGMZRePPwd87rPbw==
X-Google-Smtp-Source: AGHT+IGyRoCXiXDfq8fP7wUidqgKH0av0X59/ss9A2hKDFYS1lvBdkKchOwNNJNxFekQTauRh2mEIkp/rJT/tv4PH64=
X-Received: by 2002:ac8:5a92:0:b0:403:aee3:64f7 with SMTP id
 c18-20020ac85a92000000b00403aee364f7mr95785qtc.6.1691108961178; Thu, 03 Aug
 2023 17:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com> <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
In-Reply-To: <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Aug 2023 18:28:44 -0600
Message-ID: <CAOUHufasZ6w32sHO+Lq33+tGy3+GiO0_dd6mNYwfS_5gqhzYbw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 2:07=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com> =
wrote:
>
> On 7/28/23 18:13, Ryan Roberts wrote:
> > On 27/07/2023 05:31, Yu Zhao wrote:
> >> On Wed, Jul 26, 2023 at 10:41=E2=80=AFAM Yu Zhao <yuzhao@google.com> w=
rote:
> >>>
> >>> On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to=
 be
> >>>> allocated in large folios of a determined order. All pages of the la=
rge
> >>>> folio are pte-mapped during the same page fault, significantly reduc=
ing
> >>>> the number of page faults. The number of per-page operations (e.g. r=
ef
> >>>> counting, rmap management lru list management) are also significantl=
y
> >>>> reduced since those ops now become per-folio.
> >>>>
> >>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >>>> which defaults to disabled for now; The long term aim is for this to
> >>>> defaut to enabled, but there are some risks around internal
> >>>> fragmentation that need to be better understood first.
> >>>>
> >>>> When enabled, the folio order is determined as such: For a vma, proc=
ess
> >>>> or system that has explicitly disabled THP, we continue to allocate
> >>>> order-0. THP is most likely disabled to avoid any possible internal
> >>>> fragmentation so we honour that request.
> >>>>
> >>>> Otherwise, the return value of arch_wants_pte_order() is used. For v=
mas
> >>>> that have not explicitly opted-in to use transparent hugepages (e.g.
> >>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> >>>> bigger). This allows for a performance boost without requiring any
> >>>> explicit opt-in from the workload while limitting internal
> >>>> fragmentation.
> >>>>
> >>>> If the preferred order can't be used (e.g. because the folio would
> >>>> breach the bounds of the vma, or because ptes in the region are alre=
ady
> >>>> mapped) then we fall back to a suitable lower order; first
> >>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>>>
> >>>> arch_wants_pte_order() can be overridden by the architecture if desi=
red.
> >>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contig=
uous
> >>>> set of ptes map physically contigious, naturally aligned memory, so =
this
> >>>> mechanism allows the architecture to optimize as required.
> >>>>
> >>>> Here we add the default implementation of arch_wants_pte_order(), us=
ed
> >>>> when the architecture does not define it, which returns -1, implying
> >>>> that the HW has no preference. In this case, mm will choose it's own
> >>>> default order.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  include/linux/pgtable.h |  13 ++++
> >>>>  mm/Kconfig              |  10 +++
> >>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++-=
---
> >>>>  3 files changed, 172 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>> index 5063b482e34f..2a1d83775837 100644
> >>>> --- a/include/linux/pgtable.h
> >>>> +++ b/include/linux/pgtable.h
> >>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
> >>>>  }
> >>>>  #endif
> >>>>
> >>>> +#ifndef arch_wants_pte_order
> >>>> +/*
> >>>> + * Returns preferred folio order for pte-mapped memory. Must be in =
range [0,
> >>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires=
 large folios
> >>>> + * to be at least order-2. Negative value implies that the HW has n=
o preference
> >>>> + * and mm will choose it's own default order.
> >>>> + */
> >>>> +static inline int arch_wants_pte_order(void)
> >>>> +{
> >>>> +       return -1;
> >>>> +}
> >>>> +#endif
> >>>> +
> >>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>>>                                        unsigned long address,
> >>>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>>> index 09130434e30d..fa61ea160447 100644
> >>>> --- a/mm/Kconfig
> >>>> +++ b/mm/Kconfig
> >>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> >>>>
> >>>>  source "mm/damon/Kconfig"
> >>>>
> >>>> +config LARGE_ANON_FOLIO
> >>>> +       bool "Allocate large folios for anonymous memory"
> >>>> +       depends on TRANSPARENT_HUGEPAGE
> >>>> +       default n
> >>>> +       help
> >>>> +         Use large (bigger than order-0) folios to back anonymous m=
emory where
> >>>> +         possible, even for pte-mapped memory. This reduces the num=
ber of page
> >>>> +         faults, as well as other per-page overheads to improve per=
formance for
> >>>> +         many workloads.
> >>>> +
> >>>>  endmenu
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 01f39e8144ef..64c3f242c49a 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >>>>         return ret;
> >>>>  }
> >>>>
> >>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_page=
s)
> >>>> +{
> >>>> +       int i;
> >>>> +
> >>>> +       if (nr_pages =3D=3D 1)
> >>>> +               return vmf_pte_changed(vmf);
> >>>> +
> >>>> +       for (i =3D 0; i < nr_pages; i++) {
> >>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> >>>> +                       return true;
> >>>> +       }
> >>>> +
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
> >>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PA=
GE_SHIFT)
> >>>> +
> >>>> +static int anon_folio_order(struct vm_area_struct *vma)
> >>>> +{
> >>>> +       int order;
> >>>> +
> >>>> +       /*
> >>>> +        * If THP is explicitly disabled for either the vma, the pro=
cess or the
> >>>> +        * system, then this is very likely intended to limit intern=
al
> >>>> +        * fragmentation; in this case, don't attempt to allocate a =
large
> >>>> +        * anonymous folio.
> >>>> +        *
> >>>> +        * Else, if the vma is eligible for thp, allocate a large fo=
lio of the
> >>>> +        * size preferred by the arch. Or if the arch requested a ve=
ry small
> >>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY=
_ORDER,
> >>>> +        * which still meets the arch's requirements but means we st=
ill take
> >>>> +        * advantage of SW optimizations (e.g. fewer page faults).
> >>>> +        *
> >>>> +        * Finally if thp is enabled but the vma isn't eligible, tak=
e the
> >>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_=
UNHINTED.
> >>>> +        * This ensures workloads that have not explicitly opted-in =
take benefit
> >>>> +        * while capping the potential for internal fragmentation.
> >>>> +        */
> >>>
> >>> What empirical evidence is SZ_64K based on?
> >>> What workloads would benefit from it?
> >>> How much would they benefit from it?
> >>> Would they benefit more or less from different values?
> >>> How much internal fragmentation would it cause?
> >>> What cost function was used to arrive at the conclusion that its
> >>> benefits outweigh its costs?
> >
> > Sorry this has taken a little while to reply to; I've been re-running m=
y perf
> > tests with the modern patches to recomfirm old data.
> >
> > In terms of empirical evidence, I've run the kernel compilation benchma=
rk (yes I
> > know its a narrow use case, but I figure some data is better than no da=
ta), for
> > all values of ANON_FOLIO_MAX_ORDER_UNHINTED {4k, 16k, 32k, 64k, 128k, 2=
56k}.
> >
> > I've run each test 15 times across 5 system reboots on Ampere Altra (ar=
m64),
> > with the kernel configured for 4K base pages - I could rerun for other =
base page
> > sizes if we want to go further down this route.
> >
> > I've captured run time and peak memory usage, and taken the mean. The s=
tdev for
> > the peak memory usage is big-ish, but I'm confident this still captures=
 the
> > central tendancy well:
> >
> > | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak m=
emory |
> > |:-------------------|------------:|------------:|------------:|:------=
------|
> > | 4k                 |        0.0% |        0.0% |        0.0% |       =
 0.0% |
> > | 16k                |       -3.6% |      -26.5% |       -0.5% |       =
-0.1% |
> > | 32k                |       -4.8% |      -37.4% |       -0.6% |       =
-0.1% |
> > | 64k                |       -5.7% |      -42.0% |       -0.6% |       =
-1.1% |
> > | 128k               |       -5.6% |      -42.1% |       -0.7% |       =
 1.4% |
> > | 256k               |       -4.9% |      -41.9% |       -0.4% |       =
 1.9% |
>
> Here is my test result:
>
>                 real            user            sys
> hink-4k:         0%             0%              0%
> hink-16K:       -3%             0.1%            -18.3%
> hink-32K:       -4%             0.2%            -27.2%
> hink-64K:       -4%             0.5%            -31.0%
> hink-128K:      -4%             0.9%            -33.7%
> hink-256K:      -5%             1%              -34.6%
>
>
> I used command:
> /usr/bin/time -f "\t%E real,\t%U user,\t%S sys" make -skj96 allmodconfig =
all
> to build kernel and collect the real time/user time/kernel time.
> /sys/kernel/mm/transparent_hugepage/enabled is "madvise".
> Let me know if you have any question about the test.
>
> I also find one strange behavior with this version. It's related with why
> I need to set the /sys/kernel/mm/transparent_hugepage/enabled to "madvise=
".
> If it's "never", the large folio is disabled either.
> If it's "always", the THP will be active before large folio. So the syste=
m is
> in the mixed mode. it's not suitable for this test.
>
> So if it's "never", large folio is disabled. But why "madvise" enables la=
rge
> folio unconditionly? Suppose it's only enabled for the VMA range which us=
er
> madvise large folio (or THP)?

Indeed. It's a very peculiar behavior, as I called out in another email
