Return-Path: <linux-kernel+bounces-37424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF783AFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1126284839
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729E1292E9;
	Wed, 24 Jan 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwjqjcaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850381AD5;
	Wed, 24 Jan 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117094; cv=none; b=X78FSwNsMb2ges4MVDat87vs2qkHA5KyLusFpL0uVGN6LCgOy9WKtuQKvBMTgP8bcnp407/Ap5khz2dfa/bT9HXU36g6tM7p3p5cwlhHrPgoO25fvs5htWY9M5PrKIV+OZZNxTjeR+Axh+m61a4+TVsSNABttizAj02OIzJDfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117094; c=relaxed/simple;
	bh=Tyoyg16m+L9fCBHSlhtH6nlFRNPPjNF7BTPAFm7yRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atelTGfu1o7laIXtv+IGMiAodGwQWvyRh5ws6IYXrDvEuIqBU+QgtwHT8BQkKEP5tFHLcRnpx+ozEDEVRsYPDP8lgOPIlJNGw2x11RYqVh5WOaIasPBMwAw/IMe/VHnGc2gSq0s2U860EfyL23GZZ8/KAkChnfKehyvcEACXnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwjqjcaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DE7C43390;
	Wed, 24 Jan 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706117093;
	bh=Tyoyg16m+L9fCBHSlhtH6nlFRNPPjNF7BTPAFm7yRLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwjqjcaG2uVSX3LiUVh14RJRgcqSAysI+F7o7DiL+nNOkLGH1KH5Ra5mEeRXPel9O
	 4vkTSm7bH8TPXwywSVnK6zBlhoANxRMSdOmx5hYbJcNLsbPUWiH0TbI0q0uwj9WLmm
	 rON4hwyM0KmaEtPJekd+xKsb0Q1GASBBtmn4QD+VA9SHcEmzfsewRERjfMc+SrLg+Z
	 npZZ9ev9TtT2/KwU6cBgkz3/i7lby98lVE/TqX190zUX3j4Zse6TSWq26JsDxLSuyV
	 GQeA0KgqrQvsS2/DUN3KWPkMpBBypwMpbYwkCOi0Pv49lUKWKvG7W2NTNiZHpmBUGg
	 72MWDhysdUKSQ==
Date: Wed, 24 Jan 2024 17:24:46 +0000
From: Conor Dooley <conor@kernel.org>
To: David Regan <dregan@broadcom.com>
Cc: dregan@mail.com, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	computersforpeace@gmail.com, kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
	william.zhang@broadcom.com, anand.gore@broadcom.com,
	kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
	rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com, baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org, dan.carpenter@linaro.org
Subject: Re: [PATCH v3 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
Message-ID: <20240124-rectify-tubular-1dfe659ceac7@spud>
References: <20240124030458.98408-1-dregan@broadcom.com>
 <20240124030458.98408-2-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oefS8yUbzuzQDHdr"
Content-Disposition: inline
In-Reply-To: <20240124030458.98408-2-dregan@broadcom.com>


--oefS8yUbzuzQDHdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 07:04:49PM -0800, David Regan wrote:
> From: William Zhang <william.zhang@broadcom.com>
>=20
> Update the descriptions to reflect different families of broadband SoC and
> use the general name bcmbca for ARM based SoC.
>=20
> Add brcm,nand-use-wp property to have an option for disabling this
> feature on broadband board design that does not use write protection.
>=20
> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
> broadband board designs because they do not specify ecc setting in dts
> but rather using the strap setting.
>=20
> Remove the requirement of interrupts property to reflect the driver
> code. Also add myself to the list of maintainers.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

Oh, and the patch is missing your signoff David.

--oefS8yUbzuzQDHdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbFH3gAKCRB4tDGHoIJi
0ugAAQDPYIVJB/OprlKbbtXgUBVgLVOW/5xcsrk63na+ktc3KgEA8814J96igPC2
vVzqjQxIuwTo/yQXnDYu6UuTSxSZhgY=
=MbCJ
-----END PGP SIGNATURE-----

--oefS8yUbzuzQDHdr--

