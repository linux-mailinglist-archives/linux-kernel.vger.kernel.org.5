Return-Path: <linux-kernel+bounces-103342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0D87BE53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726851F21C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E86F086;
	Thu, 14 Mar 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl4QjPcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383E6F53E;
	Thu, 14 Mar 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425049; cv=none; b=gd5mn7N33Cj9d9asRa7RaAhh1pxCEbolxYU0L9v+cm1MFPXWy+2QfBEwbdRzt/FbEHJdPUMfnECqkW9dJbjHSHgJfbeKEWSY1/azyG4UZMa0VMBSbMExKe2F18SIBvXME1hUsx+axDs24LmUXJjQL3VSUgSitoC5rc1w8iRQzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425049; c=relaxed/simple;
	bh=0X+kWZ/rrmB+DdmZpVU62eypuVla4+LyNk+iXvCgaxo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2XnRgftmpVgYX/bLOG2drpEpBefUMiRB6jFnvY4EtVJ5CvIfpLxHCJ0j/FKPkh8vI+Yh3SusZfOXbKoawFgQQh8rixim+/yjJOgiq21vlxv2l0ntptbcgtxaT0afCjLe6hyeYLkxJXLsxK3c1jj28ZjGaFO98NK0SE6VtmOw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl4QjPcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1CC43390;
	Thu, 14 Mar 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710425049;
	bh=0X+kWZ/rrmB+DdmZpVU62eypuVla4+LyNk+iXvCgaxo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Dl4QjPcbYkzLYOaehB2v8TzcILbP14cQGdkGhhd/IZs+ODP7ODBQvD0l5o5Z8fWhM
	 IqTFy3F1DZRczesId7u6wSdMXak3SXtNbyfB9EHQJ602O3Vi0oBd5e+8PVQHg75vf7
	 SWvepJ9iVvDXPIf/t1z13J39YviBy1rJjRL68/4Mj2Acx6pm/7mxRbLNlAqdBctCmL
	 zt1FnsM6v2WkhU5cdJsLtWp8ZjFkjx31EwpowZ/pu7rQOkXkJ1c8qAsaajp/3L+Voa
	 ALOtCX3WAcF/sM5fuDSKrsE4NfVQF0fIjXO9kwAnPkz5TAYbnWuy9J3Qz//b0ZhjQY
	 PQS+GFUpcUKBg==
Date: Thu, 14 Mar 2024 14:04:05 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com, jeremie.dautheribes@bootlin.com
Subject: Re: [PATCH v2 0/3] Add multi mode support for omap-mcspi
Message-ID: <89ce73c5-eaab-42ae-aa2c-01003f04eb2c@sirena.org.uk>
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
 <ZfMCHjR2jR-24vTC@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncr8zWx/7TU0eqMX"
Content-Disposition: inline
In-Reply-To: <ZfMCHjR2jR-24vTC@localhost.localdomain>
X-Cookie: WYSIWYG:


--ncr8zWx/7TU0eqMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 02:56:46PM +0100, Louis Chauvet wrote:
> Hello Mark,
>=20
> Given how far we already are in the current cycle I suppose this series=
=20
> will only be considered after -rc1, will you want me to re-send or will=
=20
> it stay on your stack? I know some maintainers prefer contributors to=20
> re-send and others don't, so let met know what suits best your workflow.

No need to resend.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--ncr8zWx/7TU0eqMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXzA9QACgkQJNaLcl1U
h9CkrAf/a60ysAQalgL69U45xTVzqxSejNIIoVVSXqGI98oNhPO8fwzxj/aq8uXX
kEj7PJaX0ca5xmBVyowdVidxzzXZ8RvojkHZza3SWBJCbjlJkvHZ7SrtdOZ9IOc1
8M18sSazEJDokelTgRv8ComuYmGDdMCEfOqdk7kp2/CDwH90oe1p6JYyQ9pS4r79
xwCtx5vfHmQMDayBSMyep0Yn2i4HVOPL4BpBsiM/wZbBqRZax/lxyt6wK/+SzFJ0
rtneYEER0dDN2yXAFVCwzWv109V6CWSMk18kZOCJWCyuEL66f9PaHuK85bSHVXMh
N0NqXHLevI9fwoGI4nELvaaBAUfZgQ==
=3y/L
-----END PGP SIGNATURE-----

--ncr8zWx/7TU0eqMX--

