Return-Path: <linux-kernel+bounces-84240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5A86A417
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C162FB28F22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488856749;
	Tue, 27 Feb 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6BwNu7o"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB256479;
	Tue, 27 Feb 2024 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078257; cv=none; b=DIp43NPNcmM64pHouMYKv/sQWWmeT0SBy9Hn7HBJVdZGgzF3aXNiiLT50DMZv4HUvKPTPN42mWZwvjhZpr+mtzmEhy2Cr5yuvhfRWW7dx3v9iGI/gCBBmINjnuYLa8Y0crOUPznoz5cwZPOcJh0tRIbMeZ75JBNwWLLphLi0ySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078257; c=relaxed/simple;
	bh=i4eunqPzv1mPGKjyyB1oGKp6BBHF0yAXIJoIMrqLUkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeKynsjc2AA4fI4ZI0B34A7I0TvfBV9rzIF51X2r9zHGLLVktOnJyupd4Qzpios89/M6OCESiS/th0q5JF+DiUN6qJgvq6SLKQ+NrqMA0cwJpb7S6yqjckCkjsGBeehZ4xkD/CJJIhECw4vZJYmcqgpTymOCdO3LRuaNmT6pnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6BwNu7o; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a36126ee41eso597980066b.2;
        Tue, 27 Feb 2024 15:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709078254; x=1709683054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw/2eTH8icUybOg0B2mojfpsRBh1ZcHTu30XFAlRte0=;
        b=E6BwNu7owCV70FS+DrdTE61AUGVxUsJM+m7/bynmiQq+VS7LpO+F0dZFlkzVoWbfNq
         zbAXj57VGV9ikrhBk1M7NhsPZoO4dvYYNYyMdqNy7z53JRihSVG59AZtEyMeXUjrFzj/
         wDrvqZk+W/XpAYtNf7zztKkrGxxqotaTFUdsBSdM4PNvT/vy0lIPq7UMW3ELhj+pAwSz
         gdTUYXkrcwla9ig0MnzFDZmztIqRyeR86fDFIKSNI6mkyBg330H9zuamAOHbOXY6Ok7L
         8I7vSJ5yd1x8irbuIeVIqgmuUSfDRTXatEoHbamO/iE2XMtSyEj6kyN3tl7apg3vku/h
         qhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078254; x=1709683054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw/2eTH8icUybOg0B2mojfpsRBh1ZcHTu30XFAlRte0=;
        b=K2LQwTVEeOEWm3/6tAxMfA2J0phVZQwvPMNIg3DlgEzOk1ojfEgZmINAnjfTqdusss
         3FXy2XgMC4JkGlWUlJgBGBHb4HFdk0Vv52G4SeNEJff8TdxQH9uEBEwDq3mOC2Jm6tTv
         SxTcYWSiA7FMtU8l/VTxKh8+sPwbKznOsNjKY8sk6NsF3s08DSgPM4U9fnAmPC8uHxpW
         MQC1UzM84ofJ1SaiyckoWKJh8X3YVEiomOeWAxK31PnYvvPrdXy82WPHk0w/KNgG/fP+
         41iBOKnud/aJs/VhUG/lSGQ6Jpw0Jn+D5OzzBondNhKFd8978iDun2aBTWR43VHCczFd
         t37Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRxVTwnaCJLl5gBFN9cEu0MpZ2osMG2Az9l5ZnZxpMoBGRJyTTXY6FTh4ojZGn9olN3jbtRiP6j77zwch6JCZQIzMKU7AiErACCApNfNNJmfruXor1jz0w/Nm0FQIHZtwLBKmUdOPmdjRk9I9u+6UcXFhU5SFHO7espqmmg2kRE7QB+qk=
X-Gm-Message-State: AOJu0YxQKmcOQlKTmGpJYknlZ3OuZ+1B1VjQJnyhL6XGWWGpDC2Pls3u
	aARSY3r6n6L1dZL1cl70rysxOdqRIXc1RuBcGqwUOpb1ZueMk64aR+udFYDWPyUwHmU3zVY0DIt
	ENnmrDHCyOGcthRL0+VyzgMlZcOQ=
X-Google-Smtp-Source: AGHT+IGzgELteKOwRkF+kGHOFsCKs4ffEQ8yQMPYg/MYVyXRjfTkx0bQ5Dop1HHtqsPco9RRDsOyOUwCOjr/c/A2Iuo=
X-Received: by 2002:a17:906:b2ca:b0:a43:18a0:a1ab with SMTP id
 cf10-20020a170906b2ca00b00a4318a0a1abmr5315944ejb.7.1709078253580; Tue, 27
 Feb 2024 15:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz> <20240227212244.262710-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240227212244.262710-2-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 01:56:56 +0200
Message-ID: <CAHp75Ve-zKDgBXhe8fzvW0GY2nB7=ZTfhsJX6OHBH8EQWaWG-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] auxdisplay: Add 7 segment LED display driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, geert@linux-m68k.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	ojeda@kernel.org, tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl, 
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add a driver for a 7 segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14 segment displays in the future.

As Randy already pointed out
7-segment (everywhere)
14-segment (also everywhere)

..

>  drivers/auxdisplay/seg-led.c | 119 +++++++++++++++++++++++++++++++++++

I believe we want to have a 'gpio' part in the file name and in the Kconfig=
.


> +config SEG_LED
> +       tristate "Generic 7 segment LED display"
> +       select LINEDISP
> +       help
> +         This driver supports a generic 7 segment LED display made up
> +         of GPIO pins connected to the individual segments.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called seg-led.

..

> +#include <linux/container_of.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>

> +#include <linux/kernel.h>

Please, avoid proxy headers. I do not believe kernel.h is anyhow used here.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>

..

> +struct seg_led_priv {
> +       struct gpio_descs *segment_gpios;
> +       struct delayed_work work;

> +       struct linedisp linedisp;

Make it the first member, so container_of() will be noop for this.

> +};

..

> +static void seg_led_update(struct work_struct *work)
> +{
> +       struct seg_led_priv *priv =3D container_of(work, struct seg_led_p=
riv, work.work);
> +       struct linedisp_map *map =3D priv->linedisp.map;
> +       DECLARE_BITMAP(values, 8);

> +       values[0] =3D map_to_seg7(&map->map.seg7, priv->linedisp.buf[0]);

While it works in this case, it's bad code. You need to use
bitmap_set_value8(). And basically that's the API in a for-loop to be
used in case we have more than one digit. This will require another
header to be included.

> +       gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv-=
>segment_gpios->desc,
> +                                      priv->segment_gpios->info, values)=
;
> +}

..

> +static const struct of_device_id seg_led_of_match[] =3D {
> +       { .compatible =3D "generic-gpio-7seg"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, seg_led_of_match);

Move this part closer to its user, i.e. struct platform_driver below.

..

> +       INIT_DELAYED_WORK(&priv->work, seg_led_update);

Move this to ->get_map_type() as other drivers do. Yes, I agree that
->get_map_type() is not the best name currently. You can rename it to
->init_and_get_map_type() if you wish (patches are welcome!) or any
other better name.

--=20
With Best Regards,
Andy Shevchenko

