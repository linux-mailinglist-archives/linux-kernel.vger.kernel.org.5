Return-Path: <linux-kernel+bounces-85214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4A86B258
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3D028580C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87573512;
	Wed, 28 Feb 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acYfcy9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B694E15B963;
	Wed, 28 Feb 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131930; cv=none; b=RUx4wriDSz9KhASlT1qA+KE88oN7pnIzmbK/pFrpJb+abiwL2Owp4WO8r+0CgBJu9tzifJfq+l428oG+QWdN3Li7Xb3QRcE/rSu/FUKVkvHrYFHCjfrcnKL83adxx3yNv8GmBSHwRqYCzcWpUtbqpEq4/UKOkqb4erCEMwnGq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131930; c=relaxed/simple;
	bh=UAvK9lEupXL839Fje05666gFTryTZTeIzazdLbh60aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V27SJSbSE2PFa8JxBcw0mNwYLKM6WeyXExJVwEZQrVYjBwQ8ZGp3j1N2UYV6HsUb16/WnzpLlfkQlPHK/KGSCbuZhgA93M0eVEryhkK1+9rcB2zAsqb4nJEnMtTG7KQbPMXOqZwracwtHPXHxITKfj7gaVX8zxDIk0w4LYUs5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acYfcy9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144AEC43390;
	Wed, 28 Feb 2024 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131930;
	bh=UAvK9lEupXL839Fje05666gFTryTZTeIzazdLbh60aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acYfcy9Da6rHZYP2ukmfjz7P9BjtZ5VlQF0+LG9cYOuFHYpfBSFxNDTWg2DlQ5/Sm
	 HuvjTZS1z8Xx5Y+0jxw/J3RqafrqImasnDj1lnH1ugtJLGZoX2pgVTbwuK6CFmezN3
	 R0SwmzZDlADdxYWqdkAvjMFy1e6n7fUw8TsgC5nzCA+h/YM9SmY79dE0fBOLcc68pl
	 Z9MS+1PkYhEL4u35s7shS1otY5DRABkTXCmO2ESlUidx27fxX5MDF2E2dQRNnvC0IW
	 R+9I2D2kj1A5r+gKOgXtopaMiu9brJdFfb1dY1KaIEiock8O6Br9YB+VxIlDwDhAm0
	 PkvpVbsnYfVGg==
Date: Wed, 28 Feb 2024 14:52:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
Message-ID: <20240228-proud-virus-f04787290e2c@spud>
References: <20240227131625.847743063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dp3lB1dj4mYlSnzw"
Content-Disposition: inline
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>


--Dp3lB1dj4mYlSnzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2024 at 02:21:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Dp3lB1dj4mYlSnzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd9IlAAKCRB4tDGHoIJi
0sqSAQDghhwvei6klNG/ErGF7kalmt5BUdGavd4RegmAZFzQSgEAsWOdfzas3EYz
jkDPn4iT6fysOp9exYWNsZ85l5/wXAo=
=/DeD
-----END PGP SIGNATURE-----

--Dp3lB1dj4mYlSnzw--

