Return-Path: <linux-kernel+bounces-104591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDEF87D08C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758721F21B47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27440C04;
	Fri, 15 Mar 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmOcLE8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF01405F8;
	Fri, 15 Mar 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517453; cv=none; b=o9MUsnPZR4r8Vl6k/4/592di4UCB3Zp87h+o7Hvw1j1S3Ec4gJUXSOl0/eqdp6u8BiaGUd+J+IpG6nH+GkldwYHN5CnlZtAIoMg2HZj4ClySSKRFpu0HS8OGq//fKPKGmHMmt5d48DrhiJXJ7F/ZD9GsIqZpEfUgL0+3O87VtIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517453; c=relaxed/simple;
	bh=pSCHLCkTou2V/Ar4fp2rSjOt/S5Yq3PodT2wCnZIeBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqwM5WJdqIrTftqRBtAHmiviS0cRfrUI0i4AaXI658QBWPTrr/nbdMB7M+Pc8gv3pvKeJBVIsdJ4eG8PF5tn2dj8Sp8nUHQlFIfP+zsTgy29K3eZ+YQZuJ3RaEKUZuVdTnI29JoHR0phwJKouqbGj5woTpyKhv4JeZufjMpn5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmOcLE8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B30EC433F1;
	Fri, 15 Mar 2024 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517452;
	bh=pSCHLCkTou2V/Ar4fp2rSjOt/S5Yq3PodT2wCnZIeBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmOcLE8VnVn6P/PkXwekjKEA4imIacESDQjcxJLuOKJQdubDFr/LkRW9c495hki9f
	 417Lzkg1pbPwyPEJTQWyTpw8Geu/DUIZrHeSRC/zj009AWvyO54GzRwDid+4bf1LsA
	 Q/w1LXhnFw/bJH2MjAEy9Kwu0fNj3Nr9k0PotiKT5oSPBswci44odMkf7ogRry1D4Z
	 WT3TpWpZKy0jqUSgad7HA1aBpiTQpJRnFshWh6S3sMLRJKcaLoTd4nI0xWWBWHXL+d
	 Iob/7NTINc2oHegUXhxPlxcBBRTeqH47lIRmJYmaZy0SvI0TKrIZv//U925ki2w06B
	 Swm5ZfbV973Bg==
Date: Fri, 15 Mar 2024 15:44:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
Message-ID: <59f3c45d-f875-4ab8-bb2b-e1125d566938@sirena.org.uk>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B7opea/pCWfKDE4h"
Content-Disposition: inline
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
X-Cookie: Yow!  Am I in Milwaukee?


--B7opea/pCWfKDE4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:36:07PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--B7opea/pCWfKDE4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0bMcACgkQJNaLcl1U
h9Dhzwf/YYEcbM1vO9lkFBbIbVobPBfoOXwuRUxTtlKQxJ0KSSfwC+JOR2hPKqXj
1qMq1m3nCWYeeQlDloJSfRMVuEJ9cKBk35O59eLSXjRhtALkL25B27mutfFLzh9L
cWDgMo2mqyjHHwx7U6YpISXXaD0BLkXhqfoAWCWaN39+lUBxw1ChpBXXHVXXFgBF
PmZMpQMp8GlqxLMuphLP8WAHhwik1qm7CIVtqBq28meYkukruT8MrfTMVjIT3tWy
XAatYw1DGAV4IwWH5faNXcAjTx5WHx/np6Tn2IFSdeOcX3K0bEp2KAJ/fbseMcvE
DXBPi3LmvKNevrpXaXR5Ms0oFGzVCg==
=Yat5
-----END PGP SIGNATURE-----

--B7opea/pCWfKDE4h--

