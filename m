Return-Path: <linux-kernel+bounces-136366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3089D339
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CAD5B2414B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40767F498;
	Tue,  9 Apr 2024 07:32:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64A7F47F;
	Tue,  9 Apr 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647978; cv=none; b=Imv3GDo6no69kblN4RcLoq8utBg2QlFruO8Cs7LwP/7ZBsc18nYYOYaasSNmHli4hVaHboz+FxNyrzTxr0YWsa2FgBLMhhSaf/m1QbVzsP4xFHbvkYUPokZm/nIt9RxZCbAxeVNp/u5JDs/UUfepwY6WArBW0UpTBErZldCttFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647978; c=relaxed/simple;
	bh=9tPBSm7SC7rcjr+Fa4Gnnzk5ouIqti3bmwbVvtKlieI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUl/E8OvqCJiQkP+j0sLWhOdaoX1XT3OrDXgh43gAPtDbezIZe2QCtnW7T0y38SONCZjqMVXJ+5tXP3eN2pl02cwmrBiKaRxzzH8VK06/jqWsByuDP8zp2iLAzM7nLDPSQLhNh6rg+l1HAoVreZeXh30xahvXET+hzNiMe6kilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 160401C007B; Tue,  9 Apr 2024 09:32:54 +0200 (CEST)
Date: Tue, 9 Apr 2024 09:32:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
Message-ID: <ZhTvJXlWJ2TjIQ1a@duo.ucw.cz>
References: <20240408125256.218368873@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oZRkL5METsbvE8ng"
Content-Disposition: inline
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>


--oZRkL5METsbvE8ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

No problems detected here, either:

Linux 6.6.26-rc1 (ec59b99017e9)
Linux 6.8.5-rc1 (51d60edf2813)
Linux 5.15.154-rc1 (bfeab055fa43)

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oZRkL5METsbvE8ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhTvJQAKCRAw5/Bqldv6
8hwkAKCbN7dcJdR6eKxnpdlsxr+lx6SW3QCdHuq/0kq5iJoTHnUCx0gB9ltgCEE=
=wBoT
-----END PGP SIGNATURE-----

--oZRkL5METsbvE8ng--

