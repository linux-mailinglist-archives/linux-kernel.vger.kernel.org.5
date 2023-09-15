Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AED7A146F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjIODfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjIODfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:35:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0B2121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:35:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-414ba610766so183471cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694748906; x=1695353706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+PNwmN/bmJL1I9mkj8ynEN5iRLRKttuy6RTWtwzLdI=;
        b=g5ge0vejyGGP5bEPUGDoyIssBAHi0rYXE4/6kdL5rDti8C7+On0HAxtesy83jaegej
         wrXyv9c+JBFiJj2KrXHzxiRLrZinWV6wFX7d+/wxqWK5O0kCJHKhEBXALj+u3noh03bM
         Sx/AdgKlUUKr/Clg18eZOHdLK+8EOjuHDwRqmrRQ2G+LhjDCm5dob6WvLgtQMGeABtbm
         lEXLKslTkhIMCb2snQNdFW+XuL5lnxaRhatsTi1VvSGhNY/Yi0AomDxNkou4w9MtlLIZ
         f1mNFhj1plB+gNheohcqN0TPliUNKAhV7NLxITvWzPIW0lfBbTHO56t3Xip4HENWrHvI
         ct3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748906; x=1695353706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+PNwmN/bmJL1I9mkj8ynEN5iRLRKttuy6RTWtwzLdI=;
        b=s7Vdt1qN0INwOoQgv/cC4kEpPsE4ld5G/W6FsV5P8g5koNwlZ2qZ1wHqA4kJZr9CYx
         78yWpyaFuM0I3V1emy4+AI3qTsvH6LQkwLUAfi0DNoRWNIW9VdGq1yXpLiqnAe5gtqUB
         AXvbubrePHm5kUrM41DzQAeCWnDCm/LgMo+y69kYD4nQQq3BINz8GEVcI6zT35QgMhVX
         Y71EKPEPSOOSFYLaOqmC3kWEytEYNEnKCa6TCdAhFJUTmJfkdfSe9cccLbjWfR4zNPde
         japOk7/ko6C4C7FPnYrGtekJ7iH/vXsUkXjRwwQv3gP3T4dWulbMfCgwvl0Phu8/mtZm
         Z5iw==
X-Gm-Message-State: AOJu0Yx5Rkfq551VWSqZn+lZKewIeS4CxPx1WBleYszh7Whec1j40dx7
        MZTXv8mD5siIoOTI5S/dSrgAQSAlFQCrAKupRTZqdQ==
X-Google-Smtp-Source: AGHT+IEnS0u+vEl2AIzO6qpWtLjUY+Kb25imxoo0RaRfnzAF/oMKZrh73kXLe8DSGdC2WylAKA3cWGcYP1PHrhacuNQ=
X-Received: by 2002:a05:622a:102:b0:417:5a8c:a104 with SMTP id
 u2-20020a05622a010200b004175a8ca104mr140525qtw.26.1694748905646; Thu, 14 Sep
 2023 20:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230914140823.1732-1-justinjiang@vivo.com> <CAOUHufY+7j1L37c1RvCBdkx36qyNZYOBuZa_+GAA4j=9vKzwWA@mail.gmail.com>
 <JH0PR06MB684964083AEC0B49CA56EC51C7F6A@JH0PR06MB6849.apcprd06.prod.outlook.com>
 <CAOUHufYKJ9YCNU6WEQjkM5Ad7X0wWXhUQm5sQWZhZ0Tb-cFzDQ@mail.gmail.com> <JH0PR06MB68498F28DD3E630DCACB9681C7F6A@JH0PR06MB6849.apcprd06.prod.outlook.com>
In-Reply-To: <JH0PR06MB68498F28DD3E630DCACB9681C7F6A@JH0PR06MB6849.apcprd06.prod.outlook.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Sep 2023 21:34:29 -0600
Message-ID: <CAOUHufaaUQyNNniHpF06-i3YQ+f-5L5QWj5vRK2_PXyewEsOyg@mail.gmail.com>
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

On Thu, Sep 14, 2023 at 9:33=E2=80=AFPM =E6=B1=9F=E5=BF=97=E5=9B=BD <justin=
jiang@vivo.com> wrote:
>
> Hi Yu Zhao:
>
> Thank you for your reply and sharing.

Sorry, wrong link. This is the right one:

https://www.kernel.org/doc/html/latest/mm/unevictable-lru.html#the-unevicta=
ble-lru-folio-list

> On Thu, Sep 14, 2023 at 9:19=E2=80=AFPM =E6=B1=9F=E5=BF=97=E5=9B=BD <just=
injiang@vivo.com> wrote:
> >
> > Hi Yu Zhao:
> >
> > How is the unevictable folio managed in kernel?
>
> https://www.kernel.org/doc/Documentation/vm/unevictable-lru.txt
>
> > On Thu, Sep 14, 2023 at 8:08=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.=
com> wrote:
> > >
> > > The unevictable folio is not supported to add to lruvec->lists in
> > > lruvec_add_folio().
> > >
> > > So use lruvec_add_folio_tail() instead of lruvec_add_folio() to add
> > > unevictable folio to lruvec->lists in sort_folio().
> > >
> > > Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> > > ---
> > >  mm/vmscan.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)  mode change 100644
> > > =3D>
> > > 100755 mm/vmscan.c
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c index
> > > 661615fa709b..a15e45632034
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4237,7 +4237,7 @@ static bool sort_folio(struct lruvec *lruvec, s=
truct folio *folio, struct scan_c
> > >                 success =3D lru_gen_del_folio(lruvec, folio, true);
> > >                 VM_WARN_ON_ONCE_FOLIO(!success, folio);
> > >                 folio_set_unevictable(folio);
> > > -               lruvec_add_folio(lruvec, folio);
> > > +               lruvec_add_folio_tail(lruvec, folio);
> > >                 __count_vm_events(UNEVICTABLE_PGCULLED, delta);
> > >                 return true;
> > >         }
> >
> > NAK.
> >
> > lruvec_add_folio()
> > {
> >         ...
> >
> >         if (lru !=3D LRU_UNEVICTABLE)
> >                 list_add(&folio->lru, &lruvec->lists[lru]); }
> >
> > lruvec_add_folio_tail()
> > {
> >         ...
> >
> >         /* This is not expected to be used on LRU_UNEVICTABLE */
> >         list_add_tail(&folio->lru, &lruvec->lists[lru]); }
> >
> > struct page {
> >         ...
> >                         union {
> >                                 struct list_head lru;
> >
> >                                 /* Or, for the Unevictable "LRU list" s=
lot */
> >                                 struct {
> >         ...
> > }
