Return-Path: <linux-kernel+bounces-35491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30028391F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66691C21CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246F5FBAD;
	Tue, 23 Jan 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHEA1s9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838D15BA;
	Tue, 23 Jan 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022122; cv=none; b=qB2zOg4ZJQoe36Y7H9P8A7+NLO9LwvCwpzW8xLnEOcSY6hXzsgoxsEfiOTn2K8nGW2I1XyRWG9dwWZ57h1D9h0EnSLrUD7lHyZX6EfhFhD2JS9dFkX9rnsj8e8ldkr8T5bX80KSqvJa+DCHSiDcePO2sInQoRKgifLOZSBuBj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022122; c=relaxed/simple;
	bh=3eBELIBeNx2jjMvZH92tK5Oz5R59USxyREJu/1TPfWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdKzasFZeHPHmxlPrjsCfrt2y5aGbK1UFllnqhNfzIULDkzHPUoLbDnL3sv2HxWi97lzCfudQvAM6b04c5slgYGCYxjRhxYYqJlLU/+3GccCvGWsGAGu8wMjhHeoCClf6txVd1Sp0MfnRDQIrWlaueB8qO6mOantGmln/QQrzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHEA1s9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53D8C433F1;
	Tue, 23 Jan 2024 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022122;
	bh=3eBELIBeNx2jjMvZH92tK5Oz5R59USxyREJu/1TPfWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHEA1s9kWvQ+XQzXBiu/M34apKWuU+GpHUXmcVUg59cVAOsixFtkqpirdW/PJ8hdw
	 xpAD8eI4CGCv2m8kqN0YyGjnUwhM4aqJwUw+HW0GH5q/KqmlYet2to3bs7HqCwTTJ6
	 ozmCCCEW8aMtilJ9nC3eeAkZg+6X+OxcvgDjHIUzDbauYzYbQD5wDnJ075It/qiMSc
	 K3dhUkaQNdhcA44yTSxOJWBKfg8jlyiwQua8n9T2LzqJ6R6IYVfdtySdpw2sE41Rg4
	 rPpbVEdJQYbQpExIgdQei3yMf2Vpg24eCfDDMndOYXAyj4daDpcAhssuuoKx3S9gs5
	 /a5h3zSNvDEXA==
Date: Tue, 23 Jan 2024 15:01:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, conor+dt@kernel.org,
	robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	kevin-lu@ti.com, baojun.xu@ti.com, devicetree@vger.kernel.org,
	lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, jkhuang3@ti.com,
	tiwai@suse.de, pdjuandi@ti.com, j-mcpherson@ti.com, navada@ti.com
Subject: Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml file for pcm6240
 codec driver
Message-ID: <9ed437f8-e429-4694-bffc-15931d57a48b@sirena.org.uk>
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-4-shenghao-ding@ti.com>
 <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9cF9qpcdPLhab6Kd"
Content-Disposition: inline
In-Reply-To: <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
X-Cookie: Stay together, drag each other down.


--9cF9qpcdPLhab6Kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 12:25:04PM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2024 12:14, Shenghao Ding wrote:

> > ---
> > Change in v1:
> >  - Create yaml file for pcm6240 codec driver

> I don't understand. v1 is the first version. Against what is this change?

This appears to be a perfectly clear description of the contents of the
first version, it's a change against the tree before the patch is
applied.  It's a bit unusual to include a per version changelog on the
first version but not a problem.

> > +    enum:
> > +      - ti,adc3120
> > +      - ti,adc5120
> > +      - ti,adc6120
> > +      - ti,dix4192
> > +      - ti,pcm1690
> > +      - ti,pcm3120
> > +      - ti,pcm3140
> > +      - ti,pcm5120
> > +      - ti,pcm5140
> > +      - ti,pcm6120
> > +      - ti,pcm6140
> > +      - ti,pcm6240
> > +      - ti,pcm6260
> > +      - ti,pcm9211
> > +      - ti,pcmd3140
> > +      - ti,pcmd3180
> > +      - ti,pcmd512x
> > +      - ti,taa5212
> > +      - ti,taa5412
> > +      - ti,tad5212
> > +      - ti,tad5412

> And none of them are compatible with something?

No idea about these specific chips but that would be entirely normal for
CODECs, even where things are subsets there's often some tweaks needed
to initialisation or whatever.

> > +     two: pcmdevice@48 {

> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Please be more specific about what you're looking to see there.
pcmdevice doesn't seem particularly more specific than something like
dsp, it certainly seems within what the text describes.

--9cF9qpcdPLhab6Kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWv1OIACgkQJNaLcl1U
h9DNpAf/Se74hxYh7AkTK3yij9PfZPxDMjbface6QBvRaG1iWWBqUTVkAWkey0PV
+gX+ac+2Vx6rCUlhjKfQAVUakit8Mqwhuzpjdr+0K8CyVg4O5wpwp4Wb8U2tpPmx
BD+KRVCWP4yf+XAUW2tXpohgpc3MC/Vw8qdNycWsGjj8utSsL0yj7Ezojyxsjrjz
xH3PGkIAmyedjhP20zqQtyzns/Wu65mge1D83JkV+iqvlDwGM/kTBEXWB7nkLh+n
lYX2IoTB8gxIoxRfzgBejzhN/fKh94gK9hqHV3VgnL/V6TQObmau+fPWQiwaEf6o
gwLvLYuF/eC/xNQidFJI4NAFCxdf3w==
=NJzF
-----END PGP SIGNATURE-----

--9cF9qpcdPLhab6Kd--

