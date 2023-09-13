Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8A79DD44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjIMAzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjIMAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:55:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB910F6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:55:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so797282266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694566514; x=1695171314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o248tMa332dMkzE2O5OqudHGx+nnrOYejvQiKL4J6eU=;
        b=0+IJ1aJOkTiSHyi17qwQ3B3vUyijQJ7ELDkTCSDOJ2U8D2jjCOanWSVslbQkROlVnH
         6rRH/8trOlF2ABpx2O5AV4H+1EP7TOls5Zbg41aDw1iqnElD/eCXWnDUaL38z7sVxcOy
         Tdm8oxM0gmPnZUvXciftF8BdlJPvUqu6jLZ9DUUzC/Th1swQ7WO2PfrogSPDuoxzTu9y
         VPgpr0nZ/tAsXlm053KqplOILKx9cibwDiHip8atCnKDnHKGQb9M2DG1Q7fcTaZdc2Wl
         0Aip4aYuz25cWO2TqnSmVoyB5WTrg2vDEbDv8xVLN1ztiBiUrSbYMlcIGz38WZdQN+LK
         8w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694566514; x=1695171314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o248tMa332dMkzE2O5OqudHGx+nnrOYejvQiKL4J6eU=;
        b=jBZeWWUkC/h6/j/uxeS0GI+p1J17yOEI7xTeexFco12ZAesVYT2rw1Lra0nhnZV2FD
         4L45jEUrizOpRgKnanXRvcWv6NuHKpmGS0gvr5U17GzjqUX0TNDGTDyTkjkhQ+88RY65
         PP4TL8cax/NXfFDI3Hp/L9hr/fpnZXcgQEkB4MqJ9A4rhFyZQfZdxOv6V+BLC8YO6EYW
         nShpPyWC9LRT5WigRrqrABYtmNHaHxrqNIc7NJp/lMzXXVU51p2UsGsDNPZwebXUe402
         I+SumN5QSqhY2M9cfLbA9WMPUBHBnw5MbshJLfBFrEwGC5py8/sLYxFA6Cu8kpGqPTiW
         8T1w==
X-Gm-Message-State: AOJu0YzB94g+9VRDemB/3X+2fhu7j+8S1SX7cK0ANHiCSv3eDwjMwHQe
        ZfrY9JyI0DOXStWcthbjqRJ3wwU+xe+udLmldUyoCA==
X-Google-Smtp-Source: AGHT+IEFh5CSqCy6hjjItMyTZXxvitNpkbxyykzfBZoKrhKgNLvKyIwP7A9vI32UIWynY/wUCDXwURlBKgudDpLzKPE=
X-Received: by 2002:a17:906:9441:b0:9a1:f668:dae9 with SMTP id
 z1-20020a170906944100b009a1f668dae9mr647596ejx.33.1694566514000; Tue, 12 Sep
 2023 17:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com>
 <ZQEADYBl0uZ1nX60@mail.minyard.net>
In-Reply-To: <ZQEADYBl0uZ1nX60@mail.minyard.net>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 12 Sep 2023 17:55:02 -0700
Message-ID: <CAFhGd8rst8gyJ1FVSsbOADt+h2ECwv7fqh_YNHmn6anV_zGC1A@mail.gmail.com>
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

On Tue, Sep 12, 2023 at 5:19=E2=80=AFPM Corey Minyard <minyard@acm.org> wro=
te:
>
> On Tue, Sep 12, 2023 at 11:43:05PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > In this case, strncpy is being used specifically for its NUL-padding
> > behavior (and has been commented as such). We can use a more robust and
> > less ambiguous interface in `strscpy_pad` which makes the code more
> > readable and even eliminates the need for that comment.
> >
> > Let's also use `strnlen` instead of `strlen()` with an upper-bounds
> > check as this is intrinsically a part of `strnlen`.
> >
> > Also included in this patch is a simple 1:1 change of `strncpy` to
> > `strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then w=
e
> > should opt again for `strscpy_pad`.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
> >  drivers/char/ipmi/ipmi_ssif.c       |  2 +-
> >  2 files changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ip=
mi_msghandler.c
> > index 186f1fee7534..04f7622cb703 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -5377,20 +5377,15 @@ static void send_panic_events(struct ipmi_smi *=
intf, char *str)
> >
> >       j =3D 0;
> >       while (*p) {
> > -             int size =3D strlen(p);
> > +             int size =3D strnlen(p, 11);
> >
> > -             if (size > 11)
> > -                     size =3D 11;
> >               data[0] =3D 0;
> >               data[1] =3D 0;
> >               data[2] =3D 0xf0; /* OEM event without timestamp. */
> >               data[3] =3D intf->addrinfo[0].address;
> >               data[4] =3D j++; /* sequence # */
> > -             /*
> > -              * Always give 11 bytes, so strncpy will fill
> > -              * it with zeroes for me.
> > -              */
> > -             strncpy(data+5, p, 11);
> > +
> > +             strscpy_pad(data+5, p, 11);
>
> This is incorrect, the destination should *not* be nil terminated if the
> destination is full.  strncpy does exactly what is needed here.

Could we use `memcpy_and_pad()` as this matches the behavior of
strncpy in this case? I understand strncpy works here but I'm really
keen on snuffing out all its uses -- treewide.

>
> A comment should be added here, this is not the first time this has been
> brought up.
>
> >               p +=3D size;
> >
> >               ipmi_panic_request_and_wait(intf, &addr, &msg);
> > diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssi=
f.c
> > index 3b921c78ba08..edcb83765dce 100644
> > --- a/drivers/char/ipmi/ipmi_ssif.c
> > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > @@ -1940,7 +1940,7 @@ static int new_ssif_client(int addr, char *adapte=
r_name,
> >               }
> >       }
> >
> > -     strncpy(addr_info->binfo.type, DEVICE_NAME,
> > +     strscpy(addr_info->binfo.type, DEVICE_NAME,
> >               sizeof(addr_info->binfo.type));
>
> This one is good.
>
> -corey
>
> >       addr_info->binfo.addr =3D addr;
> >       addr_info->binfo.platform_data =3D addr_info;
> >
> > ---
> > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > change-id: 20230912-strncpy-drivers-char-ipmi-ipmi-dda47b3773fd
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
