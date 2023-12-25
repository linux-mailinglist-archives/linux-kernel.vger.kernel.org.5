Return-Path: <linux-kernel+bounces-11167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B681E255
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E739E1F21E85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25E5381B;
	Mon, 25 Dec 2023 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="XhBW5Cx8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560B53E00;
	Mon, 25 Dec 2023 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5941128B50B;
	Mon, 25 Dec 2023 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703536167;
	bh=jhNrBsepGZrvs9ep/J+w+YrOSPNVglsMUP/CPJQFzT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XhBW5Cx8t8QwnJgFzN0Cj1mNC928Aeg0dPj0pakisf46UoOlShwEEt7MtL8zrtI3j
	 iBGiFPTph8FoVG+IYhlNpIpLuvRSrB4Hh69HlMN0wqxtBoIX19upviF772vaAsuUv3
	 eziyGLsetxGJk5SnFECa3m5xUcxJKRSvPycCfdr8=
Date: Mon, 25 Dec 2023 22:29:26 +0200
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
Message-ID: <ZYnmJjUJjYZHxfUM@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-4-petre.rodan@subdimension.ro>
 <b23a6b74-a568-4e11-8429-6344e10a9937@linaro.org>
 <ZYmcNySur-ZQryWc@sunspire>
 <1b54a167-1c90-46b8-8a7b-a21f5d4655e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2af24PaiwPbcA0FS"
Content-Disposition: inline
In-Reply-To: <1b54a167-1c90-46b8-8a7b-a21f5d4655e7@linaro.org>


--2af24PaiwPbcA0FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 07:56:24PM +0100, Krzysztof Kozlowski wrote:
> On 25/12/2023 16:13, Petre Rodan wrote:
> >>> @@ -88,6 +88,9 @@ properties:
> >>>        Maximum pressure value the sensor can measure in pascal.
> >>>        To be specified only if honeywell,pressure-triplet is not set.
> >>>
> >>> +  spi-max-frequency:
> >>> +    maximum: 800000
> >>
> >> So you miss allOf: with $ref to spi props.
> >=20
> > for simplicity's sake and for compatibility with the i2c devices alread=
y in use,
> > this driver does not have distinct 'compatible' properties for the i2c =
and spi
> > implementation.
> > this is why I just defined spi-max-frequency, used it in the spi exampl=
e, but
> > not required it. just like in hsc030pa.yaml .
> >=20
> > without a differentiation in the 'compatible' string I don't see how yo=
ur request
> > can be implemented.
>=20
> You cannot have different compatibles. I did not propose it. I wrote
> nothing about compatible. I wrote about missing $ref in top-level for
> spi-peripheral-props. Where do you see anything about compatible?

sorry, for one hot second I thought you want that property to be conditiona=
lly
defined, like

allOf:
  - $ref: /schemas/spi/spi-peripheral-props.yaml

  - if:
      properties:
        compatible:
          contains:
            const: honeywell,foo-spi
    then:
      properties:
        spi-max-frequency:
          maximum: 800000
      required:
        - spi-max-frequency

but I guess you only want the first two lines from here.

happy holidays,
peter

--2af24PaiwPbcA0FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWJ5iEACgkQzyaZmYRO
fzDdARAA2M3MPZmM2mQ2vxbYaO7I4LWYIAZXE8AR8WBD5W95ulhz9smCSG4OOBeq
Y6QQmzOBz6UiotQa9gSwSXIUt/bU625TQ4aFIB+o0Cr5oAHJEQFxR3h8ZlGR9Dl5
eD7W29Pryq1Ila5Bp+AZV2va1cVqo4AnfE4nl3z5kw8G0tKzISK2W4k+J0JE4Goy
ak4/kH7OsKhzYeC4OZ8Tn5IMz9Qvg+frXvf8Zl+Q6XrRV0uJzJ+q/EyO57qz5775
eUijBCxZpldg2WRWMYkDqfIUM/X60397c78NNKj29Fb35ZtQw9+hoLRi6f+Zxzdr
bWRHUc1CmqhP6qS+scVEB39yanclLp1c6FPsIC/wQgyVI0t/ZkYaZ6W4UebqKFL4
vxY0zXmo1dyPd/40mICn9KG6dqNAwk73/wF/JUv/TtxEb8W1Bj8VcbmuPR9n+Shx
43tw22qgu54O5qukS7dGALJdSOivUAg4XlvuQsV7kPXwrya9QSjxEyvW8v8QmFPj
AGRwpyJ17mfrwoGVJphi/9Q+ZEoEAkjjmqG8TVzUiFMWeuMDTZUd7atvFjoLX6l9
nWBmko2CVBTleSvQgEiNjcDZM8sWsTcfLBaaO3tkjnLXSnZmKyxYdhGQIpdUK3lI
tnZhycHQYm7nns+xTp/+C/ikvywTf8tmA8hQrWJ3QbEqqB6LYuo=
=9FKe
-----END PGP SIGNATURE-----

--2af24PaiwPbcA0FS--

