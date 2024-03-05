Return-Path: <linux-kernel+bounces-92945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43C87286D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7A61F2B101
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B31272CC;
	Tue,  5 Mar 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/SwgBKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825F12A169;
	Tue,  5 Mar 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669855; cv=none; b=So9kcbtuR8X6RQPr3tgSTcV5GYRTZkEVY1hCiP9O2gnjXanYoON+NjeYgUdBMeo794p4aViCekOvCmOjHIYIskdqgcvfJPk3BLlhl+mPTYN2m7xgC6eAiiljqB/joD5chdqgjcHnRSEUTE4gnWqnU4lfXULOwF47IRydCj2pCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669855; c=relaxed/simple;
	bh=l2EXv8vi0RUW5J6tQuVvt9CmmyBDzyGZCZDvAQCCYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XagY1uZqa7fYVeJE9B+Q9EiElIqOBczxzg4EaC7wpR/9ZSJ1EJjTWZfAH+NfEikSUmSTsWXFP+qImi02XteZHKl1MGgXautBVDgPSCTBFbkLFjNKgv4iXZ+mEeEjuDWVPcYbblKEhQwLDKcMlGoOrEkdLO/x9DiWETjZBWHnlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/SwgBKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F348C433F1;
	Tue,  5 Mar 2024 20:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709669855;
	bh=l2EXv8vi0RUW5J6tQuVvt9CmmyBDzyGZCZDvAQCCYtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/SwgBKiVpbU+gobEaE+khhonkXjX9CcbX3egEb4H59ZT7IOGIb4+PsgVS3LUs6fo
	 JZ0gWaNhTB8v5o60JDAahTmazFPnMJHbMCZgtGDcKIVTcbrGV+348AO+JoJGA1yD7Q
	 HPInfewf2RK9FK9YH4xqjzOQQfzgEfU0pUxwqd9Sd5jqVS8zfMIOOHEQOro75yAZLr
	 YPtacqSp2HSZIYN2XizhHWcGQRvmLyobEOI7WUUDOrjInvpbzrw/kM4UQ2/RiYPR7m
	 WIgxb5S34p0a0UAmYcg//HpJwRXVuYxrgbj2E/KDJJVFuSIhhAOQ5wH79x+nRhpi+f
	 LCE9GRB4i/vJw==
Date: Tue, 5 Mar 2024 20:17:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: devicetree@vger.kernel.org, aford@beaconembedded.com,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: fsl,irqsteer: Allow
 Power Domains
Message-ID: <20240305-derby-grader-ace33d7d4ad1@spud>
References: <20240305035814.74087-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opsqrJQa1Lkfvv8K"
Content-Disposition: inline
In-Reply-To: <20240305035814.74087-1-aford173@gmail.com>


--opsqrJQa1Lkfvv8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:58:13PM -0600, Adam Ford wrote:
> The i.MX8MP HDMI irqsteer depends on the HDMI power domain, so add
> power-domains to the list of items which may be in the device tree.

What about the other irqsteers? If they don't all support power domains,
then please restrict this property to the imx8mp.

Thanks,
Conor.

>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
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
> 2.43.0
>=20

--opsqrJQa1Lkfvv8K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZed92gAKCRB4tDGHoIJi
0jr1APsFbtB3864mzuVtuPpkxDy7QTcQrVND4jRT3rAav+ATagD7By8imbPxDeOC
STrknUo9t6ArZTtoTVEC98BzTy5l8Ao=
=fG/U
-----END PGP SIGNATURE-----

--opsqrJQa1Lkfvv8K--

