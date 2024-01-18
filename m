Return-Path: <linux-kernel+bounces-30003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06A831691
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB481C2108F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11A2208B5;
	Thu, 18 Jan 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJg9sCwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C2200DA;
	Thu, 18 Jan 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573169; cv=none; b=mQRdBDsfcYdhZGk1aW23qKlOs2FKyH+869xhA9PIzcMYu/kFmDGoytsFPjYw5Bvi3iu0Ti63RmrWdGGDAACvU1bZc4kS0Ip2biQiYauOBWTsW9XSYdbY+nPU846LE8KebGlvYeQvt9q8dAVZjpCIMu04txgWjbC9Om6XSJBg8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573169; c=relaxed/simple;
	bh=IbQTVMt4z3sop9SW/3WlZU0zwS9nBcWxskx1Aa4Xop4=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=dAQbLcPKRMSgUIXU8KgedhGfKywncCemduW1EEoyQQz7tF5uX2Xlkgdv7edLxKqf7FcEEChYJ5Wdvk0Vr/am97QBVYOXKxi6XY5hXbebapKfLil+Lod4bRtAUQfIM67Tevk9dx5GuLx7njyXkyfc+SvjkED88mruu6ZV9xJeg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJg9sCwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E15CC43390;
	Thu, 18 Jan 2024 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705573169;
	bh=IbQTVMt4z3sop9SW/3WlZU0zwS9nBcWxskx1Aa4Xop4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJg9sCwLqoGnmIoUtBoXSmHJqpj/gow4oO9zN6lnrgMQjI3zX+eSzVxIsgF7ixFy2
	 msj+mwpR3TE4fR9kChKrpPa4PIVKb0hbdGHwm7DGarnKor/+yQ/RBxEicswlpbHF0N
	 wEGL9x2jAbAfjwRR+az+sEzJZmjdQCT41/SUrXkHw2H5nSZ1a+f0BlRtQI2JQY+Mpl
	 Ya0XDeSYJmsfnKTfcgJ86M6GF9RIUnWW71I1jIA6tipWgCLOTVh+6q/7aZYgFl37Um
	 vd2jAW3HfR8BlmffBQEcXpunQR0JkBrKeO026vD+F0sk3Rk2NUe2Ly5Nyzuzvhw24z
	 aCjaZHc1JlRhg==
Date: Thu, 18 Jan 2024 10:19:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20240118-regretful-viewer-8d7dfc7a0802@spud>
References: <20240117074911.7425-1-othacehe@gnu.org>
 <20240117074911.7425-3-othacehe@gnu.org>
 <c1ef5c08-1ae9-4a22-8ca9-47673c023e1e@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gdVdvko2Jiy19Yvv"
Content-Disposition: inline
In-Reply-To: <c1ef5c08-1ae9-4a22-8ca9-47673c023e1e@norik.com>


--gdVdvko2Jiy19Yvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:58:36AM +0100, Primoz Fiser wrote:
> > +	reg_usdhc2_vmmc: regulator-usdhc2 {
> > +		compatible =3D "regulator-fixed";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> > +		regulator-name =3D "VSD_3V3";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		gpio =3D <&gpio3 7 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
>=20
> Order properties here alphabetically like in the downstream kernel.
>=20
> Comment applies for the entire patch.

Please do not order properties alphabetically. Instead, please read the
new documentation on property ordering that makes explicit what has just
been convention until now:
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/Documen=
tation/devicetree/bindings/dts-coding-style.rst?h=3Dfor-next&id=3D83a368a3f=
c8ae8538bccb713dc0cae9eacc04790#n112

Cheers,
Conor.

--gdVdvko2Jiy19Yvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaj7KwAKCRB4tDGHoIJi
0m6eAQClJvcWaV+PGbHsXiJ9NIcovUuFyFdgcqzj7m5pggaarAD/Wj3uRmz9ihlN
pH62UkUr3zU0WnMWaTu8yz4LXjHEQAo=
=gJVS
-----END PGP SIGNATURE-----

--gdVdvko2Jiy19Yvv--

