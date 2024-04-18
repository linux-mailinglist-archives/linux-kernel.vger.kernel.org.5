Return-Path: <linux-kernel+bounces-150402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9928A9E93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066222832FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB516F83F;
	Thu, 18 Apr 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC0bbyN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6616F29A;
	Thu, 18 Apr 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454631; cv=none; b=ailhiki2ocCgHARWrzVuZ9FFEch4fER54JDLF0yAj78XeMrvVI+aC4b5WgtnapszD0EJgikKBcUSsghXLVsXs2QEFDS+Idi+Lf2dmGJNwyPWMXqWSCOlvDlj3tz2l5Va2uWPFHesFg57+3e/VKxBVQwdKZ1D8XpV6vWQoilOw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454631; c=relaxed/simple;
	bh=4OpUb2FGqt1dYv8qJb6rtIUYmk6NT4v+mrxt2BlJs78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr+x3JPWjUqQjoylYpGWKbTJy3cUcNlDQaxlufHgE2hWVFtRRIDEK35sAChyrVL98YyIHJGqjPppppCm+0nsAcuRWl1RnlzmrGDoz+nZ1axzH/3JwiWHm7h36arrPQcEly5vuMuEcz0qCfq04DWi72tSiwiZQeMMoch6sC3PVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC0bbyN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5121BC113CC;
	Thu, 18 Apr 2024 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454630;
	bh=4OpUb2FGqt1dYv8qJb6rtIUYmk6NT4v+mrxt2BlJs78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AC0bbyN8qV2IAikf/ipz2Ymd6XBcB8nhdeM6bs18urmr+z6s3Nb3gVwxKNeZKieVp
	 9q6OLQdESUN0YQ4SKdMAa9T/COjE1ccZPsd3nbF/cz5eH9XxBrFFYTXVErNKuBLOef
	 XBsNcOAfQZKDLfNzsFvUi/Z9F7tNQFD2dSK89+zEYFzThtjUCeFo2zFPeIReUSTbHu
	 AguAM3e62UFn3HX4OEf/y2xLYz50GqzNK14c1VyTBzauPXVsS3RDLJyt4dPFyF57KA
	 Zm1TwVzx6iMC1qPzI/OZRt/zFw06Z59zJ4l8AUsnaO02Fe5yTctChRo5hlLUEiyozk
	 7j/oY6mzOTodQ==
Date: Thu, 18 Apr 2024 16:37:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: correct the model name
 for Radxa ROCK 3A
Message-ID: <20240418-drove-boasting-d189ee3e22e0@spud>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
 <d00953aab0f1c978e3720885a6844caa@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aWQtx0wMEbSR6BGU"
Content-Disposition: inline
In-Reply-To: <d00953aab0f1c978e3720885a6844caa@manjaro.org>


--aWQtx0wMEbSR6BGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 05:21:18PM +0200, Dragan Simic wrote:
> On 2024-04-18 15:01, Chukun Pan wrote:
> > According to https://radxa.com/products/rock3/3a,
> > the name of this board should be "Radxa ROCK 3A".
> > Also update compatible to match the model name.
> >=20
> > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>=20
> Looking good to me.  I'll send the remaining naming cleanup patches
> a bit later.

What remaining patches?


--aWQtx0wMEbSR6BGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiE+IgAKCRB4tDGHoIJi
0hSWAP9n75/NyOZRQmE4r2XfXbMCGpbQiFM8gRerTvqrwaYz3QEA6x0msj4+h3m/
29tKpAiONgsDMh+3LtGHhE1FmBnTBwg=
=+i2f
-----END PGP SIGNATURE-----

--aWQtx0wMEbSR6BGU--

