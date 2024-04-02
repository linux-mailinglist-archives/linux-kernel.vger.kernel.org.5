Return-Path: <linux-kernel+bounces-128472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBAA895B43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72D01F21AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBDC15AAC5;
	Tue,  2 Apr 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiZ5/jmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46960264
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080780; cv=none; b=VlbpGnwmmnETW5fZN0mmF9Av5Jus2c6Ho7OPKwveDeBqpznvCV5iZxvsOPTEajGhgO54a3adW5D0GGM2nGFJjvkp+ajkBWjfcSlW5h/OAhmSAWYEj5AEz0a6UiJNHIEG/TK78NK0JQsvR8GdIky3muvF0fRh08f0MCGeHH/lNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080780; c=relaxed/simple;
	bh=aAnQ8NHRy23MYWdUWIRo2R/tt6TJTrY0OJtZc6tId9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CciOwl6qKEek0OCHgtHyfXHu38pbrogK7hNfTVep8xoGoHFyk+lTbYLL1BgRJQM+78kWIWc0sysi7aLdjU0hV6x1dD1UcH4vM1PmBXC1xbjC7O8A2P10JKmFV6a4bEuqAD8Ge4I/UUrJZoeDbkx45s5x4bHAeydYskNrNQ0SpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiZ5/jmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8878EC433F1;
	Tue,  2 Apr 2024 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080780;
	bh=aAnQ8NHRy23MYWdUWIRo2R/tt6TJTrY0OJtZc6tId9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiZ5/jmjXQAWqskmJrA1pJgb8EgneHP6L7h29nZDOit53zR/4YUizKApVrErLwl2E
	 L3XKwmSYXzdUzkzBLx7s/UKDO22g5AcaeVwK2+TIdwyzYMfvZaQo2+kM71tm74CW10
	 cQ2rKA+xKcFsCIIn8Te/BBagrSAaEBhg81bBsVrT22dIRTlq9Ct2/vQnCkGCecjPUk
	 BwsuCR7dZTYXeVgwUG/ylsYBThyVxlnSC1YQL5dYm3hNcXjOcxqtX+OsCPoZIfTUD/
	 6Rc7NHljYOeC/7yWGd726z+f3AO831VqlEH9wDeWZxLK7Ds4PywdiisI799tlpTEPb
	 jOibQxo2ds58Q==
Date: Tue, 2 Apr 2024 18:59:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, andriy.shevchenko@linux.intel.com,
	lgirdwood@gmail.com, perex@perex.cz, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com, tiwai@suse.de,
	baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com, navada@ti.com,
	v-po@ti.com
Subject: Re: [PATCH v12] ASoc: tas2783: Add tas2783 codec driver
Message-ID: <630746e4-1172-4dbd-90c8-314cbab684b3@sirena.org.uk>
References: <20240331021458.1418-1-shenghao-ding@ti.com>
 <df80758b-f3d6-4456-8600-1a19fab75407@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ijEPnn0yQQxdDGiq"
Content-Disposition: inline
In-Reply-To: <df80758b-f3d6-4456-8600-1a19fab75407@linux.intel.com>
X-Cookie: Knowledge is power.


--ijEPnn0yQQxdDGiq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2024 at 08:50:24AM -0500, Pierre-Louis Bossart wrote:

> > +static int tasdevice_comp_probe(struct snd_soc_component *comp)
> > +{

> > +	ret = request_firmware(&fw_entry, dspfw_binaryname, tas_dev->dev);
> > +	if (ret) {
> > +		dev_err(tas_dev->dev,
> > +			"%s: request_firmware %x open status: %d.\n", __func__,
> > +			tas_dev->sdw_peripheral->id.unique_id, ret);
> > +		goto out;
> > +	}
> > +
> > +	tasdevice_dspfw_ready(fw_entry, tas_dev);

> Question: is there a specific reason why all this functionality needs to
> be done in a component probe instead of when the device reports as ATTACHED?

> Since you have an interaction with userspace for the firmware, and
> firmware download takes time, you would want to do this as early as
> possible.

> Usually the component probe is part of the card creation, so you could
> add card-related or control related things. Downloading firmware does
> not strike me as a card-related activity?

This does have the effect of ensuring that the card won't instantiate
without firmware.  Given how utterly dependent on firmware this device
seems to be I can see a case for blocking card registration until the
firmware is ready, there's a usability thing there but it feels like
there's a usability issue with any error handling for missing firmware
on these devices and not registering the card does seem like a valid
choice.  That said it would still be nicer to initiate the firmware
process earlier in order to minimise latency and then either defer
registration of the component until we've managed to load firmware or
have a check at component probe to make sure that the firmware is ready.

> Another question is whether the firmware needs to be downloaded again
> during system/pm_runtime resume? That may depend on how power is managed
> at the hardware level, but in theory an SDCA device should report to the
> host whether the firmware is still valid or needs to be downloaded.

That does seem like a concern too.

--ijEPnn0yQQxdDGiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMR4UACgkQJNaLcl1U
h9DdZwf/f+U4X2SixedyA3/BS/eEc9tIpJ2U5ZcUAdK+826kYfmYWJskaqRJvDxk
DD09WbjBKkyTg28Hs5fko/1e0SnTe+5GrjVmtbhWymSb5xE0W8m8jIupWbG0gbog
YdikYvfq2GxPiECJy18gr2qPXyO18/jLqX1zQfy886Ojg4drx+ZnMOWtFkrnM0am
c8JUsei9LDgPqAMY8fSS5f7G7DpdYd4g++6dPPZKtiOfbi0cTMn9tShwenNF+/10
YP72eG40tWXAXG3YspH4/DSvT+oAeyud3SBIqV3qnmf3sOx/b54iNGmZI0tQp9If
PxkXX+odn9YUP5taCJGf1yOCVqSlHQ==
=fLjV
-----END PGP SIGNATURE-----

--ijEPnn0yQQxdDGiq--

