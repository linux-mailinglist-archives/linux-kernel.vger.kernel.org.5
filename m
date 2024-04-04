Return-Path: <linux-kernel+bounces-131369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F79C8986D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05CD28CD5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9A8627C;
	Thu,  4 Apr 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO1YE7yI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233BA84D35;
	Thu,  4 Apr 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232582; cv=none; b=CHGFhWGA+eAUIi53+oKSgCs6yPVMrWKyENQvayQcrQtUIHkg2z71ihVJuk9pM2YUtw6YFUCOL3OdkVSP+2wRIbhgzm86jvAk1YiAkcTNpDjcngf26SsywoCx3Hdc2To2eySvtGZ0VAD1sBRis3VjqeiHLWfzHWlxwu21IxMLi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232582; c=relaxed/simple;
	bh=iF+hZYmZWLuY/qpKYXvimUzQbVkITzEoCicAm2QU+ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7uPWS/NHtr4Nf++vpsE9CZdynR69ptwJ5Wspet22EG0Z+TSA/D/qMHxMeQZ5qDwhSF00RpVeWN1lz5/+nXNLr0g4/XsPQ4ZzNB81qkNvjif6SJBYlcM/7HSl3r4BFIMkGbFdWrH9akJ3qPrW7UlN0KZR9r0ChmlyatA3ZXoT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO1YE7yI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BA0C433F1;
	Thu,  4 Apr 2024 12:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712232581;
	bh=iF+hZYmZWLuY/qpKYXvimUzQbVkITzEoCicAm2QU+ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO1YE7yIHQ3qHA2nwtm0ZGmT8/uAMAQ4HLwBOrTlncFnT6lriWguTpZpABNNIHW5Y
	 qW3rMAAWv4c0Ok75qIfpTLWIaIs3z0scaY8iS9B46CBHfZBgDB0Wjc4jdGd6jyr1LO
	 gYQsN3RT7xMVJd95yiqSqpPArJGXx2gEUAO0DKw7qZugdu2OzMwnkDwOQ7hZ6F1qqZ
	 RCIeBIyNT866v7M20DFMDH5TChLGS/VOTCCGTR/TLtY2pve92qhd9BEq59iq30dINh
	 bj8OGhSALLZCuTkrSXp/Hz6Ebp4fnWqFD9WQ+i7JDmfJBmUFy45D5Wcd8g0DmpQ9Bg
	 BSvBdwPyFGYqg==
Date: Thu, 4 Apr 2024 13:09:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Support ROHM BD96801 scalable PMIC
Message-ID: <eb03ec33-0627-4986-be04-8e35da390d6b@sirena.org.uk>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bLwWuxLdQRd8U3iv"
Content-Disposition: inline
In-Reply-To: <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
X-Cookie: Buckle up!


--bLwWuxLdQRd8U3iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 10:26:34AM +0300, Matti Vaittinen wrote:

> 1. Should we be able to have more than 1 IRQ domain / device?
> 2. Should regmap_irq support having more than 1 HWIRQ

I would expect each parent interrupt to show up as a separate remap_irq.

> then it seems that reading the IRQ information from the /proc/interrupts
> works as expected. Here I am making a wild guess that the name of the domain
> is used as a key for some data-lookups, and having two domains with a same
> name will either overwrite something or cause wrong domain data to be
> fetched. (This is just guessing for now).

So if we arrange to supply a name when we register multiple domains
things should work fine?

--bLwWuxLdQRd8U3iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYOmH8ACgkQJNaLcl1U
h9CueAf/QxTLrSUED3FleSmC99lu2f6hCDoyehpmImkDa1WIGmVrBCv6Rr9IIogs
u4+/eLtbZ/A8yxKJz7qEXBNwwS5LOpZpPPZvrTe9sZ6E5vbZq1EWP2M3OdnsB9XS
64XavlWRYG6MgbYLx3G4E7xHzfAFmEBY3e9s2eaxYpH3iWiTruN8sSsS2Qx4ji8Z
DDiD4SVtDHtHT/Njz2bR1iEw2Dq5yVRGRahTcmL7mGfcskcB/KB4x7dV4WfOJN27
WZ5tTG2wDMRlan9AY9myMordW5FIPqzOhE4MdU3bmNNU/AcvrqRw0qrgvlKcik7r
q0m/K5N4s/Bmnod2mW0p9r0Z7vHSig==
=1Y5H
-----END PGP SIGNATURE-----

--bLwWuxLdQRd8U3iv--

