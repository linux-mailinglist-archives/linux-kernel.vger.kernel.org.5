Return-Path: <linux-kernel+bounces-99563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444F7878A01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39612817A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB156B74;
	Mon, 11 Mar 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="bbeHYL9c"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDF53807;
	Mon, 11 Mar 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192163; cv=none; b=MCdiqJiES+pQmlmYDJw5NlxpKLGRpNV9T5YxvsPtKzUP75CnhsrTVCJ8c6NS46Lnw2esAFQmUnTuugNpHsrIpa/ipe3kQvhYxaayeTiFmvqt4GAtJ3gkwC/gpPc3jFDqrjbBmL/e5I5hKJ4Bu3xrA3hJRUhBzaWFmavRGUtiQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192163; c=relaxed/simple;
	bh=P2boA6Eawfa0M0KZc/2wVwLRGNk2pGbWY4vmAVWmoYc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aifqARdpit3X0JxdsV3PM2DEDt14OwmCG7uH2SVXKxj8NUQyz1ehO82w01wMz4lNRlk2W/3Ug9ksJM3I+1SMt2kvEpT9BX+3Vvk0TTIwT6fL4lpLd+s+wXO98E8P8Np5C4TQIh4gKubVd7MK4xGDkAzvqYmiz1d3pcM1q4+uyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=bbeHYL9c; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 420FD1C006B; Mon, 11 Mar 2024 22:22:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710192160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbqvhn5XQIBZXIcVmp5Nrb6H8LpgxJhD1MjdLluSexE=;
	b=bbeHYL9c7+Uf4LNsiOKraSAWBeFDX23tQ4ck0XXA1qKwMKnqsIvZNQlbOVSyLmjeOOHErV
	kS6ykttG+6PB61Ig+5FNtKP8AJfENBB14kF4CjjCHHcd0tPyXrpWXEToKxlqXhH80cRXZu
	ACmF1sLujRmnzvnysycudfJLpX2/RXA=
Date: Mon, 11 Mar 2024 22:22:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCHv2 2/2] usb: typec: anx7688: Add driver for ANX7688 USB-C
 HDMI bridge
Message-ID: <Ze92H+/CbGIFuACl@duo.ucw.cz>
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
 <ZdkOESbty6iMfyhj@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lVnmtm3O7+AJlfOQ"
Content-Disposition: inline
In-Reply-To: <ZdkOESbty6iMfyhj@duo.ucw.cz>


--lVnmtm3O7+AJlfOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Ondrej Jirman <megi@xff.cz>
>=20
> This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> features removed. ANX7688 is rather criticial piece on PinePhone,
> there's no display and no battery charging without it.
>=20
> There's likely more work to be done here, but having basic support
> in mainline is needed to be able to work on the other stuff
> (networking, cameras, power management).
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Any comments here?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--lVnmtm3O7+AJlfOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZe92HwAKCRAw5/Bqldv6
8vNPAKCxJUHB7UA/4hGeH7aybwht+iS1YgCfXuiC0l3YAEPxY/J8ovquh7j0McI=
=xTTK
-----END PGP SIGNATURE-----

--lVnmtm3O7+AJlfOQ--

