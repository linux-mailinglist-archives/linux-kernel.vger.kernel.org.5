Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6204479DD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbjIMA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjIMA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:58:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAC1706
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:58:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bfb1167277so10565801fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694566727; x=1695171527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feqfynssC/l//krhpjeeQ39GiVPgRYAKpHDqbOdbEAU=;
        b=OEHdTzLPOram8KFoXC811qW0K7SDLsLRVEArK+7Urj4DfL3miCn4B3B5AEFqDHiFTw
         ivXZClrypUmbFEFtHHknqqYt8ysevK6GCVg5A5wyIw5LHqYgFmWrEg0fH1RdrSbdvFJ8
         7E1/hmpV7WClkB1RkL3WarXKfAKlAjqlCzLp4u8keE4lcmq3VNN+dujPcuXEGBB8CbtH
         4B51l4XjXnnj54eA+57N3vQBpyERcu3u0cVH+ega6/zruVf7azOWicJUjvaalXORg+Jn
         IfxSSAoSEJ4Pj191BEL02GSu4QVoVNXwBaMyKpM+u5c/6UQNE2bIS9nvi7wcY6T3gd9a
         +VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694566727; x=1695171527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feqfynssC/l//krhpjeeQ39GiVPgRYAKpHDqbOdbEAU=;
        b=vhergcIoe4VrQQQe8fZpItP7TdzpIL8WX8mqukBf8opbf1cZohlGFIWbGBrwpX5F57
         DFGhWpETUrkayrBTg7i/PZq8/kTnsNMV+Z4+KOa/BpiI1NPzi4K7PHMCWT2HhjB45pD2
         XvKJr0AzALSBAlTTFWwJY5lKTXWyStHYAKvuA1iIcNfYGhH6etDbjK/s1mcXORHh3N4y
         yv/esj3roH5j/8dTPBYcUqgPqJGX50w1uHFelpyOplYA2FjSoayKdBLp6xsVpm/AIs6S
         J+rtGVhpIp+Ial1/pGVTL9+s6Cr6Yr8KPQpi65BFGpkHugWipMJ8cwnKILd0MGCc4o4i
         oBMg==
X-Gm-Message-State: AOJu0YyIcOAd0kvlB4a9fzpr0ayPfp9j1kscwiAvoeO+srE4/n+/lafy
        4fGs2Fqn7pxGJm/lblIPTmbnKRbhs/gewmmzsJq51A==
X-Google-Smtp-Source: AGHT+IEEI2mSwsVZy5CC5hwYoZfqkgLcgNSB0rgqxaqpKpUI9/IOltkOcuY2bxkgO23YTTFgTfB5BMEHLO4Jb0+ELe0=
X-Received: by 2002:a2e:8342:0:b0:2bd:d34:f892 with SMTP id
 l2-20020a2e8342000000b002bd0d34f892mr1155677ljh.3.1694566727074; Tue, 12 Sep
 2023 17:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com>
 <ZQEADYBl0uZ1nX60@mail.minyard.net> <CAFhGd8rst8gyJ1FVSsbOADt+h2ECwv7fqh_YNHmn6anV_zGC1A@mail.gmail.com>
In-Reply-To: <CAFhGd8rst8gyJ1FVSsbOADt+h2ECwv7fqh_YNHmn6anV_zGC1A@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 12 Sep 2023 17:58:36 -0700
Message-ID: <CAFhGd8qc8T3K44N3jUB1q3GmZULwrV+TU+h9SLKsPBq0x3FAGw@mail.gmail.com>
Subject: Re: [PATCH] ipmi: refactor deprecated strncpy
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 5:55=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Tue, Sep 12, 2023 at 5:19=E2=80=AFPM Corey Minyard <minyard@acm.org> w=
rote:
> >
> > On Tue, Sep 12, 2023 at 11:43:05PM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings=
 [1].
> > >
> > > In this case, strncpy is being used specifically for its NUL-padding
> > > behavior (and has been commented as such). We can use a more robust a=
nd
> > > less ambiguous interface in `strscpy_pad` which makes the code more
> > > readable and even eliminates the need for that comment.
> > >
> > > Let's also use `strnlen` instead of `strlen()` with an upper-bounds
> > > check as this is intrinsically a part of `strnlen`.
> > >
> > > Also included in this patch is a simple 1:1 change of `strncpy` to
> > > `strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then=
 we
> > > should opt again for `strscpy_pad`.
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strncpy-on-nul-terminated-strings [1]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > >  drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
> > >  drivers/char/ipmi/ipmi_ssif.c       |  2 +-
> > >  2 files changed, 4 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/=
ipmi_msghandler.c
> > > index 186f1fee7534..04f7622cb703 100644
> > > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > > @@ -5377,20 +5377,15 @@ static void send_panic_events(struct ipmi_smi=
 *intf, char *str)
> > >
> > >       j =3D 0;
> > >       while (*p) {
> > > -             int size =3D strlen(p);
> > > +             int size =3D strnlen(p, 11);
> > >
> > > -             if (size > 11)
> > > -                     size =3D 11;
> > >               data[0] =3D 0;
> > >               data[1] =3D 0;
> > >               data[2] =3D 0xf0; /* OEM event without timestamp. */
> > >               data[3] =3D intf->addrinfo[0].address;
> > >               data[4] =3D j++; /* sequence # */
> > > -             /*
> > > -              * Always give 11 bytes, so strncpy will fill
> > > -              * it with zeroes for me.
> > > -              */
> > > -             strncpy(data+5, p, 11);
> > > +
> > > +             strscpy_pad(data+5, p, 11);
> >
> > This is incorrect, the destination should *not* be nil terminated if th=
e
> > destination is full.  strncpy does exactly what is needed here.
>
> Could we use `memcpy_and_pad()` as this matches the behavior of
> strncpy in this case? I understand strncpy works here but I'm really
> keen on snuffing out all its uses -- treewide.

^ I mean something like the following:
|    memcpy_and_pad(data+5, 11, p, size, '\0');

as this is explicit in its behavior.

>
> >
> > A comment should be added here, this is not the first time this has bee=
n
> > brought up.
> >
> > >               p +=3D size;
> > >
> > >               ipmi_panic_request_and_wait(intf, &addr, &msg);
> > > diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_s=
sif.c
> > > index 3b921c78ba08..edcb83765dce 100644
> > > --- a/drivers/char/ipmi/ipmi_ssif.c
> > > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > > @@ -1940,7 +1940,7 @@ static int new_ssif_client(int addr, char *adap=
ter_name,
> > >               }
> > >       }
> > >
> > > -     strncpy(addr_info->binfo.type, DEVICE_NAME,
> > > +     strscpy(addr_info->binfo.type, DEVICE_NAME,
> > >               sizeof(addr_info->binfo.type));
> >
> > This one is good.
> >
> > -corey
> >
> > >       addr_info->binfo.addr =3D addr;
> > >       addr_info->binfo.platform_data =3D addr_info;
> > >
> > > ---
> > > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > > change-id: 20230912-strncpy-drivers-char-ipmi-ipmi-dda47b3773fd
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
