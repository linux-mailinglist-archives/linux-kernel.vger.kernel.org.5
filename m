Return-Path: <linux-kernel+bounces-44488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7D8422BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10E21C25BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1180F679FB;
	Tue, 30 Jan 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yumtipkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADA679E2;
	Tue, 30 Jan 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613243; cv=none; b=ssQcYSDLXcxSeowymZvahr6jY9b5GmWKHRRZHd9oV+mm247az5N6rrRB9CLdm4lg1u0VaIpll7bDY77tv5Ft0yhRtfXz1WKKDuqK30mX5iUyDlNhadarY3bvbpUQtp8vpMcG3nkoWynBn3nLT/wUrwQMgzk8CzaJUMLnz/HvJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613243; c=relaxed/simple;
	bh=/9NzOhfNsiFt9TBV15bxnbKB8v1glIQ/hLc+NQj7LX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ+Ge4aYdo9VPRgwr5sVB+ge49E8/E1evAlCBI1BGN6KXdOMv6wivjbf26+gXYMaQQCZixOCL6QfGYpKBBiUk+KV3lmkex7xxsUXWkqDkecQXy28enknmNViReknhCPeJj+BItOSvi+PpHs9E8s8QQ4591YpRUOAHewy9gp/lQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yumtipkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BED6C433F1;
	Tue, 30 Jan 2024 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706613242;
	bh=/9NzOhfNsiFt9TBV15bxnbKB8v1glIQ/hLc+NQj7LX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yumtipkggd8S+HmelxCX+RgmP58dbbSqaP1bl0m9Jk8KAfbq57cRp7DF/g9AQO/bZ
	 SIJSkZTXsWBFcxJJwFps8y+WP7wrW9azpG6uOaqHkoiB9UYw1+yJlRRvSeBUVgArhx
	 Od7wfg+QwsYx9Yf2m2wUE3M3cFWp4KtBlOXhs9BoyWcSXrh7JhKND5VWv43cBGWANy
	 uts3cwul209VPKtFwcCGFai9xYiOlSYUNlTbAkrj45qKvdA7US2r7WSwn30ESSdc3V
	 hsJp1CDqsKtmTKZwz9m50KJIJvoktjc6uZ75SzKX+AVLIq/Nali7SDxE9wbZoZ4w0h
	 uklMom/GuJGVw==
Date: Tue, 30 Jan 2024 11:13:55 +0000
From: Mark Brown <broonie@kernel.org>
To: kovalev@altlinux.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, u.kleine-koenig@pengutronix.de,
	a.firago@yadro.com, sashal@kernel.org, zhuning0077@gmail.com,
	tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
Subject: Re: [PATCH 6.1.y 1/7] ASoC: codecs: es8326: Convert to i2c's
 .probe_new()
Message-ID: <25386374-44e8-4b74-8803-2dcb0806f80d@sirena.org.uk>
References: <20240130094708.290485-1-kovalev@altlinux.org>
 <20240130094708.290485-2-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JlNGArQx6R6RiAba"
Content-Disposition: inline
In-Reply-To: <20240130094708.290485-2-kovalev@altlinux.org>
X-Cookie: 1 bulls, 3 cows.


--JlNGArQx6R6RiAba
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:47:02PM +0300, kovalev@altlinux.org wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Commit 784252bac835c831e10c48be633cd1ff0d697326 upstream.
>=20
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.

This is obviously not a bug fix.

--JlNGArQx6R6RiAba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW42fIACgkQJNaLcl1U
h9AF4wf+KMjI0jWwgikQQPyjfg4Md2U3jxs0VUI32Yjrul2MIOQvX5y1E4+/SL76
nXtvq0QhXhQYgk8mdv4zlUD5+9ozi6NqWGNeU0ggquRieWOu1Wl4K5H/OeGDhuIB
uefbKQ+TFBvjzyQRub/KiQkI/RGvjdIj42ttScUuVID6BG3FlXiZQJATy+gWZIs9
2r7Up22dgKsmIw6U4GoV9fvQwP9xIM5gp3/OR8i3wpD+4edGekIUbYcs+NbpSo+e
xUjSz1YlrFfVnTdqZ/6lmdz84P8+0oTesan7TClPSG5qvWDoVvb3ruNeNdwNiMhF
qNRLj14lGgNu/7SJ+RXonBvcPHPpgQ==
=4Ne0
-----END PGP SIGNATURE-----

--JlNGArQx6R6RiAba--

