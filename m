Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F9770EA4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHEIDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHEIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A2E6A;
        Sat,  5 Aug 2023 01:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D5A60B86;
        Sat,  5 Aug 2023 08:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987A7C433C9;
        Sat,  5 Aug 2023 08:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691222598;
        bh=z4y+rgOgdY6FH4pa9QhBqoCRDWTfa8+Hog0vXTSom78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RLRh/rAY+SHTQa4YYmwXlEHKXEul8J60QJ4Ijzf9A55bd4sQvIsOaVdqHn+XrtsRl
         3UuHsGEUrrqH0jGdODCFjQNJ3ll2VYw4ka1iwRQnSQQ77pjfq/xJwejo4Xmpxt4xqu
         ukm0PljctxGq197lChQhZLYISoUc1iRvCTtb4CDoy64etE8vUvzOiqBmJN5+Wug3CF
         a2nHF+Uq6a6G//x6GzSRDJsv/zxQip+PrNj4Yg7eN/D/dcBNwdLlEt/P5W48iUozRf
         reboNH3M7ZJeWJAaFa/a7u9ui/mH4dN39IzYqQagSxzC3+hjywkgdPgoxxuEVZnQl+
         RWGeEH8/gYsRg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56ce156bd37so1964968eaf.3;
        Sat, 05 Aug 2023 01:03:18 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzn40wNzy3jW2fipoud6enPzV0pYVEWRRYejPLzaDtS//V2dZaW
        zdRxFlbA3Iz7nQ0HjiVhr0THvnFjm85FF8N2ZJk=
X-Google-Smtp-Source: AGHT+IEeV7O6jDsizVcznrnhtT771Y8XeoAdJv2NNvk27Tc6Np+lW0AMubDCEMM4cXer1x0mmTZCZtclkcBplK0B3Gw=
X-Received: by 2002:a4a:d1d6:0:b0:566:f5bb:7d40 with SMTP id
 a22-20020a4ad1d6000000b00566f5bb7d40mr4292320oos.6.1691222597869; Sat, 05 Aug
 2023 01:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230803090711.2261876-1-linux@rasmusvillemoes.dk>
 <2023080302-theology-custody-670b@gregkh> <CAK7LNARPTwmnTO-saaGo4nnc7HXK44qQihRK+EqovK=qFT8zPg@mail.gmail.com>
 <2023080447-ahead-tannery-c77a@gregkh>
In-Reply-To: <2023080447-ahead-tannery-c77a@gregkh>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 5 Aug 2023 17:02:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdYRuvM8t8rr=DysC_wt2QbhWqaCwnNvkrSHb5c0HWMw@mail.gmail.com>
Message-ID: <CAK7LNAQdYRuvM8t8rr=DysC_wt2QbhWqaCwnNvkrSHb5c0HWMw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: changes.rst: add entry for git
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 7:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Aug 04, 2023 at 06:41:54PM +0900, Masahiro Yamada wrote:
> > On Thu, Aug 3, 2023 at 7:19=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Aug 03, 2023 at 11:07:10AM +0200, Rasmus Villemoes wrote:
> > > > git is obviously used for development, directly and also
> > > > indirectly (via checkpatch, get_maintainer and other helper
> > > > scripts). But it is also invoked during the build to produce the
> > > > `uname -r` string.
> > > >
> > > > It's useful to have some minimal git version one can expect people =
to
> > > > use. For now, set a somewhat conservative minimum of 1.8.0, which i=
s
> > > > already more then ten years old.
> > > >
> > > > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > ---
> > > >  Documentation/process/changes.rst | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/Documentation/process/changes.rst b/Documentation/proc=
ess/changes.rst
> > > > index 5561dae94f85..a82c619f4bb2 100644
> > > > --- a/Documentation/process/changes.rst
> > > > +++ b/Documentation/process/changes.rst
> > > > @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-bu=
ild --version
> > > >  cpio                   any              cpio --version
> > > >  GNU tar                1.28             tar --version
> > > >  gtags (optional)       6.6.5            gtags --version
> > > > +git                    1.8.0            git --version
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > >
> > > >  .. [#f1] Sphinx is needed only to build the Kernel documentation
> > > > @@ -189,6 +190,13 @@ The kernel build requires GNU GLOBAL version 6=
.6.5 or later to generate
> > > >  tag files through ``make gtags``.  This is due to its use of the g=
tags
> > > >  ``-C (--directory)`` flag.
> > > >
> > > > +git
> > > > +---
> > > > +
> > > > +When building with CONFIG_LOCALVERSION_AUTO=3Dy, the build system =
uses
> > > > +git to produce a version string of the form
> > > > +6.4.6-00128-gd78b7f406397, which will be shown e.g. by running `un=
ame -r`.
> > >
> > > Isn't this optional?  If git is not installed it just will not use gi=
t
> > > to determine the local version.
> >
> > Right.
> > Without git, the suffix "-00128-gd78b7f406397" is not
> > appended, but you can build the kernel.
> >
> >
> > >
> > > So you should put "(optional)" above on the list of tools.
> > >
> > > And also, don't pick a specific version like this unless it is that w=
ay
> > > for a reason.  Why not pick a newer one?  Or the last one that the lo=
cal
> > > version script can handle properly?
> >
> >
> >
> > CentOS 7 (plans to retire in 2024) unfortunately
> > uses a ten-year-old git version.
> >
> > In CentOS 7,
> >
> > $ git --version
> > git version 1.8.3.1
>
> I doubt CentOS 7 can build a modern-day kernel anyway, so why is this a
> requirement?  We shouldn't be beholden to the necro-distros just because
> they have not moved into this decade :)



The default GCC on CentOS 7 is GCC 4.8,
which is too old to build the kernel.

I am not so sure how RHEL/CentOS 7 users are working
on the kernel development, but it is possible to
install a newer gcc version from Developer Toolset.


FWFW, this is how to set up GCC 11 on CentOS 7
so you can build the kernel.

# yum install centos-release-scl
# yum install devtoolset-11-gcc
$ PATH=3D/opt/rh/devtoolset-11/root/usr/bin:$PATH
$ gcc --version
gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.






Recently, I got a regression report on RHEL/CentOS 7.
So, some people might still care about this.





commit f5983dab0ead92dc2690d147f0604a0badcac6a8
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed Jun 28 01:32:05 2023 +0900

    modpost: define more R_ARM_* for old distributions

    On CentOS 7, the following build error occurs.








--=20
Best Regards
Masahiro Yamada
