Return-Path: <linux-kernel+bounces-49879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1B8470DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998DA1C247BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C1C8F1;
	Fri,  2 Feb 2024 13:09:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5046430
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879381; cv=none; b=ebD9jiA6HmDwvTBAtb9fVN/mu69q7qtXANXWuWkPcerxLltOj1ea1GMqxEpYjlkOdwkTc7GAhtcCibpFDvDouXO054wQTyKWjO/3SDiUECkF/fODNgUH4lJJykvy7XGfuzurw2c3tMts74kTfY9FLDoaH58Xn4KKcC4J8kchn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879381; c=relaxed/simple;
	bh=si1jDfJkJmfIzO1h/ErfppSUMhkjCOpyaxbayvbpRjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/pY6ewz0XrmEpWntJV53VF9nL0YMLztaenyX+GO9OcO7YGEPMcGU7H+wdN7ypVqbib6GrFxU/X92VTVwobFSdKouYi3GhH8+5lP5mch34stKvEYFrCzZLwh0VXue+pipEW3vTxpK3G+K+s45Zg02a0yA/m8nKBGDXTmFft5DwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVtIM-0003lW-88; Fri, 02 Feb 2024 14:09:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVtIK-0044R6-S0; Fri, 02 Feb 2024 14:09:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVtIK-00DnDD-2U;
	Fri, 02 Feb 2024 14:09:24 +0100
Date: Fri, 2 Feb 2024 14:08:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	kernel@pengutronix.de, oe-kbuild-all@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 17/33] spi: bitbang: Follow renaming of SPI "master"
 to "controller"
Message-ID: <fkqzgxam5hlutiujsdnrhoidx2mjcnkwl427dpvydux7fn3ye4@2p7b4e7z45e6>
References: <b2035a8030b77e8a3eea87adf7e4a191c0a18717.1705944943.git.u.kleine-koenig@pengutronix.de>
 <202401301813.fehkuS9c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tetp5lb4bqqkwc3b"
Content-Disposition: inline
In-Reply-To: <202401301813.fehkuS9c-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tetp5lb4bqqkwc3b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 30, 2024 at 06:46:16PM +0800, kernel test robot wrote:
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 6613476e225e090cc9aad49be7fa504e290dd33d]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/f=
pga-ice40-spi-Follow-renaming-of-SPI-master-to-controller/20240123-031635
> base:   6613476e225e090cc9aad49be7fa504e290dd33d
> patch link:    https://lore.kernel.org/r/b2035a8030b77e8a3eea87adf7e4a191=
c0a18717.1705944943.git.u.kleine-koenig%40pengutronix.de
> patch subject: [PATCH v2 17/33] spi: bitbang: Follow renaming of SPI "mas=
ter" to "controller"
> config: mips-db1xxx_defconfig (https://download.01.org/0day-ci/archive/20=
240130/202401301813.fehkuS9c-lkp@intel.com/config)
> compiler: mipsel-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240130/202401301813.fehkuS9c-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401301813.fehkuS9c-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/spi/spi-au1550.c: In function 'au1550_spi_probe':
> >> drivers/spi/spi-au1550.c:803:20: error: 'struct spi_bitbang' has no me=
mber named 'master'
>      803 |         hw->bitbang.master =3D hw->host;
>          |                    ^

Dang, didn't build test on mips. Will send a v3 once I did a few more
build tests.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tetp5lb4bqqkwc3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW86UYACgkQj4D7WH0S
/k4oqQf+PKoAyxps0x4nVkFRkOBtTNcXlNeXyJLJ15QRTcR2j2LDAoaetOiL8PWR
LVeT0uCO/tCC5ayoHYfKtsdtiwpkZU0d3ZhWydcB37BSC4SwcmtGTHW0PA6Y4eNE
6U3XpFO23oZ4zFCv45HqiiDbxeHySUvw97nmHinvLPw+1FqLIGhPtoKw78AbWwA3
GR4c7p7DTqYGVwlOUAv/cwioQQznUh01WYLpyRnMmMIdCvM8MkgM9ISbDNOve1al
sWus7hbUcBwlbMD4isdmYo3GomwgIv0+aDQJCFoekNiVKaS5T/QaXZWvAr7sEYQw
h4B1Fk/0m2lLaSVHLM4LaxSh2ZntjQ==
=4c6p
-----END PGP SIGNATURE-----

--tetp5lb4bqqkwc3b--

