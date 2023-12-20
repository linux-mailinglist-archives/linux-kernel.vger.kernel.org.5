Return-Path: <linux-kernel+bounces-7294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8081A4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68504289782
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C7546422;
	Wed, 20 Dec 2023 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWhhRH8p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A53E477;
	Wed, 20 Dec 2023 16:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07976C433C8;
	Wed, 20 Dec 2023 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089520;
	bh=bqmJgdG2cQrFRj9mG3l1cGlxdLWNpRQOXnL/ygP0CQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWhhRH8piymkGehZFNjjk4tSaCQSFHRx/1xOJLe48nrqHkznc28ye8lh6A6gxFWD6
	 il3/v+15Ol78BRnfRm67UQ2mxT+WEa2ftxyfE1WyTfd9xmOCSTocl8I/xNlN/e6SEz
	 oNehzM4aFSLQRnyHywdHgrL28Ktkflq+ro+H9oS/cecXYiCTGEy+10M7uoOtUrhmYJ
	 OYhMJQTlWgevgIWfLpM8I8V2NRZ5aNfLOY3ovjsIAAZLsMnRxOtgjSdN9rgWHICgA9
	 46daHsWV+0RGyvnRmUbRFz3B1XAe1Dko6SdGByN4db9SlcuR7ZuR1cZhSbhcVXqbDz
	 C+hy47ith5pvQ==
Date: Wed, 20 Dec 2023 16:25:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <20231220-gristle-renovate-557b8c330e4e@spud>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
 <20231219-mascot-semester-7d2c492b99bc@spud>
 <ZYHEcfB7b+k2g9Ge@abdel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TbtCuatvXTl7vKHk"
Content-Disposition: inline
In-Reply-To: <ZYHEcfB7b+k2g9Ge@abdel>


--TbtCuatvXTl7vKHk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:27:29AM -0500, Abdel Alkuor wrote:
> On Tue, Dec 19, 2023 at 03:18:24PM +0000, Conor Dooley wrote:
> > On Sun, Dec 17, 2023 at 11:52:27PM -0500, Abdel Alkuor wrote:
> >=20
> > Do the other devices here have interrupts? If not, you just allowed
> > interrupts for them. You, at the very least, need to add something like:
> > diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Docume=
ntation/devicetree/bindings/hwmon/lm75.yaml
> > index 63b85a83ac18..d7ce96606400 100644
> > --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> > @@ -56,6 +56,17 @@ required:
> >    - compatible
> >    - reg
> > =20
> > +allOf:
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: ams,as6200
> > +    then:
> > +      properties:
> > +        interrupts: false
> > +
> >  additionalProperties: false
> > =20
> No, not all of them support the interrupt. Just tmp101, tmp102, tmp112, a=
nd as6200.
> For now, I'll add the check for ams,as6200.

If multiple devices have the interrupt you should document it for all of
them IMO.

--TbtCuatvXTl7vKHk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYMVawAKCRB4tDGHoIJi
0kQTAQDGi4NWlAPFj4x2mWKYSSP+JqTTWeAi/dNz8yte/LXNAgD+NTIVMU3FTUN/
OyJKoUAF9TrBFE5cGE90uke0b5OryQ4=
=EULT
-----END PGP SIGNATURE-----

--TbtCuatvXTl7vKHk--

