Return-Path: <linux-kernel+bounces-97009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8434876462
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B8B1C219D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04663CF;
	Fri,  8 Mar 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYOhrchC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEB81F;
	Fri,  8 Mar 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901329; cv=none; b=p3+PSG8bgqT/il45X0ydPPOzWgwF2xsc2+95lPQyhVfmjR60TNFpK/d2Rpr9hEsdJJRZ/8lLUMpJX/a6LIWae6xUtFukPoxyCeQlLbzZXkTWnXyF4sr0ZgxFsnxNCubKd8iUJs4nO+fdzPCq2VTMH6zGjXtN8ITjf9LZHw65KrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901329; c=relaxed/simple;
	bh=FO/2tbdfopZ0jgXfxeznKBXF2Z6rQryzkEHxQzSdob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKzllPkBKmAiBX6LiWAxC99GtBE0N+Dx4q1evBCrRCjqp6AXHMrVMOv9E7n7BLwqSUfwFeXX36rSQDs+ATzD5q6TcLpQ+zk8X1912zPMg092RJqehu4EfOBQue8a0NFTvQpok5/r4SiSm2AogJ1PRd7zf+JL6c77RnUkcnGiPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYOhrchC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A38FC43394;
	Fri,  8 Mar 2024 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709901328;
	bh=FO/2tbdfopZ0jgXfxeznKBXF2Z6rQryzkEHxQzSdob4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYOhrchCM5AcfxPJr1oIyABZAaxg9gskQp8WoHXfOeui02f9YDOiUEccLFAfpD2MU
	 EiUsJt/4PuPnbdyx9XpqQeesIstI/T4Dps8oISJ/y5AUG8qglej8saE4q/j8uFmuQD
	 MtyJSyWiCJfn8zC3DSxgZZhC3aFuUlWjbwyNJa2caxdbIUR3V6GYfzhBTdUg0iUfYL
	 7DDTDQ/azQpLSE//PcmZ7EJMqDDLBKsliYdSOxj5Y2ZCkCx0GHh5Gy+4sf/Gaq7XKx
	 3nO8obKNqOFLq8Y8riZvs/8P5jhDuqveb687JPfbxHzKcjxYU2SzHwk8DBGqK0Cm2J
	 b7zKSu+WHLzaA==
Date: Fri, 8 Mar 2024 12:35:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v1 2/2] ASoC:
 starfive: Add PDM controller support
Message-ID: <330cf044-75e2-4938-b886-ce13003d30e8@sirena.org.uk>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-3-xingyu.wu@starfivetech.com>
 <fddca901-273c-4b06-ad59-d156941920d6@sirena.org.uk>
 <NTZPR01MB0956E2033EDDA3FFE1211ACD9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PmTquCiKJJKa3CmU"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956E2033EDDA3FFE1211ACD9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
X-Cookie: Isn't this my STOP?!


--PmTquCiKJJKa3CmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2024 at 08:45:45AM +0000, Xingyu Wu wrote:
> > On Thu, Mar 07, 2024 at 11:37:08AM +0800, Xingyu Wu wrote:

> > > +	if (!device_property_read_u8(&pdev->dev, "starfive,pdm-modulex",
> > &using_modulex))
> > > +		if (using_modulex == 1)
> > > +			base += JH8100_PDM_MODULEX_SHIFT; /* Use module 1 */

> > This really looks like you've got one hardware block with two devices in it, either
> > the address ranges registered for the devices in DT should be separate and you
> > shouldn't need this property or you should have one component registering both
> > PDM interfaces.

> Yeah, They like two independent device and have different register to
> configure, but just use the same clocks and resets.  Due to the sample
> rate depend on the share clocks, they should be registered together as
> a 4-channel capture device (rarely used), or just one of them can be
> registered separately as a 2-channel device.  BTW, can I use the
> 0x12250000 about the property of reg for device 0 or 0x12250010 for
> device 1 to choose which device to be used in DT?

Ah, so it's actually a small MFD but given that it's two audio blocks
possibly not worth registering as such.  I'd register two stereo DAIs to
one component and then use the DAI ID to figure out which registers to
write to.  Four channel mode might need a property to put everything as
one DAI and not register the second one, or it might just be OK to let
the first DAI be 4 channel with runtime error checking.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--PmTquCiKJJKa3CmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXrBgoACgkQJNaLcl1U
h9DEhwf+KgApJjUr4IiU+vvCVeMKJxlSEoO7nfmdqt1/A6QTnqv6jBiCGSwpMIHx
h+m+KI68xKrBA8J2ufPN/KnCh0prXfy8vOPOccavWBg4UdDm6LHnheeZHXt+xgla
VRAaPw9XpGmW7mo2lqY4QR6lutgLIQDxIoLjzRepCFoFrTQIH2yaSqUxcakRwaFA
KfqgAyDhr+NrZSThLLoHuJjGQOVEyA8TOwrjKPnG3GVjhLupXbr6UgR3BZ7I7saf
k7zYnzW4/HSb3ACbYaHCkwL88RVCFdih43ZpIwNKgxeFpB9/FYa0ow4xk3nGjoPn
cEbVA3HKOGq0/mGsOzLEYgAc2u4Vdg==
=kMbj
-----END PGP SIGNATURE-----

--PmTquCiKJJKa3CmU--

