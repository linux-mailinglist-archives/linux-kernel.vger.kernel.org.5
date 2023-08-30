Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88278DFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjH3TH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbjH3Lst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8DB1BB;
        Wed, 30 Aug 2023 04:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82F96121B;
        Wed, 30 Aug 2023 11:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24904C43391;
        Wed, 30 Aug 2023 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693396125;
        bh=rLzY3U4dSKcTj+hM5hInq9qrw2+H+JtUqJlEfdjyIhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rsKAiE+MotO6gcLZZatGtw9dIV+Tw+zGadFx8/KIqwAPRKOymrFaKb3KxoEz8TPPq
         4RNjYUa0kWGc2OEMFCbVDP5lWBKk+V1tN+7Z444sq9ZZyaHC9BCZ80xKi/fLeL5BLA
         xH7rIZZNfdpaYkOStNdRLQKjKWXPn+/YIzg7d8/KfwKp46mnRAHOj2OLW8KDbt/vYs
         cJG7GhXChZpNVoYhWm94gC/BBIwfS4U3mLO3s+Nv+z3k/GuAAVadGPRUxhkSdbz4jk
         GmjH/HwAjrkp34Yk3DyU89pmpr/4zb5gMXnyerfTlRrMpGLkNsEsRYD9nG9LV4CHNK
         jrvBaNI7rgWqw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a85b1b7574so3649457b6e.2;
        Wed, 30 Aug 2023 04:48:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YxMqSMdwRQl3WRYfOFIIZnXFtsWPIUMU1rnzLXOhWWET27s/b1X
        uS7Lf6zdAdRheZzYg5+w/iLKpc5dHaCmbT/rHq0=
X-Google-Smtp-Source: AGHT+IErT0a1cgSxAfu4qJh2xExngZ1WgT0zI1RVK8uIMo5ELnnApfUWBoxN3IA1BlFuhqFihKg3Ohycx+BGfwrvXiA=
X-Received: by 2002:a05:6808:1923:b0:3a4:6a:6363 with SMTP id
 bf35-20020a056808192300b003a4006a6363mr2561439oib.14.1693396124374; Wed, 30
 Aug 2023 04:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230829105106.1277-1-jirislaby@kernel.org> <0d86668f-4f48-cd21-b891-443e99c5c86a@kernel.org>
In-Reply-To: <0d86668f-4f48-cd21-b891-443e99c5c86a@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 30 Aug 2023 20:48:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzy4Xb1s7srS=n7bEbqHXajKR44eCh6MR5Lfwz9oTfMQ@mail.gmail.com>
Message-ID: <CAK7LNATzy4Xb1s7srS=n7bEbqHXajKR44eCh6MR5Lfwz9oTfMQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: dummy-tools: support make MPROFILE_KERNEL checks
 work on BE
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 2:00=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> I deleted too few: the subject should read:
> kbuild: dummy-tools: make MPROFILE_KERNEL checks work on BE
>
> I will submit v2 if there are no other objections.


I have no objection.

If there is nothing else to fix,
I will locally fix the subject, and apply.


I also see a similar patch from Michal Suchanek,
but I like this one because the commit log
has a good explanation.



> On 29. 08. 23, 12:51, Jiri Slaby (SUSE) wrote:
> > From: Jiri Slaby <jslaby@suse.cz>
> >
> > Commit 2eab791f940b ("kbuild: dummy-tools: support MPROFILE_KERNEL
> > checks for ppc") added support for ppc64le's checks for
> > -mprofile-kernel.
> >
> > Now, commit aec0ba7472a7 ("powerpc/64: Use -mprofile-kernel for big
> > endian ELFv2 kernels") added support for -mprofile-kernel even on
> > big-endian ppc.
> >
> > So lift the check in gcc-check-mprofile-kernel.sh to support big-endian=
 too.
> >
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Michal Kubecek <mkubecek@suse.cz>
> > ---
> >   scripts/dummy-tools/gcc | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> > index 1db1889f6d81..07f6dc4c5cf6 100755
> > --- a/scripts/dummy-tools/gcc
> > +++ b/scripts/dummy-tools/gcc
> > @@ -85,8 +85,7 @@ if arg_contain -S "$@"; then
> >       fi
> >
> >       # For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> > -     if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
> > -             arg_contain -mprofile-kernel "$@"; then
> > +     if arg_contain -m64 "$@" && arg_contain -mprofile-kernel "$@"; th=
en
> >               if ! test -t 0 && ! grep -q notrace; then
> >                       echo "_mcount"
> >               fi
>
> --
> js
> suse labs
>


--=20
Best Regards
Masahiro Yamada
