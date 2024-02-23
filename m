Return-Path: <linux-kernel+bounces-78913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97D861A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5641C20A10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4E1419B3;
	Fri, 23 Feb 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh9u3Exs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650F141993;
	Fri, 23 Feb 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710460; cv=none; b=GjTqEc8pfzFz/LFRWTp1fQuVFNrvLbxz4A68wWVgAXM5TxuG+YgpdzXWYDV4PsZBPgOdw0EnpxiYIDbI7omnj/9McKtT3Eztvkrls3pRnLB0ePYRAlMKS8i/248vIsQpz8533EQYM1f8AiXSfRUtqKLby0xeXuGEPB23QGoCoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710460; c=relaxed/simple;
	bh=uyN4IXL3t5aphJYztaDQ+uPEstUMDnIE+PmrsESAGI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbaLzmug8P+VMktakgGtgqnF5AqtqF5v18Bf6VONXMDepleOHtm0qHNa2VvdCZDZsJqjBMu1fL3jg7lOdYLcj4sx0o6b6my7SRfMKc1Sm4bPn1kLAurdTCXkEg9E94lBn+uFRCKhOY9SCCut4xr9NS6RTxpMsFNEzcdU9Ypn3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh9u3Exs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51935C43390;
	Fri, 23 Feb 2024 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708710460;
	bh=uyN4IXL3t5aphJYztaDQ+uPEstUMDnIE+PmrsESAGI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mh9u3Exslu0MqDrVFqUUkB2SDK8mmTevN16BWFQ9/MwkTriUDHh3mgdz8dgWhRDQI
	 Zteohm4vpDosBFvv604oJM+yQCJMff92KkSjf/0ox1iHbffkMMbQuarRcihvjX1xJg
	 8y+FONY94nucnADTXins3nK8SzFUsGk7uYDWyj7hVmFWKGKFGeOAE6Thk1ON4dc0Oj
	 FE1fp8g59xbrwDSTUz4aVvDQtolbTms5tO9vjaqAFsOJmNeGlt952WqpWMebxZBca5
	 SDLm9erxotX8nshRESd9rqfnAmWANy9s8EYyVxDulL++9EgxcczMjmNi9/vJj2YdPK
	 lb9MsdWiM8vXA==
Date: Fri, 23 Feb 2024 17:47:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
Message-ID: <20240223-speckled-active-1efb9e182114@spud>
References: <20240221125953.770767246@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xV04cpaxN+od26Hl"
Content-Disposition: inline
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>


--xV04cpaxN+od26Hl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 02:01:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Better late than not at all,
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--xV04cpaxN+od26Hl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjaNgAKCRB4tDGHoIJi
0mpeAQDUt1Ob3uZIlmZp0WzJOE6wUBLHijO+TLBL8+rzdPERygEAtO7j95RUzF/b
C6dbfQb+evE/c4GyejidhEFBa/7cdwk=
=7/eK
-----END PGP SIGNATURE-----

--xV04cpaxN+od26Hl--

