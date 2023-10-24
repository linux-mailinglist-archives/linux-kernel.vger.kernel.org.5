Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE60B7D59D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJXRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:38:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB3128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:38:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27d0251d305so3231738a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169118; x=1698773918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wecy31uUKb4FQTlJ6EJR6DDmV/g3NHpmyytA/eZTJIY=;
        b=PbJP5YxXEJ1DUnbjF4IxbdXKQzT16RM9pMWUDbBD0FJhd2fJyxthDz7xKKO4fSe2uX
         obNaSYIXii9H9voiYjAzNsPEj75mKQzOmGLB3s4zXzBtic8ukUTR3KR3+grNnJv8tGx3
         tFdOvQt5Q3tSCqAOpXNpMyRfYmyzTNCHNr1Ccku3u1Ok35njn569QAsboe0SITJTDX5S
         lSkQaK2MwDc+jeyz2dMrxKqSPFn73VF6RMdtlY4mlQPkrzaohEIrR0j5aj+3PIlc+VR2
         q3DNEr8pvcgvdXNkouC3HSwjq8RcfDzCQ9DGGGskOR4FhdPGC5kIgdNr1CEJg8k18EjG
         sjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169118; x=1698773918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wecy31uUKb4FQTlJ6EJR6DDmV/g3NHpmyytA/eZTJIY=;
        b=vZmaSEEyqOO24t35o019sqMNjmFCQ2uJR+CKs9+H+pcfSjPLk7VdGnNrWV39HXU8V1
         q+9IOb8bN4IZnVYrKSnJH2f3eWO7N4qvdx/66lp3rIAX3p76zbgE/54sHc8RIU642nHE
         mOi2utBeTjwkYHxEdBtUJG8wpLv3p9YSyZJihNsAetJlIcAW0bXHGw8+Sj4CYY0/kj0S
         F4oo5c78caf/axkI8iMK8crnvqMp08yNZV5RabV/73c5UvqkuSOK/SOUJFYz6/zrmRXB
         ad5P585BwOMC8nT4+Bew8h8efE+A4i3PxVDvDs63uWj4cvCNJq/XA3HV5r+bElBG3xl9
         IUxQ==
X-Gm-Message-State: AOJu0Yx0uh2NtS0P0jFg3XFCxFw6OUOuRDx26jN1J4fZPrRvdhEJQdti
        KDCkfVwPjv6Hh0L6QTXSNUvhAZizk4fknoB9m3Q=
X-Google-Smtp-Source: AGHT+IGGdM/+dCmeaXqAKIbLKCKKRSfWWUpHEuiZH0DGeNQNBFOiO2N6OBNIlyCjjd+uYsld5tQR3FLOFdHonTUKWss=
X-Received: by 2002:a17:90b:1189:b0:27d:10b1:5deb with SMTP id
 gk9-20020a17090b118900b0027d10b15debmr10806710pjb.31.1698169117679; Tue, 24
 Oct 2023 10:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231020183331.10770-1-vishal.moola@gmail.com> <20231020183331.10770-3-vishal.moola@gmail.com>
In-Reply-To: <20231020183331.10770-3-vishal.moola@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Oct 2023 10:38:26 -0700
Message-ID: <CAHbLzkpPM=21+7j6ADxXWcUe0Hp3n2aJP2fepE4DrFY6jr6=iA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm/khugepaged: Convert hpage_collapse_scan_pmd()
 to use folios
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:34=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Replaces 5 calls to compound_head(), and removes 1385 bytes of kernel
> text.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 500756604488..6c4b5af43371 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1248,6 +1248,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>         int result =3D SCAN_FAIL, referenced =3D 0;
>         int none_or_zero =3D 0, shared =3D 0;
>         struct page *page =3D NULL;
> +       struct folio *folio =3D NULL;
>         unsigned long _address;
>         spinlock_t *ptl;
>         int node =3D NUMA_NO_NODE, unmapped =3D 0;
> @@ -1334,29 +1335,28 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
>                         }
>                 }
>
> -               page =3D compound_head(page);
> -
> +               folio =3D page_folio(page);
>                 /*
>                  * Record which node the original page is from and save t=
his
>                  * information to cc->node_load[].
>                  * Khugepaged will allocate hugepage from the node has th=
e max
>                  * hit record.
>                  */
> -               node =3D page_to_nid(page);
> +               node =3D folio_nid(folio);
>                 if (hpage_collapse_scan_abort(node, cc)) {
>                         result =3D SCAN_SCAN_ABORT;
>                         goto out_unmap;
>                 }
>                 cc->node_load[node]++;
> -               if (!PageLRU(page)) {
> +               if (!folio_test_lru(folio)) {
>                         result =3D SCAN_PAGE_LRU;
>                         goto out_unmap;
>                 }
> -               if (PageLocked(page)) {
> +               if (folio_test_locked(folio)) {
>                         result =3D SCAN_PAGE_LOCK;
>                         goto out_unmap;
>                 }
> -               if (!PageAnon(page)) {
> +               if (!folio_test_anon(folio)) {
>                         result =3D SCAN_PAGE_ANON;
>                         goto out_unmap;
>                 }
> @@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                  * has excessive GUP pins (i.e. 512).  Anyway the same ch=
eck
>                  * will be done again later the risk seems low.
>                  */
> -               if (!is_refcount_suitable(page)) {
> +               if (!is_refcount_suitable(&folio->page)) {
>                         result =3D SCAN_PAGE_COUNT;
>                         goto out_unmap;
>                 }
> @@ -1381,8 +1381,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                  * enough young pte to justify collapsing the page
>                  */
>                 if (cc->is_khugepaged &&
> -                   (pte_young(pteval) || page_is_young(page) ||
> -                    PageReferenced(page) || mmu_notifier_test_young(vma-=
>vm_mm,
> +                   (pte_young(pteval) || folio_test_young(folio) ||
> +                    folio_test_referenced(folio) || mmu_notifier_test_yo=
ung(vma->vm_mm,
>                                                                      addr=
ess)))
>                         referenced++;
>         }
> @@ -1404,7 +1404,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                 *mmap_locked =3D false;
>         }
>  out:
> -       trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,
> +       trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenc=
ed,
>                                      none_or_zero, result, unmapped);
>         return result;
>  }
> --
> 2.40.1
>
