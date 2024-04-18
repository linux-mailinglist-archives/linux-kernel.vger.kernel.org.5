Return-Path: <linux-kernel+bounces-150537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29598AA0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B521B236A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD35171E5A;
	Thu, 18 Apr 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="H8KCbhtt"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9511CA0;
	Thu, 18 Apr 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459865; cv=none; b=rIhrgvuSMXCsjV/ar0H2O1G7l3gAg5zRUAjE5RxY+Qep9zcNObrq0kBd+T9KGQV/KRAzJqHzAo7A5eoP9sW+3W7dh+mbSG0tiYk+ECUe2jpR4TWeuHgSZP/l/tCZROSoJ7Fazib54JgQfSqiKZlwj/a5Uw/bxwt9Amf4q3fOQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459865; c=relaxed/simple;
	bh=8t3mzVbhg7VIOrJ13vEvF8hN/RoRblY/+EPd39bcfvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2J21gI+EdYFvc6+V9DSAZ+MXaBdgnsA/LoPgJPvk7lSP2h1ldCvdzKLq3Ixo+kgmqNX2XBbCeOzwVrTKzfB3ZBeFffLXzZzTjkxEe1/W5po1Q/r1aSvB9sCusspEfz6oQ02S8hJe4r2pCQ6u5QoCSsIGXENqAAREyAA9Ez3ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=H8KCbhtt; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713459848; x=1714064648; i=parker@finest.io;
	bh=3WxzWEkv/+/p5CFzPMwdj95KJfjxCJT9ZlcPi/TkxzY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H8KCbhttlMMTJCwlLdF4VYpZuL7hkK4KgUZxJaoKqD+tR5Ef91fYHlDmS0/e6uR7
	 uY1oidUcYeMqktBCG8AsbyuHEkOdsWkzQoaj7pYntwVZTuiVukLYvS/YyZK3gu0cd
	 wPBX7S1fRWiwxlGZ96qLa7bWYgfOTV5kDCL3rO6EwefN9v83HNG7dX3AaZ/jJfm78
	 5i8CgTtM6go8BuIAYnAfsDjIxIQq4nUxFTLsaYnk1mnC5fA2PxWj0jeObco8TWiVp
	 +t08xYNooOxHYgoDYLjcwtSgc/8Guir//b7wDVOQaSSpX4p7X3yV8lqUvUdx1jkod
	 NlJQuaLbJEoNsv+AeQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M8OiS-1stIV81lH0-014OrK; Thu, 18 Apr 2024 19:04:08 +0200
Date: Thu, 18 Apr 2024 13:03:46 -0400
From: Parker Newman <parker@finest.io>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 6/7] serial: exar: add CTI specific setup code
Message-ID: <20240418130346.12530fdb@SWDEV2.connecttech.local>
In-Reply-To: <8c91f3a5-e124-aa28-06bb-2e6a699d4998@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com>
	<ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com>
	<f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com>
	<20240418102153.554d56ba@SWDEV2.connecttech.local>
	<8c91f3a5-e124-aa28-06bb-2e6a699d4998@linux.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AlTQzZP5MP5yb3jbnelbJ/My4vSJTR1sIg35r9f/CPRIjkkHp4H
 y1gcrQ7Y9sCxB/nj/KMGn1YETW8PF9idOVDj2TTsJ8yfbWw7yuplwyxLbCauk42Z92JDrLk
 5nWxOPnNWcfRrNWeL8RdOyATRYxYr1+sM3MojfSMGX9S9AfTUrC+1Ta9SXwFBR/MDyaMify
 g2l6Qj1JoqI1dbs5siQUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tjcr0Ahnnec=;gteE6YzDXl5uqbwyvx7UohYmLNk
 JsbPXtz/URu0wLgqY5eY+LN+E5LVOZNbq4rISUy/1f9w52wkUFyw4XmciPZyGj73LWVYo3Yt0
 IugX/J5neCpHVdCdcbdDSH9RJO2AgpXEm0+eGp30+mO0rfYWlG6+Q+7K7kGpvzT2ioiSgA99x
 C8ZHUejanlT3niJaT24Ms7lQtPcMwvfkJT+oASBPanNfnont1eTDXpP7iNey9VJi/4XEbUMeS
 UZXVFibNIhLP7Xx5yObi5/FtvtciW4V63GjYgWAxAlnnXKu85qgcr7AN+hOUHKS34A0PzA98x
 A/f/85XSU9MrzWtn6ZJxtYkTkhRjNvUb68UxYcryI8Nqd1cRCLQE2YkmXUSm0c0b+Qbak1Tpv
 226eav7rndECgztJmVbiHbYCNMjxz+1wBNE0DJ935YTyV5ee4VhM7yn898uLpxpQ30O5sXNH2
 8HaYzPtJEChmUaFcPw9DzHx1Gg2rnG5zG/e1yiqDxYZGgWp5FAZc9H0BIz4gooGOKFNrLEVKr
 56pLD5g1tw67Tmcys/Vv+p1rUirz3xDIHryfPXPh1N039dlzWwYFbvO+g5Q2ELg208AipGAkB
 7qmkA6fDwCUZQ8lOXJNTF+7NtbqTT2O3yP15UPQ29seB7iEpAmac8Qg6nX8ICutDHC8jtOLX/
 5gQL6Kui1mrrXIFR3aucrm33BBllLFXtazd5Zx+eFq/UfQRTAeAhnT0rQQ9ca8Dnvi9Oy3wJv
 X8dL0sgQcdYW3KoEfpYaWVDGEoNbEN2+v4UbQx8yf+5hPkz965+g/U=

On Thu, 18 Apr 2024 19:29:44 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 18 Apr 2024, Parker Newman wrote:
> > On Thu, 18 Apr 2024 16:20:15 +0300 (EEST)
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >  =20
> > > On Wed, 17 Apr 2024, Parker Newman wrote: =20
> > > > From: Parker Newman <pnewman@connecttech.com>
> > > >=20
> > > > This is a large patch but is only additions. All changes and remova=
ls
> > > > are made in previous patches in this series.
> > > >=20
> > > > - Add CTI board_init and port setup functions for each UART type
> > > > - Add CTI_EXAR_DEVICE() and CTI_PCI_DEVICE() macros
> > > > - Add support for reading a word from the Exar EEPROM.
> > > > - Add support for configuring and setting a single MPIO
> > > > - Add various helper functions for CTI boards.
> > > > - Add osc_freq to struct exar8250
> > > >=20
> > > > Signed-off-by: Parker Newman <pnewman@connecttech.com> =20
>=20
> > > > @@ -192,11 +252,201 @@ struct exar8250_board {
> > > >=20
> > > >  struct exar8250 {
> > > >  	unsigned int		nr;
> > > > +	unsigned int		osc_freq;
> > > >  	struct exar8250_board	*board;
> > > >  	void __iomem		*virt;
> > > >  	int			line[];
> > > >  };
> > > >=20
> > > > +static inline void exar_write_reg(struct exar8250 *priv,
> > > > +				unsigned int reg, u8 value)
> > > > +{
> > > > +	writeb(value, priv->virt + reg);
> > > > +}
> > > > +
> > > > +static inline u8 exar_read_reg(struct exar8250 *priv, unsigned int=
 reg)
> > > > +{
> > > > +	return readb(priv->virt + reg);
> > > > +}   =20
> > >=20
> > > I tried to understand what is going on with this priv->virt in 8250_e=
xar=20
> > > in general and why it exists but I failed. It seems to BAR0 is mapped=
=20
> > > there but also serial8250_pci_setup_port() does map the same BAR and=
=20
> > > sets it up into the usual place in membase.
> > >  =20
> >=20
> > Exar PCI/PCIe UARTs have global configuration registers from 0x80-0x9B.
> > These registers are for reading the EEPROM, configuring the MPIO, etc.
> > As these registers are only at 0x80, and not port specific, the driver =
maps
> > BAR0 to priv->virt for accessing them.  =20
>=20
> Okay, thanks for explaining. The naming & lack of comments wasn't exactly=
=20
> making it easy to follow this bit (this is not your fault in anyway but=20
> a pre-existing problem in the driver's code).
>=20
> I've a follow up question now that it's confirmed they're different,=20
> see below...
>=20
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TR=
GD);
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);   =20
> > >=20
> > > Unnecessary parenthesis. =20
>=20
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TR=
GD);
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
> > > > +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);   =20
> > >=20
> > > Unnecessary parenthesis.
> > >  =20
> >=20
> > I will fix these in my cleanup patches.  =20
>=20
> Based on the wording in your response, I'm not sure you got this right. I=
t=20
> is code you're adding in this patch so the parenthesis should be removed=
=20
> from this change so they never appear in the commit history.
>=20

Greg has already merged this series into his testing branch. I assumed any
changes would need to be made in a separate patch series? Sorry if I=20
misunderstood. I already sent these fixes in a new mini-series.=20

> > > I recommend you add a helper for this as it is repeated twice. Are th=
e=20
> > > values 32 and 128 literal or do they have some specific meaning? If t=
he=20
> > > latter case, they should be using named defines (this likely applies =
to=20
> > > the existing trigger code in the driver too).
> > >=20
> > >  =20
> >=20
> > They are the FIFO trigger levels so they are literally 128 and 32.  =20
>=20
> Okay, no problem then if its 128 characters and 32 characters.
>=20
> > These 4 writes come from Exar's out-of-tree driver and are in=20
> > pci_xr17v35x_setup() and some other vendor specific functions.=20
> >=20
> > I am not sure why/if these are needed.  =20
>=20
> ...So the follow-up question. I see the existing code in=20
> pci_fastcom335_setup() and pci_xr17v35x_setup() writes into membase=20
> based address but your code uses exar_write_reg() which is priv->virt=20
> based. Is this difference intentional?
>=20

Both methods are effectively the same thing. I used exar_write_reg() to be
consistent with my other code and it is a bit cleaner than:

	u8 __iomem *p;

	p =3D port->port.membase;

	writeb(0x00, p + UART_EXAR_8XMODE);

