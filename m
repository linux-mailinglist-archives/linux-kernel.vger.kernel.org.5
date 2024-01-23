Return-Path: <linux-kernel+bounces-35414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBA83909D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468011C20E77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128C5F578;
	Tue, 23 Jan 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boMxB21b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBC5F840;
	Tue, 23 Jan 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018232; cv=none; b=FF6XStvMtmqxFj/hWGar4LLi7uZgmSpcMtM90x2vf4LnB0wVdib6Cx/m8Kku5Cuq7b8nGxbUGxS3TQ+e/aH3I5X6f9ShxcW9GBip/dN3jZXCaw8xERvTtxcSWNb7aDuhj67JGWpXyrc+IDbpv7E0CuubJ40YLSGhYy6dV5vSeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018232; c=relaxed/simple;
	bh=bjE7cKFCXNgqexa1XbHJgB/+EEGcugDZWlZbQses+y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUmF5xLKxW7Zl+EEGCjcgs0366yItRDBtl6pS8uS9tz06c2ls1etPBAcikwvF9GhH3hAzOIQJXID7KvToIbL5eUnI6ZUGbYVzu7r9slucni8xGEmrw6CRKkPUCfz2YjJ5H+61cj0tExrOGngQBb3gEVTGUOreZ3dBcvB7Ech4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boMxB21b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24751C43141;
	Tue, 23 Jan 2024 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706018232;
	bh=bjE7cKFCXNgqexa1XbHJgB/+EEGcugDZWlZbQses+y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boMxB21b8V/JsPzmax4mUS3X3B46r/qfkuS2WXL6YSp3qOSqvWVYIJE4JLgE+/pUK
	 StUQNLHlNgxRbahrI4qQD/2FAU1SIQs0612LK5G9NMiUGUWx+5oniMu/vlJ5mn1sDD
	 7igsYCYu0f/2fjhApDopnkt+rLy1F29564CfJH+igbGQylQYpwcpIZkG6iB0yqt45H
	 CkAG4aETuQ6ET/7Owun10hx4+Qv7WjkzG1RBliLLCHy4RcM8S0zTr+fMemtqbN5aib
	 LAzbQ7VcxFA4CR89fqX6/8l/bVbgo0piu3Dh3bSGomc9TGdpDoGI09916oqzgoRHBG
	 CdVlQXrPHXJmw==
Date: Tue, 23 Jan 2024 13:57:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Message-ID: <05c38299-bc8c-4f24-a82b-4c4e66801cce@sirena.org.uk>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <170596045016.161959.16318695944363636291.b4-ty@kernel.org>
 <Za9xnEXYczA5rsw3@hovoldconsulting.com>
 <93fee0e1-ce92-4aba-8e4b-0861f78c32c9@sirena.org.uk>
 <Za-_jrByhGnKJo66@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BoaR20KATVigOpGy"
Content-Disposition: inline
In-Reply-To: <Za-_jrByhGnKJo66@hovoldconsulting.com>
X-Cookie: Stay together, drag each other down.


--BoaR20KATVigOpGy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 02:30:54PM +0100, Johan Hovold wrote:

> The merge commit for the series does not include the volume limit patch,
> so it looks like that one got applied separately before you applied the
> rest of the series:

> 	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-6.8&id=7c70825d1603001e09907b383ed5d1bd283d61a0

Yes, loose patches go before serieses.

--BoaR20KATVigOpGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvxbEACgkQJNaLcl1U
h9Bdngf/atygantZE8Loeo+W18IGt6CE9ghCmzgjV5VSGh0boNMyi2DrhGABuQXC
COMLo5JZPokZSO+TBTwD8z09fBXlNzW6n8uAT/hgKiH/8x2kI1FGN6StDilZiIJM
AOZBBcZTRQauGIiLUhl66Vt3/UfCIBVykBpK9PIq/2L/Ys3tScF9v+LgV/K8KvMq
CFOxyi9R0o1TvssNdrDUfw2ZKOOiqcCQNSCF6t0ZfTQVFSX0kV4MFqW5XVeTeguJ
fD8wDpMq/SsD/KwFlaU0UDcH8i/P18dSlpp54kmAZUrvTVs5aujrOEtsa2o4dM7/
LbqUxbpsO1o/QgzVSzrWuX41GtdkYg==
=R1jG
-----END PGP SIGNATURE-----

--BoaR20KATVigOpGy--

