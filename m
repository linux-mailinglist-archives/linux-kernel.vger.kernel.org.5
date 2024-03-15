Return-Path: <linux-kernel+bounces-104588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6C87D080
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CBB284A72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782B40859;
	Fri, 15 Mar 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZLA39rm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA73FE47;
	Fri, 15 Mar 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517355; cv=none; b=nXK7wHBg0LFzfRyLOH8sEVLm8Zjn17tKL9RKnqEgkN1j4gumS3byRd+47O7T0lTtvKz6EtUbufpzTWm8Kn8ZvHZ+UPkx1UJZSA2VJCypxa79SkDZKueZbRTvCW8UgQhbHkR2as5MrSoiH6yOgAbjE0ZpXp8l6Ou5u6vLyOrXfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517355; c=relaxed/simple;
	bh=0N1BsCYtvWEqRVe1X5dNThaXqxh8Rg1WOw3CVPti4YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plOzmvz51sXOcLu2tTOD6WLN6F/gcK7q4y70moWXttef+WvbysPE5kOthbMrzK/KqWH4gsUi06WQxFGpAPSSTDoKR+Di+weqgToFHLq7eZkPYbBRJ+o5u8vLDeF/yve0Mx6G21RMoR4h/SU+ySpVEG9Q/0nw97NDgXMrnAMX5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZLA39rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE1CC433C7;
	Fri, 15 Mar 2024 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517354;
	bh=0N1BsCYtvWEqRVe1X5dNThaXqxh8Rg1WOw3CVPti4YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZLA39rmdpqksNLeLxk1h9LiX1nd9yk1wcsdXxauMLzm6ArILaJrTmV+Bq6zea7NR
	 3Xs2WTGetncR0cKFVXMvZEfHFA9lngGZy9pPmqgrPvdSOPnmG053CoRhKXZyTcjeDX
	 dg6jy55i7Pyfe/RSnZgaZzHpUG9HH1TCGKm4hWJlp6jQJXbuQYCOyF0qysNNZiKyML
	 NWjo/7bdc5/l+juxxp3iEIZbRpYINYj6aAlinjCFImU5xFc/6Hq6twl7iCKLEXNBYo
	 vOqY+8OnzZYY2yIzVq2z28r0mfCDLvktLEd1E8haTcfyHOy8U9+LIksYiugaUv3Cdu
	 WR6CDfa0vzsxA==
Date: Fri, 15 Mar 2024 15:42:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
Message-ID: <9ea47bd0-cf00-4bba-a305-6fea6278ac55@sirena.org.uk>
References: <20240313163019.613705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V6lwsxOq/FDcH2+U"
Content-Disposition: inline
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
X-Cookie: VMS must die!


--V6lwsxOq/FDcH2+U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:30:14PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.8.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--V6lwsxOq/FDcH2+U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0bGUACgkQJNaLcl1U
h9CcAQf9GPuJDU2HzhciC+YJFxOm6T1oG1WSQLNYgk7R+WQi6ChAn7Wi1PDsXjYa
PnC1F8kpW+FsoZBW2LMvRACqE858ZbcTcy8EQ7L0FGOrtQAer3eDFRM909bUp1n4
R7eAHgIxd997N0qrBV70pCT+XUxTZt11Dn2xme8WSBcBcpRYv8Hf3CrmOu0VTNmm
HRbgfOzGrSvSi5XEvkGJtZM5hn/0+yzCO7kJ4wg9R0ND8QPry/C9pril0EQaBn7W
SVJgFPtFkIDzPCP+3LTtpqvrhqEwdBMIxFl1RN2khcowFPg7rGdwnQHSWQHbUSDE
wZjb/kwqKGJEQK1eQB3OutV6XhV79Q==
=LvFm
-----END PGP SIGNATURE-----

--V6lwsxOq/FDcH2+U--

