Return-Path: <linux-kernel+bounces-73246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9785BFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B9C1C2126C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E15768FF;
	Tue, 20 Feb 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wOgW8k+2"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B43763F0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443026; cv=none; b=kvdmWwYUZDMIQH/p3UnnH7PDMo4oEiuXwe/D1mCXHXezu5pCnGvR4MjtpJMle/1pcG0kiZftvlZEyZaVzy/rglwNgrdryirEgKaZyUx5fIjXgoyRPrrDMnVcPyigk3kNiTbkDT6DTUeVu6arvcsFlb/Y/pX57/WxDg5GQf8rel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443026; c=relaxed/simple;
	bh=1sj9S9jNhooUQ/JS/m+MJGrY/bY6bz7kPiE07BuNenc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICE3v02Z/9jiF0+K2hUe4usALK7qgbSOvCNyW+UxWLqvxoXSaDaTOnQLZlHDnRpRFXcdtPAbHTQDCg3NqHDqFISTUznS0TW9VwGVrz5jaSR0I3vcFRRXiNu/Qk1Liqk31+BFuVNpc9CbLTQTL6SUvgZ34mFfQ04uuq6xLEk/edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wOgW8k+2; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4cdfcb24b79so274730e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708443023; x=1709047823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgAso/jjSQp7QM9VPQ9nrwybvQpA1gALdpKpuAZ8dWc=;
        b=wOgW8k+2nRZz/h8xwM0hTH9Rg+E2wpKtri5N55GgZ/9GeYx12sqrHvoBfnZY30NxIK
         ItoFPe0igBCLXTRsIWWBgOHX+EzXnCMBG9hW2iShEhXsYQH6Jr6LCojBWr3x9WSwkBoY
         pT/qLZKDnuP4PnT3NwdIejlN3Ixqn4iCvuWLX6xjoNGrQ9tKXpxatld/nDR2NsIOw00y
         dKnhhQTn2VGUJi2BwFwOEi+lxDDu8As45bf54X4I7U7dAswEhvb+IT1OQi0zrHkYm8Gn
         eqTyomggut+Ob06a7ufU8w9FglBkIe9B0q7DyV70TCo2WIZ7xENAfpCD+0mppMrTPRP/
         8x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443023; x=1709047823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgAso/jjSQp7QM9VPQ9nrwybvQpA1gALdpKpuAZ8dWc=;
        b=aJAF2AAbEL7TMz8Cn+DaW/I8ii+1qiYVzlXg1rn3wC9i5YyRSNG9OA8FqONXo2Ulw1
         U4kG6BF1RDEDBMVM/5akcLg+Em0RR4jPX6t22B05t4kymWq93gLKoLL6TtCew62KNOAs
         TEjHpgAJgN1cURAPaLif/vVMSdZBWQ1NgeSkBCCVxFUq/6Y6T6595XP/YJ9Y9NzPGDGc
         B3HT69Ve8efk2Vm9lEtqJkggVqhOVlT8nI4aIFmZgJH4WN6KG/FqjaIo3N4DQ54p5n4B
         86aiAFN7JexDHwV0j5RP5PgbOdm62HnVYQgInVhcD2bPtBY/HgfxluRh7gBehuA4rRHa
         6p3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUKIC3Tvk5+pKzBE6ODxPZj7I0+aHAhMJ2ZJTD/Rj2zvnmhrTJE77aiukHQ609u9Lunr1vZJA8OOx1sH4lBtb3ZKPLwHg5aV/+3f8F
X-Gm-Message-State: AOJu0Yyk93skpJdp2PDteC81PrcaglkSbuGuymKXb7Szae1bivHUtYdx
	5F4fC30vugZxQNfr/qkqTtiIV9pfavVWEu+z9yBuNoCR3ckSQcknWxDGEQ/CZ22+F868lMBLtZA
	XpmMbtZWV45TGdkqiJ/7fqkBpQ+bVxxiwNhxXpA==
X-Google-Smtp-Source: AGHT+IHgHbSp0Z/+ECASGBhOI1+VwVoeQh+pGTK7r7JGg5XT4Qi7soYBIVRbn0t4RuO6kjK1BcSbECjqI4xybj/MP+8=
X-Received: by 2002:a1f:4c84:0:b0:4c0:774b:e7b0 with SMTP id
 z126-20020a1f4c84000000b004c0774be7b0mr10166207vka.13.1708443022732; Tue, 20
 Feb 2024 07:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220133950.138452-1-herve.codina@bootlin.com>
 <CAMRc=MfWPEOHeNvAwra-JxHZBFMrQbP+273zbFLDZfxi7fx8Yg@mail.gmail.com> <20240220155347.693e46e1@bootlin.com>
In-Reply-To: <20240220155347.693e46e1@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 16:30:11 +0100
Message-ID: <CAMRc=MeSgCOLZvFOXF4eQOp=bTz38K5Krzuy9r569-jnDx1zFA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] leds: gpio: Add devlink between the leds-gpio
 device and the gpio used.
To: Herve Codina <herve.codina@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:53=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> On Tue, 20 Feb 2024 15:19:57 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > On Tue, Feb 20, 2024 at 2:39=E2=80=AFPM Herve Codina <herve.codina@boot=
lin.com> wrote:
> > >
> > > Hi,
> > >
> > > Note: Resent this series with Saravana added in Cc.
> > >
> > > When a gpio used by the leds-gpio device is removed, the leds-gpio
> > > device continues to use this gpio. Also, when the gpio is back, the
> > > leds-gpio still uses the old removed gpio.
> > >
> > > A consumer/supplier relationship is missing between the leds-gpio dev=
ice
> > > (consumer) and the gpio used (supplier).
> > >
> > > This series adds an addionnal devlink between this two device.
> > > With this link when the gpio is removed, the leds-gpio device is also
> > > removed.
> > >
> > > Best regards,
> > > Herv=C3=A9 Codina
> > >
> > > Herve Codina (2):
> > >   gpiolib: Introduce gpiod_device_add_link()
> > >   leds: gpio: Add devlinks between the gpio consumed and the gpio led=
s
> > >     device
> > >
> > >  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
> > >  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
> > >  include/linux/gpio/consumer.h |  5 +++++
> > >  3 files changed, 52 insertions(+)
> > >
> > > --
> > > 2.43.0
> > >
> >
> > Can you add some more context here in the form of DT snippets that
> > lead to this being needed?
>
> / {
>         leds-dock {
>                 compatible =3D "gpio-leds";
>
>                 led-5 {
>                         label =3D "dock:alarm:red";
>                         gpios =3D <&tca6424_dock_2 12 GPIO_ACTIVE_HIGH>;
>                 };

Do I understand correctly that the devlink is created between "led-5"
and "tca6424_dock_2" but actually should also be created between
"leds-dock" and "tca6424_dock_2"?

Bartosz

>
>                 led-6 {
>                         label =3D "dock:alarm:yellow";
>                         gpios =3D <&tca6424_dock_2 13 GPIO_ACTIVE_HIGH>;
>                 };
>
>                 led-7 {
>                         label =3D "dock:alarm:blue";
>                         gpios =3D <&tca6424_dock_2 14 GPIO_ACTIVE_HIGH>;
>                 };
>         };
>
>         ...
>         i2c5 {
>                 ...
>                 tca6424_dock_2: gpio@23 {
>                         compatible =3D "ti,tca6424";
>                         reg =3D <0x23>;
>                         gpio-controller;
>                         #gpio-cells =3D <2>;
>                         interrupt-parent =3D <&tca6424_dock_1>;
>                         interrupts =3D <23 IRQ_TYPE_EDGE_FALLING>;
>                         interrupt-controller;
>                         #interrupt-cells =3D <2>;
>                         vcc-supply =3D <&reg_dock_ctrl_3v3>;
>                 };
>                 tca6424_dock_1: gpio@22 {
>                         compatible =3D "ti,tca6424";
>                         reg =3D <0x22>;
>                         gpio-controller;
>                         #gpio-cells =3D <2>;
>                         interrupt-parent =3D <&gpio4>;
>                         interrupts =3D <1 IRQ_TYPE_EDGE_FALLING>;
>                         interrupt-controller;
>                         #interrupt-cells =3D <2>;
>                         vcc-supply =3D <&reg_dock_ctrl_3v3>;
>                 };
>         };
> };
>
> Also, had the exact same issue if I use a SoC gpio chip instead of an
> i2c gpio expander.
>
> Best regards,
> Herv=C3=A9

