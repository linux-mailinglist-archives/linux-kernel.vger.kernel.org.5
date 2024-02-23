Return-Path: <linux-kernel+bounces-77882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96053860B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E2128262A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360014AAE;
	Fri, 23 Feb 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Vq+fZKmD"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69314A8C;
	Fri, 23 Feb 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674459; cv=none; b=Qxt/G/U12VxOzgMyxo1Bxz6excbNtdpSmZuAjFEIt+VVd8zj3XgcuN3AEdXc/DhpKblhXGufPV7Nn0JKPTWvsydaKsYngG9UHUl5I1AQDOcSTTug9fNpK+x7j9BEr89+ULqqfv/K1FNFBlFwHnrhX4y5LnLa1UG8z2VNxpONPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674459; c=relaxed/simple;
	bh=dakXAoUwybWwoGMWZfdTc8ldPExi8xKCBV6CWj3leCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLQoKmPXWTOloX39yfNk/3IED7Pw/idYDcLgM2BF2/PjKyQYykDOIK0MD9ZB5U/HfZI4tgYmcNW3jT6lEiRFAnnIjDiRg5gttCyOKzs8rWQRHHK4qw8w1KA7+yFS1+qwa//fIiExkk7O3rWYIn5W942D1hsb5kvKCQZF0xykUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Vq+fZKmD; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 50CF41C0080; Fri, 23 Feb 2024 08:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708674453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce5HkTYASA33I56IAyhmdG33rVUQPOyGT/uJIx9/trs=;
	b=Vq+fZKmDjInp+2GboJUiFHaP9nTcpq47lLljE5/ryHmf4shX02b9F0N5mpS7URFic4p06n
	52twNA/Dgwu4QV18jBf4KL8O6Pt9fxk6KzQROLWCs8ilEgpXe6A3rFqf1gKpD1VIMIyK05
	CMFYGW97zmVteb5cD3oIzFY+hz5asow=
Date: Fri, 23 Feb 2024 08:47:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Message-ID: <ZdhNlUotGJCklJTs@duo.ucw.cz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain>
 <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
 <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
 <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com>
 <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E6eqKPZfu8IShWOk"
Content-Disposition: inline
In-Reply-To: <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz>


--E6eqKPZfu8IShWOk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Right, but also with some additional properties, like
> > - type of the indicator (7, 14, etc segments, for now we have only
> > these two supported)
> > - use-dot (+1 led per each digit)
> > - characters (how many digits we have, so we need respective amount of =
GPIOs)
> >
> > With this it's indeed belongs directly to auxdisplay as we have almost
> > everything is done already there.
>=20
> I've been playing about with this. I've got an auxdisplay driver that's=
=20
> basically working (I won't bother spamming list with it yet). But I'm=20
> wondering how I'd represent multiple characters. I kind of feel the=20
> natural representation would be something like.
>=20
>  =A0=A0=A0=A0=A0=A0=A0 led-7seg {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "generic,7-=
segment-on-gpio";
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char-0 {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 segment-gpios =
=3D <&gpio 0 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0 =A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &gpio 1 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0 =A0 =A0=A0=A0=A0=A0=A0=A0 &gpio 2 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0 =A0 =A0=A0=A0 &gpio 3 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0 &gpio 4 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 &gpio 5 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0 &gpio 6 GPIO_ACTIVE_LOW>;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char-1 {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 segment-gpios =
=3D <&gpio 8 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0 =A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &gpio 9 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0 =A0 =A0=A0=A0=A0=A0=A0=A0 &gpio 10 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0 =A0 =A0=A0=A0 &gpio 11 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0 &gpio 12 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 &gpio 13 GPIO_ACTIVE_LOW
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 =A0 &gpio 14 GPIO_ACTIVE_LOW>;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>  =A0=A0=A0=A0=A0=A0=A0 };
>=20
> But having those sub-nodes means I can't just use devm_gpiod_get_array()=
=20
> instead I'd have to use device_for_each_child_node() and=20
> devm_fwnode_gpiod_get_index(). Am I missing something? I could do away=20
> with the sub-nodes and have properties like "segment-0-gpios",=20
> "segment-1-gpios" but that feels awkward.

One solution would be to treat separate digits as separata devices
:-).

Other would be saying you don't have hardware for that, and make it
someone else's future problem.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--E6eqKPZfu8IShWOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdhNlQAKCRAw5/Bqldv6
8rq7AJ9pBX3jWCZOuYr6ImDa9LPgqwb8kgCfYRQsL9gOcZVAvjG7CU18xj2IY1Y=
=Gbls
-----END PGP SIGNATURE-----

--E6eqKPZfu8IShWOk--

