Return-Path: <linux-kernel+bounces-85218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B083D86B267
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EE028741F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54E15B105;
	Wed, 28 Feb 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmbv3RQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365DC15B0F4;
	Wed, 28 Feb 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131967; cv=none; b=Yog2wAZeftL5sa19ZNdVxy6BeMaYT5imgGzTuQ9MCQRpNZhLK6uuERT5MYbEkiQo7WDLhAwNJjIGyzQwnWQCuMlvqGOmsBp5zS0nILzefe2I8Pw+1HBEIjdvNZEcjPEjjNAzL6h+NQR7h+Tcjyy3dLPk4/SeQnbelJOH4zU7abQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131967; c=relaxed/simple;
	bh=WT3pxg7oGg8f/ufZlqyjKxqYBdjk1b9KOgBvbggFMxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzPb15wWhBP7YGgLy9ORjSiP3V/vGfZs0V+tGyEEw8bhJPNLDdavprzqnN2JuGoJslN1HG05Bp2TX/1Nn7sumXn7t1clDiXX6wGxc/eKsz0RigGCP+AiZSUKnUKWUWcaHSW/cglQQdflsr1YMtKbUkWVYe6aaI8DFGHf7IAjgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmbv3RQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5B7C433C7;
	Wed, 28 Feb 2024 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131966;
	bh=WT3pxg7oGg8f/ufZlqyjKxqYBdjk1b9KOgBvbggFMxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmbv3RQ5UwsopK/NmeHO0lXeHgJT/hExnR8UYF5MMHwUV4KZaZeywaOUH1UTYCo+Z
	 QaTj8l7oBLLObdgWRrdmrTt0HXIpgT7f1iNPtgIRX2MGiK3xo9lUgRfYrA6a1JEPJj
	 EaOIaNvBkPBVT7Bc1w+RTcg9GxnyAaRksyW4u2acgKH8dLPRi9g3GOGeqvn2srqECI
	 /xIFO+Y5iCm03Qt7x+6uyS2BPVMx/2xq1iavucElr/Ay3nMWh6EDGA5PKTDgDSDjYS
	 fUaWqJkB1Kld+KnQiIhINwsyuoRpXjrIA20ePlDBQbuk7+B5RpqSNDdTyTpB1i1C9E
	 JnkTcNh15Sxgg==
Date: Wed, 28 Feb 2024 14:52:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Message-ID: <20240228-manila-coleslaw-038ec8d464cf@spud>
References: <20240227131630.636392135@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aMnH5bQ2nuBGaW2I"
Content-Disposition: inline
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>


--aMnH5bQ2nuBGaW2I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2024 at 02:17:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--aMnH5bQ2nuBGaW2I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd9IuQAKCRB4tDGHoIJi
0rijAQCyrdvlCRDGKFxycIZooFsfiZ3iQxv986jjBpg3G4EP1wEAokLMgCkSJuj7
8KYgVeA4MUZ9EZ9iV5jNQE/Um1TI+gQ=
=uLBD
-----END PGP SIGNATURE-----

--aMnH5bQ2nuBGaW2I--

