Return-Path: <linux-kernel+bounces-92260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F87871D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2786AB25D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083AD56B8C;
	Tue,  5 Mar 2024 11:23:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25756758;
	Tue,  5 Mar 2024 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637819; cv=none; b=rqSIyi5qLP3rC2Xr8CO5uBpsLY8LAkWktcOTkn54zAc0zNleQzIVrgGKSUMUiCJwYiuk6AcD/3bhJPsEQSEJJjJDkNW+QT4WBRbirsqaloH/JvU4oHNAJjw57AE7Tr3HXXdM8z142thYhQwuxzqgL44VzW9kt6ilGq2VUJiUQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637819; c=relaxed/simple;
	bh=lLRblsxVB2TWuvJmDPwCOG96qrCmbdMXcERFB5rLQeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF53i0RGvFzZb3sVPtlg+CDczu5UB3SsbCoGciFrCjK71X279GvjwaeYZfrdFxKafDMGxscCsNaVsXUhKMn7HfpFHCy0AL/9zIq0bjy+pu8WiW6Q5SLv2Ipnw1YREfzbLes0tefbaY5nyAJ9B2O3WqPMmLMJFcwKqLZnslfqdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C3861C006B; Tue,  5 Mar 2024 12:23:36 +0100 (CET)
Date: Tue, 5 Mar 2024 12:23:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/42] 5.10.212-rc1 review
Message-ID: <ZecAt5mzBnty3U6L@duo.ucw.cz>
References: <20240304211537.631764077@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1M8RGPqVEo1dEJJx"
Content-Disposition: inline
In-Reply-To: <20240304211537.631764077@linuxfoundation.org>


--1M8RGPqVEo1dEJJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.212 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We get build failures on risc-v here:

  CC      ipc/msgutil.o
1688arch/riscv/kernel/return_address.c: In function 'return_address':
1689arch/riscv/kernel/return_address.c:39:2: error: implicit declaration of=
 function 'arch_stack_walk' [-Werror=3Dimplicit-function-declaration]
1690   39 |  arch_stack_walk(save_return_addr, &data, current, NULL);
1691      |  ^~~~~~~~~~~~~~~
1692cc1: some warnings being treated as errors
1693make[2]: *** [scripts/Makefile.build:286: arch/riscv/kernel/return_addr=
ess.o] Error 1
1694make[2]: *** Waiting for unfinished jobs....
1695  CC      ipc/msg.o

More here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
200687731

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1M8RGPqVEo1dEJJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZecAtwAKCRAw5/Bqldv6
8rkCAJ9ccAvc5hbTwBKUcbfKq8LEbkjpiACfQSSzgek7HtjQgmiUuYZ68Cubrbg=
=Kpin
-----END PGP SIGNATURE-----

--1M8RGPqVEo1dEJJx--

