Return-Path: <linux-kernel+bounces-23870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8282B2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457FD28B4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC934F8A1;
	Thu, 11 Jan 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVCo7t3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B14F8A0;
	Thu, 11 Jan 2024 16:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE11C433C7;
	Thu, 11 Jan 2024 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990705;
	bh=U1X2QWSXEg//IKtKtRyY+42Ctp17xlrN2XZx68DSDoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVCo7t3H64sRsursu9ArdrG/SaPfjjLJiEYI6egm5VvdcdoSPKfPCg5d+rbuqSQbR
	 NIyBExP9bXGwS1tTubW0NUCAaPHjUxNvC67ZHZCsQvxQs870NuIdCJK0sguAu/HODp
	 bLQLeniaLjn6yg2Vph7JNq/vvbBD+TqpYfFdcYev7J6l0xByTJ5nmKwFw+nYExT+aB
	 5wWbVfQb+C5rcTmdxm2OxXNjOJy/kc/EIUGlIdfFHMiaiFUoPKRDu+v0mKQHpq9/w6
	 66D+4aBle1VlvFsCdFgdbBrsElbybxBzIbEDvCrpWyREdnnAwyD21K151NLa6YatCi
	 r1MbK4TBzqGyg==
Date: Thu, 11 Jan 2024 16:31:40 +0000
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
Message-ID: <20240111-suitcase-collage-889fa8404ab2@spud>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
 <20240110153757.5754-2-mitrutzceclan@gmail.com>
 <20240110-unfitting-squander-b1d71c185bb7@spud>
 <478d9445-96aa-44b3-b598-8f7d7716dbba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T/gFBDvK/h08vZL+"
Content-Disposition: inline
In-Reply-To: <478d9445-96aa-44b3-b598-8f7d7716dbba@gmail.com>


--T/gFBDvK/h08vZL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:17:58AM +0200, Ceclan Dumitru wrote:
>=20
>=20
> On 1/10/24 18:17, Conor Dooley wrote:
> > On Wed, Jan 10, 2024 at 05:37:09PM +0200, Dumitru Ceclan wrote:...
> >>    ctrl-gpios:
> >>      description:
> >> -      Must contain an array of 6 GPIO specifiers, referring to the GP=
IO pins
> >> -      connected to the control pins V1-V6.
> >> -    minItems: 6
> >> +      Must contain an array of GPIO specifiers, referring to the GPIO=
 pins
> >> +      connected to the control pins.
> >> +        ADRF5740  - 4 GPIO connected to D2-D5
> >> +        HMC540S   - 4 GPIO connected to V1-V4
> >> +        HMC425A   - 6 GPIO connected to V1-V6
> >> +    minItems: 1
> >>      maxItems: 6
> >> =20
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: adi,hmc425a
> >> +    then:
> >> +      properties:
> >> +        ctrl-gpios:
> >> +          minItems: 6
> >=20
> >> +          maxItems: 6
> >=20
> > This one should not be needed, it's already set by constraints on the
> > property above.
> >=20
>=20
> No, not needed, just inspired from:
>  /bindings/clock/samsung,exynos7-clock.yaml
>=20
> Specifically, the top constraints:
>   clocks:
>=20
>     minItems: 1
>=20
>     maxItems: 13
>=20
> One of the conditional constraints:
>   clocks:
>=20
>     minItems: 13
>=20
>     maxItems: 13
>=20
>=20
> I would only have two arguments for this staying here:
>  - It stays consistent with other cases
>  - In the case a new device with more than 6 GPIOs is added, this would
> need to be put back in

Okay.

--T/gFBDvK/h08vZL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaAX7AAKCRB4tDGHoIJi
0ru8AQCdBU5wVGAEWO/zsKHdUGmfoPuB9Zz97glaVc3CR4U+UgEApoGcVfC+1Ta7
DEGHEfg/LLqoQLprkP33lsaWkNIUTwQ=
=xcFx
-----END PGP SIGNATURE-----

--T/gFBDvK/h08vZL+--

