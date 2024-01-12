Return-Path: <linux-kernel+bounces-24379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D382BBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58081F22AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BC5D724;
	Fri, 12 Jan 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="f+wBvDm1"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5ED5C8FD;
	Fri, 12 Jan 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7260728B531;
	Fri, 12 Jan 2024 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1705044632;
	bh=6Jm6c1mv+a3OF1N6sRuMkjN/1Cyes5vuHDzFuEGKHaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f+wBvDm1BomRuQJLr0eYgoYkPcFNhPLxl60od+6e+JGPA6LjsJHjWrKqXpztxwW7j
	 q23f/I6j89d9hmEms4g/7sGVNUx8ucAf/hGRXPKJg0Wl+u/lXfteckzZdnFdmN5LIn
	 h0Wy5yBovDJPT3ZeuUl8gXoI/prepLkgdFKubL8c=
Date: Fri, 12 Jan 2024 09:30:30 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml
 add sleep-mode
Message-ID: <ZaDqlmXJD6if1xK7@sunspire>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
 <20240110172306.31273-3-petre.rodan@subdimension.ro>
 <bc37f7d8-c43f-4751-9216-fc95f439b2f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTw4fbEjyL1VypdH"
Content-Disposition: inline
In-Reply-To: <bc37f7d8-c43f-4751-9216-fc95f439b2f6@linaro.org>


--LTw4fbEjyL1VypdH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Krzysztof,

On Wed, Jan 10, 2024 at 09:48:34PM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2024 18:22, Petre Rodan wrote:
> > Add sleep-mode property present in some custom chips.
> >=20
> > This flag activates a special wakeup sequence prior to conversion.
> >=20
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---
> >  .../bindings/iio/pressure/honeywell,hsc030pa.yaml      | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,h=
sc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc=
030pa.yaml
> > index 89977b9f01cf..350da1d6991b 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa=
=2Eyaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa=
=2Eyaml
> > @@ -86,6 +86,15 @@ properties:
> >        Maximum pressure value the sensor can measure in pascal.
> >        To be specified only if honeywell,pressure-triplet is set to "NA=
".
> >=20
> > +  honeywell,sleep-mode:
>=20
> "Sleep mode" naming suggests there are choices, like mode foo and mode
> bar. Probably you want something like "sleep-between-measurements" or
> something matching how does it work.

"sleep mode" is the terminology used by Honeywell and it defines a chip cap=
ability.
it is present in the HSC/SSC and ABP series of ICs.

other such options (capabilities) include temperature output in the ABP ser=
ies.

the action the driver needs to perform if this option is present is to prov=
ide a
wake-up sequence before reading out the conversions.

now regarding a rename of this property, I would vote to leave it as is - f=
or the
users to have a 1:1 equivalence of terms between the driver and the datashe=
et.

I say that because for instance in circuit design when a part symbol and
footprint is drawn based on a datasheet it is recommended to keep the same =
pin
notations and the same block diagram as in the datasheet, precisely for thi=
s 1:1
equivalence, so there is no uncertainty for the end-user.

cheers,
peter

>=20
> > +    description: |
>=20
> Do not need '|' unless you need to preserve formatting.
>=20
> > +      'Sleep Mode' is a special factory set mode of the chip that allo=
ws the
> > +      sensor to power down between measurements. It is implemented onl=
y on
> > +      special request, and it is an attribute not present in the HSC/S=
SC series
> > +      nomenclature.
> > +      Set in order to enable the special wakeup sequence prior to conv=
ersion.
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +
> >    vdd-supply:
> >      description:
> >        Provide VDD power to the sensor (either 3.3V or 5V depending on =
the chip)
> > @@ -140,6 +149,7 @@ examples:
> >              honeywell,pressure-triplet =3D "NA";
> >              honeywell,pmin-pascal =3D <0>;
> >              honeywell,pmax-pascal =3D <200000>;
> > +            //honeywell,sleep-mode;
>=20
> Drop comment.
>=20
> > 2.41.0
> >=20
>=20
> Best regards,
> Krzysztof
>=20

--=20
petre rodan

--LTw4fbEjyL1VypdH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWg6o8ACgkQzyaZmYRO
fzAg3g/8DsMXh3IKMM913xGGBa4Ntx7fvQ9JfUQb9xgKM5mKqEw5hV7Cnqp/vxGT
dC2gG2X8wtzWRMqZ9cGxrvkBXt2AZ50o3c6v+EdAM84Caqb1283j1Leq3ccuIE3d
diGQTbczspbRg5Z5z0h9pEbIkeVvHQyC2t3v+wYf1JcYkSQ7jfDTQHIcj+5Ak2ma
MgaADJ7MeQOeXjQOseSycJB/x9+lVp6BXxuTCGf7V3o8mnCdTHlCl0U2Tkntlj/+
PMj8p8pCplgNn8lRnrGUdUrxuwEfg+AY+rFOb5mLEkA+amZoNj/bK2w0wQ+Ry2S3
/YZapuuWIha2+hxKoViRMFDC5VIM1taRVO1bHQKtPYZTfpRZUIwY+Am81cJgRp6l
XbmCqF4RQyZZbpqCkfKriDSOWtmq45aejcmsw84YfVxDYP00Vfw0avAb2gOl6Jwj
ZHtfZNh2/H9W9+ZhRwSItRVflvYg/XM9dcz5chZJHMtvf3Fd/lq7pe0/rSfRZWCq
r0mf+/V5VEgm11RADaRyLpEMdg+tBXfteBZoMSXKgxHG7RC47SDRA7b7wlyAkQTx
uaEjGSKPFFxPiCCAVjFM+vkqvyecyznMOTiQjIKfQK4AwOCGUG2If49JdZiuOhDf
u+2E/yz08Z+6FHQNUdZmd9KJuvDm7ZaKcsL4Fbf3joXOIcwBKYA=
=bErR
-----END PGP SIGNATURE-----

--LTw4fbEjyL1VypdH--

