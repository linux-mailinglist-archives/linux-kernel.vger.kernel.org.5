Return-Path: <linux-kernel+bounces-129871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84109897177
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6679B22366
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1D1487F1;
	Wed,  3 Apr 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv8L7PFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C0147C6C;
	Wed,  3 Apr 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151989; cv=none; b=UaIhNM9Hnpj8oXBmsljuK8UszRWUFcv6cUpPb9leIXLLhry/d4eObXcxB0P+4y+SB7q5HzvL/tDZTwROtA7seACq+B+XcdeeJsMPFtBGxTX83oGobONyXuwgUTsaaM5dZG1SpnN9cXH0nzeuupV0pbpwZnhyPuawazOBUsMdo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151989; c=relaxed/simple;
	bh=WuiTGRd6X6pwBTtMeMT80INaLrWMzOmSLX5xvViWD48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZXEvXwzc9biNVnFcPeN0fZXg5c+xhr7BIKLVlZLMbjymQsxedQb1YKQleoNGS4ynAURK3jbVmtP8m6qNtBt+6nLf8yQZsFmj6DTVnxvQo/8vw3l5XbfFILyjaBod2+d5Ipjj/v26a3VmNUA++iBc2PYYoOlNXDS5S1U690ASdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv8L7PFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72838C433C7;
	Wed,  3 Apr 2024 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712151988;
	bh=WuiTGRd6X6pwBTtMeMT80INaLrWMzOmSLX5xvViWD48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv8L7PFYOerCMbxYxPHBDJNwj7QAsJ19FihdLejmMo8NxBfGtXrmaW2+uCD0GnnKz
	 U44+niPuP+qTIIwGdcaWtGaHX2ZJmBwOfbwxGcXC9ngHY2CCCxowLOiNaWtHsLaHOc
	 UAzLe6HA3/fcad1ihISlVEyIWQ/XsUROF30qnhEGoLiYcOqbJ4Z6Pp+7t6ECTv0H45
	 ovdtyrKF6uDvj5Kxe7QNm0eD04EkzlDEGx0TDkiDEzvD1YRGa3JAaq8tbVfXdkUwbp
	 nJISZFffql5EIVcaXoxyVWR7x5/sKwSPr6VuD6fSA45sjlm3IxaYagrTIFEKIzV2WE
	 aYU6LeZ6vlrzg==
Date: Wed, 3 Apr 2024 14:46:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
Message-ID: <20240403-decline-moaning-c359d0994d82@spud>
References: <20240401152553.125349965@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uj/+5Rr97HgkSGh/"
Content-Disposition: inline
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>


--uj/+5Rr97HgkSGh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 05:39:47PM +0200, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
>=20
> ------------------------------------------
>=20
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.

IK I am late, bank holiday for Easter delayed things :)
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--uj/+5Rr97HgkSGh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg1drwAKCRB4tDGHoIJi
0q5JAQCdIG8NNdgAbpWrAV04DxULNawavKtPdeOgvqvjs49TxQEAh0NWln1+cvJ9
+HQjHIoCM5K1CDyOnFJr/KTI5nqk8gA=
=Gp0J
-----END PGP SIGNATURE-----

--uj/+5Rr97HgkSGh/--

