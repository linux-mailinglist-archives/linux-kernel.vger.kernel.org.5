Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C967B3A67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjI2THw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2THu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:07:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0F5195
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:07:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-279150bad13so1665458a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696014467; x=1696619267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCYPjN0yoearjEsSFF68E1sP3QXMDNTGCnc22SIpFoY=;
        b=G1diTRizF6S/ael5r8c+zhUoUqhrIRNFUbn6RYJnBTgxNGCNC5zNQW4I45MuS0h2a2
         pTC54HiRCQ5pLZee1vKUzyrWuRQT2zU1dJd22+fEff74ilRzbr5qQPPmxhF8hZF4wpgg
         1fhdG0UaFc5/Lh8k6HszZjDBmX90VGpe4VHPuhnSRut4bYoyrHTrJnVdBhipTrfVCsaJ
         AxmJgZdi3J9fM4VX6u/k7OZfyPrGNlhNQ3lrhnW8TnoZDwFo8EYAJyisJbPDR7+ifVOE
         I1pAmGG0Qygj8NzzIV+NjJlsAcZfqr0TBqQQO+9YP5zXvUhrSPXTzdyLrvtmp9Jp/wAH
         s5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014467; x=1696619267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCYPjN0yoearjEsSFF68E1sP3QXMDNTGCnc22SIpFoY=;
        b=nZMYRb8UGNhfWiKGIR92C5cmgy4UwmDBfOsEL8eomYlLVkOxmtXaUNOcQSKUIWA67A
         Il5p+0D25N5ChWHBMtGPOkLL39XJZ2qYmN0R/VsqqX9AXR8gsrfHfAs/Yq5MpjXjEP3o
         90Vs0du1n4ANGg4dIeeQhYpqp6H/ggQU8sjDIwUXVzrmsRNWsmq3akPKUT6GH0DnHQmr
         qLmB2iJ0JQzDlwXfADaIKfhw/NoIB7iwaOS4SMEGPvrIVgdzNwIH5TSXkfgMjV2PGfxx
         Ki0ZSLWA+9PGZZ8JK+mzydW1ZeXJJqY/hwE10H0UPAIE+YHKN7E996kZHiYDzFjS6zkc
         RQNw==
X-Gm-Message-State: AOJu0YxnSUJLwarnqTsCb+sAaIEC8GJ1ey7Fif9h/WXSvijuS6FA++7Y
        aXT1MjLf9nGqhUQYjn7u697MOWyg1F9QWGt5m1PYVfiw
X-Google-Smtp-Source: AGHT+IFEWy/Wp8KYceaMyuC480m7sjixa5zqDnwKTAEwA57fwc+vqYeo5pIGdjF4ntQcDOlFW8ZpW3GwmHdxF8N/Mwg=
X-Received: by 2002:a17:90a:4f0d:b0:268:ca76:64a with SMTP id
 p13-20020a17090a4f0d00b00268ca76064amr4420059pjh.49.1696014467474; Fri, 29
 Sep 2023 12:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-3-vishal.moola@gmail.com> <CAHbLzkqt8LFFDH2a7+xaQmncwiK=Ynv6vHs9d=TDNjp9_wJ4rw@mail.gmail.com>
In-Reply-To: <CAHbLzkqt8LFFDH2a7+xaQmncwiK=Ynv6vHs9d=TDNjp9_wJ4rw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Sep 2023 12:07:35 -0700
Message-ID: <CAHbLzkqK+V5EhJ7JgA11VnBPYKD9=HNB0rLJ2_1J-s34BtNeTw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/khugepaged: Remove compound_pagelist
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 3:07=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Fri, Sep 22, 2023 at 9:33=E2=80=AFPM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
> >
> > Currently, khugepaged builds a compound_pagelist while scanning, which
> > is used to properly account for compound pages. We can now account
> > for a compound page as a singular folio instead, so remove this list.
> >
> > Large folios are guaranteed to have consecutive ptes and addresses, so
> > once the first pte of a large folio is found skip over the rest.
>
> The address space may just map a partial folio, for example, in the
> extreme case the HUGE_PMD size range may have HUGE_PMD_NR folios with
> mapping one subpage from each folio per PTE. So assuming the PTE
> mapped folio is mapped consecutively may be wrong.
>
> Please refer to collapse_compound_extreme() in
> tools/testing/selftests/mm/khugepaged.c.
>
> >
> > This helps convert khugepaged to use folios. It removes 3 compound_head
> > calls in __collapse_huge_page_copy_succeeded(), and removes 980 bytes o=
f
> > kernel text.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/khugepaged.c | 76 ++++++++++++-------------------------------------
> >  1 file changed, 18 insertions(+), 58 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index f46a7a7c489f..b6c7d55a8231 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -498,10 +498,9 @@ static void release_pte_page(struct page *page)
> >         release_pte_folio(page_folio(page));
> >  }
> >
> > -static void release_pte_pages(pte_t *pte, pte_t *_pte,
> > -               struct list_head *compound_pagelist)
> > +static void release_pte_folios(pte_t *pte, pte_t *_pte)
> >  {
> > -       struct folio *folio, *tmp;
> > +       struct folio *folio;
> >
> >         while (--_pte >=3D pte) {
> >                 pte_t pteval =3D ptep_get(_pte);
> > @@ -514,12 +513,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_=
pte,
> >                         continue;
> >                 folio =3D pfn_folio(pfn);
> >                 if (folio_test_large(folio))
> > -                       continue;
> > -               release_pte_folio(folio);
> > -       }
> > -
> > -       list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
> > -               list_del(&folio->lru);
> > +                       _pte -=3D folio_nr_pages(folio) - 1;
> >                 release_pte_folio(folio);
> >         }
> >  }
> > @@ -538,8 +532,7 @@ static bool is_refcount_suitable(struct page *page)
> >  static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >                                         unsigned long address,
> >                                         pte_t *pte,
> > -                                       struct collapse_control *cc,
> > -                                       struct list_head *compound_page=
list)
> > +                                       struct collapse_control *cc)
> >  {
> >         struct folio *folio =3D NULL;
> >         pte_t *_pte;
> > @@ -588,19 +581,6 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >                         }
> >                 }
> >
> > -               if (folio_test_large(folio)) {
> > -                       struct folio *f;
> > -
> > -                       /*
> > -                        * Check if we have dealt with the compound pag=
e
> > -                        * already
> > -                        */
> > -                       list_for_each_entry(f, compound_pagelist, lru) =
{
> > -                               if (folio =3D=3D f)
> > -                                       goto next;
> > -                       }
> > -               }
> > -
> >                 /*
> >                  * We can do it before isolate_lru_page because the
> >                  * page can't be freed from under us. NOTE: PG_lock
> > @@ -644,9 +624,6 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                 VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >                 VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >
> > -               if (folio_test_large(folio))
> > -                       list_add_tail(&folio->lru, compound_pagelist);
> > -next:
> >                 /*
> >                  * If collapse was initiated by khugepaged, check that =
there is
> >                  * enough young pte to justify collapsing the page
> > @@ -660,6 +637,10 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >                 if (pte_write(pteval))
> >                         writable =3D true;
> >
> > +               if (folio_test_large(folio)) {
> > +                       _pte +=3D folio_nr_pages(folio) - 1;
> > +                       address +=3D folio_size(folio) - PAGE_SIZE;
> > +               }
> >         }
> >
> >         if (unlikely(!writable)) {
> > @@ -673,7 +654,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                 return result;
> >         }
> >  out:
> > -       release_pte_pages(pte, _pte, compound_pagelist);
> > +       release_pte_folios(pte, _pte);
> >         trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> >                                             referenced, writable, resul=
t);
> >         return result;
> > @@ -682,11 +663,9 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >  static void __collapse_huge_page_copy_succeeded(pte_t *pte,
> >                                                 struct vm_area_struct *=
vma,
> >                                                 unsigned long address,
> > -                                               spinlock_t *ptl,
> > -                                               struct list_head *compo=
und_pagelist)
> > +                                               spinlock_t *ptl)
> >  {
> >         struct page *src_page;
> > -       struct page *tmp;
> >         pte_t *_pte;
> >         pte_t pteval;
> >
> > @@ -706,8 +685,7 @@ static void __collapse_huge_page_copy_succeeded(pte=
_t *pte,
> >                         }
> >                 } else {
> >                         src_page =3D pte_page(pteval);
> > -                       if (!PageCompound(src_page))
> > -                               release_pte_page(src_page);
> > +                       release_pte_page(src_page);

This line is problematic too. It may cause double unlock if I read it
correctly. The loop scans the mapped subpages from the same folio,
release_pte_page() is called for the same folio multiple times.

> >                         /*
> >                          * ptl mostly unnecessary, but preempt has to
> >                          * be disabled to update the per-cpu stats
> > @@ -720,23 +698,12 @@ static void __collapse_huge_page_copy_succeeded(p=
te_t *pte,
> >                         free_page_and_swap_cache(src_page);
> >                 }
> >         }
> > -
> > -       list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru)=
 {
> > -               list_del(&src_page->lru);
> > -               mod_node_page_state(page_pgdat(src_page),
> > -                                   NR_ISOLATED_ANON + page_is_file_lru=
(src_page),
> > -                                   -compound_nr(src_page));
> > -               unlock_page(src_page);
> > -               free_swap_cache(src_page);
> > -               putback_lru_page(src_page);
> > -       }
> >  }
> >
> >  static void __collapse_huge_page_copy_failed(pte_t *pte,
> >                                              pmd_t *pmd,
> >                                              pmd_t orig_pmd,
> > -                                            struct vm_area_struct *vma=
,
> > -                                            struct list_head *compound=
_pagelist)
> > +                                            struct vm_area_struct *vma=
)
> >  {
> >         spinlock_t *pmd_ptl;
> >
> > @@ -753,7 +720,7 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >          * Release both raw and compound pages isolated
> >          * in __collapse_huge_page_isolate.
> >          */
> > -       release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> > +       release_pte_folios(pte, pte + HPAGE_PMD_NR);
> >  }
> >
> >  /*
> > @@ -769,7 +736,6 @@ static void __collapse_huge_page_copy_failed(pte_t =
*pte,
> >   * @vma: the original raw pages' virtual memory area
> >   * @address: starting address to copy
> >   * @ptl: lock on raw pages' PTEs
> > - * @compound_pagelist: list that stores compound pages
> >   */
> >  static int __collapse_huge_page_copy(pte_t *pte,
> >                                      struct page *page,
> > @@ -777,8 +743,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
> >                                      pmd_t orig_pmd,
> >                                      struct vm_area_struct *vma,
> >                                      unsigned long address,
> > -                                    spinlock_t *ptl,
> > -                                    struct list_head *compound_pagelis=
t)
> > +                                    spinlock_t *ptl)
> >  {
> >         struct page *src_page;
> >         pte_t *_pte;
> > @@ -804,11 +769,9 @@ static int __collapse_huge_page_copy(pte_t *pte,
> >         }
> >
> >         if (likely(result =3D=3D SCAN_SUCCEED))
> > -               __collapse_huge_page_copy_succeeded(pte, vma, address, =
ptl,
> > -                                                   compound_pagelist);
> > +               __collapse_huge_page_copy_succeeded(pte, vma, address, =
ptl);
> >         else
> > -               __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vm=
a,
> > -                                                compound_pagelist);
> > +               __collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vm=
a);
> >
> >         return result;
> >  }
> > @@ -1081,7 +1044,6 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >                               int referenced, int unmapped,
> >                               struct collapse_control *cc)
> >  {
> > -       LIST_HEAD(compound_pagelist);
> >         pmd_t *pmd, _pmd;
> >         pte_t *pte;
> >         pgtable_t pgtable;
> > @@ -1168,8 +1130,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >
> >         pte =3D pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
> >         if (pte) {
> > -               result =3D __collapse_huge_page_isolate(vma, address, p=
te, cc,
> > -                                                     &compound_pagelis=
t);
> > +               result =3D __collapse_huge_page_isolate(vma, address, p=
te, cc);
> >                 spin_unlock(pte_ptl);
> >         } else {
> >                 result =3D SCAN_PMD_NULL;
> > @@ -1198,8 +1159,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >         anon_vma_unlock_write(vma->anon_vma);
> >
> >         result =3D __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
> > -                                          vma, address, pte_ptl,
> > -                                          &compound_pagelist);
> > +                                          vma, address, pte_ptl);
> >         pte_unmap(pte);
> >         if (unlikely(result !=3D SCAN_SUCCEED))
> >                 goto out_up_write;
> > --
> > 2.40.1
> >
