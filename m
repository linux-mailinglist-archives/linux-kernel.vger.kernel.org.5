Return-Path: <linux-kernel+bounces-9790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F2581CB83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C5B1C21B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64623741;
	Fri, 22 Dec 2023 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlMgyIJu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A523742;
	Fri, 22 Dec 2023 14:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE7BC433C7;
	Fri, 22 Dec 2023 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703256588;
	bh=lQ8zwules50AdfT7MsVqZCb8SpNAPPm1C3PvbI7RSio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlMgyIJu63rGlNhUoHWMZ3Kjn1p6rG3cPZCwVTycd+pjvW+7qGQuL66FmzEDC8Q+u
	 mYTL76RZd71aj/7TxWQMaUg3ZvoSfVc5fi/j3LwD3bh6LU43f9pd6ZA3ZMI72PYTnH
	 hHfLg3I4gWwMhJkJtXwD45GfrEMV1QjhMuri2lEkTn9qJ8zySSn4NDJ+4LpaGSkuLU
	 RyRpmV+Lda++txXKPJi2IcL3s1NaqdC0IODa59MSRT+llJsrfkm9UZoF3hx+itaQcS
	 W5oS1IV9x0WUPAk3TfVQjgdBoFFR0PLqm8VyxGLWbA78XsK/YBoeaw62PzljMCJGXC
	 VKX2zGhuuF19Q==
Date: Fri, 22 Dec 2023 14:49:42 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] dt-bindings: regulator: Convert ti,tps65133 to YAML
Message-ID: <b67eba2a-b07a-4076-92bb-07bd0faf338e@sirena.org.uk>
References: <20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu>
 <170282308261.876422.2237767392476986368.robh@kernel.org>
 <951a01b5da3061e1ac1d396ba7f6629e3a0e9a1e.camel@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UQoCBZBzcizwRyOz"
Content-Disposition: inline
In-Reply-To: <951a01b5da3061e1ac1d396ba7f6629e3a0e9a1e.camel@apitzsch.eu>
X-Cookie: Familiarity breeds attempt.


--UQoCBZBzcizwRyOz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 08:50:14AM +0100, Andr=E9 Apitzsch wrote:
> Am Sonntag, dem 17.12.2023 um 08:24 -0600 schrieb Rob Herring:
> > On Sun, 17 Dec 2023 14:21:39 +0100, Andr=E9 Apitzsch wrote:

> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-
> > ci/linux/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
> > : 'maintainers' is a required property
> > 	hint: Metaschema for devicetree binding documentation
> > 	from schema $id:
> > http://devicetree.org/meta-schemas/base.yaml#

> I haven't add a maintainer, yet, as the driver for tps65132 doesn't
> list one.

> Who is willing to be listed as maintainer for this device or who can be
> asked to become a maintainer for tps65132?

You could just put the list in as a fallback I guess?

The requirement for DT maintainer does seem to in conflict with the push
to convert things when people are doing incidental work on the driver...

--UQoCBZBzcizwRyOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFogYACgkQJNaLcl1U
h9DrOQf/eA9mDu+6BbsDbSGYBa06sQX8bYLVtXz5BKCJdAJLtI0NfeEHshJe07u9
oVUTRHb3U8bVjrfGoyrHZK2AUTuCx0ZEh5TK1yucr/xsaOibyeKS7DrlA0V5Ig9R
0Vrkd9yrfa0Qv9k/l0CB1GORlmo1bPxV7trL6GjHB/i0BkJeKo0wqEp6MOOwTc0l
aLZvsaZFYGBtFB0wSTAFdTHKpce5xjGG7oNbhA6xST5oOS6nAaJAVs553p/uDspx
Z5HZCDyeBaSAiIPMej1Fu9BxHM6j2E0C/uSnsg0zi99ZuRHMvrtDT2RjJonXTBUm
/crS7sndsevxlwTHkZWo4RPkqC4uyg==
=3Z9i
-----END PGP SIGNATURE-----

--UQoCBZBzcizwRyOz--

