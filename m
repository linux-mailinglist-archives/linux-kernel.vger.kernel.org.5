Return-Path: <linux-kernel+bounces-108513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD0880B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA41F22E14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F51DFEA;
	Wed, 20 Mar 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWOdT1sb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A012E4A;
	Wed, 20 Mar 2024 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917912; cv=none; b=BfgBGusNGdVWUX3QLSeoYzwhbUYmdd3czrYyi4G7HF6HZbznPi4PZ2URHHGPTVgpIeeGitn9tis8sQlLKImO03yDiZ+jz5InMNQrKMZYI8gJOQP7q9aOWH9JAXSroUZoObMp5gPyuX/vFfwCSKRZChhgGgPpyCsye3Ouqll9NoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917912; c=relaxed/simple;
	bh=swyryMXwqjnQtlGWnYfmLyIARlIGuUYIEbtz4ovC9bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JETCVSHs4f2qDJAeLVidArJqbcUDIi2pOJfjMtKXHhS7TpcPvpNk2V4PnNlI/XknTSD3hygwfU3FJ0KvUfwVr8Cngt+YJ547cxV7GQHUpZJvyXBP5sH/ES3uo3ZPdXd8AH5PDCJXc5P2dumFlo1rh2ShM3xMAlJLg84JCgtFhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWOdT1sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A9FC433C7;
	Wed, 20 Mar 2024 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710917911;
	bh=swyryMXwqjnQtlGWnYfmLyIARlIGuUYIEbtz4ovC9bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWOdT1sbBauYPxJ1R2FJqgSROCch4VlnHYoJJPf5ZCg3HrmqHOy16w8JNE6nBtVkk
	 7FVAnm1daedj1RmleerRXhJPAVQujgAuutqLjWeKDM+SaRkTzx/+b3xH43AkJ6CxOw
	 EdCzGL+X/NqDrEKuOAUdwDalvw3PGhg2hAnmVBGxleFb7ApCGcFveUCysISw6Zy9o/
	 srZzEj2y2xCxM3B2jrFZcvgHtKcEkkJ58EYbeQt5L2KcPRjYXg7muZRKIBgikt2U3j
	 I/DasmuwYa9v5FzOnmn7AO6m5SkoV+lIIg6JFJERIKhUH2vU6sPLAao+bSjaGFzvR9
	 za1Iaidu4t+4g==
Date: Wed, 20 Mar 2024 07:58:28 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: renesas,tmu: Add R-Mobile APE6
 support
Message-ID: <ZfqJFHv6p3KJRWqV@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <cover.1710862701.git.geert+renesas@glider.be>
 <18b3778031f939a8e40a9865f9be0a9ec2e28a1e.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KQ0UHsnHoWqVaDEa"
Content-Disposition: inline
In-Reply-To: <18b3778031f939a8e40a9865f9be0a9ec2e28a1e.1710862701.git.geert+renesas@glider.be>


--KQ0UHsnHoWqVaDEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:46:03PM +0100, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) on the R-Mobile APE6 (R8A73A4)
> Soc.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--KQ0UHsnHoWqVaDEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmX6iRAACgkQFA3kzBSg
KbbY7Q//aVHXNSjdwkmVvLfurOxqJNjs0NMgt8kUgSfEGKyqkveOdSRMpPebUfqF
HYM7m49xz+aPb70eMmzxzug7ZEwTRlm2uTa/nBnqZAmFH8833OrmQd+Ke14mWdP0
X5ii1qZV0iejmSFaE00FrnYZgQhDD+j5DSZRKe1ru+rT1QQ3nCA8tjDKnPjHI/0Z
9ft2iZMmoY9DSnXTbL2g3+3Z3FMCKUupYXNv6ne8yEBDu47fUuEpaN89lY/9b0K/
ToAKztkz0fsELsW3zCfQXiSefciYGnBC6uOjKid5rMSDL0ieBrBTnB3W3N6EU5W0
coAbJYfRI+KVM582rorwwTlbr53GNN5S/pegLo2oyu4C69GKDSDuNwGmeEVTxKLo
HfIvEwabqe0Geq5dsEhFo7tmS08+UXXrJasGdp+iEuYEr9NX0IyO/SzTmMudPpVp
dpzdkE5wpP96OdUVdcqkc77VvOGRbKcSD3lnPItKOvi1Lg8mx14DwehFo3kZ0PVu
2oHUMh2ZcRoXwwQe9XqcdJFJqx4wsS17csLUw6YLSK+zoDXT6IJAtWKbzN9tCZB7
r29oSIZ4G268CDP+iUQ+A3ImyFOWG+Lv2YFdiJ7yg2WYxpJ2191R2MeKJg1/8y8a
FmJLr1nmJ5a7NWne5gQuJqiqnhJNh5VZFG0fIehJyr/14RbHvds=
=TSzN
-----END PGP SIGNATURE-----

--KQ0UHsnHoWqVaDEa--

