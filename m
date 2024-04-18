Return-Path: <linux-kernel+bounces-150497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5357A8AA028
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F137A1F22DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436E172BC6;
	Thu, 18 Apr 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMddz6fG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35E171E68;
	Thu, 18 Apr 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458052; cv=none; b=bkGSHGe7WAEqpTUhVA+8voNVRVZbA5ZJNL7GP5GMexzAVisFDVf8+0a8SW0bx40rYawLk5b3mzqHMrmzPRmkZZHlRZ4Aebe9KEbgYxirbliU313d5b/NsxjGvFbbdpWnHV6LMBnOQgQuTM/hqxmEspMgt1PpKObhQ1HQ5vXiwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458052; c=relaxed/simple;
	bh=V3m/+HoOyHHRcPC4//NZxdIwWzYIWlQVXMeeEhk29vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5P0hdd0r3bWRQwa6WaKk7iUz8a9K5MfA7RP290F1NKBmRJkGQYukhl/IV0EdKhbBfTH4gH3nQYT+CQKR5iezkiZyUHa+CNOuTc33jcG2P3Tx1NsxVEH5c+iGcUM+I+5Da9x/vOL/1e615CaRgALlWy+Gwr2DQKeD23cHpNNE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMddz6fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D19C3277B;
	Thu, 18 Apr 2024 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713458051;
	bh=V3m/+HoOyHHRcPC4//NZxdIwWzYIWlQVXMeeEhk29vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMddz6fG9oGgpKB/S7mRYdjttW/BhgcZpAAtuuj+YZks/pnuobbn+AFBUAr+DCiKR
	 prDy+RkQPTO577fcl1ANKjyM1SITvfCXvln9jtCEmJFoUA7yPOs/QysLD92m3fWsuq
	 tnFPVTWhSo9wQFtxlqQEShAPOW1yUIUtU4FpAXYcCmQU/Hf2OQaf3SKW06dQp6LR6Y
	 vgEG9/WDaqmSMUyK30LEcgnPO0AtsBBLOxjvPl4JVeZYKVNCdZ9SUPM4e5g7nNwDFa
	 TW6MvHA3kYZv596JNJQspS/QMdqgrwY6Qo9KWbHagGKf8O00djU2f0sX70k5N52mVD
	 Zwurhifk4CheA==
Date: Thu, 18 Apr 2024 17:34:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93
 EDIMM 2.0 Starter Kit
Message-ID: <20240418-distort-dial-c56ca175d8b0@spud>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
 <20240418133923.3705-2-fabio.aiuto@engicam.com>
 <20240418-lapel-monstrous-5774610c7405@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0u7/MAZsV63WLHSd"
Content-Disposition: inline
In-Reply-To: <20240418-lapel-monstrous-5774610c7405@spud>


--0u7/MAZsV63WLHSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 04:33:21PM +0100, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 03:39:21PM +0200, Fabio Aiuto wrote:
> > i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
> >=20
> > EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
> > Evaluation Board by Engicam.
> >=20
> > i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
> > to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.
> >=20
> > Add bindings for this board.
> >=20
> > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> > Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Looks like you might've already got an Ack from Krzysztof on a previous
version. Please make sure to pick up acks etc when you post new
versions.

Thanks,
Conor.

--0u7/MAZsV63WLHSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFLfwAKCRB4tDGHoIJi
0m/cAP9lDew2O967UVxosiWdBCxu3U06yqIrNDGktcCB1Af5egD/fIWWhK3+Mq8J
uX3IuFqiXvRTFpq5cc5iljpXO56OrA8=
=Xwh5
-----END PGP SIGNATURE-----

--0u7/MAZsV63WLHSd--

