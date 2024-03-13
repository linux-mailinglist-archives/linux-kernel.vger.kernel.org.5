Return-Path: <linux-kernel+bounces-102111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39B87AE81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7BBB23985
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B85F546;
	Wed, 13 Mar 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsqKwqt2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C15F557;
	Wed, 13 Mar 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348792; cv=none; b=SKtnoZOyop4clDatjcl3Tak1HTpQg+Rs0ZJ429qjOpGMb+uLyiIiAHcImBeoNzilVCa44Q07klbP3b25SA+p3bHYM03h678GEUlDvJpC7eW5mMaahyfbtq5fenZL/hRCNFZhCn7qHeymEPlMQlT0mB81bV1camWALgtGwClq2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348792; c=relaxed/simple;
	bh=X7Pxz4+oG0mkqi1vhEQ+DDFougwE182gfrJARjrE8R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS9zUCNGm39YwYOXHxwQDviHdp6mViPtwpuqP2Mx0vPN7QQYJc/lCN4g7PRBul22hvgXHPOz7hbPKGTDqEWkdChnm4Rob8nAlOyaZ2OU/hOoDWCspXx0pdBVezhP86ezvqmvV1zupdupT80myv0sPf45XFXnrdeCN2Ex1m0r49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsqKwqt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B14DC433C7;
	Wed, 13 Mar 2024 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348791;
	bh=X7Pxz4+oG0mkqi1vhEQ+DDFougwE182gfrJARjrE8R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsqKwqt2uV1HHzKvZ02nLItzn9Ox/2Is7XMq2JKUWiJXOTlR0tZTBj4lpac6GBKKY
	 E8cORKtK4pb6qyTuCka7C41mkp0WpSzkDMVKcNESewfnR0BMG79PmtO1VYE6tsszMg
	 cdYtdm0vQzo1QTRMx/4DUWa2QiXDlSB0gAZ5rzf8pe/sDSJ/melDHp710j9Rni9dq8
	 6b8myYmV6ObYy5+mK8tw0pfhgWuBxH7xLiXIoAa7AJQIminQtmd6KSTV+hdEOIVGEo
	 Kh13dghb5LtTlbirFONXeYb47sE1DpmIHvk08PqpvA2Y87oorNi92wlm/Q/rdxhOsI
	 UsshN7lFTZDsQ==
Date: Wed, 13 Mar 2024 16:53:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Maxime Ripard <maxime@cerno.tech>,
	Robert Foss <robert.foss@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5.10 69/73] regmap: Add bulk read/write callbacks into
 regmap_config
Message-ID: <9e91bcd4-672e-42e6-b65b-116ebe59e48e@sirena.org.uk>
References: <20240313164640.616049-1-sashal@kernel.org>
 <20240313164640.616049-70-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2d2HpAKGhERMDEtt"
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-70-sashal@kernel.org>
X-Cookie: It's later than you think.


--2d2HpAKGhERMDEtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:46:36PM -0400, Sasha Levin wrote:
> From: Marek Vasut <marex@denx.de>
>=20
> [ Upstream commit d77e745613680c54708470402e2b623dcd769681 ]
>=20
> Currently the regmap_config structure only allows the user to implement
> single element register read/write using .reg_read/.reg_write callbacks.
> The regmap_bus already implements bulk counterparts of both, and is being
> misused as a workaround for the missing bulk read/write callbacks in
> regmap_config by a couple of drivers. To stop this misuse, add the bulk
> read/write callbacks to regmap_config and call them from the regmap core
> code.

Also a new feature.

--2d2HpAKGhERMDEtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx2fIACgkQJNaLcl1U
h9BiDAf/fSiXPCsLhNHOIcgqy+gARP/v0Ap9bHyAWiRyiRAjfmQkBIHth00VZkj2
aBpx153wHccVpwXhJzzyvY4hVhNWC4LdNVMYVy5jZvirIoWe6X8dKq1JpGlFgvcf
LfK8u863zJbCVX74dd+ZblzenBXCeWNTbSWPRbB9BV+zmxDkonNha4lpfCOZSCRi
A+8Uxbko0GX3v/UXuQmku8aqUWMgzYij/hON9XtyIbO21iE7HOhJoD28rsoukG1P
HE0JuPdEzMKq6UOz+y5xkji/g1b8/y9GyqvuMzvEbS7UPEeEizjQs1NAqaqUIIrm
Trtg26srCNO/obAgPKP34g6zOMQLdA==
=DIkw
-----END PGP SIGNATURE-----

--2d2HpAKGhERMDEtt--

