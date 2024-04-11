Return-Path: <linux-kernel+bounces-140445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0818A14C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49A91C22AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65B1426E;
	Thu, 11 Apr 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtKwRLtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346123C9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839072; cv=none; b=TVV57MXtrz137dmSKFfSH58Zui9Xch7CDxobxxUW6G6uvywKqibHCqIPBKkxplS8IOkedl1JHjXhC3lapcROh6ruM3DAo2XVmr3MY9P5S2Yy8Nx1gZUXjEwBzeIqT+ibKJ7IE9uiRl0QxHU/KhyW5hPY1OmUHyo1oAkZ2Ub9mEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839072; c=relaxed/simple;
	bh=m2L+op0Kkoe+phNEu1C3BJcAiPx7d7cpTwNj2RlDiRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7OHUPeSqX5lJBlFv/2DC1+Cjbeew2G/N1JpACbhd7oBUVTUYmDwOGFOGEH5xM4Qjd75PAVz2OCmn+pjrrSvlTlfBzWB8tdsk3Z04eheeI/8PaiaNJCzDP4anBw2XmGvMbx7k0+UC1/59uTz3hQwLFxiyGrrSFu9TkOhAtCkIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtKwRLtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC0EC433F1;
	Thu, 11 Apr 2024 12:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712839072;
	bh=m2L+op0Kkoe+phNEu1C3BJcAiPx7d7cpTwNj2RlDiRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtKwRLtTD8Bmu6A9tmCE5Ow4HzY0a4UQoFq3uclxkZBSzQkaX55VXGNgy3Cs/DDab
	 7qs9/v2EWRqCEabiMPKrfpWkbSBrGNr412+3PvECXGUlz8bUNoUGxQ9ni2sbVSIydL
	 LWOn+k3sjF5jkTeqNCfs8LBukyTNvmwITAiCfKcZJ+HIujmmA5oJWn3sZj4uONcpCJ
	 vVxU8dYCponhD8prhsJwSQKDlP2f3ublWDg7H+1a6iEbAfenygxUgp95SsLud3BAlB
	 DgsQyq+60W4lqSUZN9w0jRIz5ksMwJwIho0WRLfp4P2tKGJzwPoOaYq1AINnkVRLYt
	 J5YyMY9obpKbw==
Date: Thu, 11 Apr 2024 13:37:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] regulator: pca9450: make warm reset on PMIC_RST_B
 assertion
Message-ID: <243d9eb2-aaab-4ede-bd07-aa609b5d149e@sirena.org.uk>
References: <20240411100138.366292-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jelawFKf5YS58UF"
Content-Disposition: inline
In-Reply-To: <20240411100138.366292-1-fabio.aiuto@engicam.com>
X-Cookie: How come we never talk anymore?


--/jelawFKf5YS58UF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:01:37PM +0200, Fabio Aiuto wrote:
> Hello all,
>=20
> sorry for spamming, this one have the correct email addresses.
> This patch adds a property for to control reset behavior on
> PMIC_RST_B assertion.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--/jelawFKf5YS58UF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYX2ZsACgkQJNaLcl1U
h9AIewf/af5lIxAuo8svECUUz78FRn+sMaZmYb4kf3bqiGDTVPDPRQpiPMSiwBxG
7w34gWFZ7iMS0g7MoLOz1UKDt5DLWlVvyVIssO/2Wc5x6a5elZzGthi2o68ikt6z
pWfHJj/92g4fuzg16qg/7maA+wSEVkMjVGPY5EW9KnP/CfMDuiuDCLKOtalkxQNy
uXHh7bFCfdhxUUQFB8IKHW8GgmVHDBhiCox1wH7BHb9RcDg0KMvuMZVRaP4nVlKK
Pp/CPz3mlonYKglHcC6ffJKqEKxoArdxw4CwPW1VwBYm2u8HMyaESOJbrNS/qwZH
HtWQ7P4sS7n3N69+TJgvU5MoDx6t0Q==
=BQ+u
-----END PGP SIGNATURE-----

--/jelawFKf5YS58UF--

