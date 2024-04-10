Return-Path: <linux-kernel+bounces-138715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796AF89F977
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F8F1F26F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC615F41D;
	Wed, 10 Apr 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVWcVJUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0716F0D6;
	Wed, 10 Apr 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757764; cv=none; b=DE9pP6ME7xQq9r4qOR2gr7Kn35CreHrT8RXehwFTiiSDZwWHCRvKp9BqOJGdouWW3QropobyQV+lpJ/QOL921GnaCN/qjjrdDg47iJEu60viJmTzh2rEVw816zkHup0p3zv5A5FWyWKAoRIzlNdg7hkoFjp4AI2w0e967umz1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757764; c=relaxed/simple;
	bh=4zhqss8uTGqSHt36ubbv26Mh2WbiSU4l9Omqg6Gn0c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u56K9/6Xtmt1n0Xm0F/JTYzQZiJqWauZKwllBrO6EqOcQujoAjOUIFRsT13JtDskyGh2X/YZFHMV7q7uQfMTHzCvP2Qc3nyk/sthhha+z11ZBfiw5PP7q1EKghzPE/AGVOFdYuqOP/9ME3NlP97M81/Q5oLPfPS6uwios1M4Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVWcVJUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70176C433F1;
	Wed, 10 Apr 2024 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757764;
	bh=4zhqss8uTGqSHt36ubbv26Mh2WbiSU4l9Omqg6Gn0c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVWcVJUQ4z3KcwOYkUnG1j7Jt1CcKPVxlf/LijpC/EFD9aPRWb5TIc59OjJSafijD
	 y5kEk7Yaaa/JKrP/HV9LwTFL4/z/VwohEA99PfhgF3FTEmEmaLhnUQ5qBK9QlLdPjP
	 GCZkfNURSGiHYpjR2gLRPT/NC+Fc4CKCSqOjOHxroFKWLWSu3+RHY8JiHzirtW0DVL
	 2K1Jk13P/rBPO8PQsDhEk9SkBw+aEbIwMyZsWhqDh8iBgcpMQq7SBOg08YBF1RCuOs
	 ynLXBSVMtrwQG8uWh9IuBfjdlakKYBqbHJPYKLvBdaOnDZvFTzMUdNhJZ+1GXcv/td
	 jROJpXlrGC6ug==
Date: Wed, 10 Apr 2024 15:02:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc3 review
Message-ID: <d984acc3-1d71-48e1-9c19-6a12d04a961d@sirena.org.uk>
References: <20240409173524.517362803@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3j2YIWb/e4DVzpL"
Content-Disposition: inline
In-Reply-To: <20240409173524.517362803@linuxfoundation.org>
X-Cookie: A bachelor is an unaltared male.


--f3j2YIWb/e4DVzpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2024 at 07:44:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--f3j2YIWb/e4DVzpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYWm/wACgkQJNaLcl1U
h9AEigf+PgmA1giOX1CBp9WWISgNcB+Yesgua5iN7XNrA3fS7WnNjuN9h+kWyYtf
FqZCbTKsIIdJU5vdbqjekKqKLhyoR0CO07ms1+OEWuHpDgKVxDAETeeQeStKQ271
qivE48l48OavAty9F5jtGWCqKWIt5+4cn5hLO5/Bcr5zyrZ5zfkYSzxvyt+W8E52
F8jrDQrhP9CIJsiy2RGnj4VHPSJTK+IU4v55hS6KtX+j6UFEiiEBRHNUqK0kc39a
w6hQHEijf24PMnHF1fiqscLnd7gxgsirCpApw5A3Z0zJZ821A2pqDHQt6DaHuZXV
uBqRbOpCnfHxTI6oa5kCfAbaVfm3hA==
=K+GY
-----END PGP SIGNATURE-----

--f3j2YIWb/e4DVzpL--

