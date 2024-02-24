Return-Path: <linux-kernel+bounces-79805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC9862706
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073531C20A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57254C631;
	Sat, 24 Feb 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+8mF8J9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45EEDE;
	Sat, 24 Feb 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708803325; cv=none; b=sUhI3cxVRMMQX3bfqiH4CMfURiBA8I9mRhCewVrpbCbR2BAjOV02FB0WInHQYir/bAXoocxkTiRuBrVORxVGn0mlT6jDAngPV+ywl2Vv6l9QzG8t2uAE8YcvuUjRgT2BDgTDF2w6UrGy/XLj1I/kqgTuYIDkNxb7avgEBEHKHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708803325; c=relaxed/simple;
	bh=QEBdPxTjL+iDZKwl9XHsrez2AqEj3cnz9Kd0Et3eI0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1GF3nWiF9MNRFkcjm6apYbP3daz/6mEvE87uO418zGZybgOBRdmIoXscaun7KMkfXQB5zfPyiS/tUpOtS6kzRGOkx0xrLI3CA9zLB4Vcj0W0NbQYjnm4CK7q/AdKxSw2xTve0PWy6vm7qV4WWxVL1zC+m95RwbePELw0V71dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+8mF8J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6641CC433C7;
	Sat, 24 Feb 2024 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708803324;
	bh=QEBdPxTjL+iDZKwl9XHsrez2AqEj3cnz9Kd0Et3eI0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+8mF8J9kcEc37q93aIIqYA5ufGjGJhMvr763HbRFYSaO/dR6A5jqnY39y0CU0kVT
	 M+IRLv/uwF/9Q1XAiRNm05tjToxX6IqmjuerdS8wjps2aFacjvF02DyhyY7N+KtU7+
	 DehQO/jbYTq0DH7kH4TF70FYOqoKLqheMK9XBejWq0j1C7Bg6CfqcJEGknfkFVP0pc
	 3AbBsUREu9Ad2zRlhmk7ZjocK6CbsCtaEZT1+kzWhuruL6ci9KSjs62hzsLNiJqZcS
	 kQpLdL+TKArP5glJ//0pHjbpMf7WCulkifqwOcBySE1DtGEgfsrC2Q5Q1H3kKr/DFH
	 yiM4+FCiXE8Bw==
Date: Sat, 24 Feb 2024 19:35:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: linux@roeck-us.net, Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: Re: [PATCH v2 4/5] hwmon: (pmbus/lm25066) Use PMBUS_REGULATOR_ONE to
 declare regulator
Message-ID: <20240224-gloater-uncorrupt-53c9e1e73bd9@spud>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
 <20240223-player-buckskin-01405c5889c4@spud>
 <684ee927-2287-420b-aee5-f323e05ada47@hatter.bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yaaNXt9nsk607/Xz"
Content-Disposition: inline
In-Reply-To: <684ee927-2287-420b-aee5-f323e05ada47@hatter.bewilderbeest.net>


--yaaNXt9nsk607/Xz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:16:26PM -0800, Zev Weiss wrote:
> On Fri, Feb 23, 2024 at 08:21:08AM PST, Conor Dooley wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >=20
> > If a chip only provides a single regulator, it should be named 'vout'
> > and not 'vout0'. Declare regulator using PMBUS_REGULATOR_ONE() to make
> > that happen.
> >=20
>=20
> As mentioned on Guenter's v1, this change necessitates a corresponding
> update to arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts, which ha=
s a
> dependency on the name of the regulator.  Given (AFAICT) the lack of any
> combined dts & driver patches anywhere in the kernel git history I guess
> maybe doing both atomically in a single commit might not be considered
> kosher, but could it at least be included in the same patch series?

I was gonna do it in isolation if this went ahead, but I see you went
and did it yourself - thanks. As Guenter pointed out later in the
thread, any patch that combines dts changes with drivers or bindings
is something that likely snuck in or was some sort of extenuating
circumstance.

Cheers,
Conor.

--yaaNXt9nsk607/Xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpE9wAKCRB4tDGHoIJi
0ip+AQDYD1iWAIQyUVXbKq8vwSg7xBKWez+hDMQthSMQI51qdwEAhBaavARz8BKy
vN+0CKAeuKtMEb4V4ToEhaF9M80TtAI=
=z3Nd
-----END PGP SIGNATURE-----

--yaaNXt9nsk607/Xz--

