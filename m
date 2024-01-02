Return-Path: <linux-kernel+bounces-14544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29604821E76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7F5B22271
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D313ADA;
	Tue,  2 Jan 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Lb7f8+4E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408A14283
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so7185672276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1704208362; x=1704813162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DETzKFn+RNOmM0nC/CwezQoH3E46aIzh480BZFUjCe0=;
        b=Lb7f8+4EBO8NLX/o3qaa+L82EbFf0szEqA3MkOlb+YeQroKA5E48MKHDKzN7l3jlJ4
         Db1fqvp0nLuGAWnSv7K/BSh+qHULuINMLBa9LGoMlZ+jn6q8fF5mTtyuGBSHnMLj36jx
         M+NVabOd745ZeGBHgBcldL3cPlyVPPfOzx49BVpJl5MEXXiLlc8O5fy2yWFMtJ2PNsA0
         4QE0zf5F07lijdV7uVIeBSMM4AcB8MvD0woVWJzHho4ypCy5FT3BsFV2Fk8xHaXfIW/0
         2ouTUQUrcFIYuU1huWHGxIl2CbMsmDfjjgv0Iih+JBtkwXBuQdtpPOrBaNVPPwEEnwqa
         sOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208362; x=1704813162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DETzKFn+RNOmM0nC/CwezQoH3E46aIzh480BZFUjCe0=;
        b=hl7dGLCq8mPBmxmjebr9+nf5lilucNUr+y2/Okmn6ahF4GRD/wIe+zFGaP83tnKClJ
         SnXtOrfjubcfFzeuhSSM/XwgPsZ4mmYKqKzsnY3RfZE5MHWA9REALFUyM6O7tc0v+My5
         TW+ZdwIXacMlJ3zBomI3IQMggAfr8xvESTIaeINmgJIIpir+WUefUbJLA5zBs4RZlbfa
         ZuUlgR4eQ4SiwCjSkAl4pitCtnjllRSkxFPQY36jsO2pzpAmY0mdXYiBjv5ckIg+8LcF
         E82fwKWWdqNlaFEzVIR0qnigPpMpOMFDKyLw71RdHmnWF03kQZVCNmDHbecGJZsag+dK
         hHBQ==
X-Gm-Message-State: AOJu0YzqVuMlC+ubV2c4KVXJL8fi4L+w/GZh5TY+zghiGr//E0VEyQos
	Cko8s+Q3owdUyBH59lF5zur/4g2YsrFudRw4pkug6+ylWQsopA==
X-Google-Smtp-Source: AGHT+IGRpeH+ulCpq2/CqActcdg5ra5CWJ9lXcPK7CIYy8JkK0sx9W7zDyxU3/x4g+WaKSqbAQ0nQ6n2LGD5JROwu9w=
X-Received: by 2002:a25:860c:0:b0:dbc:519b:8415 with SMTP id
 y12-20020a25860c000000b00dbc519b8415mr12386888ybk.41.1704208362422; Tue, 02
 Jan 2024 07:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v9-0-24b168e5bcd5@cerno.tech> <20220728-rpi-analog-tv-properties-v9-9-24b168e5bcd5@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v9-9-24b168e5bcd5@cerno.tech>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 2 Jan 2024 15:12:26 +0000
Message-ID: <CAPY8ntD4oz9A1H7Ek1YSLRicLprz1ev5YeAqP2Ah=DMPk84KRQ@mail.gmail.com>
Subject: Re: [PATCH v9 09/25] drm/modes: Move named modes parsing to a
 separate function
To: Maxime Ripard <maxime@cerno.tech>, Maxime Ripard <mripard@kernel.org>
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

On Mon, 14 Nov 2022 at 13:00, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The current construction of the named mode parsing doesn't allow to exten=
d
> it easily. Let's move it to a separate function so we can add more
> parameters and modes.
>
> In order for the tests to still pass, some extra checks are needed, so
> it's not a 1:1 move.
>
> Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Tested-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>
> ---
> Changes in v7:
> - Add Noralf Reviewed-by
>
> Changes in v6:
> - Simplify the test for connection status extras
> - Simplify the code path to call drm_mode_parse_cmdline_named_mode
>
> Changes in v4:
> - Fold down all the named mode patches that were split into a single
>   patch again to maintain bisectability
> ---
>  drivers/gpu/drm/drm_modes.c | 70 +++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 58 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 71c050c3ee6b..37542612912b 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -2229,6 +2229,51 @@ static const char * const drm_named_modes_whitelis=
t[] =3D {
>         "PAL",
>  };
>
> +static int drm_mode_parse_cmdline_named_mode(const char *name,
> +                                            unsigned int name_end,
> +                                            struct drm_cmdline_mode *cmd=
line_mode)
> +{
> +       unsigned int i;
> +
> +       if (!name_end)
> +               return 0;
> +
> +       /* If the name starts with a digit, it's not a named mode */
> +       if (isdigit(name[0]))
> +               return 0;
> +
> +       /*
> +        * If there's an equal sign in the name, the command-line
> +        * contains only an option and no mode.
> +        */
> +       if (strnchr(name, name_end, '=3D'))
> +               return 0;
> +
> +       /* The connection status extras can be set without a mode. */
> +       if (name_end =3D=3D 1 &&
> +           (name[0] =3D=3D 'd' || name[0] =3D=3D 'D' || name[0] =3D=3D '=
e'))
> +               return 0;
> +
> +       /*
> +        * We're sure we're a named mode at this point, iterate over the
> +        * list of modes we're aware of.
> +        */
> +       for (i =3D 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> +               int ret;
> +
> +               ret =3D str_has_prefix(name, drm_named_modes_whitelist[i]=
);
> +               if (ret !=3D name_end)
> +                       continue;
> +
> +               strcpy(cmdline_mode->name, drm_named_modes_whitelist[i]);
> +               cmdline_mode->specified =3D true;
> +
> +               return 1;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  /**
>   * drm_mode_parse_command_line_for_connector - parse command line modeli=
ne for connector
>   * @mode_option: optional per connector mode option
> @@ -2265,7 +2310,7 @@ bool drm_mode_parse_command_line_for_connector(cons=
t char *mode_option,
>         const char *bpp_ptr =3D NULL, *refresh_ptr =3D NULL, *extra_ptr =
=3D NULL;
>         const char *options_ptr =3D NULL;
>         char *bpp_end_ptr =3D NULL, *refresh_end_ptr =3D NULL;
> -       int i, len, ret;
> +       int len, ret;
>
>         memset(mode, 0, sizeof(*mode));
>         mode->panel_orientation =3D DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> @@ -2306,18 +2351,19 @@ bool drm_mode_parse_command_line_for_connector(co=
nst char *mode_option,
>                 parse_extras =3D true;
>         }
>
> -       /* First check for a named mode */
> -       for (i =3D 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> -               ret =3D str_has_prefix(name, drm_named_modes_whitelist[i]=
);
> -               if (ret =3D=3D mode_end) {
> -                       if (refresh_ptr)
> -                               return false; /* named + refresh is inval=
id */
> +       if (!mode_end)
> +               return false;

I'm chasing down a change in behaviour between 6.1 and 6.6, and this
patch seems to be at least part of the cause.

Since [1] we've had the emulated framebuffer on Pi being 16bpp to save
memory. All good.

It used to be possible to use "video=3DHDMI-A-1:-32" on the kernel
command line to set it back to 32bpp.

After this patch that is no longer possible. "mode_end =3D bpp_off", and
"bpp_off =3D bpp_ptr - name", so with bpp_ptr =3D name we get mode_end
being 0. That fails this conditional.
drm_mode_parse_cmdline_named_mode already aborts early but with no
error if name_end / mode_end is 0, so this "if" clause seems
redundant, and is a change in behaviour.

We do then get a second parsing failure due to the check if (bpp_ptr
|| refresh_ptr) at [2].
Prior to this patch my video=3D line would get mode->specified set via
"if (ret =3D=3D mode_end)" removed above, as ret =3D mode_end =3D 0. We
therefore didn't evaluate the conditional that now fails.

So I guess my question is whether my command line is valid or not, and
therefore is this a regression?
If considered invalid, then presumably there is no way to update the
bpp without also having to specify the resolution. That is rather
annoying as almost everything else can be updated without having to
set the resolution, so this one property would be the odd one out.

Thanks, and Happy New Year.
  Dave

[1] https://github.com/torvalds/linux/commit/f741b28fb299263d2d03a0fb701bfe=
648927cd47
[2] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_mode=
s.c#L2441
[3] https://github.com/torvalds/linux/commit/a631bf30eb914affc0a574f4457683=
3477346ad6

>
> -                       strcpy(mode->name, drm_named_modes_whitelist[i]);
> -                       mode->specified =3D true;
> -                       break;
> -               }
> -       }
> +       ret =3D drm_mode_parse_cmdline_named_mode(name, mode_end, mode);
> +       if (ret < 0)
> +               return false;
> +
> +       /*
> +        * Having a mode that starts by a letter (and thus is named) and
> +        * an at-sign (used to specify a refresh rate) is disallowed.
> +        */
> +       if (ret && refresh_ptr)
> +               return false;
>
>         /* No named mode? Check for a normal mode argument, e.g. 1024x768=
 */
>         if (!mode->specified && isdigit(name[0])) {
>
> --
> b4 0.11.0-dev-99e3a

