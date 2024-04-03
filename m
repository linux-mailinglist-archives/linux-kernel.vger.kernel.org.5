Return-Path: <linux-kernel+bounces-130127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A2289746A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF99129037E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211D14AD0F;
	Wed,  3 Apr 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iokMOfxM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA7146A96;
	Wed,  3 Apr 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159367; cv=none; b=fBVZYjRnpzjMwAcAuwk5HEs4uerdXqr0VGtE9c7xkne9JiMozv2iYF/f08wqdkZAsoF0o9xdidi4WTiPwBVYw87OT9Jq7MqetyCReW7PZVtcLv1tMyy+4zMnpDVsRNwtvHPoPdRih69iZMVCIqflDTWEl8zXzxDNBENO7QOydHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159367; c=relaxed/simple;
	bh=UzhIYoxj/GeUq1Zwp8VWt8eQlrVFRAAjBbLXufD7S1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crFPkYf6Osf1uFXoi3kIdz4TET6L/pF73tFvYwzJpfhVkpviCWbRdRL/faTG6i8kp4gsyPFtDpWDXbniisODW0xiGJ0LDHkOFKx8A2e+CCr2QAaWwuxKDHbiuHYWv0r5czF//L6vP+ZVyD2xRgQq2KbPg9TSYRGU7xQLe6stxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iokMOfxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF8C433C7;
	Wed,  3 Apr 2024 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712159367;
	bh=UzhIYoxj/GeUq1Zwp8VWt8eQlrVFRAAjBbLXufD7S1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iokMOfxMA3K/TB6FKWFIK0O7s2zq9aTtls09nLxeUk6PRr6Z60BQud79hycqKEjQS
	 F2HF0BeyukIj5qydY11CNYd3p1AQY5H0UJf1+SPKTJYMa91oijQJlPi2iC9x7YoZSv
	 enYPM4R+oka/GAq9UxpBKwGke/aXce6Xr4CaZbrTt+YooAe/ataCz/2t2Sq7VaY4/W
	 wSf4CL8M23uZrbYBJHpaKS78mRBqbwWWHDrdXGSS1kIteJSz5cvTJm+kgSTcn2B6DW
	 G5Kl7+x/QvP2PTALxe6WIXRScUUhaHfwCHbiGSRKSojnp5dBZARsKUiKKCNphr8Jni
	 C5BjRi7WSaSMg==
Date: Wed, 3 Apr 2024 16:49:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Tan Chun Hau <chunhau.tan@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Message-ID: <20240403-curfew-baked-a0feef40cd92@spud>
References: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
 <20240403100549.78719-2-chunhau.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QPyn77z4oCLNx4w"
Content-Disposition: inline
In-Reply-To: <20240403100549.78719-2-chunhau.tan@starfivetech.com>


--5QPyn77z4oCLNx4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 03:05:49AM -0700, Tan Chun Hau wrote:
> Add StarFive JH8100 dwmac support.
> The JH8100 dwmac shares the same driver code as the JH7110 dwmac
> and has only one reset signal.
>=20
> Please refer to below:
>=20
>   JH8100: reset-names =3D "stmmaceth";
>   JH7110: reset-names =3D "stmmaceth", "ahb";
>   JH7100: reset-names =3D "ahb";
>=20
> Example usage of JH8100 in the device tree:
>=20
> gmac0: ethernet@16030000 {
>         compatible =3D "starfive,jh8100-dwmac",
>                      "starfive,jh7110-dwmac",
>                      "snps,dwmac-5.20";
>         ...
> };
>=20
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>

How come you didn't pick up Rob's r-b?
https://lore.kernel.org/all/20240328204202.GA308290-robh@kernel.org/

Thanks,
Conor.

--5QPyn77z4oCLNx4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg16fwAKCRB4tDGHoIJi
0rVTAPwPbHnemqIv++C11B6NjvmKObocsG2d4g/9l+VTGUcEcwD/dnqiJI0Edddc
A2TIMXnBN8NBZKR6OjdPOBQe3BmioQI=
=ysgy
-----END PGP SIGNATURE-----

--5QPyn77z4oCLNx4w--

