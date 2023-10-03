Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC497B6F19
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbjJCQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbjJCQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:56:26 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4C10F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:56:08 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f6041395dso14206817b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696352168; x=1696956968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVY4O3aDRJ+9l9d853reVluvwxUpObOaI+Y9TV87Rh4=;
        b=QOz1c4yV+oQLzs1XEDJ4FPpUnEE/gncKz+xmGmFTRYukdiL3Efs/22pcPGcvBKHapH
         f72IH1Hq1pAU677rKom1tNOvAwbf+qcx+c0iTVoz5s4MP1+k9ctN/OFPbV6z5QHrVG6R
         0wkiVPGUhFmHnHJxyn0732IxWVUoV1/tzxhfnvu+q/R1pjdQBWbdtPSTkzBMTvbx93Z5
         a0ArtPpZUuXJedxsEwypkUMSvF78dOKrI6in3++i/8ofQBzlvv9g5tNQWbP1H9buEK2B
         qM+AFz+c1levdvSccamPKCT7SH74y50pPJV7f4yEenAE5kgyXOMa3oU+taSfvpsRCPi6
         dMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352168; x=1696956968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVY4O3aDRJ+9l9d853reVluvwxUpObOaI+Y9TV87Rh4=;
        b=IBmCEymQVWdXtu4fPDpi1jO/wrT2KEMFW0dOqdJINfrOmtGg7he48F2Yy7RXThIdMD
         LyLGoWZUvUSo/oG2XVb9VVju2i4QgnpsnAf4uUz/rDx4sFGMWGNcmW3gql5riURWQo8v
         TY75+/kKpqicqHQpyxRQ20F/slO3XPu93qwTpjQxFhJh/rC5k1Yaw/QDCvjcoPCcQbXv
         mRkCCVIbrOaWrNlOVNNNNaJM/CwKIUAiGhkJzdNjQMZQJPgDnRupwKFrkpldVj7Fr1/F
         SjMhOSA3qS+fQh39+sQ4UUiRTuZQrg1tuQYTg6Fur8AtByZ62lqR/s/XA49xMj6jTFPl
         5/Kg==
X-Gm-Message-State: AOJu0YybK6yNoDr5khEO0QajsCAasnsIpCtIAKlhXpHVfQhCllFndRaH
        1I0/CS2MlsJLQ6GZ3bQ3rdIoqQREyOphXVr8NRortz3aQQOkK4oiaY0=
X-Google-Smtp-Source: AGHT+IHW2FWWosxQsv+RqGCrW8QqqapSDoaKCao+4kM7T48rQ7jHI9TcooWQJg7IqM3DmO1+wyTvuo56N+GkvbC6Qrs=
X-Received: by 2002:a81:690b:0:b0:592:227f:7964 with SMTP id
 e11-20020a81690b000000b00592227f7964mr130880ywc.47.1696352167618; Tue, 03 Oct
 2023 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231002142949.235104-1-david@redhat.com> <20231002142949.235104-2-david@redhat.com>
In-Reply-To: <20231002142949.235104-2-david@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 09:55:55 -0700
Message-ID: <CAJuCfpEkBYWu4R=fcy9P_b4aMokQHvXA3T1DpDc0hRD0OGJ=Yw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/rmap: move SetPageAnonExclusive() out of page_move_anon_rmap()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> Let's move it into the caller: there is a difference between whether an
> anon folio can only be mapped by one process (e.g., into one VMA), and
> whether it is truly exclusive (e.g., no references -- including GUP --
> from other processes).
>
> Further, for large folios the page might not actually be pointing at the
> head page of the folio, so it better be handled in the caller. This is a
> preparation for converting page_move_anon_rmap() to consume a folio.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/huge_memory.c | 1 +
>  mm/hugetlb.c     | 4 +++-
>  mm/memory.c      | 1 +
>  mm/rmap.c        | 1 -
>  4 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e54fb9c542bb..01d0d65ece13 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1506,6 +1506,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf=
)
>                 pmd_t entry;
>
>                 page_move_anon_rmap(page, vma);
> +               SetPageAnonExclusive(page);
>                 folio_unlock(folio);
>  reuse:
>                 if (unlikely(unshare)) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9c22297d9c57..24591fc145ff 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5460,8 +5460,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm,=
 struct vm_area_struct *vma,
>          * owner and can reuse this page.
>          */
>         if (folio_mapcount(old_folio) =3D=3D 1 && folio_test_anon(old_fol=
io)) {
> -               if (!PageAnonExclusive(&old_folio->page))
> +               if (!PageAnonExclusive(&old_folio->page)) {
>                         page_move_anon_rmap(&old_folio->page, vma);
> +                       SetPageAnonExclusive(&old_folio->page);
> +               }
>                 if (likely(!unshare))
>                         set_huge_ptep_writable(vma, haddr, ptep);
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d4820802b01b..9de231c92769 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3484,6 +3484,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>                  * sunglasses. Hit it.
>                  */
>                 page_move_anon_rmap(vmf->page, vma);
> +               SetPageAnonExclusive(vmf->page);
>                 folio_unlock(folio);
>  reuse:
>                 if (unlikely(unshare)) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 77222adccda1..854ccbd66954 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1165,7 +1165,6 @@ void page_move_anon_rmap(struct page *page, struct =
vm_area_struct *vma)
>          * folio_test_anon()) will not see one without the other.
>          */
>         WRITE_ONCE(folio->mapping, anon_vma);
> -       SetPageAnonExclusive(page);
>  }
>
>  /**
> --
> 2.41.0
>
