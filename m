Return-Path: <linux-kernel+bounces-136860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE689D91C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258231C2116B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9F12DD8A;
	Tue,  9 Apr 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R84Iv3vI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC512D212;
	Tue,  9 Apr 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665220; cv=none; b=l/jCxtn1X06hgS59z34yaKpWvg8jXBeCm4HG1XYSEZkH3EPdNk6TMo2rs5KYCAqeEbAdPwImIE613ugIRCNDPtL7VcQtLNeNyjhLwecHPqT3VhFwzW/vZuoDpETrGdYzoKyAWvImoVeuJiGC+ABK78zuPzv9l0fQJarStUwC2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665220; c=relaxed/simple;
	bh=yLs+MY3DNM+1EKiA8sHE5egnnrigD7twSfZJOP+Kv9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN3XT9HesXK2kwqG9uGKHn297lDLGx5Os17Gona6oZaMex7hfgmuGBkI5cJcfT+4nhEgOGfTEIGQiRfli5itiPsSLe+gpF0t8w/UGrPwCIkZg7/yH/63hzP8vy618iEKf4SYSnUqviLUUzhhif8ymybYoWXCD+qVEPwB9aOwUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R84Iv3vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A5DC433F1;
	Tue,  9 Apr 2024 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665219;
	bh=yLs+MY3DNM+1EKiA8sHE5egnnrigD7twSfZJOP+Kv9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R84Iv3vI/pIb8azmw8vwwIohhaTzCRbyHCT2beaarzTwk6n4iFt/ubgK0sc4qsoEk
	 jxgVWGvUe8e3amRBVymSwqyKnc2v8WaogMHwovWXlhKA4Rsk7mQg4GQqnbo9Y/kVjf
	 u5txGc0prmbaKGzTaP3wdKoprRVvi1+QKri7XvA+Rc7l4GQbSux8JgACLYFKzcyWJx
	 4odUE0kHa4KvdBFixkoMnPvtRpsgYMA1DvPfbOBpRYlAJztjB3my2Y2VxT/uitayUx
	 2UNaVT+uTeev3HzniL5vupF1N1ZLfS9f3xUB9+9LF5HZwKdtSllKhyNN0lZbFvk3sh
	 TzhAhDAeXBP3A==
Date: Tue, 9 Apr 2024 13:20:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
Message-ID: <20240409-collected-undecided-c146587c33c0@spud>
References: <20240408125306.643546457@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYTz2Ii3nRxB5TSE"
Content-Disposition: inline
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>


--RYTz2Ii3nRxB5TSE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 02:54:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--RYTz2Ii3nRxB5TSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhUyfgAKCRB4tDGHoIJi
0pogAQCEiwg0wAIQZj+++tx7RTAKMSF9Zr1PhX1rrOW5gaacBgEAq9N/2rP4AeTP
v4JziOSg05tJe7wgFsD4FsNMuwyRcQ8=
=ZIvN
-----END PGP SIGNATURE-----

--RYTz2Ii3nRxB5TSE--

