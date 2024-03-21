Return-Path: <linux-kernel+bounces-110001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB18858C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3466B282E36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF47580F;
	Thu, 21 Mar 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgeI9k/i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAF56B68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022769; cv=none; b=lT7ifZrrhYAy/a1dvLbwy8gjsEt4X7nUvzVt4do57CA6cFpdi/1ZBTI1BfahdOYfI7yYmNuMXpqHVqwCfNiSW0GKFFZrdwsPu5d4Nz6qZiP+QGga/UcCoIpnNyiIUMei4tx18QAXOr8Nk7lqd10AdgBkYB9o78jKieG3gwygu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022769; c=relaxed/simple;
	bh=ZyAdqdskwCoKpdggbTyuX1Rx1MltvRYgT73WGu7q/ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye+4oh+ezEa9xwgqX9cCYgUx8u/CxIpWwJwfBqRnuFcsZVNC3/yngYdW77kyIAJvhcdIYHvkgsulHx2COLyLfHZ5Z4bbLBwNmpIFaUrzoMgVN/t0jzkpNzkOqLtGUdJUkBepPtRXkMMg9jB5eQXWGUFNIlLT+bpurXxF6cYWw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgeI9k/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A113C433C7;
	Thu, 21 Mar 2024 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711022769;
	bh=ZyAdqdskwCoKpdggbTyuX1Rx1MltvRYgT73WGu7q/ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgeI9k/iPIk7tGuznR+w8Hm2Pi+FAvJhIuQTEl28m+dVCLBU6NWKhSys4zXsEdd1Y
	 9m7q1tHEsv3apkfkoAVJQYz5Mbap15xDz5s5mX6FxcEfrPMMclAgO4dcu3cBoNkqw2
	 xmmTfzRz0MdUPiMuBmyJJBVa8nP4zQXp7cf8clu4clHtZghwlSM6rJ9MR5vz2tshfp
	 5eGRcphDNLTpkfqjZjgyDRztTTkmo+V13elqpekWCNDVCcxrX0jETWhrRFcR77YdIe
	 N9xS3qL1mHKzSP8gH+D0gzXGX4nSdlz6f6udPGoNh/Nye+IeOWbndKjgJETyjuRYmH
	 hUnv0dOCc6/3Q==
Date: Thu, 21 Mar 2024 12:06:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: gpio: Fix missing gpiolib dependency for GPIO
 reset controller
Message-ID: <d88c05cf-168e-4a0a-90dc-1cb5cb21f120@sirena.org.uk>
References: <20240320-reset-gpiolib-deps-v1-1-eaf5d30fa647@kernel.org>
 <3c5efec9-cb29-4226-8701-2917ce3c2876@linaro.org>
 <94f51c4d-d954-45f6-b222-18ff3be5b5d1@sirena.org.uk>
 <93a6fb3d-b96b-4640-8194-7f778a70fdbe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zu/YR1y9t6mpBvdK"
Content-Disposition: inline
In-Reply-To: <93a6fb3d-b96b-4640-8194-7f778a70fdbe@linaro.org>
X-Cookie: MIT:


--zu/YR1y9t6mpBvdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 12:38:16PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2024 11:59, Mark Brown wrote:

> > In general the stubs do make sense however in this specific case given
> > that the driver is specifically to control a GPIO rather than using a
> > GPIO along with controlling some other thing a dependency does seem like
> > it makes sense.

> Then you add dependency in wrong place. The warning you have is in:
> drivers/reset/core.o

Note that this isn't a warning but rather a link failure.

> But the dependency you add is in RESET_GPIO, which is a separate driver.
> While the driver indeed wants GPIO, this won't solve the original
> problem. You still can have RESET_GPIO disabled and core still has the
> gpiolib call to missing stub.

That's true, though it does happen to fix the immediate issue and seems
to make sense anyway given that the driver does actually rely on gpiolib
for functionality - it seems clear that there should be a dependency
there independently of the build failure.  Like I say I do agree that a
stub is sensible and you're right that it will fix the underlying issue
behind the build failure.

--zu/YR1y9t6mpBvdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8IqwACgkQJNaLcl1U
h9DMJAf7BUtbKl/N/uvzvV5XOOoE4HWpqVGjkM9IM2rmSi0Ry8+MQC9QhhmQpIfR
B8krqtJkxLK13zMCn076LZ2T9P0RqRlNvsaePGiJFnp/4toJCL3sB3wdfRl2gR2h
3eefkKiTYTUonmr5oLFSCOcj71Q7O+9jNkR04evYpikxjB4lb+i5xPrDXrPrbXFR
KhgCAcKacPibLagKncIGd/yMu0wtKwFlJmzYerWuphl4rHIdw00RWdRVykc6LPqw
9phE4tFm5iUrr5hCscl2ljlJEFe+vCUOM/gY/08tINrj1lDeeK8r/RRHTFo0xoK1
Q80OfgvlhlqlC1NVAlHsV53lcqTj0w==
=AHvw
-----END PGP SIGNATURE-----

--zu/YR1y9t6mpBvdK--

