Return-Path: <linux-kernel+bounces-155677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD238AF585
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C011C225FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2713DDC6;
	Tue, 23 Apr 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBnlgxfG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40D13DBA8;
	Tue, 23 Apr 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893402; cv=none; b=cZJQoj7Gbp/roCTWWFsKsVDj9NPkU7pGO93yWfv4bJOTiY0sIVjfyYWis8iUC0FsOrn4H2QFFg+Q6nls+/t8plQPzs7DyVnmXfHjtTi/ZxY96Xh3pGSul8bKOWwYU2XJK/OXi+aABXz8XgLhWIOfPTR08jWtFO7BQ40iNFeVywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893402; c=relaxed/simple;
	bh=Xj2QC85GjS8D8XVqv4EzLRUhBmy53vq+J6ttSdwsXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnXE++1/zwcd2PQ1QGcjPXPF+Zot8IOFZFTYY28ABsOSzE9vpFJnX7DJ7SKaooYuQh4JuvubjIyPZ7o2QCcm1QffaSMGU2wAlZiJX+vUuAIN7SqOh5smmOnkmfSIQVXCJcIBGylYGz3DQ0WOEDsC7iE2aXpOFS7OKK1yB4htGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBnlgxfG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5872b74c44so186169066b.3;
        Tue, 23 Apr 2024 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713893399; x=1714498199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf+yPfuKi2UH2ssVP+CMlHrhjat91YAJhfeOFrdehqU=;
        b=VBnlgxfGT883tp2IgJ8+PnoG5t8acbuMvlWYRy2GkiL7gaFok+fSN3l4LFWvU/oAbF
         2VFWX/JymGZkN+bSk+VmP4Fqa0wWCvasstQS2718zMsbcDbKHZiTjaHf+/BtdpOcdZOc
         owC1cCBQyo5X3iUI+G10HoUeBC5RrzB2jBMI3G0Vkcm0p0C/XpDQxNSFInGF4zXaUfoC
         5lhK40C0dzZM/4VYs2BLp/R6j1NZOlHFB5Tdik3QJmrL4Wx6+hsGbimytgKgncHgRvOU
         Qppi5bJyuAftpVwuLqEGl4f06T0tWVBlmwqLZ3+qRrRer5zIUciSLEszz4N+46id3NjN
         YkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713893399; x=1714498199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf+yPfuKi2UH2ssVP+CMlHrhjat91YAJhfeOFrdehqU=;
        b=q8cTo6xaXtdA1xPyyh5YvEssqzLa6z2RRFafwAJ4W6ZJ+Q6D0ZZl8ccTGhzpA9TWkz
         TKVfDtIk3dFshSuNYLQQkUrjlC8tGvNyCxJyr6P7PUHkCi1oydnh0xOi+BqXsEzrXjof
         mQ1nZVzrjp+Uk0ZBZB3T4pk5Izl3Vl91TdKAaHrj4m88ltAfBowYxfYTKMXcaiDBIKKt
         zZ9GlKVWCcSRD3o9Cu0OYoox4oFnSFIOq+HKtkshYup6Rd0T9khuf/HfsNUwLQCgeD2K
         hxOYmgGQHUXFDbbae42jcDU6yXtkUfBitTZMRB57/ut+CiOY/5/ar9pmMSYrf2DwV16w
         i5rw==
X-Forwarded-Encrypted: i=1; AJvYcCWBQwLy4rilmJpk43fy51qFKeoy8C5+8OI9WYkZjCR8hIX8yrYHNqalKEFsVaNxCxvPY7MqmOi4fJ5pzLum8GepTPS7s9zI0EbMHORbP9behG3Qw3jJFN7Je7h82pKw/UKvCDNyJhB/6hyL
X-Gm-Message-State: AOJu0YxXrGF2gnhIPmElv7+PzzocNbu2hSi7dbtlhRO7ISLtVT3sBJyt
	U1teHIV5aU0Y4n0qjoEeFty9LoGZJDLI2MMFyZ8j0OLp+Z+G/X2uCuqkKQkGqtqPdYeHAapcslf
	638T9uyHefmf/BrVb/60ROIT91Xo=
X-Google-Smtp-Source: AGHT+IFYHOTLq+YZSJN7kRZqx3D8hZhUNCpHXHAx2r7vjPHnVyrR0fFWmDVb1SQwFofsgkbNX/xTkD8ScuXYuY/oyQQ=
X-Received: by 2002:a17:906:bc98:b0:a58:8392:15e9 with SMTP id
 lv24-20020a170906bc9800b00a58839215e9mr1148701ejb.70.1713893399072; Tue, 23
 Apr 2024 10:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
 <20240422133219.2710061-4-ria.freelander@gmail.com> <20240423132805.aad4ee158df616b5626c1718@hugovil.com>
In-Reply-To: <20240423132805.aad4ee158df616b5626c1718@hugovil.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Tue, 23 Apr 2024 20:32:14 +0300
Message-ID: <CAF1WSuy0-SuBxkXCEe38EbatjX-zjrKUyP1ktzEO2M0E530vYg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com, 
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com, 
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com, 
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:28=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Mon, 22 Apr 2024 16:32:15 +0300
> Konstantin Pugin <ria.freelander@gmail.com> wrote:
>
> Hi Konstantin,
>
> > XR20M1172 register set is mostly compatible with SC16IS762, but it has
> > a support for additional division rates of UART with special DLD regist=
er.
> > So, add handling this register by appropriate devicetree bindings.
> >
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> > ---
> >  drivers/tty/serial/Kconfig         |  3 +-
> >  drivers/tty/serial/sc16is7xx.c     | 61 ++++++++++++++++++++++++++++--
> >  drivers/tty/serial/sc16is7xx.h     |  1 +
> >  drivers/tty/serial/sc16is7xx_i2c.c |  1 +
> >  drivers/tty/serial/sc16is7xx_spi.c |  1 +
> >  5 files changed, 62 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 4fdd7857ef4d..9d0438cfe147 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1029,7 +1029,7 @@ config SERIAL_SC16IS7XX_CORE
> >       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> >       select SERIAL_SC16IS7XX_I2C if I2C
> >       help
> > -       Core driver for NXP SC16IS7xx UARTs.
> > +       Core driver for NXP SC16IS7xx and compatible UARTs.
> >         Supported ICs are:
> >
> >           SC16IS740
> > @@ -1038,6 +1038,7 @@ config SERIAL_SC16IS7XX_CORE
> >           SC16IS752
> >           SC16IS760
> >           SC16IS762
> > +         XR20M1172 (Exar)
> >
> >         The driver supports both I2C and SPI interfaces.
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index dfcc804f558f..09c9e52d7ec2 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -10,6 +10,7 @@
> >  #undef DEFAULT_SYMBOL_NAMESPACE
> >  #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -68,6 +69,7 @@
> >  /* Special Register set: Only if ((LCR[7] =3D=3D 1) && (LCR !=3D 0xBF)=
) */
> >  #define SC16IS7XX_DLL_REG            (0x00) /* Divisor Latch Low */
> >  #define SC16IS7XX_DLH_REG            (0x01) /* Divisor Latch High */
> > +#define XR20M117X_DLD_REG            (0x02) /* Divisor Fractional Regi=
ster */
> >
> >  /* Enhanced Register set: Only if (LCR =3D=3D 0xBF) */
> >  #define SC16IS7XX_EFR_REG            (0x02) /* Enhanced Features */
> > @@ -221,6 +223,20 @@
> >  #define SC16IS7XX_TCR_RX_HALT(words) ((((words) / 4) & 0x0f) << 0)
> >  #define SC16IS7XX_TCR_RX_RESUME(words)       ((((words) / 4) & 0x0f) <=
< 4)
> >
> > +/*
> > + * Divisor Fractional Register bits (EXAR extension).
> > + * EXAR hardware is mostly compatible with SC16IS7XX, but supports add=
itional feature:
> > + * 4x and 8x divisor, instead of default 16x. It has a special registe=
r to program it.
> > + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 =
bits of
> > + * uartclk * (16 / divisor) / baud, in case of default it will be uart=
clk / baud.
> > + * Bits 4 and 5 used as switches, and should not be set to 1 simultane=
ously.
> > + */
> > +
> > +#define XR20M117X_DLD_16X                    0
> > +#define XR20M117X_DLD_DIV_MASK                       GENMASK(3, 0)
> > +#define XR20M117X_DLD_8X                     BIT(4)
> > +#define XR20M117X_DLD_4X                     BIT(5)
> > +
> >  /*
> >   * TLR register bits
> >   * If TLR[3:0] or TLR[7:4] are logical 0, the selectable trigger level=
s via the
> > @@ -523,6 +539,13 @@ const struct sc16is7xx_devtype sc16is762_devtype =
=3D {
> >  };
> >  EXPORT_SYMBOL_GPL(sc16is762_devtype);
> >
> > +const struct sc16is7xx_devtype xr20m1172_devtype =3D {
> > +     .name           =3D "XR20M1172",
> > +     .nr_gpio        =3D 8,
> > +     .nr_uart        =3D 2,
> > +};
> > +EXPORT_SYMBOL_GPL(xr20m1172_devtype);
> > +
> >  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int=
 reg)
> >  {
> >       switch (reg) {
> > @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device =
*dev, unsigned int reg)
> >       return reg =3D=3D SC16IS7XX_RHR_REG;
> >  }
> >
> > +static bool sc16is7xx_has_dld(struct device *dev)
> > +{
> > +     struct sc16is7xx_port *s =3D dev_get_drvdata(dev);
> > +
> > +     if (s->devtype =3D=3D &xr20m1172_devtype)
> > +             return true;
> > +     return false;
> > +}
> > +
> >  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> >  {
> >       struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > -     u8 lcr;
> > +     unsigned long clk =3D port->uartclk, div, div16;
> > +     bool has_dld =3D sc16is7xx_has_dld(port->dev);
> > +     u8 dld_mode =3D XR20M117X_DLD_16X;
> >       u8 prescaler =3D 0;
> > -     unsigned long clk =3D port->uartclk, div =3D clk / 16 / baud;
> > +     u8 divisor =3D 16;
> > +     u8 lcr;
> > +
> > +     if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
> > +             divisor =3D rounddown_pow_of_two(DIV_ROUND_CLOSEST(clk, b=
aud));
> > +
> > +     div16 =3D (clk * 16) / divisor / baud;
> > +     div =3D div16 / 16;
> >
> >       if (div >=3D BIT(16)) {
> >               prescaler =3D SC16IS7XX_MCR_CLKSEL_BIT;
> >               div /=3D 4;
> >       }
> >
> > +     /* Count additional divisor for EXAR devices */
> > +     if (divisor =3D=3D 8)
> > +             dld_mode =3D XR20M117X_DLD_8X;
> > +     if (divisor =3D=3D 4)
> > +             dld_mode =3D XR20M117X_DLD_4X;
> > +     dld_mode |=3D FIELD_PREP(XR20M117X_DLD_DIV_MASK, div16);
> > +
> >       /* Enable enhanced features */
> >       sc16is7xx_efr_lock(port);
> >       sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> > @@ -587,12 +635,14 @@ static int sc16is7xx_set_baud(struct uart_port *p=
ort, int baud)
> >       regcache_cache_bypass(one->regmap, true);
> >       sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
> >       sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
> > +     if (has_dld)
> > +             sc16is7xx_port_write(port, XR20M117X_DLD_REG, dld_mode);
> >       regcache_cache_bypass(one->regmap, false);
> >
> >       /* Restore LCR and access to general register set */
> >       sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
> >
> > -     return DIV_ROUND_CLOSEST(clk / 16, div);
> > +     return DIV_ROUND_CLOSEST(clk / divisor, div);
> >  }
> >
> >  static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int r=
xlen,
> > @@ -1002,6 +1052,8 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >                                 const struct ktermios *old)
> >  {
> >       struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > +     bool has_dld =3D sc16is7xx_has_dld(port->dev);
> > +     u8 divisor =3D has_dld ? 4 : 16
>
> You are missing a semicolumn here, and compilation aborts. Looks like
> you didn't test.
>
> Hugo.
>
>
> >       unsigned int lcr, flow =3D 0;
> >       int baud;
> >       unsigned long flags;
> > @@ -1084,7 +1136,7 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >       /* Get baud rate generator configuration */
> >       baud =3D uart_get_baud_rate(port, termios, old,
> >                                 port->uartclk / 16 / 4 / 0xffff,
> > -                               port->uartclk / 16);
> > +                               port->uartclk / divisor);
> >
> >       /* Setup baudrate generator */
> >       baud =3D sc16is7xx_set_baud(port, baud);
> > @@ -1684,6 +1736,7 @@ void sc16is7xx_remove(struct device *dev)
> >  EXPORT_SYMBOL_GPL(sc16is7xx_remove);
> >
> >  const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] =3D {
> > +     { .compatible =3D "exar,xr20m1172",       .data =3D &xr20m1172_de=
vtype, },
> >       { .compatible =3D "nxp,sc16is740",        .data =3D &sc16is74x_de=
vtype, },
> >       { .compatible =3D "nxp,sc16is741",        .data =3D &sc16is74x_de=
vtype, },
> >       { .compatible =3D "nxp,sc16is750",        .data =3D &sc16is750_de=
vtype, },
> > diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is=
7xx.h
> > index afb784eaee45..eb2e3bc86f15 100644
> > --- a/drivers/tty/serial/sc16is7xx.h
> > +++ b/drivers/tty/serial/sc16is7xx.h
> > @@ -28,6 +28,7 @@ extern const struct sc16is7xx_devtype sc16is750_devty=
pe;
> >  extern const struct sc16is7xx_devtype sc16is752_devtype;
> >  extern const struct sc16is7xx_devtype sc16is760_devtype;
> >  extern const struct sc16is7xx_devtype sc16is762_devtype;
> > +extern const struct sc16is7xx_devtype xr20m1172_devtype;
> >
> >  const char *sc16is7xx_regmap_name(u8 port_id);
> >
> > diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc=
16is7xx_i2c.c
> > index 3ed47c306d85..839de902821b 100644
> > --- a/drivers/tty/serial/sc16is7xx_i2c.c
> > +++ b/drivers/tty/serial/sc16is7xx_i2c.c
> > @@ -46,6 +46,7 @@ static const struct i2c_device_id sc16is7xx_i2c_id_ta=
ble[] =3D {
> >       { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
> >       { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },
> >       { "sc16is762",  (kernel_ulong_t)&sc16is762_devtype, },
> > +     { "xr20m1172",  (kernel_ulong_t)&xr20m1172_devtype, },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
> > diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc=
16is7xx_spi.c
> > index 73df36f8a7fd..2b278282dbd0 100644
> > --- a/drivers/tty/serial/sc16is7xx_spi.c
> > +++ b/drivers/tty/serial/sc16is7xx_spi.c
> > @@ -69,6 +69,7 @@ static const struct spi_device_id sc16is7xx_spi_id_ta=
ble[] =3D {
> >       { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
> >       { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },
> >       { "sc16is762",  (kernel_ulong_t)&sc16is762_devtype, },
> > +     { "xr20m1172",  (kernel_ulong_t)&xr20m1172_devtype, },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
> > --
> > 2.34.1
> >
> >
> >
>
>
> --
> Hugo Villeneuve

WIll fix tomorrow (or today, if I will have time). Maybe I send not
latest version.

