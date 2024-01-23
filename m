Return-Path: <linux-kernel+bounces-35854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39265839766
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB61C230D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578581AA2;
	Tue, 23 Jan 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGDf1I/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA74811FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033675; cv=none; b=dNO1A4Xhp4XU8kjR5mgJ7tG5y3b24ffq8ytyHlemi4SoR79mMBnITz8zz4e6OC3DNVsJzS15LbbdQPLVlgKXaEZIb2XdBkWlYpAQZt/UhZ6lz3y1pML21JlG4gX6llHCT9zi4/4QlRSlQs1urYHGRcBFeC7V83UaQn8siJik2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033675; c=relaxed/simple;
	bh=EuIdbsvyEjvt0FMH5fVVnAJqZpjgSM2y3FKdaFbL4eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny/zj0ZmbS70n+0nPuDWa1EpRdzGTIMO9X91M74Yctl0a2ioThlOXoLEyQoP73ftBHOJDZL9FEYSJqB9xkhbeCyfP//s1mGE2aC+WB4rDPHUmftCmO250afCUxDJWWQuJjFUHmKKakkGHni7VawoiRHFn9XbnGBFkdU+KwSGdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGDf1I/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD28C433F1;
	Tue, 23 Jan 2024 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706033674;
	bh=EuIdbsvyEjvt0FMH5fVVnAJqZpjgSM2y3FKdaFbL4eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGDf1I/ooVgFDkKnpcEkeZTIqA7DLN+pnUkt16nkDbTdlQnj6yJ4tte6Q0I8CmfVi
	 0e13HumBvMjQd55zhSg9OQe4CxjCHmlk0Z0vfRdDPbFnsRmZyt9q5Ua2gWhkqyCN7R
	 HXTSLTdL59YZYtO2nd8vE800NFCqcWgO1LoaI94qTghaz7Xc6nZ0VbwogfzZQIuECA
	 qOk93/Ssr2B0cy0sLuowCyGqx33TIEXwCE3osB86jdrlFU/NvA3O7r8lcU039fFM+X
	 ztQ86cwGgqqO9SDSVvG9pWPxLmefgAO5NEM1hH1HmS5wz/fR3OmD1SE77BguyaVF3f
	 Vj7lbg7VgKSgA==
Date: Tue, 23 Jan 2024 18:14:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/1] Add support for the framer codec
Message-ID: <8519e1ab-42a7-4b66-86d3-d574c7e8a1e4@sirena.org.uk>
References: <20240123165615.250303-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pEFwQk1O5c+w1uU8"
Content-Disposition: inline
In-Reply-To: <20240123165615.250303-1-herve.codina@bootlin.com>
X-Cookie: Stay together, drag each other down.


--pEFwQk1O5c+w1uU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 05:56:12PM +0100, Herve Codina wrote:
> Hi,
>=20
> This patch introduces the framer codec support.
>=20
> The patch was previously sent as part of a full feature series and
> was previously reviewed in that context:
> "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--pEFwQk1O5c+w1uU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwAgQACgkQJNaLcl1U
h9CACQf+JSXLP8HEJFIVGaxMScSSutupMb8WfEunNGnepzwDj+HenCzzhKZh/4Uq
+Mi9UeXPFHPiGjclTRv17bp1ZO+/uPgcEWkEF5B3qISDUZf0HgvkMOA77R4hZ4HE
UIvZqWuaZz75MzGk+QZ2E5x92ut3YcP2nOACLCfQei2Xghaw0959ogv/zoSaM+NI
WJjnlCmMpw9Hhn9j6NPPQFyhUwp2geB7GnyRIf/H0UteMgqEznrpCe8DJUD456dQ
X7Zec6smOENJ+qqNgLJlzkcc+6xCdJICN9UXX0hBGyGf5vsuffTBbO20nOfqyudb
7gHrsPr0UkKzechmj5rjBXehP3td0A==
=Cr36
-----END PGP SIGNATURE-----

--pEFwQk1O5c+w1uU8--

