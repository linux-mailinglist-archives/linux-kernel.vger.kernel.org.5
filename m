Return-Path: <linux-kernel+bounces-119836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE388CD89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A3C1F656D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F013D264;
	Tue, 26 Mar 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKhd/i7w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFC13D257;
	Tue, 26 Mar 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482702; cv=none; b=lP7Qh4FKMZ9+a/YWuXahlt+zufJzhlYbdrlKw39t91t8/s+WOuA5kYBWo+bDrAmVe9kUfw+GGbByxbUorog0UwiTUmS+wSXZJwM0nj4ag2eEQIfxmmrlPFUtUDSz4wIA9Sk2wLhEj2XK1VuycaH41vmS0A2TSieFrThownkiko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482702; c=relaxed/simple;
	bh=ycn7m5+Y1yqT01wW1VBhckmXFIg2FrPiycGxeCyYLwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW1arREOQYQyc0He3sIekctjJWt3TsdZjRQs4aULulxHnoHvB9rr68JHTqDRRqraY8bYwWxtV+tJDobKZaB3PBznlo5WXiV7aK15U9xr46UT8E5KF96d4imKBcJpwAfTBVghfegMh65zsZQzj9rNWVcva4mw0yptRVBjaK6mVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKhd/i7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C90C433F1;
	Tue, 26 Mar 2024 19:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482701;
	bh=ycn7m5+Y1yqT01wW1VBhckmXFIg2FrPiycGxeCyYLwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKhd/i7w+8O5jpsyi05lySsnIG1OdJZkk4WTlVGUf8iDkQD6O5ygMdWW/8NBm9zgD
	 juZwdzTieRSjFjdeAELk55dV4sae6hAFO1GJ+3AQPF3BWhy6G3EukMybwiIHYNl+67
	 SvdrFt1jYkM96YhDN4v7pyZaFCtyE6nBzygMadhareDR9ooady4wvRoYmcMxIVf6pv
	 sfNgr/vj5WgtB4VLZzdXLrXXvXdr/n/8/41Qrp0abAKjKMFOSTqwCmw93ISFnzDpIU
	 4E9RnC8GbjmMmDxDbMq6bv4tSz1e2inyqiraieEAULkFofMGq1M2zmXZOvSqaT3FtW
	 mYAhRDVgzdhTQ==
Date: Tue, 26 Mar 2024 19:51:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
Message-ID: <20240326-footman-earful-a8b76b84956d@spud>
References: <20240325115951.1766937-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jcu+ph7jwzAjgWic"
Content-Disposition: inline
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>


--Jcu+ph7jwzAjgWic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 07:59:51AM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Jcu+ph7jwzAjgWic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMnSQAKCRB4tDGHoIJi
0n6JAQC+qZc3iXmWE++YW15+Ckq1nG6Rhr49sRH7IRf6jeFadwD/arsgFAoi8MsK
V+9QcRjV6RVuVZZNjtCwP2IuPjbbNAQ=
=lEqu
-----END PGP SIGNATURE-----

--Jcu+ph7jwzAjgWic--

