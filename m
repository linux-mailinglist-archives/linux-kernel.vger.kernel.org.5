Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C908806BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbjLFKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377415AbjLFKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:25:43 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732E512B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:25:48 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7bb4b7eb808so2283739241.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701858347; x=1702463147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKX+VQjgaUT7QW8pw5PXrpP0Vs60H0kH8aQmKKo9HyI=;
        b=Crv/EH6ZpzSDydvT1yeFzCtZee6I2eh9tPfYf3rw0nMqfU5+V2l0KDQ1H3HmOXlN41
         UAasqO/JqvSP5VJlfHXrYOFMb38b7fRH6tcTlbJnorqCyeYudkM0W14w+3YaXAVhrH9m
         wlCedhZxKM77hRQosrrpvCyw+Xb05DSHOj8Q089lT9u/+opgDzol6RcC9ktNNnTgRQ7+
         IC0ozCtB8wJ5gKgrC9wqFHPoGX2eMlwZBI33mM2/EJb3pYwdsOzxn9PFe30Xr2vTEM+n
         CuE4Gb00kJBZDIMeAtjeBS3u0cqtj+DLkoLQ+0nnho1U1lIa3LkmnYQvkMWAww3Ghgeu
         vQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858347; x=1702463147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKX+VQjgaUT7QW8pw5PXrpP0Vs60H0kH8aQmKKo9HyI=;
        b=brCMM2MKa8wCP4XnOLAxvtQSBxtL+vCQIGIPzd7o0+M0oKSB8sOs60mnn7LcdnYrjt
         cRVGSwOxEzYvSFWO1zoAh5Gfj2Co/BphN16PcvkpcUamkJqDOh4FczvHYQQqk79B+p6Y
         1ZLEr9MYMPw/adUT5r0aK7PSSfLXuvvTTA4S59YziWIeGxMcMZV4tZJ38dfy1Mu0j+vz
         4o44PUHagROvmGKKZYCrVQFveT2fdLGHgovA6uOkBbMEbvC3DUN1rI4nvlUcE22JNxzz
         zNWnxKZj/GUPlRjeJJLIj7vqF98bL48fanwmWEekyBoYgtu/QIT0EUDnG6gJMjrtCXby
         OXbw==
X-Gm-Message-State: AOJu0YxKO9bYvfGnMoEkJ/5GwAaEd2tvL+iHxM/z1RRw5YUeSSDrrT3D
        c0+WMwWeAISCrdFIddtv+nSGnCA5DkQprWm6iI0=
X-Google-Smtp-Source: AGHT+IE+Vd+bc5FQ6ScBLXr42AMECjU3h3DCBh6GLxbeJjo9dE2KF8c66OORSscUPBEmNMYeezxRFkr2aWx/C8n+gwM=
X-Received: by 2002:a67:f5d6:0:b0:464:84cc:fbda with SMTP id
 t22-20020a67f5d6000000b0046484ccfbdamr563042vso.69.1701858345953; Wed, 06 Dec
 2023 02:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20231204102027.57185-1-ryan.roberts@arm.com> <20231204102027.57185-5-ryan.roberts@arm.com>
 <CAGsJ_4zG6W_Z-u+3QcRDn4ByoeqUXjMusNS0RotfRMSqo8RCHg@mail.gmail.com>
 <CAGsJ_4zYhJWGx1DnHTiDnP3h1m8_rr6ZT6fXt8pO=jzs9QZS-A@mail.gmail.com>
 <5216caaf-1fcf-4715-99c3-521e2a1cc756@arm.com> <CAGsJ_4xHib66MP3-o9jpHGzKecmgb-omBXinazBbrCiwHkonEQ@mail.gmail.com>
 <c20b75c2-1636-47b8-b120-e0b8da326374@arm.com>
In-Reply-To: <c20b75c2-1636-47b8-b120-e0b8da326374@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 6 Dec 2023 23:25:34 +1300
Message-ID: <CAGsJ_4xsqAB6spgk3tw+96NY=+2036hx49tFNY66cMcmDamo+Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 11:16=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/12/2023 20:16, Barry Song wrote:
> > On Tue, Dec 5, 2023 at 11:48=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 05/12/2023 01:24, Barry Song wrote:
> >>> On Tue, Dec 5, 2023 at 9:15=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>>
> >>>> On Mon, Dec 4, 2023 at 6:21=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> Introduce the logic to allow THP to be configured (through the new =
sysfs
> >>>>> interface we just added) to allocate large folios to back anonymous
> >>>>> memory, which are larger than the base page size but smaller than
> >>>>> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
> >>>>>
> >>>>> mTHP continues to be PTE-mapped, but in many cases can still provid=
e
> >>>>> similar benefits to traditional PMD-sized THP: Page faults are
> >>>>> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending=
 on
> >>>>> the configured order), but latency spikes are much less prominent
> >>>>> because the size of each page isn't as huge as the PMD-sized varian=
t and
> >>>>> there is less memory to clear in each page fault. The number of per=
-page
> >>>>> operations (e.g. ref counting, rmap management, lru list management=
) are
> >>>>> also significantly reduced since those ops now become per-folio.
> >>>>>
> >>>>> Some architectures also employ TLB compression mechanisms to squeez=
e
> >>>>> more entries in when a set of PTEs are virtually and physically
> >>>>> contiguous and approporiately aligned. In this case, TLB misses wil=
l
> >>>>> occur less often.
> >>>>>
> >>>>> The new behaviour is disabled by default, but can be enabled at run=
time
> >>>>> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/ena=
bled
> >>>>> (see documentation in previous commit). The long term aim is to cha=
nge
> >>>>> the default to include suitable lower orders, but there are some ri=
sks
> >>>>> around internal fragmentation that need to be better understood fir=
st.
> >>>>>
> >>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> ---
> >>>>>  include/linux/huge_mm.h |   6 ++-
> >>>>>  mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++=
----
> >>>>>  2 files changed, 101 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>> index bd0eadd3befb..91a53b9835a4 100644
> >>>>> --- a/include/linux/huge_mm.h
> >>>>> +++ b/include/linux/huge_mm.h
> >>>>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
> >>>>>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >>>>>
> >>>>>  /*
> >>>>> - * Mask of all large folio orders supported for anonymous THP.
> >>>>> + * Mask of all large folio orders supported for anonymous THP; all=
 orders up to
> >>>>> + * and including PMD_ORDER, except order-0 (which is not "huge") a=
nd order-1
> >>>>> + * (which is a limitation of the THP implementation).
> >>>>>   */
> >>>>> -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
> >>>>> +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0=
) | BIT(1)))
> >>>>>
> >>>>>  /*
> >>>>>   * Mask of all large folio orders supported for file THP.
> >>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>> index 3ceeb0f45bf5..bf7e93813018 100644
> >>>>> --- a/mm/memory.c
> >>>>> +++ b/mm/memory.c
> >>>>> @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >>>>>         return ret;
> >>>>>  }
> >>>>>
> >>>>> +static bool pte_range_none(pte_t *pte, int nr_pages)
> >>>>> +{
> >>>>> +       int i;
> >>>>> +
> >>>>> +       for (i =3D 0; i < nr_pages; i++) {
> >>>>> +               if (!pte_none(ptep_get_lockless(pte + i)))
> >>>>> +                       return false;
> >>>>> +       }
> >>>>> +
> >>>>> +       return true;
> >>>>> +}
> >>>>> +
> >>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> >>>>> +{
> >>>>> +       gfp_t gfp;
> >>>>> +       pte_t *pte;
> >>>>> +       unsigned long addr;
> >>>>> +       struct folio *folio;
> >>>>> +       struct vm_area_struct *vma =3D vmf->vma;
> >>>>> +       unsigned long orders;
> >>>>> +       int order;
> >>>>> +
> >>>>> +       /*
> >>>>> +        * If uffd is active for the vma we need per-page fault fid=
elity to
> >>>>> +        * maintain the uffd semantics.
> >>>>> +        */
> >>>>> +       if (userfaultfd_armed(vma))
> >>>>> +               goto fallback;
> >>>>> +
> >>>>> +       /*
> >>>>> +        * Get a list of all the (large) orders below PMD_ORDER tha=
t are enabled
> >>>>> +        * for this vma. Then filter out the orders that can't be a=
llocated over
> >>>>> +        * the faulting address and still be fully contained in the=
 vma.
> >>>>> +        */
> >>>>> +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, fal=
se, true, true,
> >>>>> +                                         BIT(PMD_ORDER) - 1);
> >>>>> +       orders =3D thp_vma_suitable_orders(vma, vmf->address, order=
s);
> >>>>> +
> >>>>> +       if (!orders)
> >>>>> +               goto fallback;
> >>>>> +
> >>>>> +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >>>>> +       if (!pte)
> >>>>> +               return ERR_PTR(-EAGAIN);
> >>>>> +
> >>>>> +       order =3D first_order(orders);
> >>>>> +       while (orders) {
> >>>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orde=
r);
> >>>>> +               vmf->pte =3D pte + pte_index(addr);
> >>>>> +               if (pte_range_none(vmf->pte, 1 << order))
> >>>>> +                       break;
> >>>>> +               order =3D next_order(&orders, order);
> >>>>> +       }
> >>>>> +
> >>>>> +       vmf->pte =3D NULL;
> >>>>> +       pte_unmap(pte);
> >>>>> +
> >>>>> +       gfp =3D vma_thp_gfp_mask(vma);
> >>>>> +
> >>>>> +       while (orders) {
> >>>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orde=
r);
> >>>>> +               folio =3D vma_alloc_folio(gfp, order, vma, addr, tr=
ue);
> >>>>> +               if (folio) {
> >>>>> +                       clear_huge_page(&folio->page, addr, 1 << or=
der);
> >>>>
> >>>> Minor.
> >>>>
> >>>> Do we have to constantly clear a huge page? Is it possible to let
> >>>> post_alloc_hook()
> >>>> finish this job by using __GFP_ZERO/__GFP_ZEROTAGS as
> >>>> vma_alloc_zeroed_movable_folio() is doing?
> >>
> >> I'm currently following the same allocation pattern as is done for PMD=
-sized
> >> THP. In earlier versions of this patch I was trying to be smarter and =
use the
> >> __GFP_ZERO/__GFP_ZEROTAGS as you suggest, but I was advised to keep it=
 simple
> >> and follow the existing pattern.
> >>
> >> I have a vague recollection __GFP_ZERO is not preferred for large foli=
os because
> >> of some issue with virtually indexed caches? (Matthew: did I see you m=
ention
> >> that in some other context?)
> >>
> >> That said, I wasn't aware that Android ships with
> >> CONFIG_INIT_ON_ALLOC_DEFAULT_ON (I thought it was only used as a debug=
 option),
> >> so I can see the potential for some overhead reduction here.
> >>
> >> Options:
> >>
> >>  1) leave it as is and accept the duplicated clearing
> >>  2) Pass __GFP_ZERO and remove clear_huge_page()
> >>  3) define __GFP_SKIP_ZERO even when kasan is not enabled and pass it =
down so
> >>     clear_huge_page() is the only clear
> >>  4) make clear_huge_page() conditional on !want_init_on_alloc()
> >>
> >> I prefer option 4. What do you think?
> >
> > either 1 and 4 is ok to me if we will finally remove this duplicated
> > clear_huge_page on top.
> > 4 is even better as it can at least temporarily resolve the problem.
>
> I'm going to stick with option 1 for this series. Then we can fix it unif=
ormly
> here and for PMD-sized THP in a separate patch (possibly with the approac=
h
> suggested in 4).

Ok. Thanks. there is no one fixing PMD-sized THP, probably because PMD-size=
d
THP is shutdown immediately after Android boots :-)

>
> >
> > in Android gki_defconfig,
> > https://android.googlesource.com/kernel/common/+/refs/heads/android14-6=
.1-lts/arch/arm64/configs/gki_defconfig
> >
> > Android always has the below,
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
> >
> > here is some explanation for the reason,
> > https://source.android.com/docs/security/test/memory-safety/zero-initia=
lized-memory
> >
> >>
> >> As an aside, I've also noticed that clear_huge_page() should take vmf-=
>address
> >> so that it clears the faulting page last to keep the cache hot. If we =
decide on
> >> an option that keeps clear_huge_page(), I'll also make that change.
>
> I'll make this change for the next version.
>
> >>
> >> Thanks,
> >> Ryan
> >>

Thanks
Barry
