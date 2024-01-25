Return-Path: <linux-kernel+bounces-39034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303A83C9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E699AB2342D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73B130E4C;
	Thu, 25 Jan 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG7NIfWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B0130E20;
	Thu, 25 Jan 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203479; cv=none; b=cNbAsnnjHV3sV+P45qnfxlS2wvezvu6+38fkUExcYtir+IbyK1O5C7TxAXcqCKjp72TTCTmutlnGsFHi2r1mFDnUD5pP3KglMaV5sO3aqyqSGEB9MUkqinVNCQHFp5uh9+t/8UzuY09q+13KN5eCIcv96RrGxtDWfEnZQcqctZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203479; c=relaxed/simple;
	bh=V9ka2qXzdEJuRAebj5OgqDcPDbq9Epq7uKXZHp+iGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQs0rLytVqxh3wiUxI5At1IycX4ZQqC12AK0V9wJ94KNcEoUW7ru9+05HAHFOMKxX3QkN4HbeF/nC1B4OhSQSY7tel4aqS7XOdo8+G7uPo/eHI1MPLdLoVlJRHaOIXcjRVJTtShYBa1IAR/2gcA6sRD/SDldeSFBqlemPOHyQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG7NIfWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D4BC433F1;
	Thu, 25 Jan 2024 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203478;
	bh=V9ka2qXzdEJuRAebj5OgqDcPDbq9Epq7uKXZHp+iGo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uG7NIfWquPGwy1B0M504M/E9Vfqa6SQZWZtJr2cWJFQ5fS9wZxzvBUlTRnlD5jQBE
	 5fhuaY/ehaxNls8wBkpA6CO/K+GHnl4nrWj1/zPENy7bgfrDz5ht9YTBJkRQkmpoif
	 6+OOz+Sb5E3y1my+VcqD8SJkUyYMhlYWxV6/4xLJX5CCpx5xl31HBB0lBBClTs2avu
	 x0kQUKKZhOPtOx2TBNv1f5nc2/tMXh6wUdvANn+YkBVZ7N0rUUkdyHN2yRX/gjiR0e
	 Cvv2JXimvXnSq3PF75PpnLaHSLtEpekgZ6WANoZrhFNFrdte6j3vvP6/tX+hXwICvc
	 XIYBDim0Nm7lQ==
Date: Thu, 25 Jan 2024 17:24:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	wenhua lin <wenhua.lin1994@gmail.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	zhaochen su <zhaochen.su29@gmail.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH V2 6/6] dt-bindings: pwm: sprd: Add sprd,mod attribute
Message-ID: <20240125-stammer-sandblast-0dcad9e535c0@spud>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
 <20240125025533.10315-7-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ia640Mup0gRbyG16"
Content-Disposition: inline
In-Reply-To: <20240125025533.10315-7-Wenhua.Lin@unisoc.com>


--Ia640Mup0gRbyG16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:55:33AM +0800, Wenhua Lin wrote:
> Add sprd,mod attribute, which set the number of different
> duty cycles that PWM's waveform could output, to dts.
>=20
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sprd.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml b/Docume=
ntation/devicetree/bindings/pwm/pwm-sprd.yaml
> index 02e039fee3b4..7c956b840fa1 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
> @@ -55,6 +55,16 @@ properties:
>      minItems: 4
>      maxItems: 4
> =20
> +  sprd,mod:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 4
> +    items:
> +      minimum: 0xFF
> +      maximum: 0xFFF
> +    description: |
> +      The number of different duty cycles that could be set for PWM's wa=
veform output.

Why is this not a fixed value for a given SoC? Given the description, it
certainly sounds like something that does not vary on a per device
basis.

Thanks,
Conor.

> +
>    "#pwm-cells":
>      const: 2
> =20
> @@ -63,6 +73,7 @@ required:
>    - reg
>    - clocks
>    - clock-names
> +  - sprd,mod
> =20
>  additionalProperties: false
> =20
> @@ -88,6 +99,7 @@ examples:
>                                   <&ext_26m>,
>                                   <&ext_26m>,
>                                   <&ext_26m>;
> +        sprd,mod =3D <0xFF 0x1FF 0x3FF 0xFFF>;
>          #pwm-cells =3D <2>;
>      };
> =20
> --=20
> 2.17.1
>=20

--Ia640Mup0gRbyG16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKZUQAKCRB4tDGHoIJi
0p/4APwOno17wR0ULk3ScAzUFUpYmnfhWHJD4AVnFP5xK4a2ZQEA1ePEUwebT2ZG
YtxYi+oxd1sm4IGeW4GQklWnv0hdBAY=
=24Fz
-----END PGP SIGNATURE-----

--Ia640Mup0gRbyG16--

