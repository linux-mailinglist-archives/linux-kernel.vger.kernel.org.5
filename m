Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F82759985
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjGSPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGSPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:23:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67367BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:23:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso940463166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689780210; x=1692372210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYTI3rxc07upa7orcKEjaXXi8vFg3GHcpbX5fCjL0zo=;
        b=rdSZMmCBAzdoLWy2/2UJlGsstH/QYihCudnOBWEcFDbhLbNqgAM44QGcCaXrsL0MZ5
         pjR3A+Zn/i9gUApwqFh6kQEXOLtwNztvHcB7lKRze6OnKeCJN6xMbEu66yJOHs4LJd5G
         EVnjHe5A+sPq0DPYxhnQWgZ7K1Cc59nBV3CtMGphzgzfOXaerrWxiU8ZHPOB019cIG3R
         yzpLrXd5SAGoryzS8IFtSkQGY03lxtpJgn4MSTDt+3/vNhCuPLJNgg45MBDntjpN6h31
         N0uGKP8KYQA8QBYEJ6XIX3jpnCnhOX/Poa80m4YFWkTK744ncQw9xIiAqblLdeYW4uEm
         XHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780210; x=1692372210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYTI3rxc07upa7orcKEjaXXi8vFg3GHcpbX5fCjL0zo=;
        b=Txi0STRK1zgUscTbZvIbcuAbkysiG6Wz+/Q7t7EePri/5NaabSSUifAGL6O4HOlqtg
         qcf/q/DLa/iKksOSHdTKMX8FLLJlFexGEPZMj2cOh1Gv8/N05FeqQCiGBrUDHmIw9njY
         UYGEzP1FalTr1iYL3YS760AJWpbuuWOx45ETQY6+ut8N1Nqm8CAuPw6IcGZIjkGUFpP5
         xYU7l7fNVYuxUbOx8ju6+2YGxkTShl42qoLPLCzliirdNXnj0E3chljeV2IIsVSAf/z3
         QFkaa4Ck48cMrycQAmNlfLJSPbrwBqR35/8V+7dij2aMaHkeFVCk6MK/XJYs69rprspy
         7HZg==
X-Gm-Message-State: ABy/qLaUrtxlrAy4ktcxb594Pea9vho86MoHLlcHp1hYwfDUzk4BZZwl
        JhuynTSFuNvFhPfAqMOHo1IVoIIqMXs9sO1MO2/DYg==
X-Google-Smtp-Source: APBJJlGe6ARv3ysgZg/JX60UPzKzjCRWAJishv5hbT41vqoQjAhbq5kvYF4ZBIk9ocMe7qHigXOLNSRSfN3CRgzS3pg=
X-Received: by 2002:a17:907:8d11:b0:992:a838:a564 with SMTP id
 tc17-20020a1709078d1100b00992a838a564mr2251707ejc.28.1689780209717; Wed, 19
 Jul 2023 08:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230714194610.828210-1-hannes@cmpxchg.org> <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org> <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org> <CAJD7tkbkoph+N3E92n4xGAvVP12H=issOfAPmdrS0655Ja=qAw@mail.gmail.com>
 <20230719142832.GA932528@cmpxchg.org>
In-Reply-To: <20230719142832.GA932528@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 19 Jul 2023 08:22:52 -0700
Message-ID: <CAJD7tkYTmkVAbm20gmU0nB4vyA8YEy2+uRiQLFW00RHUApn+9Q@mail.gmail.com>
Subject: Re: [PATCH] mm: kill frontswap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 7:28=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Hi Yosry,
>
> thanks for the review. I hope I saw everything you commented on ;) -
> can you please trim your replies to the relevant hunks?

You did :) Sorry for that, my client automatically trims the quotes so
I couldn't perceive the size of the problem :p

>
> On Tue, Jul 18, 2023 at 11:52:45AM -0700, Yosry Ahmed wrote:
> > On Mon, Jul 17, 2023 at 9:02=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > > -/*
> > > - * "Get" data from frontswap associated with swaptype and offset tha=
t were
> > > - * specified when the data was put to frontswap and use it to fill t=
he
> > > - * specified page with data. Page must be locked and in the swap cac=
he.
> > > - */
> > > -int __frontswap_load(struct page *page)
> > > -{
> > > -       int ret =3D -1;
> > > -       swp_entry_t entry =3D { .val =3D page_private(page), };
> > > -       int type =3D swp_type(entry);
> > > -       struct swap_info_struct *sis =3D swap_info[type];
> > > -       pgoff_t offset =3D swp_offset(entry);
> > > -       bool exclusive =3D false;
> > > -
> > > -       VM_BUG_ON(!frontswap_ops);
> > > -       VM_BUG_ON(!PageLocked(page));
> > > -       VM_BUG_ON(sis =3D=3D NULL);
> > > -
> > > -       if (!__frontswap_test(sis, offset))
> > > -               return -1;
> >
> > With the removal of the above, it will be a bit slower to realize an
> > entry is not in zswap and read it from disk (bitmask test vs. rbtree
> > lookup). I guess in the swapin path (especially from disk), it would
> > not matter much in practice. Just a note (mostly to myself).
>
> I briefly considered moving that bitmap to zswap, but it actually
> seems quite backwards. It adds overhead to the fast path, where
> entries are in-cache, in order to optimize the cold path that requires
> IO. As long as compression is faster than IO, zswap is expected to see
> the (much) bigger share of transactions in any sane config.

Makes sense to me, thanks for the clarification. Maybe we should put
this in the commit log as well?

>
> > > @@ -1356,15 +1342,12 @@ static int zswap_frontswap_store(unsigned typ=
e, pgoff_t offset,
> > >
> > >         /* map */
> > >         spin_lock(&tree->lock);
> > > -       do {
> > > -               ret =3D zswap_rb_insert(&tree->rbroot, entry, &dupent=
ry);
> > > -               if (ret =3D=3D -EEXIST) {
> > > -                       zswap_duplicate_entry++;
> > > -                       /* remove from rbtree */
> > > -                       zswap_rb_erase(&tree->rbroot, dupentry);
> > > -                       zswap_entry_put(tree, dupentry);
> > > -               }
> > > -       } while (ret =3D=3D -EEXIST);
> > > +       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=
=3D -EEXIST) {
> > > +               zswap_duplicate_entry++;
> > > +               /* remove from rbtree */
> > > +               zswap_rb_erase(&tree->rbroot, dupentry);
> > > +               zswap_entry_put(tree, dupentry);
> >
> > nit: it would be nice to replace the above two lines with
> > zswap_invalidate_entry(), which also keeps it clear that we maintain
> > the frontswap semantics of invalidating a duplicated entry.
>
> Agreed, that's better. I'll send a follow-up.

Thanks!

>
> > > @@ -1418,7 +1401,7 @@ static int zswap_frontswap_load(unsigned type, =
pgoff_t offset,
> > >         if (!entry) {
> > >                 /* entry was written back */
> >
> > nit: the above comment is now obsolete. We may not find the entry
> > because it was never stored in zswap in the first place (since we
> > dropped the frontswap map, we won't know before we do the lookup
> > here).
>
> Good catch. I'll send a delta fix to Andrew.
>
> > LGTM with a few nits above, probably they can be done in follow up
> > patches. Thanks for the cleanup!
> >
> > FWIW:
> > Acked-by: Yosry Ahmed <yosryahmed@google.com>
>
> Thanks!
>
> Andrew, could you please fold this in?
>
> ---
>
> From 86eeba389d7478e5794877254af6cc0310c835c7 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 19 Jul 2023 10:21:49 -0400
> Subject: [PATCH] mm: kill frontswap fix
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d58672f23d43..583ef7b84dc3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1399,7 +1399,6 @@ bool zswap_load(struct page *page)
>         spin_lock(&tree->lock);
>         entry =3D zswap_entry_find_get(&tree->rbroot, offset);
>         if (!entry) {
> -               /* entry was written back */
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> --
> 2.41.0
