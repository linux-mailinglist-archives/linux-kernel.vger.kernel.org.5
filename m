Return-Path: <linux-kernel+bounces-48155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2083845809
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369E02876E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5F86646;
	Thu,  1 Feb 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvgWe6TE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F415336A;
	Thu,  1 Feb 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791663; cv=none; b=JqwPM2DIseA9nfrc/tzbqHoCp4txFB5a1L6DT/LIbPH2ORpoV0E65Q9vI7hX+nPGXwLuhaMooKjFwOPJIQIZHXstm2qgtYPJTZij14pJeS1V/1KO/NfH8dxLFe3bJIt00GeZHUdQMCBQ8vP+AbGzZItiL7qCrKYx8cJ/M6hC0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791663; c=relaxed/simple;
	bh=pfyIXZDpe+PzOEhUCcex34QzQ9m9/xSM8przvGPqCHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iydhDWHKhQizxp81T1PuqYDhHj1+YCYuHPEilCxvqSwWEh+vxmHAHyGrH21r7epscx8+KDZ5aqjDufno5CPCyQfARSoqEiVqsvK25Lkgvlna/04+BefENQgV9xzcbZ7oy+cCY/Md4IGC7sWvhFJcUMi1D2ZrOWlMXy3cGfWwYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvgWe6TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412DEC433C7;
	Thu,  1 Feb 2024 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706791662;
	bh=pfyIXZDpe+PzOEhUCcex34QzQ9m9/xSM8przvGPqCHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvgWe6TExi/6E6ARbS60l912CKcDcS5/FM0uAqpU5v5dJJ1YcgsVuqpbYqPUbj14T
	 WNFhoJ4Q0+7T2UOfhbjO7Q0vBEa5I8GYjVbGRNJTzSykdBJrypLfT7B6k1Pc356JaM
	 MhpYujp+yAp+4CFMYL90ckHHgL4LX31XCLEgnuM0m/90xqlj+yPs/M66zCjPqruzCi
	 L/DjeAIK8G+F5cI4+WYB6nS/+TvZw/16C/DbaAQjGaWSs2AObwHy1kWrOwaUz/Oo6A
	 j5magtUyaKUzXkdEqc2Kzgw7Z2in7FKJZTn7kWhgV+7ZAGoM6VGAE5+W0cdtWC9OCV
	 CDGTjgRsOjuPA==
Date: Thu, 1 Feb 2024 12:47:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 00/18] ALSA: Various fixes for Cirrus Logic CS35L56
 support
Message-ID: <1cc8d9c7-2af5-43f1-a022-75624deae51f@sirena.org.uk>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CDtLnkViadJro5Nz"
Content-Disposition: inline
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
X-Cookie: You can't cheat the phone company.


--CDtLnkViadJro5Nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 04:27:19PM +0000, Richard Fitzgerald wrote:
> This chain of patches fixes various things that were undocumented, unknown
> or uncertain when the original driver code was written. And also a few
> things that were just bugs.
>=20
> The HDA patches have dependencies on the ASoC patches, except for the fin=
al
> patch that removes a bogus test stub function.

Takashi, should I apply the ALSA bits of this via ASoC?

--CDtLnkViadJro5Nz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW7kukACgkQJNaLcl1U
h9AAwgf8CybxhlcP0vma6wF2MMGIG14ggLVyQOf/7GCmv2SetczhzQxcsJg2O1Oh
X//clpmlLPFK9WZzjZwoJ7vsdsbROiILlNblqzMQO4llCCi4CwaXx2xUyhiIcrTA
UWakVULs7ip7fUiLtTP0ztYDbQji8ly5BIacROzLGoWo7KQrVulLhlf34IU+VI0H
Q3YDZH2KN39ls/UHIDbsh1vRCnNvg3OCziGN063D2CTBFc3fpTCyUAhG/ODyg1Y1
aPSyAy/jTMsGmrRpRTtI8zoM1srKATSA8oNcyhelfZXvA0zZ2zja8GM0ZBiGdye1
EISkvnFnf9gB/+WJPejgAncCL07xcA==
=jCSO
-----END PGP SIGNATURE-----

--CDtLnkViadJro5Nz--

