Return-Path: <linux-kernel+bounces-30460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50F831EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623312845D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793A2D623;
	Thu, 18 Jan 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1DTRCtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057E2D60F;
	Thu, 18 Jan 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601476; cv=none; b=GHyzvA1vlfve3erumj8e3IJPPX5YeG6gXxECsqX5dywfvwufZP5ld/x47z/cSWY/rgy/xyqk6BvLuBqv1DRYwLw1qG6MS6Rx0x17bV1yujpD8d+Vwt18aZcSSIimt1/ENya7FreJMvoI7fxvNUnTEugKzYE8OlkOGOlcDpSxzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601476; c=relaxed/simple;
	bh=7HxfecGY7uZgdsol1Qo2cUjoPAbeDfayvo1koO5ULvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLwE46A8nCcjEB65jw/3NTD1SowDTRw475SfgecWrGRBVreC6EC2/OtmPXJWaOx/PfD+nI/hBvswvk3YC/msxydFJwz6HDtI28JirS/dVrg1QVuMraatTxXV/6jmTnZrG41uCOeROBxb2bSyN8ukugwq5kI5dGbo9uYTQ/UScv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1DTRCtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAFCC433C7;
	Thu, 18 Jan 2024 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705601476;
	bh=7HxfecGY7uZgdsol1Qo2cUjoPAbeDfayvo1koO5ULvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1DTRCtlzWHnBBSXCYXrElu6RGkLsiCfEInH0glYNuO6U5ns1lW8CHrO2gB0d49xi
	 43DYWUjn70KACnl9rExL4JOXQk1sRGqyWWHl5j6eHUa3fsBDicqSgKmSx2ME4WmzFi
	 MikB+qb43aBUK30QyHTevkn278Bo0WVDljQ87MDvBcm18cIzKorUuhGppsqm4OBqhe
	 hlmmFKj07PQIVWLdD0FmuOScqc2P0/JRY/H/9/U4dNHFRDvgVyI9qsiBhUfxMcXe8Q
	 G/m1LwKEp7Q5KYFiWdH8HF4Y5PoNyw+M8/NNFLg2Vqz5vs+kqYT6mWLyY4zCu/EB62
	 lyESpAH4u0aYg==
Date: Thu, 18 Jan 2024 18:11:09 +0000
From: Mark Brown <broonie@kernel.org>
To: andy.shevchenko@gmail.com
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
	lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
	sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] ASoC: cs42l43: Add support for the cs42l43
Message-ID: <aec96f5a-b759-48c7-a5ec-bafe3bfa5357@sirena.org.uk>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-7-ckeepax@opensource.cirrus.com>
 <Zali4qxdegY7H6eY@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="97E1gLHhLegY+sZD"
Content-Disposition: inline
In-Reply-To: <Zali4qxdegY7H6eY@surfacebook.localdomain>
X-Cookie: FEELINGS are cascading over me!!!


--97E1gLHhLegY+sZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 18, 2024 at 07:41:54PM +0200, andy.shevchenko@gmail.com wrote:
> Fri, Aug 04, 2023 at 11:46:02AM +0100, Charles Keepax kirjoitti:

> > +	unsigned int hs2 = 0x2 << CS42L43_HSDET_MODE_SHIFT;

> BIT(1) ?

Given that this is writing a value into a register field called "MODE"
it seems very likely that it's an enumeration value rather than a
bitmask (and similarly for all the other places where you're making
similar comments).  Please think a bit more about the code being
commented on when making these minor stylistic comments.

> > +static const char * const cs42l43_jack_text[] = {
> > +	"None", "CTIA", "OMTP", "Headphone", "Line-Out",
> > +	"Line-In", "Microphone", "Optical",

> Better to have this by power of 2 blocks (seems it's related to the possible
> values ranges in the HW).
> If it's just a coincidence that there are 8 of them, perhaps other (logical)
> grouping is better?

This is probably well within the realm of driver author taste...

> > +	// Don't use devm as we need to get against the MFD device

> This is weird...

This is normal, the splitting into subdevices is often a purely Linux
internal thing and not represented in the firmware description so
external resources are linked to the top level.

--97E1gLHhLegY+sZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpab0ACgkQJNaLcl1U
h9C5DAf+O6KGhhljQY7I80+eSBdyZV5AJMoCpfMru36z4haLJoHDqhn+67FC1yql
1n/AnyJAp3Nl19jHZ4inj+wTpH5+NR0blMMfw0R9FL7jpzbq7b6LgSC+hqfi8vDS
nY2R6zSnnnOm3HxpKrbxFx82jDnVtZumBuJbfW1kL8tJC52DBVDLOpiY+mPpd4jh
OUNcrgsFpw3GMcX6GapLflbfqYRvP8BIZtfhYlHkjRiO/aj9THItdd31GnAOzFpK
R9hyiVdneKaNBHpvRv+XVI355y3eDqACVK6L3ERBXMHDAhXZnBP/n8J/sRJxARn4
MTeH+5L7hG1IzL3kXWLBUbTnfJl+Hg==
=mldP
-----END PGP SIGNATURE-----

--97E1gLHhLegY+sZD--

