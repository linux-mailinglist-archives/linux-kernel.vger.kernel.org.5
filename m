Return-Path: <linux-kernel+bounces-136724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43889D796
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EE91C213D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1DC85C73;
	Tue,  9 Apr 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="DlxH/Fna"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF501811E9;
	Tue,  9 Apr 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660665; cv=none; b=Q6zuMhK64D7vou+2qr5pL69YbNAN+KVPIRh49V4QZPJxI1B998kD0Td/3jeu6hdSoGmBWYYfd0/rcCUjKDhagPq/QG58oruOpbEdUBEsEAPzR0S+7cmQ/MFmOaGbIKutkMiMY+fCVp90TsMF8ybcn5JNvDTdH2AU+Rxq5HMFnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660665; c=relaxed/simple;
	bh=qqf5a/EY02zPcDiutgF2yPSaWnzOls7BMpdi+ctjzRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXD5jXt+6aub2rD07p4vLwsf1Mil9EBq096RtvpIGIoBQYum0GLpD1OaP1DGN/SCL+d/UTTcu/PNQDTw6up+h1FFdfcnEZutHNvV4kdg0ojwH445N2UBzwMoMNGqegMeQE1xn23wUgOGafY8vjqI7Ak8+TSXMP3yyBjfJEoLWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=DlxH/Fna; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F22911C007B; Tue,  9 Apr 2024 13:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712660653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ+v7gDWnIHLHrKpLguqCMBP/+unrvR2yYCVCES/Tcw=;
	b=DlxH/Fnam4Xic6XHXP9QYSXq49VMSvA6hQBciBC7KWYICbyYBdNUEKvuBe3ehgJ2ALQ4MX
	+NkMcDnSIZUlcCqVLVekfxblhZ38WIJhVsq4lF2y3JMTWBkAkiwLgFBGNBkrEos9L7k76P
	F3pweM24Mt5N9Iz+SIMc9W5J2IQIwY8=
Date: Tue, 9 Apr 2024 13:04:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCHv3 2/2] usb: typec: anx7688: Add driver for ANX7688 USB-C
 HDMI bridge
Message-ID: <ZhUgrNwRYoaV1AIJ@duo.ucw.cz>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ZhPM4XU8ttsFftBd@duo.ucw.cz>
 <ZhUQ6kzV5ARlkfPC@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e3VgoD62Ejch02x1"
Content-Disposition: inline
In-Reply-To: <ZhUQ6kzV5ARlkfPC@kuha.fi.intel.com>


--e3VgoD62Ejch02x1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> > features removed. ANX7688 is rather criticial piece on PinePhone,
> > there's no display and no battery charging without it.
> >=20
> > There's likely more work to be done here, but having basic support
> > in mainline is needed to be able to work on the other stuff
> > (networking, cameras, power management).
> >=20
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Co-developed-by: Martijn Braam <martijn@brixit.nl>
> > Co-developed-by: Samuel Holland <samuel@sholland.org>
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> Just couple of quick comments below - I did not have time to go over
> this very thoroughly, but I think you need to make a new version in
> any case because of comments in 1/2.

Yes, there will be new version.

There is ton of sleep primitives, and existing ones are okay. I can
change everything to fdelay or whatever primitive-of-the-day is, but
I'd rather not do pointless changes.

You can ask for major changes, or complain about extra newlines, but
doing both in the same email does not make sense.

> Btw, Co-developed-by comes before Signed-off-by I think.

I believe this order is fine, too.

> > +++ b/drivers/usb/typec/anx7688.c
> > @@ -0,0 +1,1830 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ANX7688 USB-C HDMI bridge/PD driver
> > + *
> > + * Warning, this driver is somewhat PinePhone specific.
>=20
> So why not split this into core part and PinePhone specific glue
> part?

Potentially a lot of work I can't really test and would rather not do.

> > +	struct delayed_work work;
> > +	struct timer_list work_timer;
> > +
> > +	struct mutex lock;
>=20
> Undocumented lock.

This is simple driver. How do you expect me to document it? Protects
this data structure, not exactly uncommon.

> > +
> > +	/* wait for power to stabilize and release reset */
> > +	msleep(10);
> > +	gpiod_set_value(anx7688->gpio_reset, 0);
> > +	usleep_range(2, 4);
>=20
> Why not just use usleep_range() in both cases.

It does not really make code any better. Can do if you insist.

> > +static int anx7688_connect(struct anx7688 *anx7688)
> > +{
> > +	struct typec_partner_desc desc =3D {};
> > +	int ret, i;
> > +	u8 fw[2];
> > +	const u8 dp_snk_identity[16] =3D {
> > +		0x00, 0x00, 0x00, 0xec,	/* id header */
> > +		0x00, 0x00, 0x00, 0x00,	/* cert stat */
> > +		0x00, 0x00, 0x00, 0x00,	/* product type */
> > +		0x39, 0x00, 0x00, 0x51	/* alt mode adapter */
> > +	};
> > +	const u8 svid[4] =3D {
> > +		0x00, 0x00, 0x01, 0xff,
> > +	};
>=20
> Why not get those from DT?

Are you sure it belongs to the DT (and that DT people will agree)?

> > +	u32 caps[8];
> > +
> > +	dev_dbg(anx7688->dev, "cable inserted\n");
> > +
> > +	anx7688->last_status =3D -1;
> > +	anx7688->last_cc_status =3D -1;
> > +	anx7688->last_dp_state =3D -1;
> > +
> > +	msleep(10);
>=20
> Please make a comment here why you have to wait, and use
> usleep_range().

/* Dunno because working code does that and waiting for hardware to
settle down after cable insertion kind of looks like a good thing */

I did not write the driver, and there's no good documentation for this
chip. I can try to invent something, but...

> > +	i =3D 0;
> > +	while (1) {
> > +		ret =3D anx7688_reg_read(anx7688, ANX7688_REG_EEPROM_LOAD_STATUS0);
> > +
> > +		if (ret >=3D 0 && (ret & ANX7688_EEPROM_FW_LOADED) =3D=3D ANX7688_EE=
PROM_FW_LOADED) {
> > +			dev_dbg(anx7688->dev, "eeprom0 =3D 0x%02x\n", ret);
> > +			dev_dbg(anx7688->dev, "fw loaded after %d ms\n", i * 10);
> > +			break;
> > +		}
> > +
> > +		if (i > 99) {
> > +			set_bit(ANX7688_F_FW_FAILED, anx7688->flags);
> > +			dev_err(anx7688->dev,
> > +				"boot firmware load failed (you may need to flash FW to anx7688 fi=
rst)\n");
> > +			ret =3D -ETIMEDOUT;
> > +			goto err_vconoff;
> > +		}
> > +		msleep(5);
> > +		i++;
> > +	}
>=20
> You need to use something like time_is_after_jiffies() here instead of
> a counter.

Well, this works as well, but yes, I agree here.

> > +	ret =3D i2c_smbus_read_i2c_block_data(anx7688->client,
> > +					    ANX7688_REG_FW_VERSION1, 2, fw);
> > +	if (ret < 0) {
> > +		dev_err(anx7688->dev, "failed to read firmware version\n");
> > +		goto err_vconoff;
> > +	}
> > +
> > +	dev_dbg(anx7688->dev, "OCM firmware loaded (version 0x%04x)\n",
> > +		 fw[1] | fw[0] << 8);
> > +
> > +	/* Unmask interrupts */
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_STATUS_INT, 0);
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_STATUS_INT_MASK, ~ANX7=
688_SOFT_INT_MASK);
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_IRQ_EXT_SOURCE2, 0xff);
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_IRQ_EXT_MASK2, (u8)~AN=
X7688_IRQ2_SOFT_INT);
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	/* time to turn off vbus after cc disconnect (unit is 4 ms) */
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_VBUS_OFF_DELAY_TIME, 1=
00 / 4);
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	/* 300ms (unit is 2 ms) */
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_TRY_UFP_TIMER, 300 / 2=
);
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	/* maximum voltage in 100 mV units */
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_MAX_VOLTAGE, 50); /* 5=
 V */
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	/* min/max power in 500 mW units */
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_MAX_POWER, 15 * 2); /*=
 15 W */
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_MIN_POWER, 1);  /* 0.5=
 W */
> > +	if (ret)
> > +		goto err_vconoff;
> > +
> > +	/* auto_pd, try.src, try.sink, goto safe 5V */
> > +	ret =3D anx7688_reg_write(anx7688, ANX7688_REG_FEATURE_CTRL, 0x1e & ~=
BIT(2)); // disable try_src
>=20
> Those two comments are obscure.

I hoped they make sense to someone familiar with the area. Can't do
much better than remove them.

> This function seems to have lot of hard coded information above.
> Shouldn't much of that come from DT?

You tell me, I suppose you seen some similar drivers.

> Please note that if you have that PinePhone specific glue driver, you
> can get much of the hard coded information from there, if getting the
> information from DT is not an option for what ever reason.

Thanks for review.

Could you trim the parts of email you are not replying to?

Do you see any other major problems?

Do you have any idea if this chip is used elsewhere? I do not have any
other hardware with anx7688, so I won't be able to test it elsewhere,
and if there are no other users, having specific driver should not be
a problem for anyone. If there's other user, well, there's chance they
have docs and can help.

How would you envision the split? Do you have any other driver that
could be used as an example? Is someone else putting them in the
device tree?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--e3VgoD62Ejch02x1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhUgrAAKCRAw5/Bqldv6
8tdbAJ9whsn5MtGDbYUeie+RE5DcrfiBTQCfd0dzide5IWF2ZejjVK++2UM1z+Q=
=UoGp
-----END PGP SIGNATURE-----

--e3VgoD62Ejch02x1--

