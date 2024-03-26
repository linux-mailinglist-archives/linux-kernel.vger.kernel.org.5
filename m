Return-Path: <linux-kernel+bounces-119435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27D88C8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AE1C646BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D513C9C0;
	Tue, 26 Mar 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCBaOfCI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7913C815;
	Tue, 26 Mar 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469779; cv=none; b=Y7j3yBOngMuM2wVIwhRkWE8/hfLKc7MZz7Y2IPES2B33zAZrwQbTkk2jB83BiC2oZS3v9fXgHsiiSD82hPcV8lGLLMsdvH6rmEe5gKpFRe9cAnDdh48KF/KXpwxmmRr8NrllW2/koVrAcESuaP8m1AL/4OdiFudP7FdRBOos38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469779; c=relaxed/simple;
	bh=uu5YswgyRKr1NEtLECW11lvdLQTNhkw30cz7TaktJj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD0IZD3oek74CjJJK3ocn1RfDGGY8nddN0qsDbOh+44bIQLK4nuE5UmbQvyB2FyGz0HnRCiAkghpMGumQ+RTGc87NqYjVS/irDDXcy4+XaNiHwCNmPKf2pw5r0Z1ZVix4nmwI1BDfMJGDGn5pD6BIIQ4KQQey//MQIZ9G4A8Uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCBaOfCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8B5C43394;
	Tue, 26 Mar 2024 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711469778;
	bh=uu5YswgyRKr1NEtLECW11lvdLQTNhkw30cz7TaktJj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCBaOfCIK0jVs1NE7ZYPNhytAkUEeddgUUp0GlxxXF1FO/AfDin/1g9GGM+fo/NBO
	 xzhHlGcHbRaseNsQ2txKe2ZCLIYtrwr6/sfpZg++LX3cyInCThQJJ5flkzmbwnX3Vd
	 3488teR/DlXDNqKtt1/aKFAQBMA5cqa6iwHpEmAfqqquyGNJUunKtIMGfgP7tNmQz3
	 6X7iO/wqlCHwZJmCd9beSTMj/opWaUpgzWCji5ryGJk9RBgnyK8AiDwtKTxQbCnGSn
	 drmcau4MOreVlRJ3xq0EKBft9cRePDBfWf1UOE+jLbcvJyC40IGmiOBHjV0dfGUFeO
	 4Bes9IY3VJYVg==
Date: Tue, 26 Mar 2024 16:16:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <cb00ee0c-ed03-4351-9782-99eab1894234@sirena.org.uk>
References: <20240325120003.1767691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N65eYDdE+sWianZv"
Content-Disposition: inline
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
X-Cookie: 1 bulls, 3 cows.


--N65eYDdE+sWianZv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:00:03AM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.

This is broken on at least the original Raspberry Pi, no output appears
on the console.  Bisection tells me that the problem is introduced by
d7303ef54fae6 ("printk: Disable passing console lock owner completely
during panic()") though I'm not entirely sure I believe this.  I've got
some bisects running on other 32 bit arm platforms with the same
symptoms which I suspect will turn out to be the same issue, and v6.8 is
failing in what looks like the same way.

BTW I did ask to be CCed on the review mails, it'd make life a bit
easier.

--N65eYDdE+sWianZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYC9M0ACgkQJNaLcl1U
h9CDVwf+Is/eRLhqlgtF3tcmbj4g5ps5aeSqwytWmPKtsL2q9sn4WrT8j3ApkAfU
QJLsAl7D2xfE21zjfsiyqQ2ZMmOVZXK7d9BrAvctKB4reTvwLlT2myzNYLpF21lM
5e34Kl0vahfQRxQxyMHZBPUc0bWGTW080XIuYa8y11wSbAEFe/A7WJEOH+mbgj5k
3RH9xriaRvokhCm8SYcC+yPCJj6nr7xxDSfmYrLNA8+ZBOw6qwV6rYU3TpQx74eI
XbLLycflENPbWO5t4WIljnLowMS32DgpZndtL8g8MS5ipRsStBbI7fT4rIwVrFbt
CIjHFBDYmqdIKJqmG3nOBjmQxH5qQA==
=J3NM
-----END PGP SIGNATURE-----

--N65eYDdE+sWianZv--

