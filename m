Return-Path: <linux-kernel+bounces-29144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1D830988
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B301F21BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA7219F3;
	Wed, 17 Jan 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unp4VVa0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5721366;
	Wed, 17 Jan 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504610; cv=none; b=FfSYAmLSPxqr80d1xl5vPaXKct5HjH4ZJD7MfL+qiHmUqdTY8XN8axBxOOf3cDMw10NdNc2HhIkyx9WPWJ0k+gmXGDcHuFs2HRah1KUXu8d8DLPgxYZpIENJltjBa/HgPHQz9WemXUTNH+A0NTnkq+1hdmPc3qpdJthyUC3IPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504610; c=relaxed/simple;
	bh=mBE9BOHTIZdE/jrFvh00lCztdXiLr/PMRIPEllEfPts=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=mC4sgN3Cny/u28j1a9at9Z2MD54R0W2jYY2OZX6SA0Mlu5UHmbgbPZ6cojaRR1cy+b37fGTy416QAwYfm3L3ajKCG3tTV8YJfLT3VzwJWPDQVtDNAB39oessB8in9ous1squMhFspdA00uxCd5vwF+yF5ZOgEnjzRD8NmZJDHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Unp4VVa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DDC433F1;
	Wed, 17 Jan 2024 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705504610;
	bh=mBE9BOHTIZdE/jrFvh00lCztdXiLr/PMRIPEllEfPts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Unp4VVa0HPsGHHdZ2Y/5hVTV5PTs1qhxC6GRRacnC2JnJvNhFzbHkyA3Mf2dXV2wx
	 TCl01n7CB7xdPyq2hd0+8wfndvDiPcE3PQtlEKFqz6yWzA8sOZgH4Jgqsh8Gx8Djg2
	 iFR/vaC3jz4go0lpuucZhJmbVXBgn4XK9ftSnYfS3D+wM2oE0/5PGTjibsN/Qhtu28
	 0TfYvMAqKw/NHituiQBAEl0kPK7dU0BTvBpZlhSeV/2lCbVxnctV8WlpyP/DmsZ2dD
	 hcmtc6aZ+XqV6RaA+2QDnNbop7U9VoDCYtBbW8Oqsh2loR3Fl3jCz7Uoh/22Jyg/Zr
	 bLpznb/ILPLOQ==
Date: Wed, 17 Jan 2024 15:16:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, miquel.raynal@bootlin.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH] dt-bindings: mfd: ti,am3359-tscadc: Make dmas &
 dma-names optional
Message-ID: <20240117-moistness-directory-e3dc0cd1c7c0@spud>
References: <20240117052104.747333-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EQKeQlNgSG3qg3tq"
Content-Disposition: inline
In-Reply-To: <20240117052104.747333-1-w.egorov@phytec.de>


--EQKeQlNgSG3qg3tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 06:21:04AM +0100, Wadim Egorov wrote:
> The driver does not require dmas or dma-names to be configured for the
> ADC to work properly. Remove dmas and dma-names from the required
> property list.

You say "the driver" - I assume that this is the linux driver. What
about drivers for other operating systems?

Thanks,
Conor.

>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml =
b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> index 23a63265be3c..70b5dfce07d2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -61,8 +61,6 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> -  - dmas
> -  - dma-names
> =20
>  additionalProperties: false
> =20
> --=20
> 2.25.1
>=20

--EQKeQlNgSG3qg3tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZafvXQAKCRB4tDGHoIJi
0qZHAPoD8IK/BeBMUM7Cx9AesB+DAlDWmmuDPt7qr0hwBEMQlAEA0YyfenyGDvmy
oWeQHVfNmVMOPkgYJ+7z3FmZXHJ2NQI=
=Wd5S
-----END PGP SIGNATURE-----

--EQKeQlNgSG3qg3tq--

