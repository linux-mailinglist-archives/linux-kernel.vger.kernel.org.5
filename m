Return-Path: <linux-kernel+bounces-73555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0EA85C41E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75473283425
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004F134CE0;
	Tue, 20 Feb 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRal7+Tj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367ED12EBEC;
	Tue, 20 Feb 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455507; cv=none; b=m6K/qAKm7qP4nmE7rvM0oKQ2ZCQ4ZwDtN5P4l4JaRXGtzjsJNaizhBJ49RSUROms7z0TWoIYLkh3MQPyEovnuNKl+lE9CvKBIfBOP+Xxfy96IRuDbH+DF+bJMWSmc+Xdkgj95Y9dgGZlgmtAzQ7TjpYtgKF8iOsbI5XcWI5/TDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455507; c=relaxed/simple;
	bh=4CW+LXiG5f6KUnfcKWM4ar6fdeuFp263jPQ98dKh8To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZPTlK/nHTobypjOTv25YH8u93nyNJj+zhgAIN+NKgG9ztc65odNzREUGrnc1kU9wrCn28g2OlShQlEqPfq+QdCP3UZUZH7/Zte/iQuaM7aD8+HqhTHPLhbo7VXnYXF0IckVzScp/jZyp/4AMtt30MA4m7wrcmme2rYhtlWpcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRal7+Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8244EC433F1;
	Tue, 20 Feb 2024 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708455506;
	bh=4CW+LXiG5f6KUnfcKWM4ar6fdeuFp263jPQ98dKh8To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRal7+Tjf7Yw6mzcb2bExp2WfEpXtJymsOzpnLJOxdxE3uQJ76YtQptlT33ndySIQ
	 QbSlyCDhONv7jXWK7ZMb3JDD0HHrdgswSU9QNtCz7eYLN4beruUcNGHptKIbUVILDB
	 AzO4g1N4Rsi8NV3/ZqwEnff5khPHFHzUqeyJZ1TnNrHopXdEfJ9EwtiJz4GUiZOIr4
	 mNy7F4xsrsfmDvFIq4FfiYf0FV0ievwNv3Ncc8cJD5JAPcsiv4QkqlsdYL/2iXA5Nf
	 s7SeYrZK0dB901IfHMeaqcbYCZtx1cJkBu4Iicwgb6MlLepMijBLMZ/7UBJL5Ljrhp
	 0KXMtRKOd5K6A==
Date: Tue, 20 Feb 2024 18:58:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: Mehdi Djait <mehdi.djait.k@gmail.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 04/14] media: dt-bindings: media: rockchip,px30-vip:
 allow for different variants
Message-ID: <20240220-catchy-cupcake-e600e5af7650@spud>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
 <20240220-v6-8-topic-rk3568-vicap-v1-4-2680a1fa640b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y+i2VP3O5QfWvvRS"
Content-Disposition: inline
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-4-2680a1fa640b@wolfvision.net>


--y+i2VP3O5QfWvvRS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Feb 20, 2024 at 10:39:14AM +0100, Michael Riesch wrote:
> Move the documentation of clocks and resets to a allOf: structure in order
> to allow for different variants of the IP block.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../bindings/media/rockchip,px30-vip.yaml          | 58 ++++++++++++++--=
------
>  1 file changed, 37 insertions(+), 21 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.ya=
ml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> index 675a1ea47210..7168f166798c 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> @@ -24,32 +24,16 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> -  clocks:
> -    items:
> -      - description: ACLK
> -      - description: HCLK
> -      - description: PCLK
> -
> -  clock-names:
> -    items:
> -      - const: aclk
> -      - const: hclk
> -      - const: pclk
> +  clocks: true
> +
> +  clock-names: true

This is, unfortunately, not how we like multiple soc support to be
handled. Instead, the widest constraints are added at the top level
and constrained by the allOf. If none of the names etc are shared, at
least the widest constraints for minItems and maxItems should be able to
be here.

That said, this patch should be squashed with the patch that actually
adds the other device to the binding.

Cheers,
Conor.

> =20
>    iommus:
>      maxItems: 1
> =20
> -  resets:
> -    items:
> -      - description: AXI
> -      - description: AHB
> -      - description: PCLK IN
> +  resets: true
> =20
> -  reset-names:
> -    items:
> -      - const: axi
> -      - const: ahb
> -      - const: pclkin
> +  reset-names: true
> =20
>    power-domains:
>      maxItems: 1
> @@ -85,6 +69,38 @@ required:
>    - clocks
>    - ports
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,px30-vip
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: ACLK
> +            - description: HCLK
> +            - description: PCLK
> +
> +        clock-names:
> +          items:
> +            - const: aclk
> +            - const: hclk
> +            - const: pclk
> +
> +        resets:
> +          items:
> +            - description: AXI
> +            - description: AHB
> +            - description: PCLK IN
> +
> +        reset-names:
> +          items:
> +            - const: axi
> +            - const: ahb
> +            - const: pclkin
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.30.2
>=20

--y+i2VP3O5QfWvvRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdT2TQAKCRB4tDGHoIJi
0tZhAQDtcuqCE1tbyiZKmF78dkxlm/na01H9RkqI8fZC7+braQD/U7aIEwSULwcM
axi2QjcgExsgOX/i6A0txpW/TSVrcAo=
=V7Gm
-----END PGP SIGNATURE-----

--y+i2VP3O5QfWvvRS--

