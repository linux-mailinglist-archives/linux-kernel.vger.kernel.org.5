Return-Path: <linux-kernel+bounces-41164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7583ECCA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA63285062
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6363200C6;
	Sat, 27 Jan 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBaJT/Kh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861733D1;
	Sat, 27 Jan 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706353400; cv=none; b=LuBnqsNIq6MPxAxeBQ6jvLMHwOl5z6QJ5JdiUPf6D+jokhNQ+2Xkjt/3xUpL35mVm7FyGpb7QKMbW2VZXLX45dkMjoQQCK/+9xVVo5sJxZhgxtgs/j8KUrb4cDUWvCSCHGZAYOXaYpmpQj9j/8XFo2HyCx9AWy+ewtSOG4vxoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706353400; c=relaxed/simple;
	bh=yl0BYkYr0KJfRtCRnstJBk+fgnnqo4CtTb58KQ3ZRWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnp+54EoB1olY+NUU9+F7ZXxibkwE4aaPpNI/BF/dlLPiozVxmd6AVCFqhGpm5p+aqZ4wDysCoOdiSPTWpxV2GfKLiULShrKukBr588md9PMQSpcqiddK0nYAPzHTb7m7C5Ab8i2SjT9edRvj+f9J9TdmAnxP/xVlZUp+cIa6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBaJT/Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB96C433C7;
	Sat, 27 Jan 2024 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706353399;
	bh=yl0BYkYr0KJfRtCRnstJBk+fgnnqo4CtTb58KQ3ZRWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBaJT/KhcJ6pILu1JMtOlZjc5NcTWbd0oSooCHIVk9L0P/iRshrMcWSZeiC/COBgH
	 BECj2c7HOvBf4xqqpP2Ew66F8UiOT/IR3T5JgtLfKL0xpsBjdir+9+aHK26+CVysrL
	 rly6ECWJ/hYJHCooN7pGgajEs1TuYokQRuWZ2UdVREJ/n9yWutgUkvTsvydfV0FTK5
	 AKpdoo1mgHvzUNhgkn7Vt6ILNZbcD++Ozyl6jqstOTwPkCBMGyOiacbKCaIl27SF8+
	 ErHuG76n4O61hw9a8ofwtvfSbdntbDgLSwpTq1m0YX99X0UyDhIjCYmEVNTGT5KI7t
	 YOSnAmUUoUNaA==
Date: Sat, 27 Jan 2024 11:03:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240127-hunting-wick-fc1eed1af6b1@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud>
 <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
 <20240126-scale-serrated-33686467d91b@spud>
 <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
 <20240126-blaspheme-calculate-a4134dc1ed68@spud>
 <536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEKFPbYYOtLi9l3Q"
Content-Disposition: inline
In-Reply-To: <536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se>


--PEKFPbYYOtLi9l3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 10:40:31AM +0100, Peter Rosin wrote:
>=20
>=20
> 2024-01-26 at 23:14, Conor Dooley wrote:
> > On Fri, Jan 26, 2024 at 11:10:36PM +0530, Naresh Solanki wrote:
>=20
> > I did look at what you have there and I think your dts is wrong.
> >=20
> > The iio-hwmon binding says:
> > | description: >
> > |   Bindings for hardware monitoring devices connected to ADC controlle=
rs
> > |   supporting the Industrial I/O bindings.
> > |=20
> > |   io-channels:
> > |     minItems: 1
> > |     maxItems: 51 # Should be enough
> > |     description: >
> > |       List of phandles to ADC channels to read the monitoring values
> >=20
> > And then you have:
> > |	iio-hwmon {
> > |		compatible =3D "iio-hwmon";
> > |		// Voltage sensors top to down
> > |		io-channels =3D <&p12v_vd 0>, <&p5v_aux_vd 0>, <&p5v_bmc_aux_vd 0>, =
<&p3v3_aux_vd 0>,
> > |			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>, <&adc1 4>, <&adc0 2>, <=
&adc1 0>,
> > |			<&p2V5_aux_vd 0>, <&p3v3_rtc_vd 0>;
> > |	};
> > |
> > |	p12v_vd: voltage_divider1 {
> > |		compatible =3D "voltage-divider";
> > |		io-channels =3D <&adc1 3>;
> > |		#io-channel-cells =3D <1>;
> > |
> > |		/* Scale the system voltage by 1127/127 to fit the ADC range.
> > |		 * Use small nominator to prevent integer overflow.
> > |		 */
> > |		output-ohms =3D <15>;
> > |		full-ohms =3D <133>;
> > |	};
> >=20
> > A voltage divider is _not_ an ADC channel, so I don't know why you are
> > treating it as one in the iio-hwmon entry. Can you explain this please?
>=20
> This is the exact intent of the voltage divider (and the other bindings
> handled by the iio-rescaler). The raw ADC reports the voltage at its inpu=
t,
> which is fine, but if there is an analog frontend in front of the ADC
> such as a voltage divider the voltage at the ADC is not the interesting
> property. You are likely to want the "real" voltage before the voltage
> divider to better understand the value.
>=20
> In this case it's much more interesting to see values such as 12.050V
> which is presumably close to the nominal voltage (12V? guessing from
> the node name) rather than some unscaled raw ADC voltage (in this
> example it would be ~1.359V, which tells you rather little w/o rescaling
> it first).

Thanks for explaining it. Naresh, can you respin please with an
explanation of why the property belongs in the binding please?

> It's all in the description of the binding...

Obviously it was not sufficiently clear, it's not as if I didn't look at
it...

Cheers,
Conor.

--PEKFPbYYOtLi9l3Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbTi8gAKCRB4tDGHoIJi
0irBAQC/E6pH/v9G1cPxD4totgtOdP6R6un1YtOfN56hp58+AwEAt2eplZHFIOo4
pnncaWC1QWLMPW8QQ0qV9zSenk8Tcws=
=qI/n
-----END PGP SIGNATURE-----

--PEKFPbYYOtLi9l3Q--

