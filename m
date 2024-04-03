Return-Path: <linux-kernel+bounces-130388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D356489786A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B1BB3C060
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032E155A47;
	Wed,  3 Apr 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMoqFOuP"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894C152513;
	Wed,  3 Apr 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166285; cv=none; b=ayx1XQSRqKQvHxGjZiW9CyKd9T2gYkVnp4qi1nbA51LhT4KKrUJPL5d7nSJl5AWd6UKCnDdNMLpF6m8VqMeDrEg3rNfCwj28OYjEMa7YXJHLSCm/cFCA0Oe9Pg3VfdKoC4kFSJMFJfdk2PnKL9RBjktUfQLrDBDCf9Hg3EeVgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166285; c=relaxed/simple;
	bh=qlaC/nOO2wW6YX9nIJo18Mx51joixNRxdhP7W77ht1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxzD1nRRT3/bKR7V6KSHJRKNMmXBEdaE1kGgBeE4n/mkOk+lNQ/EU5pf+a1rIH2RfWB2ZGTBEfvPqHDjDP3I9QihTUkzz68l6MIxPjVCb1qsp24X4699OAa8WCyZFZGc2MC+GYvo16ChkJoBGQ6P4Sm9D0S2jvtOgMQGXgR4IP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMoqFOuP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3417a3151c4so31700f8f.3;
        Wed, 03 Apr 2024 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712166282; x=1712771082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ0v0GF0gyyABhhhVrngkvNWmNZR3i3O24zieOvv0cg=;
        b=EMoqFOuPUbp1+UwH/JgRhbBawbZHBAVIFoJz7231WqnB1zugWvjeDPBarvlTbU/xjb
         NawXW5rnzxqE1iwtAGc+iKL9+WPHozc3B1DmpGzriyqHdNQyt4SJjoPzhOVY9bU1luR1
         wFcEFU5fJQABhavPyyYOj3KiqKfiEJXKWmTJ7/AwWAMsRM0wmCq8wz08NwVPLJqQzUwx
         1k52wgW03QlxiJ0c2dmhWJnEc3/XhSD0a0mLpuf1xXnkf70iFus67daNNB5x4OkLa+uZ
         /FMuOpOzYUZkkWG/zTucM1uRfH0hLtIFe5n8fZKE4h23uoRuM3imyGSfl/d1KtCgsnLt
         OmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166282; x=1712771082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ0v0GF0gyyABhhhVrngkvNWmNZR3i3O24zieOvv0cg=;
        b=faRZ9m8Qa0iUj4wZ3DJDhGXQHVGt99im+3320qrjNWgSAImcVHHDQ1UVkBQ5vlREc0
         Fq4MWzE8OxireMbaf32PRNrZCbtCBKPe+jYzSAAAf4KVe5/Zgdq/jjVSLdZG80hFyrQw
         WrtdqNtOdek2DweGVLsylEBDOl5Xxpq73rvxsTtBI4B/SupXJSMCudZrR1GNFa6K5FSK
         mphxNnKin4GxrjviC9hwv8X1r07qrRk0bQVr7IzoL3A9fTxAZ3fgQftEPgztKjgz5P94
         CO4adu0PvkTRYdfsC7fO3ILkwpy1EbTSaJA6KOvV55CxGUrTG2VVFen7v8yApbdzcaaU
         GMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj2rvOjEamWzAkNoeL1+dlpitlPCkuBVIHS6cSFOhq1fdCpmc0jQWtoeRDN9hTV3eWg0DWEyD0WigFn+YR3FrnW+SbJrm6pjbHz3zlMhWnRK5lDOF44HctqCkg3dBdsRS5GHJ7dS/1HPln
X-Gm-Message-State: AOJu0YxkbZ9egG3mN9JU9IEHMFfgvL64HLSmsmy002cHDK/KOZLSuThZ
	S8cYzgDhlSHPJZDHrN909N2Fplnc7EyOH3KInuA3PNIiEoAKYVj8gxC9U8HOCAQu2mlJzPHfNQi
	BX3M+4/2aNQovNt4isz6d2D7ro6cNWwFcCVI=
X-Google-Smtp-Source: AGHT+IF7dJceFJhLnmKSHKofqAxYbSQKMPd6RKz2ktK1nckW/bPe2J+9zw2z02WGDAlCEGcTt3NqttltmJr6HUhumMA=
X-Received: by 2002:a5d:4a0a:0:b0:33d:277b:8bf6 with SMTP id
 m10-20020a5d4a0a000000b0033d277b8bf6mr197105wrq.26.1712166282248; Wed, 03 Apr
 2024 10:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402174353.256627-1-hugo@hugovil.com> <20240402174353.256627-4-hugo@hugovil.com>
 <CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com> <20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com>
In-Reply-To: <20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Apr 2024 20:44:05 +0300
Message-ID: <CAHp75VcEj64aFb0nT8uQitkNSdWWqz7pmAqSGaGwy-tA=df0EA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:35=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Tue, 2 Apr 2024 22:40:07 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Apr 2, 2024 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:

..

> > > -config SERIAL_SC16IS7XX_CORE
> > > -       tristate
> > > -
> > >  config SERIAL_SC16IS7XX
> > >         tristate "SC16IS7xx serial support"
> > >         select SERIAL_CORE
> > > -       depends on (SPI_MASTER && !I2C) || I2C
> > > +       depends on SPI_MASTER || I2C
> >
> > Is it?
>
> See discussion below, but I would remove the SPI/I2C depends. And I
> would rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE.
>
> >
> > >         help
> > >           Core driver for NXP SC16IS7xx serial ports.
> > >           Supported ICs are:
> > > @@ -1042,22 +1039,18 @@ config SERIAL_SC16IS7XX
> > >           drivers below.
> > >
> > >  config SERIAL_SC16IS7XX_I2C
> > > -       bool "SC16IS7xx for I2C interface"
> > > +       tristate "SC16IS7xx for I2C interface"
> > >         depends on SERIAL_SC16IS7XX
> > >         depends on I2C
> > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > -       select REGMAP_I2C if I2C
> > > -       default y
> > > +       select REGMAP_I2C
> > >         help
> > > -         Enable SC16IS7xx driver on I2C bus,
> > > -         enabled by default to support oldconfig.
> > > +         Enable SC16IS7xx driver on I2C bus.
> > >
> > >  config SERIAL_SC16IS7XX_SPI
> > > -       bool "SC16IS7xx for spi interface"
> > > +       tristate "SC16IS7xx for SPI interface"
> > >         depends on SERIAL_SC16IS7XX
> > >         depends on SPI_MASTER
> > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > -       select REGMAP_SPI if SPI_MASTER
> > > +       select REGMAP_SPI
> > >         help
> > >           Enable SC16IS7xx driver on SPI bus.
> >
> > Hmm... What I was thinking about is more like dropping
> >  the SERIAL_SC16IS7XX and having I2C/SPI to select the core.
> >
> > See many examples under drivers/iio on how it's done.
>
> Ok, I found this example:
> bf96f6e80cef ("iio: accel: kxsd9: Split out SPI transport")
>
> In it, the SPI part doesn't select the core, but depends on it, similar
> to what I have done. I find this approach more interesting for
> embedded systems as you can enable/disable I2C or SPI part if you
> need only one interface.

Yes, but what I mean is to have i2c/spi symbols visible and if user
selects one of them or both the core is automatically being selected.

..

> > > +#include <linux/device.h>
> >
> > Not used (by this file).
>
> I was assuming that this file was for "struct device"?

But it does not use it. It uses an opaque pointer, for which the
forward declaration is enough to have.

..

> > > +void sc16is7xx_remove(struct device *dev);
> >
> > Will require forward declaration
> >
> > #include ...
> >
> > struct device;
>
> Isn't it provided by <linux/device.h> ?

But why? Have you looked into device.h? It's a mess. You don't need it
in this header.

..

> > Follow the IWYU principle (include what you use).
>
> Ok, I tried to follow it, I do think those 4 includes are required in
> this file, no?

I haven't deeply checked, I believe for the next version you will
provide a better list.

> and maybe I can add <linux/string.h> for memcpy().

For sure, yes.

--
With Best Regards,
Andy Shevchenko

