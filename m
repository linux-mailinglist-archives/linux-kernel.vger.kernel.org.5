Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47616756E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjGQUg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGQUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:36:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA91A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:36:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401d1d967beso87991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689626184; x=1692218184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG3UloC6pPSvkIYL8rMmu+UHUcjJ8ZWmhMAzCruBxHE=;
        b=iRjdQMzCwzc8zxaE0VcML8ZQquEPicxVIyConz1X5vBJjg/j+HWQsY18+JfB3kDuL+
         t5UnYN0JVwbPAEvQxmPu6bCCDcavRFvllYcEEo0PzEAHIASq0B0UeU89StmjD6IeCi5y
         7Nuz3q8fM+mNxNHbHPppbhX5z++/7eUsCrGsoiHtj05zuA1Vray53MUyG0p9Ef78eAPO
         LRMAwvVIrop1vzNigqNhcoTl2u3/h9DnrzFxoImhhK45lbHz95EMbHb8c5UvqEOBKsn6
         3wUaRsEC2VwSo/gq6N0DUwr3X6zxqXIBfsg99qfpbsJiKdSzsVzxsbmWKPm9+S27okgo
         Db4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626184; x=1692218184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG3UloC6pPSvkIYL8rMmu+UHUcjJ8ZWmhMAzCruBxHE=;
        b=F07aXOz8nNblv0BSvCevEi0resN0svbIhAjtFSzHmn5L3X6BwauJ5/ML5+1umRbXx0
         RJl1/GisiZPcKcigYhezm+6evhjJEtRx9Uwqrj3NHoLDLnuNc7Nys11FHCgbtSpfZETF
         M8p+EE+AJFEo1lQFBV9VCjZbyPE22BvqGiWnipob5pRrBwrKC2K/qJYPVXThPP+kLKZH
         wBQTFoPT2/EaiTlywhLRi/2ZZkmZUqpGYcCG9gOS9kSc09z7jJBMcnhlaPF0UzTlR6tR
         rF5xVHgIT8/ZtdNzQOQ2rZxMyG+HZ5sGivl4iHeB60rUGoEO9fU4IDEW0tjDcojSS8St
         vb+A==
X-Gm-Message-State: ABy/qLajOVbgA7TyCcC6OqDRJZ2iL17UuKCBjVpa+efEbfplhpKDuS4U
        Oy37f5V8uCAtdcBklhpr3eYnbzXNHoYG/dtZd6UxuyiSL6vxoafxzenOQA==
X-Google-Smtp-Source: APBJJlHoQ1hCZX4jmZcqjxUm4/c4z+1Rlze98VqSxDFJSoPTZ6il6ivy3Eok+/OrcTOc6/5Njnh1y/+9N/I2a0i07hg=
X-Received: by 2002:a05:622a:34c:b0:403:ac17:c18a with SMTP id
 r12-20020a05622a034c00b00403ac17c18amr74135qtw.14.1689626184158; Mon, 17 Jul
 2023 13:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com> <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com> <CAOUHufaDfJwF_-zb6zV5COG-KaaGcSyrNmbaEzaWz2UjcGGgHQ@mail.gmail.com>
 <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com> <CAOUHufb3Ugh_eZ7kPxuGyHFgPCVecMAU6hEAaWYrb7f6h7-0LQ@mail.gmail.com>
In-Reply-To: <CAOUHufb3Ugh_eZ7kPxuGyHFgPCVecMAU6hEAaWYrb7f6h7-0LQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 17 Jul 2023 14:35:47 -0600
Message-ID: <CAOUHufa+4DVjLWRa_zVRHQ0yVF_h9mfSaqmn7VJ6bArSw49S+g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Jul 17, 2023 at 1:31=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jul 17, 2023 at 7:36=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > >>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **=
folio)
> > >>>> +{
> > >>>> +       int i;
> > >>>> +       gfp_t gfp;
> > >>>> +       pte_t *pte;
> > >>>> +       unsigned long addr;
> > >>>> +       struct vm_area_struct *vma =3D vmf->vma;
> > >>>> +       int prefer =3D anon_folio_order(vma);
> > >>>> +       int orders[] =3D {
> > >>>> +               prefer,
> > >>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COST=
LY_ORDER : 0,
> > >>>> +               0,
> > >>>> +       };
> > >>>> +
> > >>>> +       *folio =3D NULL;
> > >>>> +
> > >>>> +       if (vmf_orig_pte_uffd_wp(vmf))
> > >>>> +               goto fallback;
> > >>>> +
> > >>>> +       for (i =3D 0; orders[i]; i++) {
> > >>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << ord=
ers[i]);
> > >>>> +               if (addr >=3D vma->vm_start &&
> > >>>> +                   addr + (PAGE_SIZE << orders[i]) <=3D vma->vm_e=
nd)
> > >>>> +                       break;
> > >>>> +       }
> > >>>> +
> > >>>> +       if (!orders[i])
> > >>>> +               goto fallback;
> > >>>> +
> > >>>> +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> > >>>> +       if (!pte)
> > >>>> +               return -EAGAIN;
> > >>>
> > >>> It would be a bug if this happens. So probably -EINVAL?
> > >>
> > >> Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1=
 makes it
> > >> possible for pte_offset_map() to fail (if I understood correctly) an=
d we have to
> > >> handle this. The intent is that we will return from the fault withou=
t making any
> > >> change, then we will refault and try again.
> > >
> > > Thanks for checking that -- it's very relevant. One detail is that
> > > that series doesn't affect anon. IOW, collapsing PTEs into a PMD can'=
t
> > > happen while we are holding mmap_lock for read here, and therefore,
> > > the race that could cause pte_offset_map() on shmem/file PTEs to fail
> > > doesn't apply here.
> >
> > But Hugh's patches have changed do_anonymous_page() to handle failure f=
rom
> > pte_offset_map_lock(). So I was just following that pattern. If this re=
ally
> > can't happen, then I'd rather WARN/BUG on it, and simplify alloc_anon_f=
olio()'s
> > prototype to just return a `struct folio *` (and if it's null that mean=
s ENOMEM).
> >
> > Hugh, perhaps you can comment?
> >
> > As an aside, it was my understanding from LWN, that we are now using a =
per-VMA
> > lock so presumably we don't hold mmap_lock for read here? Or perhaps th=
at only
> > applies to file-backed memory?
>
> For anon under mmap_lock for read:
> 1. pte_offset_map[_lock]() fails when a parallel PF changes PMD from
> none to leaf.
> 2. changing PMD from non-leaf to leaf is a bug. See the comments in
> the "else" branch in handle_pte_fault().
>
> So for do_anonymous_page(), there is only one case
> pte_offset_map[_lock]() can fail.

=3D=3D=3D
> For the code above, this case was
> ruled out by vmf_orig_pte_uffd_wp().

Actually I was wrong about this part.
=3D=3D=3D

> Checking the return value from pte_offset_map[_lock]() is a good
> practice. What I'm saying is that -EAGAIN would mislead people to
> think, in our case, !pte is legitimate, and hence the suggestion of
> replacing it with -EINVAL.

Yes, -EAGAIN is suitable.

> No BUG_ON() please. As I've previously mentioned, it's against
> Documentation/process/coding-style.rst.
>
> > > +Hugh Dickins for further consultation if you need it.
> > >
> > >>>> +
> > >>>> +       for (; orders[i]; i++) {
> > >>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << ord=
ers[i]);
> > >>>> +               vmf->pte =3D pte + pte_index(addr);
> > >>>> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
> > >>>> +                       break;
> > >>>> +       }
> > >>>> +
> > >>>> +       vmf->pte =3D NULL;
> > >>>> +       pte_unmap(pte);
> > >>>> +
> > >>>> +       gfp =3D vma_thp_gfp_mask(vma);
> > >>>> +
> > >>>> +       for (; orders[i]; i++) {
> > >>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << ord=
ers[i]);
> > >>>> +               *folio =3D vma_alloc_folio(gfp, orders[i], vma, ad=
dr, true);
> > >>>> +               if (*folio) {
> > >>>> +                       clear_huge_page(&(*folio)->page, addr, 1 <=
< orders[i]);
> > >>>> +                       return 0;
> > >>>> +               }
> > >>>> +       }
> > >>>> +
> > >>>> +fallback:
> > >>>> +       *folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->addres=
s);
> > >>>> +       return *folio ? 0 : -ENOMEM;
> > >>>> +}
> > >>>> +#else
> > >>>> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct f=
olio **folio)
> > >>>
> > >>> Drop "inline" (it doesn't do anything in .c).
> > >>
> > >> There are 38 instances of inline in memory.c alone, so looks like a =
well used
> > >> convention, even if the compiler may choose to ignore. Perhaps you c=
an educate
> > >> me; what's the benefit of dropping it?
> > >
> > > I'll let Willy and Andrew educate both of us :)
> > >
> > > +Matthew Wilcox +Andrew Morton please. Thank you.
> > >
> > >>> The rest looks good to me.
> > >>
> > >> Great - just incase it wasn't obvious, I decided not to overwrite vm=
f->address
> > >> with the aligned version, as you suggested
> > >
> > > Yes, I've noticed. Not overwriting has its own merits for sure.
> > >
> > >> for 2 reasons; 1) address is const
> > >> in the struct, so would have had to change that. 2) there is a uffd =
path that
> > >> can be taken after the vmf->address fixup would have occured and the=
 path
> > >> consumes that member, so it would have had to be un-fixed-up making =
it more
> > >> messy than the way I opted for.
> > >>
> > >> Thanks for the quick review as always!
