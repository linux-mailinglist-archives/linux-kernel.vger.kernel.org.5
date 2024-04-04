Return-Path: <linux-kernel+bounces-131371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25618986D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747B8B243D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1A85C70;
	Thu,  4 Apr 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB/qjHQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41484D37;
	Thu,  4 Apr 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232611; cv=none; b=J7pE2ApkXBtn9zZnNJYpJP/f2pUhPlWlOzCRScV8a5ys/By9Xn3OYzBOXX2rT1ia/OJGpDMn2EyKpL4FStgaV72RlW1ROa/qQOtydj4692lQVMbXtUBojaCA/84dA77SWnmN8VjGILGgSl05GZqUaYWVnTQ15tWjCc5sAAaYYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232611; c=relaxed/simple;
	bh=o15dZi6UCpDmIye31DR7EHenj10EP41qtu/qjRdTnHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMunef45ajcvHQNwdNiEWl6QmGMbH3O9nVnCKOcDeCfZctYxjCQnh/kfRcfDDgzudD+QArPVhr8yQPR0aeco6ugGLfEuUMMsFTbCq5U1PU1s3iNnqcOCTASG+XTGqcUzstr5ec3W7arP5EUh/v9DhhM/wWv0CwRwJP3ymstpQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB/qjHQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185F8C433C7;
	Thu,  4 Apr 2024 12:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712232611;
	bh=o15dZi6UCpDmIye31DR7EHenj10EP41qtu/qjRdTnHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SB/qjHQCsjn3qjTaAjh9jix45QHy4mEjDKmhG/M++hF1H+e1/6+4scHalPb8D7qkg
	 pL+u/1T88qs7oSi0fLlGAzM93rhDagFrwPUVzVzDD6H84IbLGADqp5ApofIxxWS3LK
	 mBjNb16s9/7RVzQM4FxLlUdraYTQRJPCizxyA7Hku72kmx5BLwp4TGvSRlw9DC9PVq
	 PY8uQPYIlZYkqiaJphjpMvRJ/ZMSIJNyHtOyekDnsI3OsfjcXlWJ+BrED/jdumRo1N
	 VerSAehkLRdqDQx1Q2Tew0u1IaJ6lWFo/XfRP0HUNv5lOC8889I0usyIng/ZXEjrfS
	 hI3Zc8Vd8ZRiw==
Date: Thu, 4 Apr 2024 13:10:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
Message-ID: <81eeb067-5bfd-48c9-9ed3-ff60fcdd2fc0@sirena.org.uk>
References: <20240403175125.754099419@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pNtLI10WrIpMEkHV"
Content-Disposition: inline
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
X-Cookie: Buckle up!


--pNtLI10WrIpMEkHV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 07:55:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--pNtLI10WrIpMEkHV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYOmJwACgkQJNaLcl1U
h9CS9wf+LPCt+CFvdeJURvMXUGVxidgAh/UWN9rI4fqNgeDGAS+VtkUCrm02QZBp
s5Nlk/lwLcTessAd3hG9r8DPpjC/Ljub8R680RdwCmXJS/ugqM6BX6ZrWfXbnyjl
P3c7rc52qUfCvcAqvnX1VYD+RftkiDL405vhGB8Z7PPLFLJeBfgc5CHtkGA3LbJU
mvCIcnlA7VllLKxsl5x9G/9QlbMgkD1EyxWT79091pi4ydjP9a1mbpue5bff9hWL
JDaIUsA5HYgzKspgWauSO9/TfM2XGyFtUMsqAs9AvZuKoIF2PaWzlZJcEaXiFqFM
D7x8MeeGozEuKfLP4+ND0apckv02Cg==
=O8WI
-----END PGP SIGNATURE-----

--pNtLI10WrIpMEkHV--

