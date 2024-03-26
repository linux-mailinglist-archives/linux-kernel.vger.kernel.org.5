Return-Path: <linux-kernel+bounces-119835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CD88CD86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608B832768A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC913D265;
	Tue, 26 Mar 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwj1dIaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF913D25C;
	Tue, 26 Mar 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482662; cv=none; b=bXeNmiCHyN9n0+7LzgQe1syRs6ExlFpYRvmP11g6iUiEwcEwxQ7lYguz7LMTpmjHHMhJJ6xNlU1pJK2DnROV3lOTvCHrugCVcbE7vAyWj1L4qgxvCpY9eRT0v6Dd78VrfYNLhz022DIRECEgPz+I6DxCL+2SwhesRCB9PoGO3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482662; c=relaxed/simple;
	bh=UZIVFMySdeLQUFd4CMQO70cwFyaw258elwTR63xED/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfhWfJT4tuc0aHKnIJv8cjQfsg+UEqr/vLXqhOxMySZHve0lCTMV7cjCK0X7ZHEVJOajLjJJ2xJDKOInNRZkcr+Q1g6xtwHze9gFFQOV+OErAWv/sGAIZt7q2NlF211k3YDOJ0dKAL8H9XP9PDihIK/nstKTjCE4I9PmNFj7SQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwj1dIaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD7BC433F1;
	Tue, 26 Mar 2024 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482662;
	bh=UZIVFMySdeLQUFd4CMQO70cwFyaw258elwTR63xED/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwj1dIaPM5CREH/Vqa9f+Apph7bhzyNYr4OKmJQ2Y0Zc8QjIYh7hGc1Gx6OdG6tpB
	 lItlyZLD1g+LCk16dEwUxzjGTTwg7h46rIcfyCVX0PmGQEgON9hkDosoASy2xUNIJx
	 hIaSzsk7pzisbozk2+GXQ9zL8ATrnMjuVMXE1945lQBeDiGCFr2oERU+qwBjR8STNy
	 icMKmXYcFRwgi76c7MWwplZGDzPSvmspvu1bi/UvK5tPq3Jm7LAlVU1w56lKf58wGD
	 ghfA22u9hnOAabjf/Q+g9en1Hwx4yd/p6aelTYLXfza7XSzptvt6dRgulfr5tIqRe5
	 cf+JU2Jv+8n5w==
Date: Tue, 26 Mar 2024 19:50:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
Message-ID: <20240326-croon-hyphen-d6eb62732a42@spud>
References: <20240325115939.1766258-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2Vrl30jqbgNZCn4"
Content-Disposition: inline
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>


--D2Vrl30jqbgNZCn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 07:59:39AM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--D2Vrl30jqbgNZCn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMnIQAKCRB4tDGHoIJi
0o7YAQDe+tCEii+Y/NjRDJFcQFzXortY3cOYYIxEaiv3+4ZlugEAnFs6oIbc3oWB
PFLdiJYqoWL/VFV20TruSPPQcR1rjAo=
=oZkY
-----END PGP SIGNATURE-----

--D2Vrl30jqbgNZCn4--

