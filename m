Return-Path: <linux-kernel+bounces-97146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B1876613
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902D21C22681
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483AF40862;
	Fri,  8 Mar 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI24qi44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8638DF9;
	Fri,  8 Mar 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907153; cv=none; b=F4QKv6my9nqyDFW6q0+76/miUI7UFJIRK6fUSk/rjIVedES5jIfn6xfxrVktzWeaPIi/un/HxbQrId+erB0vpqRgXZFncjvchomFdQdQhE+xpelcuYFG3BrheLfVBuMfdqvW1Tu0VuIm0h8WTZp/ym3M5YHIS9XbsOql+ooutcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907153; c=relaxed/simple;
	bh=E2jQGhctqhdTeyf9K9GCx+OjkomQmjygegGT1CBBREQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pqmh757ofrQvYhVFv8Z+8etd+Dai0Kqih2oNhJ84wfptvHOQ2Y1teUr9T6H7AzJ9oh5Yhbqcpun2kHhYOfrlDNODMUv9Xc6dNV3yeAsWn9cZLDgWgbfS1mdL1CkMfC6qENdFEofO12cb5LolfSvkLfyM/nFrlxVMsXnPl+7AjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI24qi44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B52C43390;
	Fri,  8 Mar 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709907153;
	bh=E2jQGhctqhdTeyf9K9GCx+OjkomQmjygegGT1CBBREQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GI24qi44A/VKrjHaZyry5snyO4/S802K7VYlZx5PFgC7N79guUAXhow08Urp7MUAK
	 ByE8lXVWDynmqBRDBgcg/wTmFHls89Nsbatq/i9pifile8ZwwfDSBJdF4Bf55YE9fh
	 EuHcsPsvO5TzB/cmJW04FgYGCJ85bffDyTvDmR5H6HxfDE2lO5aD2uwg1AvenRILIy
	 wnUEEKlLysKL06eTY27BGRD2qLD2eTxah7JGI80+QvEnlQ3AlxMAcjRJhnUVgmJwHg
	 GR05l60AYWnmAW1L0gztoN+bUZtf1y9dniOxOk1/GPl33MMBTUXX3bqEGBNI5SdXRt
	 01DmTSJSzzDGA==
Date: Fri, 8 Mar 2024 14:12:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, hdegoede@redhat.com, lenb@kernel.org, rafael@kernel.org,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs35l56: Add support for CS35L54 and CS35L57
Message-ID: <275d4e66-dc76-47cc-9681-e60b218a8cc7@sirena.org.uk>
References: <20240308135900.603192-1-rf@opensource.cirrus.com>
 <20240308135900.603192-2-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UB2zcriJOOZ1VYZ+"
Content-Disposition: inline
In-Reply-To: <20240308135900.603192-2-rf@opensource.cirrus.com>
X-Cookie: Isn't this my STOP?!


--UB2zcriJOOZ1VYZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 01:58:58PM +0000, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> The CS35L54 and CS35L57 are Boosted Smart Amplifiers. The CS35L54 has
> I2C/SPI control and I2S/TDM audio. The CS35L57 also has SoundWire
> control and audio.

Acked-by: Mark Brown <broonie@kernel.org>

--UB2zcriJOOZ1VYZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXrHMoACgkQJNaLcl1U
h9BJNgf/col+eBURywhfhU3h5mWvgk9QsAP/3Q91Vw+e7Gs1iqslPA8VMZ8hEEpl
ju6worO4W2byKRApwSBWq9otMb6RHqliZPejYB+CYMjEmd4dGMYN9a23NXDGE/Kh
0naRleJyq2sT3icE9dkxYav2I3wGKlekSgnyKeO214cm91kdfA3YrOn1ahna6Wrq
dZQagOFwx7/Vg33BBzOvMpbaVMtAQTcTcnk4QhaLQbOJG4tezTQHXKis2hnHDOsI
ah1fvI3VC6nUIZDGEIZPb/Hmi3+gyiWrPyH2jmj3wUg2bacHPHJHYCxjIt6AOFKx
H44hhHYLhLuzmJXgiVshJBxdsAwHbQ==
=kY3n
-----END PGP SIGNATURE-----

--UB2zcriJOOZ1VYZ+--

