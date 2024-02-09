Return-Path: <linux-kernel+bounces-59600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085B84F98D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E931F2479E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991B79DC0;
	Fri,  9 Feb 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6VIidju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464E7603C;
	Fri,  9 Feb 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495816; cv=none; b=C7Kak1p7sNEDmJnyOslUnKH/+pDShUzSWbcPBozc1z6r9dPAxaPim5XRN71JjrAud7FOP1AhrUrHULzc7be8ynaL6Xz1/7OftYIQMssXTiDsO/mGPP/AuARUhFa5YeW1nPxOTCb7RrJezZK7qi2ZeOMq/1qu2oHAhqi/0+0k+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495816; c=relaxed/simple;
	bh=6GrQUOBdJgHuDQRzQ0AqHks4zrwNm8RCrCT11ANobpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTyNrzE1QMXevd8ISGJFxrvQZ46/ZDQ5ss2IpOITzr68pmAnq9rTRhXTiEE+5EcgDvgsGIVixE348MQo8GbO2aX88axamO+Z/ceO81CRrAZDlSB7z/mlpncfaQfnH2QbgDOumAoJ4xh6sk5zgxJmDOQiUvhtnE6HtKv4WxrZXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6VIidju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61699C433C7;
	Fri,  9 Feb 2024 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707495816;
	bh=6GrQUOBdJgHuDQRzQ0AqHks4zrwNm8RCrCT11ANobpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6VIidjuiRzBOMpxAFx9Ujc11tpmGqm4gLCRKSuM9hZ2Z80TnDiicpugTZJ9J4Qur
	 LpHePQyL00ARRJ/vLTIf8V1nJdSxnbL4Z2bWWQ7JQ3iNCoOXPQ+eFJ3RbEp2GTqZnf
	 LVG4ecVzT86YpGhU0pXygWg9ywDWIO5PbjSHJcigiIb0UfnZ3vMZ1zU7VkCPjdPF7U
	 YmFidBTG8t9WnuGvCb4pUnF8IjFP2YAnEklcYrgButOhIWtyAB87AoW7HqvfRK8Syv
	 XrIHQHzj0qlI0bTmhjvNmiXTEVFH5iMwgyMXkXGndumu6//Qkg7ZtEhJvtYDXj9Wjg
	 1NET7e/P8JIng==
Date: Fri, 9 Feb 2024 16:23:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Ding, Shenghao" <shenghao-ding@ti.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
	"P O, Vijeth" <v-po@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"McPherson, Jeff" <j-mcpherson@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"Chawla, Mohit" <mohit.chawla@ti.com>,
	"soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
	"Agrawal, Manisha" <manisha.agrawal@ti.com>,
	"Hari, Raj" <s-hari@ti.com>, "Yashar, Avi" <aviel@ti.com>,
	"Nagalla, Hari" <hnagalla@ti.com>,
	"Bajjuri, Praneeth" <praneeth@ti.com>
Subject: Re: [PATCH v4 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Message-ID: <ZcZRhEG51DVic2BO@finisterre.sirena.org.uk>
References: <20240208095255.1508-1-shenghao-ding@ti.com>
 <160173b0-098e-493f-93b1-8b831838e0a0@linux.intel.com>
 <0ac563b32399400897b8f3adce6195c3@ti.com>
 <d65cf9f4-1617-2962-2786-bcaf7907dd67@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zQWo3yeIUj38KCw5"
Content-Disposition: inline
In-Reply-To: <d65cf9f4-1617-2962-2786-bcaf7907dd67@linux.intel.com>
X-Cookie: You might have mail.


--zQWo3yeIUj38KCw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 09:44:25AM -0600, Pierre-Louis Bossart wrote:

> > > > +static const char *const pcmdev_ctrl_name[] = {
> > > > +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
> > > > +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
> > > > +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
> > > > +};

> > So far, I have no good way to handle the devices with multiple pcmdevices sitting in different i2c buses.
> > As you know, the gain value highly depends on both the mic-phone position and the mic-phone's own
> >   characters. All these controls have to be open to the product developer or manufacturer. They might
> > rename them per their products if they want.
> > As to the stable, my customers and I had developed many productors on arm-based paltforms. At least,
> > the i2c number is same as the one defined in dts.

> IIRC there is a codec prefix that can be used to uniquify controls, that's
> what we used when we have identical amplifier devices in the same system.
> Using this prefix would avoid this sort of hard-coding of the control names
> proper, in other words let the ASoC framework add a prefix if needed.

Yes, that's the best approach here - this also lets people assign
meaningful names which makes it easier for users to figure out which
device is which.  Set name_prefix when registering the device.

> > In PC, hwid, subsysid and vendorid can help to identify the platform.

TBH it's really not at all reliable for PCs either when you start
looking at motherboards targeted at industrial systems and the like.
There's an awful lot of machines out there that describe themslves as
"To be set by OEM" or whatever sadly.

> >   But it seemed difficult to get platform id on non-PC system. More often,
> > different productors from different customers might use the same platform.
> > In my view, the products developer or manufacturer might rename the firmware
> >   per their products if they want, not limited to the platform.

> It's not "might rename", it's "are required to rename".

> Your solution works if everything is build and configured for ONE board.
> That's pretty limiting, even for your own CI and tests.

> Could we not add a prefix for the firmware path that either either set with
> a subsys_id or vendor_id, and if it doesn't exist with a kernel parameter or
> a quirk?

> Renaming firmware files is a never-ending source of problems IMHO.

It's true that vendors will frequently not bother changing the machine
names or other descriptive information when deriving from a reference
design but that's more their problem than upstream's, and the more that
upstream uses the facilities that exist to describe boards the more
likely it is that OEMs will start to pick up on the value of doing
something sensible with them.  Pierre is right here, we should just be
using what we've got.

We should probably add a helper that tries to figure out a machine name
to try inserting into the filename for machine specific
firmwares/coefficients.  That's probably not even ASoC specific,
there'll likely be other examples where it makes sense.  Perhaps the
firmware code might be a good home?

--zQWo3yeIUj38KCw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGUYEACgkQJNaLcl1U
h9Csxwf/UkPhiZf21Muv5c/db1WjqskOJFvvs/5cjmh6WnI5Ga6nm5S4NlE5/km0
PNcycb9JDrGWHh23psT5niHn0gAE9zMvIpT6Vfl8GgqTWxeF+8PckPFzUE40SQS4
AaSDJeVgZup4DLev7WdG88pcGqT0/eNxa/IAm0SVJNT5yy+OF9DQGm8bs+xvwcfI
GR/CxwnrtTIf3daOZPnR1oubGjn/Dfxkl0fRItKO3ydJXjHH+uU+IHlI3OXv2bL+
8uANu+wnubCNWPwELzIIo63FdVzrV4wHack4Ylxrp56KV91uHy+G+SDAPRntCtZM
dLp4gKZCgLEu8WpfBSlKJjxmPjVteg==
=j3/W
-----END PGP SIGNATURE-----

--zQWo3yeIUj38KCw5--

