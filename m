Return-Path: <linux-kernel+bounces-119293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A888C6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A51A1C2656A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21A13C82C;
	Tue, 26 Mar 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzKRe4NW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CC762F7;
	Tue, 26 Mar 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466493; cv=none; b=UqZI1dFtXoFL6jvn02pbpSJEyE7CTlOJDx8u9aqFmbDbc0zKMNJp8tw3JsAzkPxAGFFis5zB7IzPuVn1nbVyGQ49WbExlxYUmdc3AN9zGzDrW5AdRKMyTyHvRfbUWN9RkU8TvQtG8yv21q4uAx8l0NKHPS5IDXBORnY/Ipwv5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466493; c=relaxed/simple;
	bh=Z2nHEZxxs+vahFJw6w8Vrrmei2z4FFUD+zEzVpaw5H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnBYI5n/i496G22Kcww7POAct7ytUam22y6b0rix48gkBIvc61qPFn2QyZJGGcH3x6FJ7EznaPEIOnqxuX/Wtc6rwwZP5bCCmhnaTYShFiiNpk2oWfBTEzIFVH5Go7yqjwbs49voa4ScLS/fFz3I2RukuNYK+3UgioTsfEi/+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzKRe4NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2A0C433F1;
	Tue, 26 Mar 2024 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466492;
	bh=Z2nHEZxxs+vahFJw6w8Vrrmei2z4FFUD+zEzVpaw5H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzKRe4NWAd0WBGd3bYApx7sOogsbE54S8mOwV6Af4JKl2jjrKrgQRwVFjAGNsEhDN
	 577OdUlsy1Z5OY2vDvpWKYDA4okOPVLMaP5aYewYOt0+MEkPY6b30LImOlbdiVTITc
	 unXDkDWP/VtD4doN6wyf0fGRfPKJbYaOzG3gmKDhv8PWdejjhobwNmo7VIFiDYRc+J
	 r0EacQyeYsYQzmsmT8hKD0pValaHKVRxGLE7Pa28gTWnG8EPsKQeM0OVefWaB/BRRN
	 QnhVUwYH2fKu+u14hIxE/FlMTjcQLU+0qsJV0yX6p68XUP3F0K3dbf8L262vzfOt0U
	 6y2ybQMMQwNjg==
Date: Tue, 26 Mar 2024 15:21:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/4] arm64: dts: imx8qxp add asrc and sai
Message-ID: <dad6304d-c409-4434-9e9b-16f03e781e87@sirena.org.uk>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
 <ZgLYOYFRxVqK30Z1@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7b4Cs5shdIaGWwE"
Content-Disposition: inline
In-Reply-To: <ZgLYOYFRxVqK30Z1@lizhi-Precision-Tower-5810>
X-Cookie: Equal bytes for women.


--e7b4Cs5shdIaGWwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:14:17AM -0400, Frank Li wrote:

> @Mark Brown:

My name doesn't have any @s in it...

> 	Could you please pick dt-bindings part? Reviewed by dt team.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--e7b4Cs5shdIaGWwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYC5/YACgkQJNaLcl1U
h9CGKAf+Pm0HJdpSvyWxG+K+cFCY2Bt4R2RNbiJoWTL2Ji/dAH2dpykqW0T7UdzM
r+rOBinegJxI0D0oNN+eMFK0S41gAfLxvjaKxA1QaeI1OeXPeIJcXDY35qBzQ6q7
V/MwY4qEFlpHpfRH41N6ukr+dVeZEsHnlcCVrXV8FZme9QGqqM/cOKQbwjF1o5f0
jkJUngWn1gpW8q00yQVil5knaPuTaqgKWsxGRUDbyk0JnQU1hhlm+yuafuSJXEjd
NbgyqT9To3lgbWCHxIHsLZg/1mPXjJduCVp4Vni8yc5UzVwTlfYBchuTSJi/VHJ/
Xty0wzuEvt5P1OItoKouELfONb1gaw==
=uSpT
-----END PGP SIGNATURE-----

--e7b4Cs5shdIaGWwE--

