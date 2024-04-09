Return-Path: <linux-kernel+bounces-136863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3D89D927
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE591F22BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8512D20C;
	Tue,  9 Apr 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U41Zr9xa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF10129E81;
	Tue,  9 Apr 2024 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665314; cv=none; b=iCVM7x3mBj/B/YYkY7x6qNjqMqld3GSGBAWirLVpdfspU1XpcZDNkUN5/45Mme8TKCPaiqRnSDkPpwEwQOffGyp88oP/8RSgpsSF9i7gyN8vD4bQaTyBIezqDFx9kb0Dqrt0+LPSkzfnIm3OdRcSXntnmqMeLeeHvkF3lnBKq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665314; c=relaxed/simple;
	bh=09iqk1eid762w6SImvv9WIm/kS3GJGBK/Tkc31Kv1LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQkkf05Q7fwGisO8i5a8TuK8VpJ8oEvmcdTDhqdjcV4SWExuRfeMR0cK3LTc6PTDUhJdeLh7GGAZj7cSlNCObn3Md8RaFjv/04KfgdKl4pzepr+YLYp0cbBu7q/Kb7/Htt3IzT2BQkhrcvyVVmiPX9s5gMurbFrNPVHbuDpu5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U41Zr9xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FDBC433C7;
	Tue,  9 Apr 2024 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665313;
	bh=09iqk1eid762w6SImvv9WIm/kS3GJGBK/Tkc31Kv1LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U41Zr9xagq6OVBE93Vv1dl4RetfSKpJK30cDRfu1Rl0SjOLMl0Lo5EeXTh/QfJ2vi
	 Q3IOLDfN53T64BCQz+QoJNnHg3kIjoC1F282B3wQovBRKDm551ixFr4qPJVIWR1SSS
	 MrpAe4MgOlZoDGh8yEdYrXJ62GonhSEsU+vCzNEudM7s4kbb3co6S/wk81oRMay8a6
	 E+SdppW+J/zQfkDCS0xZtOBuOasPsFBHh2M700qyf+aj5NBs4bi5ak+hIUBigm/nRO
	 cxRZOmetsybnhqgs8T+RtISksWEdZSur59aLqvzWdAaaNrLCqN0wwZEYPWwCXuC9LR
	 fN5DDn7s3fKqw==
Date: Tue, 9 Apr 2024 13:21:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
Message-ID: <20240409-unhelpful-huntsman-25e264e68251@spud>
References: <20240408125256.218368873@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cGk9BMXf4prOg65w"
Content-Disposition: inline
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>


--cGk9BMXf4prOg65w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 02:56:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--cGk9BMXf4prOg65w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhUy2wAKCRB4tDGHoIJi
0h3bAQDWbaFTfPQqfVroVzcs1csrU8HpiOAQNZVfmxnsk7/BKgD/b9wsTmT87o8B
E6oR3y+Iz/qshaOmG9KdGPBM4bqFIQU=
=vEkp
-----END PGP SIGNATURE-----

--cGk9BMXf4prOg65w--

