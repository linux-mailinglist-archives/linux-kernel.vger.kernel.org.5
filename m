Return-Path: <linux-kernel+bounces-135719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B7C89CA38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0BC287C64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06161142E9C;
	Mon,  8 Apr 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7+jORCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F41428F0;
	Mon,  8 Apr 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595792; cv=none; b=HHEqDXdxIO6xdguIiQqk75EP2ZaDVjJFmTXcn8qD19QUhKvm79EWH9lDKM+mHxD+agsadP/EAuxkTpHNTO0PAUWo1lNlDpcK7B0K3P4g7ipJM2YATA6eRf+ijEs6jQcfHGHx8CRkrdl0pCbHRo0eJ81H5LaHgmxCVmxdfXmERPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595792; c=relaxed/simple;
	bh=ANT4FZdfZseVFVw6Nz7AxKNIfXcpdibg2ihifdlXaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5HQOerPV0aGSde9tvdH+5CeXhT004LZ/YXwyqKyVQxnHCWeCdI1y16mOzGl9XnVhBlwEwbsIMjVlJ3oWqQBNOqRZ/mn+1kWDdCTdB+7F+gIQQg0yCjRvBLWbfTG4mkEb2cKGx/SRfQvcKg8LShN2ZLTQ2GCwDmDAub6DB8SWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7+jORCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F8C433F1;
	Mon,  8 Apr 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712595791;
	bh=ANT4FZdfZseVFVw6Nz7AxKNIfXcpdibg2ihifdlXaMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7+jORCduU22JxlfHMQ0+Emv+dDKJPXhS5V6GO0eOEJMqsFZbm51aSmHXKL+EhQKt
	 /5VYVOH5eUgzB+QSlcDXxABTcYWqiRyGhnzhtHX4954+o6vsHO5vfZkSQsUELdURPD
	 PfzCWk5hcEPo7avQ5v+Uoq1XzRTx/tgNsFJsLfBRcN/Nx8h9OfvBOfW5XMAhAxRDNP
	 TYvdpV+x/NdhjO47/FFyrmWG2YPOLXKKABzduej5kr6yGayn4vZtEmFisz3TMfFoXl
	 G1h5u1ZIpy2NBpHa+hBrdXm3SN3ag8JnSaqQHqCBnAykj3+OW7to48dRGONPxMwD/R
	 oOOJHoCC2EJVw==
Date: Mon, 8 Apr 2024 18:03:06 +0100
From: Conor Dooley <conor@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
Message-ID: <20240408-friction-mosaic-ba48bc27788d@spud>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pc67qC+tpVYwcPxp"
Content-Disposition: inline
In-Reply-To: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>


--pc67qC+tpVYwcPxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 11:09:52AM +0300, Nikita Shubin via B4 Relay wrote:
> The goal is to recieve ACKs.

I dont see a maintainers entry in -rc1 for the drivers/soc/cirrus
portion. Who is gonna give you an Ack for that portion? If you intended
maintaining that driver, should you not add a MAINTAINERS entry for it?

Thanks,
Conor.

>=20
> This is a fraction of v9 "ep93xx device tree conversion" series:
>=20
> https://lore.kernel.org/all/20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me/
>=20
> The clk driver for ep93xx was converted to AUX device, as suggested
> originally by Stephen Boyd.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Nikita Shubin (4):
>       ARM: ep93xx: add regmap aux_dev
>       clk: ep93xx: add DT support for Cirrus EP93xx
>       dt-bindings: soc: Add Cirrus EP93xx
>       soc: Add SoC driver for Cirrus ep93xx
>=20
>  .../bindings/arm/cirrus/cirrus,ep9301.yaml         |  38 +
>  .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |  94 +++
>  drivers/clk/Kconfig                                |   8 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-ep93xx.c                           | 840 +++++++++++++++=
++++++
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/cirrus/Kconfig                         |  13 +
>  drivers/soc/cirrus/Makefile                        |   2 +
>  drivers/soc/cirrus/soc-ep93xx.c                    | 240 ++++++
>  include/dt-bindings/clock/cirrus,ep9301-syscon.h   |  46 ++
>  include/linux/soc/cirrus/ep93xx.h                  |  26 +
>  12 files changed, 1310 insertions(+)
> ---
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> change-id: 20240408-ep93xx-clk-657a1357de67
>=20
> Best regards,
> --=20
> Nikita Shubin <nikita.shubin@maquefel.me>
>=20
>=20

--pc67qC+tpVYwcPxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhQjSgAKCRB4tDGHoIJi
0twqAP9cedccziELIxDEm3H8XNGNoWKNb0cqmUBpB+KT5b1E3gD/eS70Lg7vFl4f
y42aBtqmffeu3MDOoyR6cGSJX6ua6gM=
=0o+E
-----END PGP SIGNATURE-----

--pc67qC+tpVYwcPxp--

