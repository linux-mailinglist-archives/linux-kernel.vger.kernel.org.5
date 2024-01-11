Return-Path: <linux-kernel+bounces-23871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EC82B301
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522D5B21A59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747650255;
	Thu, 11 Jan 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtX9kBJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AD51000;
	Thu, 11 Jan 2024 16:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C6EC433F1;
	Thu, 11 Jan 2024 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990787;
	bh=cBOEHJ4jz+911gd0H8RzE2SvkvqohyMtgT/JyoRoh4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtX9kBJ2RSIaZ5ApbfyL+BVDfVPnIICVdVWIvT3ELBc6rohF8c68fWZffaqmk1e21
	 m1f1XHU3TOoLQJUySrZ3+AiibNy3MiERrRcR5TJhzAhbGBqZJPRuS3sXjlMy6q7kMF
	 Jeegz3p4QclI2UQecnwkIaumwMWFuNI3elKOqlaO0ubg/54TY7fjZonfFuEUsTHsd9
	 QYfX8U5MDLMa/gMxlJKM0wAsJ6LDnEisFZHSfGVPQdcpjLYXgGhRMGZU2gQ1UfoBQW
	 acCJmwEWl5e3ltqrGilZXn7AKYIokzifF0+ZpaFZMX6j0UAED9buN1GUg9g2IEqcud
	 DmYzMVcgBoJlQ==
Date: Thu, 11 Jan 2024 16:33:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: hmc425a: add conditional GPIO
 array size constraints
Message-ID: <20240111-numerate-aqueduct-9eaaa4dfc572@spud>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
 <20240110153757.5754-2-mitrutzceclan@gmail.com>
 <20240110-unfitting-squander-b1d71c185bb7@spud>
 <478d9445-96aa-44b3-b598-8f7d7716dbba@gmail.com>
 <20240111-suitcase-collage-889fa8404ab2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLcpOGUKLjHDM79r"
Content-Disposition: inline
In-Reply-To: <20240111-suitcase-collage-889fa8404ab2@spud>


--SLcpOGUKLjHDM79r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 04:31:40PM +0000, Conor Dooley wrote:
> On Thu, Jan 11, 2024 at 10:17:58AM +0200, Ceclan Dumitru wrote:
> >=20
> >=20
> > On 1/10/24 18:17, Conor Dooley wrote:
> > > On Wed, Jan 10, 2024 at 05:37:09PM +0200, Dumitru Ceclan wrote:...
> > >>    ctrl-gpios:
> > >>      description:
> > >> -      Must contain an array of 6 GPIO specifiers, referring to the =
GPIO pins
> > >> -      connected to the control pins V1-V6.
> > >> -    minItems: 6
> > >> +      Must contain an array of GPIO specifiers, referring to the GP=
IO pins
> > >> +      connected to the control pins.
> > >> +        ADRF5740  - 4 GPIO connected to D2-D5
> > >> +        HMC540S   - 4 GPIO connected to V1-V4
> > >> +        HMC425A   - 6 GPIO connected to V1-V6
> > >> +    minItems: 1
> > >>      maxItems: 6
> > >> =20
> > >> +allOf:
> > >> +  - if:
> > >> +      properties:
> > >> +        compatible:
> > >> +          contains:
> > >> +            const: adi,hmc425a
> > >> +    then:
> > >> +      properties:
> > >> +        ctrl-gpios:
> > >> +          minItems: 6
> > >=20
> > >> +          maxItems: 6
> > >=20
> > > This one should not be needed, it's already set by constraints on the
> > > property above.
> > >=20
> >=20
> > No, not needed, just inspired from:
> >  /bindings/clock/samsung,exynos7-clock.yaml
> >=20
> > Specifically, the top constraints:
> >   clocks:
> >=20
> >     minItems: 1
> >=20
> >     maxItems: 13
> >=20
> > One of the conditional constraints:
> >   clocks:
> >=20
> >     minItems: 13
> >=20
> >     maxItems: 13
> >=20
> >=20
> > I would only have two arguments for this staying here:
> >  - It stays consistent with other cases
> >  - In the case a new device with more than 6 GPIOs is added, this would
> > need to be put back in
>=20
> Okay.

Sorry, that's probably super unclear. I meant it's okay to leave it.


--SLcpOGUKLjHDM79r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaAYPgAKCRB4tDGHoIJi
0jalAQCPzckyn2TpzYdmBZKa/c3mDGk156cx45W8rNKZyQr3awD8Chazl9EKk0I2
8pWYm0pVfUobXV74ZFjqNmRG9pqKMQQ=
=3NAy
-----END PGP SIGNATURE-----

--SLcpOGUKLjHDM79r--

