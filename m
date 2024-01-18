Return-Path: <linux-kernel+bounces-30319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88091831D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEFD1F22570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1528DD4;
	Thu, 18 Jan 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLMPK8gc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A124B37;
	Thu, 18 Jan 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593410; cv=none; b=Bk4va8nBk02V69hGQBB+hPfe32EUIK2o4d4NjUlhwmiofyoOuVsnrMPgQUCBHbScStEQB6O/C4trRn572livCYlK9U6DPRppGjsmmUgsMOs+hB9UZz+b+wPmms/O0aNgPE91ekGIW+hAb3AnCfmPEXgyMzKGvJhygC3m4937Lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593410; c=relaxed/simple;
	bh=5EROv/PliSUdPC4ViG2nwtB6PhsDjdlT/9YdwUIjIdo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=OdBB8DdbnoVKplpDgdSRyzrDIQcX370XkDUTbXmeak6moBC4Klyne6fcgJRg9/EmSS3G+drnvuVLF4lfpUD7OAs0pz1nwrpYcXXRAvSVKb0vosI+MGTVel3riFEOZx6Lw5/oXLFc/pScvzE9xOz/X5MeHRLIfQ7GI8DewW9sxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLMPK8gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ED5C43390;
	Thu, 18 Jan 2024 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705593410;
	bh=5EROv/PliSUdPC4ViG2nwtB6PhsDjdlT/9YdwUIjIdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLMPK8gcRLNqG2wGliNsZRieedsidby49NUPFFHxvHBMPjxS0OqW54NtBHDiY3I+y
	 w/BAcm620hR+yJiYRUl+nRCeUT6yLscWFUKhp3zil+XtrqF2kM7QF7fGDTIqBpq8ki
	 YQmMPEujp0HnbJErCfREk9VO+GpyRVNIhK2VfS/uildXFJ5qu10qTy9M4hav6v/ZAY
	 H46DItUhNKml38G2FFHQUeKwUhRr/32CmlpWeHJEvT8vOmz87vt2orf+52RZGqWmNA
	 H/HjtLJ2BDIL4aZhuImk1XDElAGIcW5aQLtyyFg0AShtf99DshxQj91bViakWGSAna
	 2WyEi54gzCHRg==
Date: Thu, 18 Jan 2024 15:56:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Primoz Fiser <primoz.fiser@norik.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH v2 2/2] arm64: dts: imx93-phycore-segin: Add Phytec
 i.MX93 Segin
Message-ID: <20240118-excavate-bridged-7378c8ebc16a@spud>
References: <20240117074911.7425-1-othacehe@gnu.org>
 <20240117074911.7425-3-othacehe@gnu.org>
 <c1ef5c08-1ae9-4a22-8ca9-47673c023e1e@norik.com>
 <20240118-regretful-viewer-8d7dfc7a0802@spud>
 <87jzo6vjtg.fsf@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NQNMzSLYhR4PxVsu"
Content-Disposition: inline
In-Reply-To: <87jzo6vjtg.fsf@gnu.org>


--NQNMzSLYhR4PxVsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 02:43:07PM +0100, Mathieu Othacehe wrote:
>=20
> Hey,
>=20
> > Please do not order properties alphabetically. Instead, please read
> > the new documentation on property ordering that makes explicit what
> > has just been convention until now:
> > https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/Doc=
umentation/devicetree/bindings/dts-coding-style.rst?h=3Dfor-next&id=3D83a36=
8a3fc8ae8538bccb713dc0cae9eacc04790#n112
>=20
> Thanks for the link.
>=20
> I have a question though. Regarding that section:
>=20
> --8<---------------cut here---------------start------------->8---
> /* SD-Card */
> &usdhc2 {
> 	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> 	pinctrl-0 =3D <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> 	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> 	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> 	bus-width =3D <4>;
> 	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
> 	no-sdio;
> 	no-mmc;
> 	vmmc-supply =3D <&reg_usdhc2_vmmc>;
> 	status =3D "okay";
> };
> --8<---------------cut here---------------end--------------->8---
>=20
> The documentation states:
>=20
> --8<---------------cut here---------------start------------->8---
> Order of Properties in Device Node
> ----------------------------------
>=20
> The following order of properties in device nodes is preferred:
>=20
> 1. "compatible"
> 2. "reg"
> 3. "ranges"
> 4. Standard/common properties (defined by common bindings, e.g. without
>    vendor-prefixes)
> 5. Vendor-specific properties
> 6. "status" (if applicable)
> 7. Child nodes, where each node is preceded with a blank line
> --8<---------------cut here---------------end--------------->8---
>=20
> All of the properties in my example are falling into the "4" category I
> guess, except for "status" that should come last. Now, how am I supposed
> to order those properties? I had a look to other IMX device trees and it
> is hard to establish a pattern. Pinctrl first, then alphabetical order?
> Anything else?

If that is the established order for imx devicetrees, then yeah, I would
follow that ordering. From my own quick check of recently added boards,
that is the way things seem to be.

Cheers,
Conor.

--NQNMzSLYhR4PxVsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalKPAAKCRB4tDGHoIJi
0izkAP9EwNLAq04HFpfgHUVYT/Na89yK5jZy0i4ZY1N9tIUjfQEA8dSFHsrQeZTB
wUL5SOyLaCYmAv6hVCqWanaLFWQjuQI=
=AlYo
-----END PGP SIGNATURE-----

--NQNMzSLYhR4PxVsu--

