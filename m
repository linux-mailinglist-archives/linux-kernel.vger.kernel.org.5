Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848057CE4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjJRRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjJRRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:37:12 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392F2D4B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:33:12 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7af20c488so87741597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697650391; x=1698255191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29LMb17t2WvZXiqVSSxiSoW1baNgIMJCymPjPvWCVfk=;
        b=FTJBCoZ44qIT4ic73E6chpWdRnXKvAZoGvTfgb6bX+NmZOwaUhMW6yeqiP0jNZVbFZ
         14GhG46x7Ae0IMZSyiYrxjvQXs5/VoKSqz8r74YygIIMp3dn9WerIYK6+uhPJNxrrPCG
         Qy/YfCICnO2kfyHVpMcXfIwCPzx4djAy/V6ohcNOKrNRIkxW4qQoya9y5mlXTU2bKS4l
         0Nugw1nEElqdBN8ZHR3+knE1NELzJZuHAm3sXFdcU/+k7P4pR6t53kcwDvjn8c0wj8YD
         jxKnAlQwzlf0lnc39K6k/5sZCdZu52zVXDzd1Obzv3NmAdFp3nhhSojyVs3YpFqJYfz4
         24Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650391; x=1698255191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29LMb17t2WvZXiqVSSxiSoW1baNgIMJCymPjPvWCVfk=;
        b=LWVwnH2qFVlJbx9iaunDDt7f8nXKaciPrNZruur3Yq1qqYEnNm+s1xH5R+/h9ImTs2
         yHVM+bqnSH6h0+vyB1o0V+Yq2pFEKhQhvqGR+GZuSFQEM7CsBx9M0dWTpUZgEMUjzCaY
         0a6NAYQ5A1UMAgOAzdowoh/DAOWC3kbr4NvQSgOjmbZmaLVUDIrsgXB7QzH2WJVV5zOw
         w4sRkcXRbyqlcrnWZt7n9648RW3dyxdWgfjgVta1b9X3Mko6uWdhwpPbc+QNu4s29CNv
         WYrP2bvhKhFEyB8QG2NdCUW8sHeikS8LbqreFXxp1NcljO/WAdEUEFBBn5/ODdWzZHL6
         8XVA==
X-Gm-Message-State: AOJu0YztLF297xRKsvWubuHW1qKaFag61ChYH+Ed/5egUtlQS/ucxo6I
        TGKZmq1e9ge8RBnSzV3pc2gF3KMgDIiQIW3cBO+4EW2a
X-Google-Smtp-Source: AGHT+IEHZ8IlhTaOwhvyH851RRGnxtg3fgGPAj6DCeEtPcTQdxNcOuQpijzhW6as7LqVPOX4nd/QZZ1aubAWOXFJVh8=
X-Received: by 2002:a25:26d1:0:b0:d9b:2477:b624 with SMTP id
 m200-20020a2526d1000000b00d9b2477b624mr17199ybm.64.1697650391317; Wed, 18 Oct
 2023 10:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231016200510.7387-1-vishal.moola@gmail.com> <20231016200510.7387-3-vishal.moola@gmail.com>
 <CAHbLzkrTmt=5ECLG0ZQs=14BxHhKZtDY1DfG3mSau7LU-0PeKw@mail.gmail.com>
In-Reply-To: <CAHbLzkrTmt=5ECLG0ZQs=14BxHhKZtDY1DfG3mSau7LU-0PeKw@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 18 Oct 2023 10:33:00 -0700
Message-ID: <CAOzc2pw7K=6Vqp=ptZQDNOP1Q9g+oqViJnVus6RsUXuOJnJyuQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/khugepaged: Convert hpage_collapse_scan_pmd() to
 use folios
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 1:41=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Mon, Oct 16, 2023 at 1:06=E2=80=AFPM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
> >
> > Replaces 5 calls to compound_head(), and removes 1466 bytes of kernel
> > text.
> >
> > Previously, to determine if any pte was shared, the page mapcount
> > corresponding exactly to the pte was checked. This gave us a precise
> > number of shared ptes. Using folio_estimated_sharers() instead uses
> > the mapcount of the head page, giving us an estimate for tail page ptes=
.
> >
> > This means if a tail page's mapcount is greater than its head page's
> > mapcount, folio_estimated_sharers() would be underestimating the number=
 of
> > shared ptes, and vice versa.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/khugepaged.c | 26 ++++++++++++--------------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 7a552fe16c92..67aac53b31c8 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1245,7 +1245,7 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
> >         pte_t *pte, *_pte;
> >         int result =3D SCAN_FAIL, referenced =3D 0;
> >         int none_or_zero =3D 0, shared =3D 0;
> > -       struct page *page =3D NULL;
> > +       struct folio *folio =3D NULL;
> >         unsigned long _address;
> >         spinlock_t *ptl;
> >         int node =3D NUMA_NO_NODE, unmapped =3D 0;
> > @@ -1316,13 +1316,13 @@ static int hpage_collapse_scan_pmd(struct mm_st=
ruct *mm,
> >                 if (pte_write(pteval))
> >                         writable =3D true;
> >
> > -               page =3D vm_normal_page(vma, _address, pteval);
> > -               if (unlikely(!page) || unlikely(is_zone_device_page(pag=
e))) {
> > +               folio =3D vm_normal_folio(vma, _address, pteval);
> > +               if (unlikely(!folio) || unlikely(folio_is_zone_device(f=
olio))) {
> >                         result =3D SCAN_PAGE_NULL;
> >                         goto out_unmap;
> >                 }
> >
> > -               if (page_mapcount(page) > 1) {
> > +               if (folio_estimated_sharers(folio) > 1) {
>
> This doesn't look correct. The max_ptes_shared is used to control the
> cap of shared PTEs. IIRC, folio_estimated_sharers() just reads the
> mapcount of the head page. If we set max_ptes_shared to 256, and just
> the head page is shared, but "shared" will return 512 and prevent from
> collapsing the area even though just one PTE is shared. This breaks
> the semantics of max_ptes_shared.

In my testing this replacement appears to do the opposite (underestimating
instead of overestimating), which admittedly still breaks the semantics of
max_ptes_shared. It appears that this happens quite frequently in many
regular use cases, so I'll go back to checking each individual subpage's
mapcount in v2.

> >                         ++shared;
> >                         if (cc->is_khugepaged &&
> >                             shared > khugepaged_max_ptes_shared) {
> > @@ -1332,29 +1332,27 @@ static int hpage_collapse_scan_pmd(struct mm_st=
ruct *mm,
> >                         }
> >                 }
> >
> > -               page =3D compound_head(page);
> > -
> >                 /*
> >                  * Record which node the original page is from and save=
 this
> >                  * information to cc->node_load[].
> >                  * Khugepaged will allocate hugepage from the node has =
the max
> >                  * hit record.
> >                  */
> > -               node =3D page_to_nid(page);
> > +               node =3D folio_nid(folio);
> >                 if (hpage_collapse_scan_abort(node, cc)) {
> >                         result =3D SCAN_SCAN_ABORT;
> >                         goto out_unmap;
> >                 }
> >                 cc->node_load[node]++;
> > -               if (!PageLRU(page)) {
> > +               if (!folio_test_lru(folio)) {
> >                         result =3D SCAN_PAGE_LRU;
> >                         goto out_unmap;
> >                 }
> > -               if (PageLocked(page)) {
> > +               if (folio_test_locked(folio)) {
> >                         result =3D SCAN_PAGE_LOCK;
> >                         goto out_unmap;
> >                 }
> > -               if (!PageAnon(page)) {
> > +               if (!folio_test_anon(folio)) {
> >                         result =3D SCAN_PAGE_ANON;
> >                         goto out_unmap;
> >                 }
> > @@ -1369,7 +1367,7 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
> >                  * has excessive GUP pins (i.e. 512).  Anyway the same =
check
> >                  * will be done again later the risk seems low.
> >                  */
> > -               if (!is_refcount_suitable(page)) {
> > +               if (!is_refcount_suitable(&folio->page)) {
> >                         result =3D SCAN_PAGE_COUNT;
> >                         goto out_unmap;
> >                 }
> > @@ -1379,8 +1377,8 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
> >                  * enough young pte to justify collapsing the page
> >                  */
> >                 if (cc->is_khugepaged &&
> > -                   (pte_young(pteval) || page_is_young(page) ||
> > -                    PageReferenced(page) || mmu_notifier_test_young(vm=
a->vm_mm,
> > +                   (pte_young(pteval) || folio_test_young(folio) ||
> > +                    folio_test_referenced(folio) || mmu_notifier_test_=
young(vma->vm_mm,
> >                                                                      ad=
dress)))
> >                         referenced++;
> >         }
> > @@ -1402,7 +1400,7 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
> >                 *mmap_locked =3D false;
> >         }
> >  out:
> > -       trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,
> > +       trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, refere=
nced,
> >                                      none_or_zero, result, unmapped);
> >         return result;
> >  }
> > --
> > 2.40.1
> >
