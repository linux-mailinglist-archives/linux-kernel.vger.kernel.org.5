Return-Path: <linux-kernel+bounces-94451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ACD874002
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF97EB21450
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180413E7D9;
	Wed,  6 Mar 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aug0Cwrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AA5FDCC;
	Wed,  6 Mar 2024 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751215; cv=none; b=A0zpjldQgJFhI6wDmodz16+xzjx5G/nG1515pbfmG9ZOKLCHxp3UiDa6sgiackmMTq8r8+KfVmQXeD7qKB9uNtVNJ7SECB7KGdosSgfo2zU7gCyUmzwArqQZO1/bi5+djxf34E24OisxByqyahvBkcPI5E3S2jBOR0dKYq7nK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751215; c=relaxed/simple;
	bh=sNdO9nT79tocdpHlSu6Tel+IFTT6tNR337Bq9tNA2DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlEfVcy6/BTWA+BgBb5EbGnP6cltfZU/bmopYG4TLWwcnQ8qtj2+iOlOfbs86r1UtivCbmbWb6XRmixFTdbw8GQv9p3SXAjJ0rb/vB2j2eW1zHecQRisCQ2a1PE/ljBbyA1lV4C3aSUjv84bVZ/3/hCdElQTRifKtCJgMCChF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aug0Cwrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D10FC433F1;
	Wed,  6 Mar 2024 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709751214;
	bh=sNdO9nT79tocdpHlSu6Tel+IFTT6tNR337Bq9tNA2DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aug0CwrjD0Fj3Uh/SHf0yMg+mCs0N/Ik/CMN4qqQfSX0vcBtRfDMfhaqTwc8X1vOr
	 8NHcAODztGqGSVkOiHjlV63q+rGR/Ri9+5+QcgVjvaNUuWHzuod4JsizNd39WZTaaf
	 obeJjjvNEQJ33eP03jLOOatiMPcXpuVKPvbwxKkMtkDVo7CSs+ujlg8FHQVOcZlbN3
	 tU5TIv8MQcUi2yuDez625vgt5MPdHfurMTiY/H5J1uY/Csigzm8V/F/PipDDfiSvKB
	 B52JwMOZ5BvOrTPxMQGTvEF1SmLapAC8C2guP11EmCmlgQetz2FZYh8oVd1zXafgj3
	 4gLX0BivxOJoQ==
Date: Wed, 6 Mar 2024 18:53:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains property
Message-ID: <20240306-rack-hurling-4ffabd4f507b@spud>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-1-c61b98046591@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JzFOx+mcF0ef70Ss"
Content-Disposition: inline
In-Reply-To: <20240305-asrc_8qxp-v4-1-c61b98046591@nxp.com>


--JzFOx+mcF0ef70Ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 12:33:02PM -0500, Frank Li wrote:
> Add power-domains property for asrc and spdif since fsl,imx8qm-asrc/spdif
> and fsl,imx8qxp-asrc/spdif require 'power-domains'.
>=20
> Set 'power-domains' as required property for compatible string
> fsl,imx8qm-asrc/spdif and fsl,imx8qxp-asrc/spdif.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--JzFOx+mcF0ef70Ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZei7qQAKCRB4tDGHoIJi
0gn7AP0dCMMNi73674NaiMLRXtLe28MNRzsLoBHYAWMCVW3jCAD+LZ5OhLVdWRAs
deG5qWB9TVWh/dGTLOkOMlnBWwJRmQI=
=eERr
-----END PGP SIGNATURE-----

--JzFOx+mcF0ef70Ss--

