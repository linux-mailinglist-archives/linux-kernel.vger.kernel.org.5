Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84428123DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjLNA2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjLNA2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:28:19 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89631D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:28:25 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35d718382b7so31291285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702513705; x=1703118505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOSXxu0Ty5SRYxvtBv47EJc9VazQTq5FR1JKdC1EXXI=;
        b=QDCE7vVIY78NTdQ9XluI2oW8wwIFVZpfq0lzriZAmrPM0gwM/PkfWcCq6gAfAjcqS6
         Ka19swcDBm4Sc0wa1XokZGB7ik1d20AYBCXyxYXpH8TjPGK3KtCJOICPmZWuxLZGk3Dn
         XDIizSluSF1vXG3dACqEHjMhxU0TFBNJvt2XQCbf93Kb6Vfhty71Xg4QtLYBE43EtRLc
         wKnZ+GdoGFpXu5v5Ck0i9F4pX6cVR74rzelsYIrVTwfbICDYXyS1ftn48FwKMn5AVpe8
         b6Mr0g1Wq9cEpRuvSATC+Od1h7nxufw2pawV4p4Jt05UoclsnL0x4kmp0tMwPIWG/e09
         z9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513705; x=1703118505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOSXxu0Ty5SRYxvtBv47EJc9VazQTq5FR1JKdC1EXXI=;
        b=e65krjGPpSklgVD2uouGKZY55A3HH7Ea+S6jECduAMruHwE56KQ0H7SrZtKmPY7zp4
         ed+Sh7QR3KGJfR9zhAySC3opOHN2qyCu9d3tijI5dAqcol8pWQsvwNOj5u+49suhh5NZ
         rTxAHcgHJiu3kbY8/iIcAcAyh5yFIyRnA+S1Iyz59Tr9B858BqEXfySrpBIgKxcU9mw7
         7L7pfeouV67Z637gdAAn0M1zQ3hc0NUK4+QF2KePfhUqBVCwVZitxUAeN5hw9G5M70En
         uuv/P8TT7F1hpyK41M6ZS0Q1cnKFVXTKrb+J3lTcNsHC1QG6ovoj9Zb+2/rEPIhWvvDr
         //Lg==
X-Gm-Message-State: AOJu0YyGlcW1JlFR8ruBEBh9XC1QYY4lnfmIzSSj7eRw75uSR+rcesgo
        6GwRfUfacb+YzHnDXQP5c/EB2wLdJAUzG/4UHztFRvz68yk=
X-Google-Smtp-Source: AGHT+IHuxrOR2RIzgNSFCxEWboJMMjmHD7ppE3QLpc5tJ6emMuXh2ut+6Ofzb0AHwCe/jRYRvWJa70U8yx6St+i+tjo=
X-Received: by 2002:a05:6e02:1c4d:b0:35f:7629:87d3 with SMTP id
 d13-20020a056e021c4d00b0035f762987d3mr1990455ilg.43.1702513704644; Wed, 13
 Dec 2023 16:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20231211052850.3513230-1-debug.penguin32@gmail.com>
 <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com> <CALk6Uxog_LLF2dec2J54baMfee8jCOEabjWLG6-L=FEyZ-FFBQ@mail.gmail.com>
In-Reply-To: <CALk6Uxog_LLF2dec2J54baMfee8jCOEabjWLG6-L=FEyZ-FFBQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 13 Dec 2023 16:28:13 -0800
Message-ID: <CAKEwX=OwFk7aL-PGE4JBR0qy5NzbDbSmPGyu8yd7FK+yU8mRBg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     sjenning@redhat.com, akpm@linux-foundation.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 13, 2023 at 5:20=E2=80=AFAM Ronald Monthero
<debug.penguin32@gmail.com> wrote:
>
> Hi Nhat,
> Thanks for checking.
> On Tue, Dec 12, 2023 at 12:16=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > On Sun, Dec 10, 2023 at 9:31=E2=80=AFPM Ronald Monthero
> > <debug.penguin32@gmail.com> wrote:
> > >
> > > Use alloc_workqueue() to create and set finer
> > > work item attributes instead of create_workqueue()
> > > which is to be deprecated.
> > >
> > > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > > ---
> > >  mm/zswap.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 74411dfdad92..64dbe3e944a2 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> > >                 zswap_enabled =3D false;
> > >         }
> > >
> > > -       shrink_wq =3D create_workqueue("zswap-shrink");
> > > +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> > > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 0);
> >
> > Hmmm this changes the current behavior a bit right? create_workqueue()
> > is currently defined as:
> >
> > alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
>
> create_workqueue is deprecated and it's observed that most of the
> subsystems have changed to using alloc_workqueue. So it's a small
> minority of few remnant instances in the kernel and some drivers still
> using create_workqueue. With the create_workqueue defined as is , it
> hardcodes the workqueue  flags to be per cpu and unbound in nature and
> not giving the flexibility of using any other wait queue
> flags/attributes. ( WQ_CPU_INTENSIVE, WQ_HIGHPRI, WQ_RESCUER,
> WQ_FREEZEABLE, WQ_UNBOUND) . Hence most of the subsystems and drivers
> use the alloc_workqueue( ) api.
> #define create_workqueue(name) \
> alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
>
> > I think this should be noted in the changelog, at the very least, even
> > if it is fine. We should be as explicit as possible about behavior
> > changes.
> >
> imo, it's sort of known and consistently changed for quite some time alre=
ady.
> https://lists.openwall.net/linux-kernel/2016/06/07/1086
> https://lists.openwall.net/linux-kernel/2011/01/03/124
> https://lwn.net/Articles/403891/   =3D> quoted: "The long-term plan, it
> seems, is to convert all create_workqueue() users over to an
> appropriate alloc_workqueue() call; eventually create_workqueue() will
> be removed"
>
> glad to take some suggestions , thoughts ?
>
> BR,
> ronald

I should have been clearer. I'm not against the change per-se - I
agree that we should replace create_workqueue() with
alloc_workqueue(). What I meant was, IIUC, there are two behavioral
changes with this new workqueue creation:

a) We're replacing a bounded workqueue (which as you noted, is fixed
by create_workqueue()) with an unbounded one (WQ_UNBOUND). This seems
fine to me - I doubt locality buys us much here.

b) create_workqueue() limits the number of concurrent per-cpu
execution contexts at 1 (i.e only one single global reclaimer),
whereas after this patch this is set to the default value. This seems
fine to me too - I don't remember us taking advantage of the previous
concurrency limitation. Also, in practice, the task_struct is
one-to-one with the zswap_pool's anyway, and most of the time, there
is just a single pool being used. (But it begs the question - what's
the point of using 0 instead of 1 here?)

Both seem fine (to me anyway - other reviewers feel free to take a
look and fact-check everything). I just feel like this should be
explicitly noted in the changelog, IMHO, in case we are mistaken and
need to revisit this :) Either way, not a NACK from me.
