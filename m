Return-Path: <linux-kernel+bounces-46845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541E844547
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC36294496
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A813342C;
	Wed, 31 Jan 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmve9pUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C612CD9D;
	Wed, 31 Jan 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720087; cv=none; b=Im5l9SacKKjqrz7cNi7Sv51Tghh2b0AYX5fpo0UMwwV70ZijzAD+yfc50aBgLFzUpxaAQqUXLnyjVloKQrAn5pcXQx/xudY8l5mLfVqpmcOOnlSJmM9fO+8YAfOAEyQBMbdb/S4U3fk+tH23IBTC89NBuyebxuYZuiUjtSbu4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720087; c=relaxed/simple;
	bh=e7PkgB7K0gx8CAPjTVUKMOvEqHbyafX+oBkcjQV6dys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARHe509KVM9JXw8scBfFUs/AI/wcwU+/kjlT9nIhhdKa8j7DqfhTFFX2sJ5Mygd6oA6UsWcfRG5z8RWKbL+CAr/wXlMnOlHySY5Oev3jeQyGO0gKcf/WPIaITrZT+wePsfU4Wsbw6S0E8VUFXzGAwDwr97Iyq2PCtR77mV6wnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmve9pUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A395C433F1;
	Wed, 31 Jan 2024 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720087;
	bh=e7PkgB7K0gx8CAPjTVUKMOvEqHbyafX+oBkcjQV6dys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nmve9pUUOt196CcaU4YrJBEqco8cFcMpDhATzxHHFGUBeb+NRVrbaatX8PRY9P2Ri
	 a72GGOr8swMe3/9YGP2C7ynYNXM3YtjprV7fg2zcqLiv8ZbI7AS/Gat+qn0VTM84lX
	 sW0uTAp3pKw6YA91cokoNKsX+bspGqRgmZMH+viCzzb6VewaxLvhClbU/iKqbWGFEG
	 5veXuTSAZi0pjjMSsQBMIYiIKQP817JFKr5UCxMGb1ZwHGDBioeocFw5MlzcAHUsA+
	 EPOkzz4hr0nHkcNzhgd05rVWD/+s6VrsblUWPVhpu2xicRpeqKYQgpr1CcDdIHYSLo
	 f4B4pQU5jYfsw==
Date: Wed, 31 Jan 2024 16:54:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240131-stylized-defile-d8fe346ab197@spud>
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
 <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
 <20240131163516.000043df@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h8APYS+PcgeCvIXI"
Content-Disposition: inline
In-Reply-To: <20240131163516.000043df@Huawei.com>


--h8APYS+PcgeCvIXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 04:35:16PM +0000, Jonathan Cameron wrote:
> On Wed, 31 Jan 2024 09:29:59 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > On 30/01/2024 12:56, Naresh Solanki wrote:
> > > voltage-divider is always an iio consumer at the same time it is
> > > optionally an iio provider.
> > > Hence add #io-channel-cells
> > > Also update example.
> > >  =20
> >=20
> > Fix
> > wrapping
> > and
> > proper
> > sentences. Each sentence finishes with full stop.
> >=20
> > ...
> > >    output-ohms:
> > >      description:
> > >        Resistance Rout over which the output voltage is measured. See=
 full-ohms.
> > > @@ -75,12 +82,17 @@ examples:
> > >              spi-max-frequency =3D <1000000>;
> > >          };
> > >      };
> > > -    sysv {
> > > +    p12v_vd: sysv { =20
> >=20
> > No, drop label.
> >=20
> > >          compatible =3D "voltage-divider";
> > >          io-channels =3D <&maxadc 1>;
> > > +        #io-channel-cells =3D <1>;
> > > =20
> > >          /* Scale the system voltage by 22/222 to fit the ADC range. =
*/
> > >          output-ohms =3D <22>;
> > >          full-ohms =3D <222>; /* 200 + 22 */
> > >      };
> > > +    iio-hwmon {
> > > +        compatible =3D "iio-hwmon";
> > > +        io-channels =3D <&p12v_vd 0>; =20
> >=20
> > The same question as for v2. Drop unrelated example.
>=20
> Conor requested an example of the device acting as a consumer and a provi=
der.
> Might have meant in the patch description?
>=20
> Conor?

I wanted it in the property description to help with understanding when
to use it. I don't think the extra example nodes actually help you
understand what it is doing, only how to write one yourself once you
know you need it.

Thanks,
Conor.

--h8APYS+PcgeCvIXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbp7UQAKCRB4tDGHoIJi
0qUKAP0Ww48y8Vpl0AK0ojq0GTFz+pnr+vWFetK6V8fbSyQ0YwEAg+sb0e5EXttx
Yc5wqU6OG+ali+z2CNC/Op4kdAyPMAE=
=i3bX
-----END PGP SIGNATURE-----

--h8APYS+PcgeCvIXI--

