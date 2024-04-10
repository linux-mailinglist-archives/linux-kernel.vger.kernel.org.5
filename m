Return-Path: <linux-kernel+bounces-138718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F789F97F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240A21F23B66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5B16DEA8;
	Wed, 10 Apr 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+S/PEv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD7171097;
	Wed, 10 Apr 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757832; cv=none; b=afgJ/JK7hJKmSiL2vil7yOfaDcAhk9N+rT+5ViwBxEvRNC67oICxW3w4bECzeSPQ3lK7cSctvt82Cs6LlaUJ274UNod+tgnUnhIPcgqGWhxfupBCbLVOhip/IK9Y9QR/oVGzZ3Mj1ugt56hx2q6LIyyFLJIb+G48BDAPkYbVTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757832; c=relaxed/simple;
	bh=SpMSKQGEV5o3KdXrklT/YVxxCFrl0uM/Eec2XixhoDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQVzYeq4uDD9jhHTyjYzYl7SMgmHL6b0/1b89xGLEl8p9F97Dg9z9gy1S4ptdiRCBW5HSjcqmWUKHdDSmxwXVock454NH92BrPmxd/6oC1qwbQ/np+jDuQK6H70NtV+x5L+X6kOv4HptRtEqQKAYrFVC8YiNrLdsGb0FF9/8fDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+S/PEv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ADBC433C7;
	Wed, 10 Apr 2024 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757832;
	bh=SpMSKQGEV5o3KdXrklT/YVxxCFrl0uM/Eec2XixhoDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+S/PEv4g0dlBDJeU2beMAOon8oC2ZnK5+S0izjZYzcFr/UU7jlZkDuQvle9kXaeh
	 PuTfwfc/DHRvoXzGF/bUrupUyQrTEX0ySleHbG8sj3BCSgAeuFS8wYA0d7Ic+exSzs
	 EpSv/haiypOeWq5nAo1ewV8V0q3e/Pv8M1tsmL/xZCyK3zAlx2zTyRAaut5cMc9oWj
	 ykbWVFaM+ehmadU06ooYc+1nqtWy4CCosel93ITeiMgErbpSIZp5iRsGSwk/5iDBnT
	 s9zCPJtAovdeFV8419ODA7Nq3Dw7AOGYuEdLQa7UcuFEf+DwsPjeogGHt8Wa3wpxDn
	 p+vCMj7xwxEFw==
Date: Wed, 10 Apr 2024 15:03:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/255] 6.6.26-rc3 review
Message-ID: <99b996f3-ad7a-4637-a964-ce841229c322@sirena.org.uk>
References: <20240409173540.185904475@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CYifh2CmSs3afu7h"
Content-Disposition: inline
In-Reply-To: <20240409173540.185904475@linuxfoundation.org>
X-Cookie: A bachelor is an unaltared male.


--CYifh2CmSs3afu7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2024 at 07:44:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--CYifh2CmSs3afu7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYWnEAACgkQJNaLcl1U
h9BbBAf/YtVca/WJBQWvGcLY5wKpzD4Z3g/WsOc7eHLDrmQ3rQP09f2zKfmFHfQb
hW/HXwY6eT/ecxq0YeiNrUqOlFKdH0q6TVjS5c6SfeuuTjIsFTD2UYZB6rmSRLrj
z6H5lShVrUx5GrQKcfnoENRlp1VnlAhBN96ipiJGtIVqmlwiKw6GnoxbfWjTABMo
MAfv/hvRegKRWE8QFjg6jBhc/Igi5lWTnf57XPn9x8ot2Huwbn7xuKdxaNTCGFPI
DYPRITymwhu3gkRZHL3RcD2c47pIelI5DWpQipAdemLYaTKgC3wOVU82GV7jlYJv
7CL9HCBulDcCmHfsiIdbOhsUrjgo0g==
=d/dz
-----END PGP SIGNATURE-----

--CYifh2CmSs3afu7h--

