Return-Path: <linux-kernel+bounces-75074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353785E296
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB051F25AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA185946;
	Wed, 21 Feb 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5Ct9CLh"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DE85651;
	Wed, 21 Feb 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531379; cv=none; b=rDximMABXCHMEaWktxFFqkg6wceUKISuh8ZvYkssxEcweepNdyh8+hOhJMDJUXUq5uLaHJspRu7MBeDNb17cPyB0jtH8bMyHPqhb+1tyvJ8w8uoTdIFT9/Iun4aSZzM+eIvliGh5OYxkKiWR2ozsYWqzwE2xhPT3eedHaYAgtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531379; c=relaxed/simple;
	bh=N65iXSjU/h0ELkZkUlceQfqdX38DRu2buPhtEJ4dLQI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WQx3nYJMdibey/Tr1e6yFPVzUE59lPhyFvkQptLKWMBG1PwO6VxHIUrcu2QRcY4UNsYupQ8skq3e2utKmKRd56X1yxQeJCOZbI/Dw1Tb7ZCqgsR32DXDFD+zhpluTWyMXdRO5LrpLr7R+0mlCD57q4GZn1LcVwbfSW4+DKkCiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5Ct9CLh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0619D40007;
	Wed, 21 Feb 2024 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708531372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXbmWq1iYuKDOOGKfD5Ci1T2sY0QXJfhciM8bKHhdb0=;
	b=N5Ct9CLh7AbDeQnE8aCydJ0xJbJ2daqddQuOB0AJiMqVTu8n2WycvnhoDi2gb9AQI1a9A7
	DLd1nvSy9EDhUcuFCg6raWyc5PcHmJ7j9AKCBj8uaj6cwpy1VJPBODb7zZOeP9m6u8iGj+
	wIOL9QRu9rwaR91Rd8dVO/GJRkS6PLJCliWCg5pLAonMoFaiTQ9muooFuQSxRBqK62zLJk
	o9+b4bFgFvrRVsnIGWljKXJraqvf48ettxpK1/eIuk0mLxzucfIS3JUnN9G176qnA5v0QR
	SNgGFrs/ptnquRahTr8irkWKVs6V9HoGRxgAYhFDIzA+AhpHN+uL9jiFHwQOHQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 17:02:51 +0100
Message-Id: <CZAVTOOYBRY0.FH5RTPSXS8QN@bootlin.com>
Subject: Re: [PATCH 05/23] gpio: nomadik: extract GPIO platform driver from
 drivers/pinctrl/nomadik/
Cc: "Linus Walleij" <linus.walleij@linaro.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
 <CAMRc=MfXHbpq7vgw64pYGGAyQQnYyGa1ei5NAQ6swtH7o--R=w@mail.gmail.com>
In-Reply-To: <CAMRc=MfXHbpq7vgw64pYGGAyQQnYyGa1ei5NAQ6swtH7o--R=w@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Bartosz,

On Mon Feb 19, 2024 at 5:08 PM CET, Bartosz Golaszewski wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
> >
> > Previously, drivers/pinctrl/nomadik/pinctrl-nomadik.c registered two
> > platform drivers: pinctrl & GPIO. Move the GPIO aspect to the
> > drivers/gpio/ folder, as would be expected.
> >
> > Both drivers are intertwined for a reason; pinctrl requires access to
> > GPIO registers for pinmuxing, pull-disable, disabling interrupts while
> > setting the muxing and wakeup control. Information sharing is done
> > through a shared array containing GPIO chips and a few helper
> > functions. That shared array is not touched from gpio-nomadik when
> > CONFIG_PINCTRL_NOMADIK is not defined.
> >
> > Make no change to the code that moved into gpio-nomadik; there should b=
e
> > no behavior change following. A few functions are shared and header
> > comments are added. Checkpatch warnings are addressed. NUM_BANKS is
> > renamed to NMK_MAX_BANKS.
> >
> > It is supported to compile gpio-nomadik without pinctrl-nomadik. The
> > opposite is not true.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  MAINTAINERS                                        |   1 +
> >  drivers/gpio/Kconfig                               |  12 +
> >  drivers/gpio/Makefile                              |   1 +
> >  drivers/gpio/gpio-nomadik.c                        | 660 +++++++++++++=
++++++
> >  drivers/pinctrl/nomadik/Kconfig                    |   5 +-
> >  drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |   3 +-
> >  drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |   3 +-
> >  drivers/pinctrl/nomadik/pinctrl-nomadik.c          | 722 +------------=
--------
> >  .../linux/gpio/gpio-nomadik.h                      | 122 +++-
> >  9 files changed, 804 insertions(+), 725 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0cb2c459d1cf..3f864e773267 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2474,6 +2474,7 @@ F:        drivers/clk/clk-nomadik.c
> >  F:     drivers/clocksource/clksrc-dbx500-prcmu.c
> >  F:     drivers/dma/ste_dma40*
> >  F:     drivers/pmdomain/st/ste-ux500-pm-domain.c
> > +F:     drivers/gpio/gpio-nomadik.c
> >  F:     drivers/hwspinlock/u8500_hsem.c
> >  F:     drivers/i2c/busses/i2c-nomadik.c
> >  F:     drivers/iio/adc/ab8500-gpadc.c
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 1301cec94f12..ff83371251c1 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -478,6 +478,18 @@ config GPIO_MXS
> >         select GPIO_GENERIC
> >         select GENERIC_IRQ_CHIP
> >
> > +config GPIO_NOMADIK
> > +       bool "Nomadik GPIO driver"
> > +       depends on ARCH_U8500 || ARCH_NOMADIK || COMPILE_TEST
> > +       select OF_GPIO
> > +       select GPIOLIB_IRQCHIP
> > +       help
> > +         Say yes here to support the Nomadik SoC GPIO block.
> > +
> > +         It handles up to 32 GPIOs per bank, that can all be interrupt=
 sources.
> > +         It is deeply interconnected with the associated pinctrl drive=
r as GPIO
> > +         registers handle muxing ("alternate functions") as well.
> > +
> >  config GPIO_NPCM_SGPIO
> >         bool "Nuvoton SGPIO support"
> >         depends on ARCH_NPCM || COMPILE_TEST
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index 9e40af196aae..9fc2f5931b22 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -116,6 +116,7 @@ obj-$(CONFIG_GPIO_MT7621)           +=3D gpio-mt762=
1.o
> >  obj-$(CONFIG_GPIO_MVEBU)               +=3D gpio-mvebu.o
> >  obj-$(CONFIG_GPIO_MXC)                 +=3D gpio-mxc.o
> >  obj-$(CONFIG_GPIO_MXS)                 +=3D gpio-mxs.o
> > +obj-$(CONFIG_GPIO_NOMADIK)             +=3D gpio-nomadik.o
> >  obj-$(CONFIG_GPIO_NPCM_SGPIO)          +=3D gpio-npcm-sgpio.o
> >  obj-$(CONFIG_GPIO_OCTEON)              +=3D gpio-octeon.o
> >  obj-$(CONFIG_GPIO_OMAP)                        +=3D gpio-omap.o
> > diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> > new file mode 100644
> > index 000000000000..e39477e1a58f
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-nomadik.c
> > @@ -0,0 +1,660 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * GPIO driver for the IP block found in the Nomadik SoC; it is an AMB=
A device,
> > + * managing 32 pins with alternate functions. It can also handle the S=
TA2X11
> > + * block from ST.
> > + *
> > + * The GPIO chips are shared with pinctrl-nomadik if used; it needs ac=
cess for
> > + * pinmuxing functionality and others.
> > + *
> > + * Copyright (C) 2008,2009 STMicroelectronics
> > + * Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
> > + *   Rewritten based on work by Prafulla WADASKAR <prafulla.wadaskar@s=
t.com>
> > + * Copyright (C) 2011-2013 Linus Walleij <linus.walleij@linaro.org>
> > + */
>
> Add a newline here.

This commit tries its best to not modify the file too much. It mostly is
a copy-and-paste. The goal is to have a sensible diff between old
drivers/pinctrl/nomadik/pinctrl-nomadik.c and new
drivers/gpio/gpio-nomadik.c. We wait until later commits to fix stuff.

Should below comments "avoid new calls to X" still be taken into
account, knowing that this is old code being moved around?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

------------------------------------------------------------------------


