Return-Path: <linux-kernel+bounces-11061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6481E0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941C71F2214E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833C524A2;
	Mon, 25 Dec 2023 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="j5q3XDHU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A951C35;
	Mon, 25 Dec 2023 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8920428B50B;
	Mon, 25 Dec 2023 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703510587;
	bh=14EQC5qqKiN5WQ9VzIjt0dHBHxOgMiyScJ9um6lKD0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j5q3XDHUWueFj+YEUtMxpKA2OGcnEOPcLBX8hzJrlWlaySiW6ApiDZ+YbYnFfxG+L
	 ix/DlXfFefHW8aUSVsqB4wfbzPrLz3/HOI8kJP2V6e1FGz1VQwPPojEUDTqIaRSMDm
	 XKSQsk+ONK2Yw9S4sPC+wQE2rWpgWg/X1dduyL5o=
Date: Mon, 25 Dec 2023 15:23:05 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add pressure-triplet
Message-ID: <ZYmCOVvgcElnxRuH@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-3-petre.rodan@subdimension.ro>
 <49525adf-1540-4801-8cdf-be1c0fe640f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hkq38sgjI1VM5oWr"
Content-Disposition: inline
In-Reply-To: <49525adf-1540-4801-8cdf-be1c0fe640f6@linaro.org>


--hkq38sgjI1VM5oWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Krzysztof,

On Mon, Dec 25, 2023 at 01:57:39PM +0100, Krzysztof Kozlowski wrote:
> On 24/12/2023 15:34, Petre Rodan wrote:
> > @@ -54,14 +57,6 @@ properties:
> >        If not present the device is not reset during the probe.
> >      maxItems: 1
> >=20
> > -  honeywell,pmin-pascal:
> > -    description:
> > -      Minimum pressure value the sensor can measure in pascal.
> > -
> > -  honeywell,pmax-pascal:
> > -    description:
> > -      Maximum pressure value the sensor can measure in pascal.
> > -
> >    honeywell,transfer-function:
> >      description: |
> >        Transfer function which defines the range of valid values delive=
red by the
> > @@ -72,17 +67,52 @@ properties:
> >      enum: [1, 2, 3]
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >=20
> > +  honeywell,pressure-triplet:
>=20
> Why not putting it just before existing properties?

I'd like to have pmin-pascal, pmax-pascal as the last two honeywell specific
properties, since they are not to be used unless someone has custom silicon.
so we will still have a block moved just like above.
the most logic order is the one I proposed above:

honeywell,transfer-function:
[..]
honeywell,pressure-triplet:
[..]
honeywell,pmin-pascal:
[..]
honeywell,pmax-pascal:
[..]

since the last 3 are tied together as we will see below.
is there any reason you want this order to change?

> > +  honeywell,pmin-pascal:
> > +    description:
> > +      Minimum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,pressure-triplet is not set.
>=20
> The last sentence is redundant - schema should enforce that.

when someone generates the dtbo files via

cpp -nostdinc -I include -I ${LINUX_SRC}/include/ -I arch -undef -x assembl=
er-with-cpp ${file}.dts "${BUILD_DIR}/${file}.dts.preprocessed"
dtc -@ -I dts -O dtb -o "${BUILD_DIR}/${file}.dtbo" "${BUILD_DIR}/${file}.d=
ts.preprocessed"

the schema is not checked in any way.
so unless people can be bothered to understand the yaml intricacies in the
bindings file, I feel they need to see that redundant information there, se=
e below.

> > +oneOf:
> > +  - required:
> > +      - honeywell,pmin-pascal
> > +      - honeywell,pmax-pascal
> > +  - required:
> > +      - honeywell,pressure-triplet
> > +
> > +allOf:
> > +  - if:
> > +      required:
> > +        - honeywell,pressure-triplet
> > +    then:
> > +      properties:
> > +        honeywell,pmin-pascal: false
> > +        honeywell,pmax-pascal: false
>=20
> This allOf is not needed.

speaking for intricacies, if the allOf is removed, then a binding containing

honeywell,pmax-pascal =3D <840000>;
honeywell,pressure-triplet =3D "0015PA";

would be considered to be correct by the schema, but that would be the inco=
rrect
result. so afaict allOf needs to stay, and so does the redundant text.

best regards,
peter

--hkq38sgjI1VM5oWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWJgjUACgkQzyaZmYRO
fzBBUBAA2cgW9liq1ZnhpYLvCPsgC2B5qNPUFS///YgWjSAgs5hs+/jmebW9b6D4
F57slVCOmIUqL04DBp0RSFkF4HhBf+QifhOhSAqEEWtCKZZ0gfS3x92mj09ffdgj
2F2qFMQDZoA9z8S9IaUukHDRZgdelag+jkgeAy6bcA7KQhcr0P/Ivvme1Jbb/ggx
gOfl4yQbRpy6E5Z4b9TTBzzezvjGOFCngzy6wFa5A+1NWMAiSaIkw6F+eRhLguTD
SvOR6UNtv+FyT7Ianeql5Z9rgtxr1Od6JT2oVMIhKOV09gTehGEkqJgddBQ7A7oR
WLE+D8kxr+M+4/f8IagIseURVdFzb71fWEkYSE2oW38Q2xdVslV05paCEVSDmt17
ycggYymBElTg8TPoA72ziUsMAHBFlOX2eQiWrjD3FPQ3iXVkzk+k8Afs5TfTAoI3
9cGD+pDORCHZe10NN87c5biq2lJ1GK1oatJsi8tQW7x45qt74EDy0Hgbc2WeYWfA
qO6cb6/SbM9Ob2J+KXGWJy0sCmfB14EYX2JtAJd1TAGFlKbIhixjlKCa/IO4/QJP
2v1/MixDh3ljL/TaZ7Sj8V6h9eR63XvCpLZjjWHFmPRm8PFPseE9Ov/FOexcNMWf
2UyHQPU5mFEXb2HR6RegwP0bUF9f2gB7Hzf4jxC3tW6dQsTuxoA=
=+r+4
-----END PGP SIGNATURE-----

--hkq38sgjI1VM5oWr--

