Return-Path: <linux-kernel+bounces-22101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E0682993B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061DA1F22F05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF047A79;
	Wed, 10 Jan 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLl5KJoI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AC803;
	Wed, 10 Jan 2024 11:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CDAC433F1;
	Wed, 10 Jan 2024 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704886634;
	bh=mwJrCpsKvuUCqcMvNxsHnQZmtYyfQD9QX3G8uiaffuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLl5KJoIiS72N38mQw9egsP0cnZ89Kvj5RF5MUorG0cl7hSslxX8G7NxfXiwkdpyH
	 SA+zfbuR12Cl/uUrInXED9S2i9I/2EdLGrpLU6rsPAV9eXK743H4NTqVBSONGyifJw
	 7ko/f8B/4v5OjJYiaDcRTMNtOTIixdRa+ATiEf9dqCYDrP1f3SxwnbrzfonaU1lzxE
	 0hQLPZArQDUy3izg6lsdcnMJnNhnUjHWH6NmBt1V1UfLaaS+9/h8jtJsm+60ZOetI5
	 hFZKvmBFbmER3Xr7M8JakP5barYxMTf9laImGOteBPBs//hJAOjrsZAD6/fTyHBD1f
	 3EtCKQ5rHeprA==
Date: Wed, 10 Jan 2024 11:37:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: dai-common: Narrow possible
 sound-dai-cells
Message-ID: <7e312b05-857f-40a6-a1a1-a954dfea7044@sirena.org.uk>
References: <20240109213812.558492-1-krzysztof.kozlowski@linaro.org>
 <1ja5pdzb7k.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uPIbnbsl4a7wx/f4"
Content-Disposition: inline
In-Reply-To: <1ja5pdzb7k.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Do you have lysdexia?


--uPIbnbsl4a7wx/f4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:07:30PM +0100, Jerome Brunet wrote:
> On Tue 09 Jan 2024 at 22:38, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
>=20
> > Instead of accepting any value for sound-dai-cells, the common DAI
> > properties schema should narrow them to sane choice.

> Adding a constraint solely based on current usage feels wrong.

> A DAI provider in its generic form must have the sound-dai-cells to
> provide one. It says nothing about how many parameters an actual device
> might need. That is the idea behind this binding.

> It is up to the device specific bindings to define that value.

> If restricting things here is really important, defaulting to 0 (with a
> comment explaining it) and letting actual devices then override the
> value would feel less 'made up'

I tend to agree.

--uPIbnbsl4a7wx/f4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWegWQACgkQJNaLcl1U
h9Dc7wf+P2n83klonD5EiADHNArTPBrzWtVooyEDf3soqckt8MR+DtlIo0460+NS
2oTbfl6e2b1tYShEhraljnpAewMBnsexZWfnszWDt6aMtm1MBQxj0TnK0LTIp6lz
CYr5voMqzQtQaJOO2XqdlExuT7oK34tf1JA8yg7699wqsdrrPrYq0cYZw3QOMCJx
i0bTfY4dMNNmBahx9aNeoQdIOfu0272dk9Rj9d8U7TwN3vQSFnt0kz3/bswGhjCx
gKs81/Kn/sChLbTOzZel4Ctw/AAFBUYpnVsm+JZwpp3ma77LTnmFWw1ogEXq4HZl
yEfxszZgp4ylkHQ5WLPSFFkR9D5qHw==
=W+Yk
-----END PGP SIGNATURE-----

--uPIbnbsl4a7wx/f4--

