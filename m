Return-Path: <linux-kernel+bounces-135260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBF89BE0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607EC1C2125D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4424657C5;
	Mon,  8 Apr 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="cxWklAGe"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2795FB97;
	Mon,  8 Apr 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575317; cv=none; b=eXSLxARZfn78WGInb5j5FPo4HTqQCL8Tm677hjBaL3TKntocW1YZqpwgbV97WsTtZev1H7sokS3KmOvoom0W1D2koWW/Eyg6M4qBMpJM+SUEl4JPb4IB49bGBTd32e9Lz7SrKI94dJJmYPy0H7rrN08TPazzQajVqV3gehEnD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575317; c=relaxed/simple;
	bh=fdquaXWCbYL4ik7x4w+mTdj5QkTTmaC30QJ1pMlJkJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfhRVxvH+yqyg2c2eti9ahw5ibkSXyAVjbBpK7JHndJXqflgkG65yaxUlnwtP/KWDOWCWcbXEKO3Y5JfnB/5oIy4irNH/ix51V1KqC+hCADB83K8mozkA4v8Md5kfup/fqSJmDMLoJehTr2IzFPRq+9gOj1ul+5OhTmM6X2tR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=cxWklAGe; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2F9B51C006B; Mon,  8 Apr 2024 13:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712575312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BrP8N21nXarKEWVxpMkevruH+XMKp5XToFxXZz5jtTM=;
	b=cxWklAGeXe6x3EkvF82RB5i7oLcXDXwKw3Y7ozLZDFUGQNZVVQczWqUPVycL5ywH4XJPTo
	h1w+sBy0Wv4iKUUMPmzMVVqkaw4cceMGBKRCcokHcTVr0ktLqjTJHcMVoT+CnRGTTzHt/n
	XbbeHL3NCwuQPQNBGREv7pN7ZnrXnq0=
Date: Mon, 8 Apr 2024 13:21:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	megi@xff.cz
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNyKrA94GXh8GmU"
Content-Disposition: inline
In-Reply-To: <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>


--PGNyKrA94GXh8GmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> > but I did best I could.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> ...
>=20
> > +  cabledet-gpios:
> > +    maxItems: 1
> > +    description: GPIO controlling CABLE_DET (C3) pin.
> > +
> > +  avdd10-supply:
> > +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
> > +
> > +  dvdd10-supply:
> > +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
> > +
> > +  avdd18-supply:
> > +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
> > +
> > +  dvdd18-supply:
> > +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
> > +
> > +  avdd33-supply:
> > +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
> > +
> > +  i2c-supply: true
> > +  vconn-supply: true
>=20
> There are no such supplies like i2c and vconn on the schematics.
>=20
> I think this represents some other part of component which was added
> here only for convenience.

Can you give me pointer to documentation you are looking at?

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--PGNyKrA94GXh8GmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhPTTwAKCRAw5/Bqldv6
8pSfAKChCJQYbXh+ffiYIr3g7dsXssSWbQCfT8lWq5X3vnCAnv25EY7uJIVeogE=
=7fNt
-----END PGP SIGNATURE-----

--PGNyKrA94GXh8GmU--

