Return-Path: <linux-kernel+bounces-3695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D5816FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105351C240E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB774E0A;
	Mon, 18 Dec 2023 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/IOaIRA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836B3A1A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5ABC433C8;
	Mon, 18 Dec 2023 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702904501;
	bh=W8eAPiq8dzSUZQJ7s0j4TLMfM3ORPvHdiiFiHj1bm2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/IOaIRAD47EW7wqSgM5+70Ae9oqp4TXEgnI0oevAcUhPPZ+2LHc611Byuq0sm9w6
	 87VpmADW9LJUtMrdfPdJSTys+Nc5NcapheEx36HaiedC0/Ku+ewFLPdBQzPMTwbHis
	 B52Fd5id8I6D5U68GrNhW3V/vXem6Ukn1p/8bk72pPUGf5B6teBVoh23kPnUtkAibc
	 uGXfEU4ZBXbcBZkHGZ4jonHjAQAMGrEG6iC96nrIFFnH9VNbKlYCOJpx29mv9uWJVT
	 MGdX8/f654+ECsiJd+4T4nbAGrnoUyhEvp8NrvYMrQ+5xF6tLaMdF5+lh8j3qEEXIX
	 RqGSATdfOofmA==
Date: Mon, 18 Dec 2023 13:01:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Karina Yankevich <k.yankevich@omp.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] regulator: of: Remove redundant check in
 of_get_regulation_constraints
Message-ID: <dfe54005-d897-494b-8566-7d18172c7dfa@sirena.org.uk>
References: <20231218095707.2625407-1-k.yankevich@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dh5vtBMWhTYQtpvO"
Content-Disposition: inline
In-Reply-To: <20231218095707.2625407-1-k.yankevich@omp.ru>
X-Cookie: I'm proud of my humility.


--Dh5vtBMWhTYQtpvO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:57:07PM +0300, Karina Yankevich wrote:
> The pointer 'suspend_state' cannot be NULL after the switch statement
> so remove the redundant check.
>=20
> Found by Linux Verification Center (linuxtesting.org) with the Svace stat=
ic
> analysis tool.

You've provided no analysis which shows that this is the case, nor any
explanation as to why it matters.

--Dh5vtBMWhTYQtpvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWAQrEACgkQJNaLcl1U
h9DL7gf+OxwM2j5lCsFSqZjcuEhr6emY4ZO9xN0p0ZJej2FCwKelTnomri//mFvn
79SgvZxjC79EXhXScQzsVGQDgUaCdOmf08ELEKNtjIkEmvPeHDYAqRcBjj/XEERN
2KEkeOJgLqijxQflI0tQtqMWbyXSfSvrIfBZItR9yz9HLCmNSvZvoftoPyO3FHSm
DZsYdHS9g3oEECuYv+kh5ruJGfwxt1y2gye00BLR4TMyqOWTkdQR2ymoW7L5N6PA
5O31aF6gQBWkeeX4KphpCQBhREjodLTHbcBumNHvg5JS+mIfDiDLZoRvDcHehu16
h+5CW9JNrhUnulkOHLwDOIRwt3QH/Q==
=RwMo
-----END PGP SIGNATURE-----

--Dh5vtBMWhTYQtpvO--

