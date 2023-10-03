Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24B7B6F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbjJCQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbjJCQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:58:07 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDEAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:58:04 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f7f2b1036so13960407b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696352283; x=1696957083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZvT8ncjg0ZRyDoQnM/j59uk5ZJ4wEfWtKw7l31+bQY=;
        b=4cebTZS8HjfDdLXhnQ+qTVnMJkckvdnjGOpBQv5HUoqNIkGRMAbW8tpeICgq1B1Ul/
         QyUntTKtiYMX/9/naV3cZNEkQBAHbdtG2nsWCeGq3Ho1jUashhwUiM4/HG5kDPnNRpwF
         Kvt17xycz6L/IMmQ8fdvj+6XpoiAnyzl+Oy1qM3LJxpGzXWyCAiuPXBmY1Mn12KUNdVR
         /yBer6b7+vhuhcneY0ycyhr8x44Hk3AGoLAdIWhQCwdkZrf98P8c+hHCt/QZQNiAf8re
         b1d4fuTIufDpADlbV8T1HkWAAaHhriGLV8Vq/fPjPp+7oNwxDlw3VJOvAYqFlqg/ilc+
         0jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352283; x=1696957083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZvT8ncjg0ZRyDoQnM/j59uk5ZJ4wEfWtKw7l31+bQY=;
        b=ZIy5MMhuoAMuORsAGDHSsR3PLjTu7llOGCZ+tVh1nge7g6NMMxBmHvTOTT9E9AX2Cq
         2AnZQc2shLEx+FozjOqsBAMkTcg0uO1Z/XSlK8wjhZGb1GC7i7hRHpfSSAoTAn5HKaLN
         cIEIaqc98ShQIwC9SGlE6Ohf44xvCnCDlLrEdqm0Je1PjhOuFvovFD69LF06eavPtpPh
         9/TVuuVM+gBsYBPXT8MD7Nyzz7v/QU/T9cda3cUcFF6xCQHFSm/QpBYodFiL/X457Ezc
         edqtxGs2Jjitj+vuWUkYk/3DOz5WW3YJtbseFhTuITeVTnT/LWTC+wwR8dBjhMzyQBBN
         8tnQ==
X-Gm-Message-State: AOJu0Yzx6Qi1yVM8WEROrapAyBFNaw+JKHsJJ5r76BbYK9+mGDumQiqH
        3vPSv2IVh77burH1AW41thHPOhVeu7h4D4GRCiFykAwRJvJHC9A5oTZ0YQ==
X-Google-Smtp-Source: AGHT+IHlpMyozoEdc5iDClc28l5sTlqhMCX7P6ooVhNJ5m2DvOLWzBtI6WW9y0ov4pbtTIBiUIT6U6R5wVCkH6wsrfQ=
X-Received: by 2002:a0d:d54f:0:b0:5a1:f0f8:4280 with SMTP id
 x76-20020a0dd54f000000b005a1f0f84280mr218666ywd.22.1696352283288; Tue, 03 Oct
 2023 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231002142949.235104-1-david@redhat.com> <20231002142949.235104-3-david@redhat.com>
In-Reply-To: <20231002142949.235104-3-david@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 09:57:50 -0700
Message-ID: <CAJuCfpFZ_GRkCJRs2C7sa1k-L-vj7J4EaAtsyM4ECaG3=A+xEA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/rmap: convert page_move_anon_rmap() to folio_move_anon_rmap()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 7:29=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's convert it to consume a folio.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  include/linux/rmap.h |  2 +-
>  mm/huge_memory.c     |  2 +-
>  mm/hugetlb.c         |  2 +-
>  mm/memory.c          |  2 +-
>  mm/rmap.c            | 16 +++++++---------
>  5 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 064b432a4033..8034eda972e5 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -194,7 +194,7 @@ typedef int __bitwise rmap_t;
>  /*
>   * rmap interfaces called when adding or removing pte of page
>   */
> -void page_move_anon_rmap(struct page *, struct vm_area_struct *);
> +void folio_move_anon_rmap(struct folio *, struct vm_area_struct *);
>  void page_add_anon_rmap(struct page *, struct vm_area_struct *,
>                 unsigned long address, rmap_t flags);
>  void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 01d0d65ece13..08245226ccb8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1505,7 +1505,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf=
)
>         if (folio_ref_count(folio) =3D=3D 1) {
>                 pmd_t entry;
>
> -               page_move_anon_rmap(page, vma);
> +               folio_move_anon_rmap(folio, vma);
>                 SetPageAnonExclusive(page);
>                 folio_unlock(folio);
>  reuse:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 24591fc145ff..e52c6048e74f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5461,7 +5461,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, =
struct vm_area_struct *vma,
>          */
>         if (folio_mapcount(old_folio) =3D=3D 1 && folio_test_anon(old_fol=
io)) {
>                 if (!PageAnonExclusive(&old_folio->page)) {
> -                       page_move_anon_rmap(&old_folio->page, vma);
> +                       folio_move_anon_rmap(old_folio, vma);
>                         SetPageAnonExclusive(&old_folio->page);
>                 }
>                 if (likely(!unshare))
> diff --git a/mm/memory.c b/mm/memory.c
> index 9de231c92769..1f0e3317cbdd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3483,7 +3483,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>                  * and the folio is locked, it's dark out, and we're wear=
ing
>                  * sunglasses. Hit it.
>                  */
> -               page_move_anon_rmap(vmf->page, vma);
> +               folio_move_anon_rmap(folio, vma);
>                 SetPageAnonExclusive(vmf->page);
>                 folio_unlock(folio);
>  reuse:
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 854ccbd66954..37f05f33559b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1141,19 +1141,17 @@ int folio_total_mapcount(struct folio *folio)
>  }
>
>  /**
> - * page_move_anon_rmap - move a page to our anon_vma
> - * @page:      the page to move to our anon_vma
> - * @vma:       the vma the page belongs to
> + * folio_move_anon_rmap - move a folio to our anon_vma
> + * @page:      The folio to move to our anon_vma
> + * @vma:       The vma the folio belongs to
>   *
> - * When a page belongs exclusively to one process after a COW event,
> - * that page can be moved into the anon_vma that belongs to just that
> - * process, so the rmap code will not search the parent or sibling
> - * processes.
> + * When a folio belongs exclusively to one process after a COW event,
> + * that folio can be moved into the anon_vma that belongs to just that
> + * process, so the rmap code will not search the parent or sibling proce=
sses.
>   */
> -void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
> +void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vm=
a)
>  {
>         void *anon_vma =3D vma->anon_vma;
> -       struct folio *folio =3D page_folio(page);
>
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>         VM_BUG_ON_VMA(!anon_vma, vma);
> --
> 2.41.0
>
