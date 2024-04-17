Return-Path: <linux-kernel+bounces-148795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAA8A8787
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75920B230CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B64146D59;
	Wed, 17 Apr 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNpCaVGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B2142625;
	Wed, 17 Apr 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367556; cv=none; b=ZkyQTd45cJWNnJSlu5Joj1cIgyLbsSn+yF87mQufM1S04W5TzhFr5fSE71asFORDrrUHpI7kY30PQ4IHKyJdUGGoUlqmnuvJSn4pPcLEKWpqecpQxYdRn2A+Iigphc41HUTkQqXRvvPP+K3Jm1wPOP61DVjFQRsCiQ3jWd/Datc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367556; c=relaxed/simple;
	bh=ExXTOF7E2XdRHFoRRHZlQyZt3AaGPH9qv/wKJ86w0aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecyjYw/wtyPfsS+Zlj8cnDvBkSTSJQYls0by+gLTDqHRZ5Vlo/D6RWOMSTLR6I3NW/FxnXnoJ3MS4KBFECRymYxWGWSR05rC97AH4HTZ/VMdjY3E2C9KBX26A03TwHBNqeYqtyoJRp+q0aw4D44kjd8WYWziPNJ/JjimrYgH400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNpCaVGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC0C072AA;
	Wed, 17 Apr 2024 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367556;
	bh=ExXTOF7E2XdRHFoRRHZlQyZt3AaGPH9qv/wKJ86w0aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNpCaVGIeW6zkJSGxSCih9gQp5PXISQazsi9Clc9Jd3NQ/N7OQGwS5G5BTJ+zKT4a
	 SY/jEobOaSwYc6BWACjYEw/4PkI1y/942ZEt4W4YPveRlJeuyJZ4w4ZXduuh0oDMg+
	 ACG9FQ8PVJN+KoKh76tUmSpnD94ZhkqydM//fnoB5Z0ZJqt90YxUvTP+tvPkGQz/ha
	 N/6hNXHNtjHGwiWtyTpuGGeKyyr7KR7Ni7YNcjLqWfIWrGIW7BayDO/XumA6XHCB4S
	 /zOIq4m4LxdMfbKoM3KQzj15vxRe5r1HYS3kPOyv3oR+nfXFhySvPa3W6d41zO9jPU
	 GFARGCzD0twLQ==
Date: Wed, 17 Apr 2024 16:25:50 +0100
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
Message-ID: <20240417-fame-cotton-c5c6d40c003d@spud>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-2-angelogioacchino.delregno@collabora.com>
 <20240416-grope-blissful-a914854b3732@spud>
 <20240416-onion-prone-44b45d5a003e@spud>
 <ef29f74b-af21-4807-8d72-0e627586a288@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tUWCs0nZ7Ll4Hx8L"
Content-Disposition: inline
In-Reply-To: <ef29f74b-af21-4807-8d72-0e627586a288@collabora.com>


--tUWCs0nZ7Ll4Hx8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:26:06AM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/04/24 19:30, Conor Dooley ha scritto:
> > On Tue, Apr 16, 2024 at 06:28:58PM +0100, Conor Dooley wrote:
> > > On Tue, Apr 16, 2024 at 05:38:00PM +0200, AngeloGioacchino Del Regno =
wrote:
> > > > Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
> > > > Resource Collector (DVFSRC), a hardware module used to collect all =
the
> > > > requests from both software and the various remote processors embed=
ded
> > > > into the SoC and decide about a minimum operating voltage and a min=
imum
> > > > DRAM frequency to fulfill those requests in an effort to provide the
> > > > best achievable performance per watt.
> > > >=20
> > > > This hardware IP is capable of transparently performing direct regi=
ster
> > > > R/W on all of the DVFSRC-controlled regulators and SoC bandwidth kn=
obs.
> > > >=20
> > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregn=
o@collabora.com>
> > > > ---
> > > >   .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 57 ++++++++++++++=
+++++
> > > >   1 file changed, 57 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/soc/mediatek=
/mediatek,mt8183-dvfsrc.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediate=
k,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/media=
tek,mt8183-dvfsrc.yaml
> > > > new file mode 100644
> > > > index 000000000000..12bcc3fdfd07
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt818=
3-dvfsrc.yaml
> > > > @@ -0,0 +1,57 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dv=
fsrc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: MediaTek Dynamic Voltage and Frequency Scaling Resource Col=
lector (DVFSRC)
> > > > +
> > > > +description:
> > > > +  The Dynamic Voltage and Frequency Scaling Resource Collector (DV=
FSRC) is a
> > > > +  Hardware module used to collect all the requests from both softw=
are and the
> > > > +  various remote processors embedded into the SoC and decide about=
 a minimum
> > > > +  operating voltage and a minimum DRAM frequency to fulfill those =
requests in
> > > > +  an effort to provide the best achievable performance per watt.
> > > > +  This hardware IP is capable of transparently performing direct r=
egister R/W
> > > > +  on all of the DVFSRC-controlled regulators and SoC bandwidth kno=
bs.
> > > > +
> > > > +maintainers:
> > > > +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> > > > +  - Henry Chen <henryc.chen@mediatek.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > >=20
> > > This items should not be needed with the enum, right?
> > >=20
>=20
> Whoops. Yep items is not needed.
>=20
> > > > +          - enum:
> > > > +              - mediatek,mt8183-dvfsrc
> > > > +              - mediatek,mt8195-dvfsrc
> > > > +      - items:
> > > > +          - const: mediatek,mt8192-dvfsrc
> > > > +          - const: mediatek,mt8195-dvfsrc
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description: DVFSRC common register address and length.
> > > > +
> > > > +patternProperties:
> > > > +  "@[0-9a-f]+$":
> > > > +    type: object
> > >=20
> > > Why is there no enforcement of what a child could be here?
> >=20
> > Seems like you know exactly what the children are: regulators and an
> > interconnect? What am I missing?
> >=20
>=20
> I wasn't sure whether that would've been a good idea, given that there wi=
ll
> be more possible children in the future - as in - more drivers that need =
the
> DVFSRC communication.

If there's no additional hardware, just additional drivers wanting to
use this, there's no need to modify the dt, you just call
platform_device_register() to spin up the new drivers.

> But anyway yes, for now, it's just the regulator and interconnect drivers.

We can always free it up whenever new requirements appear.

> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    soc {
> > > > +        #address-cells =3D <2>;
> > > > +        #size-cells =3D <2>;
> > > > +
> > > > +        dvfsrc@10012000 {
> > >=20
> > > "dvfsrc" looks like something my (imaginary given allergies) cat would
>=20
> (allergies: ugh, same here - feel you)
>=20
> > > produce from sitting on my keyboard. Could you use full words for the
> > > node name and make it something that attempts to be generic please?
> > >=20
>=20
> I'm not entirely sure that I can find a generic name for this... I wonder=
 if
> "remoteproc" could work - as this is a remote processor (a MCU, actually).
>=20
> To give you context, this doesn't need firmware to be loaded, and does no=
t have
> any remoteproc driver.

I dunno, I don't think having to load firmware to something or interact
with a remoteproc driver in linux changes what the hardware actually is.
>=20
> Because then, I don't think that "performance-controller" would be correc=
t,
> even though I have this N.2 choice... ideas?

My lot call this type of thing a "system controller" in our specs. Any of
firmware, remote-processor, performance-controller all seem valid to me.

> Cheers,

Cheers,
Conor.

--tUWCs0nZ7Ll4Hx8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/p/gAKCRB4tDGHoIJi
0lEeAP9ODgsxAxqY6EugFK0v+xBoTRrFSYYNmBEiyjKsBl58iwEApvmNdrMatUuk
K3JRuZZ5UsqYCh5o+lFttCQJm55Rugk=
=bY+B
-----END PGP SIGNATURE-----

--tUWCs0nZ7Ll4Hx8L--

