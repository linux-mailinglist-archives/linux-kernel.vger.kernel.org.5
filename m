Return-Path: <linux-kernel+bounces-66929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281AB8563B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D992B25CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0913FF5;
	Thu, 15 Feb 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZbCU7rO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304F12E1C3;
	Thu, 15 Feb 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001569; cv=none; b=YOe4yeay1w352ScOF+uj/UTLOdB05u/DjRDbqnUFXxz8AvhnVCZBSTBI6rrd8jEvIywDzk3znwrfv0+ooDueSJZBsHI2YbJiyM5+rYPFYHvPTVH8lOYOJzlvTYMt5uJEUyKc4YIIHqxVmLXnRwfwt2G3w96MbdxVJjZXwqUmgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001569; c=relaxed/simple;
	bh=F0unL5VuXkG8H7993BUREvJS7UUzi8Iu+yOsyj+bbuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYEHFIAki7oxwOcOiNn0GMr2QsnK4HJkzXnmdDy8vajtE4ReWXaGSAv7L7m8u7h6S9BuLEJ/nP5nZszpxXgY8RZdycPOlu7itWj+Hhw1PMj41OG5KooB9YaLiqwuz30uNo1G+diLe37XEQGCQXccnFxavzqKtj4Clye+HxfC24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZbCU7rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A5FC433F1;
	Thu, 15 Feb 2024 12:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708001568;
	bh=F0unL5VuXkG8H7993BUREvJS7UUzi8Iu+yOsyj+bbuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZbCU7rOcaW4HF/VJkFNGBEO4QKh+hos4AUxFmd8z9gQtif/uotluzP9Ie1MJ2AKj
	 ccTb+IcaRfYEW5BFy6ROKH9JzxNP6dVAxw/qjrr8tgdl7lpySoJ1uDmCYu6b3iMIEg
	 MdDyj7ykYSmI0xJZNveKSSv0jqRfYL2mEDLxpJXLu7sl4BhthELmTbxxGstu/RV8sZ
	 jHYFzS88Br7bxzV2E9MgE6/DJsMcl6Ez8Zw9d9i3wnlQPq3b9iuFasii/0tCVd54Nc
	 86fdeQDUF2cFq9qVHBR5o70lQYUEBdXocLsJDbZw8kSquJOavntQj3GdUvErmLBl+6
	 i6q3OZ4UY2v9w==
Date: Thu, 15 Feb 2024 12:52:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	robh+dt@kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240215-demystify-abacus-c8fbfe1e9f2b@spud>
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-5-alisa.roman@analog.com>
 <20240208-occupancy-shudder-514d8569e261@spud>
 <73d01418-65e2-4327-b6b3-c4de501c2920@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eVxVWuwy3y01LPUE"
Content-Disposition: inline
In-Reply-To: <73d01418-65e2-4327-b6b3-c4de501c2920@gmail.com>


--eVxVWuwy3y01LPUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 02:13:38PM +0200, Alisa-Dariana Roman wrote:
> On 08.02.2024 20:03, Conor Dooley wrote:
> > Hey,
> >=20
> > On Thu, Feb 08, 2024 at 07:24:58PM +0200, Alisa-Dariana Roman wrote:
> >=20
> > > +patternProperties:
> > > +  "^channel@([0-7a-f])$":
> > > +    type: object
> > > +    $ref: adc.yaml
> > > +    unevaluatedProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: The channel index.
> > > +        minimum: 0
> > > +        maximum: 7
> >=20
> > There are only 8 possible channels, at indices 0 to 7, so why is the
> > pattern property more permissive than that? Shouldn't "^channel@[0-7]$"
> > suffice?
> >=20
> > > +
> > > +       diff-channels:
> >=20
> > > +        description: |
> > > +          The differential channel pair for Ad7194 configurable chan=
nels. The
> > > +          first channel is the positive input, the second channel is=
 the
> > > +          negative input.
> >=20
> > This duplicates the description in adc.yaml
> >=20
> > > +        items:
> > > +          minimum: 1
> > > +          maximum: 16
> >=20
> > Hmm, this makes me wonder: why doesn't this match the number of channels
> > available and why is 0 not a valid channel for differential measurement=
s?
> >=20
> > Thanks,
> > Conor.
>=20
> Hello and thank you for the feedback!
>=20
> I will change the pattern property and the description.
>=20
> Regarding the channels, I followed the existing style of the driver for t=
he
> AD7194 channels: one iio channel for each pseudo-differential input
> channel(AINx - AINCOM), summing up to 16 channels; and one iio channel for
> each differential channel (AINx - AINy), summing up to 8 channels.

I don't know what question this is answering. Everything here is about
channels so it is hard for me to relate it back.
Please reply inline & not at the end of the message to everything :)
Was it meant to answer the following?

> > > +    properties:
> > > +      reg:
> > > +        description: The channel index.
> > > +        minimum: 0
> > > +        maximum: 7
> >=20
> > There are only 8 possible channels, at indices 0 to 7, so why is the
> > pattern property more permissive than that? Shouldn't "^channel@[0-7]$"
> > suffice?

If it was a response to this, the reg property only allows 8 channels so
the regex should only allow 8 too. The number after @ must match the number
in reg. If using each of the 16 "pseudo-differential" inputs in
isolation is thing you want to be able to do, your reg property does not
allow it.

> For the
> diff-channels, I thought the possible values should be 1->16 corresponding
> to AIN1->AIN16 (I will add this to the description as suggested by David).

With a description, this should be fine.

--eVxVWuwy3y01LPUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc4JGwAKCRB4tDGHoIJi
0uGpAQDJPZr9YPefeO7EEWAtw6D6/mFbOUDNFDHU5QLxuDJz2QD+KySncCvuevdB
iY+/Lv/jb2kLjyD5AhdAh3y9bA/icQ0=
=MYMP
-----END PGP SIGNATURE-----

--eVxVWuwy3y01LPUE--

