Return-Path: <linux-kernel+bounces-51140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19B848702
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646F1283F0C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EC5F479;
	Sat,  3 Feb 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4ggV+2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387B5EE93;
	Sat,  3 Feb 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973056; cv=none; b=GLqyZl+lziRriD2dTUOHahFY1hQoXWvEpWyumBl1h/XHO7gG5Q7J/HPdDoL2q0S/pHXrcuMTXfKxW4wq0i7Uph96H4AsOb02rE32dcrEWjdcd+Q4rx69h9m8Mwn4VsbrJ5z+WOZ5wMW7ahCCGmd2dbcBoTomWcnWc0p64DDGrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973056; c=relaxed/simple;
	bh=iy/JXt4YE+LvE7ZBENrUKrSe66OESfhfmI4kfMKbZdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1i2G6xZqChgXqT7Ra3dr8EWcsNDjBwCX4OTH6O3SJkCsH2FpAuD4ez3knLygqew//73hbgUVVfAnELmJhnISyamLh/QSZu1peTnhmsLc3rZxbvtP0NGJfuplaf5sOiUlVBuP2GCU+uhW73+g5lAuczBsA7f2OwKSv56JL0VgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4ggV+2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C22AC433F1;
	Sat,  3 Feb 2024 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706973055;
	bh=iy/JXt4YE+LvE7ZBENrUKrSe66OESfhfmI4kfMKbZdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4ggV+2fVNA7zZ+az+2oGX/YCywj28jC/1ND4uni1aX7nbK4j7+oWYVBroFXWe9bD
	 8qdudMp6raF2CJygLhh6vP841SKkX3u2EYf2Vdb8rsGNLzeSMA87m4LdzPqsIFepXC
	 jRYOXF4Spn7NSwMO30KXkTfoCeSKziJFu4dehTcdclfLzhuz/Wh1r4c1l9D9cPpHKJ
	 A/AlG3NmlvUq47aA96SIvYR4bvltcjL1/d96RFPB/+vin7n0eJ1b3CAN1Y0YwLnod4
	 z414w30LDy8kWE2hWuCq47Npv5USozUMDJXWa7l3/C9B3/FmVQZkmNRXU341APEUkf
	 GMs9A7oz0v5gQ==
Date: Sat, 3 Feb 2024 15:10:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Message-ID: <20240203-tummy-egomaniac-5aba55889a83@spud>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
 <20240203-prolonged-backfield-c659e0016d70@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HClS5m0LnfolVLZL"
Content-Disposition: inline
In-Reply-To: <20240203-prolonged-backfield-c659e0016d70@spud>


--HClS5m0LnfolVLZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 03:08:59PM +0000, Conor Dooley wrote:
> Hey,
>=20
> On Fri, Feb 02, 2024 at 05:10:49PM +0100, Josua Mayer wrote:
> > Convert the abracon abx80x rtc text bindings to dt-schema format.
> >=20
> > In addition to the text description reference generic interrupts
> > properties and add an example.
> >=20
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >  .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
> >  .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 74 ++++++++++++++=
++++++++
> >  2 files changed, 74 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b=
/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> > deleted file mode 100644
> > index 2405e35a1bc0..000000000000
> > --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -Abracon ABX80X I2C ultra low power RTC/Alarm chip
> > -
> > -The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab080=
5, ab1801,
> > -ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and th=
e ab1805
> > -is the superset of ab180x.
> > -
> > -Required properties:
> > -
> > - - "compatible": should one of:
> > -        "abracon,abx80x"
> > -        "abracon,ab0801"
> > -        "abracon,ab0803"
> > -        "abracon,ab0804"
> > -        "abracon,ab0805"
> > -        "abracon,ab1801"
> > -        "abracon,ab1803"
> > -        "abracon,ab1804"
> > -        "abracon,ab1805"
> > -        "microcrystal,rv1805"
> > -	Using "abracon,abx80x" will enable chip autodetection.
> > - - "reg": I2C bus address of the device
> > -
> > -Optional properties:
> > -
> > -The abx804 and abx805 have a trickle charger that is able to charge the
> > -connected battery or supercap. Both the following properties have to b=
e defined
> > -and valid to enable charging:
> > -
> > - - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
> > - - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables =
the output
> > -                          resistor, the other values are in kOhm.
> > diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml =
b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > new file mode 100644
> > index 000000000000..405b386a54b0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
> > +
> > +maintainers:
> > +  - devicetree@vger.kernel.org
>=20
> Ideally you put someone here, not the DT list. Usually the original
> author is a good choice, which I think happens to be the subsystem
> maintainer... Failing that, the rtc subsystem list is likely a better
> choice than the DT one.
>=20
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
>=20
> > +  - $ref: /schemas/interrupts.yaml#
>=20
> This should not be need.

Ahh I now realise what your intent was here. All you need to do is add
| interrupts:
|   maxItems: 1
to your binding and it should do what you're looking for.

--HClS5m0LnfolVLZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb5XegAKCRB4tDGHoIJi
0sOTAQDffNu5fDfBfG1UVePkzaZdi8iRgQBhHT4P/gogSzFe/wEAomBdnunofNhF
8MSnD1Jd2edeMQIFZbQjOX1p+ITILAM=
=QkK0
-----END PGP SIGNATURE-----

--HClS5m0LnfolVLZL--

