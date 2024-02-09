Return-Path: <linux-kernel+bounces-59900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81884FD19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08AA1C22249
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373883CB7;
	Fri,  9 Feb 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="sTmoAfGk"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179B81AA5;
	Fri,  9 Feb 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507853; cv=none; b=Cw0l7GzK0RDmZl4zudEm927sujgUoPG9gPypLkVB7tc+zYLAby5DpBbPh/90kG5ioMAOV9rC+Q2qdezdnSuth2SuQEj1KNSdfBvHuZ/ek11RkI+mYhaDuRCfINx35VNT6eIRa/CH0B7BdP5DyRBeaPM2LQAaP0nG4Bo1vXygjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507853; c=relaxed/simple;
	bh=Y5NzkBo9Pss0qlsTCcbI1qPnckcndo6/QONgzTvCArw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdGa4ggKR/vAZOplE0W9MxtfyyuLZS1XzH0f8UQ26y5JihuMl4mxanfXe7BV87diRftHDRkQkdWutTRnaW4QPOFUFYuBCVnqT4r8wZj/WLS5gl+cjDHqTNICZ7FH7nJN5f09OKr9apv5n6u7lgrtefmqPIsQrfXWxu6xtyH8YP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=sTmoAfGk; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 73BA71C007B; Fri,  9 Feb 2024 20:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1707507842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONTTT+r/HyquDcQPq/M190iHbV9h/M5HxT6bxZXpo3k=;
	b=sTmoAfGkTBI6qeSlUPGA9ehBSnsDJq6stffOparvSkIozVnvZLsSQ1AF4bk+v3Qxck81L8
	01hquF6Y6b+plX+GlouzUDuVLZW09yUj2PA/sumYWFRIGt86r4juy1+OWggEUT18cA2Ggg
	dDYocnP54ybJZ/xw2czDFOcy76mIk7E=
Date: Fri, 9 Feb 2024 20:44:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	phone-devel@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de,
	martijn@brixit.nl, samuel@sholland.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: anx7688: Add driver for ANX7688 USB-C HDMI
 bridge
Message-ID: <ZcaAgXwmpTxISn3t@duo.ucw.cz>
References: <Zbt1dIByBZ2stzjm@mobian>
 <iikhv7e2z3pk7nr6bvtuepwyrmukym5fjtc2xspsmhxzz5jlwe@5vfs4i3w66kc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TjKZTdICc2XbU5ZB"
Content-Disposition: inline
In-Reply-To: <iikhv7e2z3pk7nr6bvtuepwyrmukym5fjtc2xspsmhxzz5jlwe@5vfs4i3w66kc>


--TjKZTdICc2XbU5ZB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Ondrej Jirman <megi@xff.cz>
> >=20
> > This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> > features removed. ANX7688 is rather criticial piece on PinePhone,
> > there's no display and no battery charging without it.
>=20
> Don't remove the flashing part. Some Pinephones come without the firmware
> in the past. Even recently, I've seen some people in the Pine chat
> asking how to flash the firmware on some old PinePhone.
>=20
> It's a safe operation that can be done at any time and can only be done
> from the kernel driver.

I can re-add it later, but initial merge will be tricky enough as-is.

> > There's likely more work to be done here, but having basic support
> > in mainline is needed to be able to work on the other stuff
> > (networking, cameras, power management).
> >=20
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>=20
> I should be second in order of sign-offs. Martijn wrote a non-working ske=
leton
> https://megous.com/git/linux/commit/?h=3Dpp-5.7&id=3D30e33cefd7956a2b49fb=
27008b4af9d868974e58
> driver. Then I picked it up and developed it over years to a working thin=
g.
> Almost none of the skeleton remains.

I believe From: should match First signed-off. I guess Martijn should
be marked as co-developed-by or something like that?

> License is GPLv2.

Ok.

> > +	ret =3D of_property_read_variable_u32_array(dev->of_node, "sink-caps",
> > +						  anx7688->snk_caps,
> > +						  1, ARRAY_SIZE(anx7688->snk_caps));
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get sink-caps from DT\n");
> > +		return ret;
> > +	}
>=20
> ^^^ The driver will need to follow usb-c-connector bindings and it will n=
eed
> a bindings documentation for itself.
>=20
> That's one of the missing things that I did not implement, yet.

Yep, I fought with device trees for few days. I should have yaml
ready.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--TjKZTdICc2XbU5ZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcaAgQAKCRAw5/Bqldv6
8hVHAJwKdrMSwlHGJgCePaiwKzXOXwsYGQCgmaWFSFHZOLEP8pMfPXnkuU8afj8=
=zDar
-----END PGP SIGNATURE-----

--TjKZTdICc2XbU5ZB--

