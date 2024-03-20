Return-Path: <linux-kernel+bounces-108966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C7388129F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D7E1C23144
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A094595C;
	Wed, 20 Mar 2024 13:44:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F1D4176F;
	Wed, 20 Mar 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942251; cv=none; b=opWS49Z3kFoC1wFh19VjMQVLfo/aJkHb81UhpgXF2drEyRcMHHAONTMj7xIHyuKaiUmevUm3C6vYX8hiz9KSqBc6FXNhCAhtNoai5j79gr1BNm2TgypZH8ap7W6hrCXrNjZJfFEHSD69PZyB90vx+1w8wrBRVAWmIgKJ4Lu05HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942251; c=relaxed/simple;
	bh=xkrLHfb+cwWUu5OQ4s38CCRC+eqDh3llbk/KQ+2e28k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyr7js5U7QvLsKpgMcbPP2Gc4sufJ/Hg+MJI+kxDaRR7dk+AoyfY5vp5VAPmFKT70KWkBq7lYVH6TaxJltWP3gkhl6W5bwZQ5crXxjopxPHJzdbiPjlsoBmHxel4cZM8gcPOMHgBxuz2Yq1IAVgDjmjcrDuoq6ysppJFbkC9KyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5E3951C0082; Wed, 20 Mar 2024 14:44:07 +0100 (CET)
Date: Wed, 20 Mar 2024 14:44:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>, josef@toxicpanda.com, dsterba@suse.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: btrfs fix missing in 5.10-stable was Re: [PATCH 5.10 00/73]
 5.10.213-rc1 review
Message-ID: <ZfroJoVIz3dBrO1t@duo.ucw.cz>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RacRqke8BQzKOhcW"
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>


--RacRqke8BQzKOhcW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

While debugging "search for known-bad commit" script, I noticed:

We have

41b3cc57d626d c2e39305299f0 btrfs: clear extent buffer uptodate when
we fail to write it

commit in 5.10, which is fixed by this, but we don't have that one:

651740a502411 btrfs: check WRITE_ERR when trying to read an extent
buffer

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RacRqke8BQzKOhcW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfroJgAKCRAw5/Bqldv6
8kj2AKC8iIDgRB8TvPqMlcC55VZTzMh4AQCfbocZ2JLnSPPx8ditWw34phNmv9k=
=enMu
-----END PGP SIGNATURE-----

--RacRqke8BQzKOhcW--

