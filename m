Return-Path: <linux-kernel+bounces-95447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B32874DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A4E2812A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F01292DC;
	Thu,  7 Mar 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrIOcIyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF182891
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811602; cv=none; b=YhFTcEODBHjsU3/PJhZFDRvLj2TzRCo7g2t0d3tnuFN8RwDYjHuZ1UQSCRC6C8RXRoZPg6wRR2tg92yVZwkXSYtSLqUPymRYxwnT3EJEsWKbV7M34uyJQM864JNKey9eAEFKRcbzWMVJsxK4tMLDJHQGQ4ckSl/f0/wrsqXTRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811602; c=relaxed/simple;
	bh=Iuq7wW8jUMuLEGXJxlWdQh1apTqKm177uyslO/azaA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duiMSVi6DYhMKRvygCkXpWc8506DE06xP2X8gBO/aIwrSv71+l2q/7tXaavD6A4ZNJn+hr+aoVp99tqYZ9mjqMYomKDmElB4vF0h/HargG7s7hgzVs0OtWklqBoAPBSj9piOCb6sydIXHMPTMCGDHnV1MNUYOkmk10wGVuslZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrIOcIyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C50EC43390;
	Thu,  7 Mar 2024 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811602;
	bh=Iuq7wW8jUMuLEGXJxlWdQh1apTqKm177uyslO/azaA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrIOcIyteGH0Psn3UTwqnj74q29j0zZzlNwDb+jOzAT0YfFLtqtJatnHtTqOCLqMg
	 EpEo7/c34kZYqaRx0WgFP6Wy1qLqPnPfzuyxVuJeu2oDalU+ZoAwmn2RNAWE8fr/km
	 7N1Sf0IeqPSgo5CLh/6oJQt5gDUCyKHAEN0Uk6SMqP0RvbL9XkjTbFjwHbZB+uZ5C8
	 lOp9gdYXFT+FeF+MtKeUGj7vcGKLbpbVY64LTDl8/npzoCVS8LoMYVGAvlt38cplnF
	 Y4Yad3S+o3UBFonsHBxFK0adxptiwr7vXxClhuk4ikwaGedXzhuWRtPxrmMkOTbwoL
	 AoJmTjdBDeFOw==
Date: Thu, 7 Mar 2024 11:39:55 +0000
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"bard.liao@intel.com" <bard.liao@intel.com>,
	"mengdong.lin@intel.com" <mengdong.lin@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Xu, Baojun" <baojun.xu@ti.com>, "Lu, Kevin" <kevin-lu@ti.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "soyer@irl.hu" <soyer@irl.hu>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v10] The tas2783 is a smart audio
 amplifier with integrated MIPI SoundWire interface (Version 1.2.1
 compliant), I2C, and I2S/TDM interfaces designed for portable applications.
 An on-chip DSP supports Texas Instruments SmartAmp sp
Message-ID: <73a4416f-4738-485d-aa5a-431c306e7023@sirena.org.uk>
References: <dff90323b41a4e3a8e0e8540fbb32154@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="13xliTJPAqH3UJDZ"
Content-Disposition: inline
In-Reply-To: <dff90323b41a4e3a8e0e8540fbb32154@ti.com>
X-Cookie: Been Transferred Lately?


--13xliTJPAqH3UJDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 03:56:40AM +0000, Ding, Shenghao wrote:

> > We also try to keep default settings from the silicon except in the most
> > obvious cases, it avoids issues with trying to work out what to set and
> > accomodate different use cases for different systems.

> > If you do need to set non-default values then either just regular write=
s during
> > probe or a regmap patch would do it.

> So, can I remove=20
> ".reg_defaults =3D tas2783_reg_defaults," and tas2783_reg_defaults from t=
he code?

Yes, supplying register defaults is completely optional.  It means we
can't omit default values from cache sync and have to read values back
=66rom the device the first time we read but those tend to be fairly minor
performance impacts.

--13xliTJPAqH3UJDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXpp4sACgkQJNaLcl1U
h9ARWwf9HcdUwT7bKSmEfdLwH0kU4RDbbNZ1UNhRUruO7+2kcrukoh9IbkAmJHHg
7lUfJI6hks3ir1uTyONS3PVarAim8mvzQfQZmuyu4mrWqHDXcIc/eAuX0mlrV3mv
2h5EPcE050Hi1esdMYb2+ax80Y3VlzPgTgqxkZCFzVNH7Yj4tr2Z3MidZQMlLR2W
vzJ7S+cs2kiq8TFkxMKECTDDEN02cqrC5+KxXPr6vXbQIPP8RP1ouO7wFoLQyvYM
OYSH/d/VB0O47dSfAscE/2aX+kOlBJkViIYHCJUqcUAp0xS5aWXM6il9ihS7tTw1
Awg6yj0cCP6wSRcPknF56znWUqLBCA==
=F7oz
-----END PGP SIGNATURE-----

--13xliTJPAqH3UJDZ--

