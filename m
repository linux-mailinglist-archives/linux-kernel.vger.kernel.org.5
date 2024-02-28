Return-Path: <linux-kernel+bounces-85032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738786AF61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF331F26EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DC36129;
	Wed, 28 Feb 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPcLjgwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D44149007;
	Wed, 28 Feb 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124390; cv=none; b=ib0IND006x4qELUYpYlTjJlXmMOp9FbSFDvVfavqM1aWJ0VuauD3oIuRylbmikcszpkLW76I9lwDWvb6DoEP30Phm0kb+EIpgkwjEbZolVsBeSww9XzpXixIM10a0joH1iYen9oGPlJXCOfSWhXpL6gOnCk/CQk/QpHDlkXNeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124390; c=relaxed/simple;
	bh=1H9kccDHQCzYAaTfhJ05GmDsCS9f9LtMjtfn/v0Yy1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMZ2YILTpEisW+ArdKHoERg03xmR5HHnIpz1jSf1ZjXdNeRpMQNtA3LuaQtckfCdWX+Nhm76h9FAszrrld/hHQ9IdbzVGpNr47LFmSHAgdRbYiLkKOLUNtP5L0GlD389UvDJQPs2bMy+qLtQDxa13QzgE3gTu3gwQfLjOu49xww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPcLjgwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1A9C433F1;
	Wed, 28 Feb 2024 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709124390;
	bh=1H9kccDHQCzYAaTfhJ05GmDsCS9f9LtMjtfn/v0Yy1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPcLjgwFjnTuH8n7kmTsjPbkb8cIYTeD7UvauyObhkThzKBxr8NZ0+eYD1uuDnxQI
	 GCqfiVBB+2pGa8MK+I7MJOoqbUgpsMisWpbQM7PaploTtVZGrR/cwl7Ls0XtAwPJk5
	 J+dg2yuaQ3g7dxASD3LMJ2cwYRPtJvNEb2forj9IVC3Ne3S3PeT2xIn4LFQ3venzTS
	 S7iaSBzB+gbQmcayGPUDV/50ksebulhnGzawfKYBSQynvq13B+OjQj2HaEb0YnTUqy
	 b9+u81bDcjIe8HGG6lDEZ67bNUZLtGU54cjvpa583ycpbNZGGEnG+hGFTFxV6Cx5S5
	 YzdrtWZJgOlIQ==
Date: Wed, 28 Feb 2024 12:46:23 +0000
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"Chawla, Mohit" <mohit.chawla@ti.com>,
	"soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
	"Agrawal, Manisha" <manisha.agrawal@ti.com>,
	"Hari, Raj" <s-hari@ti.com>, "Yashar, Avi" <aviel@ti.com>,
	"Nagalla, Hari" <hnagalla@ti.com>,
	"Bajjuri, Praneeth" <praneeth@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/4] ASoc: PCM6240: Create PCM6240
 Family driver code
Message-ID: <997ff4d2-e349-447c-bb21-5814ed544c30@sirena.org.uk>
References: <20240223123809.503-1-shenghao-ding@ti.com>
 <0cba2632-5d79-488a-9eec-dbed4208971b@sirena.org.uk>
 <3e0ebab7835040ff81775f43b71d3b99@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJdU7/5Tvhn9HdVp"
Content-Disposition: inline
In-Reply-To: <3e0ebab7835040ff81775f43b71d3b99@ti.com>
X-Cookie: Function reject.


--pJdU7/5Tvhn9HdVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 04:20:16AM +0000, Ding, Shenghao wrote:
> > From: Mark Brown <broonie@kernel.org>
> > On Fri, Feb 23, 2024 at 08:38:04PM +0800, Shenghao Ding wrote:

> > > +static const char *const pcmdev_ctrl_name[] = {
> > > +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
> > > +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
> > > +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
> > > +};

> > So, I see why you're doing this naming thing for the per-device controls
> > - the device can (and is designed to) allow controlling multiple amps with a
> > single I2C write.  However this is resulting in something that's really awkward
> > from an ALSA point of view, the names that are being generated are very
> > much not idiomatic for control names and probably aren't going to be
> > terribly meaningful for end users since they're not associated with where the

> For only single one device, all these seems redundant and makes uncomfortable
> Many of my customers will have such cases as
> Four pieces of Pcm6240s and three pieces of pcm6360s in the same i2c bus.
> The chip name can help them identify the chip and set the right chip and the right channel.

The problem is not with having the names, the problem is that the names
look nothing like how normal ALSA names for deduplicating controls look
- normally these are specified by the board and are human legible rather
than based on the numbers of buses inside the system.

> > I think it would make sense to do a version the driver with no user visible
> > controls (or at least none that need this name generation stuff) and then
> > make the controls an incremental patch, the driver would obviously need
> > both bits to be properly useful but it'd mean that the simple bit could get
> > reviewed and possibly merged separately to the complicated bit which would
> > probably be easier.

> You means to remove the kcontrols first. After the patch was accepted, add these
> Kcontrols, right?

Yes, or even just split the controls out so they're a later patch in the
series - no need to wait before sending the code, just sort it after the
rest of the driver.

--pJdU7/5Tvhn9HdVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfKx4ACgkQJNaLcl1U
h9DIdgf/ZMgewU2psT7+ur4bSYk1sdzqGAc5+UgL7TBgfbOMz6CRfOq32Kr9X5tR
gTYRbpTVOj/TOHLkscgCiXgilcrO8YXet1fWMoil7k9oz/ljzekVOBZnndTpEb4V
cMy+l40tv6Zbslj8GeP2d2M5MVjtj8O+W14ZzdYqkHeQb1fQQ4wrLUIWgMwFzM/X
G0/qnbQZ/JHMyo0NmAs/ZkZJtOVZAZCGxTSe8nk+C64eY8v8HYeLV1naD5rblv44
oKy5VIrQNAFUJbSvZM+xUs8FEQcIoUkLMCytGpSvnxDM8QmYoSaJNk7ksFtnsn/Y
b6QAtKV79tfssTO1HMFIu2ZHA5OY6g==
=srzX
-----END PGP SIGNATURE-----

--pJdU7/5Tvhn9HdVp--

