Return-Path: <linux-kernel+bounces-27609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F282F2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A5A1F24CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE371CA8E;
	Tue, 16 Jan 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbTy1yY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871991CA96;
	Tue, 16 Jan 2024 17:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F66C433C7;
	Tue, 16 Jan 2024 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705424799;
	bh=mM4aZ0Smj1G4ODpdQlh2X3TH/t0XZAPwOM9uWl64c9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbTy1yY5YxIsWytGQu9ziFjQaRe7cKrNYnXd7y34HcLIZPxluOWFbjDV0Im888hDy
	 7TtkDfwaTTlPwerg5EAYDoz+rU5e8ISdQHVgNZw7Uq1sK42ntiJRNK5d/VFrkaZh/z
	 DobE60Vow1DeHNY1ReyC7/5dnhsNywHRQyxlTu8YZjBrDxeKOj1gMrQX77e6OwUoOc
	 eMuuFZ87vKseu2E5zv4SED7vsGtIOauILPFRi0oeOL54GzuOXOTjdf69Bclz9Vbqas
	 f51Y4wIQDNmPkRpWjaiI6esJclmWhClwKAcSCjKpKexy//WphAWAFS+U19lwonI2ED
	 rq+sG0QVQhcOw==
Date: Tue, 16 Jan 2024 17:06:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rockchip: Document rk809 support for
 rk817 audio codec
Message-ID: <20240116-mangle-parish-93b5cd672d17@spud>
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-2-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HCATQ6nEVgWWIaF+"
Content-Disposition: inline
In-Reply-To: <20240116132102.3272682-2-tim@feathertop.org>


--HCATQ6nEVgWWIaF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:21:00AM +1100, Tim Lunn wrote:
> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
> using the same rk817_codec driver. However it is missing from the
> bindings.
>=20
> Update dt-binding documentation for rk809 to include the audio codec
> properties. This fixes the following warning from dtb check:
>=20
> pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
>    'clock-names', 'clocks', 'codec' do not match any of the regexes:
>    'pinctrl-[0-9]+'
>=20
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
>=20
> (no changes since v1)
>=20
>  .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/=
Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> index 839c0521f1e5..bac2e751e2f2 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> @@ -12,7 +12,7 @@ maintainers:
> =20
>  description: |
>    Rockchip RK809 series PMIC. This device consists of an i2c controlled =
MFD
> -  that includes regulators, an RTC, and power button.
> +  that includes regulators, an RTC, a power button, and an audio codec.
> =20
>  properties:
>    compatible:
> @@ -93,6 +93,34 @@ properties:
>          unevaluatedProperties: false
>      unevaluatedProperties: false
> =20
> +  clocks:
> +    description:
> +      The input clock for the audio codec.
> +
> +  clock-names:
> +    description:
> +      The clock name for the codec clock.
> +    items:
> +      - const: mclk

You have one clock only, why do you need to have clock-names?

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +
> +  '#sound-dai-cells':
> +    description:
> +      Needed for the interpretation of sound dais.
> +    const: 0
> +
> +  codec:
> +    description: |
> +      The child node for the codec to hold additional properties. If no
> +      additional properties are required for the codec, this node can be
> +      omitted.
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      rockchip,mic-in-differential:
> +        type: boolean
> +        description:
> +          Describes if the microphone uses differential mode.
> +
>  allOf:
>    - if:
>        properties:
> --=20
> 2.40.1
>=20

--HCATQ6nEVgWWIaF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa3mgAKCRB4tDGHoIJi
0negAQC6WRkztcA8oUNox2CjFfyLMgPQeNqY0Naid3MIsCE1+AEAoN9U55E3bKoA
xbTlriGwpSuOCwAhptplZHMfaNSOpgk=
=qI+7
-----END PGP SIGNATURE-----

--HCATQ6nEVgWWIaF+--

