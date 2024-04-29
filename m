Return-Path: <linux-kernel+bounces-162658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45808B5EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217F61C21393
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717684038;
	Mon, 29 Apr 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw4y/hv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736714A8D;
	Mon, 29 Apr 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407000; cv=none; b=Fi44Kktl77AAps0ogrCSru4RYUvaTfD7F9QGkcpkM3MR1E7OF9k+oiqxA2wExHaMUNvDec5jLlY5pnvKDULKfGXDr8e1xjbkZnJYDgwN5+ae8sjMJFPBLnSJ+uJDCEYb/eBu605mtsNMP1B1drEs/Gbi5+L0ZcptCofHN+sD4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407000; c=relaxed/simple;
	bh=ZAtGzg5xpGyRTDWRrb2P98Cvugc+fB+eaQXGW6P1/hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpvpOQjG5YT2CttgKF/Z1siSQcpJe5qMFyBLuv/KHfYuAfeUTPPPevlw553mHOF7jSAE2NpOvSwcSRLljOJ8cUqXG2aaU9epvImKTldfwrZpOPN0F0DkYfQt20horjeYm60eIageB6OHid9xXnbkMP+J1FadDXfkVXiWzLkq7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw4y/hv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C47FC113CD;
	Mon, 29 Apr 2024 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714407000;
	bh=ZAtGzg5xpGyRTDWRrb2P98Cvugc+fB+eaQXGW6P1/hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gw4y/hv0on/UyzNmi4cz6milNX1OQfPdqWJ//xYpNdrCAvZV7BZvi6kywVg10g7Os
	 8xP0emuan30Ddh4d16M+uYPMpVAgiOGtvWmxGTUft3mY/o7zfGqt/MngKsEr6XHzhG
	 z3O3uIwbKliJxxrnbqJ8ekwtga9LX7zveXVEHnzToracaCaU/cGdsvVLP7HYIutAWC
	 G2LbUuUkqvFfZMNBLmzypobpICmnx7beK2au/htN8cxTzdS8zTORVVXIXC/iPxv7VH
	 8oaRjZzH/g69yHwiRY/XdNLiWv1Y/mvShsSyj9tiTgQWAWzUSNJhWTjr11lKg+uPN1
	 iH8G1tWMCIGCw==
Date: Tue, 30 Apr 2024 01:09:58 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 1/2] regulator: dt-bindings: rtq2208: Add property to get
 ldo of RTQ2208 is adjustable or not
Message-ID: <Zi_GVrak1a8e6v7r@finisterre.sirena.org.uk>
References: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
 <1714385807-22393-2-git-send-email-alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1k+RQz/jK2KhQiZu"
Content-Disposition: inline
In-Reply-To: <1714385807-22393-2-git-send-email-alina_yu@richtek.com>
X-Cookie: lisp, v.:


--1k+RQz/jK2KhQiZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 06:16:46PM +0800, Alina Yu wrote:
> Since there is no way to check is ldo is adjustable or not.
> 'richtek,use-fix-dvs' is added for that. user is supposed to know whether vout of ldo is adjustable.

As Krzysztof said we already know if the voltage can change since in
order for Linux to change the voltage there must be a voltage range
specified (and see comment on patch 2).

--1k+RQz/jK2KhQiZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvxlUACgkQJNaLcl1U
h9DfNgf8ClE+rYHKggStfAAkgeIFkBwgVTxO1I85bFXhSuclF7fd7Y6sE0sTwNtr
QtWcDvwPxbAEKwqJwouq/C3ktCeNVQVGKkGpRaUnQZ+FjqKN2ZS6CImRWb697D6l
tuwIjMt660KtNHtDCDLvXODd2OaVUkxCfL55C94hHgURP0+C8D43KjBasw5lHz7j
fdBpUC84egX4zFpDfTCmATRVIjCLXIxooUEfog6NnoM+7gZV3xlVOS7mDoCgoUcQ
t3ji3C+JZqo3sEb7cuYiuQcZAhAOU85adO7mo9YLzpKZKSOxoH7u4PpR9mUqG+5m
5X7DT0Z3/Ekv5DSu6KoR9WEQTTMWkQ==
=rZd1
-----END PGP SIGNATURE-----

--1k+RQz/jK2KhQiZu--

