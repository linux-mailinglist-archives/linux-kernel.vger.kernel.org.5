Return-Path: <linux-kernel+bounces-142688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E58A2ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D62280EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB935EE73;
	Fri, 12 Apr 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="prjL34Gr"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8055D73D;
	Fri, 12 Apr 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927230; cv=none; b=DOBeJy7QAB2G0LxtXJimh/CBb4F+ASzpRdAdBwhH6CGNut2WPIng8zliVkPyF05juqQR98JfwPz2cpLe44w/wMYv+owJHOKZN/a90khElpddgEbukqjry1XerpuRL/V+S9NDsf+JBEYW31WXTMl+SBhO0azeXzuBfxUZkEO035o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927230; c=relaxed/simple;
	bh=rKCe+ru0sIIg/gVq56Bi1gfIUtdAzd5dD4bqK3F1UG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuxnBYdnW76b77ParbiV1XMSXoXg8HSAfXNT+uP+voXIcOn6Uv7rpdXtZudKcnStLs8cKv0XYv0aKI6OgzueH+78Es1TkI5idF77mSXLJIi9BkfQ9KtUw7d6uBUnWuhQWJPBp6ir2W1Aol0x926XZPaONk/OKqc6YjIxIed0eQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=prjL34Gr; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712927216; x=1713532016; i=parker@finest.io;
	bh=Brp8PPWU1GgjfxLdssNi6MpQZBUA/d0iMTD/w1/+Nt8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=prjL34GrZ0PT9lrBRioHA42gxB+lcWF2pEmALp6+fCB41lXLWYn0vXybjvaDpkdO
	 YZOTHMEeLFYN9Af+bHrpBPJPZJ7E9fyIzfRSOAgrv2hu0hoA6JnxGC5JGZ9xPiPsp
	 KXt4QQzSnvtYQy//KC9jyynUhbkdvAHXoWXMv0j7/UPnSrACyOMhcpKfMcHUPDKDZ
	 OJtRpbkqTRVVlOBojv3D0A3FKfV5Kl1U9ue+EOEeAV6hO8snMyEgSX7Pgg2IEVD6p
	 vokzs6ijPkWLpe6D8a9vKg0CE6N1G31H9FB7oun6i3G1SZ3t9hHcHOsJSQrOS5FEb
	 2Nn44zs9OYzD/f4+6A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LvDe8-1svaOw2UMc-010IMM; Fri, 12 Apr 2024 15:06:56 +0200
Date: Fri, 12 Apr 2024 09:06:54 -0400
From: Parker Newman <parker@finest.io>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 2/7] serial: exar: add support for reading from Exar
 EEPROM
Message-ID: <20240412090654.54c43612@SWDEV2.connecttech.local>
In-Reply-To: <2b817d47-52f6-bc9b-cb24-4f540101ea50@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>
	<2b817d47-52f6-bc9b-cb24-4f540101ea50@linux.intel.com>
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
X-Provags-ID: V03:K1:+cZav3GqS522N3/b6WTixeO4zQeD4c9H+MSi67F2JVbiFqK/Lxo
 dHMyeSPtwBvDcDHhAbYyShm004fYZBRZ//RSo85LFlvvLheuV/xuT+EmzsjEbfYfGWaSEIl
 DVUa6NImwKLmX6KHOzO8oRO72EcqgvTfGxuT9Rs3+emtKwbAprye6YFY7YnFgQ2pC/WFh+S
 DSnVCJjzAcxUCo3GmwPhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:90UXfPez/NA=;NUO32OZvhgDrW+EPC8F4hUdjKdr
 Tjvcfu08S4skfqDiCOmkR4B1Wj26FGNfIRptEHcMgzGx5cJzVio72HpyH4dtBW5u+5Pf2F1xz
 uITYxNDICrkhzveAugTfpbjHJjDIxq19MPGtRTPK56eOHfKE0nnvXUp3IwnQzlZFdALBsMET8
 XVwntZTeL8FDxagq1euMFVZrpGuAgVgDqO7aILo/cQpZQCTL/afU/OB+OkY0o9TJdHjPwB1aJ
 PUurYnED9fqEAyYgMSSWADySXl2YqTHGuQWuNr1Y2ZKRyZpdRg2KP/ZcOf2/BRanmTDuKqYXu
 UxpfnsvSLY9wbasETPwbi6fSTt+nfca4d+ptCHESeRlHDXxY6J3da1uGdZ4XRy/p8njCDeBp3
 l7HOdrb8Cj5v0R0BlrqSESzyzwoXQmRbbQI0s7dSOOZadeoLjp7Li/4bn87hnl8hnUZYPh2qE
 uTMxjEkc38jFQn9ENAVLK3GofUtJB3dQSoh3xCcKnaBBow4JElAV32gspadY4RgP6/OWexpBW
 V2YlMhYQw9oXMeZkOZqKgFPiZyIjzFZiTTyhylRMtKncwYXMqFaK5L2KUELkXv3lj3VezKBf2
 pti6GK81wVEyq/m/dkC1EpcADkxOnJq4XtyugOrNm5/ziwnB8G+oKHWzZkPZzRUgY276Mctz9
 2LmeQlH/Gh7gJa1G1+ozBLGolyZ0maYhQAhjfk8+4BL4UvdimVHj+keb09n/jY8RVthWsBGJz
 HmOfAJ02/q4oYyYrQcLovCGBFeZHmv0mlHsHtMd2l2gweI8wIvtHDE=

On Fri, 12 Apr 2024 13:36:42 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 11 Apr 2024, parker@finest.io wrote:
>=20
> > From: Parker Newman <pnewman@connecttech.com>
> >=20
> > - Adds support for reading a word from the Exar EEPROM.
> > - Adds exar_write_reg/exar_read_reg for reading and writing to the UART=
's
> > config registers.
> >=20
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 110 ++++++++++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8=
250/8250_exar.c
> > index 4d1e07343d0b..49d690344e65 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -128,6 +128,16 @@
> >  #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
> >  #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polari=
ty */
> >=20
> > +/* EEPROM registers */
> > +#define UART_EXAR_REGB                  0x8e
> > +#define UART_EXAR_REGB_EECK             BIT(4)
> > +#define UART_EXAR_REGB_EECS             BIT(5)
> > +#define UART_EXAR_REGB_EEDI             BIT(6)
> > +#define UART_EXAR_REGB_EEDO             BIT(7)
> > +#define UART_EXAR_REGB_EE_ADDR_SIZE     6
> > +#define UART_EXAR_REGB_EE_DATA_SIZE     16
> > +
> > + =20
>=20
> Extra new line.
>=20
> >  /*
> >   * IOT2040 MPIO wiring semantics:
> >   *
> > @@ -195,6 +205,106 @@ struct exar8250 {
> >  	int			line[];
> >  };
> >=20
> > +static inline void exar_write_reg(struct exar8250 *priv,
> > +				unsigned int reg, uint8_t value)
> > +{
> > +	if (!priv || !priv->virt)
> > +		return;
> > +
> > +	writeb(value, priv->virt + reg);
> > +}
> > +
> > +static inline uint8_t exar_read_reg(struct exar8250 *priv, unsigned in=
t reg)
> > +{
> > +	if (!priv || !priv->virt)
> > +		return 0;
> > +
> > +	return readb(priv->virt + reg);
> > +}
> > +
> > +static inline void exar_ee_select(struct exar8250 *priv, bool enable)
> > +{
> > +	uint8_t value =3D 0x00;
> > +
> > +	if (enable)
> > +		value |=3D UART_EXAR_REGB_EECS; =20
>=20
> You could just do:
> 	u8 value;
>=20
> 	value =3D enable ? UART_EXAR_REGB_EECS : 0;
>=20
> Or even:
>=20
> 	exar_write_reg(priv, UART_EXAR_REGB, enable ? UART_EXAR_REGB_EECS : 0);
> > +
> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
> > +}
> > +
> > +static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
> > +{
> > +	uint8_t value =3D UART_EXAR_REGB_EECS;
> > +
> > +	if (bit)
> > +		value |=3D UART_EXAR_REGB_EEDI;
> > +
> > +	//Clock out the bit on the i2c interface
> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
> > +
> > +	value |=3D UART_EXAR_REGB_EECK;
> > +
> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
> > +}
> > +
> > +static inline uint8_t exar_ee_read_bit(struct exar8250 *priv)
> > +{
> > +	uint8_t regb;
> > +	uint8_t value =3D UART_EXAR_REGB_EECS;
> > +
> > +	//Clock in the bit on the i2c interface
> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
> > +
> > +	value |=3D UART_EXAR_REGB_EECK;
> > +
> > +	exar_write_reg(priv, UART_EXAR_REGB, value);
> > +	udelay(2);
> > +
> > +	regb =3D exar_read_reg(priv, UART_EXAR_REGB);
> > +
> > +	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
> > +}
> > +
> > +/**
> > + * exar_ee_read() - Read a word from the EEPROM
> > + * @priv: Device's private structure
> > + * @ee_addr: Offset of EEPROM to read word from
> > + *
> > + * Read a single 16bit word from an Exar UART's EEPROM =20
>=20
> Add missing .
>=20
> > + *
> > + * Return: EEPROM word on success, negative error code on failure =20
>=20
> This function does not return any -Exx code as far as I can see??
>=20
> > + */
> > +static int exar_ee_read(struct exar8250 *priv, uint8_t ee_addr)
> > +{
> > +	int i;
> > +	int data =3D 0;
> > +
> > +	exar_ee_select(priv, true);
> > +
> > +	//Send read command (opcode 110)
> > +	exar_ee_write_bit(priv, 1);
> > +	exar_ee_write_bit(priv, 1);
> > +	exar_ee_write_bit(priv, 0);
> > +
> > +	//Send address to read from
> > +	for (i =3D 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>=3D 1)
> > +		exar_ee_write_bit(priv, (ee_addr & i));
> > +
> > +	//Read data 1 bit at a time
> > +	for (i =3D 0; i <=3D UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> > +		data <<=3D 1;
> > +		data |=3D exar_ee_read_bit(priv);
> > +	}
> > +
> > +	exar_ee_select(priv, false);
> > +
> > +	return data;
> > +} =20
>=20

I will fix all of these.=20
Thanks,
-Parker

