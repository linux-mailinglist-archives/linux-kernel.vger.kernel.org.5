Return-Path: <linux-kernel+bounces-111958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED388733E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724621F277A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E46931E;
	Fri, 22 Mar 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7O00PmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02463CB4;
	Fri, 22 Mar 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132477; cv=none; b=e/eB+f8Ra4xJXZQQmmkkLUyZxDQOnLxdkbfFMLGEFmagsuFe0x+tL754sn6x0E469lzGmj917AoM5kyxWkx1NArXV1O2aZYME44Huz0SrM/VHlHZiHk/uRV9mkZhLRgZRb+OZP4cJ/QHyxHDC32DCq+R0U+WjKeidk83tH6cAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132477; c=relaxed/simple;
	bh=6PCoRlmkutx/LHsc70GhZUwGUN7dDMu8R829RBPxXx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt7ZAyZcBJLiWI6K5SAzwPLraXvI2akGNNETb0CaaduAqVFM6vuQM3iOTEkfnjjDVkzurhziuyMIsD44+HlnlfTCDiH40Wrk5bhuzmQC6kxJkr+576++gANaoyZzPPCC4WJWzEVcsO0q4BagmWgho87kNz9mITQeyuHN7yD/O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7O00PmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF35C433F1;
	Fri, 22 Mar 2024 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132476;
	bh=6PCoRlmkutx/LHsc70GhZUwGUN7dDMu8R829RBPxXx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7O00PmRfLiD6cvfR49FYckVuXBthdD3Ir2OQ5CbbHgzV2WCV016us2hCBIJd6blj
	 NTE4OLS2VwMupYVGmFv7F8coDQzzQfcU1KB558Jr2SRA9ySTmTuk5j/t2rVTEfWUWD
	 Jh2rkMbDxE5NNldj9fZ8thgFR8QJWQ8ExNzCFUuB1AbKg6ZMy23vxc41JXQ1fl+K4D
	 ZDNccw1fFYXWDMeMRvtMRwnPWLCuf0RdoODcpdYWK43YK6AgOv0nbl0sogYNSVpCrK
	 HDd3wEROCrAnKL9ZaNw7nR7xIWFHCR0rILi5pZWdCWDJMvoG+06ir3h75lIY4Qnrcr
	 r6xhW4JXWn5+A==
Date: Fri, 22 Mar 2024 18:34:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Allen_Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240322-rectified-udder-fef9102f58da@spud>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud>
 <20240322183009.GA1227164-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lnQoOh6YHraD9SfN"
Content-Disposition: inline
In-Reply-To: <20240322183009.GA1227164-robh@kernel.org>


--lnQoOh6YHraD9SfN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > Add the HX83102j touchscreen device tree bindings documents.
> > > HX83102j is a Himax TDDI touchscreen controller.
> > > It's power sequence should be bound with a lcm driver, thus it
> > > needs to be a panel follower. Others are the same as normal SPI
> > > touchscreen controller.
> > >=20
> > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> >=20
> > note to self/Krzysztof/Rob:
> > There was a previous attempt at this kind of device. This version looks
> > better but might be incomplete given there's a bunch more properties in
> > that patchset:
> > https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@himax.co=
rp-partner.google.com/
>=20
> Those don't look like properties we want coming back.

Oh, I don't want most of them coming back either. There are some
supplies in there though that I think we would like to come back, no?
Maybe this particular device doesn't have any supplies, but that doesn't
really seem credible.

--lnQoOh6YHraD9SfN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3POAAKCRB4tDGHoIJi
0oZGAQCE3pDMwybKUvEoEPviPgR/Q/ZN0K5CHvpccJjYCPEGHwD/RgtucX7Mw89b
lQWEppItKNSOW75Y2KFMerXPFy0+/QE=
=lAe8
-----END PGP SIGNATURE-----

--lnQoOh6YHraD9SfN--

