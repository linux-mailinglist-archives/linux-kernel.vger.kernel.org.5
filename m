Return-Path: <linux-kernel+bounces-59665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F384484FA13
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3831C27DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA41A80BF5;
	Fri,  9 Feb 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUICP55E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052F7BAFE;
	Fri,  9 Feb 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497331; cv=none; b=nZ7qG745SD358c9I/Koal7OA9Ne8aI/jbJWwUR7o28lhXthsB/+sbNah6u1n5aAxUXDrQ58r8J/boLVg75ofREPoInnSkLu8R/UfygbQjI3Zc0SOSFMi5JDefK56ahyNMNaCBXvdx0oXYliRy67cr/P4sisFpgYltOWHbYa2P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497331; c=relaxed/simple;
	bh=q6KRifW45XyYG++EuP39gFvYw+jyB0o8roAAZ2MR+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWpUtg0lRY9GIGeWj5GwhY1YbKlaoO57irUiAlK82B+TXu92yEWbg7uV3RXyV8S6imD3/+dYS4cvFpc1jHXS38/MyoXSJK+4wLX7ICwtXT1lNyZk4wzLJRqhthfk/4uqChTDMDGnb9p3kTskI8yTadwb2xCDwdyZ44mbaiLrrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUICP55E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A94C43390;
	Fri,  9 Feb 2024 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707497330;
	bh=q6KRifW45XyYG++EuP39gFvYw+jyB0o8roAAZ2MR+0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUICP55E2oM2gEJA9ESzjFyXcxBCRgpf96uEm1r2FqjhneWHIzdKMs/NUGJAiK298
	 BdNCCm3RLvngicb7IIEUXYUUQ6+kchVg9PCvcmUq4WKAUCYvry5tlJldh+U0QXJaOl
	 PBrQ8LYFwgoM++XK/AxqFBK/nEkc7WO2OmEi7lL+Oj3NAdR478QYC+uS2SeMcFrFr6
	 WgPqftIX/TpUPjDdotmQCB4h80qGvYxxJ8Qi2jixyHFZd3zHRl/HLkh5bRSRexCbAt
	 18Iibje8tGF3NgThtcTMDz2qC3tC1U8a0We1QogEihc0TBYYAbakI+RO0tpGytMf2E
	 fqn+C3bWkJqIA==
Date: Fri, 9 Feb 2024 16:48:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: tglx@linutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Message-ID: <20240209-trifocals-rejoice-27a17500584f@spud>
References: <20240209100122.61335-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aP82gP6uNUjMexDP"
Content-Disposition: inline
In-Reply-To: <20240209100122.61335-1-dharma.b@microchip.com>


--aP82gP6uNUjMexDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 03:31:22PM +0530, Dharma Balasubiramani wrote:

> +examples:
> +  - |
> +    interrupt-controller@fffff000 {
> +      compatible = "atmel,at91rm9200-aic";
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +      reg = <0xfffff000 0x200>;

One nit if there's some other reason for a respin, reg before
interrupt-controller.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--aP82gP6uNUjMexDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZXbQAKCRB4tDGHoIJi
0u8+AQDr+6EzFCsRmBuBINVUA1xkA/IVqfQZrlEDxkBfyL6dEwD+M7ZA1UnyHP4i
BeANlMiPapAOZ24HaZNVoY+d5gKz+Ag=
=eO/i
-----END PGP SIGNATURE-----

--aP82gP6uNUjMexDP--

