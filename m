Return-Path: <linux-kernel+bounces-109913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDE8857B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34A5283A33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719557329;
	Thu, 21 Mar 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqKmKa4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C957311
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018780; cv=none; b=kEiDxIUtUjBo++omPKTFO3Dwp+fjSJgqCTgnNwV1gmvCXreB/7d6yTVnvNK/75jkwQKhq8z2onz2mDUjGFfzZ2nNRzx2Fw5K9+ojFeuNyfpTbPMrGJQXS9TuGIg7BfqI5LQClefS6Yu+fOGVd57j0ZSb+HeNLvYzyw/+nyzQD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018780; c=relaxed/simple;
	bh=unGnft3Vvxvu2SmIARuZJrAnC+4UBELoLWaueW96N6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLDwXCwj1eBlw3h4bN83q86Ga/H+nVzun1Po4YABBKymjac3akkuAhwTHL5sUl7cbDYptvi3N7j9rYCxzVO7qYGsJTvQ/et8IkRvJYJaQJgx2uqiy0AdXb1L/0Nq5dAl+cWLQWbvVYJIZuRO5zuTRQ80vK3m+IhlgObhm0o1AaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqKmKa4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B69C433C7;
	Thu, 21 Mar 2024 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711018779;
	bh=unGnft3Vvxvu2SmIARuZJrAnC+4UBELoLWaueW96N6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqKmKa4ynBgLdmJl9RLYiJejlZpDunyKviajyMHSBvuIbNAi8wDaWDvllcTq4+0Ej
	 kUd6XVUpSedNBSiVMnEFadDRfUk9dboQo3+u4UnsXJmOm+9YyQLHkKak/l0C/qlhJt
	 H1sr6dAz7RAhL2B8HWMHmgNCphst+B3GA/vstL2hvYV41REZBGfus2ntXQfOBTf9tE
	 p1tGisOWD4KjkCWPsf0qouBh+Qk/9oydKLqir75DLUdbGJ3ffcyQQFCrzK6biGnimf
	 hp8kicAF2z1893LHnMvnj2W4qyBv3tQjrHJl0b+eHCtFogtxCi+sqTsxdPGM4A7eaO
	 eXrfSxGXGyC4Q==
Date: Thu, 21 Mar 2024 10:59:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: gpio: Fix missing gpiolib dependency for GPIO
 reset controller
Message-ID: <94f51c4d-d954-45f6-b222-18ff3be5b5d1@sirena.org.uk>
References: <20240320-reset-gpiolib-deps-v1-1-eaf5d30fa647@kernel.org>
 <3c5efec9-cb29-4226-8701-2917ce3c2876@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cSMFegShQkDDXv1F"
Content-Disposition: inline
In-Reply-To: <3c5efec9-cb29-4226-8701-2917ce3c2876@linaro.org>
X-Cookie: MIT:


--cSMFegShQkDDXv1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 08:18:36AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2024 20:59, Mark Brown wrote:

> > The GPIO reset controller uses gpiolib but there is no Kconfig
> > dependency reflecting this fact, add one.

> Lack of dependency was intentional: because there is no dependency.
> GPIOLIB is optional. Because of that I added few stubs for missing
> GPIOLIB functions, but I missed this stub here.

> I propose to add gpio_device_find_by_fwnode() stub for !GPIOLIB case,
> instead of adding dependency.

In general the stubs do make sense however in this specific case given
that the driver is specifically to control a GPIO rather than using a
GPIO along with controlling some other thing a dependency does seem like
it makes sense.

--cSMFegShQkDDXv1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8ExcACgkQJNaLcl1U
h9CMbQf/cA0I8UivOk7mENvASGJQJcA4a6kvDHYr+/vv+zLbWBbXq6vEY/745KpQ
mhZDEgfjC5hJukSHwH8yK51BcQtvuWKlF7Hsh/I9Hr/gnwuWnde8kFlLSaQOqGG2
JQgK2JtKhVqYMRKB43CbeRch1ryjo74PmevyLf0xLcRzLaMfImStEipjHARokrDB
huoHWX4LctjvbWVBckSthUOw1w34sMo32glElPqDiiK58WKXa1+w5k2HOLo7/k5o
1ZBPfyNPja6aYhMXDtHwSfQIW2WP/alAc3yAB9neHvJ87xrW36P6k8V4jySgb67R
9qmepWhxrNLRIVrtddh5bAvBJFlZGQ==
=Qzxm
-----END PGP SIGNATURE-----

--cSMFegShQkDDXv1F--

