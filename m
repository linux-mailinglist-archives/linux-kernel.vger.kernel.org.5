Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE27CCE56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbjJQUmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:41:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085BC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:41:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso2966660a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697575318; x=1698180118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJopoaNgvivmBcLFBdfIDmzr0qztUwvLw+YT1b0SCdk=;
        b=lzTCnrIVqnUPlKzDsIYut08kaYCo6zoX+vO+YTCB/g4qLPPcythr4JUfkgtztmB2r5
         1aKj44z2iWf7lxby+hDPqBPl74zJaAhRmpFue+OxXqDoYnmCePTxEwRyeR07h3q5HMzM
         smHxxfjGMaQiV6YW2HPVlLF92Vmp48FNf6pCcZVYPYtwNQmAfrDx7f3PtY9ld/fbOgxm
         G5/LR3QYE/OeEF6NbOyI7kUDlIw4H3p+0bZWtQWqlRl6CsFz+0LJ2qlmdQ+M3JZMgZ1h
         /K4QQkGdqk6zvL9X1v9zeej9MENgzUCp4LWH6lqL6tnUhzZwv6nHE8L0pTl7XGjDjcUS
         J3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575318; x=1698180118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJopoaNgvivmBcLFBdfIDmzr0qztUwvLw+YT1b0SCdk=;
        b=lOFmGOC7TJsZSgFFvnUTLio3yLIiqq4jzDEKhX8niFFrixGjdl2r5SPV5EpAdJxnVJ
         Kry6WCqcaXAqLv/QDhSY0IA4sX0AhmVtgIlepnTp2mYXikFwOTlMBSTww8g7EQkwNOQ4
         g7nY7FOLlhT2iNiRoWgtyjeMzBBLkOlE5zVyJFi8TxxaR5J/GyN5+AfMcYA/iA95Ooy/
         uQ978umBE1afSZiIK/LXk2Bp59Jw6yc+GGNyAg2xTeuYFPw83p2SYJKrjH/7uarxsQ+C
         /BVfT9yzinqOAm5yUAQxWf70WqE9fzTSC5ioaA3uA93SWBykmKeA8wMdR6le2gHIfZIg
         CXjg==
X-Gm-Message-State: AOJu0YwO/O257LHeI7C1ZiMaMkhaUnlVm/U2sUl6b+7y7bXvQx/HJOcV
        wkqC6MMnS7a5gImQfgefavxnvF16cX9K+7ue7ng13y8y
X-Google-Smtp-Source: AGHT+IFD9sjsz/nxhufOudoMvKUywMmy9QHuwrScNCcoGHBewdqoVyQa/kTgSXcBWHcsJBHcwGAPuhHXu7vEDBwPPOA=
X-Received: by 2002:a17:90a:656:b0:27d:a5f6:21da with SMTP id
 q22-20020a17090a065600b0027da5f621damr3065351pje.16.1697575317589; Tue, 17
 Oct 2023 13:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231016200510.7387-1-vishal.moola@gmail.com> <20231016200510.7387-3-vishal.moola@gmail.com>
In-Reply-To: <20231016200510.7387-3-vishal.moola@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 17 Oct 2023 13:41:46 -0700
Message-ID: <CAHbLzkrTmt=5ECLG0ZQs=14BxHhKZtDY1DfG3mSau7LU-0PeKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/khugepaged: Convert hpage_collapse_scan_pmd() to
 use folios
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
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

On Mon, Oct 16, 2023 at 1:06=E2=80=AFPM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Replaces 5 calls to compound_head(), and removes 1466 bytes of kernel
> text.
>
> Previously, to determine if any pte was shared, the page mapcount
> corresponding exactly to the pte was checked. This gave us a precise
> number of shared ptes. Using folio_estimated_sharers() instead uses
> the mapcount of the head page, giving us an estimate for tail page ptes.
>
> This means if a tail page's mapcount is greater than its head page's
> mapcount, folio_estimated_sharers() would be underestimating the number o=
f
> shared ptes, and vice versa.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/khugepaged.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7a552fe16c92..67aac53b31c8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1245,7 +1245,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>         pte_t *pte, *_pte;
>         int result =3D SCAN_FAIL, referenced =3D 0;
>         int none_or_zero =3D 0, shared =3D 0;
> -       struct page *page =3D NULL;
> +       struct folio *folio =3D NULL;
>         unsigned long _address;
>         spinlock_t *ptl;
>         int node =3D NUMA_NO_NODE, unmapped =3D 0;
> @@ -1316,13 +1316,13 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
>                 if (pte_write(pteval))
>                         writable =3D true;
>
> -               page =3D vm_normal_page(vma, _address, pteval);
> -               if (unlikely(!page) || unlikely(is_zone_device_page(page)=
)) {
> +               folio =3D vm_normal_folio(vma, _address, pteval);
> +               if (unlikely(!folio) || unlikely(folio_is_zone_device(fol=
io))) {
>                         result =3D SCAN_PAGE_NULL;
>                         goto out_unmap;
>                 }
>
> -               if (page_mapcount(page) > 1) {
> +               if (folio_estimated_sharers(folio) > 1) {

This doesn't look correct. The max_ptes_shared is used to control the
cap of shared PTEs. IIRC, folio_estimated_sharers() just reads the
mapcount of the head page. If we set max_ptes_shared to 256, and just
the head page is shared, but "shared" will return 512 and prevent from
collapsing the area even though just one PTE is shared. This breaks
the semantics of max_ptes_shared.

>                         ++shared;
>                         if (cc->is_khugepaged &&
>                             shared > khugepaged_max_ptes_shared) {
> @@ -1332,29 +1332,27 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
>                         }
>                 }
>
> -               page =3D compound_head(page);
> -
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
> @@ -1369,7 +1367,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
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
> @@ -1379,8 +1377,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
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
> @@ -1402,7 +1400,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
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
