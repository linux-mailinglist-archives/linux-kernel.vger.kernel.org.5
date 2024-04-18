Return-Path: <linux-kernel+bounces-150434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DB8A9F44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C10B21839
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4E16F84B;
	Thu, 18 Apr 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC8VKVm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3015FA9F;
	Thu, 18 Apr 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455825; cv=none; b=SigxKr5ZqfUYYKS0cDUyGCd7hUodFiiFTreBiWTZLOknqxmpZSxhDlexv0rWcx9bKxOZ+6RZMXxxWp8dLNpkhTkjv8fq6MVDvazEttG9SUT5pIc9AGNlAzXKVMhctNAPKeacG0Ag/fj7UQjpFE4h7mc1ApRZmdC4I1tUp9sXl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455825; c=relaxed/simple;
	bh=NuLhSfmYURyeA4KyKnBJ8GgZw3mwTQhoH5JrHj17W2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjaSI5HlAi1YmUYhBYJmcAyTUYrlRr0xu7+qwphS0ZZer7r5BXsOCUYe67h6KS+R/QvtSERck9GHLozAs2ceLKQF02FEw8vdL/nrvuEc1Km6TxwmD+WBJtpRfPG63t4915uC6SKJD706M31aZEnFsEHvqq0R2ZdffQK99lWN8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC8VKVm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE17C113CC;
	Thu, 18 Apr 2024 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713455824;
	bh=NuLhSfmYURyeA4KyKnBJ8GgZw3mwTQhoH5JrHj17W2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC8VKVm5hRy2IWpiv+a8i3bjGGmhEFdfpcgke+gWkBdnKp/GfF5li0yOqubX0m3bt
	 dPTnBjB0ibYwUMXtA2qBD04QQf5EYFdGid5NPHouU9RvlXo+XwuXwUw8wOytI5JqR6
	 5pNPmDYJhJYEswFyq/7AUHJIjxUqIvis0irOFtW1D9pBQJYQ5OblC72B43UYRj0bxK
	 Deli09g5qDv4VpnClB9wlI3cSXOhCANJ1AjMl1xnZnomcAIOEm2vAHSCNM5+6OX+cM
	 r8mxMVYUwJvZpel05v/cxU1PtG1fTuh0LCjX1s2Oq2/ESfT0i3W9u6nX3eyJ5od/Fi
	 yB4TX5eQPHC0A==
Date: Thu, 18 Apr 2024 16:57:00 +0100
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
Message-ID: <20240418-skinless-aptitude-245665a7c757@spud>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
 <d00953aab0f1c978e3720885a6844caa@manjaro.org>
 <20240418-drove-boasting-d189ee3e22e0@spud>
 <7fec3e2f4e16b1aca6cd08e1882bd885@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e6Eqyn2mnOtnO6RB"
Content-Disposition: inline
In-Reply-To: <7fec3e2f4e16b1aca6cd08e1882bd885@manjaro.org>


--e6Eqyn2mnOtnO6RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 05:46:30PM +0200, Dragan Simic wrote:
> Hello Conor,
>=20
> On 2024-04-18 17:37, Conor Dooley wrote:
> > On Thu, Apr 18, 2024 at 05:21:18PM +0200, Dragan Simic wrote:
> > > On 2024-04-18 15:01, Chukun Pan wrote:
> > > > According to https://radxa.com/products/rock3/3a,
> > > > the name of this board should be "Radxa ROCK 3A".
> > > > Also update compatible to match the model name.
> > > >
> > > > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> > > > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > >=20
> > > Looking good to me.  I'll send the remaining naming cleanup patches
> > > a bit later.
> >=20
> > What remaining patches?
>=20
> The same naming cleanups need to be performed for the Radxa
> ROCK 5 boards. [1]  I had some more cleanups for the ROCK 4
> boards in mind, but I'll drop them after your NAK. [2]
>=20
> Though, I'm not really sure why the NAK?  Those names aren't
> used anywhere, neither in the Linux kernel, nor in U-Boot.

There may well be other users outside of those two projects that are
actually looking at it - I don't think that adding a hyphen is worth
disrupting anyone for, it seems perfectly clear without it what board
this is.

--e6Eqyn2mnOtnO6RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFCzAAKCRB4tDGHoIJi
0qZRAQDvp1WMjeZQ5UkpdXHldOb66YBev1YO2u1XU0t6ffUyzgEAkK6CFkop9QIu
mtkvqS5obGem7DzXQW/A9taovKtQTQw=
=VAgQ
-----END PGP SIGNATURE-----

--e6Eqyn2mnOtnO6RB--

