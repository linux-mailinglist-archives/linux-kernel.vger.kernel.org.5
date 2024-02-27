Return-Path: <linux-kernel+bounces-83791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70842869E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103CF1F2BB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFC4F5EC;
	Tue, 27 Feb 2024 18:00:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292B4EB44;
	Tue, 27 Feb 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056839; cv=none; b=k1rkI7LGDP2f7MZmEjnWakRQyKrUG59sPEnI+A+pXrwS7+k/KqTqL9E4sI3RYpPyDbhOHYu0v1T4E2yl7RRZYCw5k6VWX+myud6e5UVSNdh0pt2D0nFMNeTTeEBX968i8FXjT8PC/2ciKIRy1AP4+OPg4C4YSiJyu78pDcW7OVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056839; c=relaxed/simple;
	bh=HMLqiLNT5rGKC/cGZ6H4NNZrrQDJZ8PPrqMkNXuLyAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHhZWA/Z8jB4td/OLQFcaMEO+Fcj4sxtON2Jw2o4k2x3cZFZenyKMVyYvzlW06LA2SE7BLAnBNz36ppbSDEQ1wIy34WjF+PW9ll0UCg2ASpfTaRfRrmzjSLpmh9Af6tKfXYEbCoQn8g16C07NBEPf2LgPisDkqFyhBLYptN1VCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 377DE1C0082; Tue, 27 Feb 2024 19:00:35 +0100 (CET)
Date: Tue, 27 Feb 2024 19:00:34 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Message-ID: <Zd4jQrJLf44KxKWM@duo.ucw.cz>
References: <20240227131615.098467438@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9s0xY+6wLOv2nWYy"
Content-Disposition: inline
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>


--9s0xY+6wLOv2nWYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.

We get build errors on risc-v:

  CC      drivers/clocksource/dummy_timer.o
2773  CC      net/sunrpc/timer.o
2774  CC      drivers/firmware/efi/libstub/lib-fdt_rw.o
2775In file included from ./include/linux/list.h:9,
2776                 from ./include/linux/module.h:12,
2777                 from drivers/net/ethernet/realtek/r8169_main.c:12:
2778drivers/net/ethernet/realtek/r8169_main.c:5512:23: error: 'rtl8169_pm_o=
ps' undeclared here (not in a function); did you mean 'rtl8169_poll'?
2779 5512 |  .driver.pm =3D pm_ptr(&rtl8169_pm_ops),
2780      |                       ^~~~~~~~~~~~~~
2781./include/linux/kernel.h:46:38: note: in definition of macro 'PTR_IF'
2782   46 | #define PTR_IF(cond, ptr) ((cond) ? (ptr) : NULL)
2783      |                                      ^~~
2784drivers/net/ethernet/realtek/r8169_main.c:5512:15: note: in expansion o=
f macro 'pm_ptr'
2785 5512 |  .driver.pm =3D pm_ptr(&rtl8169_pm_ops),
2786      |               ^~~~~~
2787  CC      net/sunrpc/xdr.o
2788  CC      drivers/clocksource/timer-riscv.o
2789make[4]: *** [scripts/Makefile.build:289: drivers/net/ethernet/realtek/=
r8169_main.o] Error 1
2790make[4]: *** Waiting for unfinished jobs....
2791  CC      drivers/mmc/core/sdio_bus.o
2792  CC      net/sunrpc/sunrpc_syms.o
2793  CC      fs/fhandle.o

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
192614164

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9s0xY+6wLOv2nWYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZd4jQgAKCRAw5/Bqldv6
8sLFAJ0QUN7KR2m75k1T8lOY1T21lGXAeQCdHEuBygosXiY/oDuPaRX4gxtXBFw=
=sWUz
-----END PGP SIGNATURE-----

--9s0xY+6wLOv2nWYy--

