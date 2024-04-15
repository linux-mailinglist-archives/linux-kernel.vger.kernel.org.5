Return-Path: <linux-kernel+bounces-145631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE48A58C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C771C20C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327B8BEF;
	Mon, 15 Apr 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C753SYye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10ED82D91;
	Mon, 15 Apr 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200829; cv=none; b=XWrbjG1nO6nwYdo27dNtZOXM+4Ktuv3+WCKbE0nJRNnX4canxRK/ZIAMIqVF+f4ZZITRJeE6ceJZgBIjoddzAqVYVfyQ5AKA63RvcOfmt5RV+G4LVZeaqGhpOk4Tc/12N+Odg7VYw0Fw7GWmHqMTvj0J4MWHE80740cfqtskNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200829; c=relaxed/simple;
	bh=FOsS3Rqk88ldzlT96VMVnmS+dPPkpqirhwk6Fw5Yn5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLVz4P0d6ypwGYVneKcRgjDAgL2B03DvV3Yu696oUArVK9QAmdxLyR8LeLjnJwRZtyrhRDGLRi6sDIjMU8eToy5elvLQMx6cbZRQlZj2v/Zi0nv90QcM/5lLT84z7M9hWVPv6j1EHJ5W4FtWLa4voxkwGMCQA7l3mQIHgij4WbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C753SYye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F68C113CC;
	Mon, 15 Apr 2024 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200829;
	bh=FOsS3Rqk88ldzlT96VMVnmS+dPPkpqirhwk6Fw5Yn5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C753SYyeQDwc2ojdR7attJ5/xEhfc/W0AV1zpqzVThMMxtq+s8KsfpxtWH91J7f/A
	 IAr/sVVCi45hOea7W1ial9TQqus6DBfOMp1MlCd/EGq7hbNA3HW0BVKdSCgGWB4kHC
	 4x0oJmrj9sBIDM+FWUvV8/SApcFGPGEu7b9jOXYMexasX0IU3JwaIEIOGWe9Ud8+U/
	 Z3zyWTNdIp3FV2gY9+n7w4Srns+ZQjdi3QE/hE7B+yHP4sa6uLAdr/1qukeBSmVHeu
	 k1dLL0vdM+3Wy/pCkb99SH9/VwmiXl4q81VB1WAFjdCfTSsvgs+FsAsv3HKgsm5Qq4
	 piio5Ei5FEScg==
Date: Mon, 15 Apr 2024 18:07:03 +0100
From: Conor Dooley <conor@kernel.org>
To: David Wronek <david@mainlining.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Raydium RM69380
Message-ID: <20240415-basically-laboring-3a5fde2027ef@spud>
References: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
 <20240415-raydium-rm69380-driver-v2-1-524216461306@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0GLNjRxLWL3JBgc2"
Content-Disposition: inline
In-Reply-To: <20240415-raydium-rm69380-driver-v2-1-524216461306@mainlining.org>


--0GLNjRxLWL3JBgc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 06:10:41PM +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
>=20
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
>  .../bindings/display/panel/raydium,rm69380.yaml    | 91 ++++++++++++++++=
++++++
>  1 file changed, 91 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69=
380.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.=
yaml
> new file mode 100644
> index 000000000000..0ac7d033cbe0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raydium RM6380-based DSI display panels
> +
> +maintainers:
> +  - David Wronek <david@mainlining.org>
> +
> +description:
> +  The Raydium RM69380 is a generic DSI panel IC used to control
> +  OLED panels.
> +
> +allOf:
> +  - $ref: panel-common-dual.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - lenovo,j716f-edo-rm69380
> +      - const: raydium,rm69380
> +    description: This indicates the panel manufacturer of the panel
> +      that is in turn using the RM69380 panel driver. The compatible
> +      string determines how the RM69380 panel driver shall be configured
> +      to work with the indicated panel. The raydium,rm69380 compatible s=
hall
> +      always be provided as a fallback.
> +
> +  avdd-supply:
> +    description: Analog voltage rail
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: phandle of gpio for reset line - This should be active =
low
> +
> +  ports: true
> +  reg: true

Where is reg defined? I briefly checked the two panel-common bindings
and didn't see it.

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vddio-supply
> +  - reset-gpios
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "lenovo,j716f-edo-rm69380", "raydium,rm69380";
> +            reg =3D <0>;
> +
> +            avdd-supply =3D <&panel_avdd_regulator>;
> +            vddio-supply =3D <&vreg_l14a>;
> +            reset-gpios =3D <&tlmm 75 GPIO_ACTIVE_LOW>;
> +
> +            ports {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                port@0 {
> +                    reg =3D <0>;
> +                    panel_in_0: endpoint {
> +                        remote-endpoint =3D <&mdss_dsi0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg =3D <1>;
> +                    panel_in_1: endpoint {
> +                        remote-endpoint =3D <&mdss_dsi1_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +...
>=20
> --=20
> 2.44.0
>=20

--0GLNjRxLWL3JBgc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1etwAKCRB4tDGHoIJi
0mHkAQDH2xKYkE4R7Ku+Y0Z6OrwT1OLZWwQTMHQ67JzNr6FllgD/W2C7opnNMcD7
rf8AECa0OELVhjuuAVTl3UtDPCqW0gE=
=+guv
-----END PGP SIGNATURE-----

--0GLNjRxLWL3JBgc2--

