Return-Path: <linux-kernel+bounces-147313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261158A7260
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83B3284158
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEB13342C;
	Tue, 16 Apr 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peVMTXH5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05EF9F0;
	Tue, 16 Apr 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288630; cv=none; b=FACgbarAy11Ie2V//1Is8uY24ekW8CaVrvb4xItmHKz2oCEdFqvro379UPqs4XdlGuUozSPDsJO5QMqRDWQvTjRRZ36X/g6eIUOAbM2QYRinDXLXTCffWuIm+p6ptbbu/kE66gdG7HsHgV1gtT3Y6Hp5KofmFQ9Gc7NmzSr6IKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288630; c=relaxed/simple;
	bh=XS4hUiQRaKWKxZ54JJm6tIu8KmrPOVRJYpat6/cOu/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUqkNDAc1xaGPMMr/5ObBXVyBJ0/HDQF1QbkHp2KApEqkaO09NW6QI8bsgGalUkqFKg6I5zv/Y/VPYTgwZgfC8f7wOhY2YSw+ETnk6UAanCKp8OM5u6yZ5p5e14srLFXHqSIrrsJPuqYxRd2wLu46VfPTCBB7dbaptIh/uZCK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peVMTXH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6269DC113CE;
	Tue, 16 Apr 2024 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713288630;
	bh=XS4hUiQRaKWKxZ54JJm6tIu8KmrPOVRJYpat6/cOu/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peVMTXH5eF7pekueJv97cqfGgMnF5D9QmHNZ/BvBc0ERATh0KcYTfOhZE72qeet5T
	 3qAJjziGx/cr9NSmS4wsvKCgBSsTSCVYeN+A3B+ce2DfyYSt2SyIQHEarZ8LFQT6tY
	 TMulnWeGAIGcHloWMxoBNPpfSnzpBkpCB/BexAIVcoozLjcOx0SCNmGldPQyxtRYVK
	 gCTRzmcywanWRZp2dL0D59SWouf0IwEUcxt2jFoMbBon/mIaFUl611pd41ZwwLLUtx
	 6wpKl0FbZ7e3KFun0wTB6jQ4l2hk2KOXLUXIU7diGh24DqY9N++wFBWtI8UEobEHtX
	 j/E/YI7vuYghQ==
Date: Tue, 16 Apr 2024 18:30:24 +0100
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
Message-ID: <20240416-onion-prone-44b45d5a003e@spud>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-2-angelogioacchino.delregno@collabora.com>
 <20240416-grope-blissful-a914854b3732@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wP1ObGMFQC4n3zme"
Content-Disposition: inline
In-Reply-To: <20240416-grope-blissful-a914854b3732@spud>


--wP1ObGMFQC4n3zme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 06:28:58PM +0100, Conor Dooley wrote:
> On Tue, Apr 16, 2024 at 05:38:00PM +0200, AngeloGioacchino Del Regno wrot=
e:
> > Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
> > Resource Collector (DVFSRC), a hardware module used to collect all the
> > requests from both software and the various remote processors embedded
> > into the SoC and decide about a minimum operating voltage and a minimum
> > DRAM frequency to fulfill those requests in an effort to provide the
> > best achievable performance per watt.
> >=20
> > This hardware IP is capable of transparently performing direct register
> > R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/medi=
atek,mt8183-dvfsrc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt=
8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,=
mt8183-dvfsrc.yaml
> > new file mode 100644
> > index 000000000000..12bcc3fdfd07
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dv=
fsrc.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc=
=2Eyaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek Dynamic Voltage and Frequency Scaling Resource Collect=
or (DVFSRC)
> > +
> > +description:
> > +  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC=
) is a
> > +  Hardware module used to collect all the requests from both software =
and the
> > +  various remote processors embedded into the SoC and decide about a m=
inimum
> > +  operating voltage and a minimum DRAM frequency to fulfill those requ=
ests in
> > +  an effort to provide the best achievable performance per watt.
> > +  This hardware IP is capable of transparently performing direct regis=
ter R/W
> > +  on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> > +
> > +maintainers:
> > +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.co=
m>
> > +  - Henry Chen <henryc.chen@mediatek.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
>=20
> This items should not be needed with the enum, right?
>=20
> > +          - enum:
> > +              - mediatek,mt8183-dvfsrc
> > +              - mediatek,mt8195-dvfsrc
> > +      - items:
> > +          - const: mediatek,mt8192-dvfsrc
> > +          - const: mediatek,mt8195-dvfsrc
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: DVFSRC common register address and length.
> > +
> > +patternProperties:
> > +  "@[0-9a-f]+$":
> > +    type: object
>=20
> Why is there no enforcement of what a child could be here?

Seems like you know exactly what the children are: regulators and an
interconnect? What am I missing?

>=20
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        dvfsrc@10012000 {
>=20
> "dvfsrc" looks like something my (imaginary given allergies) cat would
> produce from sitting on my keyboard. Could you use full words for the
> node name and make it something that attempts to be generic please?
>=20
> > +            compatible =3D "mediatek,mt8195-dvfsrc";
> > +            reg =3D <0 0x10012000 0 0x1000>;
> > +        };
> > +    };
> > --=20
> > 2.44.0
> >=20



--wP1ObGMFQC4n3zme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh61sAAKCRB4tDGHoIJi
0kmFAP93becCTty5zhdZz9iHDigSwk/4jcVZ97Bb+qr2Aa9DnAEA3ztf7bZFSh7q
Dy/w11JkKRpcOGwlnr3cqLVVUtw4zgs=
=XJy2
-----END PGP SIGNATURE-----

--wP1ObGMFQC4n3zme--

