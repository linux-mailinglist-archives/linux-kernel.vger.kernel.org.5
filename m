Return-Path: <linux-kernel+bounces-12816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76581FA63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2581F227D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65DFBF4;
	Thu, 28 Dec 2023 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImleyuI0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B5F9CD;
	Thu, 28 Dec 2023 17:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6AAC433C8;
	Thu, 28 Dec 2023 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703785213;
	bh=9lvOW+y4p7AcyZznFgvQnRNjR+a6hfIT15DpVBLsxLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImleyuI0fhDC+fRRLwsjkCZc6QDM1p9TW0/2CUFE6snl/n2vIcK39cvmTOsodWiLL
	 /LNbuEOKpIOZ3LNdJQzuvJQq0779LzQnpbK8hsuR95FRNg5zXruetSz0ZiqbZUCBil
	 Rb5pBdmGSG9CLLLU6UjsakXN4TYCt+Siwptv3oyBKHZsTmBywoaQubX/2pLWD/XMLP
	 JKGNe9iUQRIzmEQ81A++HYPncW4REz589Y1cMridSPiZnHlLEddqk8NOs7lPFdt8z0
	 ftvwafAOtz7qr7PTpPkEuhsQrPtB1NoZoy0j0qzh/qyAiEDT8Ch24GQCjANW0RPb1w
	 t6e84DEHEmGmw==
Date: Thu, 28 Dec 2023 17:40:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] dt-bindings: regulator: Convert ti,tps65133 to YAML
Message-ID: <ZY2y88J2gAn94wH9@finisterre.sirena.org.uk>
References: <20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu>
 <170282308261.876422.2237767392476986368.robh@kernel.org>
 <951a01b5da3061e1ac1d396ba7f6629e3a0e9a1e.camel@apitzsch.eu>
 <b67eba2a-b07a-4076-92bb-07bd0faf338e@sirena.org.uk>
 <401f400a-e267-4131-82ee-a5759edaa3cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PAaX8K46RqP1ey/u"
Content-Disposition: inline
In-Reply-To: <401f400a-e267-4131-82ee-a5759edaa3cb@linaro.org>
X-Cookie: You might have mail.


--PAaX8K46RqP1ey/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 23, 2023 at 03:17:24PM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2023 15:49, Mark Brown wrote:

> > The requirement for DT maintainer does seem to in conflict with the push
> > to convert things when people are doing incidental work on the driver...

> I agree. How about relaxing the check and not marking missing maintainer
> as a failure?

That certainly works for me - it could just be a warning for example.

--PAaX8K46RqP1ey/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWNsvMACgkQJNaLcl1U
h9DGNQf/c/Kg4yQTxlaPyoonpSzeqWf1t2c6AeY1Uj/dmyRZ5de+1ZAnwqLWYbI1
QkL1DXcYTi+Kzs1eiHdcgqNex7GaCOScJ5KY0TYh9oYv2HNGDjaVhjYxPtdxaQ+B
6l05HergqcpyvA60AcQk9oCdyRvHpQjYsTx6OX1k/z/4tA7phLzsKtVsq6kz2C/l
U+6WqmqqEIjeMh6pnGOROtksibxWTpNlklEjRZyBlJXTRRu3iFnLTcUwCK3oewIO
osv6AbTwKIeAuAkLyEc/naN4dJWq8tx71agBKIfp+6NBQVjGe6DnmclL9WoYehhb
YbHLXPu4vMCI2OnBFUe7f3GD4kKKsg==
=BIPr
-----END PGP SIGNATURE-----

--PAaX8K46RqP1ey/u--

