Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB652754A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGORdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGORdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:33:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C801172C;
        Sat, 15 Jul 2023 10:33:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so2994608f8f.0;
        Sat, 15 Jul 2023 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689442419; x=1692034419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5lBpFjcCM8ICwBqvH4u5XdokFHe2AakZ8reWsweCKQ=;
        b=JPhW42vvXf0KAbwfNqd3hIpQQhdECfDll5zxT2xWwcLhGLMSw/lKt7c3Y5VKVoy9k5
         SjbmENMYNURFWsrv6SJba7MX3vDWTLP4CKpNRvqDuPUnISwMUSbSELT9eXP39fSG/RhA
         aTxDJ91WC77BZiGooEQgdHz6bFmY3lXPgoc/44Y6y5UMLe3AJoWpwC7knqFeN1fAK3Nw
         ucDso93hlHy1je/2Sh1PcoOWg93KbUY74wSNsjViQK7fJSb8dG73fbxsNmVLLooQ+/xS
         MedfCBRfcke09CN+QYrh3GhhC3Jq3PYnaeWHgIV0dmTvSrbV1fj9vKz0iq498oeUP7OS
         khdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689442419; x=1692034419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5lBpFjcCM8ICwBqvH4u5XdokFHe2AakZ8reWsweCKQ=;
        b=CKvKmtGttHhdedOs7sZCZaT0LXgY+zgiRpmqvUGnMb1kUBKU8dbUlp+YLnCR477Ojk
         rBOgVeBIzyQ2rj8e2Q8QdpAMbt0OAZOs58Wzgfqho+z/PkRIR+scJrAgutnf7hrYpKcT
         7uGgQPgTOQjKiMBtS1xYOM4QY1WSpvtbO74xY1V+b4Mzuc5Jz/xiLRxFefDaTxqjd2jB
         gh75srmSaRetQTPnFGOgSusXfG/OQKKQ3uHj86Qm/EIZ9T9P1uyEtacgtBQu8HZPxz5f
         SHOGYmJcLHojW5C7FlGF++hlPUs3YbV5ReXmdrYxjum8ErBFuJCj9IX9+QUFUGkk+MeP
         U3Ag==
X-Gm-Message-State: ABy/qLYSGn3WxgbeCn+mMaoeQH3dpTWHtyxvMg7MTHlfW254jhb/SPZK
        dgn9T0bQdIFETH/qJqrY1+XTeIBLHGyqpXF6s8c=
X-Google-Smtp-Source: APBJJlFS2IPwYaxMES/dSmbeBBhwRK5Mlr+veXC1fF+cFCnNpii+8auBVezC/EEl7BICKzitHM67P39hBCL9Nkurep4=
X-Received: by 2002:a5d:5706:0:b0:314:2b0a:dac7 with SMTP id
 a6-20020a5d5706000000b003142b0adac7mr7200870wrv.36.1689442419348; Sat, 15 Jul
 2023 10:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230712175023.31651-1-maxtram95@gmail.com> <4b7da537-8ec3-95e2-4053-871c56e980ea@redhat.com>
In-Reply-To: <4b7da537-8ec3-95e2-4053-871c56e980ea@redhat.com>
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
Date:   Sat, 15 Jul 2023 20:33:12 +0300
Message-ID: <CAKErNvr+F_6_qFyQi_JeDwKNyUapTWZ=KuNx7-UeNgLJoFPrwg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/intel/hid: Add HP Dragonfly G2 to DMI quirks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alex Hung <alexhung@gmail.com>, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Hughes <hughsient@gmail.com>,
        Jorge Lopez <jorge.lopez2@hp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 20:00, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Maxim,
>
> On 7/12/23 19:50, Maxim Mikityanskiy wrote:
> > SW_TABLET_MODE reports are broken on BIOS versions newer than 1.9.1 on
> > HP Elite Dragonfly G2. Analysis of SSDT9 shows that the BTNL method has
> > to be called to start getting 0xcc and 0xcd events. Apparently, the
> > button_array_present method used to return true on BIOS 1.9.1 and older=
,
> > but it returns false on newer BIOSes due to HEBC returning 0x000033f3
> > (bits 0x60000 and 0x20000 are not set).
> >
> > Add this laptop to button_array_table to force the BTNL call, and also
> > add it to dmi_vgbs_allow_list to read the initial state and sync VBDS
> > with VBPS, because this laptop has a reliable VGBS method.
> >
> > Tested with BIOS 1.13.1.
> >
> > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
>
> Thank you for figuring this out and thank you for the patch.
>
> WRT the need to call BTNL, I expect that if one laptop needs this likely =
more models will need it and I expect / hope that this will not cause any i=
ssues when called everywhere.
>
> So I think it would be better to instead of adding this model to the butt=
on_array_table[] it would be better to just always call BTNL (I suspect thi=
s is also what Windows does).
>
> Can you give the attached path to always call BTNL a try ?

Thanks for the patch, I tested it, and it works for me. Also tested on
a non-convertible laptop and didn't see any side effects.

Regarding calling BTNL unconditionally, I guess it's fine to try it,
my only concern is that it might break buttons on some laptops if it
has some weird side effects there, but the change can always be
reverted if you get some bug reports.

I couldn't find any publicly available docs on this interface, so I
don't know whether the driver is expected to call BTNL to get tablet
mode events, or whether such behavior is specific to HP.

> As for adding the model to dmi_vgbs_allow_list[] on many models it seems =
that the EC will send a 0xcc / 0xcd event at boot (now that I think about i=
t I guess this may be in response to the BTNL call) and then on that event =
the SW_TABLET_STATE evdev gets registered and the first event also syncs th=
e state.
>
> Can you check if just using the always call BTNL patch, without the quirk=
 perhaps already makes the SW_TABLET_STATE evdev show up (including the cor=
rect state) ?

Yes, I checked it before, my laptop sends an event on boot (after an
arbitrary delay of about 0.5..1.5 s), but only when started in the
laptop mode. If I turn it on in the tablet mode, there is no initial
event, so I'm afraid the VGBS quirk is needed.


> If no event is send during boot, the n I'm fine with adding the model to =
the dmi_vgbs_allow_list[], but perhaps this is not necessary?
>
> Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/platform/x86/intel/hid.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/in=
tel/hid.c
> > index 5632bd3c534a..5c78b476ed1e 100644
> > --- a/drivers/platform/x86/intel/hid.c
> > +++ b/drivers/platform/x86/intel/hid.c
> > @@ -128,6 +128,13 @@ static const struct dmi_system_id button_array_tab=
le[] =3D {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
> >               },
> >       },
> > +     {
> > +             .ident =3D "HP Elite Dragonfly G2",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G=
2 Notebook PC"),
> > +             },
> > +     },
> >       { }
> >  };
> >
> > @@ -150,6 +157,12 @@ static const struct dmi_system_id dmi_vgbs_allow_l=
ist[] =3D {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go"),
> >               },
> >       },
> > +     {
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G=
2 Notebook PC"),
> > +             },
> > +     },
> >       { }
> >  };
> >
