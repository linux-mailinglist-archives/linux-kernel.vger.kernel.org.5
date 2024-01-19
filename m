Return-Path: <linux-kernel+bounces-31416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBCC832DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAA11C23BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55C56461;
	Fri, 19 Jan 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyFLZJZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAF56454;
	Fri, 19 Jan 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684601; cv=none; b=n8oOIxKHVLA4q2HCbC7lxK76UPmnbYcKYigNbifhSMMDIgkQRJVFYFFaJOUzXFuAO8trm56Ou1fiCPbomdzKPD4kRtOnhufkEwD4msxvfC/OdFtYNDvg/17fwKDPLexy8H8YnD3iZiIM1DvRTESCKZSqUMzPNWGUk+KY9IkuReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684601; c=relaxed/simple;
	bh=jNPrMjuwW2jiFZRIQsWOlPiFPzjdiUPwl0gq/ViP+84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDDNQb/VbO4n0WucPy+EbaLx33pv2j3nnfqqRUe4QH6CS4nZ8XsibTxwtd6JNq4AvYlSKAvHtL5xvBKTkE6TIP53bHttaj9Yf7Fk2Zr688xDDL+ZSSQp7QjFcXr64N9h0fFsN0LNyVGXeQ05VByqHmSZ2PoizOxabrA2JJ7zGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyFLZJZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B51DC433F1;
	Fri, 19 Jan 2024 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705684600;
	bh=jNPrMjuwW2jiFZRIQsWOlPiFPzjdiUPwl0gq/ViP+84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyFLZJZc091+EG7wAb/chfOjRPwjE6XVRT7psPmZ/+FFeei+JDyAcsPHMJrvquOcu
	 KVGO+t+PYnDANz5EUCTsqIdl/L1NOUbQvtN8ghPyxlNzzhVkZuVDWhVniNqTUVAdLl
	 bMqDwMDjzFt22MjeYpVWr1zOiNjGctLzjXlItzGKQbC6j917crs+8ElXvP7d2IbNQs
	 bLYg1y4/qcTF9lxj4c1ZMQRRVM7SiFVj8+ppmq7vO92I2GYiDyknt+S8B1oZDVj5e9
	 aPmOGtv1F/dnbUUgQFTw2gTPB4JNNUK+VFcniHxtNQM/eWU2TlxxeLyV2Im0D7eAfF
	 K+x/DxK1nzQYw==
Date: Fri, 19 Jan 2024 17:16:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/2] Add Variscite VAR-SOM-MX93 support
Message-ID: <20240119-fantasy-sycamore-5fee33d2a16b@spud>
References: <20240108110241.8555-1-othacehe@gnu.org>
 <87mst1654q.fsf@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4N1mxou9cWmYZEdK"
Content-Disposition: inline
In-Reply-To: <87mst1654q.fsf@gnu.org>


--4N1mxou9cWmYZEdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:31:49AM +0100, Mathieu Othacehe wrote:
>=20
> Hey,
>=20
> > This is a v7 adding support for the Variscite VAR-SOM-MX93 SoM on Symph=
ony
> > Board.
>=20
> Friendly ping :) Is there something else that I can do here?

It's the merge window, you'll have to wait until next week to get
anything applied most likely - unless Linus extends it due to the power
outtages that he has had.

Cheers,
Conor.

--4N1mxou9cWmYZEdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqucwAKCRB4tDGHoIJi
0kboAQDtcQY4iz0GomNJqZi0qSCPCblzeGwFwslDe2Tcoxo9pwEAjJaoFHS5JSNQ
CBW7lEU4a7BTAeUjR8zYG3DFAAO2ZQ8=
=f6dW
-----END PGP SIGNATURE-----

--4N1mxou9cWmYZEdK--

