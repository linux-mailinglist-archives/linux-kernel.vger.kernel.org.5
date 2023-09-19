Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C17A57A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjISDCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjISDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:02:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE895;
        Mon, 18 Sep 2023 20:02:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c012573498so22752251fa.2;
        Mon, 18 Sep 2023 20:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695092525; x=1695697325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6jZCjLhiHuYsbpaMoawt7/mepZO3oZhk8mBqHjvEbY=;
        b=AZ6HY/O7W2CKml6NAzpGmJeWhpLYdH/FOyiqbbuGsXW8Sr97QOYU3bKQQtpDmPNyJ/
         ezVTxWnBXdxg8gtSxKLfWZdrSiMi31fjCY5ZDbWmEZRO+p6e7KaU2XMQPeBszgcOHI3c
         votMyAAPUxXVUdYQRb58gG1DUWMUh78bM70cT87jeZRFJzs/zwugxz3TB8ZQ0gYE88ng
         ZLoaCTvL/sIKT3iDQG9dk1H3vX9fogTBaEtnUMilsGK2HpAwgVlvvtuotAZZNvf1vSUg
         Oq43c9TaF8eodZiLQWrtTLrqYnsa0UQ4eTRj1hJIAZMkXGrgqVGH7MAvmrfZKtlwHrSa
         aTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695092525; x=1695697325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6jZCjLhiHuYsbpaMoawt7/mepZO3oZhk8mBqHjvEbY=;
        b=ZMZ0uXfNN3uwvMj+uJHTHgy3Snk1bUSggdDrEa5x3ByLdtu1S+fVApskHQUfAqlQjO
         9BqWwtJkJx4L3rGdnv3h4RiAnX9r1sVK6YZBirBf336i2LTa9dyG72U8QMx62ZILpS5v
         CiWBsrWeiJpPIx3ytGH3YwgGh2Y6ApSpGpI4e3UW1C/W3X15UreSJF2NjxMgcFOlyg5K
         WVS1ZjEp2RDR8TA4iPNAgINJ8/zRxSREh6VD83WemkA2Qc3/EFBo40oXkYxFftf+QngL
         7Qq6SYyoAmmrGTCvV1BWj+RPnR1jopNh7Lry3lPIxYFqiS+NFMMjykeVwFo2A9Z1H52E
         Ftnw==
X-Gm-Message-State: AOJu0YzwpmoTZxWRF/ssfEyYEKvDnttkuFMxu3FVbXohmELmlqlKcCy6
        8D4BGBY8Z2Z2rrRzta2oR6iFrLkRF12BbSZxxNw=
X-Google-Smtp-Source: AGHT+IF37DAV2Mqz9FnqxAWHK7EGAa/NKq+ccnIaLSbDz84sZOvvBr7ZXjvVMASO7EaGdS08ISvcVwDwTU/vrsJ33AE=
X-Received: by 2002:a2e:bc14:0:b0:2bf:ee57:f18 with SMTP id
 b20-20020a2ebc14000000b002bfee570f18mr8822031ljf.16.1695092524723; Mon, 18
 Sep 2023 20:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
In-Reply-To: <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 18 Sep 2023 22:01:53 -0500
Message-ID: <CAH2r5mssa12aGh+xvzKZVVTqsBz2Ku88PY8n+ntRnVz_waTURw@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Brian Pardy <brian.pardy@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Steve French <sfrench@samba.org>
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

> I'm not clear on the value or necessity of this "laundromat thread"

This thread is used to clean up cached directories when directory
leases are supported (in those cases directory contents, and
information needed for revalidate of directory paths can be cached
safely).

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
