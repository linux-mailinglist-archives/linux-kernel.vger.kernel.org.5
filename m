Return-Path: <linux-kernel+bounces-40733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A083E4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2451F22C66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FC2563B;
	Fri, 26 Jan 2024 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2v+5Osv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BD25573;
	Fri, 26 Jan 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307248; cv=none; b=V3O94hGRATRh+OBxv5w4zHQsPvWdth7PZ1pn7FCMMr5vIU6rVwP9CrC8GznupHihglhBpdhQLpDwYu++KEM3lhPqHs7qinx1911p3NlmuKClPubCE6WSqN8h8Y43vlhx72tbJ8Z9TtNqP+XRllD5VJj6OMBGift9cBhZQEvAi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307248; c=relaxed/simple;
	bh=0b8lK1c7dQnFioNfIBpSdxAWV5NjN5Icq9TAOnp0CbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIXlDyiDxDX+18V4VCYxNwCWKQwNeYzHXAU9poLkTOdAdbUxZT7N1MJ/nUdDYXusDi68OEovfgnaermTlcSIHmgkWKj34GoiFPJQOzZ3gG/egbIN5kaLf76gLK1bczWKsawk8mTvIfDu9NQN/9gR+gTrt7x9O0dGBYsq6UHdcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2v+5Osv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1224C433F1;
	Fri, 26 Jan 2024 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307248;
	bh=0b8lK1c7dQnFioNfIBpSdxAWV5NjN5Icq9TAOnp0CbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2v+5OsvdqgT3i4Kqm59IquUkMr2RwumpWqwYaQeU3u8MDlGdElaRznNLlJ2bM5BC
	 DWAcMB7xbDv+X+8wlwPbVBiOOnonowk+oOOnuFwD9EYKkKKP9lmfzUIRrCNJevipRp
	 Gm5CKc8LUeJcKlI55319rgTbhgXqGnwve0ZvDxHtZ8cGdFqOCZLP4VxqKWwi4CpynU
	 SS4IZR7Vjlg9xw/A6cj0wl5iyCSNt4sFCXIwcuawXvm3YidLdeWyTvPciy3RNQOr9/
	 bTBo6y1JpCEKAxGWxy2/hk8K+bZBqSJ4oennqOjIJLBCXwT0RvtBwrQjqrtES9Ze+W
	 SzvoicC3tf6Pw==
Date: Fri, 26 Jan 2024 22:14:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240126-blaspheme-calculate-a4134dc1ed68@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud>
 <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
 <20240126-scale-serrated-33686467d91b@spud>
 <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="51HTn85XAt3vYgRW"
Content-Disposition: inline
In-Reply-To: <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>


--51HTn85XAt3vYgRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:10:36PM +0530, Naresh Solanki wrote:
> Hi Conor,
>=20
>=20
> On Fri, 26 Jan 2024 at 22:22, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Jan 26, 2024 at 09:55:20PM +0530, Naresh Solanki wrote:
> > > On Fri, 26 Jan 2024 at 21:47, Conor Dooley <conor@kernel.org> wrote:
> > > > On Fri, Jan 26, 2024 at 05:25:08PM +0530, Naresh Solanki wrote:
> > > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml |=
 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-di=
vider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > > index dddf97b50549..b4b5489ad98e 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.y=
aml
> > > > > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.y=
aml
> > > > > @@ -39,6 +39,9 @@ properties:
> > > > >      description: |
> > > > >        Channel node of a voltage io-channel.
> > > > >
> > > > > +  '#io-channel-cells':
> > > > > +    const: 1
> > > >
> > > > The example in this binding looks like the voltage-divider is inten=
ded
> > > > to be an "IIO consumer" but "#io-channels-cells" is an "IIO provide=
r"
> > > > property.
> > > >
> > > > Are you sure this is correct?
> > > I'm not aware that #io-channels-cells is only for IIO provider.
> >
> > #foo-cells properties are always for resource providers
> >
> > > But I do get some kernel message as mention in commit messages
> > > if this is specified in DT.
> >
> > Can you please share the DT in question? Or at least, the section that
> > describes the IIO provider and consumer?
> Below is link to complete DT:
> https://github.com/torvalds/linux/commit/522bf7f2d6b085f69d4538535bfc1eb9=
65632f54

If you're gonna link something that is in a vendor tree, you should link
the actual vendor tree and not something that "does not belong to any
branch on this repository, and may belong to a fork outside of the
repository"!

I did look at what you have there and I think your dts is wrong.

The iio-hwmon binding says:
| description: >
|   Bindings for hardware monitoring devices connected to ADC controllers
|   supporting the Industrial I/O bindings.
|=20
|   io-channels:
|     minItems: 1
|     maxItems: 51 # Should be enough
|     description: >
|       List of phandles to ADC channels to read the monitoring values

And then you have:
|	iio-hwmon {
|		compatible =3D "iio-hwmon";
|		// Voltage sensors top to down
|		io-channels =3D <&p12v_vd 0>, <&p5v_aux_vd 0>, <&p5v_bmc_aux_vd 0>, <&p3=
v3_aux_vd 0>,
|			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>, <&adc1 4>, <&adc0 2>, <&adc=
1 0>,
|			<&p2V5_aux_vd 0>, <&p3v3_rtc_vd 0>;
|	};
|
|	p12v_vd: voltage_divider1 {
|		compatible =3D "voltage-divider";
|		io-channels =3D <&adc1 3>;
|		#io-channel-cells =3D <1>;
|
|		/* Scale the system voltage by 1127/127 to fit the ADC range.
|		 * Use small nominator to prevent integer overflow.
|		 */
|		output-ohms =3D <15>;
|		full-ohms =3D <133>;
|	};

A voltage divider is _not_ an ADC channel, so I don't know why you are
treating it as one in the iio-hwmon entry. Can you explain this please?

Thanks,
Conor.

--51HTn85XAt3vYgRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbQuqwAKCRB4tDGHoIJi
0qjuAP9odQPk4Rld47KxMAhyjjvAY+H2UQ4tgEBdtSu82pnmHgD/YOowmNyiakzs
BOEey09K7vzMOq+xY/EArtk2sMjdVQ8=
=279c
-----END PGP SIGNATURE-----

--51HTn85XAt3vYgRW--

