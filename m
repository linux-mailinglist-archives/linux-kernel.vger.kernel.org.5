Return-Path: <linux-kernel+bounces-85021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495686AF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2011A2853B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3657145B27;
	Wed, 28 Feb 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRsfQdix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1973515;
	Wed, 28 Feb 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123733; cv=none; b=u8pq6XuSo18Ubc8oHyc3WlW+Hj2TWp1Ef34eBBLS2lmyNJUMN6IyDbRVlp1+f29I6wh4Tt5pjWyv3DQooBbIAu2MGkTjvFo9gihruH/RiT5K6nTQbJaIjiS/SS8jHzgzvhmtjxx83VbI3IalqZUMfPQR8VGu2FPyFM7YF36G2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123733; c=relaxed/simple;
	bh=1pgQK9aLsh1QMqOUlKhfXXSUFpsP/N2g45/FWso6So8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8FmC9VRtQz2O9M3sgUSPTyVsE4y5GIf7NpKvJx+HplDSN23JMC4wbVqrEtgqGp6Sk4l7PQ9gukwlU/ay0oqsSTh0yzTNs/EbPj4DB3RRMkz263rFnDDf+RXl51Juch8w8YTz0aD+/OtN4XVwUVJAchoATnQzErEs9SdE2SUfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRsfQdix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB383C433C7;
	Wed, 28 Feb 2024 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709123732;
	bh=1pgQK9aLsh1QMqOUlKhfXXSUFpsP/N2g45/FWso6So8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRsfQdix7XWJKfb1kO6HlWBrvkbStw5DRWlEnOars3/UDUOGEQyfY3vwBr/th6Ezf
	 CimDkwlK2M79QAFu+U74bHA1i9LnEFtE2Bc3vYKTYSvJci+/4ktWoHeOB/jSrsGa5P
	 2obnt2ZE419sifS5mkf21DbO9l7s/taAoEkYuIhXQotnPSssERAuSGINUQvHbtHjWv
	 zwNdz06lmqWAB6BNiAOsMnwDL2tXbvA5j/UMOxjQfl2ClPnUh2PyjBxmoKPsHbUJqa
	 feuRWz4HwXOkrs392FZXRj2PFFkXolZL+Wa84wYDpZMvf0Ga5wv8si43HrgtuTQSCw
	 twKT7mXZfnoRw==
Date: Wed, 28 Feb 2024 12:35:28 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: tglx@linutronix.de, maz@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	l.stach@pengutronix.de, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: fsl,irqsteer: Add
 power-domains entry
Message-ID: <20240228-sphere-stylus-71b9189fd93b@spud>
References: <20240226130516.3821803-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MqZO6m3bS8tHuDyQ"
Content-Disposition: inline
In-Reply-To: <20240226130516.3821803-1-peng.fan@oss.nxp.com>


--MqZO6m3bS8tHuDyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:05:16PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add optional power-domains entry for i.MX95 usage

If it is only for the imx95, please limit it to that device only.

Thanks,
Conor.

>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml
> index 20ad4ad82ad6..7ccbb96434a4 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> @@ -59,6 +59,9 @@ properties:
>        u32 value representing the number of input interrupts of this chan=
nel,
>        should be multiple of 32 input interrupts and up to 512 interrupts.
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.37.1
>=20

--MqZO6m3bS8tHuDyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8okAAKCRB4tDGHoIJi
0oJgAQDZp4EzUmU6mEyQ8YKgbJyEAgDn64J20y010rhh+fiVagD/SCjsJxtvr+sP
ogt3rgFXqhd6pocLmSNLno3bcSy2sAA=
=232Z
-----END PGP SIGNATURE-----

--MqZO6m3bS8tHuDyQ--

