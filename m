Return-Path: <linux-kernel+bounces-129840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CC89711D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7160DB26087
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3A0148FEC;
	Wed,  3 Apr 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjUoT8do"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427A1487EB;
	Wed,  3 Apr 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150984; cv=none; b=pjoaG+MQyIjbnnu2z3tZciD+9hNXEaaeooVL4OE3xMyDaCe9HuNFlV+JLuM4HqGTV70HiEpBfNE0xbxgFkFpyaKvrHSbkiAd5PS9cnvYi9cBiHG5p8JO6fuerrMDNCGrxCl73YwCRTgmuKnGjCmpUBMdfj6KDb8YAaiLVRTMKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150984; c=relaxed/simple;
	bh=yCfc4jjAAOPfzT5/WSLGgG6RBpYO+DBZSoLbwBso14Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsssZWlqJNTtqWM/oI+Bl+3/7z/ZKVmW2PpNh9wXf/cEpGpRg+wzZu6OV+Fo66XCD28V4aCZU3Nd7W6rlGxEkfoQ5kcr83qEIXkohGTd0fh0hjwWSpoXTvFaSky+NQ7u+vT4if7+LcU1g6TzW7HHmtZgHXvbAr4GKUpLKx44hCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjUoT8do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F63DC433F1;
	Wed,  3 Apr 2024 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712150983;
	bh=yCfc4jjAAOPfzT5/WSLGgG6RBpYO+DBZSoLbwBso14Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjUoT8doe5+WFWVHkIAPjhZOkdw5rnT80mTl+Hu4v+J3+4TFnlTtVjH7ZHHkmFnui
	 H64RP+vDJGxLNu5fuX6DBzEq9j7YtpZx5r6K8hwnZ7jzy8ieyV7kqWsUOtnRWNTxpC
	 ZILqJ56KwXK4a3Ji9GLp1gL3gfWBeBzx+eHORvRiUnRJ21XajLuKlP6u0qRO2qrz4v
	 gsaIbZYf5LFIoinqCgyPHCEfj+lhFawYUHvs6FyUiHHQoX0xHNZ6NBnvTyQGU2/lW0
	 yFj//SxBPJKGthMZHUIN+cXH699v+yjjDxi3wM4ICIrCW5EeiSNp/W4CCYHMFVVv/A
	 BGFjYQ9KOXhaQ==
Date: Wed, 3 Apr 2024 14:29:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2DzaS6zLhbWBoCgG"
Content-Disposition: inline
In-Reply-To: <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
X-Cookie: Knowledge is power.


--2DzaS6zLhbWBoCgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 02:07:29PM +0300, Andy Shevchenko wrote:

> Do I need to do anything else to get the rest applied?

All the concerns I have with swnodes just being a more complex and less
maintainable way of doing things still stand, I'm not clear that this is
making anything better.

--2DzaS6zLhbWBoCgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYNWcEACgkQJNaLcl1U
h9BmCgf/ZHvUdWWOvdRjMCssbeGy75qGy+Wod1vkt2kN1hNvwyxNXYSPxWatXM2w
QtKSALFWURE2l0ZUlV4lk/XlS/NbnaFo89EyjN/1tdkMDt2q3mtf+Ou6sTGyEn+R
w/gs25kbo7c3EplWSZTRBSyw5f14hTY1qonNt/eWXTbZSvvfkQ3Unkm5sLK92W6P
LyM3/KH1wk6tSkbrrvAZbvP2Fyyb3LM1GdSNsqYKTmDfsZ1PFsJUuUmQWruAqnJP
rNkcF2lyO5Bpr7sEVqnBqGxqryAanPjYtMidMKw7Wdd5c8C4H9nTZhdKt0cW485k
Mg/wYVVMsN0WpmVANmWOjK+HE2BwnQ==
=3aN0
-----END PGP SIGNATURE-----

--2DzaS6zLhbWBoCgG--

