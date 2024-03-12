Return-Path: <linux-kernel+bounces-100339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E68795ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9230B21531
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C57AE6D;
	Tue, 12 Mar 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVhw8QnW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DF7AE41;
	Tue, 12 Mar 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253162; cv=none; b=Tg/2P52sWdRs8Qa36JR6OSzudTiBBmD4jX0XeBYHE4Ohp2+jXVImTnT3BllrCcdbVqOkKVIuA0sDgCz/O44phqJSWiyw1ncspIflw4mbHiQn/Z0OSSIez3FIXxcrsZtTZe7LQwmQhzcOgpW+WQ7xDxojMItVpd7Ah/ANi7E9ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253162; c=relaxed/simple;
	bh=4oMqalpRE5kYhEuNbKjmqLDbCTx5FoitYiZ2uX6Cerc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi3geoCd829PBAP6gv+uukjorfu3cb98/B3j2zpF3jV51wkttJs+Msl1mEDFWbS09RTdvw3y3nL8hx3T5Wn94xkMu3VGujzFND7w21+jJ0TQasAVX3wskn2gODRlq3CMdyPUqzWnthul/9THsFUZrEqv1c/6gF1yGvt5czu/x1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVhw8QnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F65C433F1;
	Tue, 12 Mar 2024 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253161;
	bh=4oMqalpRE5kYhEuNbKjmqLDbCTx5FoitYiZ2uX6Cerc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVhw8QnWKpyhA6h+Wp7sjPirbGDeeggI0btMmjtHNIVQhrNQrGqMELK8Qcf0VUudY
	 RdRpT1bRG0fGP6atUbF9I7UU5dBEyyNfhgoXCfyRnfuD7sqAX3EVe7zkGhlGRbvmJj
	 OHTlsoVI3djGkfhL6xMVLRzl4buNa3JvkG42UkinfEzW/NqJMYALrlPEtTvCM41N26
	 8ZC7J6h8fwahMKFyfUrGesSOPe7osKBJXf4qVNrZjuc2CZyFLiCTWxWpgME5pClxhF
	 qhxRfi+S6iOsg5pRiVLHd0BfrLtlCE6MHbyRFUSDkwOIYVOqvB49xSX1ozF5I5nz8e
	 w4h2kJFSyXPPg==
Date: Tue, 12 Mar 2024 14:19:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] regulator: axp20x: add support for the AXP717
Message-ID: <1a87ae5e-fc27-4395-ba7d-7e340439e697@sirena.org.uk>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpd0Wtl02vcwQBz2"
Content-Disposition: inline
In-Reply-To: <20240310010211.28653-5-andre.przywara@arm.com>
X-Cookie: Oh, so there you are!


--qpd0Wtl02vcwQBz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 01:02:11AM +0000, Andre Przywara wrote:
> The X-Powers AXP717 is a typical PMIC from X-Powers, featuring four
> DC/DC converters and 15 LDOs, on the regulator side.
>=20
> Describe the chip's voltage settings and switch registers, how the
> voltages are encoded, and connect this to the MFD device via its
> regulator ID.

Acked-by: Mark Brown <broonie@kernel.org>

--qpd0Wtl02vcwQBz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwZGMACgkQJNaLcl1U
h9D7Ywf/XmLzLcrO7mY/k312SrxXdU5zU7dQ+wER3ZTFwb7o5zlQZ7vEwIq8CsV4
97dROKk5cEJbUeS+87PTyiFWGcIQUhE5sVE1wQhJEwMhNWc2m8nSEOOHoy/wpSCi
Oq3bzA4pm2JLoG0cWk3ioF9S4yfqqOK+fHt6a2SA1LJFAfoTA0qEZeYRQjuajqAn
JHwaCnv5ewAoJQLW9aaMGQj4rRWrsKvmtbVANa2zI8uhlTo31CzSYjWeq2hGWd53
Zkgzr5vovAMriBJZNkQvz5N2nguDMYBuuJQeUuDjgYj0kMe+EAD6XeAMOJON9q/q
33U8R6317YRKU3QyY8YxRR3cFAHY2A==
=WJiX
-----END PGP SIGNATURE-----

--qpd0Wtl02vcwQBz2--

