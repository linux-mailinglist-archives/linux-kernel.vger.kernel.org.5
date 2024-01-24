Return-Path: <linux-kernel+bounces-37234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3695683ACFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35A32845B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593777656;
	Wed, 24 Jan 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4IeEzzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6A382;
	Wed, 24 Jan 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109390; cv=none; b=BD8DejuLCiycdg817pUczG9ZMYxA3weZiDcZibOsWuDt8JFglj1kHgvZ/EZmnfa4AbQUIkWFZ3YK+UaNV3A25gTzFktX6sJi6YDRHPbbzEPwe9nj6ECjAQG6ZkCSk89kK5FQUoL9omFjLWadc1DXlcTLlc6A9NP6j+UaRr4Yvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109390; c=relaxed/simple;
	bh=teEG/HE5cVE8qRdJoU3arSGKdBLpBxrZ1kXz0DlNeQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT/SDI3TuwRNKMxxHIbYFRW/gReKRQW0oFlKxO5YidX4rauqusV+o2EzDuWaj8I0xt3U8y77AqcWgcEm/XHympYqqVtxP3ezWy3ScjJW2ANX2Jt+I5dAYv/nTGdVM/29EsKssziejFkhVbhx3A4HMZd95+SuWQRD51X8k5aLbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4IeEzzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84823C433F1;
	Wed, 24 Jan 2024 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706109389;
	bh=teEG/HE5cVE8qRdJoU3arSGKdBLpBxrZ1kXz0DlNeQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4IeEzzt8PL7Pq3Tv+Y3kdLw8a3QLEHW6MaQrtF4v1lSjv+qa+J+exdrrMMuvHQAY
	 8C5wkdWbVDKSMU1wVujfpwYxmNJnSg3YGPd4kgD0Oo8lAMwAaa2m88jIPvsBkni/c7
	 OiFS9ZiY1OgcATvhch9/nGMOZZc/Rzc4UHYgmxNySDv2UPOr2J0YG/rP98vQIiHk0h
	 vlNZ83gU47NtaEVsIlFFJcoPXZVdGmVHEjtNuF22JlnzyWAnIeFSutSjFjVTjt3rz1
	 M6//f9lqcS+XSyWlTowDywBA3HqTKu3z7jTiXGowSkaVrd58r25FfpfoWFY6kt6JY5
	 EB8iijR1l3e/A==
Date: Wed, 24 Jan 2024 15:16:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 6/6] spi: cs42l43: Tidy up header includes
Message-ID: <8b8fcdbd-b1c8-4618-acf8-e31b6ab33be7@sirena.org.uk>
References: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
 <20240124151222.1448570-6-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="555fmk7VPc9JdOqq"
Content-Disposition: inline
In-Reply-To: <20240124151222.1448570-6-ckeepax@opensource.cirrus.com>
X-Cookie: To err is human, to moo bovine.


--555fmk7VPc9JdOqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 03:12:22PM +0000, Charles Keepax wrote:
> Including some missing headers.
>=20
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>=20
> The changes to the MFD headers necessitate the inclusion of of.h here to
> keep things building, hence my including this SPI change in the this MFD
> series. The rest of the SPI fixups will be sent separately, as they are
> also not dependent on this change.

If this is needed to keep things building then presumably it should be
before or part of whatever change introduces the requirement, otherwise
we have a bisection issue.  Anyway:

Acked-by: Mark Brown <broonie@kernel.org>

--555fmk7VPc9JdOqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWxKcgACgkQJNaLcl1U
h9Ai1Qf+Iwy4hQvX006euDyDS3MsQArWK4ZhxwxVt9gRfwug+2P5Krqwe0yE1X/2
H5KXUz1D8h8mb75KTMpjkFH1Inhg2xYvh6Ib+SeIkOTms3yHZV+WVCD7lOQvgz5I
1vGDBg4Rpxo7pQdxDU0yO2tBkFcAyUdLLkzl09Sfl/gwotNc1xAV1RfOZJgvXSFi
tlX/OK36m1R1iuKBX+OjF+Imn8ItunzXt9D4zoKerZ8FBHqeXNuoVT7IO9c89/K5
OWt+Wamf9D1ce+DJiY07sMRP6ZpThempR/uAR0S5ruNd43iNKirI45l43MXBzxHA
rbZOc23OXifJwDHx51yXx0pIOdS0Cg==
=Sfm2
-----END PGP SIGNATURE-----

--555fmk7VPc9JdOqq--

