Return-Path: <linux-kernel+bounces-66961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E574856451
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA70B2BE51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974B12FF69;
	Thu, 15 Feb 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkxPcOon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15012FB17
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002791; cv=none; b=Ux3kQ6t+BCelWfmom3C1Es333KDJEBHwgyPczWkgmqsjZk09nEZnXQ/vacGw5tMZSpuuoUtq0WZS0+pYi3+wJ/SkhWoSG6HPV7iKG9ZphsMtC+TpNno5oARJYTKas9+rvpW6V0+f8UBhq0mDD0bjqczak1WcaYxsYglNpFbeOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002791; c=relaxed/simple;
	bh=k6ahrQf1bzBFsJWo3E1QJSMfD1uJ5Y3IdNDLKsUBB0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLFLMu23nCoj8iK1+GJB1958hmU3TQUhtNygHUk7KpcnLtw0gxB6jVipaRgkGHo4HOSXVuWkNBQlO9ZHS9t9I8zBMV1rjNDJ2d02jd9+6JHV+o5zKTvdjOvrw6RyzIeg6oWa2qd9awKu2WLDBz1l1xI0FE5sQV9GfgvxEahBmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkxPcOon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC179C433C7;
	Thu, 15 Feb 2024 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708002790;
	bh=k6ahrQf1bzBFsJWo3E1QJSMfD1uJ5Y3IdNDLKsUBB0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkxPcOonMGtPXqAOwpoVceaCLFP7SN1a0BKT3mpaKj6u+1la//uTTZ8WIN5hFvYCw
	 n9A2XRV+GuVLXRfznZrZfbwEmOnLgn6N9WYrzs3wN8JbL2etyF4D20ECtEnBnZ5kOk
	 WG64Obz+oJTXzLi8H7OwGlenHeCMj5iNDWxMT5IpoPjyLm7jTmIghtDnKxsitw24KN
	 3MBlulob9BueIubA13HY6QUPjDu4U3RLxSjf8JzNSTXi7RHwWu61ytsn8Mah15CGpV
	 rd1oCmKEJCTWCg4sedBtGluK5Z6R5qXECjbNqdMnJS/5RKf6CPkTazFf2xS2KM2/oU
	 DUdugBbPGNv4w==
Date: Thu, 15 Feb 2024 13:13:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: lp873x: Use bitfield helpers
Message-ID: <cfdc968e-f5e7-48e0-805b-8a5d745a7536@sirena.org.uk>
References: <15edeaa9a644c4025234088da3dabb023fce04ac.1708002503.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0S74mQtgFvj/nx3f"
Content-Disposition: inline
In-Reply-To: <15edeaa9a644c4025234088da3dabb023fce04ac.1708002503.git.geert+renesas@glider.be>
X-Cookie: Pass with care.


--0S74mQtgFvj/nx3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 02:09:18PM +0100, Geert Uytterhoeven wrote:
> Use the FIELD_PREP() helper, instead open-coding the same operation.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Mark Brown <broonie@kernel.org>

Presumably there's some dependency or something which means I would have
acked this rather than applying it?

--0S74mQtgFvj/nx3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXODeEACgkQJNaLcl1U
h9Dk9wf+K3ddGYblBNV7o8hfLUgyOwpIFNzO4BbcSImGjJkqi0GLjiXVYD38AXfj
1pVgtbGxeRrodZ2fGwPtNlqKXV/QcQkxbBJ6aox7+cj/W8X9TaSpmU96yPJNF9Kc
YyByGq2vWdZ5272dpOGnppjMVk1qvHht+ydTVLM8QwdFFZbp5gcYyeUbhuKEBjMD
F9GAYxeN2dZi/TnolHExBxxBGiaJfbVbg+f7w9yUyfM5/GZe3wy7aY53CQSpQSz0
57wQUMdaiU8uUcY/ffx6gzMGnlCyGRVNMiPbrVsFIt3Ly7ffBVdE4WNFcFILjH4I
AifJzyQbJ4nc45sSK1OrJ/fpWUpFyg==
=C+YR
-----END PGP SIGNATURE-----

--0S74mQtgFvj/nx3f--

