Return-Path: <linux-kernel+bounces-153684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F274D8AD1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8616281A08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F115380B;
	Mon, 22 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFfbKYoA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CF1474BA;
	Mon, 22 Apr 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802529; cv=none; b=VbXojXcs+e3efv6e/6ML9I0t3lwuaJ3fpPeUkzYrpYRMsmRZh7F7nzlO/2IgqH+4PBOxZxVlAU6wkn9pTPlnqOTix//E9mD6KhtooyyqVv0oF1UGyOSQxEBPHwFRyfsnt9YUBJ6iM0zqKEHiS9g/JIcNgY92qjOr7LxkthveBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802529; c=relaxed/simple;
	bh=+T7qGoJM5CptwNtRlbFQYHPrnonOpqhbu/z+ZqbwDxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shWMQBWlPyWrjN0wdec/lr82W8xvCVM52kSQQ83K42oufuN6Wve0PoF91YZ0SQ5+SjxD0L6uvWymkfS/WI5GPhK7NbLIOiPX/3ZEo6cW6BKTS1XCEpj1++Cx0HEoEPhVTQNJktIDjy7zHXhMq6sdHMZw+vX0u6qfjsreSOJywn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFfbKYoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0BEC32783;
	Mon, 22 Apr 2024 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713802529;
	bh=+T7qGoJM5CptwNtRlbFQYHPrnonOpqhbu/z+ZqbwDxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFfbKYoALeaHJ0fDwzw0lg1SCTCKx3hn0tFWM3d/QyrFQLf7233i9lfrySHzfQjxj
	 2U60qOufIXMn+70hs6Uw2GYvdz0C0wGp72OWXgSZclopmLgufHn+XJ/U8RZ3SD7d/m
	 0TKMoG0OY2vtO48ZlPPCm1tMLwswG1Vag/7gxDXYhMObsB0OQQex9zorRVA9+dXeBV
	 qg1WtVZYFO1kKnMDBxcp8OfJXxVZTcexDXFWQwblj2d8DBIRAmKCB0PrEWJsF9hBOT
	 0PNFoRKrLj7YdLbipK7TJ4c9MId58O8IMMSkS7US/xlr7nLbC5JXazTRLsPmKZbm0Y
	 YHrkVYfahXsHg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c75145c6c4so39874b6e.0;
        Mon, 22 Apr 2024 09:15:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXRs2xKuChmGSyeczlOAtjbDo1VELDN8OHMeSFjkD3T69SzZO4ICyJdI9stJbaWsJZzHag9VbkS/NVdiDlM9WqwiQqbGPxYPeohHp+RfzaIbJM2q2xWLfLDuPyrqH7hVAsJQgBCcrJ0bhOJnNThcZNoDz2xLtV9BPZh51kjYPJe4gnacpSzBEjJ6vUfiIGGAqI9WbszI94UWFrAjb3cGawEoxiGHwAhWiYqw==
X-Gm-Message-State: AOJu0Yy8TSTx6ypRU7TEBkEHXvg4C5rcefTMhik85C9582Qo+9WAG78O
	P/VBPK6vd7r/uRDK4JzxRcogxDnBR7evC+bjfoBYrlWObynRxlUVOef/ohShZT3tKbZkx3Nw0v7
	Y2aOqjf/F3+BcNllN/MWN84Cd1wg=
X-Google-Smtp-Source: AGHT+IFuTJmoqmLpevz+uTmJX81reztBPyhbSeBbFcxUNXIQFfQPQ80CJ515TwTQNC2nE/LxIBgav9z4gMvpgI10aGQ=
X-Received: by 2002:a05:6870:b28c:b0:22e:7cc0:ebd5 with SMTP id
 c12-20020a056870b28c00b0022e7cc0ebd5mr12811422oao.5.1713802528328; Mon, 22
 Apr 2024 09:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060835.71708-1-W_Armin@gmx.de> <ZiYTJOmwDVaws3lh@surfacebook.localdomain>
In-Reply-To: <ZiYTJOmwDVaws3lh@surfacebook.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:15:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joULbyKQJ4suqKj7_UZwaA63M+N4AaWSm7vOdM4OZBEA@mail.gmail.com>
Message-ID: <CAJZ5v0joULbyKQJ4suqKj7_UZwaA63M+N4AaWSm7vOdM4OZBEA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] ACPI: fan: Add hwmon support
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Armin Wolf <w_armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	jdelvare@suse.com, linux@roeck-us.net, linux@weissschuh.net, 
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:36=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Mon, Apr 22, 2024 at 08:08:35AM +0200, Armin Wolf kirjoitti:
> > Currently, the driver does only support a custom sysfs
> > interface to allow userspace to read the fan speed.
> > Add support for the standard hwmon interface so users
> > can read the fan speed with standard tools like "sensors".
> >
> > Tested with a custom ACPI SSDT.
>
> ...
>
> > +/*
> > + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
>
> No file name in the file, it makes an unneeded burden if file is going to=
 be
> renamed.
>
> > + *
> > + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> > + */
>
> ...
>
> > +#include <linux/acpi.h>
> > +#include <linux/hwmon.h>
>
> Please, follow IWYU pronciple, e.g., missing err.h here.
>
> > +#include <linux/limits.h>
> > +#include <linux/units.h>
>
> ...
>
> > +/* Returned when the ACPI fan does not support speed reporting */
> > +#define FAN_SPEED_UNAVAILABLE        0xffffffff
> > +#define FAN_POWER_UNAVAILABLE        0xffffffff
>
> Shouldn't these be rather as ~0 of the respective types or _MAX (from lim=
its.h)
> or something like that?
>
> ...
>
> > +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *=
fan, u64 control)
> > +{
> > +     int i;
>
> unsigned
>
> > +     for (i =3D 0; i < fan->fps_count; i++) {
> > +             if (fan->fps[i].control =3D=3D control)
> > +                     return &fan->fps[i];
> > +     }
> > +
> > +     return NULL;
> > +}
>
> ...
>
> > +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sen=
sor_types type, u32 attr,
> > +                                int channel)
> > +{
> > +     const struct acpi_fan *fan =3D drvdata;
> > +     int i;
>
> unsigned
>
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             switch (attr) {
> > +             case hwmon_fan_input:
> > +                     return 0444;
> > +             case hwmon_fan_target:
> > +                     /* When in fine grain control mode, not every fan=
 control value
> > +                      * has an associated fan performance state.
> > +                      */
> > +                     if (fan->fif.fine_grain_ctrl)
> > +                             return 0;
> > +
> > +                     return 0444;
> > +             default:
>
> > +                     break;
> > +             }
> > +             break;
>
> Instead of two breaks, just return 0 from 'default' case.

I agree here, but for a different reason.

If all of the other cases return from the function, the default one
should return either unless there is a specific reason not to.  IIUC,
there's no such reason in this case.

> > +     case hwmon_power:
> > +             switch (attr) {
> > +             case hwmon_power_input:
> > +                     /* When in fine grain control mode, not every fan=
 control value
> > +                      * has an associated fan performance state.
> > +                      */
>
> /*
>  * Use correct style for multi-line
>  * comment blocks. As in this example.
>  */

Yes, please.

Thanks!

