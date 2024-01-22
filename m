Return-Path: <linux-kernel+bounces-33884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DD836FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE421287848
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5E51C4C;
	Mon, 22 Jan 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYOl3uZ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785151026;
	Mon, 22 Jan 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946420; cv=none; b=oGBjMTEM2fqxtuuJAIqHzYejyKV17yWJ+iUuvxxMYP6jJ/x3XzzRNNCEG07dSJLtJrz0uPQkK/XeHpVSv/NMGidwJCbR6QzrpKB9rcOTI577l9+qPVZBRgXaSPKMa5np68bIleWo9/dW4KUKm4++tvLNTtN/0XCzfRzIvdZmbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946420; c=relaxed/simple;
	bh=MEx6fJrAlgplstfDKSw5stdpiSQ0xarAZZIl0igTa4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5SsZOZpwaZTygPirr3oz8z/+9/h9yjUa01jcCy/eeblX+/zbR/sG7xLBcfAtL2j0uHVLorNVAL+jLNawySGt6sjomZ/K9hMbCsfjpLifZDPMJWJaKPAUyz0g/oZOVcUWlGqTIBPMZSJt3joSQUzR+G8Rrivfp0ltRg5yzDlAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYOl3uZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4213C433C7;
	Mon, 22 Jan 2024 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946419;
	bh=MEx6fJrAlgplstfDKSw5stdpiSQ0xarAZZIl0igTa4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYOl3uZ/r/W9FEr43Av1g/VvFBhS8477EX6xGQkw18n+z38oKrbqIYspDxp8hpZNC
	 BNHKIYJ37+3uERL9o6h/aasj4a4EAZqwOVAtqRrgBs/KkmbTVopfHclCP/6XRMpGP5
	 5PT+1vxqw3g6/F78QXEGVhjJCsR8xbDjOLTYz4R6h0A1h1pl73Yr11z2h+GW0tgtqr
	 txju67JyQsoOegaCTfrJej8qmplWdsXedmkgCXf3Ainb0Tm34XkCyrrtXQ86FFInJC
	 WLpvY/Q+c461BzVMh3YuEUmWXf/siqJT1PCtmm98V733zIw306ykojjpJY7308x54c
	 +xDY5yviZFq3Q==
Date: Mon, 22 Jan 2024 18:00:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
	KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
	scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <20240122-daunting-woof-19fac5689bb2@spud>
References: <20240122095650.60523-1-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ozOZKuBm4zqCXBiO"
Content-Disposition: inline
In-Reply-To: <20240122095650.60523-1-wtli@nuvoton.com>


--ozOZKuBm4zqCXBiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 05:56:49PM +0800, Seven Lee wrote:
> Added a DT schema for describing nau8325 audio amplifiers.
>=20
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau83=
25.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml=
 b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> new file mode 100644
> index 000000000000..9105985357aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAU8325 audio Amplifier
> +
> +maintainers:
> +  - Seven Lee <WTLI@nuvoton.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,nau8325
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,vref-impedance:

I know this property already has users, but this is a new device and you
are writing a new driver from scratch, could you instead call it
"nuvoton,vref-impedance-ohms" and make the options the impednances
themselves?

The absence of the property could then be used to indicate that it is an
open circuit?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      VREF impedance selection.
> +    enum:
> +      - 0 # Open
> +      - 1 # 25kOhm
> +      - 2 # 125kOhm
> +      - 3 # 2.5kOhm
> +    default: 2
> +
> +  nuvoton,dac-vref:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      DAC Reference Voltage Setting.
> +    enum:
> +      - 0 # VDDA
> +      - 1 # VDDA*1.5/1.8V
> +      - 2 # VDDA*1.6/1.8V
> +      - 3 # VDDA*1.7/1.8V

I would also rather than this enum was used to have sensible values for
the enum itself (which I suppose means strings here), rather than the
register values. Seeing "nuvoton,dac-vref =3D <2>" in a devicetree is not
very meaningful IMO.

Cheers,
Conor.

> +    default: 2
> +
> +  nuvoton,alc-enable:
> +    description:
> +      Enable digital automatic level control (ALC) function.
> +    type: boolean
> +
> +  nuvoton,clock-detection-disable:
> +    description:
> +      When clock detection is enabled, it will detect whether MCLK
> +      and FS are within the range. MCLK range is from 2.048MHz to 24.576=
MHz.
> +      FS range is from 8kHz to 96kHz.
> +    type: boolean
> +
> +  nuvoton,clock-det-data:
> +    description:
> +      Request clock detection to require 2048 non-zero samples before en=
abling
> +      the audio paths. If set then non-zero samples is required, otherwi=
se it
> +      doesn't matter.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        codec@21 {
> +            compatible =3D "nuvoton,nau8325";
> +            reg =3D <0x21>;
> +            nuvoton,vref-impedance =3D <2>;
> +            nuvoton,dac-vref =3D <2>;
> +            nuvoton,alc-enable;
> +            nuvoton,clock-det-data;
> +        };
> +    };
> --=20
> 2.25.1
>=20

--ozOZKuBm4zqCXBiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6tLgAKCRB4tDGHoIJi
0kInAQD2wiz5P1EmfjIPuiLPGoHAsvUKWrqo4jhy7dEavxbbPQEAsqYcBXruVOBh
gFGDyeRQY1oic2J6Iyn8ZbI3S+PANgc=
=vEaT
-----END PGP SIGNATURE-----

--ozOZKuBm4zqCXBiO--

