Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820807D59D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbjJXRkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbjJXRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:40:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0410C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:40:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so4146197a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169228; x=1698774028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xWGwGBYtGQcESxLDi2O/elWlIJtx15pyBUk6hkFzL4=;
        b=BiElUKCdBmrM8nnWCzDSgZcRCi/swkiw43C4ZIGPFYmwM2SASkIoVtTbtWaMz9Ukbe
         bscxYi6ZQ+i1EKFsQDGczk5tJ7cMYz6Uqx+J83Q42ZFYZATAsbLwV1fuMSuto+mBakF2
         Np5cgKfr5K5AZoGrJHhXC1Wtm4HU2hdT6dC7YCW7qpm9gJVFWornt5tetmFHfxS4+PiG
         NYTm6z0klfse4aSk8iq4ijnLwMI8oUEAzNGQeQCyVtHvNi+7cC0cTixsn696VqRZZ/Ys
         oMAVBELz3gbUlI41+xFkxZLjNepiyo/WFfthb1jEgjm9hGb+xkUpv9kykkES/I0bneJy
         T/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169228; x=1698774028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xWGwGBYtGQcESxLDi2O/elWlIJtx15pyBUk6hkFzL4=;
        b=T6Y9xIrSbIxka08qhd3BPYdXkCE/Kx0RPRqgpskx1XRPsFoJ5vj6gu9X8ahsxMYmWf
         cqzuCnP5qzN+3yD0lZmYeTYv0xFTHWTi7yzprlJL+EMBd52vgSVgT+TbvtEKg2zfZoFD
         wrK5Wvp6s6GTTcUC5I/E+Ljj7cX4tgdnFiiZM1IFcuZDk+up3LSH6pdo77+LPmxTvLkN
         Jbntx0Jkzp3Dai980xk6A2JEcivrmjCVXPqGmsZ0VOqKRfBK04O+HI/rijl9EXg4sBo8
         KscnnAJSINhkXuJyXf8bNkDncBwDUHDoIDTdDNJlE5q9Yxxu8R0iJOX/fiHv+dv53atx
         Jm/Q==
X-Gm-Message-State: AOJu0YyXdGq8ZgqGTfq7ogkjvJV+BryTylnGRByx9ovsWsckVfwq7nHf
        wh87FZT5yndF2PiyFYxgB/aS3lWaws6pzfK0sg4=
X-Google-Smtp-Source: AGHT+IHIes8+KZbr5QFSv8mkeyL/tKYrsJTKUM8ciSJZzTy3Cni0SQN69j/7pYt+DueUNi+xQbN8hBmQTffZGeAIEdw=
X-Received: by 2002:a17:90a:ac02:b0:27d:b3d:5c33 with SMTP id
 o2-20020a17090aac0200b0027d0b3d5c33mr12739037pjq.28.1698169228336; Tue, 24
 Oct 2023 10:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231020183331.10770-1-vishal.moola@gmail.com> <20231020183331.10770-6-vishal.moola@gmail.com>
In-Reply-To: <20231020183331.10770-6-vishal.moola@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Oct 2023 10:40:16 -0700
Message-ID: <CAHbLzkpzxs_6t4opKJJ6mGZnHqeJqA3zt74T39y-eyVt57WNhg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp()
 to use folios
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

On Fri, Oct 20, 2023 at 11:34=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> This removes 2 calls to compound_head() and helps convert khugepaged to
> use folios throughout.
>
> Previously, if the address passed to collapse_pte_mapped_thp()
> corresponded to a tail page, the scan would fail immediately. Using
> filemap_lock_folio() we get the corresponding folio back and try to
> operate on the folio instead.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 45 ++++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6a7184cd291b..bc2d8ff269c7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1477,7 +1477,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>         bool notified =3D false;
>         unsigned long haddr =3D addr & HPAGE_PMD_MASK;
>         struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
> -       struct page *hpage;
> +       struct folio *folio;
>         pte_t *start_pte, *pte;
>         pmd_t *pmd, pgt_pmd;
>         spinlock_t *pml =3D NULL, *ptl;
> @@ -1510,19 +1510,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,=
 unsigned long addr,
>         if (userfaultfd_wp(vma))
>                 return SCAN_PTE_UFFD_WP;
>
> -       hpage =3D find_lock_page(vma->vm_file->f_mapping,
> +       folio =3D filemap_lock_folio(vma->vm_file->f_mapping,
>                                linear_page_index(vma, haddr));
> -       if (!hpage)
> +       if (IS_ERR(folio))
>                 return SCAN_PAGE_NULL;
>
> -       if (!PageHead(hpage)) {
> -               result =3D SCAN_FAIL;
> -               goto drop_hpage;
> -       }
> -
> -       if (compound_order(hpage) !=3D HPAGE_PMD_ORDER) {
> +       if (folio_order(folio) !=3D HPAGE_PMD_ORDER) {
>                 result =3D SCAN_PAGE_COMPOUND;
> -               goto drop_hpage;
> +               goto drop_folio;
>         }
>
>         result =3D find_pmd_or_thp_or_none(mm, haddr, &pmd);
> @@ -1536,13 +1531,13 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,=
 unsigned long addr,
>                  */
>                 goto maybe_install_pmd;
>         default:
> -               goto drop_hpage;
> +               goto drop_folio;
>         }
>
>         result =3D SCAN_FAIL;
>         start_pte =3D pte_offset_map_lock(mm, pmd, haddr, &ptl);
>         if (!start_pte)         /* mmap_lock + page lock should prevent t=
his */
> -               goto drop_hpage;
> +               goto drop_folio;
>
>         /* step 1: check all mapped PTEs are to the right huge page */
>         for (i =3D 0, addr =3D haddr, pte =3D start_pte;
> @@ -1567,7 +1562,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>                  * Note that uprobe, debugger, or MAP_PRIVATE may change =
the
>                  * page table, but the new page will not be a subpage of =
hpage.
>                  */
> -               if (hpage + i !=3D page)
> +               if (folio_page(folio, i) !=3D page)
>                         goto abort;
>         }
>
> @@ -1582,7 +1577,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>          * page_table_lock) ptl nests inside pml. The less time we hold p=
ml,
>          * the better; but userfaultfd's mfill_atomic_pte() on a private =
VMA
>          * inserts a valid as-if-COWed PTE without even looking up page c=
ache.
> -        * So page lock of hpage does not protect from it, so we must not=
 drop
> +        * So page lock of folio does not protect from it, so we must not=
 drop
>          * ptl before pgt_pmd is removed, so uffd private needs pml taken=
 now.
>          */
>         if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
> @@ -1606,7 +1601,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>                         continue;
>                 /*
>                  * We dropped ptl after the first scan, to do the mmu_not=
ifier:
> -                * page lock stops more PTEs of the hpage being faulted i=
n, but
> +                * page lock stops more PTEs of the folio being faulted i=
n, but
>                  * does not stop write faults COWing anon copies from exi=
sting
>                  * PTEs; and does not stop those being swapped out or mig=
rated.
>                  */
> @@ -1615,7 +1610,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>                         goto abort;
>                 }
>                 page =3D vm_normal_page(vma, addr, ptent);
> -               if (hpage + i !=3D page)
> +               if (folio_page(folio, i) !=3D page)
>                         goto abort;
>
>                 /*
> @@ -1634,8 +1629,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>
>         /* step 3: set proper refcount and mm_counters. */
>         if (nr_ptes) {
> -               page_ref_sub(hpage, nr_ptes);
> -               add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
> +               folio_ref_sub(folio, nr_ptes);
> +               add_mm_counter(mm, mm_counter_file(&folio->page), -nr_pte=
s);
>         }
>
>         /* step 4: remove empty page table */
> @@ -1659,14 +1654,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,=
 unsigned long addr,
>  maybe_install_pmd:
>         /* step 5: install pmd entry */
>         result =3D install_pmd
> -                       ? set_huge_pmd(vma, haddr, pmd, hpage)
> +                       ? set_huge_pmd(vma, haddr, pmd, &folio->page)
>                         : SCAN_SUCCEED;
> -       goto drop_hpage;
> +       goto drop_folio;
>  abort:
>         if (nr_ptes) {
>                 flush_tlb_mm(mm);
> -               page_ref_sub(hpage, nr_ptes);
> -               add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
> +               folio_ref_sub(folio, nr_ptes);
> +               add_mm_counter(mm, mm_counter_file(&folio->page), -nr_pte=
s);
>         }
>         if (start_pte)
>                 pte_unmap_unlock(start_pte, ptl);
> @@ -1674,9 +1669,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>                 spin_unlock(pml);
>         if (notified)
>                 mmu_notifier_invalidate_range_end(&range);
> -drop_hpage:
> -       unlock_page(hpage);
> -       put_page(hpage);
> +drop_folio:
> +       folio_unlock(folio);
> +       folio_put(folio);
>         return result;
>  }
>
> --
> 2.40.1
>
