Return-Path: <linux-kernel+bounces-912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6438147E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17D01C233F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F12C861;
	Fri, 15 Dec 2023 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Thwhup0t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCE2D797;
	Fri, 15 Dec 2023 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 13:13:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1702642402; bh=LfEPw8Rf3GRHOSbe1ZYau1FlgGol6uSWCfKA23VZKA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Thwhup0tbf5AHaKXNolCNyZ7FbvV6p0pPbY5A++Os5L+KUiggTTgNqVBAuHlmx6bM
	 oOBqVtzQJIvj1NsZ6CRLm9QtWeAqFo7+P/uSRr/3Lt8MS/Ni5s5qHJfIlbknXcvXCq
	 2MaWIArwCp0mV95CmUUodBY/vYFQuU1fE4lhybhk=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id C12E080698;
	Fri, 15 Dec 2023 13:13:22 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id B4253180C65; Fri, 15 Dec 2023 13:13:22 +0100 (CET)
Date: Fri, 15 Dec 2023 13:13:20 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: make deb-pkg: Does not strip debug symbols when compressing
 modules
Message-ID: <ZXxC4i1BIUh9oABC@buildd.core.avm.de>
Mail-Followup-To: Salvatore Bonaccorso <carnil@debian.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <ZXthQYablvopq0su@eldamar.lan>
 <ZXtieLq1kTs4pIbL@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9XsFw9lddrpm7zB"
Content-Disposition: inline
In-Reply-To: <ZXtieLq1kTs4pIbL@eldamar.lan>
Organization: AVM GmbH
X-purgate-ID: 149429::1702642402-FDD6B5FF-A2CCCE2C/0/0
X-purgate-type: clean
X-purgate-size: 3550
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean


--k9XsFw9lddrpm7zB
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2023 13:13:20 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: make deb-pkg: Does not strip debug symbols when compressing
 modules

On Thu, Dec 14, 2023 at 09:15:52PM +0100, Salvatore Bonaccorso wrote:
> Hi,
>=20
> On Thu, Dec 14, 2023 at 09:10:41PM +0100, Salvatore Bonaccorso wrote:
> > Hi
> >=20
> > When using (only tested with XZ compression, but the others should
> > behave similarly) CONFIG_MODULE_COMPRESS_XZ=3Dy to compress the modules,
> > it looks that the debug symbols are not striped.
> >=20
> > Building with the attached test configuration results in packages:
> >=20
> > -rw-r--r-- 1 build build  8.9M Dec 14 20:47 linux-headers-6.7.0-rc5+_6.=
7.0-rc5-00042-g88035e5694a8-1_amd64.deb
> > -rw-r--r-- 1 build build   75M Dec 14 20:48 linux-image-6.7.0-rc5+-dbg_=
6.7.0-rc5-00042-g88035e5694a8-1_amd64.deb
> > -rw-r--r-- 1 build build 1014M Dec 14 20:47 linux-image-6.7.0-rc5+_6.7.=
0-rc5-00042-g88035e5694a8-1_amd64.deb
> > -rw-r--r-- 1 build build  1.3M Dec 14 20:47 linux-libc-dev_6.7.0-rc5-00=
042-g88035e5694a8-1_amd64.deb
> >=20
> > This is odd, the linux-image-6.7.0-rc5+ package has a size of almost
> > 1G and the modules are not stripped.
> >=20
> > Switching the values instread to=20
> >=20
> > CONFIG_MODULE_COMPRESS_NONE=3Dy
> > # CONFIG_MODULE_COMPRESS_XZ is not set
> >=20
> > the packages are again produced correctly:
> >=20
> > -rw-r--r-- 1 build build 8.9M Dec 14 20:59 linux-headers-6.7.0-rc5+_6.7=
=2E0-rc5-00042-g88035e5694a8-2_amd64.deb
> > -rw-r--r-- 1 build build 819M Dec 14 21:00 linux-image-6.7.0-rc5+-dbg_6=
=2E7.0-rc5-00042-g88035e5694a8-2_amd64.deb
> > -rw-r--r-- 1 build build  73M Dec 14 20:59 linux-image-6.7.0-rc5+_6.7.0=
-rc5-00042-g88035e5694a8-2_amd64.deb
> > -rw-r--r-- 1 build build 1.3M Dec 14 20:59 linux-libc-dev_6.7.0-rc5-000=
42-g88035e5694a8-2_amd64.deb
>=20
> and the classical one. Missed to attach the promised attachement. The
> used config is now here.

:)

Hi Salvatore,

did you try to build with 'make INSTALL_MOD_STRIP=3D1 ...'?  When I'm
reproducing your issue here, the flag reduces the package size from ~1GB
to ~95MB.

Kind regards,
Nicolas

--k9XsFw9lddrpm7zB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmV8QuAACgkQiMa8nIia
bbhqRxAAmO+Zt5rOnsMsmI3ONRfEyOtvKlilCTAXjrSv0My/IENgB+XWFsJG2lnn
CBUi5ONIgl0mlIRtpFLwMiDHftFsc4wL/ga499rUJ2JULveY+iTPRNXQm+UPYudq
XXppfJvqJym6Q3s2uGTRbJCry7VSzoHufTj+DmkTKRgSJ+Er9b/5fU6vuWJx2pKz
EoC6C2SCs313HDdNQrG+zhFqgcMZNH1nS5FBcMKBsNgALFIeDjyXb4p695ThJj4p
fAfaCBDXJs7bkeUFGKnyvcH0iY0xQ20xN+CZ4oABjh8zbDREN190yU8wEg7It61c
iMmEkDHOmfA7TfO+pSQux7ZHadB5VnD5a94beJHO5hl1Y4hocgKyMUxF55uoojbq
hTrR1WcqVdBHhLhhzsC35FFYg8mrpw4RNCpa5x6UrrzNFIqLU6RsvvMkDEV7z83A
dWQYWTqrtJcE2WrG+7Jf4N14xD+vukwXbqXJw7BXOVNg3KdKOlQ5Igy6PqoIUlj2
P148zaadrUzFyee2UuVmZRxRwQZogGyXY6Z5ezSiQf8eoAGnMrFNb9emYTs6SFTo
bh/6GsjOP6QOnH47OklH7lKWnUfpYdfCeBp6/dwwA9FZ9/SlyqIj7DSVo1L60GSr
yH47DLYIMa/uZgt5aWQQscIiAW2FqJ0kFXV161pZlh81MnMIqYY=
=P1d1
-----END PGP SIGNATURE-----

--k9XsFw9lddrpm7zB--

