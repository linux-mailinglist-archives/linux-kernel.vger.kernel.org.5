Return-Path: <linux-kernel+bounces-22476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FB829E34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21E3B2101E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A994CB23;
	Wed, 10 Jan 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHiKqD8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F84C601;
	Wed, 10 Jan 2024 16:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E03C433C7;
	Wed, 10 Jan 2024 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704902952;
	bh=IN50I227Q+4tz3SlW+Lm0mdV9qShGiS6aGpkLM6W178=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHiKqD8nAhmRJp7OBjKqI0VP6n3+VwxnX3RIEsMeUhSEJYrmLdtmksU6MwlGWnMTx
	 Sy5ZMMfklUS2CmCjyPOPxC/3FVgoPKVvtqpJ6MfHyT6SGMuYFhmi9Osm8Ee0H9D39y
	 AvevsA96j2+nQDRPrs38B/nYglEa6Sev3iILB5oIBvg2o+emQLWoYzFIoZvOA4FjHl
	 qoRluAWEfi1PE2UjotlCUFbBDS3BA7Hv0ADaHOThMT7qy0iN7pbWClwwuVK270tGeH
	 derQkg9ulmojGxOrNL+g5BYe33gkcOyRxwNwhDoZMaNSKKz+tLieykiMXx8n0nSP08
	 1H4XglpDhs+dg==
Date: Wed, 10 Jan 2024 16:09:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl,irqsteer: Add
 power-domains
Message-ID: <20240110-ignore-womanhood-a7ee7caa71f1@spud>
References: <20240110094338.472304-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XO/g/Cc5UWBFhjth"
Content-Disposition: inline
In-Reply-To: <20240110094338.472304-1-alexander.stein@ew.tq-group.com>


--XO/g/Cc5UWBFhjth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:43:38AM +0100, Alexander Stein wrote:
> Some SoC like i.MX8QXP use a power-domain for this IP add it to the
> supported proerties. Fixes the dtbs_check warning:
> freescale/imx8qxp-tqma8xqp-mba8xx.dtb: irqsteer@56000000: 'power-domains'
>  does not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,i=
rqsteer.yaml#
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>=20
> Notes:
>     Please note that both the board dts and the DT node for irqsteer bein=
g used,
>     are still work-in-progress.

The binding doesn't even support the imx8qxp's irqsteer yet, I think
this should be added alongside support for that SoC. Am I missing
something?

Cheers,
Conor.

>=20
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml
> index 20ad4ad82ad64..cb4fcd23627f6 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> @@ -42,6 +42,9 @@ properties:
>    clock-names:
>      const: ipg
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    interrupt-controller: true
> =20
>    "#interrupt-cells":
> --=20
> 2.34.1
>=20

--XO/g/Cc5UWBFhjth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ7BIwAKCRB4tDGHoIJi
0iDfAPsGnjAlrCLhui7Olj6NVOB3GH9pRBv6p7fZCUuQpw7YuQD+IMw/52v3rwa9
cnRkcgZF5tVaI9qo3Cg0Mo8eV2yMkQU=
=pSDe
-----END PGP SIGNATURE-----

--XO/g/Cc5UWBFhjth--

