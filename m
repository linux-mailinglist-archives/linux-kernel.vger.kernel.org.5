Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D0C7CE499
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjJRRa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjJRRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:30:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771C53AA9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:21:38 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso8215681276.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697649697; x=1698254497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlsllgD6PkaqFDw9HMpD0Og8oMtW0iTOecosrhmZCqs=;
        b=LcAgY3+o6neSteIQbN3SQskkwqcRTyWbzdkkF6N+33nQaYSBsSVPSfF/GleI4cCITb
         PKzHPKkaLLcExIQRtIj5hVk8ix2uv2mhBNX6+CSG/getefCEokBZH7iXLoFS5+8Cbc4a
         uq+LIv8UfLm/fSsyVKwJB8FLWumMdYjJtg9qfCBgVq5oCfDMNzh1aKnvhBryGsnrUtST
         06dv1Chem3MQ0Mw9zVa0XzUJJKcJAagwPNYH8SGEH9N3Bxsi1zuqCe0QyiGnZtcHoxlh
         cQIRL4+fJSH0LvinCWc8SQ2KotyunbKQ6F5WeDzYCoD8dAo8J3MGAPQJLp2tK46bpt/U
         HmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649697; x=1698254497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlsllgD6PkaqFDw9HMpD0Og8oMtW0iTOecosrhmZCqs=;
        b=skdBtdtixAJskYKT9dHEMQcOqpdhp1r1gZE5V+LWz287BiqA1REG+LmHs0R+T47dL2
         DhswBkpglZNFcfTS2PNxsugm7oKHA6e8at2cDwv84W3WlSYJKfe4GEMgaUCKMwkhSnJB
         cLImLPndVfl/0XIymtlE8QtV7TPEbd65r5B1Rlrrkmu5+l24an3CJhmDdgzf1hxQlk8P
         3wVTeucNaz+TsAY1hlkwgIDg49qHHWe3+kFCJhPhsWmMh281pxWsBlJcwJKJnu0dNebN
         ZDPGa4iUtExY7QnMuCvFNsk5xFhPQKiRNqkORXM+8n3qHAS5rpmHj/L9hb0MB/qK36iO
         7n5A==
X-Gm-Message-State: AOJu0Yw6uzSYuNrRyNJlTs3WgQmoaaZOr5vMun027BmBIEXIcwXPtHam
        6SWy3SAJTUVXgOyJ9fd0W/+QmRbC6Z7Z6uv3hWZ12C2q
X-Google-Smtp-Source: AGHT+IHcqLXU34Ocg34YwR4wruTTUORgvwsW2VYFcffaPOMJl8CEorUKlJWndaafeW9HkCYXPFx+bt4rln6T8GQYrCU=
X-Received: by 2002:a25:8a92:0:b0:d9a:bbe1:1b7a with SMTP id
 h18-20020a258a92000000b00d9abbe11b7amr5541586ybl.50.1697649697519; Wed, 18
 Oct 2023 10:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231016200510.7387-1-vishal.moola@gmail.com> <20231016200510.7387-5-vishal.moola@gmail.com>
 <84cdc2c3-e5e3-469b-b265-8df3e72a8c2f@huawei.com>
In-Reply-To: <84cdc2c3-e5e3-469b-b265-8df3e72a8c2f@huawei.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 18 Oct 2023 10:21:25 -0700
Message-ID: <CAOzc2pwRoYhhrCkHXyBD90OzZR4AwV3t9fgEuOo84ftKXKMcbQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm/khugepaged: Convert alloc_charge_hpage() to use folios
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, shy828301@gmail.com
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

On Mon, Oct 16, 2023 at 8:48=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
>
>
> On 2023/10/17 4:05, Vishal Moola (Oracle) wrote:
> > Also convert hpage_collapse_alloc_page() to
> > hpage_collapse_alloc_folio().
> >
> > This removes 1 call to compound_head() and helps convert khugepaged to
> > use folios throughout.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >   mm/khugepaged.c | 13 +++++++------
> >   1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index fa21a53ce0c0..70bba8ddea13 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -886,16 +886,16 @@ static int hpage_collapse_find_target_node(struct=
 collapse_control *cc)
> >   }
> >   #endif
> >
> > -static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, =
int node,
> > +static bool hpage_collapse_alloc_folio(struct folio **folio, gfp_t gfp=
, int node,
> >                                     nodemask_t *nmask)
> >   {
> > -     *hpage =3D __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
> > -     if (unlikely(!*hpage)) {
> > +     *folio =3D __folio_alloc(gfp, HPAGE_PMD_ORDER, node, nmask);
> > +
> > +     if (unlikely(!*folio)) {
> >               count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> >               return false;
> >       }
> >
> > -     folio_prep_large_rmappable((struct folio *)*hpage);
> >       count_vm_event(THP_COLLAPSE_ALLOC);
> >       return true;
> >   }
> > @@ -1062,15 +1062,16 @@ static int alloc_charge_hpage(struct page **hpa=
ge, struct mm_struct *mm,
> >       int node =3D hpage_collapse_find_target_node(cc);
> >       struct folio *folio;
> >
> > -     if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask=
))
> > +     if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nma=
sk))
> >               return SCAN_ALLOC_HUGE_PAGE_FAIL;
> >
> > -     folio =3D page_folio(*hpage);
> >       if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
> >               folio_put(folio);
> >               *hpage =3D NULL;
> >               return SCAN_CGROUP_CHARGE_FAIL;
> >       }
> > +
> > +     *hpage =3D folio_page(folio, 0);
> >       count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
>
> count_memcg_folio_events=EF=BC=88=EF=BC=89and kill count_memcg_page_event=
?
> >
> >       return SCAN_SUCCEED;

Thanks, I didn't notice that was the last caller.
