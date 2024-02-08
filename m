Return-Path: <linux-kernel+bounces-58673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508384E9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406D5B231A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA964EB38;
	Thu,  8 Feb 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN9toC51"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F64A990;
	Thu,  8 Feb 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425057; cv=none; b=Qvd5hw1utsXT92zqUIR16R4YYcdOnv2FngbRJJu6zfCa1pom7ojuF23Ap6TwkTGNX1W3WK8y/+vT7Kp5TiPC8RAfhSU2kOwDSBQmANT+GdUb6UHO0HsqhEBVwfU/py2Mk0wGhNn2wc+CGWnuzrkqxV+Ez7q6bFJTasL/BOHDoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425057; c=relaxed/simple;
	bh=qRU3iyaNpE+Rb447l6RJ0FET7PNDqULjkzw4mJQ4ng8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=madKijA0jtsrbsnZok+lSbLNBiDT5Ybn6Sg2vIIsWGYIB8HC2KZIFRTOiCJTLWnZ/P+xdTTJcpvMjnaoWVkblFtC7b0nPS2FV96LaC7uIhVa2xUW60cbCKFLCP/CmvXVFVxiXUkXF9mKCd2O1gVXgzcrLC/XWnLlCZu4dx57wtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN9toC51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7D5C433F1;
	Thu,  8 Feb 2024 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707425055;
	bh=qRU3iyaNpE+Rb447l6RJ0FET7PNDqULjkzw4mJQ4ng8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AN9toC51pq/9x8QIWVxF4buscSvG4ysb+w20x6vnPRzxQsjRq1o6Adm/kO4s0vT7h
	 H83rkBpj/4M+Go3njXtX08ASUQLDhlyklHa2woNAuwe9iarkgYoM6kOpnsZXuUMvfE
	 IZujNzlLudUhADK9j8uWViZFmNJdh6PgXroB8trZD41s97ztXeLzZzTNVZn/GY75R8
	 3SewPmB3dvUHOyxj3hv2Y5NjynVxSarYvitpX2IvVJd0j8ZmFnfJ62+kicZVyMzhSN
	 b3rbYOKJqdFH8BZzNOVc0eBecHxrPpava3AjXVQSjQjrwpMJKHesnZPOL0evariV/J
	 HyJh+lwB5J2gA==
Date: Thu, 8 Feb 2024 20:44:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <20240208-morbidly-submerge-fcafe85bffc9@spud>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
 <20240208165937.2221193-15-andriy.shevchenko@linux.intel.com>
 <20240208-chute-bacteria-75425bd34dc9@spud>
 <ZcUamOqKUuA-ahRY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sxJRa8heXZCzXt88"
Content-Disposition: inline
In-Reply-To: <ZcUamOqKUuA-ahRY@smile.fi.intel.com>


--sxJRa8heXZCzXt88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 08:16:56PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 05:50:51PM +0000, Conor Dooley wrote:
> > On Thu, Feb 08, 2024 at 06:58:57PM +0200, Andy Shevchenko wrote:
> > > Add initial device tree documentation for Maxim MAX6958/6959.
> >=20
> > Why "initial"? Are there elements this display that you've not
> > documented yet?=20
>=20
> s/documented/implemented/

Oh no, I meant documented. Whether or not you implement support in the
driver doesn't really matter, but you should endeavour to document as
much of the hardware as possible. Certainly simple things like
interrupts.

> There are features of the hardware that may need additional properties.
>=20
> > > +title: MAX6958/6959 7-segment LED display controller with keyscan
> >=20
> > > +properties:
> > > +  compatible:
> > > +    const: maxim,max6959
> >=20
> > Where's the max6958's compatible? I don't see it in your driver either.
>=20
> For now, see above, there is no need.=20

I don't know what I am supposed to see above.

> Moreover, there is no need at all
> as we have autodetection mechanism. I don't see why we should have two
> compatible strings just for the sake of having them.
>=20
> > It seems that the max6959 has some interrupt capabilities that are not
> > available on the max6958, so a dedicated compatible seems suitable to
> > me.
>=20
> So, please clarify the DT's p.o.v. on the hardware that can be autodetect=
ed.
> Do we need to still have different compatible strings? What for? I don't
> see the need, sorry for my (silly) questions.

If there's an auto-detection mechanism, which is a valid justification,
you need to put it in the commit message. If you don't it just looks
like you're missing a compatible.
The advantage of a dedicated compatible is restricting the properties
that would only apply to either the 6958 or 6959 to just that device.

You've only partially documented these devices though, so it is not
clear how much of a divergence there'd actually be.

cheers,
Conor

--sxJRa8heXZCzXt88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcU9GwAKCRB4tDGHoIJi
0hs+AQDCko8IQ57nsKd0xBsoOxTDO7hnzRgkrEyfG9eQFeWRpQEA78y+k53qmS8I
JdySkG1FA4lAUXaiepc4F+RFVXbhYgo=
=HrI2
-----END PGP SIGNATURE-----

--sxJRa8heXZCzXt88--

