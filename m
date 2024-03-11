Return-Path: <linux-kernel+bounces-99542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E6B8789C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3981F2157F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36ED56B63;
	Mon, 11 Mar 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Vc41yShE"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2B56B62;
	Mon, 11 Mar 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191021; cv=none; b=M/XvkOw/nBfVtW6WzPsgQXtCNAJji8SDITEJC/TFh8Oz10NInBNrWh6tpp8GFoWNXfQwSZiOWBP20b1yT94IYr+dkKjF2nl8gOXek3l1RVkWUmCfsz9IMy0pIeYcM+LV5x8CFpW2kQrA7by47UIHAvo/4ixKQVHxJOfIaesCjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191021; c=relaxed/simple;
	bh=/4ihzR4g13F2RIb3BUs/H920FdYvtQsN3YLshunvtv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLXTqcyIsskeVLPexpVlbXs1r1PuQW2ZSLrHHrhX4aURTHxbNtRRfTRtEuU2t51iRaW+yX8C2LsA3Uqkd6yaPcN4pEtgYhjs2KmrrgNe1Nv2PxCr+TCEkPkboAtydFFjNJA3lXFuO9jpqiYVEpkad0mnlXdFKrvTSw6R/lq/OjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Vc41yShE; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 678FE1C006B; Mon, 11 Mar 2024 22:03:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710191016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q7gUO0Ji+KOmOMQiuxcSbAFRusTzJmqn0pkFoB5G88=;
	b=Vc41yShE4UOwT1lb5e7A7lfik6sTaaRdp766TRw0HORIB8iFYQJo+jL1W/k3nL6QxNyuJC
	ejHGEAG2P+1aDx15XXo2Ih3NoOjVzlSpZWDEtCUBt4YOsgqqvbXovLtRW5SI8i/Mj0h5pA
	D4Ecui2h+U+u2A/Au3K6dSZtxHGqbow=
Date: Mon, 11 Mar 2024 22:03:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"David S . Miller" <davem@davemloft.net>, benve@cisco.com,
	satishkh@cisco.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 10/12] enic: Avoid false positive under
 FORTIFY_SOURCE
Message-ID: <Ze9xpwnt/54DkIOM@duo.ucw.cz>
References: <20240229204039.2861519-1-sashal@kernel.org>
 <20240229204039.2861519-10-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iEGdikiwxHoeJDiH"
Content-Disposition: inline
In-Reply-To: <20240229204039.2861519-10-sashal@kernel.org>


--iEGdikiwxHoeJDiH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Kees Cook <keescook@chromium.org>
>=20
> [ Upstream commit 40b9385dd8e6a0515e1c9cd06a277483556b7286 ]
>=20
> FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
> code base has been converted to flexible arrays. In order to enforce
> the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
> destinations need to be handled. Unfortunately, struct vic_provinfo
> resists full conversion, as it contains a flexible array of flexible
> arrays, which is only possible with the 0-sized fake flexible array.
>=20
> Use unsafe_memcpy() to avoid future false positives under
> CONFIG_FORTIFY_SOURCE.

This prepares for future chagnes, but I don't believe we'll port them
to stable.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--iEGdikiwxHoeJDiH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZe9xpwAKCRAw5/Bqldv6
8hH5AKC8h6YmAzzNGI2GZT/2xED40X6G2gCfTMEdohcsxXWJbkPr8sNwseyDp6U=
=gOKP
-----END PGP SIGNATURE-----

--iEGdikiwxHoeJDiH--

