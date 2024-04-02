Return-Path: <linux-kernel+bounces-127930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56A8952DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F36281FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9B7EEE3;
	Tue,  2 Apr 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klLwct7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3F78B4E;
	Tue,  2 Apr 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060530; cv=none; b=sTrGI+iY8K7GWwH0grfbNn4aPRLsR8ZMng4GhGFGwYMy2qJEGfIPcrZzIgaU+TcaGxwahvhheGQFYbPcxiaaHn7x2x4fVVD9MepZ/3eLhDQTSm9Porxtz801VhiT4WR36wyRY9pxR0Fdxk1QgQpX7EFuD40aNnzJmsKPE2VO3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060530; c=relaxed/simple;
	bh=qmT61xpESqYXhoFPXjXEy3AYJR4rNFumTpttPsZIrtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGs7AFgFCMV+Jk/WgCSIOx5bw4hfFzvuapPogizr7D+Zt8CyPQ7Pb4Pve1k4k0FFUwh2MPty4kscrJ8c14FU8m0g++LTkrJF2UglXBDLFvcZCf2PPAtTY430sshtnUgU2en1+2g6sM4rWU2OMZZlvPbYghg36jZ4dzWagsq8wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klLwct7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF59C433C7;
	Tue,  2 Apr 2024 12:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712060529;
	bh=qmT61xpESqYXhoFPXjXEy3AYJR4rNFumTpttPsZIrtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klLwct7d6FmF9m7SIP+kCVZyk5Qdr7PFZmnmOp8zRKam/4/PD0PrPSAL3EFSzCXzf
	 UDGmaFu0YLT8HI2DoD3AI0wVFoF0MIJTCMf5PDzsNAa7RAjJ9nVsTvcpuV4S8RmxvL
	 PP2djsJnLAXbdUM5Ypi5KKTEE3fP211eeRVKqjk4gOpvMbuib1Ia5kK/59RFM3BUgO
	 VQTq+7o+JJswjgpeAoOlqdZPsNs6f/OXHmYrOXwfDTS584JF67ZopAHBQvdz3dMNGq
	 QERvlHWluiJg9PPOnQXL8WHqDaXNDm8f0FMmpS6MXbveYuLGa7a87fN6VOmJaK1h9O
	 ipw5GPm0Fjryw==
Date: Tue, 2 Apr 2024 13:22:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Qingfang Deng <dqfext@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI
 controller
Message-ID: <c4df0a94-be48-464f-892a-7157cb30f034@sirena.org.uk>
References: <20240329015147.1481349-1-dqfext@gmail.com>
 <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wwGR2gIgMptPNZlz"
Content-Disposition: inline
In-Reply-To: <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
X-Cookie: Knowledge is power.


--wwGR2gIgMptPNZlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 30, 2024 at 06:42:11PM +0100, Krzysztof Kozlowski wrote:
> On 29/03/2024 02:51, Qingfang Deng wrote:

> > Add YAML devicetree bindings for Siflower Quad SPI controller.

> Describe the hardware. What is this Siflower?

That seems like a perfectly adequate description - ${VENDOR} ${FUNCTION}
is normal enough and Quad SPI is a well known standard.  We don't need a
marketing spiel for whatever IP version is currently supported.

--wwGR2gIgMptPNZlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYL+GsACgkQJNaLcl1U
h9BikQf+Nd+bJTiKoa1kyU6VH3F54z0ol7XeaUtcsZdj40SydA6N9rCOh4hN2VIR
OUN/odTAI67RPQxc8BZISH87m1KYdsPmP5ZpYz/Bpmaq/vw+IKs9koj/j+oceJbB
/QFKo90LGjz0eBmxZhf9+jdJ1UFL4nAmicTDVrpuQZHwlyMPwS+EGeN8c21/eU/b
vnZpoVAUp9C9NCzNSGLmp4DbgvvWx2ax52KwyjEmOwONqDODom41j9oMAnGv8HfF
ZDVd1+2rmG8rvXWWyFQOGdQHhsB7j8G4R1/bmZ/84bSN1PVPEUbI/4th6jVpbgfC
JuSax9KzPv7wHn3TpcpmyWoDmsXadA==
=vA6S
-----END PGP SIGNATURE-----

--wwGR2gIgMptPNZlz--

