Return-Path: <linux-kernel+bounces-31348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02363832CED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53F71F221BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85754F91;
	Fri, 19 Jan 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf+AudPq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F152F84;
	Fri, 19 Jan 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680706; cv=none; b=JogeslxgAwlPgLsvtjM4qH6sb0Fg1STgCD+T9egYozvIwMJ439Qs058EmOCB+DlvVUEtnTR5j9RWUopcQuUJyQmZRZBhALf9q89hf5hGaQgq+eq+XaxoMEmCAV6bYj1cGr5Rj+zUpwOOk+x4vnZSu59arBSyUN+KUI7olbpWEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680706; c=relaxed/simple;
	bh=+skD1Cd21Cux1rhwy4Loe+zv/a/MyUJx8jCiWv0gWcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUS/mKvKwvQgE4OIWzjqweE5mLlsPUJTd7/5Z99ecUbp3FMPbVeII14WtBmFC5e3h2wQccld59YOhEzjajposMVAtGmo82Gk0wLwBKsDUXvr2zabpTwH0AbgRxHMzas7ZDsRhGkTXoBgyLPPvPfepLgWaXmqEUaLAQU89oB8uG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf+AudPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8066C43390;
	Fri, 19 Jan 2024 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680706;
	bh=+skD1Cd21Cux1rhwy4Loe+zv/a/MyUJx8jCiWv0gWcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uf+AudPqoPRw2CG/rHV1Kffa3eWl6QKRrqtmSoJe9FVdMskVAu0ugBpCxGhggmZyS
	 9Oq3ASqWG10ShScumrsntAokrOUy34wthJ+/oGg1Vv/JsS88Zso0Jl+dsQK5ADd+L1
	 QvQrUk5klEGzWqpB4XBqHqhdF0DMcPh1N3GMW2X+EY6N2gjnjQmajySm6UHobM+7/W
	 Hb6nQ4wtI+HgaekBxElXPGdSiYzEXc6pjcxdgUdiwCpIcwfLyRIXkyszTb1odu0RDb
	 ikgxeONpT8Vzjtt4SJNRFkfi4W0T4H9hnmT1mf22OqNY0WqFJv3ZJ3+oqGBgm6HLgw
	 IFRS6UAIhLrTQ==
Date: Fri, 19 Jan 2024 16:11:37 +0000
From: Conor Dooley <conor@kernel.org>
To: "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: s32g: add uSDHC clock IDs
Message-ID: <20240119-magnetic-racing-0adf8e5fbd4a@spud>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
 <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IwcdJ08lEQ0ScTZl"
Content-Disposition: inline
In-Reply-To: <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>


--IwcdJ08lEQ0ScTZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 03:02:28PM +0200, Ghennadi Procopciuc (OSS) wrote:
> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>=20
> Add the SCMI clock IDs for the uSDHC controller present on
> S32G SoCs.
>=20
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> ---
>  include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h
>=20
> diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt-bin=
dings/clock/s32g-scmi-clock.h
> new file mode 100644
> index 000000000000..739f98a924c3
> --- /dev/null
> +++ b/include/dt-bindings/clock/s32g-scmi-clock.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +/*
> + * Copyright 2020-2024 NXP
> + */
> +#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
> +#define _DT_BINDINGS_SCMI_CLK_S32G_H
> +
> +/* uSDHC */
> +#define S32G_SCMI_CLK_USDHC_AHB		31
> +#define S32G_SCMI_CLK_USDHC_MODULE	32
> +#define S32G_SCMI_CLK_USDHC_CORE	33
> +#define S32G_SCMI_CLK_USDHC_MOD32K	34

Why do these numbers not start at 0?

--IwcdJ08lEQ0ScTZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqfOQAKCRB4tDGHoIJi
0m6QAQDkyHsKFGP8Nx5njMmo5n45oTbiIFTNGOPzdthdFHkyAgEA7YBexbTeR4Lj
zdvAD8t9m+g3o/zvlGrCYsXaDDCNkAc=
=2Ek4
-----END PGP SIGNATURE-----

--IwcdJ08lEQ0ScTZl--

