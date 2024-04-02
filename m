Return-Path: <linux-kernel+bounces-128490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BE895B89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B552847EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE715AD8C;
	Tue,  2 Apr 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPQ+yVrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68E15A48E;
	Tue,  2 Apr 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081805; cv=none; b=fdH1N69mNg/5HeiyOCQGgKBYB859EKTHF/tIhYANgPsiWxqah8aQhca9nc0KCXJUDspHtrIV/RLJ9wn5K1HVg52X/31dfWfWNca6LCBeoIXDfrDEfzABN15iafVn+2Fh7da9LlRpXB05Qo7CBuTij3nSqn8Y3+NXOqVuJVdm5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081805; c=relaxed/simple;
	bh=8BiCVmFy63V+eTl/AVpgSOVQf6tyNbleMPcurdNocRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Pdq/Fi8T4kyLkVO76tVXARWcI2Q7HcI6NhDSsmiqg9hRaz89FsSIZuX2DPzpcV/blb4gnUa7GVTVGJLDdGtAiHIhcnZ+PeZ5Snq4gLlq1izO4FY5Nz2vSm120xwcKpKWIE6w2Whk1FW2y5xCVbXdqVGLL5yPcjWzv1HhXVufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPQ+yVrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C1CC433F1;
	Tue,  2 Apr 2024 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081804;
	bh=8BiCVmFy63V+eTl/AVpgSOVQf6tyNbleMPcurdNocRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPQ+yVrhybRzaIex8t/Hk+wwzspXlSqzA3gd0X34712H/2JZzhn15PzeqYsvGC7q9
	 XYJtskpCf6TBGD4zdCMhhZ80osvFEa5KkqhNqnc4cXh9/lfyxN2o9Vm/ifkPQDDdkb
	 ygjWtSFH+QNheytGnh+8DO1jEtUnut1d8IBi5NOhd9UHu1Ud+AdwnNDAeut/jx0pAK
	 Q/WG8A3IfIMjC8oFEpYZQk8IggcPvwhliTlvEBw4Ada/K0cqsp0ufYfYDfOsZqIbjO
	 U7hEkR3btoXiXN3mdMOscNyNN8pBv0BOXEQjOLvRT6sTYotMkMvIEWsL3uI/jzB4aL
	 Xt9YBatK9DXTg==
Date: Tue, 2 Apr 2024 19:16:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240402-anemic-aerospace-bc428fff280c@spud>
References: <1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com>
 <1712036704-21064-3-git-send-email-hongxing.zhu@nxp.com>
 <ZgwU8edE3VFYngWR@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uXgaz3Nbx29M47AI"
Content-Disposition: inline
In-Reply-To: <ZgwU8edE3VFYngWR@lizhi-Precision-Tower-5810>


--uXgaz3Nbx29M47AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 10:23:45AM -0400, Frank Li wrote:
> On Tue, Apr 02, 2024 at 01:45:03PM +0800, Richard Zhu wrote:
> > Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> > - Use the controller ID to specify which controller is binded to the
> > PHY.
> > - Introduce one HSIO configuration, mandatory required to set
> > "PCIE_AB_SELECT" and "PHY_X1_EPCS_SEL" during the initialization.
> >=20
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> You missed all conor's comments.=20
> Please double check v1's comments.

> > +  fsl,refclk-pad-mode:
> > +    description: |
> > +      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
> > +      refclock is derived from SoC internal source), INPUT(PHY refclock
> > +      is provided externally via the refclk pad) or OUTPUT(PHY refclock
> > +      is derived from SoC internal source and provided on the refclk p=
ad).
> > +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> > +      to be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2 ]
>=20
> I remember needn't enum because there are header file.

Yah, specifically my comments about this property were missed and were
probably the most meaningful comments I left.

Thanks for the reminder Frank.

--uXgaz3Nbx29M47AI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxLhwAKCRB4tDGHoIJi
0pZcAQCTI+cY1udLcUNjtBNe7Lo4O6o7chZeO/Kb4VgRbXUqoQD+ML1p+97bAlvQ
s82SO4faNQLQqwutH9R/sp+ZuAP4PQQ=
=KOqW
-----END PGP SIGNATURE-----

--uXgaz3Nbx29M47AI--

