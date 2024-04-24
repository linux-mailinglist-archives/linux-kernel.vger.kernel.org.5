Return-Path: <linux-kernel+bounces-156477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF98B0318
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF091C2428D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E31586F4;
	Wed, 24 Apr 2024 07:21:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33D1581EC;
	Wed, 24 Apr 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943277; cv=none; b=VKbroE9gTuDDdbMTOQJqdfHOYr+pS7Ag7VaBUzUMTkTNzc7GVbRD089rdlXXztCJc7stfmOQTt1l2pxkEMxfS+aL4+vpaws+tM/S0SLw2bryJBB1h2LG6yv84DsPP/rMaF+F7J0lE8PpDzMeO1AstSHa5QJIOQpKdxcjgCEW+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943277; c=relaxed/simple;
	bh=MrAMw9NiDMTzXplx1v8tQRk0DT6c3nZFJrzglC0myyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/hK/Ssym8KfE/axNSfHkE/vwe7/KlJE3t5JxXkNxVIEJ5fPlLnQF6GhKApw6TNti1P6VNnYBIoQQdS/AB4AKJ0FpkW9xavvuYp7sUbe/ODiPH52y/mmksx55tXUTxc1edXcysTeR+HTxWI58lhWlXMFOwifpqg+FpSUgfmiRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B61B71C0080; Wed, 24 Apr 2024 09:21:13 +0200 (CEST)
Date: Wed, 24 Apr 2024 09:21:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
Message-ID: <Ziiy6cS8Yyg6VFfK@duo.ucw.cz>
References: <20240423213853.356988651@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z8vrHj1uEYz9nP1I"
Content-Disposition: inline
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>


--Z8vrHj1uEYz9nP1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This causes compilation errors in our testing:

arch/arm/mach-omap2/pdata-quirks.c:259:15: error: variable 'pandora_soc_aud=
io_gpios' has initializer but incomplete type
1991  259 | static struct gpiod_lookup_table pandora_soc_audio_gpios =3D {
1992      |               ^~~~~~~~~~~~~~~~~~
1993arch/arm/mach-omap2/pdata-quirks.c:260:10: error: 'struct gpiod_lookup_=
table' has no member named 'dev_id'
1994  260 |         .dev_id =3D "soc-audio",
1995      |          ^~~~~~
1996arch/arm/mach-omap2/pdata-quirks.c:260:19: warning: excess elements in =
struct initializer
1997  260 |         .dev_id =3D "soc-audio",
1998      |                   ^~~~~~~~~~~
1999arch/arm/mach-omap2/pdata-quirks.c:260:19: note: (near initialization f=
or 'pandora_soc_audio_gpios')
2000arch/arm/mach-omap2/pdata-quirks.c:261:10: error: 'struct gpiod_lookup_=
table' has no member named 'table'
2001  261 |         .table =3D {
2002      |          ^~~~~
2003arch/arm/mach-omap2/pdata-quirks.c:261:18: error: extra brace group at =
end of initializer
2004  261 |         .table =3D {
2005      |                  ^
2006arch/arm/mach-omap2/pdata-quirks.c:261:18: note: (near initialization f=
or 'pandora_soc_audio_gpios')
2007arch/arm/mach-omap2/pdata-quirks.c:262:17: error: implicit declaration =
of function 'GPIO_LOOKUP'; did you mean 'IOP_LOOKUP'? [-Werror=3Dimplicit-f=
unction-declaration]
2008  262 |                 GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTI=
VE_HIGH),
2009      |                 ^~~~~~~~~~~
2010      |                 IOP_LOOKUP
2011arch/arm/mach-omap2/pdata-quirks.c:262:55: error: 'GPIO_ACTIVE_HIGH' un=
declared here (not in a function); did you mean 'ACPI_ACTIVE_HIGH'?
2012  262 |                 GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTI=
VE_HIGH),
2013      |                                                       ^~~~~~~~~=
~~~~~~~
2014      |                                                       ACPI_ACTI=
VE_HIGH
2015arch/arm/mach-omap2/pdata-quirks.c:264:17: error: extra brace group at =
end of initializer
2016  264 |                 { }
2017      |                 ^
2018arch/arm/mach-omap2/pdata-quirks.c:264:17: note: (near initialization f=
or 'pandora_soc_audio_gpios')
2019arch/arm/mach-omap2/pdata-quirks.c:261:18: warning: excess elements in =
struct initializer
2020  261 |         .table =3D {
2021      |                  ^
2022arch/arm/mach-omap2/pdata-quirks.c:261:18: note: (near initialization f=
or 'pandora_soc_audio_gpios')
2023  CC      net/sched/sch_api.o
2024arch/arm/mach-omap2/pdata-quirks.c: In function 'omap3_pandora_legacy_i=
nit':
2025arch/arm/mach-omap2/pdata-quirks.c:271:9: error: implicit declaration o=
f function 'gpiod_add_lookup_table' [-Werror=3Dimplicit-function-declaratio=
n]
2026  271 |         gpiod_add_lookup_table(&pandora_soc_audio_gpios);
2027      |         ^~~~~~~~~~~~~~~~~~~~~~
2028arch/arm/mach-omap2/pdata-quirks.c: At top level:
2029arch/arm/mach-omap2/pdata-quirks.c:259:34: error: storage size of 'pand=
ora_soc_audio_gpios' isn't known
2030  259 | static struct gpiod_lookup_table pandora_soc_audio_gpios =3D {
2031      |                                  ^~~~~~~~~~~~~~~~~~~~~~~
2032cc1: some warnings being treated as errors
2033make[2]: *** [scripts/Makefile.build:250: arch/arm/mach-omap2/pdata-qui=
rks.o] Error 1
2034make[1]: *** [scripts/Makefile.build:500: arch/arm/mach-omap2] Error 2
2035make[1]: *** Waiting for unfinished jobs....
2036

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/670037=
1466
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
265143103

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Z8vrHj1uEYz9nP1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiiy6QAKCRAw5/Bqldv6
8vbUAJ9LTKihTTO5zazCV/M7Zb73aYUbBgCgu5+1hRVetQhHn2GgrkBQXnvFPdo=
=RcgZ
-----END PGP SIGNATURE-----

--Z8vrHj1uEYz9nP1I--

