Return-Path: <linux-kernel+bounces-33603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99A836C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EF31C2653A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF25F861;
	Mon, 22 Jan 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S52r1pOF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A875F855;
	Mon, 22 Jan 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937444; cv=none; b=Bs5J7LLX2/7W5z6xVdpvYq5SYFWz3rZdR/HzLTbvj13nRc83lrPgAcY0ArZpBjFnPF3C8ravwo+vaVbjhqUPkBTgTIJQBlNi7rl6+QMpPKO1we8EjsoKlWe33CxqxAN8PB8A7tCOpBIylTud8Wfb0hGzphjjf7mHQDOJO8FbjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937444; c=relaxed/simple;
	bh=9bNnmiH+8UI1sMbYl/o0a2aQj7h/T4wML5jeK7jIfLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR/RLavcNTy1aAvzBQFJqH8vSdt69qgASqJyxKRn9PaxA9D/3McmGQJ9zot3STZsua3o5dLDavMeZI38LSjFd/12xBaqS6Vi+wq3OK1qfBklX3A6ykAbM5D7pncPfqvbP5FN3hHLRZX4H6ZOfNA6kDKvs4J50n+NG/AUFMkKOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S52r1pOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5FEC433F1;
	Mon, 22 Jan 2024 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937443;
	bh=9bNnmiH+8UI1sMbYl/o0a2aQj7h/T4wML5jeK7jIfLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S52r1pOFucH6amUFrPplJzUJA6WWuRXyKAGFvS3vhC/9FwYKOleIqdsBF4eyNfcFq
	 0qGr2So+fGdTUMug81HDddK6ZtJvYO3xypBdB/7/gL4XFXSiakdzN+6E9C1Qi88OYR
	 VLBpGvgY6P9HPDjtqbqtmj3nDT/Ftf1QIhJ94f6fRa3y1yhqvb4iFi2087NMwpBKGv
	 vG/Pinz/+zkgXBRgu0Y9WxRYGTXPrGdu62k7HMTpWDBORZzJQ/WK/lokZeiH1IH7Jf
	 y0MzwEYO1VikY+zMqnmaMc1GoqIqJbskbhzSeBtDTmnOkQ4eItDkD64A0LwTOIr+7H
	 La+MUVN7brNjQ==
Date: Mon, 22 Jan 2024 15:30:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: soc-core.c: Add "Unknown" and "Unknown Product"
 to dmi_blacklist
Message-ID: <e90440a5-587b-48b2-a61f-0800aa8200d5@sirena.org.uk>
References: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fW75YJszql3fWvoQ"
Content-Disposition: inline
In-Reply-To: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
X-Cookie: Poverty begins at home.


--fW75YJszql3fWvoQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 02:44:43PM +0100, Daniel Abrecht wrote:
> In U-Boot, the default for DMI vendor / product if not set is "Unknown" and
> "Unknown Product".
> See https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/lib/smbios.c?ref_type=tags#L272

This is still corrupted according to git am unfortunately.  I can't
immediately spot the issue.

--fW75YJszql3fWvoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWuih4ACgkQJNaLcl1U
h9DY9gf/ZxevJ0vqxtuKyX7zMqcY/z9pxHbGxT9P47qpYQ+dcc+1OgwcB1ARTZuL
wyqDn2q03F+F04rgu+clhRVmtfBAEY0IobyVriEw+bY+ZUbJfQQPdoDQ/7fAsoEC
GQKPleM1i9KhdQc0/mIS1VN7x5yHykY0z7uj6BaEZo5fHig8gTMHBwGHXoQoXE2q
0TNTdsjgJZutzp2TqvjJg9phemdm5GzMVgP5vU8xvdynE/yfoczVTXenE0C0DYfH
UNNYhSlZbKse/oiTAlC+1DqAMrhfLiS6cZjBQOfCMwOLMmOZv87RW44TSQ2wbOIl
hOlaIZWxqG0Ssic1J70qYIX8T7aX1Q==
=32Ep
-----END PGP SIGNATURE-----

--fW75YJszql3fWvoQ--

