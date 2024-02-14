Return-Path: <linux-kernel+bounces-65680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A63F855058
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD81C27521
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0F82885;
	Wed, 14 Feb 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3DgzkPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846D60BBA;
	Wed, 14 Feb 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931781; cv=none; b=QtPXB74iSJD+pMot80PYPqTb5ZGMQGooYHoz7nI1wEu8Rk6efALbU2C8rRM6/pUZR4OB2wyVVTv+o692TYaVts8+1IXV/8GaoDY4DKIK9Bsa5Xi9guxWxd4KmaGypMhXSWXc3y66oFAwscL4TqZ71MkhtfoLbnglNv638mLYhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931781; c=relaxed/simple;
	bh=+joyx0bmEnXyVy5esBqSXjpzYkY8kxZ8vd/ZpfSmvWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMbno+lui2Y9Z4sAHmGjbLIXHlAIzTZD6vnHhyJSKvygFeL709WewM7vlBZEK1ch0Hi3FyBSDSUOBEpA8cjG02aZWFAjrqC+CRuk1XmbYXIRrhpfBvhJQo0RluAb6gerGFk1sG5gYU77Vgs8gx9u76e/M7fC7rW6c5SQM9dlSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3DgzkPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F345C433F1;
	Wed, 14 Feb 2024 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931780;
	bh=+joyx0bmEnXyVy5esBqSXjpzYkY8kxZ8vd/ZpfSmvWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3DgzkPw6OKniqOGuHrkCmMdzuJ8k/Vd7nQRWLRwRP7ys6T/7dUj8nrqk9FOb+Ahe
	 ywbR/psfeipPxPNrfO0NWUJ9STX86CF6b6SsJ77UtCSnj6QgEPgVVSDxKwmrhnMGvU
	 m9FIC4ae9obhqn/231NelfgGPO3uLgalkutO+8WYgPNsvR6lrLnbrgGYBfrDFEaUW6
	 ZsQMxHAr4QQQSzaFl8HUrrfnraN4qd8o3xkihmp+nMKdTYO4qSsvVtkZAxffEiz+Ni
	 tKlo/bd0ufomJOVKIPJFQ8jV5dRJPHEmHg2VfeM5YHByrBCTwsEvIEVfvgHW6ViD5L
	 hwPhGgX7eL1BA==
Date: Wed, 14 Feb 2024 17:29:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J
Message-ID: <20240214-boat-drapery-3f957d393ccc@spud>
References: <20240211205211.2890931-1-megi@xff.cz>
 <20240211205211.2890931-3-megi@xff.cz>
 <20240212114738.0000535b@Huawei.com>
 <i2q2vntbhilrpwppzl367ndoetbyd6guyti4t4n7vtg5pwq7bi@tjkio7zpwrfw>
 <20240214163116.000031b5@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZURdXPkQnAo0vG8A"
Content-Disposition: inline
In-Reply-To: <20240214163116.000031b5@Huawei.com>


--ZURdXPkQnAo0vG8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 04:31:16PM +0000, Jonathan Cameron wrote:
>=20
> > > > +
> > > > +  dvdd-supply:
> > > > +    description: |
> > > > +      an optional regulator that needs to be on to provide DVDD po=
wer (Digital
> > > > +      IO power, 1.8V~AVDD) to the sensor.
> > > > +
> > > > +  mount-matrix:
> > > > +    description: an optional 3x3 mounting rotation matrix.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg =20
> > >=20
> > > Any power supply that is required for operation should be listed here=
 (even though
> > > we can rely on the stub supplies if it isn't in the DT).
> > > I used to think this wasn't necessary, so lots of bindings upstream d=
on't yet
> > > have it. =20
> >=20
> > By stub supply you mean dummy supply created when the *-supply property=
 is not
> > specified in DT? Or something else?
>=20
> Ah yes. I got the term wrong.
> >=20
> > Because DTC_CHK prints a warning if I make the proerty required in bind=
ings and
> > not specify it in DT
> >=20
> > arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2b.dtb: magnetomet=
er@1c: 'avdd-supply' is a required property
> > 	from schema $id: http://devicetree.org/schemas/iio/magnetometer/voltaf=
ield,af8133j.yaml#
>=20
> Provide one, or don't worry about that warning.=20

For the sake of the platform maintainer, please choose option 1.

Thanks,
Conor.

> Various discussions have taken place on this over time and end
> result is bindings should require them to differentiate from power
> supplies that are actually optional.
>=20
> Jonathan
>=20
>=20

--ZURdXPkQnAo0vG8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcz4gAAKCRB4tDGHoIJi
0t2XAP4nJHA2b9GYmFqXkv+07/EH+A0d1pTP+qFxL6MbEPfAnwEA3fFVoQUTBNDE
m/cQ44UUEixiyx9FrScrbk45rvjqEAc=
=0zCn
-----END PGP SIGNATURE-----

--ZURdXPkQnAo0vG8A--

