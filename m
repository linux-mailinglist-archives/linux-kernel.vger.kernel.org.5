Return-Path: <linux-kernel+bounces-157359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEA88B105A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B661C24B26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A416D331;
	Wed, 24 Apr 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNC8fc1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30613DBB2;
	Wed, 24 Apr 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977752; cv=none; b=f+aLTBrAoUp9KNRaP5QwMQ+1b4DWTLY6/5ajevDXpVSD5aA+3CvTb2krWVikXHRb8dWTqT6dvSlq9KBgrxQ5rlH6qfFNkRKbkbaze7GQZCwEiV3OM9C1Plf7LY4gsIw6TBOYI9HkoT2Q9yqFyHld0517kGvkBkuLQxvp2R28Lg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977752; c=relaxed/simple;
	bh=XcBcA9wSG/hJqeu2uO50hcTfxZb6NSTZgAUm+I1++nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSB5yyRTWoVjCdepqiipGLsHJ+E4YoRpmgFRKPU8S3WTrZ7CcbTC1v2TZVBy3Pww+o8p+QYa/i+rYS5cGIKRTs2E0PiDh5eb8Pa1vNCBKn2nvV3J1i1v8lWntSSVLy/at/+iAmdg/6pGIz4axplZnxfK4GeVAq1C3mO5lCi+wq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNC8fc1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A43C113CD;
	Wed, 24 Apr 2024 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713977752;
	bh=XcBcA9wSG/hJqeu2uO50hcTfxZb6NSTZgAUm+I1++nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNC8fc1dGCQBoAHHhdVOJtKeyApmqtVbNNuW6qLJgKphsscgz7l97oYolAN18RgzN
	 X8WYFrZzikxmCz7NL0qeaGalJAZ5jQNK8gUgKsn5H1Z3PYEFOalGOnXFrSVIYbSrGX
	 kbcf9513A+QXDgxB55zm0Sq15uyVVq7IMsVG3DbJTXPR+ORsYmWbLDmOyq86wT8c6K
	 LKHbgYPtYyiGdLIl2qI2lkROy6qlDVj3h/IjId47UQ/iSub4blTTfIaJ5LRalDeVZU
	 n5OK0F1Is3nUpC5UmnKHg/vK9oI2wd+ge3ok/OQyqpswlDGW5fs/lNby+JtnNu4c+C
	 2nLvliZyH8T1A==
Date: Wed, 24 Apr 2024 17:55:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v3 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
Message-ID: <20240424-spelling-float-9b881cb80992@spud>
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
 <20240424023010.2099949-2-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pj/RbvYXrqipqoo5"
Content-Disposition: inline
In-Reply-To: <20240424023010.2099949-2-yangcong5@huaqin.corp-partner.google.com>


--Pj/RbvYXrqipqoo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:30:04AM +0800, Cong Yang wrote:
> In V1, discussed with Doug and Linus [1], we need break out as separate
> driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
> and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> controller, they have some common CMDS. So add new documentation for
> this panels.

It'd be good to note in the commit message that the 3v3 supply is not
present on these panels, given it was present in the other binding and
not here.

> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aSAZ=
QvdMV95r3zRUw@mail.gmail.com
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> Chage since V3:
>=20
> - Update commit message.
>=20
> V2: https://lore.kernel.org/all/20240422090310.3311429-2-yangcong5@huaqin=
=2Ecorp-partner.google.com
>=20
> ---
>  .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
>  .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax=
,hx83102.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum=
-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl=
6.yaml
> index 906ef62709b8..53fb35f5c9de 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.ya=
ml
> @@ -32,8 +32,6 @@ properties:
>        - innolux,hj110iz-01a
>          # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
>        - starry,2081101qfh032011-53g
> -        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
> -      - starry,himax83102-j02
>          # STARRY ili9882t 10.51" WUXGA TFT LCD panel
>        - starry,ili9882t
> =20
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8310=
2.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> new file mode 100644
> index 000000000000..2e0cd6998ba8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml

Filename matching a compatible please. What you've done here makes it
seem like there's a fallback compatible missing, given this looks like
the LCD panel controller and the starry compatible below is an LCD panel.

> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/himax,hx83102.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax HX83102 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
> +      - starry,himax83102-j02
> +
> +  reg:
> +    description: the virtual channel number of a DSI peripheral
> +
> +  enable-gpios:
> +    description: a GPIO spec for the enable pin
> +
> +  pp1800-supply:
> +    description: core voltage supply
> +
> +  avdd-supply:
> +    description: phandle of the regulator that provides positive voltage
> +
> +  avee-supply:
> +    description: phandle of the regulator that provides negative voltage
> +
> +  backlight:
> +    description: phandle of the backlight device attached to the panel

I'm not sure why this was given a description when port or rotation
was not.

Otherwise, this looks fine to me.

Cheers,
Conor.

> +
> +  port: true
> +  rotation: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - pp1800-supply
> +  - avdd-supply
> +  - avee-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        panel@0 {
> +            compatible =3D "starry,himax83102-j02";
> +            reg =3D <0>;
> +            enable-gpios =3D <&pio 45 0>;
> +            avdd-supply =3D <&ppvarn_lcd>;
> +            avee-supply =3D <&ppvarp_lcd>;
> +            pp1800-supply =3D <&pp1800_lcd>;
> +            backlight =3D <&backlight_lcd0>;
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint =3D <&dsi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--Pj/RbvYXrqipqoo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZik5kgAKCRB4tDGHoIJi
0vQEAQCABxeP8C4PVO0oy7rmAnyax20mxLqgK/83cR+wn6PwTQD+MyzcuAspe9+N
QVbJuxD7LhSAFPIPTocJGhAi2aFUpAY=
=uy9b
-----END PGP SIGNATURE-----

--Pj/RbvYXrqipqoo5--

