Return-Path: <linux-kernel+bounces-129866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5589716C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17EE1C26011
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DC1487F6;
	Wed,  3 Apr 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meEpAEPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E00142E78;
	Wed,  3 Apr 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151856; cv=none; b=pO1HnRYmoFUmkyWSbsCDYLcovusRbmxrSXBjnThO4DYXE7Oba/Bk5IGe+5leO8vSOI3mZG7mhp7GKoMDp1OZ61l9FFYXY4nVTEV3QaBZCDTT6MNFiQ4xWFwUkaeNX2WSpm5Lqn+vS63/bdWSwlM/o0ucTXs6V25Yt+xzmF7k70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151856; c=relaxed/simple;
	bh=1mvS+FUBmyvtS+2wLIyVNxxyjhs4XFIhe+lp7x8KcA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUiR6jnrkkSD6mP1650GT2yasoIl4n80ew+mBzPdFVXKf66VjD1JcXrsWnc5+UNUhIZpFPvkv/YdMdgnlrj73b5yLs5dEF1l9qEqZ7TbTFt+NsCZH0AgNzJf3CZrqOQS90c1h4KQeHH6H+TX4lIqGsxrODyAwaBsVXQoiVrrXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meEpAEPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06FDC433C7;
	Wed,  3 Apr 2024 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712151855;
	bh=1mvS+FUBmyvtS+2wLIyVNxxyjhs4XFIhe+lp7x8KcA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meEpAEPFKNU4Dpjsyte4PeLIcSwKIMeTiIYTq0s+GkW7ul2JAtQLwcsIwS/A0wUm/
	 wIsMoaLHtefy/uBxSLXnafwXh0sQp91tVT6uGeBbyy9NhbDMIEAIw2nSUir/uFiudi
	 cIRYyHie8P3R7X2ilLxzHeH9h6HfVxlVfAZcaPEmNIscbNMNV33vQj0p5kBWUED4pv
	 mZAxEq5QR4wRdi8ZDJf4U+fCDoVzQ3Is+S28IwQOx0c+dggd9PYTtNEGOFOdxUDUi9
	 VC0rvqMI/KXBTLPD3MBb+P2rMp/IVa6hXseM314/k7ga91vRISWXqo/ykg039L1mui
	 wMCILSBxRPZDQ==
Date: Wed, 3 Apr 2024 14:44:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
Message-ID: <20240403-component-cuddly-ad80b8dd5db2@spud>
References: <20240401152530.237785232@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FIzDBGW8upI2VJvK"
Content-Disposition: inline
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>


--FIzDBGW8upI2VJvK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2024 at 05:43:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

--FIzDBGW8upI2VJvK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg1dHwAKCRB4tDGHoIJi
0rRwAQChthDnZxgjhRFMtKS9jMJ38clP3XUHJdQV3+hKDWG6WQEAuvx7Xz4To90c
cGZWTzOhSi0MgB2mZby1k9TMXTNuXAQ=
=2qMD
-----END PGP SIGNATURE-----

--FIzDBGW8upI2VJvK--

