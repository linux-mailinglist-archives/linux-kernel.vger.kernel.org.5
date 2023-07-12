Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73D8750F35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjGLREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGLREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:04:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09E1BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:04:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403b622101bso9091cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689181445; x=1691773445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVeD9z3PSK+aTOmTD9k9UOsEux3BkF5Ba5FOkdbVMMY=;
        b=oBUkGXWdvJ2JxocSbrod93y4yf8u6vIBXK9palvGTFrYpkNReBBTzs8NIKHoXVq9Cl
         gha2Znimw/T76YjOUILZAzyD9jk0B4VRXeSswhyty/RzU+qmXeK+0e1MYkon9NS58UeF
         TnslBH760mLeXap2axCSc2Is6XsXsZRpq1E9I4748r1Uz1SXf+dZCVdag6xCsHniv/Ey
         WIMlvrbeWXThZdzkUFkxMD8ED0F3PdT9V4V4xLDz6K+Xfyv+05xbDr0fEHUr6SK2eKwI
         8APyOje9W4pWYrW8Lszh7jAoDvOjdYLy6x32Pj6K11CBZd1jK4zZ7LlbYWiyoDztjwaD
         X8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181445; x=1691773445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVeD9z3PSK+aTOmTD9k9UOsEux3BkF5Ba5FOkdbVMMY=;
        b=cC+q15WPTDQeGu9IgLM7AwiJ6qFR3x1XbK7i8ek90lf8EKztf26NB+dp7/WHNvWxd5
         urlN7uGwnlahnXjgvbZlaR0k5MD4F+u41hoijlsLmw3SJ/enq/1ylNoaVtI2piwPt8wu
         iNG178k+2rMCON8NRbutHmNcdlv6sx2oNKg0+n8MxsVQt1Y9SVE10jm+TRQ5xjeU//bC
         LZc1jd4jUIJqbGfH58ssUUcIlwmJsrtZq2JirF+OEwAQZTTe/Ill1m+EdRPVlUbR3Vzd
         fZ03RZt0fMT0kzLYJsVwm0JmZ5bvYQSOmvewDY+kGKFrClxc6rBpv7nf3T8H5CwMjCEV
         O1NA==
X-Gm-Message-State: ABy/qLYAcYNTabKbvjcRWfzs8qKHYsvykTmmcrb7OjsAVpxzSVsUsF9c
        W7hP3aZImvLJZbvl/vPeDzbechnyTGhyJn1nJUs4qg==
X-Google-Smtp-Source: APBJJlGZ1d/pAUKgErJQIh+061YDvP9bTZu16m9NABkbpf09nzWY2JK0PAIPYbODZAbSKg1amLnx3kRjl6rFxzFpkQY=
X-Received: by 2002:a05:622a:241:b0:403:a43d:be41 with SMTP id
 c1-20020a05622a024100b00403a43dbe41mr332490qtx.20.1689181444608; Wed, 12 Jul
 2023 10:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-3-fengwei.yin@intel.com> <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com>
 <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
In-Reply-To: <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 12 Jul 2023 11:03:28 -0600
Message-ID: <CAOUHufbK87NBia8-3OnKwma3JVxe5mJ593yCy_a3HWC1tYH_EA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:44=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
> On 7/12/23 14:23, Yu Zhao wrote:
> > On Wed, Jul 12, 2023 at 12:02=E2=80=AFAM Yin Fengwei <fengwei.yin@intel=
.com> wrote:
> >>
> >> If large folio is in the range of VM_LOCKED VMA, it should be
> >> mlocked to avoid being picked by page reclaim. Which may split
> >> the large folio and then mlock each pages again.
> >>
> >> Mlock this kind of large folio to prevent them being picked by
> >> page reclaim.
> >>
> >> For the large folio which cross the boundary of VM_LOCKED VMA,
> >> we'd better not to mlock it. So if the system is under memory
> >> pressure, this kind of large folio will be split and the pages
> >> ouf of VM_LOCKED VMA can be reclaimed.
> >>
> >> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >> ---
> >>  mm/internal.h | 11 ++++++++---
> >>  mm/rmap.c     | 34 +++++++++++++++++++++++++++-------
> >>  2 files changed, 35 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index c7dd15d8de3ef..776141de2797a 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *f=
olio,
> >>          *    still be set while VM_SPECIAL bits are added: so ignore =
it then.
> >>          */
> >>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D V=
M_LOCKED) &&
> >> -           (compound || !folio_test_large(folio)))
> >> +           (compound || !folio_test_large(folio) ||
> >> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
> >>                 mlock_folio(folio);
> >>  }
> >
> > This can be simplified:
> > 1. remove the compound parameter
> Yes. There is not difference here for pmd mapping of THPs and pte mapping=
s of THPs
> if the only condition need check is whether the folio is within VMA range=
 or not.
>
> But let me add Huge for confirmation.
>
>
> > 2. make the if
> >         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D VM=
_LOCKED) &&
> >             folio_within_vma())
> >                 mlock_folio(folio);
> !folio_test_large(folio) was kept here by purpose. For normal 4K page, do=
n't need
> to call folio_within_vma() which is heavy for normal 4K page.

I suspected you would think so -- I don't think it would make any
measurable (for systems with mostly large folios, it would actually be
an extra work). Since we have many places like this once, probably we
could wrap folio_test_large() into folio_within_vma() and call it
large_folio_within_vma(), if you feel it's necessary.

> >> @@ -651,8 +652,12 @@ void munlock_folio(struct folio *folio);
> >>  static inline void munlock_vma_folio(struct folio *folio,
> >>                         struct vm_area_struct *vma, bool compound)
> >
> > Remove the compound parameter here too.
> >
> >>  {
> >> -       if (unlikely(vma->vm_flags & VM_LOCKED) &&
> >> -           (compound || !folio_test_large(folio)))
> >> +       /*
> >> +        * To handle the case that a mlocked large folio is unmapped f=
rom VMA
> >> +        * piece by piece, allow munlock the large folio which is part=
ially
> >> +        * mapped to VMA.
> >> +        */
> >> +       if (unlikely(vma->vm_flags & VM_LOCKED))
> >>                 munlock_folio(folio);
> >>  }
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 2668f5ea35342..455f415d8d9ca 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -803,6 +803,14 @@ struct folio_referenced_arg {
> >>         unsigned long vm_flags;
> >>         struct mem_cgroup *memcg;
> >>  };
> >> +
> >> +static inline bool should_restore_mlock(struct folio *folio,
> >> +               struct vm_area_struct *vma, bool pmd_mapped)
> >> +{
> >> +       return !folio_test_large(folio) ||
> >> +                       pmd_mapped || folio_within_vma(folio, vma);
> >> +}
> >
> > This is just folio_within_vma() :)
> >
> >>  /*
> >>   * arg: folio_referenced_arg will be passed
> >>   */
> >> @@ -816,13 +824,25 @@ static bool folio_referenced_one(struct folio *f=
olio,
> >>         while (page_vma_mapped_walk(&pvmw)) {
> >>                 address =3D pvmw.address;
> >>
> >> -               if ((vma->vm_flags & VM_LOCKED) &&
> >> -                   (!folio_test_large(folio) || !pvmw.pte)) {
> >> -                       /* Restore the mlock which got missed */
> >> -                       mlock_vma_folio(folio, vma, !pvmw.pte);
> >> -                       page_vma_mapped_walk_done(&pvmw);
> >> -                       pra->vm_flags |=3D VM_LOCKED;
> >> -                       return false; /* To break the loop */
> >> +               if (vma->vm_flags & VM_LOCKED) {
> >> +                       if (should_restore_mlock(folio, vma, !pvmw.pte=
)) {
> >> +                               /* Restore the mlock which got missed =
*/
> >> +                               mlock_vma_folio(folio, vma, !pvmw.pte)=
;
> >> +                               page_vma_mapped_walk_done(&pvmw);
> >> +                               pra->vm_flags |=3D VM_LOCKED;
> >> +                               return false; /* To break the loop */
> >> +                       } else {
> >
> > There is no need for "else", or just
> >
> >   if (!folio_within_vma())
> >     goto dec_pra_mapcount;
> I tried not to use goto as much as possible. I suppose you mean:
>
>     if (!should_restore_lock())
>         goto dec_pra_mapcount; (I may use continue here. :)).

should_restore_lock() is just folio_within_vma() -- see the comment
above. "continue" looks good to me too (prefer not to add more indents
to the functions below).

>     mlock_vma_folio();
>     page_vma_mapped_walk_done()
>    ...
>
> Right?

Right.
