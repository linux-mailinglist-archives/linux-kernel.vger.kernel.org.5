Return-Path: <linux-kernel+bounces-159888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C267E8B357B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29177B20E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E7613FD9D;
	Fri, 26 Apr 2024 10:44:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6E29CEC;
	Fri, 26 Apr 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128265; cv=none; b=u3/xIKz45bIdggeZglropcZwkgBwHK8lHrsIw0tjR+PIB3OjfE/HfWowRWpE+ydH1VAzTy4yWqdI01vblxdOT5EveNYNOhNEA0rRHlYv1yK0z0WtxM93XANfO/BeYu6KLvtub5UnYCm8Oxk8wOGVfSYvi6us8wXfOaKCJ83fOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128265; c=relaxed/simple;
	bh=oiJnEtXecqKBogjajw76z6JmscL3oLdmGCyxcj19DIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpIGvZVBhDZmlX34mOW2l8uwnMZreKagWhZBJIcmD5H1yuHtxC9IXwELNWumqMDZFWf33VJ8h0T+pfkLGF4LddRV2pGk3MYnqOcm2oiZ6rQiwsC35+XbwDxppvvxC7l+jX90PlO4H/CY/OaXmm9EzXvIEoYtk9QxicSdhD899iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 95E8C1C0080; Fri, 26 Apr 2024 12:44:21 +0200 (CEST)
Date: Fri, 26 Apr 2024 12:44:21 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	dmitry.torokhov@gmail.com, mmyangfl@gmail.com,
	schnelle@linux.ibm.com, g@b4.vu
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
Message-ID: <ZiuFhTU4fPezFe1M@duo.ucw.cz>
References: <20240423213853.356988651@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jHhyeEcumdBQ39D"
Content-Disposition: inline
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>


--4jHhyeEcumdBQ39D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Dmitry Torokhov <dmitry.torokhov@gmail.com>
>     ARM: OMAP2+: pdata-quirks: stop including wl12xx.h
>=20
> Dmitry Torokhov <dmitry.torokhov@gmail.com>
>     ARM: omap2: n8x0: stop instantiating codec platform data

Cleanups. This code is so old it should not really be touched in stable.

> David Yang <mmyangfl@gmail.com>
>     HID: kye: Sort kye devices

I guess this is some kind of preparation for something we don't have
in 6.1?

> Niklas Schnelle <schnelle@linux.ibm.com>
>     PCI: Make quirk using inw() depend on HAS_IOPORT

This is preparation for patches we won't take to 6.1.

> Niklas Schnelle <schnelle@linux.ibm.com>
>     usb: pci-quirks: group AMD specific quirk code together

This is preparation for patches we won't take to 6.1.

> Geoffrey D. Bennett <g@b4.vu>
>     ALSA: scarlett2: Rename scarlett_gen2 to scarlett2

Big rename, and it comes after relevant patches, so unneeded.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4jHhyeEcumdBQ39D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiuFhQAKCRAw5/Bqldv6
8tEDAJ9PDsVDATvVvsujHzDbM8c83KehcgCdGdlEBGVdOKJBfWVzl8M92J0btsk=
=jA80
-----END PGP SIGNATURE-----

--4jHhyeEcumdBQ39D--

