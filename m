Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12AE76FDA0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjHDJmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHDJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:42:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C430F8;
        Fri,  4 Aug 2023 02:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919B561F79;
        Fri,  4 Aug 2023 09:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC527C433C8;
        Fri,  4 Aug 2023 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691142152;
        bh=LxB1A3SflD2/rcpnjLAWUeMaCaz16ieR3+UC//gBZww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mt+c3wcn70Zldr8Gdi39eM6ykm4zIjUy9QAm9lRpy+B4zzBGUHkvIDqixv/6ZAkIe
         sD1vuXJxW/NHCqb9t1Buwtd0L4Rbij3sjx0dYCqKT4hLmsTlhn7qJbDVcEC6uQD4Ih
         wxz8wKeQhHWbHbV5sBPjmxBAajbimujuBWXBWN7s6fTPgfLfHloWUwQz2HwmiPiR7D
         +6ea6qmHMLgumwzv6EJKI2yx+zWGy0vA4x5/6L2khmjSIxBUMaUDeDuj8rZIN5vzZB
         bmyz+j56wTIa1SabTxbx4RXnZMz+n2Amf8saWus1UoBHWplsL/Y/MUGR6EYg616DsS
         Scd+7/ArbQSmQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1bed90ee8b7so1147996fac.0;
        Fri, 04 Aug 2023 02:42:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywo5aq3EtUQnaWP6d8OJJpayGZgODukPJ6+zNelX/tvej+beePx
        r7W92phioq+dvHaLzx6zCBYQu7qrfS1DdGGITU4=
X-Google-Smtp-Source: AGHT+IHRnNseIsFg7KvfjwUtSQb1tNdZTYfuSLHkn5ovbA6p/pkU61Fm+hGm6tYwfEycpSCl0Tn8BOndSM3U0/8P3IA=
X-Received: by 2002:a05:6870:4710:b0:1b3:8fed:c4a0 with SMTP id
 b16-20020a056870471000b001b38fedc4a0mr1076875oaq.1.1691142151121; Fri, 04 Aug
 2023 02:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230803090711.2261876-1-linux@rasmusvillemoes.dk> <2023080302-theology-custody-670b@gregkh>
In-Reply-To: <2023080302-theology-custody-670b@gregkh>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 4 Aug 2023 18:41:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPTwmnTO-saaGo4nnc7HXK44qQihRK+EqovK=qFT8zPg@mail.gmail.com>
Message-ID: <CAK7LNARPTwmnTO-saaGo4nnc7HXK44qQihRK+EqovK=qFT8zPg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: changes.rst: add entry for git
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 7:19=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Aug 03, 2023 at 11:07:10AM +0200, Rasmus Villemoes wrote:
> > git is obviously used for development, directly and also
> > indirectly (via checkpatch, get_maintainer and other helper
> > scripts). But it is also invoked during the build to produce the
> > `uname -r` string.
> >
> > It's useful to have some minimal git version one can expect people to
> > use. For now, set a somewhat conservative minimum of 1.8.0, which is
> > already more then ten years old.
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  Documentation/process/changes.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/=
changes.rst
> > index 5561dae94f85..a82c619f4bb2 100644
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-build =
--version
> >  cpio                   any              cpio --version
> >  GNU tar                1.28             tar --version
> >  gtags (optional)       6.6.5            gtags --version
> > +git                    1.8.0            git --version
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >  .. [#f1] Sphinx is needed only to build the Kernel documentation
> > @@ -189,6 +190,13 @@ The kernel build requires GNU GLOBAL version 6.6.5=
 or later to generate
> >  tag files through ``make gtags``.  This is due to its use of the gtags
> >  ``-C (--directory)`` flag.
> >
> > +git
> > +---
> > +
> > +When building with CONFIG_LOCALVERSION_AUTO=3Dy, the build system uses
> > +git to produce a version string of the form
> > +6.4.6-00128-gd78b7f406397, which will be shown e.g. by running `uname =
-r`.
>
> Isn't this optional?  If git is not installed it just will not use git
> to determine the local version.

Right.
Without git, the suffix "-00128-gd78b7f406397" is not
appended, but you can build the kernel.


>
> So you should put "(optional)" above on the list of tools.
>
> And also, don't pick a specific version like this unless it is that way
> for a reason.  Why not pick a newer one?  Or the last one that the local
> version script can handle properly?



CentOS 7 (plans to retire in 2024) unfortunately
uses a ten-year-old git version.

In CentOS 7,

$ git --version
git version 1.8.3.1



Tagger: Junio C Hamano <gitster@pobox.com>
Date:   Mon Jun 10 12:34:56 2013 -0700

Git 1.8.3.1





If we are allowed to abandon conservative distros,
I prefer git >=3D 2.14.0

That supports 'git status --no-optional-locks'



--=20
Best Regards
Masahiro Yamada
