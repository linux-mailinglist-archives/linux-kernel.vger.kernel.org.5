Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019467D59D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjJXRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:39:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D183
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:39:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d129e2e7cso3577266a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169162; x=1698773962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh/V28St3W/9eHmyATqjDrrxXI3buY6hWbnciYhV7KA=;
        b=mNM2qvkAcZA1WOac2QquKsv6hhjDdGIrU9KWi54Flq1ex0Sd6uy99zdE47iD8QIisu
         OS+UWFfn7zFsKX6ydSDUFPEjKJPepfFwWXrFP9XkCQ/CnugI4oH5FDhzpjnfHg7g23WH
         gGCYW7B35BiVeu8Us0ZsI5jqUA9gnVMjOMlVxhdTsVYDYMNgAX2XKz+e6LGB6U+e7YLG
         jzdsO1Ge8MVRDP9rsF0QB6X9CInFZWaNglDBg/0ZRu1ax68WGnyQ4plgqnG+kEPd74ow
         b+h3HqP8DUMJ0fpPXOkz/1pYrH6XMDLqvES09XZ4wO/BZUP6KuBO/n2k8/V51otAseZy
         2YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169162; x=1698773962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh/V28St3W/9eHmyATqjDrrxXI3buY6hWbnciYhV7KA=;
        b=Lixs28tUQdta1zU+97SDRlR7JZqUEGs0HcFtJ5p1fBqL58SkdUXxZ0vPyek5O1YW0o
         Y1ShDTxtRQMn1VOn0Y1ui5I4t8FmuuSa7nPnH6vSJKZG0VcyEX5/7lrcUQ+40VDmfgBF
         +3wDeoa2QxWptCmBG0dN4lgeZy6KQ5audrb5+mKJGQOTWqsPt1O7XQr/8hG/fRk6T+Ai
         Blj3MqkE5z5eaEsePtMcKsHs2r/YiEIBnM+Eh8X599bqAxQMf9GQI88lL9kOkCSmwlyF
         89oMWMVPVapisWLOHWcfPTkwvqTBgBHpNxCUyY9TX5W4ix5UeVRZhXlpZPnxnnvVvwnU
         6xDA==
X-Gm-Message-State: AOJu0Yyev5xBIKiPl7syap4IRutix31sE0mpGtZKENpXnQoebMDgW0ng
        KmuPCQGpUp3J4KsPAWLjRqnblXwdUvXsNi4LcrE=
X-Google-Smtp-Source: AGHT+IFpDGG6W98PYI7K3wmeTQtI42cl6sPEOd0zYu5D1LCkIlODoz0rvnjvooP5XkNLrFJ42pqCR8qPUqYK/748IwU=
X-Received: by 2002:a17:90b:f85:b0:27d:75f2:a3ee with SMTP id
 ft5-20020a17090b0f8500b0027d75f2a3eemr10898508pjb.10.1698169161902; Tue, 24
 Oct 2023 10:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231020183331.10770-1-vishal.moola@gmail.com> <20231020183331.10770-4-vishal.moola@gmail.com>
In-Reply-To: <20231020183331.10770-4-vishal.moola@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Oct 2023 10:39:10 -0700
Message-ID: <CAHbLzkq1Q5ysu2yxxVNh92T-fFLo+pP93jfRqLOMdp4M9tBXuw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/khugepaged: Convert is_refcount_suitable() to
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

On Fri, Oct 20, 2023 at 11:34=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Both callers of is_refcount_suitable() have been converted to use
> folios, so convert it to take in a folio. Both callers only operate on
> head pages of folios so mapcount/refcount conversions here are trivial.
>
> Removes 3 calls to compound head, and removes 315 bytes of kernel text.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c4b5af43371..9efd8ff68f06 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -524,15 +524,15 @@ static void release_pte_pages(pte_t *pte, pte_t *_p=
te,
>         }
>  }
>
> -static bool is_refcount_suitable(struct page *page)
> +static bool is_refcount_suitable(struct folio *folio)
>  {
>         int expected_refcount;
>
> -       expected_refcount =3D total_mapcount(page);
> -       if (PageSwapCache(page))
> -               expected_refcount +=3D compound_nr(page);
> +       expected_refcount =3D folio_mapcount(folio);
> +       if (folio_test_swapcache(folio))
> +               expected_refcount +=3D folio_nr_pages(folio);
>
> -       return page_count(page) =3D=3D expected_refcount;
> +       return folio_ref_count(folio) =3D=3D expected_refcount;
>  }
>
>  static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> @@ -625,7 +625,7 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                  * but not from this process. The other process cannot wr=
ite to
>                  * the page, only trigger CoW.
>                  */
> -               if (!is_refcount_suitable(&folio->page)) {
> +               if (!is_refcount_suitable(folio)) {
>                         folio_unlock(folio);
>                         result =3D SCAN_PAGE_COUNT;
>                         goto out;
> @@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                  * has excessive GUP pins (i.e. 512).  Anyway the same ch=
eck
>                  * will be done again later the risk seems low.
>                  */
> -               if (!is_refcount_suitable(&folio->page)) {
> +               if (!is_refcount_suitable(folio)) {
>                         result =3D SCAN_PAGE_COUNT;
>                         goto out_unmap;
>                 }
> --
> 2.40.1
>
>
