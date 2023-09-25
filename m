Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48BB7ADF58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjIYS6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjIYS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:58:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D23B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:58:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d86574d9bcaso5538737276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668282; x=1696273082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuoynwRV5c5Nr3xHW2kpZ/cwqzPNC7pXTPcMuN6SgkI=;
        b=Ktr1KBiRoUJ2hMcCkcy60oxvgc1W9g/UQAaJZRCV/4U5uALnrI7IrQFydJOdS/iwj5
         3/845Gm7vnOE5aKIOrmbEVwEUHV3HfsYPNO+ymeIVYiKneoO1IK3p+LOzVV0N0QdGLmH
         HUv835sCfwIP1A2yUiOdLj9ghcMWaODRTTtGVlnn7dBcS1sVFQ409TBuViRSaSwUUoDk
         vm+iGkK8HWpGEJ5Ov4R21i/+8vawpOYdTWV1ABFeIaZifaP5U2j4JeU+kyjaAyDe0jTU
         4ETuWWXqFi1U/6IlGquDXDefDRSK2JCVePt6AYK20N3nM0wsT5+wss0WRhGS4jjY3/Aj
         X70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668282; x=1696273082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuoynwRV5c5Nr3xHW2kpZ/cwqzPNC7pXTPcMuN6SgkI=;
        b=h+KflvlmIVjUMJt6uubgcEmmHD8y8KQlyqzI5OhETdVHpKE26gwXpHmGWDEAsf6U9+
         FqaZSAT3YXoG3S0IM2D7PJNq+4jANcUh/uL3PXy93D93TowrXFs43qhO5SSAbP4YJn5s
         KL/MqHjNyYTIj9UQ0lOqsvvmlKVXgJjKmuhblsDQfsCp6qZ3duj6x75w0j1qTeM2UaH7
         ZXlwFCehnQX8Ty1aNtL15CHD488Depup//U9ntbf2VV5DTrHCUuAykbVrft9irZv5rTO
         /wtKUKd4SnLO6s3N8jWneCmuOtOcOGSFOG97bDm6XNuIt6aFRbX0z4t51Y9djUnDApyg
         lqbg==
X-Gm-Message-State: AOJu0YyWPwyO4yQPAyqI0QJ+ueNG8wPQ3pVsmiBaguSrwSGlbfnCtrvG
        6RqzTKSeVxtTBEKWPoyn7JuV1E4sCNII7yMHrTs=
X-Google-Smtp-Source: AGHT+IFhxIMAD8ALqrfxM2hLcXZVqSR1gp0jeGimI8rQ6mz7kjqRK98F1ZFQ6+i51oL224BKpp/aIdJSnkZqz92uYis=
X-Received: by 2002:a25:7455:0:b0:d85:3b6a:c3b8 with SMTP id
 p82-20020a257455000000b00d853b6ac3b8mr6880934ybc.45.1695668282213; Mon, 25
 Sep 2023 11:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-2-vishal.moola@gmail.com> <fd2149bb-2c5f-222c-5134-ae251910b3cc@redhat.com>
In-Reply-To: <fd2149bb-2c5f-222c-5134-ae251910b3cc@redhat.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 25 Sep 2023 11:57:51 -0700
Message-ID: <CAOzc2pxjg=ReO_3s-LWu_iwik=5ASS3qL-2dKGjd6BN6AthH2w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm/khugepaged: Convert __collapse_huge_page_isolate()
 to use folios
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Mon, Sep 25, 2023 at 12:18=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 22.09.23 21:36, Vishal Moola (Oracle) wrote:
> > This is in preparation for the removal of the khugepaged compound_pagel=
ist.
> >
> > Replaces 11 calls to compound_head() with 1, and removes 499 bytes of
> > kernel text.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >   mm/khugepaged.c | 52 ++++++++++++++++++++++++------------------------=
-
> >   1 file changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 88433cc25d8a..f46a7a7c489f 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -541,7 +541,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                                       struct collapse_control *cc,
> >                                       struct list_head *compound_pageli=
st)
> >   {
> > -     struct page *page =3D NULL;
> > +     struct folio *folio =3D NULL;
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       bool writable =3D false;
> > @@ -570,15 +570,15 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >                       result =3D SCAN_PTE_UFFD_WP;
> >                       goto out;
> >               }
> > -             page =3D vm_normal_page(vma, address, pteval);
> > -             if (unlikely(!page) || unlikely(is_zone_device_page(page)=
)) {
> > +             folio =3D vm_normal_folio(vma, address, pteval);
> > +             if (unlikely(!folio) || unlikely(folio_is_zone_device(fol=
io))) {
> >                       result =3D SCAN_PAGE_NULL;
> >                       goto out;
> >               }
> >
> > -             VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +             VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
> >
> > -             if (page_mapcount(page) > 1) {
> > +             if (folio_estimated_sharers(folio) > 1) {
>
> For a tail page of a PTE-mapped THP this is not the same.
>
> The possible side effects this might have should be spelled out in the
> patch description.

Ok, I'll add the side effects to the commit message in v2.
