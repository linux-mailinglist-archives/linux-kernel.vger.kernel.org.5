Return-Path: <linux-kernel+bounces-158827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2C8B256D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA91C22F75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593F14BF89;
	Thu, 25 Apr 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk1f2X1G"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCB14B080;
	Thu, 25 Apr 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059668; cv=none; b=b0iPmk6bl8uhtFMv4cwoc8HNyZ0kvNjX4dGB5yN9J0JE7qlBuiNlM94O08wBSo4QOtDV2cbzsGILYsncQikkKENyAQ6ghZQQnzr7t1x4Il/uW5g9AceOkUDKVGJAVhWbQoEQNV3frpIPU/GZ4H8DfwB+CtG9rplYKNOzaiz4gUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059668; c=relaxed/simple;
	bh=e5/97CeRrHoyCUP8c7c+7jK1c5FR0YOpLq9fkhjzesc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGZlxcKDNG2GZykI2bKWr6EZGvdP1B11Q4r4f0nMXA8vqnG2Y7nqTehIlI5ulsrepfxK6FQ6hpqHn5OKuvwOsJnNuCmdEj9UDsfFsPkis+PL2iyDf4gXvnyNui427KQa1qilao3XMRBmzL9sZYr/KK8CWl8QbeCXod6eIZsJI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk1f2X1G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a556d22fa93so138511266b.3;
        Thu, 25 Apr 2024 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714059665; x=1714664465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwO/yikPQmVpeff2ynebKp1ynRZVosQFdRsZEIeKqBA=;
        b=Lk1f2X1GIBdL00L91E6DCSx/phD9GZscVh01ovyK0XWw47GymmYgHCcxjsgOUsesjJ
         jJq4e/51eYQZb60sZQbsQgez+mboue2m2/zAGnrHnwCMbGRifxudJnBjtZ3WMWDrFxlE
         Rgr79Q1xE821lfjQlDgppvhaAD0id+Nu0O3Hz8JssFqmDsJvUShssii7C9pmXofuqr3C
         /8CEkpdT6u7GR7LrRYRxMd36e1lFz+R6SJsBB6Z3KTAwFRfsRd/R3/gTAfYqdI2ckWIs
         9QWIa1KkhsYOueDvHyg9L8j60cFWaXutJxMPCtOTjMARKtC6KgPnZCZpnNgtFr9ZenQF
         UuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059665; x=1714664465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwO/yikPQmVpeff2ynebKp1ynRZVosQFdRsZEIeKqBA=;
        b=lJvxHLuP6pXM4BjrJQOvb7DhBNFQyBb1CXUB8pTiCjAwoVjqHzTaxb/6m3V3VPltVE
         bL8fCIr+jMzXd10RNqkiwikbnnNqn/K+kAdAzBnhDdwPyymducQn50Dh/G9QN9NYtf76
         6shofvCwhSSxqEYY4K2dqFI9eHARFUMSGhRKDgf70pvKU1ji67I+YAv64yVAo7p05+T0
         qzqqtIz4jHGbQUUMdqgT2giWcJZN6W/7h8s0ssIctTtQtn4km40GTY8wwgmN7+BkrvEA
         2/gP17l4a0+eWzQFAn97bJa6DECEEVXuZ9ynBrs6pyoxpg2aB7IacRCZoIqNysHkUKF6
         gw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJy0njWWIVr9vUq6uTUF5Ttq2LIOIQtVhKT0zVlxwgvdrCwGF8DJs38SSFpNwpB1C95VoDC73Y18751IxIfAsnvjpBKWiCfRd5b4sYNMqvknRFFDJADAmyNeK60A1KF6siuheOEOdaYcpO
X-Gm-Message-State: AOJu0YxFbXPwWvDU3CPBSzhqpS9nx9yk57rEOxGPfESyeYbD8oLkiap7
	wWhfrdZJT5Ehc78k0V7WVXlilzIw5zd9cX5r8JPak3nJE0XlCIB/dyZjynvYHCDyUCnz3MYWQvu
	kgVVXsTNBQtFbqlU1c4Zeufj624A=
X-Google-Smtp-Source: AGHT+IGc4eBcETJ0OfL1wAox/ZT94lQ95bL55lwGqk0WSIK1R42BaKOyYkOxfCx4Pj1jN6V+G1gQMhE1SCQXnqH6YQY=
X-Received: by 2002:a17:906:8312:b0:a56:2556:8e3 with SMTP id
 j18-20020a170906831200b00a56255608e3mr63844ejx.73.1714059664353; Thu, 25 Apr
 2024 08:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424191908.32565-1-rilian.la.te@ya.ru> <20240424191908.32565-4-rilian.la.te@ya.ru>
 <20240425112602.57610aad643525a0e9973ff6@hugovil.com>
In-Reply-To: <20240425112602.57610aad643525a0e9973ff6@hugovil.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Thu, 25 Apr 2024 18:43:20 +0300
Message-ID: <CAF1WSux0DX6KrQrPAVXvLefPPVFeCHSPuLPa+X7rL8j0o60LEw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Herve Codina <herve.codina@bootlin.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 6:26=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Wed, 24 Apr 2024 22:18:54 +0300
> Konstantin Pugin <rilian.la.te@ya.ru> wrote:
>
> Hi Konstantin,
>
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > XR20M1172 register set is mostly compatible with SC16IS762, but it has
> > a support for additional division rates of UART with special DLD regist=
er.
>
> -> "... but it supports additional division rates with special..."
>
> > So, add handling this register by appropriate devicetree bindings.
>
> I am not sure about this, support for DLD is added in the driver,
> not in device tree. You can probably drop that sentence?
>
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
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
>
> Remove "Register".
>
> Also, DLD register needs EFR[4] =3D 1 to be accessed, so maybe add this
> to the comment:
>
> /* Divisor Fractional (requires EFR[4] =3D 1) */
>
>
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
> This still breaks compilation. I noted in V7 of the patch to fix this,
> but obviously you didn't do it, altough you mention that you would do
> it in your reply to me, and you also mention doing it in your cover
> letter...
>
> This means you didn't test your patchset V8 before sending it. You
> really need to properly test _before_ sending a new patchset.
>
>
> Hugo.
>
>
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
> > 2.44.0
> >
> >
> >
>
>
> --
> Hugo Villeneuve

I compiled a kernel before sending on x86. Which options are you
using? I will try to replicate it. I cannot run this kernel on actual
hardware, because I need vendor patches - support of my board is not
mainlined.

