Return-Path: <linux-kernel+bounces-82130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F0867FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DC8291EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFE12F365;
	Mon, 26 Feb 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ3F9cbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826760DC5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971745; cv=none; b=mY8XqxGI9ezjCxCKPQd05AUys2oKxO9Vtlr8vlFw6Qg4ZUFRi/vpvBGnFiS79FJSpDwv0cBIMFTWVzvNCABD99kQjToFwyditbRPj3PiwE/8YM1TgcikWdkvCKxm8khE5BlPsw4I9HAx2vdBRjEEN5uA5A5Gq4ZUIa22rQg9SFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971745; c=relaxed/simple;
	bh=4HJ7QZmEzbiNDw8RgLII/RxxXuOFtD7S2+44xweOYmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4K8M14VS7+rSB3JBOemxW3E/T/Co0zdb3a/CQziM7k2Mqy+9OEkMJ8hGc1oUf5UHNy/6R+/KI5y92A8rMCs16aAGNL2/bTg5B+WuS39e/EOf7YA/asyutrilYXNx45mR5/HZFduU9J2h138VYnhx+olKf9TKSbBAbFQvMgLgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ3F9cbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CAEC433F1;
	Mon, 26 Feb 2024 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708971743;
	bh=4HJ7QZmEzbiNDw8RgLII/RxxXuOFtD7S2+44xweOYmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZ3F9cbzquR4xcLD4TKdKi4927TF5ehMsNCkIqhYOPGGwQVrRbAMPobMeas7b2wNH
	 LQMLxJ0hlg4PmegcHtr+Hn+cLJGKrIQhGg3FDPXt2HUOrlxCDGDp/czNj7v3OezWNY
	 AFSmaPintXCFy5TLf5GKEvn/5cYT/FYdn5WFCIk8HPsGtm6c86odb82poAA0rfn7VG
	 oricTtk4K/kYGJ55NRWPYdjwVr56KErmzQAQ/C5/vY4H2FSTdlfJYPKR4dcBU3EqLj
	 9Z796+S9Sq74IDc4vXs84uLUHPbCAKZkkSemf+rKTLO/2kiJKhlso38WM3XiXB28Qf
	 njW8zL+z6mCqA==
Date: Mon, 26 Feb 2024 18:22:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 6/6] ASoC: meson: axg-fifo: use FIELD helpers
Message-ID: <33629de8-df96-43d6-864c-a5a3f022edae@sirena.org.uk>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
 <20240223175116.2005407-7-jbrunet@baylibre.com>
 <a828b4f7-282b-4b83-9a64-04557edf9b6a@sirena.org.uk>
 <1j4jdvdr5l.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q+5S/qvXOwv2kElV"
Content-Disposition: inline
In-Reply-To: <1j4jdvdr5l.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Walk softly and carry a BFG-9000.


--q+5S/qvXOwv2kElV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 07:15:41PM +0100, Jerome Brunet wrote:
> On Mon 26 Feb 2024 at 15:42, Mark Brown <broonie@kernel.org> wrote:

> > /build/stage/linux/sound/soc/meson/axg-fifo.c:207:18: error: implicit d=
eclaratio
> > n of function =E2=80=98FIELD_GET=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> >   207 |         status =3D FIELD_GET(STATUS1_INT_STS, status);
> >       |                  ^~~~~~~~~
> > cc1: all warnings being treated as errors

> Ah, I forgot to include <linux/bitfield.h>. Thanks for letting me know.
> I'll fix it

> It was fine when I tested with ARCH=3Darm64 and the default defconfig so
> most likely it got indirectly included.

> Could you tell me which ARCH/defconfig triggered this ?

Probably an x86 allmodconfig.

--q+5S/qvXOwv2kElV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXc1tsACgkQJNaLcl1U
h9BbIwf+JQ2bGsvMg1TLmjMB3qUfEiDX/uoTzuiHGbK9XfKSLd4AHucb1y6162Ex
ukDAHzN22nW0mAffn+iCmWGhOsbi+omeXSurpDUhBprtLom8EdU/XW1sR0jZTyDm
p/o08Ymm7Hi1ZkqkBcEZUPbeWQNJJZ2nCkJ36CRYZsn4Ewu+k4sJgyQqeIEXL3aR
DB5mYXLFGggpOhMtboCw/YaDJew7Vv43z5zdx26jiBpb9RN7GBRrlZ+7qW8te6t7
qmKPnN81WszZRoS36MkLArodIeUwbbxPDZg2g8RLUPbUmLFF2EuYVNejbCHxyuy5
OUseW/HQKoPkQfWc9v9ZFR/QNmtYBg==
=bRmR
-----END PGP SIGNATURE-----

--q+5S/qvXOwv2kElV--

