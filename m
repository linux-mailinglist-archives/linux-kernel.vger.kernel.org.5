Return-Path: <linux-kernel+bounces-73614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E6C85C524
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D788B25469
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E814A4CC;
	Tue, 20 Feb 2024 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCStGpKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197C36135;
	Tue, 20 Feb 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458432; cv=none; b=sD8tUCRwvtENPD1k19TemjpyxsGuFcKPJuzhKXXmBfdlNDItm3AA522NIZsvRT0yVKDb/StFRveJwTGKr4c6aockcPQAFFa0pPSLBF8ynUAwixdgY7UNk6Jx++X8RaEg61eg89LxXr/+ByDrX4dSKso2IZl4KM6lY17BvNy5y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458432; c=relaxed/simple;
	bh=1KiS+U4NNT/mwNoBNJ7E4oCUd/6Lzcv1jcGa7+zX+Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5rKySNfULmYywDyACGfz7qzKSvjJndaHom8m5a8STNguAE++fWgBKQI6fwiavGZMDn+FfXhoiEiMUUNpMKVIh//e96/O6hN41EIEe3fQs5dPXKgJD9iSJD7h1u+ZYXGZGmExmnvjdtwtvAakynEDGEPiNIDI2GD/0gJflN1tH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCStGpKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB893C433F1;
	Tue, 20 Feb 2024 19:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708458432;
	bh=1KiS+U4NNT/mwNoBNJ7E4oCUd/6Lzcv1jcGa7+zX+Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCStGpKyprAazJxn0xJT7SpatIrasVkTuxPqf5bGDO8klHUhTy+LkvcfqhpDAIU+E
	 Pi00Fq6nJ1FQWsSHrp/hmBlnxf6Xd0WHN+8fLsiE1ztai154YOZ6B0EWFmvsv2SL5r
	 9ClVxPzJcv1EIEaReBaUA3fVisEt1mMD6oaly5q6ztRAMWOCkSvkJ8gBo5aS3LPpVB
	 OJUSexXEcLR17q74kIhLp3ZL63KDtyNMaLOgNTqvcSaDS/r2NYaByhx8f8KxgmeDre
	 Rav/PUuB3tWB7omnjX4YilFxFDibRERnfx2HaJ+oPNWdeXLVzwe/CeT6a9HsJ/VHc2
	 JqWtq6zLrJxFQ==
Date: Tue, 20 Feb 2024 19:47:07 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240220-tamper-feed-0622f9441cfe@spud>
References: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
 <20240216-ad7944-mainline-v2-1-7eb69651e592@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="39pzYbsQtZHaU+Tb"
Content-Disposition: inline
In-Reply-To: <20240216-ad7944-mainline-v2-1-7eb69651e592@baylibre.com>


--39pzYbsQtZHaU+Tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2024 at 01:46:18PM -0600, David Lechner wrote:
> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.

I think this binding is overall pretty well written, especially
considering the interproperty dependencies.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--39pzYbsQtZHaU+Tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdUBuwAKCRB4tDGHoIJi
0uuWAQDLngt5pz4PlV2W01fTD2fS7srtxqDPBPGnF6sXp+nKUwEAuL1m1J9Am2Th
iGA+hrTy6KEwjZqWfj7mHiqM/QpsFQg=
=VP88
-----END PGP SIGNATURE-----

--39pzYbsQtZHaU+Tb--

