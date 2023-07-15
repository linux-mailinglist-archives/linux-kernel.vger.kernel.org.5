Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D29754716
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGOGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGOGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A6358E;
        Fri, 14 Jul 2023 23:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49FFC6092A;
        Sat, 15 Jul 2023 06:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7665C433C7;
        Sat, 15 Jul 2023 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689403046;
        bh=28KkXXydks0YVAuGGcxT7Uv8avQHc6CF+wMoi/BVCVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TRpQSythwInhINm81lMZh3cQi4rlZZAyk7pLJIXuQFNdtadJtYBaM8MW6brMm9Bj2
         52AXs3qLUk5PVZrAAS+IN8KVEPjWnv7364IdNxfsG/jkK7qz0GSmW051QaaZ4sUZPv
         wFcCOUXDLwA16ZVcyFyuSrLmqBnc2Af8uYSFusbmD9l4eG8OCLAajQrFbl1vrIjmpV
         M/wYLmA8E0WcYtWbSSAx8YHMOODK1NRjPyoLYPrgoXJVOwJOF4BZOVjuYTtWG1x3WS
         WCKD4HbF8kTeksLHGcp+RmhgN+GBd4f3/jtw+m60RRQ93e8QLQwl1GoMLTdpVcv0JJ
         cau2zFN2Uja7Q==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a3c78ede4bso2004188b6e.2;
        Fri, 14 Jul 2023 23:37:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLZriypHLL7pJwaVj5JvMQrHq7iXswv7TUMn5rPq5eKB67VfKrMW
        wShQtwhtOfuXnXnpDX+43r0s12GBP7S7IKjsFCY=
X-Google-Smtp-Source: APBJJlFp7nbzd8uDAVqcgzgy5GRnnYUdqE8yOpQlP+Z+az+qgEmTWQS1EB8pxuJCnpOMdHC+ZScm2Zm/lq9Bwa7mxB8=
X-Received: by 2002:a05:6808:1384:b0:3a4:1f76:bdfb with SMTP id
 c4-20020a056808138400b003a41f76bdfbmr7753259oiw.14.1689403045890; Fri, 14 Jul
 2023 23:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <4f414a87-0c54-44bd-b218-f6f0b22c57ef@p183> <ZLEmgxm73zzmffWD@fjasle.eu>
 <4dc7e56c-6692-4d4c-a8d2-05abe4501e66@p183> <ZLGiQxF5ffbWR7tR@fjasle.eu>
In-Reply-To: <ZLGiQxF5ffbWR7tR@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 15 Jul 2023 15:36:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMT_RfCw3_Tv7VzdYJJFitMqrDG95pWeUTpcMZEr2Txg@mail.gmail.com>
Message-ID: <CAK7LNARMT_RfCw3_Tv7VzdYJJFitMqrDG95pWeUTpcMZEr2Txg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: flatten KBUILD_CFLAGS
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 4:30=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Fri, Jul 14, 2023 at 08:45:00PM +0300 Alexey Dobriyan wrote:
> > On Fri, Jul 14, 2023 at 12:42:11PM +0200, Nicolas Schier wrote:
> > > On Thu, Jul 13, 2023 at 09:52:28PM +0300, Alexey Dobriyan wrote:
> > > > Make it slightly easier to see which compiler options are added and
> > > > removed (and not worry about column limit too!).
> > > >
> > > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > > ---
> > > >
> > > >  Makefile |   22 +++++++++++++++++-----
> > > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > > >
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -555,11 +555,23 @@ LINUXINCLUDE    :=3D \
> > > >           $(USERINCLUDE)
> > > >
> > > >  KBUILD_AFLAGS   :=3D -D__ASSEMBLY__ -fno-PIE
> > > > -KBUILD_CFLAGS   :=3D -Wall -Wundef -Werror=3Dstrict-prototypes -Wn=
o-trigraphs \
> > > > -            -fno-strict-aliasing -fno-common -fshort-wchar -fno-PI=
E \
> > > > -            -Werror=3Dimplicit-function-declaration -Werror=3Dimpl=
icit-int \
> > > > -            -Werror=3Dreturn-type -Wno-format-security -funsigned-=
char \
> > > > -            -std=3Dgnu11
> > > > +
> > > > +KBUILD_CFLAGS :=3D
> > > > +KBUILD_CFLAGS +=3D -std=3Dgnu11
> > >
> > > If you want to put -std at top, on contrast to the sorted options bel=
ow,
> > > you could also merge the two lines above.
> >
> > I don't know. Standard choice is arguably the most important option
> > so I put it first.
>
> yes, I think I would have put it on top, too.  I just would write it this=
 way:
>
>     KBUILD_CFLAGS :=3D -std=3Dgnu11
>
>     KBUILD_CFLAGS +=3D ...
>
> But it is bike-shedding, ignore it if you're not convinced.
>
> Kind regards,
> Nicolas





Starting line 813, we have more and more
"KBUILD_CFLAGS +=3D" lines.


I thought we perhaps could merge them in a single place.
(but "KBUILD_CFLAGS :=3D " still must come before "export KBUILD_CFLAGS")


[move everything to line 813]

KBUILD_CFLAGS +=3D -std=3Dgnu11
KBUILD_CFLAGS +=3D -fshort-wchar
KBUILD_CFLAGS +=3D -funsigned-char
KBUILD_CFLAGS +=3D -fno-common
KBUILD_CFLAGS +=3D -fno-PIE
KBUILD_CFLAGS +=3D -fno-strict-aliasing
KBUILD_CFLAGS +=3D -Wall
KBUILD_CFLAGS +=3D -Wundef
KBUILD_CFLAGS +=3D -Werror=3Dimplicit-function-declaration
KBUILD_CFLAGS +=3D -Werror=3Dimplicit-int
KBUILD_CFLAGS +=3D -Werror=3Dreturn-type
KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes
KBUILD_CFLAGS +=3D -Wno-format-security
KBUILD_CFLAGS +=3D -Wno-trigraphs
KBUILD_CFLAGS +=3D -fno-delete-null-pointer-checks
KBUILD_CFLAGS +=3D $(call cc-disable-warning,frame-address,)
KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-truncation)
KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-overflow)
KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member)
 ...




That will change the order of compiler options
because they cross line 760

  include $(srctree)/arch/$(SRCARCH)/Makefile


So, I think the patch is fine if we try to be safe.



--=20
Best Regards
Masahiro Yamada
