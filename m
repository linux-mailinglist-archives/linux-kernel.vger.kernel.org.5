Return-Path: <linux-kernel+bounces-136921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B106089D9DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3907AB222F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2E12E1E3;
	Tue,  9 Apr 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltzu6DzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041912EBD4;
	Tue,  9 Apr 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668267; cv=none; b=Kx6sB6erOLWGG1d4ws5CNLXiYLdG1QnkBhmVxn765D9vR3/ifdj3ZJznyallYxHIX+ssWVCUgSSka0GUwjOD51+UVQo4461h5S8250qRj2H8SOYjl3YR7UZqo5NJ4V41XssIY76vaPgu2y/abKp2okZ2ZOI9WLh6iXeeRlZrneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668267; c=relaxed/simple;
	bh=Xe412WLq6VSlNpe0tAVJDmryM5F6qp2XSmWQjeaKIsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO3dmbSUMT9KV16Cb6tXA13yFYk/KQDXTxI3FzF7jpxXD2hKauJ91Tt8gce9xOIKS17P+IPEw4MLomV2qiLeOvaG9id+unoyxcSJfHQLFbkPBnMnuwczthEEejdiwcVwwG6xQ4sdow93suCIrXMrMCLkVab9FZUgJt84SU1gKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltzu6DzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E34DC433F1;
	Tue,  9 Apr 2024 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668267;
	bh=Xe412WLq6VSlNpe0tAVJDmryM5F6qp2XSmWQjeaKIsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltzu6DzWbBEWIDPImHphPjr3jQphZhgJZ1bkCxEcJtNjj2NmxQpI4TOXLiyQnzD5k
	 7cJvrper1tnBGJ65pI3+7RYkZjz0fA9USoFDjC/o9p3Hw1okUxU/7grhzR9O8/O0Qk
	 yw1dE3Rtidq6LJYOTcHVpZWJGGYQS58AxQg5oIbdwsPSXmmm0GDVX+NlVGy5TqeAUe
	 6egrNQBJ2Lafvoqwm48tDIo9LORxCEV6zyV8GAcriayNrDJbe7NAyrPlctq1sW3Doe
	 54pZCzUHOzU5EX/mD7j+DasB7+quXjtbtHERPxKRZYgu57G2C9tVXQqVGVUGsfEVIT
	 IFZ/fZMrzQp3g==
Date: Tue, 9 Apr 2024 14:11:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
Message-ID: <bd00e632-fcef-44b9-b13b-2db417c7bce9@sirena.org.uk>
References: <20240408125256.218368873@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7lrLzgHKE8psHx2h"
Content-Disposition: inline
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
X-Cookie: Everything you know is wrong!


--7lrLzgHKE8psHx2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 02:56:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--7lrLzgHKE8psHx2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVPmQACgkQJNaLcl1U
h9C0agf/S12JQN0DPDRzIILPQcGeyCoDujAyjG7ulDwQm3GzCeG5idQSyPrm3s0R
CRltvjpMCxjLrrRmPr/dtQ3f5YCmiHOoSH2ToUjQNtmdcFDcAbGPnMCfPfDmuX6R
821RSxomNKIyGIMsgqaCWoAVlLw4RUdAHv59ZxSD5ZZewKEw/ROkvb28zvSMq5lU
4haBi4u7Kwq1fRUS3jK91oDjO7z7caLHI5aCo8uVdyrbuukW8oM71+GuSmGtdPnF
5FuhvRaE4oaznDfLNYwapvOwzr4HlZf9kcxLj50gQxYX14uJh4OHNmMquWcn3VKw
auNOFrxPyvGrMh/S2yNI1Rq5sd6h6g==
=wLop
-----END PGP SIGNATURE-----

--7lrLzgHKE8psHx2h--

