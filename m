Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F57F4EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjKVSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:08:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371511B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:08:23 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso661241fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700676501; x=1701281301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z//RucA8tE1/CYD6Q8FXMQUzE3udbcwedLzht1PJJU0=;
        b=LyVy+TXamX5b4XO/UjHuY5l/ksKHva9nFIl7bnT/ar9v0b0DdRg0j4FbSZbspcudNq
         2YUh41d3IEdlNZY1/FF4nPPp/WmqDjs3YiFcmXNQXLvso3G+w03kMIUKb0eDl9XIylcv
         y3BVauTwsnuoN5KjFIJd/LEgGreyszLDd0rhTiH6+ZGya4lKgsOfiTI6gvEJ2es0IZ1q
         ACcCofU9Xh1VGTPyH6u8bBKULwMq8my66L7jl5qpO571toBeE4r3AW5kCuBe0e3vEYzA
         ji3g/XFkLvzq4c6W9wBE8xB1sLI6qJ2+w9mHcyXCcwqW2TRMAgRyODrg47sG+FvAf8Oe
         nH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676501; x=1701281301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z//RucA8tE1/CYD6Q8FXMQUzE3udbcwedLzht1PJJU0=;
        b=TvO7ZOsicXpCw49Gd9T/IN2hdegXk5vaIJ8QHlI1xupMkVgFOTb8xjWRZZY4Xpy4J9
         Ype8RoUo+I2IbyHOB8PPbqfII2deMmTenDw1rD3YZoJE2u4WAArcEt1YqYOMPfRu91LF
         8K8XpenTm7x0JIpv1r7aUc0L7qIm2InrGTv3rvNG6IGJDI0X6fgEhXOi4y5EH7ggatfO
         GbmHwg/3+bSPUGbjlQIEY0R/l76rJaWSCbsAKaS7wmc5nJoUpQm1dRsVKayAHomK4RQs
         cgj4yWpvEt5B1LNQqemXToGY3qukG1kwRqojJ2Lz+u5m7b2OhGTvWT17k3w5Sc70JQDC
         fKsQ==
X-Gm-Message-State: AOJu0YxDeY0E5YmcixXjv/t4b98yi6LLSjDNzM7Vj3zd/kTYimoqb0nH
        wbwYwnIhrAjTydtJsKGD6F6RbNj4zLwuufKkAsA=
X-Google-Smtp-Source: AGHT+IEH4JaV9faUPetkiI3Pq13W6T68SfFoLkf6MuquZjHLZ5crwlofQHtlnSF6LY+cHU+ljortfnDpM+AFlOiiSig=
X-Received: by 2002:a2e:824f:0:b0:2c5:9e2:ed14 with SMTP id
 j15-20020a2e824f000000b002c509e2ed14mr2225732ljh.39.1700676501254; Wed, 22
 Nov 2023 10:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-16-ryncsn@gmail.com>
 <CAF8kJuM3Czmr1Up9mYGK9k9HH8r0CHkXvZ8rWyqniM4vtExF+Q@mail.gmail.com>
In-Reply-To: <CAF8kJuM3Czmr1Up9mYGK9k9HH8r0CHkXvZ8rWyqniM4vtExF+Q@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 23 Nov 2023 02:08:03 +0800
Message-ID: <CAMgjq7DsUBr4CgrJi9VKTgU3_tyrD0c5dLS_zU7akm31PQy-5g@mail.gmail.com>
Subject: Re: [PATCH 15/24] mm/swap: avoid an duplicated swap cache lookup for
 SYNCHRONOUS_IO device
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=89 01:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > When a xa_value is returned by the cache lookup, keep it to be used
> > later for workingset refault check instead of doing the looking up agai=
n
> > in swapin_no_readahead.
> >
> > This does have a side effect of making swapoff also triggers workingset
> > check, but should be fine since swapoff does effect the workload in man=
y
> > ways already.
>
> I need to sleep on it a bit to see if this will create another problem or=
 not.
>
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index e057c79fb06f..51de2a0412df 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -872,7 +872,6 @@ static struct page *swapin_no_readahead(swp_entry_t=
 entry, gfp_t gfp_mask,
> >  {
> >         struct folio *folio;
> >         struct page *page;
> > -       void *shadow =3D NULL;
> >
> >         page =3D alloc_pages_mpol(gfp_mask, 0, mpol, ilx, numa_node_id(=
));
> >         folio =3D (struct folio *)page;
> > @@ -888,10 +887,6 @@ static struct page *swapin_no_readahead(swp_entry_=
t entry, gfp_t gfp_mask,
> >
> >                 mem_cgroup_swapin_uncharge_swap(entry);
> >
> > -               shadow =3D get_shadow_from_swap_cache(entry);
> > -               if (shadow)
> > -                       workingset_refault(folio, shadow);
> > -
> >                 folio_add_lru(folio);
> >
> >                 /* To provide entry to swap_readpage() */
> > @@ -922,11 +917,12 @@ struct page *swapin_readahead(swp_entry_t entry, =
gfp_t gfp_mask,
> >         enum swap_cache_result cache_result;
> >         struct swap_info_struct *si;
> >         struct mempolicy *mpol;
> > +       void *shadow =3D NULL;
> >         struct folio *folio;
> >         struct page *page;
> >         pgoff_t ilx;
> >
> > -       folio =3D swap_cache_get_folio(entry, vmf, NULL);
> > +       folio =3D swap_cache_get_folio(entry, vmf, &shadow);
> >         if (folio) {
> >                 page =3D folio_file_page(folio, swp_offset(entry));
> >                 cache_result =3D SWAP_CACHE_HIT;
> > @@ -938,6 +934,8 @@ struct page *swapin_readahead(swp_entry_t entry, gf=
p_t gfp_mask,
> >         if (swap_use_no_readahead(si, swp_offset(entry))) {
> >                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx=
, vmf->vma->vm_mm);
> >                 cache_result =3D SWAP_CACHE_BYPASS;
> > +               if (shadow)
> > +                       workingset_refault(page_folio(page), shadow);
>
> It is inconsistent why other flavors of readahead do not do the
> workingset_refault here.

Because of the readaheads and swapcache. Every readahead pages need to
be checked by workingset_refault with a different shadow (and so a
different xarray entry search is needed). And since other swapin path
need to insert page into swapcache, they will do extra xarray
search/insert anyway so this optimization won't work.

> I suggest keeping the workingset_refault in swapin_no_readahead() and
> pass the shadow argument in.

That sounds good to me.
