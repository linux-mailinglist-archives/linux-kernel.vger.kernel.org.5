Return-Path: <linux-kernel+bounces-56827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED084CFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942F41F26191
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12481ACA;
	Wed,  7 Feb 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzM/DvIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB181ACE;
	Wed,  7 Feb 2024 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326838; cv=none; b=hprdayeTYc+OVUmGmgsP6u4hFxfHX1GgTOtrm1K8pd3b1yWxE1UigxyMsHjWuf2+Pv6x+dca987oDj3woIBRrSOsdjK8qQiyBOQaBrrSX+Ma9GOuLNnZL1w7R4quBRbMhr6aKFFe2gY6nti6CLYG3v0FfjJCmppoTj3uSEy9x4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326838; c=relaxed/simple;
	bh=7wyYdg/OPZRMNK0CWvLZGY+pFUjlnvWuYHOfq6M3Yfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PleHySX9OVK38ta9GfHYC5bHjTBqKrDd0o6FtVlX1LvX+8Wb6BySNdLycKhFk1gALCQHdZ5A3cHraCczmB44p0QD22tA/sUCuI4PRtc2IWvW92E9xIqwS9C/EhcOWduZesSXUZ9ALcNcm4m+pRCSJOZiMTrhMF7uJmicvVkr2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzM/DvIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E92C433C7;
	Wed,  7 Feb 2024 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707326837;
	bh=7wyYdg/OPZRMNK0CWvLZGY+pFUjlnvWuYHOfq6M3Yfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzM/DvIFAg3I+QTeCC20Viunolxcz4TZyhwmZ2Vue+9jA0xmlBEkge0XQhZoCMOjM
	 uyu3VeAQg91K4jIeOmd99QgFwZQfjnjEENmKpcdcKLauBStHNMfaMC5sTKy9bBbmrv
	 lEZ3clyhhqUdoA0ZUrdfCim2+MxIlYehLrHQ7RU25j3dSKpMa1+E9mBhqVRBHQMYO/
	 9lBAKqDp/1hlVTrZQJywwrnjd9UMY4fEFSU1bXrj1+Jr2EHQ6Ia0p1BclrnvkaBif8
	 Z+TNRcnv5JrjYjP1/D98Ep+MdQN8NvW+C8ZiVAHNSm5CFfY+xSLRBbofqynxZcJ0Jq
	 N/ffvSYndyBEw==
Date: Wed, 7 Feb 2024 17:27:12 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240207-carat-darling-03f5a98e65da@spud>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
 <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x110uJIlPRj+uj6y"
Content-Disposition: inline
In-Reply-To: <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>


--x110uJIlPRj+uj6y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 11:34:13AM -0600, David Lechner wrote:
> On Tue, Feb 6, 2024 at 11:26=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> > AD7986 ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   8 +
> >  2 files changed, 239 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > new file mode 100644
> > index 000000000000..a023adbeba42
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
>=20
> ...
>=20
>=20
> +  adi,reference:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, internal-buffer, external ]
> +    default: internal
>=20
> ...
>=20
> > +allOf:
> > +  # ref-supply is only used for external reference voltage
> > +  - if:
> > +      not:
> > +        required:
> > +          - adi,reference
> > +    then:
> > +      properties:
> > +        ref-supply: false
> > +    else:
> > +      if:
> > +        properties:
> > +          adi,reference:
> > +            const: external
> > +      then:
> > +        required:
> > +          - ref-supply
> > +      else:
> > +        properties:
> > +          ref-supply: false
>=20
> This seems like something that could potentially be improved in the
> dtschema tooling. Since adi,reference has a default of "internal", I
> would expect:

Oh god, Rob will probably have to remind us how this works. I talked
with him about trying to do some conditional stuff like this a while
back, but I was not able to find any logs for IRC from then.

>      if:
>        properties:
>          adi,reference:
>            const: external
>      then:
>        required:
>          - ref-supply
>      else:
>        properties:
>          ref-supply: false
>=20
> to be sufficient here. However, currently, if the adi,reference
> property is omitted from the dts/dtb, the condition here evaluates to
> true and unexpectedly (incorrectly?) the validator requires the
> ref-supply property.

But I was trying to do something like you are here, and was also
surprised that this evaluated to true when the property was not present.

I ended up doing something completely different, so I have no example to
show you of how things ended up being.



--x110uJIlPRj+uj6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcO9cAAKCRB4tDGHoIJi
0nleAP9nmX07gBI9U1z0W95doO2LL4c6cqMPv9K6RCD9pvnqbgEA8H1q3EmcoLxn
o0hU6apWmTvd+VJL+ba4PuLVOlUbygM=
=9TQ/
-----END PGP SIGNATURE-----

--x110uJIlPRj+uj6y--

