Return-Path: <linux-kernel+bounces-15628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F9822F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D89285B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C51A293;
	Wed,  3 Jan 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="E2OUavRp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F61A28F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e7409797a1so88639277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1704290539; x=1704895339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luUKiYhdMa+DSjWQpnDAurUJm/xFMM0nUDBelYSIQ7E=;
        b=E2OUavRpN35emzKJ5WCgpGBCDiyzR51t3n5uovTKQx0NP8QClZaJ/SvanKJmK/DScx
         Y8vjhgGQklPG/btJk2y8kzQJ5kJKQN4HJ1Kq5cheAMDe0z//MAt44fJ8LOYiVEVI3gl4
         Gjkl4EdY7dtL/iRkLHuhyjnWzuQqwF4jLrvCt8IzZ77jXc01UJ0nqHWBUKvy3YFj1C5X
         dWsFADbchhEpguWMqd/C6p8gsTfL+s7w6l4siPO2PD/uagFaPD/pNUA2myADkPOccu/p
         xDCqKIZVHhXjmUXNmETyuV6gz5bjCnSz8tjt1+/7H1hfO28Mm4tPIQUmwp1AM5PS05g9
         ADrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290539; x=1704895339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luUKiYhdMa+DSjWQpnDAurUJm/xFMM0nUDBelYSIQ7E=;
        b=waUK3OAtXL0cWWRZIGpcg//9uPHHGJFHOKhJcPY9eYjwSBrLy+kEBCaB37rhzeXssV
         f8yAjQuRyr7r0+xaO6R6+TgFfPVkGsywzYDYGdyK6uXgz+0aSjOsF3n4YO54rtUiw/V2
         zEKwbgS9N3Fs1fZ6nfK2ENlauNgCmcnoEsevNVnkfzYjZOxNio8LDY05cegKJyRzl/n+
         V+13Xe7j0qxous2n+6IgofTJBCIwDGOtV4U93W/XSQZ3pZh+5dYltqAMcLwkMEuO9nHx
         DKeq9TcvLLqw/OwOXCedIkkfdtaMbb6ybqthn2HNRBKUnwrFfEvKVRzRBDNkW7URprQy
         5Syw==
X-Gm-Message-State: AOJu0YzAwNBYuIDUqqJxH+1wNS1zRboH2+BMy4m140hTeCtfPDPF1ymu
	hEhPXUAAmZKFCtfJCxpZg17pM6fhA1LStG4naLB0PMXaD16Wcw==
X-Google-Smtp-Source: AGHT+IGQN8KrE+4xYkNUPGMZl2eRSEZ8ppFRb4MyA++6EMf+cQaNmC0TRsIWZJGgprSfIHpyRwTLIJDoYQmNgG1zX48=
X-Received: by 2002:a05:690c:2e84:b0:5ee:6164:5722 with SMTP id
 eu4-20020a05690c2e8400b005ee61645722mr6447462ywb.60.1704290538857; Wed, 03
 Jan 2024 06:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v9-0-24b168e5bcd5@cerno.tech>
 <20220728-rpi-analog-tv-properties-v9-9-24b168e5bcd5@cerno.tech>
 <CAPY8ntD4oz9A1H7Ek1YSLRicLprz1ev5YeAqP2Ah=DMPk84KRQ@mail.gmail.com> <z5mywwtyboycdoqhayfuqjobr53jajgaft5ikfdkt77tnm7bhg@d4gjmlqpnnrt>
In-Reply-To: <z5mywwtyboycdoqhayfuqjobr53jajgaft5ikfdkt77tnm7bhg@d4gjmlqpnnrt>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 3 Jan 2024 14:02:01 +0000
Message-ID: <CAPY8ntB0V2yRWVnr6HYby0g2seDL5P03iO+7E_TLa3niPGSfPw@mail.gmail.com>
Subject: Re: [PATCH v9 09/25] drm/modes: Move named modes parsing to a
 separate function
To: Maxime Ripard <maxime@cerno.tech>
Cc: Karol Herbst <kherbst@redhat.com>, Samuel Holland <samuel@sholland.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chen-Yu Tsai <wens@csie.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Lyude Paul <lyude@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Ben Skeggs <bskeggs@redhat.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, 
	David Airlie <airlied@linux.ie>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Dom Cobley <dom@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>, 
	Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>, nouveau@lists.freedesktop.org, 
	Hans de Goede <hdegoede@redhat.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime

On Wed, 3 Jan 2024 at 13:33, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Dave,
>
> Happy new year :)

And to you.

> On Tue, Jan 02, 2024 at 03:12:26PM +0000, Dave Stevenson wrote:
> > Hi Maxime
> >
> > On Mon, 14 Nov 2022 at 13:00, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > The current construction of the named mode parsing doesn't allow to e=
xtend
> > > it easily. Let's move it to a separate function so we can add more
> > > parameters and modes.
> > >
> > > In order for the tests to still pass, some extra checks are needed, s=
o
> > > it's not a 1:1 move.
> > >
> > > Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> > > Tested-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >
> > > ---
> > > Changes in v7:
> > > - Add Noralf Reviewed-by
> > >
> > > Changes in v6:
> > > - Simplify the test for connection status extras
> > > - Simplify the code path to call drm_mode_parse_cmdline_named_mode
> > >
> > > Changes in v4:
> > > - Fold down all the named mode patches that were split into a single
> > >   patch again to maintain bisectability
> > > ---
> > >  drivers/gpu/drm/drm_modes.c | 70 +++++++++++++++++++++++++++++++++++=
++--------
> > >  1 file changed, 58 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.=
c
> > > index 71c050c3ee6b..37542612912b 100644
> > > --- a/drivers/gpu/drm/drm_modes.c
> > > +++ b/drivers/gpu/drm/drm_modes.c
> > > @@ -2229,6 +2229,51 @@ static const char * const drm_named_modes_whit=
elist[] =3D {
> > >         "PAL",
> > >  };
> > >
> > > +static int drm_mode_parse_cmdline_named_mode(const char *name,
> > > +                                            unsigned int name_end,
> > > +                                            struct drm_cmdline_mode =
*cmdline_mode)
> > > +{
> > > +       unsigned int i;
> > > +
> > > +       if (!name_end)
> > > +               return 0;
> > > +
> > > +       /* If the name starts with a digit, it's not a named mode */
> > > +       if (isdigit(name[0]))
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * If there's an equal sign in the name, the command-line
> > > +        * contains only an option and no mode.
> > > +        */
> > > +       if (strnchr(name, name_end, '=3D'))
> > > +               return 0;
> > > +
> > > +       /* The connection status extras can be set without a mode. */
> > > +       if (name_end =3D=3D 1 &&
> > > +           (name[0] =3D=3D 'd' || name[0] =3D=3D 'D' || name[0] =3D=
=3D 'e'))
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * We're sure we're a named mode at this point, iterate over =
the
> > > +        * list of modes we're aware of.
> > > +        */
> > > +       for (i =3D 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++)=
 {
> > > +               int ret;
> > > +
> > > +               ret =3D str_has_prefix(name, drm_named_modes_whitelis=
t[i]);
> > > +               if (ret !=3D name_end)
> > > +                       continue;
> > > +
> > > +               strcpy(cmdline_mode->name, drm_named_modes_whitelist[=
i]);
> > > +               cmdline_mode->specified =3D true;
> > > +
> > > +               return 1;
> > > +       }
> > > +
> > > +       return -EINVAL;
> > > +}
> > > +
> > >  /**
> > >   * drm_mode_parse_command_line_for_connector - parse command line mo=
deline for connector
> > >   * @mode_option: optional per connector mode option
> > > @@ -2265,7 +2310,7 @@ bool drm_mode_parse_command_line_for_connector(=
const char *mode_option,
> > >         const char *bpp_ptr =3D NULL, *refresh_ptr =3D NULL, *extra_p=
tr =3D NULL;
> > >         const char *options_ptr =3D NULL;
> > >         char *bpp_end_ptr =3D NULL, *refresh_end_ptr =3D NULL;
> > > -       int i, len, ret;
> > > +       int len, ret;
> > >
> > >         memset(mode, 0, sizeof(*mode));
> > >         mode->panel_orientation =3D DRM_MODE_PANEL_ORIENTATION_UNKNOW=
N;
> > > @@ -2306,18 +2351,19 @@ bool drm_mode_parse_command_line_for_connecto=
r(const char *mode_option,
> > >                 parse_extras =3D true;
> > >         }
> > >
> > > -       /* First check for a named mode */
> > > -       for (i =3D 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++)=
 {
> > > -               ret =3D str_has_prefix(name, drm_named_modes_whitelis=
t[i]);
> > > -               if (ret =3D=3D mode_end) {
> > > -                       if (refresh_ptr)
> > > -                               return false; /* named + refresh is i=
nvalid */
> > > +       if (!mode_end)
> > > +               return false;
> >
> > I'm chasing down a change in behaviour between 6.1 and 6.6, and this
> > patch seems to be at least part of the cause.
> >
> > Since [1] we've had the emulated framebuffer on Pi being 16bpp to save
> > memory. All good.
> >
> > It used to be possible to use "video=3DHDMI-A-1:-32" on the kernel
> > command line to set it back to 32bpp.
> >
> > After this patch that is no longer possible. "mode_end =3D bpp_off", an=
d
> > "bpp_off =3D bpp_ptr - name", so with bpp_ptr =3D name we get mode_end
> > being 0. That fails this conditional.
> > drm_mode_parse_cmdline_named_mode already aborts early but with no
> > error if name_end / mode_end is 0, so this "if" clause seems
> > redundant, and is a change in behaviour.
> >
> > We do then get a second parsing failure due to the check if (bpp_ptr
> > || refresh_ptr) at [2].
> > Prior to this patch my video=3D line would get mode->specified set via
> > "if (ret =3D=3D mode_end)" removed above, as ret =3D mode_end =3D 0. We
> > therefore didn't evaluate the conditional that now fails.
> >
> > So I guess my question is whether my command line is valid or not, and
> > therefore is this a regression?
>
> It's a mess :)
>
> Documentation/fb/modedb.rst defines the video parameter syntax as:
>
> <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m][eDd]
>
> And thus mandates the x and y resolution. I guess that's what I use as a
> base, and thus -bpp alone would be invalid.
>
> But then it contradicts itself some time later by documenting that
> video=3DHDMI-1:D is ok.
>
> I guess what you experienced was just an oversight: it was not
> documented anywhere that it was valid, so we didn't really tested it
> either. We should add a unit test for it and fix it.

Does dropping this "if (!mode_end)" check, and at least the check for
bpp_ptr in the "No mode?" block below it, seem reasonable to you?

I guess there is also the question of whether a refresh rate without a
mode is valid. That one seems less useful, and all uses of
refresh_specified appear to be after some form of checking xres and
yres.

I can put a couple of patches together to deal with this if you're
happy with the principle.

Thanks
  Dave

