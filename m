Return-Path: <linux-kernel+bounces-143629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A588A3BA4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32069284207
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F91CD2F;
	Sat, 13 Apr 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgaV4HXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5D366;
	Sat, 13 Apr 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712997091; cv=none; b=Hy2FI1gcBwnL6XygNuBa1RuqA6ZFnDfbRGedwhEj6J+qKtB4JtaU4K+5wihj+V0KS4RLbeACt5NbR5ozER5+mop3PVo7XfYbXxSBkHbTI44CsCQ5RgpbynohuzlVeHMNr6oJr7SsOEo2LpVPjV4jj7nXVz4Micfuu7SoDu077EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712997091; c=relaxed/simple;
	bh=w6tHrbN1gz8u8i97H3GIjGJiI9OQ0hR78mrZ/VG0kxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtb17zItJ0s50wu2xmgATKV+DGKu9mztM+tpXU2woSHEX2UsVdcj1ACqLKpLVUK+vOEHOTMB7gdtb2eaVm9Tx3nD7FOhEcdVbmX8dVQj5HN2unltEpj+lM1wn7ljvBzf90e318EvWmM3k6wdX1vYUkXTERgRoBQdYhJn2MpaBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgaV4HXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B354C113CD;
	Sat, 13 Apr 2024 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712997090;
	bh=w6tHrbN1gz8u8i97H3GIjGJiI9OQ0hR78mrZ/VG0kxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgaV4HXvxve3UF+GtV98mQHdGZ7EEMp5Hop9ByvaIEhtxSJ8SnBLVHkq6mJMiQzwi
	 5Gkmb+vqYgr/cseLJV1slxzTlzm5dttUCI4TXKx7JKKJZLZAr+nbHbE7cS6zEiQoqP
	 BCMRJG8iFLvJ5TWB7kQlie2F/ZcKUipD7oGD5Co/OAfku8uRp64mfkRNuLXPEAgTAt
	 0jmcSAmVgmuK0QUNBCEqJUSEU0nHBfwMBrvpgNsaLUt/Qu5CtopbpgSH2rixOSFcMN
	 +pPu+7SKi8elreNggLXmf8bMoJtws67owjDGvNBxKcyrG4IGbquLiiGV8o5ALZ+tZg
	 nIDuowKaSG49w==
Date: Sat, 13 Apr 2024 04:31:26 -0400
From: William Breathitt Gray <wbg@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
Message-ID: <ZhpC3lLD-BHqJEZz@ishi>
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d/IvkqaW6ax31Foy"
Content-Disposition: inline
In-Reply-To: <20240410072102.1200869-1-andy.shevchenko@gmail.com>


--d/IvkqaW6ax31Foy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:21:02AM +0300, Andy Shevchenko wrote:
> Convert driver to use memory mapped IO accessors.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: William Breathitt Gray <wbg@kernel.org>

A minor suggestion below, but I find this patch accepted as-is.

>  static int sch_gpio_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;

In general I think this is a good variable to define to simplify all the
&pdev->dev appearing throughout this callback, but I'd rather have seen
it as its own patch so we could change all the other uses of &pdev->dev
at once without distracting from the memory-mapped I/O change of this
particular patch. Not really necessary, but maybe at some point in the
future a follow-up patch doing such a cleanup would be nice.

William Breathitt Gray

--d/IvkqaW6ax31Foy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZhpC3gAKCRC1SFbKvhIj
Ky0kAQDUwdQ4ta2t1mSTRTCD2R1i1TroJSyem81dRGJsBgFClQEAivISTvpcs3gq
w5sOoWbOz8Ij4TChn9SnPje/ioR81w4=
=MCt1
-----END PGP SIGNATURE-----

--d/IvkqaW6ax31Foy--

