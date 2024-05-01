Return-Path: <linux-kernel+bounces-165717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2F8B9024
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A0F1F22F38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D1161330;
	Wed,  1 May 2024 19:45:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B636182DF;
	Wed,  1 May 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592726; cv=none; b=n/xy/xt8xiWokwB4ThABD84GyH5QNWUdYk8eh2dfB/fmiONI+HbtR5WQYwbFWZzOy+JvlRaawo5ZaueY5os2x09QOnzLCHGe4FuBFUT9e3B8y4e/Tz3ntNKO4fIbvspBdo3uhGy3dD2Q/atvitbFk0GCN5DvTnpztB5cN2ETVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592726; c=relaxed/simple;
	bh=xnreSdsdbD6FtP4vdUNMdg0/Ay0B/FX9xAEZ+/zp/9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2lxbBa5zQpHUR6lIjWQicUTzxT6sjuw5zdTyYiV6V20hnOisc2yLv9s6Fw6FuBWZoAsPByb1YmXGFlJIpqCy7a8FEDI3jDOyxoPdSfb1Xei9ZyxFBQVqPfiJ3wFrlPS9vGbQtOW/FHUqzAsGV9YpdJZ2w88zB0wY75IysKchcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9B3241C0084; Wed,  1 May 2024 21:45:23 +0200 (CEST)
Date: Wed, 1 May 2024 21:45:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/137] 5.10.216-rc2 review
Message-ID: <ZjKb0+/CRMkSh6/6@duo.ucw.cz>
References: <20240430134024.771744897@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s5+Lxu76gKpdbpd0"
Content-Disposition: inline
In-Reply-To: <20240430134024.771744897@linuxfoundation.org>


--s5+Lxu76gKpdbpd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.216 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--s5+Lxu76gKpdbpd0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZjKb0wAKCRAw5/Bqldv6
8tuAAJ42uPjYnkwokEKPMxdsBxQou/dqxwCfTvyQ6MchtzZ+yJ6uMvHh5Ps2spY=
=KwGI
-----END PGP SIGNATURE-----

--s5+Lxu76gKpdbpd0--

