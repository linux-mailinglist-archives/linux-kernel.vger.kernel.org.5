Return-Path: <linux-kernel+bounces-37316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59BF83AE29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D28228880B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803147CF1C;
	Wed, 24 Jan 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9Q8tohb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7657CF03;
	Wed, 24 Jan 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112978; cv=none; b=n0iReUBG/HFwW5ZXTxtX9wcMq3QVuArw1UtkjqiCmMGDzx4UvS29W8yf7AoOur/9/QMygpheUQ1EuzQ4uuyRBg3ANF5K3zyeE71QPcwOrnqHWC0zC3EIiQBjdzy8HPOl1WnvSP1x2uqTVTxEHW+G/yz2aowK8v716orVoo9zmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112978; c=relaxed/simple;
	bh=/Y+fj7oNVpD22CS0LwKmfcpc8EY7p2jBwyx6uzCSGuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snC3OmL0tTLzFhO5YlUI5fGCzFoA0FjbLOOV1pT9Oed1a7DqHkSDcOHfyQb23HSTSb+hikIPpP0J5wWn/prfuX1JmJRBBv2COvQvMsEhZcEDUwckb3g2NfSNBB2X4FU/7Zu249/vELyZdMujyXoSxMCV22YMKmdHL17nHcY/5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9Q8tohb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565D9C433C7;
	Wed, 24 Jan 2024 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112978;
	bh=/Y+fj7oNVpD22CS0LwKmfcpc8EY7p2jBwyx6uzCSGuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9Q8tohbTthid5ztVhtaVxbxx3yvOdQKUGlWCsQJ/OuscgR3JRyNUUgeUaVE2oOuk
	 +bJVlq2yiLjhBKHSNVcXFz1p7rVrs3/FvBxevhML7MgFgKsXtg0iHtDEkZ6yaEpLiY
	 ysVuXtpPNV5eia0sqv3dN3o73bDlp2nNQWehBv20mhQa83AObgUirj5+zeBUGltVg0
	 W7UHH0Bv8RvzuXR7iLqdQr6enjKqzeg/mYv2oNIHLgjTPODb94VCj8PGhUz04N3aJV
	 T/ZGpK2RsIP4TuFd3N93fvhybWUxff+jgO5y9dtJZ357UV0iMFdA9GmufN3kFRvuDb
	 f57vFsuz2SbNA==
Date: Wed, 24 Jan 2024 16:16:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pinctr: pinctrl-zynq: Fix compatible string
Message-ID: <20240124-frolic-onyx-56bd63791aca@spud>
References: <c1307a4dd5e30290acacc786cb2170deb9eaa539.1706087258.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2FhCrXjjKDsJhluq"
Content-Disposition: inline
In-Reply-To: <c1307a4dd5e30290acacc786cb2170deb9eaa539.1706087258.git.michal.simek@amd.com>


--2FhCrXjjKDsJhluq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:07:46AM +0100, Michal Simek wrote:
> Compatible string doesn't really match with compatible string listed in t=
he
> driver itself. While binding was converted from txt to yaml
> xlnx,zynq-pinctrl was listed as compatible string but example was using
> xlnx,pinctrl-zynq and also this string is used in all DTSes.
> xlnx,zynq-pinctrl is used only in dt binding and not present in any DT
> which is stable for quite a long time that's why use old compatible string
> and update binding document instead of starting to use unused compatible
> string.
>=20
> Fixes: 153df45acda0 ("dt-bindings: pinctrl: pinctrl-zynq: Convert to yaml=
")
> Signed-off-by: Michal Simek <michal.simek@amd.com>

I assume that U-Boot etc all use the "incorrect" compatible as was in
the example? If they do, then the patch seems good to me.

Thanks,
Conor.

> ---
>=20
>  .../{xlnx,zynq-pinctrl.yaml =3D> xlnx,pinctrl-zynq.yaml}      | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/pinctrl/{xlnx,zynq-pinctrl.yaml=
 =3D> xlnx,pinctrl-zynq.yaml} (98%)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.=
yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
> similarity index 98%
> rename from Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.y=
aml
> rename to Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
> index d2676f92ef5b..de6c10ba36c4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/pinctrl/xlnx,zynq-pinctrl.yaml#
> +$id: http://devicetree.org/schemas/pinctrl/xlnx,pinctrl-zynq.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Xilinx Zynq Pinctrl
> @@ -28,7 +28,7 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: xlnx,zynq-pinctrl
> +    const: xlnx,pinctrl-zynq
> =20
>    reg:
>      description: Specifies the base address and size of the SLCR space.
> @@ -181,7 +181,7 @@ examples:
>    - |
>      #include <dt-bindings/pinctrl/pinctrl-zynq.h>
>      pinctrl0: pinctrl@700 {
> -       compatible =3D "xlnx,zynq-pinctrl";
> +       compatible =3D "xlnx,pinctrl-zynq";
>         reg =3D <0x700 0x200>;
>         syscon =3D <&slcr>;
> =20
> --=20
> 2.36.1
>=20

--2FhCrXjjKDsJhluq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE3zAAKCRB4tDGHoIJi
0sPzAQCNRelXi/3uPTNzp0NMcUDp2hCNDXY/Zz1AqGOkW9F1fQD3bklsW3G6KflA
U0OhD68HpwMBn+rmyCVmS5flpbfqBQ==
=9BWH
-----END PGP SIGNATURE-----

--2FhCrXjjKDsJhluq--

