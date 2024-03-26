Return-Path: <linux-kernel+bounces-119839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981F88CD92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF931C3C003
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2113D271;
	Tue, 26 Mar 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtCuFOd6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4A13D25D;
	Tue, 26 Mar 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482757; cv=none; b=NCaCBcKoTwJ8TLNRDDk4qPNLs6hR9/08Pze4CgdFbD+Vmly3r2MpdqeM7qD0nx8DEQO2ti+Q0NE1csMZZTLzQaXah2uEyxAyi/TtXTNeEWHkKJ/XlLspr4/XujBl/Y84fzeY04J8MTNmKFon2hNJaZi0Jtf4Bmrqh7ij9Kfb2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482757; c=relaxed/simple;
	bh=owPtedrODsXKBhEM+dXMFJCHmunp9nfmyHwJv+GIISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVAWWaj8GJh3TqvT0SKW104HG3v/lHapopnk7vH2/a+tWmmmrIUelSQUrhrBSoLLIHsvqCi5DeLcqe37nhX3BBxfzLa/ew3Rhx7Y8sFu+oKWKm9u6sfuj7OkMsy7+Gmui2p3wfJtrbIBt8apXYJRkzYfOjuIdfWhA+ieOERqluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtCuFOd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3F6C433F1;
	Tue, 26 Mar 2024 19:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482757;
	bh=owPtedrODsXKBhEM+dXMFJCHmunp9nfmyHwJv+GIISs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtCuFOd6n5e7yQ8sIcyyMZyRIQaDnCpeme1o0ivdZx8EGBw3bfaIWQpbNNn/xiaiL
	 1Z7tm4uTQpXPFFgTwwt0v3dBKKBlb65i1oFWB8TlYO/ugjK9VesWvNW6kOWxQoYpcT
	 s+v6z2puYG4X2OjNkLPpRjPaqBHhMQ+8teH47i65q3uZzs+oMQfqPSo8/eJCRcb5Vk
	 GpF2t0C8nGoAYXr9Kt/L7Vuib5AdAyCYscJ5VhKo/IrS4kKBxK0bBEJzuxv/N2+C+/
	 IHMLbLej4NzlRxOsJV/cIN60eFvKneJ/yCl6nbDNicLYi4Zl3ZnO7h0oXETb3hkFKU
	 3zPvL4Re5whWA==
Date: Tue, 26 Mar 2024 19:52:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <20240326-skydiver-maybe-2e7a2335aef3@spud>
References: <20240325120003.1767691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1zU+/+TjOMHxamQF"
Content-Disposition: inline
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>


--1zU+/+TjOMHxamQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:00:03AM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--1zU+/+TjOMHxamQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMngAAKCRB4tDGHoIJi
0jgDAPwKdWlrdTGVB/iRhfqr3KTaABLdr/D3z2xlNBGAlBr6QgEAiCUXDzp3N/Cf
2lS9HP3v2+jrHN0AlqtW1D2Iy52pAgs=
=tpji
-----END PGP SIGNATURE-----

--1zU+/+TjOMHxamQF--

