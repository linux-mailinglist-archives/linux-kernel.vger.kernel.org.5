Return-Path: <linux-kernel+bounces-142739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D658A2F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37051C21F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761E83CCE;
	Fri, 12 Apr 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="jIAcMZ9w"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAC1DFD9;
	Fri, 12 Apr 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928984; cv=none; b=M8NLKaEHvklJZM5fnulVt0GWQ8HWYFTOWU13r8VnnPJZziI5gdRoz8G44hTbxr84QOdXEwAKl3fx4SM2W3rxMsdtNtFe2dOlwDtiUFD/ztHNNPVROEwdzxsgd2IU3rYzagfAX8r7U4GLW7lQPIkfyhB8PemaK5b6sv/8ixKyA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928984; c=relaxed/simple;
	bh=+f12AoCq1Uk7MdNTnhqJMwJbAErNbJVN3OzdMGHbrj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqRxfjkyhJVJiCCFH9VynGrs5FxH2ncTLn6mTPHJhaGhVMUesUqsmskjBxXFxwrGDw8My6JV9EzCFU8CFabFhUab0DDaNFCtFiM08zYQWQEvDbInpFGxHVmmW2fJaEt0zlAJrSEnronLWBuaKn4Hccmvt8x/dI0PVXX6QgCZ7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=jIAcMZ9w; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712928975; x=1713533775; i=parker@finest.io;
	bh=Gt74haBilWrf2DFuac5s7xs1UEykV4iYzenuK42Ti6w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=jIAcMZ9wRc2YuUHrfuNZc8a/ZmNDzNnZxZ5qb8lEc0fvg+D14rTfCamwaHTmbiKS
	 uzEoCkR1TnBW9ZFpHLO0dyaNcvq/HafZyGhTzWCKmMwSCJb2l/qKUZ09ODxaYq9Hw
	 WSO3nSOIhYquidnxSuyDZ9Z0LCPW0qBWePdejFCtI3kdk94Ot+6wIPr04Lq8062yG
	 mPCRV5trFIPbFj50FlBz5BAAKhITwTN5B5Y+i3OEIApJjgMnBQweMd6Xr0L8q7XK+
	 5CQlSsh3KyDb6DZnrdtZdc6fowL+GKWRLwMYBA528F/P6vXQln4dtmUCVPE6qLQYx
	 A4JCAWah7zo7nB6fKQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MVerB-1sGSpd3f83-00YwhH; Fri, 12 Apr 2024 15:36:14 +0200
Date: Fri, 12 Apr 2024 09:36:13 -0400
From: Parker Newman <parker@finest.io>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/7] serial: exar: add support for config/set single
 MPIO
Message-ID: <20240412093613.0cbb4362@SWDEV2.connecttech.local>
In-Reply-To: <b057b1e2-1cf9-2f20-2453-b359a1e89f01@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>
	<b057b1e2-1cf9-2f20-2453-b359a1e89f01@linux.intel.com>
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
X-Provags-ID: V03:K1:bkX7ucM1qk5+VnygobM35POx/lwpyru7giJyC2mlhFqkUEc5uTf
 BWLkZK/7UTKX2uy3pAqbuEsaMik5dZu4d9+h8iClEILL2HJ1enAg0TBt8JdeCQdbflt9mg2
 kbkXG8vRE5zjFAJpzNEFopnBkwNsEJg6XzihZCts8z21vxzkQBX8vlPIatBf6Q0UsSvrYS6
 hwMvNZ8wTrfIsyH2BlmdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z11ttMU+Sow=;yZ1j1QLlQ7kqOHJfM1vaNxLdMci
 vEF5vMlPI5vB6+orJavTlmip6jjKG60mb1gQJ0Qrgi6mz23izlJ5LsV33fBBgj6PdBMBvqGv4
 dG9dLOnvTtJp39klqP+oLQWdQWLOYvH7z4y3Vb0Log+56US4/K49lWWsT7/LZ4CPv456rd+rE
 MdcCvkd6gcbdtC7KwHi4xHwD4p8W1dIIsFaPx4choiXr3V50x0BCplUc5EeGCuXQ+loA08Q5F
 XdTGOx6gG+DfB3m/v8gciVzHKYRYDVQa1UsmfEFp0ewe7G1VbWeej0RJ41IbiLsiSTShESWaF
 /vjA8QFdc4lxXga/xSzbOyyEYmRwh875xp6LUtrfvDDDXo1Cji+Gw8y2zvqKbuVi4wjQnNefQ
 3wFLIEIT3U+eDZ9d/ULXitEN0CKEE8UDFUmMgUR41MShUMvb06FwhjJwMgkieRMS8ZdHWrH0a
 kb01iQZSWiFrt/ky9dG8jueWfJHGvGowiAGHUIcHElDVNhMsPKQNGcLSVJ+PPNqY9We0rUtMT
 Owt5/BD4k66ZNcJ9OW56hGB0egKr+SfpaIIQjz3oXTBaGQ6+/oMhKApWVsQ5hXO86CQwXV3bQ
 /y8xXDtvNDzV1VgMQLvje0LNrqy4qCuWIn6D5DT02JDJ1ytJTsuivhOkB0rq85YRILDq4/oN4
 0HOHT8QSQ1vkCJRjawRkxFrVykn0mgXKXlxA/ghxr7Wq6uwxnn+F7BrsSduGc+rIyNxaxmMbn
 stiwrOWV8bj1jb05URYsRPMvWFbBSmd4dHOGWUsAtUY+kjfMW9u2yM=

On Fri, 12 Apr 2024 13:20:41 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 11 Apr 2024, parker@finest.io wrote:
>=20
> > From: Parker Newman <pnewman@connecttech.com>
> >=20
> > Adds support for configuring and setting a single MPIO
> >=20
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 88 +++++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8=
250/8250_exar.c
> > index 49d690344e65..9915a99cb7c6 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -305,6 +305,94 @@ static int exar_ee_read(struct exar8250 *priv, uin=
t8_t ee_addr)
> >  	return data;
> >  }
> >=20
> > +/**
> > + * exar_mpio_config() - Configure an EXar MPIO as input or output
> > + * @priv: Device's private structure
> > + * @mpio_num: MPIO number/offset to configure
> > + * @output: Configure as output if true, inout if false
> > + *
> > + * Configure a single MPIO as an input or output and disable trisate. =
=20
>=20
> tristate
>=20
> > + * If configuring as output it is reccomended to set value with
> > + * exar_mpio_set prior to calling this function to ensure default stat=
e. =20
>=20
> Use () if talking about function.
>=20
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int exar_mpio_config(struct exar8250 *priv,
> > +			unsigned int mpio_num, bool output)
> > +{
> > +	uint8_t sel_reg; //MPIO Select register (input/output)
> > +	uint8_t tri_reg; //MPIO Tristate register
> > +	uint8_t value;
> > +	unsigned int bit;
> > +
> > +	if (mpio_num < 8) {
> > +		sel_reg =3D UART_EXAR_MPIOSEL_7_0;
> > +		tri_reg =3D UART_EXAR_MPIO3T_7_0;
> > +		bit =3D mpio_num;
> > +	} else if (mpio_num >=3D 8 && mpio_num < 16) {
> > +		sel_reg =3D UART_EXAR_MPIOSEL_15_8;
> > +		tri_reg =3D UART_EXAR_MPIO3T_15_8;
> > +		bit =3D mpio_num - 8;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	//Disable MPIO pin tri-state
> > +	value =3D exar_read_reg(priv, tri_reg);
> > +	value &=3D ~(BIT(bit)); =20
>=20
> Use more meaningful variable name than "bit", it could perhaps even avoid=
=20
> the need to use the comment if the code is self-explanary with better=20
> variable name.
>=20
> > +	exar_write_reg(priv, tri_reg, value);
> > +
> > +	value =3D exar_read_reg(priv, sel_reg);
> > +	//Set MPIO as input (1) or output (0) =20
>=20
> Unnecessary comment.
>=20
> > +	if (output)
> > +		value &=3D ~(BIT(bit)); =20
>=20
> Unnecessary parenthesis.
>=20
> > +	else
> > +		value |=3D BIT(bit);
> > +
> > +	exar_write_reg(priv, sel_reg, value); =20
>=20
> Don't leave empty line into RMW sequence.
>=20
> > +
> > +	return 0;
> > +}
> > +/**
> > + * exar_mpio_set() - Set an Exar MPIO output high or low
> > + * @priv: Device's private structure
> > + * @mpio_num: MPIO number/offset to set
> > + * @high: Set MPIO high if true, low if false
> > + *
> > + * Set a single MPIO high or low. exar_mpio_config must also be called
> > + * to configure the pin as an output.
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int exar_mpio_set(struct exar8250 *priv,
> > +		unsigned int mpio_num, bool high)
> > +{
> > +	uint8_t reg;
> > +	uint8_t value;
> > +	unsigned int bit;
> > +
> > +	if (mpio_num < 8) {
> > +		reg =3D UART_EXAR_MPIOSEL_7_0;
> > +		bit =3D mpio_num;
> > +	} else if (mpio_num >=3D 8 && mpio_num < 16) {
> > +		reg =3D UART_EXAR_MPIOSEL_15_8;
> > +		bit =3D mpio_num - 8;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	value =3D exar_read_reg(priv, reg);
> > +
> > +	if (high)
> > +		value |=3D BIT(bit);
> > +	else
> > +		value &=3D ~(BIT(bit)); =20
>=20
> Extra parenthesis.
>=20
> > +
> > +	exar_write_reg(priv, reg, value); =20
>=20
> Again, I'd put this kind of simple RMW sequence without newlines.
>=20
> > +
> > +	return 0;
> > +} =20

I will fix above.=20

> There are zero users of these functions so I couldn't review if two=20
> functions are really needed, or if the difference could be simply handled=
=20
> using a boolean parameter.
>=20

The functions are used by code in other patches in this series.=20

I kept exar_mpio_set() and exar_mpio_config() separate because we plan on
adding support for other features in the future that require reading and=20
writing MPIO.=20

Thanks,
-Parker


=20

