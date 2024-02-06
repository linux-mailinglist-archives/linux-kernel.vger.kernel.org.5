Return-Path: <linux-kernel+bounces-54727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443E584B2F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F133C28518B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810325677B;
	Tue,  6 Feb 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLYe5xSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41445BAE6;
	Tue,  6 Feb 2024 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217149; cv=none; b=VzZGHia+g+v2XHO7RENc/rWVb4QYc/KdAnf5XCL4Aw2wP6Fxj+25Jj3dF5vf5u++vMv70sNdhdbmGDwi9O7wfX2EF1VKn0xf0hwmlO4n8sgtiQnY1jRwY1p4pxLpa46DXL3WAxspqh1M8iI2k3pfCuBXtgZnxYfF9lETcpxMGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217149; c=relaxed/simple;
	bh=m1COPvgI8DAgpxWvHI1P0CLUstxG49tEkR1RqUd5cuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm4kPFBB2MPaNUTG53AQHw/U+n8aHWLQxJWD4A16JzAV6uA5SPu7k7C3Hfn42bBpV5jLeEdM7f/rTCDhA8ycUD6KER10O6OqjwRZv8bD/ufFDsTD8dfPYt36pTrHX5fukMQ5EzDS6A7Rudp8FmZFfNggF+5/UhtmgGKWSLrxYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLYe5xSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84048C433C7;
	Tue,  6 Feb 2024 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217149;
	bh=m1COPvgI8DAgpxWvHI1P0CLUstxG49tEkR1RqUd5cuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLYe5xSd1BGjdt9JytXSQ0iJHMFYUejuUzmpBDu+9ZMUDUoClQyZUKCSENVA5kT9m
	 vgDc4b00j+NSnir3Glqca86K00a/o06TGHh1fnwCNkpUK6oWv8r0FqDkSO0NyJu0cZ
	 rLFrF/CPpFp2oau3Py417CL7J0e9MbRZtJbWUM6VLnee8KwgN1HLnJbByom/tOK8Be
	 Xk7aY8V3dII2cBKDeyVAEDbl+Lh5I3cJMobvDIsrE6XoBssIvvw0DkI5tDnIcGq67a
	 AADmjAgVVue9m299igFPDFXSqzoIMywCIm2wuI/XFXnlIfAOSPv1rjiflwMEtKhD1l
	 46W6CJKCQDr8Q==
Date: Tue, 6 Feb 2024 10:59:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bo Liu <liubo03@inspur.com>, lee@kernel.org, wens@csie.org,
	marek.vasut+renesas@gmail.com, support.opensource@diasemi.com,
	neil.armstrong@linaro.org, ckeepax@opensource.cirrus.com,
	rf@opensource.cirrus.com, mazziesaccount@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org, patches@opensource.cirrus.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/18] mfd: convert to use maple tree register cache
Message-ID: <ZcIQ+f3F/hSU1Jcx@finisterre.sirena.org.uk>
References: <20240206071314.8721-1-liubo03@inspur.com>
 <CAMuHMdU7fYCsNT9ditqJ-saUsRm9J2zLh=-q-zmExhBRJeE8NQ@mail.gmail.com>
 <ZcIE/RMTq34TgpQt@finisterre.sirena.org.uk>
 <CAMuHMdVj1bS9s69ASrd5xULc8oELoBbnb8HEX9MEmA43853_EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wohqWBqzA9LyPZP8"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVj1bS9s69ASrd5xULc8oELoBbnb8HEX9MEmA43853_EQ@mail.gmail.com>
X-Cookie: You might have mail.


--wohqWBqzA9LyPZP8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 11:14:11AM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 6, 2024 at 11:09=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > There is a very small niche for devices where cache syncs are a
> > particularly important part of the workload where rbtree's choices might
> > give better performance, especially on systems with low end CPUs.

> The REGCACHE_* value is specified by the device, not by the CPU?

The device is going to dominate here, the main thing is how much of the
workload consists of syncs.

> While some of these MFD devices are on-SoC, and thus there is some
> relation between device and CPU, several others (e.g. PMICs) are
> external, and thus might be present on systems with a variety of CPU
> performance.

> Perhaps the value should depend on some CPU heuristic instead?

No.

--wohqWBqzA9LyPZP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCEPgACgkQJNaLcl1U
h9CLEQf/Q8Y34eZ58gNTCjgBWHllS9BWTNNoJRfggd2UXR/TK6Wux1Oco73AD+sp
j/x/FfZT9XT7iXbarZ87ZUfIEOS0Av7GhvLufUzoxtgfwbGkm+8sR96avkCzf8sX
WpZ5sICL8fs2NykKkJt76AWsgWaBOYnRgyZrIZ+0a1w+ZUiE5UYEb6TQ7IZZtKrE
EehYa/mJg3yWROqkiRtnEvouDAmIAgVH7rM2Vfj9G79uLyG4fsvvsuOEjQ5KMGMU
IQAfWU0Vik+XfvR3VhaP11Bd3wjt8noEbyksgDXNSHwDDNH1zytr6GrQJGJkkVh0
JB5leaIP9fDnAmofgyqoOqG6uUokNQ==
=UNpd
-----END PGP SIGNATURE-----

--wohqWBqzA9LyPZP8--

