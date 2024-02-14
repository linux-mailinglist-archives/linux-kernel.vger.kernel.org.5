Return-Path: <linux-kernel+bounces-65189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39A85492B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F371C20EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0921BDD5;
	Wed, 14 Feb 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY+W//+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413C1B813;
	Wed, 14 Feb 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913502; cv=none; b=db58AvSrT7m0YecBxKdl9LklxN5EGht3L7dd57fRSEyoO12eOVv7yFnaZKVhT7j1kg9imzlLnMivihZCoMKuf+HXv3+sEYSvKOyAi2rKcQnJU8bgvntsbxnDXi/h0lRI5YuLdjKx31P9sAysW21Sy0zQ9pQ/MNdKCJAVshIaNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913502; c=relaxed/simple;
	bh=om12AIRXbhoBkX5ErV9iC57tbcp9qmnO+XHs8NR0XaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pst2ZP/FPvYwsprb52cDBfog4IkNVroBsvoWQ+tHZOyg/vcWcfsGrMVFKkLO48yfF+vcSbnfwlodr2XL2bYyiwzf6O60SvyHVfxif/kyKwTOEs1+Hyk8nSg4wpQs6Ac8s8K/4MotID3cu0HDLrejUMAW1RYBAimDoDY0MpaB1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY+W//+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18DDC433F1;
	Wed, 14 Feb 2024 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707913501;
	bh=om12AIRXbhoBkX5ErV9iC57tbcp9qmnO+XHs8NR0XaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sY+W//+oR5pT+WqLTp1mUjOaDEV57w6AM2zyTU5R+puNv38dmMoH3d477WwuHMWCc
	 Byzg4+kFesYaTSSssDgxb+3kjerABcZ2lY6PXSEIQE8Ag7sRhypfakz6Q8fTRn6Yok
	 fzK4Cw9GnU+bUQrxxMnq9eJ9B2URNGFJbpEOC8xCHLyzw/1SsYyVAXsnK24PMJUsae
	 rN9i3eNBbqJ1OePuJ7qeOah1liQQE6RbNN0+0uYBxP1iF8ow0YivnQZ9ZT5+kHFZnc
	 juE1ksU1dgDn4v9IXyAHJ8M/sicz3YNjb+9nW1koJPEhZMeEmeYcy4VOdmLNsUvCno
	 ZwlOG9l8DAwjA==
Date: Wed, 14 Feb 2024 12:24:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Message-ID: <aa707af2-b0ef-46de-83ae-584756d5569d@sirena.org.uk>
References: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7rTl/oWJRMeE7uX"
Content-Disposition: inline
In-Reply-To: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
X-Cookie: Available while quantities last.


--s7rTl/oWJRMeE7uX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 12:10:06PM +0530, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--s7rTl/oWJRMeE7uX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXMsRcACgkQJNaLcl1U
h9AUYQf+IoYLzVMnh8iw5Nit64An1Vh3KQ/uSzayMzfztETr+85K7EGJw6RuAuEF
X9XXAgq5jPkq4VvN57Urd4ieIR4gajNsEoOk09cM3w7hYF0UNk8BcnX1LF/c4/JZ
+ItbXiyPZUNXGjHwi4IEoMK1g0Og6Y0B7lSwTb+bYV0NYTu1LIZytwpYQEBeXRGY
g5dm+0Hh0dzJ5yAT8zT7PyoxMaHmNB7lHU9v0RYtSVbj7lg836C3uI1TM8TllMMZ
afjmEjNPP7I8eCI+X8NzorvWLi+e0CwHvI3SZnZoflcGhuxQGlGNPPtdeT2hmFq5
hrT3azEJn0Olq8RI61G+QCJK9J8ziw==
=dEZg
-----END PGP SIGNATURE-----

--s7rTl/oWJRMeE7uX--

