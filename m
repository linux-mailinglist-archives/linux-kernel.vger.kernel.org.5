Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDE776624
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjHIRJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHIRJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:09:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B491FD4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:09:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-407db3e9669so10391cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600992; x=1692205792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtpCk/kHhj2S6pipOJUYP67g+bYAwvz2JrywuvS8YOQ=;
        b=aNJkmQnJc9BMhQElymADNWR0bea0CfKbnPyRAbMOIsyX1O5SvhbT5XEBcr59UUQSY2
         rtJQgNlr+3XX2e4IBleDAAsMgPaIXQLK9gJ5mrqP++BsLxTne0JBtTrM377YGNJHVtw7
         7qwCfGdC3VxbMvpXVqINkG344YjRDZFrs/KJ/YqBVX4HgG5XxwGaOoUhY6XDYwyGObiw
         F/lUkD3HnAfwPC57vNU1aLBeQrXBUjcbkMutG0I4FqWkHe3AqSnQ8c0gI5hInh5HFupd
         QQyrDkRKWUZ4m30p/E+rbmWW+IkR6TI4unkqu41EeO3D9auij5NTGZXbtQuDdlLO5pLo
         nc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600992; x=1692205792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtpCk/kHhj2S6pipOJUYP67g+bYAwvz2JrywuvS8YOQ=;
        b=T4eNFa3YkVngENqAEWYTtfChrK6AI9oY/aL0f2RVVe78d3v0g3DkQCddT7KSZjnG/a
         wSb+jBsk7kUfxDG/D8YvIp25JsntM4Mhi3OnF5j7Ldd+jY36bdRseydcWXLBrTUJ34bJ
         uWxd/bKhdhdxEOPL4YKP3neAMjPMaF8Td9Tg9QT5qGRmtvtKI0IxQ/jJa3hyHm8XU8t0
         DoaIL+/2HsSSCe4ajO/9ZNcE6b9qOQhwzrT8Lzjp2mkqs669wAADnXPM4wjceC6GPycq
         Cj5nq1b9W7TGE7nMTBCVlb9g0yt0BYmA+b8lyLU1oewqqCSvi1ujCZOORbgW7irIR4AB
         2NAg==
X-Gm-Message-State: AOJu0YyqtMj9aB9razztK2UahsHBOz+W+4250bKAZjn0EFkQ7jm7GAVe
        HMZ2FclaPzOLLzsDDe6GMp5iajj1nT9s4b9x4y6rC2ogy451kQrMD8LQug9R
X-Google-Smtp-Source: AGHT+IG3KpWlEgRZKeJSH8IgCAin4Njba7/XEsLpalnm0FAG6d4NjQB5bA/B5TubP0zyNjJ1pjjco2FQoZ4A8eX95sk=
X-Received: by 2002:ac8:5790:0:b0:3f2:1441:3c11 with SMTP id
 v16-20020ac85790000000b003f214413c11mr201381qta.2.1691600992091; Wed, 09 Aug
 2023 10:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1691568344-13475-1-git-send-email-quic_charante@quicinc.com>
 <9d109a43-78a3-dee4-5aaa-385bdfe4bcb3@redhat.com> <CAC_TJvckhxwz9TxXgMSaiihHddY+AnEGqjLxvO6qF0eqTb5U8Q@mail.gmail.com>
In-Reply-To: <CAC_TJvckhxwz9TxXgMSaiihHddY+AnEGqjLxvO6qF0eqTb5U8Q@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 9 Aug 2023 11:09:16 -0600
Message-ID: <CAOUHufarW3utTCqk+tes-tbU7iRKCYa_GMZvSNxJrFRKWXMbWw@mail.gmail.com>
Subject: Re: [PATCH] Multi-gen LRU: skip CMA pages when they are not eligible
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        zhaoyang.huang@unisoc.com, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>
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

On Wed, Aug 9, 2023 at 9:54=E2=80=AFAM Kalesh Singh <kaleshsingh@google.com=
> wrote:
>
> On Wed, Aug 9, 2023 at 7:00=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 09.08.23 10:05, Charan Teja Kalla wrote:
> > > This patch is based on the commit 5da226dbfce3("mm: skip CMA pages wh=
en
> > > they are not available") which skips cma pages reclaim when they are =
not
> > > eligible for the current allocation context. In mglru, such pages are
> > > added to the tail of the immediate generation to maintain better LRU
> > > order, which is unlike the case of conventional LRU where such pages =
are
> > > directly added to the head of the LRU list(akin to adding to head of =
the
> > > youngest generation in mglru).
> > >
> > > No observable issue without this patch on MGLRU, but logically it mak=
e
> > > sense to skip the CMA page reclaim when those pages can't be satisfie=
d
> > > for the current allocation context.
> > >
> > > Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>
> Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks, Charan! Do we need a "Fixes" tag?

> > > ---
> > >   mm/vmscan.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index b4329f9..6cbe921 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4943,7 +4943,7 @@ static bool sort_folio(struct lruvec *lruvec, s=
truct folio *folio, struct scan_c
> > >       }
> > >
> > >       /* ineligible */
> > > -     if (zone > sc->reclaim_idx) {
> > > +     if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> > >               gen =3D folio_inc_gen(lruvec, folio, false);
> > >               list_move_tail(&folio->lru, &lrugen->folios[gen][type][=
zone]);
> > >               return true;
> >
> > Makes sense to me.
