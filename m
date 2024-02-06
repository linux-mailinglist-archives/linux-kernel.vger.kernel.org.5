Return-Path: <linux-kernel+bounces-55274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1884BA12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58B71C2227F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6301339A9;
	Tue,  6 Feb 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN//mvjt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71671C01;
	Tue,  6 Feb 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234481; cv=none; b=EdDWLpd25PAODpDnwxR8ZZ6Bh9BOfn+V91BbehSt8jNgdh5nS/G/10Fnjv9mY7WwCDunbpw2UofO9ndbdR9Y/TOh4JNd9kUkHg7gA75CW7Wq3hMtcZOuEqTGxEtn8sy1QSJrS9kEr9Ds8AixKSboFcu6jO2qilVg9dzG0Qv8FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234481; c=relaxed/simple;
	bh=23DzthJXVC7vl2loyVn7P3Oe8LvV0igxtj6YGRqIgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0tZGWRW4yUY+vNZmQayFY8hAaQp8iUEV0zMr+4nl3IDv3W3viRpyFmSER2Btpv8J5smcUef+CLJzfWwygyzdEPUy/3+EIkHCjcB7ZdGNY/lKo6DiY8Fq7Y8MxMD1+rmwtmKf5aFW6vfS6M7YJd2K6dr7PP2UUrkOczBBGGjJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN//mvjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB66C433F1;
	Tue,  6 Feb 2024 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234480;
	bh=23DzthJXVC7vl2loyVn7P3Oe8LvV0igxtj6YGRqIgLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sN//mvjt3Sb3Mpx+5RopHhPSeUGP/jVXTdPXAPxdiimZ52OrZiHopaDdQ2+s7qMCl
	 mjrvFoEVyUMF1W92/h5v+3/kyv8bo9p7iD/UGgQMnSmcuPplOv2pS2CxSEk/G79SM3
	 YsRTtiJqgmAuQpppFRRqNL0nWeKgOqRi/HSE250se/ZcZzW8YTLEqPoMlFOiYSf/D6
	 L5SjDzqmfX3beSFpKEDoUz5ZlYSdd1yIdBbkQ+kpKQ7LvAEFoKBoi4HCFL+WsUBRmN
	 No6jZLSH1NwaHZh+zmu+3Oy704l5oWVAnrSffpOOk57h8BGk9fq1W5WvjqxtTlFC0N
	 26h5csDgvGarQ==
Date: Tue, 6 Feb 2024 15:47:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Shengyang Chen <shengyang.chen@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	tomi.valkeinen@ideasonboard.com, r-ravikumar@ti.com,
	aford173@gmail.com, agx@sigxcpu.org, rdunlap@infradead.org,
	u.kleine-koenig@pengutronix.de, sam@ravnborg.org,
	bbrezillon@kernel.org, changhuang.liang@starfivetech.com,
	keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: cdns: Add display
 bridge support for dsi on StarFive JH7110 SoC
Message-ID: <20240206-construct-slum-20f58637a228@spud>
References: <20240206065709.108684-1-shengyang.chen@starfivetech.com>
 <20240206065709.108684-2-shengyang.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UBTuCz2QbktCyFae"
Content-Disposition: inline
In-Reply-To: <20240206065709.108684-2-shengyang.chen@starfivetech.com>


--UBTuCz2QbktCyFae
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:57:08PM +0800, Shengyang Chen wrote:
> From: Keith Zhao <keith.zhao@starfivetech.com>
>=20
> Add compatible to support dsi bridge on StarFive JH7110 SoC
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--UBTuCz2QbktCyFae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJUqAAKCRB4tDGHoIJi
0iT2AP9aMGH7lGOnPX9HNLvvULNe0bBIH2+I3Z3pLGQsIma+8AEAr9ijpMJIqsE3
Ay6/1CGLrTojHBe+KCsOuZSMRhxUSgs=
=fZyT
-----END PGP SIGNATURE-----

--UBTuCz2QbktCyFae--

