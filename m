Return-Path: <linux-kernel+bounces-147311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6199B8A724D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202372812F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95113340D;
	Tue, 16 Apr 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N088a8C9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC17132C1F;
	Tue, 16 Apr 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288545; cv=none; b=JtS/xhOWW4eFmcDR+8RNYQU8Un1ANY5CspaHKX9XDY5MrOM64UvgReWxeT9lzml23Gw+Xu6frKT1Q3y97+lNOkYgD0SzU2b8UqprbgtqZxQyDW8eic9+nSKQmdGc2C53KWM/EjG9Lc8/dE3pKfr/Q75vvHfdcW03h4sj2dWsNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288545; c=relaxed/simple;
	bh=pzLiPf2BmuAp4EQPnQxHsJQ/UQhL2QfZVqplzTySip0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a147pu4TpOtuzElRm0d/G/KN4Mj4ZhxEoc7S3n5t30oIYB99+CzSSaAhzGOfYdQ/eRN3dC6vJn1bHAAuFyzQf4tl/A8XNAwbJKMEzfzK5txS1kbztUge6eNwwpuWAyAIBs9xZMHXIp1/OLZDtPyaiXWsI3SBPIWZgKnjq+Hp0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N088a8C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04842C113CE;
	Tue, 16 Apr 2024 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713288544;
	bh=pzLiPf2BmuAp4EQPnQxHsJQ/UQhL2QfZVqplzTySip0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N088a8C9FmN1VDWp65w6E1bCyNFVGRowbzimjCqepdy/ECyTGaVp+1KASSq2Txbmz
	 bAzLr+c/xvmHHlAIHlhx8UY4DCAxN/RJbnduYekj3LMv0sD5mOqSn2dwun4A3FLg/l
	 yo9r9tuaYG/JgCEBkKi0lT3a8Yzk9aj84ckvsJFP23ytkKLj44JgTbaTLzg+wfcDof
	 3GRbca/uy/VeOXkBCvUfrs4AXmScm1vs1zerx8bdj+FEskS/d22VJ4mL+y29CoTF/z
	 sM6OS8/Mee1L9NqdFcTCZiLNimgzBEP8SSEL7IvhPyzMYniKdWrCf1OHNSXhlYl4fO
	 wUoYVFFjPcG2w==
Date: Tue, 16 Apr 2024 18:28:58 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com
Subject: Re: [PATCH v1 1/6] dt-bindings: soc: mediatek: Add DVFSRC bindings
 for MT8183 and MT8195
Message-ID: <20240416-grope-blissful-a914854b3732@spud>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="29wYAvcTm3T+HZi+"
Content-Disposition: inline
In-Reply-To: <20240416153805.431118-2-angelogioacchino.delregno@collabora.com>


--29wYAvcTm3T+HZi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:38:00PM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
> Resource Collector (DVFSRC), a hardware module used to collect all the
> requests from both software and the various remote processors embedded
> into the SoC and decide about a minimum operating voltage and a minimum
> DRAM frequency to fulfill those requests in an effort to provide the
> best achievable performance per watt.
>=20
> This hardware IP is capable of transparently performing direct register
> R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediat=
ek,mt8183-dvfsrc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt81=
83-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt=
8183-dvfsrc.yaml
> new file mode 100644
> index 000000000000..12bcc3fdfd07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfs=
rc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Dynamic Voltage and Frequency Scaling Resource Collector=
 (DVFSRC)
> +
> +description:
> +  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) =
is a
> +  Hardware module used to collect all the requests from both software an=
d the
> +  various remote processors embedded into the SoC and decide about a min=
imum
> +  operating voltage and a minimum DRAM frequency to fulfill those reques=
ts in
> +  an effort to provide the best achievable performance per watt.
> +  This hardware IP is capable of transparently performing direct registe=
r R/W
> +  on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +  - Henry Chen <henryc.chen@mediatek.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

This items should not be needed with the enum, right?

> +          - enum:
> +              - mediatek,mt8183-dvfsrc
> +              - mediatek,mt8195-dvfsrc
> +      - items:
> +          - const: mediatek,mt8192-dvfsrc
> +          - const: mediatek,mt8195-dvfsrc
> +
> +  reg:
> +    maxItems: 1
> +    description: DVFSRC common register address and length.
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object

Why is there no enforcement of what a child could be here?

> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        dvfsrc@10012000 {

"dvfsrc" looks like something my (imaginary given allergies) cat would
produce from sitting on my keyboard. Could you use full words for the
node name and make it something that attempts to be generic please?

> +            compatible =3D "mediatek,mt8195-dvfsrc";
> +            reg =3D <0 0x10012000 0 0x1000>;
> +        };
> +    };
> --=20
> 2.44.0
>=20

--29wYAvcTm3T+HZi+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh61WgAKCRB4tDGHoIJi
0nNWAQCySaXXigINWOe/Zbh6nvFd8lAElm6OUs1rfgKt63696wD/R+RgIT2mRIEQ
WUVPpbyXy3TS22RWrWgU0ZHHesGKRgg=
=DGfI
-----END PGP SIGNATURE-----

--29wYAvcTm3T+HZi+--

