Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EDB7A579E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjISDBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjISDA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:00:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0CC10E;
        Mon, 18 Sep 2023 20:00:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50300e9e75bso4327362e87.1;
        Mon, 18 Sep 2023 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695092443; x=1695697243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQPsynM6R2ixtC19ozrB1TNJHFIvPl8x0SLoxOWlNjY=;
        b=kNwHngh38YWGFkLIcLpOVV2+LZTDVMorwdlczm9zsFi/VO01W0WFta+TwfKf8PsWHK
         hUCv6jgacWw4YIEL/fXUdr7SnGzJQcGW6rmq9A5rykdM+P7yWrMLuDlEkl0hllM6/MM8
         iN0GZOW6j4VwWuDTg+BIKeN+5T1g/ueUg66akWMrSpXX6gwq3thrIJyzKYRWCnPbmmBj
         yCG5BwFthUIkR8IX33Lc3EK2m4/ngq6sl6V1WnBLALSYKZtMbRkdhs0NDaaaXkJbkAxX
         RfCkBASPhKj09mnCkn69l15b1jRAAy0KINb/a8HMJSrEePQ0VezUlqEtfrfXpgF+s6d8
         NZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695092443; x=1695697243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQPsynM6R2ixtC19ozrB1TNJHFIvPl8x0SLoxOWlNjY=;
        b=cDbT7WI1gJrWwNtWkRBNHFT2dM7H5B6INwmEyDBFHui2HGqWhcBGnQilyBdaw52mwW
         LkFcU4p9eZ5mI7grtzXjwZxWxEu0V1X9G3F9NkqMyJsmKQemP9QgPDRxAQhoZOO10ZmO
         W8iQRvGpzeOa22ptFKba375+PKCKMIwU4T7Jo8ZoVQDXswVy5Ona4YCeOdGtMMb1+GpR
         KIdo3OxUuYCI/ul5xm9chcHss2noAY3UtKYYc384I2vdxmvGOd535G5uq+0LIrj/gqBv
         k9PEP9LB2DnTz3QCjalF9FEwpZKas62JBgK40xTkwhLovKFFcxi9Lv5DYFHcn5Tw37wT
         kK2w==
X-Gm-Message-State: AOJu0YwgDTe+vGRQVnCltgc5e/iYBejBLYDT/hers2WgEx5MyEwnCILg
        40ptKWIonwteVHjla+l8ydGgRnuJin0uvSTb1Bo=
X-Google-Smtp-Source: AGHT+IGlAOnCxGpp/hLOpHuYyGGKpGYpW05H5HJl9jbhGYgiEZGsLdOS8IPxbCkhQnT0SnZMoNPuLqYa7J3ux6BvvJE=
X-Received: by 2002:a05:6512:3055:b0:503:1722:9c5a with SMTP id
 b21-20020a056512305500b0050317229c5amr4187770lfb.3.1695092443021; Mon, 18 Sep
 2023 20:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
In-Reply-To: <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 18 Sep 2023 22:00:31 -0500
Message-ID: <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Brian Pardy <brian.pardy@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo and I were discussing the laundromat thread at the SMB3.1.1 test
event (at SDC this week) which is now going on - will let you know
what we find.

One obvious thing is that it probably isn't necessary for cases when
the server does not support directory leases, but we noticed another
problem as well.


On Mon, Sep 18, 2023 at 9:20=E2=80=AFPM Brian Pardy <brian.pardy@gmail.com>=
 wrote:
>
> [RS removed from CC due to bounce message]
>
> On Wed, Sep 6, 2023 at 5:03=E2=80=AFPM Brian Pardy <brian.pardy@gmail.com=
> wrote:
> > On Tue, Sep 5, 2023 at 9:01=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.=
com> wrote:
> > > Thanks for the regression report. But if you want to get it fixed,
> > > you have to do your part: perform bisection. See Documentation/admin-=
guide/bug-bisect.rst in the kernel sources for how to do that.
> > >
> > > Anyway, I'm adding it to regzbot:
> > >
> > > #regzbot ^introduced: v6.4..v6.5
> > > #regzbot title: incorrect CPU utilization report (multiplied) when mo=
unting CIFS
> >
> > Thank you for directing me to the bug-bisect documentation. Results bel=
ow:
> >
> > # git bisect bad
> > d14de8067e3f9653cdef5a094176d00f3260ab20 is the first bad commit
> > commit d14de8067e3f9653cdef5a094176d00f3260ab20
> > Author: Ronnie Sahlberg <lsahlber@redhat.com>
> > Date:   Thu Jul 6 12:32:24 2023 +1000
> >
> >     cifs: Add a laundromat thread for cached directories
> >
> >     and drop cached directories after 30 seconds
> >
> >     Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> >     Signed-off-by: Steve French <stfrench@microsoft.com>
> >
> >  fs/smb/client/cached_dir.c | 67 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/smb/client/cached_dir.h |  1 +
> >  2 files changed, 68 insertions(+)
>
> Is there any further information I can provide to aid in debugging
> this issue? Should I just expect incorrect load average reporting when
> a CIFS share is mounted on any kernel >6.5.0?
>
> I'm not clear on the value or necessity of this "laundromat thread" -
> everything worked as expected before it was added - shall I just patch
> it out of my kernel builds going forward if there is no interest in
> fixing it? Is a .config option to disable it possible?



--=20
Thanks,

Steve
