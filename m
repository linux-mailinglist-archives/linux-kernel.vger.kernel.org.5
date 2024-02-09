Return-Path: <linux-kernel+bounces-59691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A554F84FA7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AF028790D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8681F7BB1C;
	Fri,  9 Feb 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q35So9lM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28037BB08;
	Fri,  9 Feb 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498179; cv=none; b=Cd+Amo8sWcXga8gsGHY5s0Rm0xcadSAiy6vK1wQVjA4nJGR7rUrpM8EZoMSjkHJJfyD2xx3IzlC4P+ORRzlyMaQeYn21ia/AYsgjr2EpJkaksq+DU6Pgl3urh7nFrA5hWBa31Wfa+wIe++FBqKC+m2pU3NdXzsHR1cM6b0ene9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498179; c=relaxed/simple;
	bh=Lrq5hrellIefTYXXaHqu+INob5qfnV/eTzPySL8VU5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnIv5z4j/DhLwt31OSdaw7z33HtPfnQP0xG2NUYe5wZUVAk34z8EcRmegQRtnict09n4dF7wf9lNdx+9i+favafWCX4YbycbZnUBVFP08IzXmjECpyUYcpgeg/mDtIYrBNsUfVZWxPU3ss8X3YuXJix7gXFb6zVXiGPPNjipS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q35So9lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774C1C43390;
	Fri,  9 Feb 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498179;
	bh=Lrq5hrellIefTYXXaHqu+INob5qfnV/eTzPySL8VU5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q35So9lMUF2qGPmWrxH5SYbPPJBrKVvLLQw5AQec4iPoHNRwhUzDQ6SYepvHKvMro
	 oCqjzcMTp4qbIiaqL2RA9dcZkHPMyJ8cFx2i9ruAJEn6fofmNCCEfOb1MIYdlSuqRu
	 wShi0uujxKxLN2LnKK6rGoIzOy9gXVTx5dbheOVbYBSLcUbztCGqv6HYN0U3Ry922i
	 oJey30Qf+Td7NtryF4L5kN7kEm3Y8uu00Yfdogb9ZqHE54Z+NNzFpxOHV9aOQsYhnl
	 cZBhywCyFiyJOYuJ2DsHlUZlmpYZSx1Ph8LczEAJf5cTpqTRlXCHoDQDwFPaat9Wd3
	 GwifIkFRL1Vbw==
Date: Fri, 9 Feb 2024 17:02:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/4] dt-bindings: stm32: update DT bingding for
 stm32mp25
Message-ID: <20240209-stinging-unwarlike-674ebb82d53e@spud>
References: <20240208142301.155698-1-gabriel.fernandez@foss.st.com>
 <20240208142301.155698-3-gabriel.fernandez@foss.st.com>
 <20240208-syndrome-storeroom-5cc8bdd07c05@spud>
 <768067ff-cd69-4a55-aa5a-fc1eae5c1116@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ySXbP4Hch0LxT6iF"
Content-Disposition: inline
In-Reply-To: <768067ff-cd69-4a55-aa5a-fc1eae5c1116@foss.st.com>


--ySXbP4Hch0LxT6iF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 10:46:14AM +0100, Gabriel FERNANDEZ wrote:
> Hi Conor,
>=20
> Thank's for your review.
>=20
> Yes, I have checked that point. I have also written the RCC driver for
> TFA/OPTE/UBOOT and once
>=20
> I receive Ack in the Kernel, I will upstream the other components.

Okay, if you know theres no other implementations:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

btw, please avoid top posting in the future.

Thanks,
Conor.

--ySXbP4Hch0LxT6iF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZavgAKCRB4tDGHoIJi
0nJ9AP9pgCiDfbPPK8C8wpcNkD8v8BwOQJmplpuRMXqfPtlZbAD/TCtE1mY94jtz
r1I6lqx/NZblJhh+vgmcoqfZ+KCBWw8=
=1lSt
-----END PGP SIGNATURE-----

--ySXbP4Hch0LxT6iF--

