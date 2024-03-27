Return-Path: <linux-kernel+bounces-121781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3F88ED9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31601C2C00C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C283A0B;
	Wed, 27 Mar 2024 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0wk9Ph0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818B14D447;
	Wed, 27 Mar 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562823; cv=none; b=d0CfFefptJclNlmUKe0QER/ajR5Y5eWc4jttG4vB0e2EMvgpY6EldV/GC5+erBV15nn4AS9xQmvKg9UwUVPYpuP7JGC0y+vXgvfvinh4Yg1aZYxLhnpS5Y+m6/hU/nnrXq0eEZnGlTcwISzLVrjJo0Rk1pcXMNT3+zS40e9vAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562823; c=relaxed/simple;
	bh=/bu3JpKJr0qnVs//UM1Yw62jMcXqbFvPuluMhcemfBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O19SciHkhazHjwB3JC2BhEfb5KL2WB6HDEUmwst2OyigoF0Ilr04WBTmLzzfp2K0t1tyUN3lsomU1OQaARj/BhmkgvTRkxQUVVxOOvuO33OW69BTcOcYvSZj3BT7T6glb+CZnTkFopaAa2XGX4K/2wr6PS5UPJ9Ux5jzfFpJU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0wk9Ph0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F87C433A6;
	Wed, 27 Mar 2024 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562822;
	bh=/bu3JpKJr0qnVs//UM1Yw62jMcXqbFvPuluMhcemfBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0wk9Ph0DhJ4VlgbRH0d78KXTKNFsEUmzcYHqfxk5mODxKk7rXnpm0PiYFuMIs6hI
	 6P6HOATZW6Bh2JmaKrsjSj3pDKSmbdBuVcUpH8yO0c/nir7cEtxxg8HZob7vTKxZG0
	 wmidW7OSGxrIHc/Bcy5+AMgTFrfbbg7+6WD/0wElzC9hW2mS90RBn9ju1xkQAJ3ll4
	 +pXN2N7HN/hWdRj/kkTTNmgAHkD8rxhtYLOQ5GF4SCM3wajKaNUqIPkhQqugyTxqFg
	 N8AF2GxZ4pOotjVpRSMSHfX0PR0hDYZEnWc9eqPAezpJJuoiNae5socdBEdJyus7e/
	 fF1UJDXmbMJHQ==
Date: Wed, 27 Mar 2024 18:06:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <20240327-cotton-fang-37f6d8fde0e5@spud>
References: <20240131132600.4067-1-jszhang@kernel.org>
 <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0VltnKYIOb8VcZm1"
Content-Disposition: inline
In-Reply-To: <20240206-magma-deem-2c88e45a545a@spud>


--0VltnKYIOb8VcZm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Tue, Feb 06, 2024 at 07:13:48PM +0000, Conor Dooley wrote:
> On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
> > The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> > The board features:
> >=20
> > - JH7110 SoC
> > - 1/2/4/8 GiB LPDDR4 DRAM
> > - AXP15060 PMIC
> > - 40 pin GPIO header
> > - 3x USB 3.0 host port
> > - 1x USB 2.0 host port
> > - 1x M.2 E-Key
> > - 1x eMMC slot
> > - 1x MicroSD slot
> > - 1x QSPI Flash
> > - 1x 1Gbps Ethernet port
> > - 1x HDMI port
> > - 1x 2-lane DSI and 1x 4-lane DSI
> > - 1x 2-lane CSI
> >=20
> > Add the devicetree file describing the currently supported features,
> > namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>=20
> Got a dtbs_check issue in the patchwork CI:
>=20
>   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-c=
lock: 'clock-frequency' is a required property
>   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
>   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-c=
lock: 'clock-frequency' is a required property
>   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
>=20
> Can you fix that please? Also, I applied some patches the other day that
> seem to conflict quite a bit with the common board dts patch. Would you
> please do a rebase on top of that please?

Been going through stuff on my todo list now that the merge window is
closed. Could you please resend this with the rebase done?

Thanks,
Conor.

--0VltnKYIOb8VcZm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRgQgAKCRB4tDGHoIJi
0pBPAQCiBXJv2E98EL2KnrNrG4R6lov/fM6sLaACMedaJDc7uQD+L4Rwr/7Nrzcv
3NycjRUFPZtsx0EM7+vyd1cyKFonnw4=
=lyg8
-----END PGP SIGNATURE-----

--0VltnKYIOb8VcZm1--

