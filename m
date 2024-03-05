Return-Path: <linux-kernel+bounces-92422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE0871FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551D91C256AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615185958;
	Tue,  5 Mar 2024 13:18:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650505A7A4;
	Tue,  5 Mar 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644703; cv=none; b=EYJdp6zbnPSn4EhFlxdXhzQskiosohNxjD+LKStZQM5EATKbw286ztUTXEA7QqzKeAqtk6G7K8DxCJzYNicAQ1kUKPpOdyWZG53mbenGVRZB4X+S+7TH/HhLa619grfUiQ4zvBWRabkeFvL+Hu/iB+qzryou1QN38kkbLpFXB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644703; c=relaxed/simple;
	bh=9zRIRB+U5W/Aj9OVFRN4PlGUIXT3VLQ10A0pWAR2cGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olae7GMdm/sbJdq11W/++3Tt/ctNaKroppnPwyZYRVWyXNroel7CB29JIlJ8lVkJleKXRlaVIZv4E1Db8ecdgVUsWKNHRjKDnkDg01wJM7zstAiU4WvIYnxnzHsUMvcrkPiCmOysRxKPqdaEj9I6y/GN8wAhYr/J78uoKNgRWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B20EA1C006B; Tue,  5 Mar 2024 14:18:19 +0100 (CET)
Date: Tue, 5 Mar 2024 14:18:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
Message-ID: <Zecbm3qVFN87GtxT@duo.ucw.cz>
References: <20240305112824.448003471@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gwN6tXj/ZlVntKPQ"
Content-Disposition: inline
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>


--gwN6tXj/ZlVntKPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.7.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gwN6tXj/ZlVntKPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZecbmwAKCRAw5/Bqldv6
8iTvAJoCqbEpUvKENnW48TQj0CtEewO4JwCgkKMMAO2MuyLhBvUVjcmUFECbcS8=
=A5tN
-----END PGP SIGNATURE-----

--gwN6tXj/ZlVntKPQ--

