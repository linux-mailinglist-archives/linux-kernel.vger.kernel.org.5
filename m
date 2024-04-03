Return-Path: <linux-kernel+bounces-130413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C6C8977BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57FE1C20FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635F51534EB;
	Wed,  3 Apr 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ/W8c6X"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D11CD04;
	Wed,  3 Apr 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167509; cv=none; b=FEfthG5cyhGyzOK3EXfHbBGcqE3iC5cuOTNn1ipu3fUSEetVgnPnPUZ4YWOdVwSoe37ubd7mfZsVaWWFbCb7VyTAEq13EGTpBJ3LwQxeLLwA48bemCCzY2Efu6Ow0av+W/O3nUkcSrVNi4mVlSETHliPneL7nyNUaHD7ZJuyrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167509; c=relaxed/simple;
	bh=u5kwijjs50yD93l3u4g8LTHbhhOcvdUDjpPCNlZnj+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw1io1VcuSlrQ8Dft5Dc+WZNvJhegVtcA56RNwvd44MIo/6ulAmliStr9hPysZsLTW9vLuOVWVLJJv3Szp8A/BDP1/LWvinCwBgUsPAK6TiFBjuBYfI/xKTs3r6+OdOh9MDukCUf/RXdbuKb/XAibyiG0VCcO/7C6EFBSAWBM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ/W8c6X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4702457ccbso19648466b.3;
        Wed, 03 Apr 2024 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167506; x=1712772306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTMMrRC0RdMZfwZ8YEC2hPg7nA7GR3Lo7xiKVG1MTxE=;
        b=jJ/W8c6XHqXVFt6Sf7f7CRSttuRqK8MhccOLewcvOyLB5Q41njR8yUXde12B37tVEO
         ZoHaXQvlffF9edPSM1zZxEF6PpoXPd+04yWBQf38R4JL2mKzwO3RGncMOvdrXBEU6qV/
         P7VSz4QK2mbMHE5oBDR10gpIGj8afsnBA/vwY+BoyGjG6k73KCKNeo3iOYXPiVejL9GO
         HW5uACetZvQ9ZXQyONthU6sAaZwMzWh1QUw004q/Lb23bY/oa9GgriQ1OleGv0UzUp4F
         IzuUBR1S0Imkns5MDBtiZW2NNMzKDgY9HtDHxLwvZhCxxkk0ZkmLcWdOx1jwAGtXY277
         jEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167506; x=1712772306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTMMrRC0RdMZfwZ8YEC2hPg7nA7GR3Lo7xiKVG1MTxE=;
        b=UABHhDcNMNqPEwGTQL9zGgvT3BH12rEgv9S83tFWggyGJt/oiCic9igO1GZJkJGfQI
         O+aiibUNVWItHmyrJwF2uQaT0x9GpFq18sgHnDNSwxgzGaBQIHKti/7uRJoJkVrfQdtC
         qMKRJAtZ/qdPJJqAAkoeWTXopEeY3a1rBr2i72E8NBZxrOuL2wN4b0jhh9sA4O6cGYoq
         XsUbW2ibqKcBLJ/Ur8dEg4t4gIs9ecZbxlnNJVquP/fXeYDGVDV9Oa2QzA0lgC9lcKoG
         8uJCyDs0+vH01tVK1SCqrfhCj1jhWgKl3pgE1VfOL5m4XjR5V6x6UYcZe0YHjyy1soYC
         zWEA==
X-Forwarded-Encrypted: i=1; AJvYcCUd31XvlwFhsfRilr7LwgyUe3Zwdxj3DC9hJOVnrVDi0y1A8pCmZjuTkfgJAAgBNmMIa+MvNi6SaY/hKFPCevSpqDMWJYZQAZaXO1pwkUlkpSEHGjWeOl+w7tiHvofEvFJJR5cAA6FsIxAm
X-Gm-Message-State: AOJu0YxFZn/CraJtrcEeMTE0V0DUWa57sp5UNjvKTEX8hjdmsfXqx/Wy
	RJBQhoNFNZNMB8T72b5wZezAlGHJBFtc1Ns4bMrWf0VonhDTswMjfCQr81+/wkF2LR+Pe1249ZJ
	+gei+Yc3hEwbRVvInBVs4x9eu59o=
X-Google-Smtp-Source: AGHT+IHRgBGvourdOZUYV/4Ou8Ih5ePDB1KVDUAA8vWgiNkZiKN+n+V3fotC/zULRJGSGByoRc/6XXthqb7+xc54u24=
X-Received: by 2002:a17:906:35cd:b0:a4e:17c2:d60a with SMTP id
 p13-20020a17090635cd00b00a4e17c2d60amr49411ejb.54.1712167506172; Wed, 03 Apr
 2024 11:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402174353.256627-1-hugo@hugovil.com> <20240402174353.256627-4-hugo@hugovil.com>
 <CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com>
 <20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com> <CAHp75VcEj64aFb0nT8uQitkNSdWWqz7pmAqSGaGwy-tA=df0EA@mail.gmail.com>
 <20240403135910.2ef852670c184927340d08d7@hugovil.com>
In-Reply-To: <20240403135910.2ef852670c184927340d08d7@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Apr 2024 21:04:29 +0300
Message-ID: <CAHp75Vdm0RAX_xD41VvXuv3GG0SkHffqw7v=hs_6m4Ev1WZjMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 8:59=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Wed, 3 Apr 2024 20:44:05 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Apr 3, 2024 at 7:35=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:
> > > On Tue, 2 Apr 2024 22:40:07 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Apr 2, 2024 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovi=
l.com> wrote:

..

> > > > > -config SERIAL_SC16IS7XX_CORE
> > > > > -       tristate
> > > > > -
> > > > >  config SERIAL_SC16IS7XX
> > > > >         tristate "SC16IS7xx serial support"
> > > > >         select SERIAL_CORE
> > > > > -       depends on (SPI_MASTER && !I2C) || I2C
> > > > > +       depends on SPI_MASTER || I2C
> > > >
> > > > Is it?
> > >
> > > See discussion below, but I would remove the SPI/I2C depends. And I
> > > would rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE.
> > >
> > > >
> > > > >         help
> > > > >           Core driver for NXP SC16IS7xx serial ports.
> > > > >           Supported ICs are:
> > > > > @@ -1042,22 +1039,18 @@ config SERIAL_SC16IS7XX
> > > > >           drivers below.
> > > > >
> > > > >  config SERIAL_SC16IS7XX_I2C
> > > > > -       bool "SC16IS7xx for I2C interface"
> > > > > +       tristate "SC16IS7xx for I2C interface"
> > > > >         depends on SERIAL_SC16IS7XX
> > > > >         depends on I2C
> > > > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > > > -       select REGMAP_I2C if I2C
> > > > > -       default y
> > > > > +       select REGMAP_I2C
> > > > >         help
> > > > > -         Enable SC16IS7xx driver on I2C bus,
> > > > > -         enabled by default to support oldconfig.
> > > > > +         Enable SC16IS7xx driver on I2C bus.
> > > > >
> > > > >  config SERIAL_SC16IS7XX_SPI
> > > > > -       bool "SC16IS7xx for spi interface"
> > > > > +       tristate "SC16IS7xx for SPI interface"
> > > > >         depends on SERIAL_SC16IS7XX
> > > > >         depends on SPI_MASTER
> > > > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > > > -       select REGMAP_SPI if SPI_MASTER
> > > > > +       select REGMAP_SPI
> > > > >         help
> > > > >           Enable SC16IS7xx driver on SPI bus.
> > > >
> > > > Hmm... What I was thinking about is more like dropping
> > > >  the SERIAL_SC16IS7XX and having I2C/SPI to select the core.
> > > >
> > > > See many examples under drivers/iio on how it's done.
> > >
> > > Ok, I found this example:
> > > bf96f6e80cef ("iio: accel: kxsd9: Split out SPI transport")
> > >
> > > In it, the SPI part doesn't select the core, but depends on it, simil=
ar
> > > to what I have done. I find this approach more interesting for
> > > embedded systems as you can enable/disable I2C or SPI part if you
> > > need only one interface.
> >
> > Yes, but what I mean is to have i2c/spi symbols visible and if user
> > selects one of them or both the core is automatically being selected.
>
> Ok, I see. But a drawback of doing this is that for each interface
> (I2C/SPI), you would need to list (duplicate) all the devices
> supported. For now, that list is only in one place,
> for the generic SERIAL_SC16IS7XX_CORE section:
>
> ...
> config SERIAL_SC16IS7XX_CORE
>         tristate "SC16IS7xx serial support"
>         select SERIAL_CORE
>         help
>           Core driver for NXP SC16IS7xx serial ports.
>           Supported ICs are:
>
>             SC16IS740
>             SC16IS741
>             SC16IS750

Hmm... How do the other drivers have this separation? So, check
several examples (and check _the recently added_) in IIO and follow
that. If they have CORE visible, follow it.

..

> > > Isn't it provided by <linux/device.h> ?
> >
> > But why? Have you looked into device.h? It's a mess. You don't need it
> > in this header.
>
> Yes I have looked at it, and saw that the forward declaration of
> "struct device" opaque pointer is in it, and this is why I was
> including it. But I will remove it if you wish.

This file doesn't use the struct device, it uses an opaque pointer. In
C for this the forward declaration is enough, no need to include a
whole mess from device.h.

--=20
With Best Regards,
Andy Shevchenko

