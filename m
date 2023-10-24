Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE637D59D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJXRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:40:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B605A1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:40:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27dc1e4d8b6so4082374a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169200; x=1698774000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jqecopWEo5Tu0tYTbEKGg8fX65wX9DmJTQg6zHcs64=;
        b=FlD4tfHaw5+yN4q116nrN4uczNqU8QPe3WA6vrYCX3G3kj0RwEEJxNoZb7wyb+ckQ5
         M1NFBgOQkNbHt4TxOrTgHMy6RDDCZXuGYPdOiSMLUW9aOxS3JVOCsz6Zuv33kRoIX/7U
         cmAaGOJkPvzLGEGkGQoqvb7OIFpSyBs50Z0vpam3/3kKg+/t9YZeWKduucSERiaEOUPp
         mmG9wLIMowQOCC8uTijKC05SD6BvQrYjBJ30rzQpVvRDXBBZom9By+ngOILNvVtR6gD9
         iHE/MZjVemLiMsZihddKyEXG7ysfeGOI7J9OMkbihD3q7118G59+OXZzkJKaB/tissP2
         A4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169200; x=1698774000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jqecopWEo5Tu0tYTbEKGg8fX65wX9DmJTQg6zHcs64=;
        b=v3B6NG5SH+ZxzSrBlDqiYK3HR2Ik1nOss/9nT+LvR2AkTFlPKgrNHQ5vdW/Gk9wpz0
         SA0DQynTSzhz/akAcfT3AqvRiQfBIiKsUqdU1jt9gpJsNfIPWkqcT9P6B5f5GB2UhXuw
         Y70HY3F2Rjiw74vIfgNLowCOON8r5IHNPPIa01TDszhZEw8RbViHgOnczFQeO6he1a3r
         ppmbCuRGBUNPnAxQZ/2aFxyGjFURCpFLze9pxaRhJ/U23+3H8hIcElZZhGELqLzRe0nY
         8Yii+QiNTcrADq6RhEaGlD6ItnNsvQjlHV6NzXejo1+kYhbyPyr4NY2Ci4Ntd3NpvxwO
         MynQ==
X-Gm-Message-State: AOJu0YxFA7k5Y0hqVj2CohD2zchBdJ55nM+l+uTxU/UQY8rxO2AG++79
        U90jDMG8CO/WZOgB8moVZ1LQEUEzM6tWJzBFEfc=
X-Google-Smtp-Source: AGHT+IE5ZgEF8eQPaKMnM8EC8El5a/KEonFn7iMq+f2p/cMBtJfWHu4pQe4ORYUeIhxTXVkEJkBlyyNue4O/gkCFHkI=
X-Received: by 2002:a17:90a:2ec5:b0:27d:97e5:f3fa with SMTP id
 h5-20020a17090a2ec500b0027d97e5f3famr13021834pjs.29.1698169200572; Tue, 24
 Oct 2023 10:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231020183331.10770-1-vishal.moola@gmail.com> <20231020183331.10770-5-vishal.moola@gmail.com>
In-Reply-To: <20231020183331.10770-5-vishal.moola@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Oct 2023 10:39:48 -0700
Message-ID: <CAHbLzkref0EdCMSCrRnGR1b6LmBV9PrkuR1aFBT-wCgUsmXG_g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/khugepaged: Convert alloc_charge_hpage() to use folios
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
> Also remove count_memcg_page_event now that its last caller no longer use=
s
> it and reword hpage_collapse_alloc_page() to hpage_collapse_alloc_folio()=
.
>
> This removes 1 call to compound_head() and helps convert khugepaged to
> use folios throughout.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/linux/memcontrol.h | 14 --------------
>  mm/khugepaged.c            | 17 ++++++++++-------
>  2 files changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ab94ad4597d0..3126bde982e8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1080,15 +1080,6 @@ static inline void count_memcg_events(struct mem_c=
group *memcg,
>         local_irq_restore(flags);
>  }
>
> -static inline void count_memcg_page_event(struct page *page,
> -                                         enum vm_event_item idx)
> -{
> -       struct mem_cgroup *memcg =3D page_memcg(page);
> -
> -       if (memcg)
> -               count_memcg_events(memcg, idx, 1);
> -}
> -
>  static inline void count_memcg_folio_events(struct folio *folio,
>                 enum vm_event_item idx, unsigned long nr)
>  {
> @@ -1565,11 +1556,6 @@ static inline void __count_memcg_events(struct mem=
_cgroup *memcg,
>  {
>  }
>
> -static inline void count_memcg_page_event(struct page *page,
> -                                         int idx)
> -{
> -}
> -
>  static inline void count_memcg_folio_events(struct folio *folio,
>                 enum vm_event_item idx, unsigned long nr)
>  {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 9efd8ff68f06..6a7184cd291b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -888,16 +888,16 @@ static int hpage_collapse_find_target_node(struct c=
ollapse_control *cc)
>  }
>  #endif
>
> -static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, in=
t node,
> +static bool hpage_collapse_alloc_folio(struct folio **folio, gfp_t gfp, =
int node,
>                                       nodemask_t *nmask)
>  {
> -       *hpage =3D __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
> -       if (unlikely(!*hpage)) {
> +       *folio =3D __folio_alloc(gfp, HPAGE_PMD_ORDER, node, nmask);
> +
> +       if (unlikely(!*folio)) {
>                 count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>                 return false;
>         }
>
> -       folio_prep_large_rmappable((struct folio *)*hpage);
>         count_vm_event(THP_COLLAPSE_ALLOC);
>         return true;
>  }
> @@ -1064,17 +1064,20 @@ static int alloc_charge_hpage(struct page **hpage=
, struct mm_struct *mm,
>         int node =3D hpage_collapse_find_target_node(cc);
>         struct folio *folio;
>
> -       if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask=
))
> +       if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nma=
sk)) {
> +               *hpage =3D NULL;
>                 return SCAN_ALLOC_HUGE_PAGE_FAIL;
> +       }
>
> -       folio =3D page_folio(*hpage);
>         if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>                 folio_put(folio);
>                 *hpage =3D NULL;
>                 return SCAN_CGROUP_CHARGE_FAIL;
>         }
> -       count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
>
> +       count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
> +
> +       *hpage =3D folio_page(folio, 0);
>         return SCAN_SUCCEED;
>  }
>
> --
> 2.40.1
>
