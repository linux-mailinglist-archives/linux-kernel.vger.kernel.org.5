Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10D7774B08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjHHUjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjHHUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:38:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA3182E99
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:29:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5234dee9a44so366231a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515751; x=1692120551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRTbpdHAIcRAL+8fbnX37iDC0EoRIyOQNOdvRt+62Lw=;
        b=DjSyFc466XoPSs0e4ymkKPotfNOOJUf3A/2g6OKlGaTDH+SXaR4NO50LD/IYycgHTF
         N9mN3rzd3YJmnjIv9fJ5OgRtc6kekPPBeKf5DMt9ndXAndHPlyx/cUClBh6XFMRqqLje
         AM2jZaunxmXmUQM4lwfPzIKrvE0WXYl+0S7o3dRSIuANPYbwqYWHil6HtsQn9VYH7z80
         /G0LjfAYWzzjZObiVaDalPjtPAeu+o2LKeE89g9rgNT2fHXdXNCdEiLeH3H8OCOn7AmE
         Mtg5LGfxbYIUcT9VxoaxHAfC2AgSsv8kfzMZwyezLYE9MzugxFsDembayZDf9GZE79pr
         IKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515751; x=1692120551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRTbpdHAIcRAL+8fbnX37iDC0EoRIyOQNOdvRt+62Lw=;
        b=Z7w2r3urNWGa/doiwO9/vdK8ZcaipGaRmxCt6DalX1nY/xUATSjSA30dFs0FxB9cW8
         oKHkp5aKGQIEPvUZFH4tLarjo6aUMdEOHQ8Xhfl5JjfKpvsmLg1nwF2dUJPOio5rNCTf
         yzzPkBY65k43QhypkifFwgXlW8HK5OAUNdwDGY+5TVdok2V1H7gTp21/EQBn6DHvygK4
         XH2wHP1y/2GPcDIP1IvAxkY62vGptNZSGAwOM1nGcG77lMbsoQ654uxBkEYNM9N3dytF
         t5PicAoolfQV3o7ob/0D8q403IHBRrD+iDyBuFwcjFlYdACyWlbH4IKJwfic2qB3lCKc
         c8xQ==
X-Gm-Message-State: AOJu0YyUlQiO8+vysIGVErDUu1AoSAf1Cy4B7/IP5WiR3aKVbl734zrs
        /aj3JyUzkdLKxjrlk6d8js/l8bjJDewQPXG7xgR0Og==
X-Google-Smtp-Source: AGHT+IEj9jsvS5MROtkM+IvgsvU8cU1CnN/c3z5EIcbbMeYA6EJeqykx7Eu9avENEdzUbqBt4ia3FKkcPXu7iENsbGg=
X-Received: by 2002:aa7:d84b:0:b0:523:366b:9cb4 with SMTP id
 f11-20020aa7d84b000000b00523366b9cb4mr459388eds.1.1691515751068; Tue, 08 Aug
 2023 10:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
 <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com> <202308071636.AF290F0@keescook>
In-Reply-To: <202308071636.AF290F0@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 8 Aug 2023 10:28:57 -0700
Message-ID: <CAFhGd8oSGJ5=fk58wOSgbuXX_VaP14q0Re=Xfom=rdOR6fT1rQ@mail.gmail.com>
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
To:     Kees Cook <keescook@chromium.org>
Cc:     Bill Wendling <morbo@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:40=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Mon, Aug 07, 2023 at 03:36:55PM -0700, Bill Wendling wrote:
> > On Mon, Aug 7, 2023 at 2:18=E2=80=AFPM Justin Stitt <justinstitt@google=
.com> wrote:
> > >
> > > Use `strtomem` here since `console_buf` is not expected to be
> > > NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
>
> How is it known that console_buf is not a C-string?
There are a few clues that led me to believe console_buf was not a C-string=
:
1)  `n =3D min((size_t) len, ARRAY_SIZE(console_buf));` means that `n`
can be equal to size of buffer which is then subsequently filled
entirely by the `strncpy` invocation.
2) console_buf looks to be a circular buffer wherein once it's filled
it starts again from the beginning.
3) ARRAY_SIZE is used on it as opposed to strlen or something like
that (but not sure if ARRAY_SIZE is also used on C-strings to be fair)
4) It has `buf` in its name which I loosely associate with non
C-strings char buffers.

All in all, it looks to be a non C-string but honestly it's hard to
tell, especially since if it IS a C-string the previous implementation
had some bugs with strncpy I believe.

>
> > > instead of using `ARRAY_SIZE()` for every iteration of the loop.
> > >
> > Is this change necessary? I have a general preference for ARRAY_SIZE,
> > because a change in size is less likely to be overlooked (unless that
> > goes against the coding standard).
>
> I would prefer this stay either ARRAY_SIZE or sizeof, as it keeps it
> tied to the variable in question.
>
> >
> > > Also mark char buffer as `__nonstring` as per Kees' suggestion here [=
1]
> > >
> > > Finally, follow checkpatch's recommendation of using `min_t` over `mi=
n`
> > >
> > > Link: https://github.com/KSPP/linux/issues/90 [1]
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Notes:
> > > I only build tested this patch.
> > > ---
> > >  arch/um/drivers/mconsole_kern.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconso=
le_kern.c
> > > index 5026e7b9adfe..fd4c024202ae 100644
> > > --- a/arch/um/drivers/mconsole_kern.c
> > > +++ b/arch/um/drivers/mconsole_kern.c
> > > @@ -4,6 +4,7 @@
> > >   * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.=
com)
> > >   */
> > >
> > > +#include "linux/compiler_attributes.h"
> >
> > nit: Should this include be in angle brackets?
> >
> > #include <linux/compiler_attributes.h>
>
> True, though this shouldn't need to be included at all. What was
> missing?
>
> >
> > >  #include <linux/console.h>
> > >  #include <linux/ctype.h>
> > >  #include <linux/string.h>
> > > @@ -554,7 +555,7 @@ struct mconsole_output {
> > >
> > >  static DEFINE_SPINLOCK(client_lock);
> > >  static LIST_HEAD(clients);
> > > -static char console_buf[MCONSOLE_MAX_DATA];
> > > +static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
> > >
> > >  static void console_write(struct console *console, const char *strin=
g,
> > >                           unsigned int len)
> > > @@ -566,8 +567,8 @@ static void console_write(struct console *console=
, const char *string,
> > >                 return;
> > >
> > >         while (len > 0) {
> > > -               n =3D min((size_t) len, ARRAY_SIZE(console_buf));
> > > -               strncpy(console_buf, string, n);
> > > +               n =3D min_t(size_t, len, MCONSOLE_MAX_DATA);
> > > +               strtomem(console_buf, string);
> > >                 string +=3D n;
> > >                 len -=3D n;
> > >
> > >
> > > ---
> > > base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> > > change-id: 20230807-arch-um-3ef24413427e
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
>
> --
> Kees Cook
