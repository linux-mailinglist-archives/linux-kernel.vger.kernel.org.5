Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2957A1459
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjIODZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIODZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:25:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34231FCE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:25:49 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-415155b2796so112201cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694748349; x=1695353149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfEJAb1Oa43f4O5YEz3j++WYlwhSssKiqqan4u4vMXc=;
        b=ccvGVNWpRK2ftao2R4yDnxDys+2ZVU2ivsl7Xi/YOYtDOSX1m+psD07YkPFdYG9Apk
         d9dJj2E4bP33VUnGY1SvweHu+MHcc/MQjMkG0t175U0w1y0W6DEbNCiNU/l0h0wSgcxm
         SJ5g7GAl1dkNSNcbnR2u8fgdRbWMTYQ2u1Xrzi/iydj/qoQ2T9BJmWpJoYf86ZGmRs+z
         FKkJfqAu2hHUaixCg8MpZGdZfGTw5hfVVcpC9rVGMTqsU9kMC/5sdbLu+5xh9HtXbuzQ
         oAnPrzJpg3CstZvvz7fatooAEtS3U6oP4mTmGMKWv3br++elVKxRvz/ri//QWz1kXguC
         Ll7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748349; x=1695353149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfEJAb1Oa43f4O5YEz3j++WYlwhSssKiqqan4u4vMXc=;
        b=L2HpjNiGQlx6IXYvmKYYNcA7IrRlzHRq8fNwEcL5qc/w+L/fCHm3N7eY0BMsQ9Jw7U
         uSoud6hmHoHaVloLRs20qy5rqLM5aPawlRRIjuVHe+hvPqzvGFzDSujoAKloBS+5ENjW
         aD5PHWE74NDvmUD5yIhd9+VjY4X+FV3LWTr9bEnWZg6mR1/bVWN84JCzWFArDhvTY8LD
         9e6QCD32FPdarNl9FkNFCtGm1+iTM3dfWvIHj8rrm+H+seXwppfyAXbti/XQhb2fb74u
         GqfDkF5Zef6TpscYPsYGGQlw4CBoDVgmBlLVVReOh65ekWn2S4gLMEOOquiy8Qlpr4kK
         m8tQ==
X-Gm-Message-State: AOJu0Yy/J7J/Xk1HIkGB9kBfYLzH/lz7q9RuMB+5kTF2EE8l7G7VNVLi
        VNDCY93qsLZ2g9qJnV4L2rOdwPeUZzN4y2qy8JPacA==
X-Google-Smtp-Source: AGHT+IEdmRI/AeyGbYGXZEVYz1wokGH6qYqLgtz4EqSaNq3jxHSXHSd0UP5c3n8USlIx3LalHoys0zearPoT0fT7pd0=
X-Received: by 2002:ac8:5707:0:b0:412:9cd:473b with SMTP id
 7-20020ac85707000000b0041209cd473bmr143007qtw.4.1694748348614; Thu, 14 Sep
 2023 20:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914140823.1732-1-justinjiang@vivo.com> <CAOUHufY+7j1L37c1RvCBdkx36qyNZYOBuZa_+GAA4j=9vKzwWA@mail.gmail.com>
 <JH0PR06MB684964083AEC0B49CA56EC51C7F6A@JH0PR06MB6849.apcprd06.prod.outlook.com>
In-Reply-To: <JH0PR06MB684964083AEC0B49CA56EC51C7F6A@JH0PR06MB6849.apcprd06.prod.outlook.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Sep 2023 21:25:10 -0600
Message-ID: <CAOUHufYKJ9YCNU6WEQjkM5Ad7X0wWXhUQm5sQWZhZ0Tb-cFzDQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: fix add unevictable folio to lruvec->lists
To:     =?UTF-8?B?5rGf5b+X5Zu9?= <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 9:19=E2=80=AFPM =E6=B1=9F=E5=BF=97=E5=9B=BD <justin=
jiang@vivo.com> wrote:
>
> Hi Yu Zhao:
>
> How is the unevictable folio managed in kernel?

https://www.kernel.org/doc/Documentation/vm/unevictable-lru.txt

> On Thu, Sep 14, 2023 at 8:08=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.co=
m> wrote:
> >
> > The unevictable folio is not supported to add to lruvec->lists in
> > lruvec_add_folio().
> >
> > So use lruvec_add_folio_tail() instead of lruvec_add_folio() to add
> > unevictable folio to lruvec->lists in sort_folio().
> >
> > Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  mode change 100644 =3D>
> > 100755 mm/vmscan.c
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c index
> > 661615fa709b..a15e45632034
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4237,7 +4237,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio *folio, struct scan_c
> >                 success =3D lru_gen_del_folio(lruvec, folio, true);
> >                 VM_WARN_ON_ONCE_FOLIO(!success, folio);
> >                 folio_set_unevictable(folio);
> > -               lruvec_add_folio(lruvec, folio);
> > +               lruvec_add_folio_tail(lruvec, folio);
> >                 __count_vm_events(UNEVICTABLE_PGCULLED, delta);
> >                 return true;
> >         }
>
> NAK.
>
> lruvec_add_folio()
> {
>         ...
>
>         if (lru !=3D LRU_UNEVICTABLE)
>                 list_add(&folio->lru, &lruvec->lists[lru]); }
>
> lruvec_add_folio_tail()
> {
>         ...
>
>         /* This is not expected to be used on LRU_UNEVICTABLE */
>         list_add_tail(&folio->lru, &lruvec->lists[lru]); }
>
> struct page {
>         ...
>                         union {
>                                 struct list_head lru;
>
>                                 /* Or, for the Unevictable "LRU list" slo=
t */
>                                 struct {
>         ...
> }
