Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A6756D43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjGQTcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGQTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:32:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D548E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:32:07 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40371070eb7so56921cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689622326; x=1692214326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJjS2MKoaxJHnAQjvrDhXqMPcmj9GPq6druRIeP/a3w=;
        b=eEZoK578XjidGGSs/x5nWoMgo1UcO+mpQdHymRPXuEizNfKai/jwiuJeACRRl1ncoU
         2UFlRA5Bwc7UfPRaBKkPedL1u8E7CFqmhK3j1x1xNWJdP7BgyEGwqiucOURV+x7rGPIg
         +rdFmPMdQgT1bQne5iKIfpwnHwTyKq1sybcRjOOeYfCCrqDtFT+5g4OB/fMKzMqp2J2F
         a3aJAcaC0r0zOxoY8sDabnQTCSn5oYVPIkrYC3CERtAElP0F4k7I4W7WPT0S8mRJTQRa
         a3/gf9+cofgUgnJ/g53dRmOrJ5x8Pw23beN6Cy0/StrbDOtgPqKa0r1XhscBiuH0yNl6
         3oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622326; x=1692214326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJjS2MKoaxJHnAQjvrDhXqMPcmj9GPq6druRIeP/a3w=;
        b=Y0aCPjTvUrvj+ee4F6q1jJmtRfl3oJvIcgm9FiQkxgKH4C6UadUWYcHzLtst1BNQGY
         0AfiCOTpx4wIYnXJUZ2cUZDEkXjthJaNiuB28dPnD1SISHvSoSoOlWTB4ovkAVOi9Q9U
         E/fKk1mFismxNXSGgQ4Qt/gevN/SG6vZFWKf60DUZTvE5p7/ERGGRbUbmgmSQSVAtcAz
         uUTem/MRtH/XE2ni5dqAuMg9CmFArs8ZtGPV/VbfvFiEWiNgHdUMaI231EMZgsQj1LZ3
         jkh+W5se9hMzZ6NIXO3ySKdxFArt8JkCv0sKf4aRuBcDAVcLeOfMgwb145zhHQEQZ2wG
         3unA==
X-Gm-Message-State: ABy/qLbisZTURpPi3rQHqmSiuID0Z9xH5fsePBO7yDrBdonUDMoCGjY1
        0yRDZ/HPyIouIAk1/n3DpNUXQB49SboWOWBVmEIaLQ==
X-Google-Smtp-Source: APBJJlGFkCcjE+9R4DIuEHvn9v4EanNueQ7hy8UO9ZuOg7HM5tC5oqYA4jgrOVFDTg9qY4RU5FnlUER7zLVZp8OY7g4=
X-Received: by 2002:a05:622a:612:b0:403:affb:3c03 with SMTP id
 z18-20020a05622a061200b00403affb3c03mr45444qta.10.1689622326499; Mon, 17 Jul
 2023 12:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com> <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com> <CAOUHufaDfJwF_-zb6zV5COG-KaaGcSyrNmbaEzaWz2UjcGGgHQ@mail.gmail.com>
 <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com>
In-Reply-To: <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 17 Jul 2023 13:31:30 -0600
Message-ID: <CAOUHufb3Ugh_eZ7kPxuGyHFgPCVecMAU6hEAaWYrb7f6h7-0LQ@mail.gmail.com>
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

On Mon, Jul 17, 2023 at 7:36=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> >>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **fo=
lio)
> >>>> +{
> >>>> +       int i;
> >>>> +       gfp_t gfp;
> >>>> +       pte_t *pte;
> >>>> +       unsigned long addr;
> >>>> +       struct vm_area_struct *vma =3D vmf->vma;
> >>>> +       int prefer =3D anon_folio_order(vma);
> >>>> +       int orders[] =3D {
> >>>> +               prefer,
> >>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY=
_ORDER : 0,
> >>>> +               0,
> >>>> +       };
> >>>> +
> >>>> +       *folio =3D NULL;
> >>>> +
> >>>> +       if (vmf_orig_pte_uffd_wp(vmf))
> >>>> +               goto fallback;
> >>>> +
> >>>> +       for (i =3D 0; orders[i]; i++) {
> >>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order=
s[i]);
> >>>> +               if (addr >=3D vma->vm_start &&
> >>>> +                   addr + (PAGE_SIZE << orders[i]) <=3D vma->vm_end=
)
> >>>> +                       break;
> >>>> +       }
> >>>> +
> >>>> +       if (!orders[i])
> >>>> +               goto fallback;
> >>>> +
> >>>> +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >>>> +       if (!pte)
> >>>> +               return -EAGAIN;
> >>>
> >>> It would be a bug if this happens. So probably -EINVAL?
> >>
> >> Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1 m=
akes it
> >> possible for pte_offset_map() to fail (if I understood correctly) and =
we have to
> >> handle this. The intent is that we will return from the fault without =
making any
> >> change, then we will refault and try again.
> >
> > Thanks for checking that -- it's very relevant. One detail is that
> > that series doesn't affect anon. IOW, collapsing PTEs into a PMD can't
> > happen while we are holding mmap_lock for read here, and therefore,
> > the race that could cause pte_offset_map() on shmem/file PTEs to fail
> > doesn't apply here.
>
> But Hugh's patches have changed do_anonymous_page() to handle failure fro=
m
> pte_offset_map_lock(). So I was just following that pattern. If this real=
ly
> can't happen, then I'd rather WARN/BUG on it, and simplify alloc_anon_fol=
io()'s
> prototype to just return a `struct folio *` (and if it's null that means =
ENOMEM).
>
> Hugh, perhaps you can comment?
>
> As an aside, it was my understanding from LWN, that we are now using a pe=
r-VMA
> lock so presumably we don't hold mmap_lock for read here? Or perhaps that=
 only
> applies to file-backed memory?

For anon under mmap_lock for read:
1. pte_offset_map[_lock]() fails when a parallel PF changes PMD from
none to leaf.
2. changing PMD from non-leaf to leaf is a bug. See the comments in
the "else" branch in handle_pte_fault().

So for do_anonymous_page(), there is only one case
pte_offset_map[_lock]() can fail. For the code above, this case was
ruled out by vmf_orig_pte_uffd_wp().

Checking the return value from pte_offset_map[_lock]() is a good
practice. What I'm saying is that -EAGAIN would mislead people to
think, in our case, !pte is legitimate, and hence the suggestion of
replacing it with -EINVAL.

No BUG_ON() please. As I've previously mentioned, it's against
Documentation/process/coding-style.rst.

> > +Hugh Dickins for further consultation if you need it.
> >
> >>>> +
> >>>> +       for (; orders[i]; i++) {
> >>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order=
s[i]);
> >>>> +               vmf->pte =3D pte + pte_index(addr);
> >>>> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
> >>>> +                       break;
> >>>> +       }
> >>>> +
> >>>> +       vmf->pte =3D NULL;
> >>>> +       pte_unmap(pte);
> >>>> +
> >>>> +       gfp =3D vma_thp_gfp_mask(vma);
> >>>> +
> >>>> +       for (; orders[i]; i++) {
> >>>> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order=
s[i]);
> >>>> +               *folio =3D vma_alloc_folio(gfp, orders[i], vma, addr=
, true);
> >>>> +               if (*folio) {
> >>>> +                       clear_huge_page(&(*folio)->page, addr, 1 << =
orders[i]);
> >>>> +                       return 0;
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>> +fallback:
> >>>> +       *folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address)=
;
> >>>> +       return *folio ? 0 : -ENOMEM;
> >>>> +}
> >>>> +#else
> >>>> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct fol=
io **folio)
> >>>
> >>> Drop "inline" (it doesn't do anything in .c).
> >>
> >> There are 38 instances of inline in memory.c alone, so looks like a we=
ll used
> >> convention, even if the compiler may choose to ignore. Perhaps you can=
 educate
> >> me; what's the benefit of dropping it?
> >
> > I'll let Willy and Andrew educate both of us :)
> >
> > +Matthew Wilcox +Andrew Morton please. Thank you.
> >
> >>> The rest looks good to me.
> >>
> >> Great - just incase it wasn't obvious, I decided not to overwrite vmf-=
>address
> >> with the aligned version, as you suggested
> >
> > Yes, I've noticed. Not overwriting has its own merits for sure.
> >
> >> for 2 reasons; 1) address is const
> >> in the struct, so would have had to change that. 2) there is a uffd pa=
th that
> >> can be taken after the vmf->address fixup would have occured and the p=
ath
> >> consumes that member, so it would have had to be un-fixed-up making it=
 more
> >> messy than the way I opted for.
> >>
> >> Thanks for the quick review as always!
>
