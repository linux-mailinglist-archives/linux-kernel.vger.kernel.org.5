Return-Path: <linux-kernel+bounces-59747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB084FB32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027F328DCAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045A7EF09;
	Fri,  9 Feb 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W31tYjMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6767B3D2;
	Fri,  9 Feb 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500516; cv=none; b=LT+rBQ+BgPrlOdStJ/3D9PbrQt7sHcsFqGLO5U8jRfmycIABDI9TZplecZFi0N2SX7lhFk02ha+9AdjqeLhnY3nXjZW4DJeRWz02Z/33QNn23NvrKts0ozc7MCb93Y3UXHDp3RWssEInJlG/BLHBMu1F+M0y9r15xo1DuTh5PV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500516; c=relaxed/simple;
	bh=Qc4AbQqALiytLpMcojyv4Ko9mDH1xImfA6IKZkEgKFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG3he8f3I6ABX3W0VXd++XBuZmTf/nVwQLJn8QJJGKZQUYHS5L7RyVdTQBAbpraF6LIKEpsNEcw3TJwK6dXQf7jcnX3QpS0sUMAdxQ6wAPOSyBFevS3FjkZxBZeq22mud57mNXC/ziywqAO7mIQyu7A4vfIZfl/rvzPsOsyahg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W31tYjMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350E4C433C7;
	Fri,  9 Feb 2024 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707500515;
	bh=Qc4AbQqALiytLpMcojyv4Ko9mDH1xImfA6IKZkEgKFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W31tYjMSmQ111vjm+XeO6U1F3LX9XB1Q8g/y+du1AH49RXonhAqz+xKFUrA0eA2OH
	 /M7tVdLaLD6BtZbLzpBsw4olqjVdMPOY+JLYP1fTTq9QjBdVMoWdcSi65zxfId0OWs
	 hJlceQGm+doqVrbrUOm7A6FBQCMOzYeLhlMoS6cITY3OOzz9X4Z5ChZk1NfYuLXrHM
	 mHdy8VMz7pg1omHGuW0keCpXVQ6LUjoJRMb0gseRutDLrsmxaDSA4O9WYGC1F4OB9A
	 vIqP3cafYV/CIkJS/9i9DwLaCDmW5WC6j5KggWkp0dFBoGt5cDJmTq/9guEKGzwiS7
	 jSVuDulsag74A==
Date: Fri, 9 Feb 2024 17:41:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, robh@kernel.org,
	andi.shyti@kernel.org, semen.protsenko@linaro.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Message-ID: <ZcZj3/0xI6HqP8n8@finisterre.sirena.org.uk>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
 <20240208-grating-legwarmer-0a04cfb04d61@spud>
 <c2b08463-cb13-4e9b-8797-8ebcf1047f66@linaro.org>
 <20240209-chest-sleet-a119fc3d4243@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgLDICfeMpZPQCWn"
Content-Disposition: inline
In-Reply-To: <20240209-chest-sleet-a119fc3d4243@spud>
X-Cookie: You might have mail.


--xgLDICfeMpZPQCWn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 04:21:16PM +0000, Conor Dooley wrote:
> On Fri, Feb 09, 2024 at 01:56:56PM +0000, Tudor Ambarus wrote:

> > At least I don't
> > see how it would work, I guess it will use the minimum depth between the
> > two?

> I'm not really sure how it would work other than that in the general
> case, but some use case specific configuration could work, but I do
> agree that it is

You do get devices that are single duplex only where the mismatched
sizes wouldn't be a pressing issue.

--xgLDICfeMpZPQCWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGY94ACgkQJNaLcl1U
h9CRSAf/UeE2nO0guLYvWREfU8g9XrY8V4UUuS9NFBhw7MxxJ7LMq3HNckLuExHe
ooFPzasOI0p1bL9293Lp6lx7xjjB9v/3g+mdiWKQP3zGz2GeFALCACYhXPSAJMr0
MGyjPLSsh62r3YTLVmi85MpnrbLiv63/uKTPuzonGgDrxF8xPpDHKrnHCZlSX84D
aL63bNmK+OZZoVOWitOMy+BZLJbI7khnbt6QNatsyFtcW4LqNS6ssM1a5TwkLqtj
bkfJ/cmBBRDMxj52bhU2aHPhzxkx9p3BRJNKogV6Pxk0WanzbRwcbmJFZS/IQTjk
3z1Rf91cjlbTfeSCRRhLjAM5IeFY9g==
=5hKK
-----END PGP SIGNATURE-----

--xgLDICfeMpZPQCWn--

