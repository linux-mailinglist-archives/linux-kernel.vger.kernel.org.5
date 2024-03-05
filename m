Return-Path: <linux-kernel+bounces-92412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C0871FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA971C20F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF7C8593A;
	Tue,  5 Mar 2024 13:16:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4255E77;
	Tue,  5 Mar 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644565; cv=none; b=ErrQ4hy+6VY/xn0kxlQVk/IJ0j90WlCdWT59wJ62lfsmXM7UKchIt3O8HqPSgKswkG7LZBH662TbRQLYz1PiWFKlwC+q+4YqkxY0p8lFheuAFzLMpN77VK5wxNaP8yE8I/323pgt+OET9fRAi+NXdQJZ4jE6A7bYnqGiwGN0VJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644565; c=relaxed/simple;
	bh=JrOn8v/tFG1tuyd+KlzQ2N7IWUKWMCvSln/lXECSltE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTsBAACSr/3klztq9p2zCGYRbVdPWZz58S5mXK/FubNXKXgCYA3V8tCrf1FNscrMF34/4zRkrJcZVEXLBL8pgFK3bK5iNHuXJRZ07T2tab9Y1FFmYrK2Unrpx20ioMn1tAdMXxESIojSCJh0u0Gp39fQni2q2pvcr3rONC7cnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F27451C006B; Tue,  5 Mar 2024 14:16:01 +0100 (CET)
Date: Tue, 5 Mar 2024 14:16:01 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/41] 5.10.212-rc2 review
Message-ID: <ZecbEfXRqD5kBLmM@duo.ucw.cz>
References: <20240305113119.020328586@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tvfEa0ydwhPPFtN"
Content-Disposition: inline
In-Reply-To: <20240305113119.020328586@linuxfoundation.org>


--8tvfEa0ydwhPPFtN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.212 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8tvfEa0ydwhPPFtN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZecbEQAKCRAw5/Bqldv6
8l5vAKCYZSr82wz519l5l0G7qOFcWFSN1QCgsskBNFqLmsNIMs1EfUvdEPV+7rc=
=ixEc
-----END PGP SIGNATURE-----

--8tvfEa0ydwhPPFtN--

