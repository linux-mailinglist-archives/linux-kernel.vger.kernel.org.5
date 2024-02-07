Return-Path: <linux-kernel+bounces-56722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1284CE0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8601F269D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B587FBC6;
	Wed,  7 Feb 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVipaoMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A27FBAF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319819; cv=none; b=iJ0xSM4+eN6+Hvmg69YFbLa4B3p4flYQ+93nYn4q3Xp51bOc9/67iG9dEx5zvCz0rH/iXESVdeQzF+HcMNnXeqPVtUSHXNcDTSA9Y+Zd8GUjYcMr4yHOmisceSG4xq6hvVHlIt8WWoLFCSiwmdSrnhM2gDjThbPGU47TPhLFeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319819; c=relaxed/simple;
	bh=UgPWixAo3eAKaq+jYQ5o0vmRE5lLNZA4whjgz2D5js8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBg2KnmlN3SKDrXd5dsXKTgvHyg+n1AgOIwCScqJUFrdNDa2VrBk4sDmacLKh2JI/50li614F4FE87RRJUGkXPain58FIQaoom9udABiskJ4/MrUtYBDOnMx67ofVOuT7WWUiEZoUbAes5JRZE0aiOco9I+LRSvKyJ+Ho8VZ/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVipaoMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D262C433F1;
	Wed,  7 Feb 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319819;
	bh=UgPWixAo3eAKaq+jYQ5o0vmRE5lLNZA4whjgz2D5js8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVipaoMHyx9WnbIjLYzyXphOQf+W8hyIdhhwHFjN/ge/T09Yv2iFGcWr61HU9O2j7
	 Vu1BzAg81apdTGQwJQNr2rmG69kwBT8YYCGJCaxzh34HN2QzubCWOE/9WTt+FpaKHK
	 eHjZT9zLkQ59y1UPNbrdS6bTMNa/KFKtsosOFq7o4YawthN1D/cCRG2eEWcU4EVvht
	 LuJgB7mMKdaZqAELSZ3eqjjB+8ucTuXTOaD3oemKWYsIpbtEwEU1PdHcdSMSA8ci6G
	 Dogo9TEyZqD3R1kyfqNhiYsuvtmbMgQBbyThZNgKm0+w+O7LvssopRg1ijDd4xxB7g
	 sGclDkZSSZM4Q==
Date: Wed, 7 Feb 2024 15:30:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	bard.liao@intel.com, mengdong.lin@intel.com,
	yung-chuan.liao@linux.intel.com, baojun.xu@ti.com, kevin-lu@ti.com,
	navada@ti.com, tiwai@suse.de, soyer@irl.hu
Subject: Re: [PATCH v7] ASoc: tas2783: Add tas2783 codec driver
Message-ID: <ZcOiCFlqsnyAEgl3@finisterre.sirena.org.uk>
References: <20240207054743.1504-1-shenghao-ding@ti.com>
 <ZcOWZlXu1fL_haFU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vE1mhbGjFNiuNYDa"
Content-Disposition: inline
In-Reply-To: <ZcOWZlXu1fL_haFU@smile.fi.intel.com>
X-Cookie: You might have mail.


--vE1mhbGjFNiuNYDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 04:40:38PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 07, 2024 at 01:47:42PM +0800, Shenghao Ding wrote:

> > +static const struct regmap_config tasdevice_regmap = {
> > +	.reg_bits = 32,
> > +	.val_bits = 8,
> > +	.readable_reg = tas2783_readable_register,
> > +	.volatile_reg = tas2783_volatile_register,

> > +	.max_register = 0x44ffffff,

> I'm always wondering how this can work in debugfs when one tries to dump all
> registers...

regmap will filter out non-readable registers from what it shows in
debugfs so sparse regmaps will end up much smaller than they might look.
The debugfs code also has support for seeking into the output (since
each register is a fixed size) so we'll only actually render whatever is
being read in an individual read().

> > +static const struct dev_pm_ops tas2783_sdca_pm = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(tas2783_sdca_dev_suspend,
> > +		tas2783_sdca_dev_resume)
> > +	SET_RUNTIME_PM_OPS(tas2783_sdca_dev_suspend,
> > +		tas2783_sdca_dev_resume, NULL)
> > +};

> Use new PM macros.

..which are?

--vE1mhbGjFNiuNYDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDoggACgkQJNaLcl1U
h9C60gf1GOfWTgnrzFxR9xa5hmkPBPAi1Ojd3JfrzPlUXJfieLeZWc2wwlEbDLsA
yNTO21FqNRRdtrRAay4kRZBBFuam/4RwDef616jFc6lY61hkvPz/CeUSZ9X4Oqa1
nFnGaVmNNKxEdhM/J4cDsxjdhIpsUa/ib+rhwZGv2vXWxMlQhAbfQneSIKuedTfz
z+kXD1kegP9QWiqQzHsko8X/qBQjk/TfPYhjOSZni8hgKAmb5xY35jgcba3qZj0b
ndwz0c749lcBm7ojhrV14jeGmZwH2RmvHHxy76Csw9cKnRoOUuKs5eU6Wvh+yqOZ
FueTF3iS+xTteyTeDrGeO3T2+w16
=rb8K
-----END PGP SIGNATURE-----

--vE1mhbGjFNiuNYDa--

