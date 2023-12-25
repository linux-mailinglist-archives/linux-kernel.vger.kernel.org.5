Return-Path: <linux-kernel+bounces-11110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4481E162
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0563DB21EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C749524D8;
	Mon, 25 Dec 2023 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="nzsu33WJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1D55C03;
	Mon, 25 Dec 2023 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5658E28B50B;
	Mon, 25 Dec 2023 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703517241;
	bh=4ne2KQLiuid2BVnmmPmM/upM+2zJMRDvZiqnHDntmtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nzsu33WJjpl0gq2qO8zbgznbQ8nGqTTtTqsUnUqzPo7lSrLqSXQ31PKoDY8qrCOHk
	 Bap/7gCUwDg0MarpmcN9tXW/VnH5avBAsdfq8Hw2N5eszM/lagJNw+jmGZZwyNofkR
	 Z0OgNoEhGP1/HUCoGvkU0n7DjNBblfVLlk3Q+mm0=
Date: Mon, 25 Dec 2023 17:13:59 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add spi bus
Message-ID: <ZYmcNySur-ZQryWc@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-4-petre.rodan@subdimension.ro>
 <b23a6b74-a568-4e11-8429-6344e10a9937@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RQSMSeDNmbCQ1QW/"
Content-Disposition: inline
In-Reply-To: <b23a6b74-a568-4e11-8429-6344e10a9937@linaro.org>


--RQSMSeDNmbCQ1QW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

On Mon, Dec 25, 2023 at 01:59:43PM +0100, Krzysztof Kozlowski wrote:
> On 24/12/2023 15:34, Petre Rodan wrote:
> > Add spi based example.
> >    There are many models with different pressure ranges available. The =
vendor
> >    calls them "mpr series". All of them have the identical programming =
model and
> > @@ -88,6 +88,9 @@ properties:
> >        Maximum pressure value the sensor can measure in pascal.
> >        To be specified only if honeywell,pressure-triplet is not set.
> >=20
> > +  spi-max-frequency:
> > +    maximum: 800000
>=20
> So you miss allOf: with $ref to spi props.

for simplicity's sake and for compatibility with the i2c devices already in=
 use,
this driver does not have distinct 'compatible' properties for the i2c and =
spi
implementation.
this is why I just defined spi-max-frequency, used it in the spi example, b=
ut
not required it. just like in hsc030pa.yaml .

without a differentiation in the 'compatible' string I don't see how your r=
equest
can be implemented.

cheers,
peter

--RQSMSeDNmbCQ1QW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWJnDcACgkQzyaZmYRO
fzDA+g//UUJUG3n3dsKPrrrgTrB6x3FviyXIP896zMqQwVppSQKJJfKBgjThXtJc
Tq97Rbg9/rdjxDgNrCfIzmmspY0szApHJCpu5O+MGm2pAai3e2VZ+TYhotmlb7f5
jCOKEIbwc0Ox58IWpczFChL+wwHsugAzoRRnExh9MKKSEssA/arQ5iy421KWEmda
645uxB9UyjAEdxQsjx71UwmlJrGbMR9gtBFKmahFRuCopz/IxbHgw5JCXGMpYVYl
X6Xv+AJ0/DGCK2ZGOhgs+4jgbLhjf0MkZIVipc5WkgEkLOwwiCNtMqk5PGvHcwGQ
AEhqSYYUhsEdrACEiO7tFki9rrVIxqU0NRyQVyjcayNckuPpB1KEVRfb92aJ9LHk
mPDTiGqYOiT7cPxFK5uJg3YlZ6U0ZWDNYuR36/UV7abY3TfX8ErIfRIrNBWKsana
QWr2OylbsodRjXKseHWFg9VFUHBzPH2UySCf1Iyflamk7WCw3kp39y2hbChyv2tA
wNgKbu5s4ocCAAXM+ppf6toxJN0lIpPczJHr8RCfkU9Vvn71fqH9gHW/JqFpi9x2
j1CNKg96yckLPnuWzkV8zoRYYJa5XZ8sVSMAn6QlKvEyx1Tsph834FO4FLeWVMbX
KrP2ruWVHTewAqGHmjV4CLKwAaVsi2SeM2GwlgvEyt1RhyICFcg=
=Z5+B
-----END PGP SIGNATURE-----

--RQSMSeDNmbCQ1QW/--

