Return-Path: <linux-kernel+bounces-27612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0C482F2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64FD1F21A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94751CAA2;
	Tue, 16 Jan 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyWNoQcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFB1CA87;
	Tue, 16 Jan 2024 17:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03191C433F1;
	Tue, 16 Jan 2024 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705424968;
	bh=DmSwrk+5cORRbEk06f8bHofm6Do4a4AKu4LPO82gZXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyWNoQcDDdL4Oq6T2s1G71OpJajZruAErAF64TuqkCGXdIMhVMFUurgNnP4UbPoi7
	 vmw5Rw72t5aa3ld2qclsTFSCKUA5x7jfVdHMH2z1Fro0R3E2XfIfYFXUEydvDduI/e
	 WSJzBPE8gQvrJYpW2/EhCFaGf2H8nEM2glIcV6Ut/obvD0ZWdH4jrWP7KigY+QHU1i
	 ihX3arjWqLEuGnmzmTGF5nAQK5pGyTWHpzTunoZfdJPvoXEHUVvAA2KqVwIl/NE6LO
	 k0FqhmzqapzAFiYikpxjjCGhCP9FK7acGyY7yI8lCgfhbzxSDF/71h5FG/bChu+d9l
	 Im4dPg6lwR2NQ==
Date: Tue, 16 Jan 2024 17:09:23 +0000
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
Subject: Re: [PATCH v2 3/3] dt-bindings: rockchip: Update rk809 example with
 audio codec properties
Message-ID: <20240116-muppet-buggy-4caf9620b660@spud>
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-4-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZK3izpEatKf2F2cp"
Content-Disposition: inline
In-Reply-To: <20240116132102.3272682-4-tim@feathertop.org>


--ZK3izpEatKf2F2cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:21:02AM +1100, Tim Lunn wrote:
> Update the example provided to include the properties for using
> rk817 audio codec.
>=20
> Signed-off-by: Tim Lunn <tim@feathertop.org>
>=20
> ---
>=20
> Changes in v2:
> - Fix missing include and pinctrl for codec example
>=20
>  .../devicetree/bindings/mfd/rockchip,rk809.yaml          | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/=
Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> index 9b9d670708ce..fee8338b230b 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
> @@ -147,6 +147,7 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/clock/px30-cru.h>
>      #include <dt-bindings/pinctrl/rockchip.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/gpio/gpio.h>
> @@ -161,10 +162,13 @@ examples:
>              clock-output-names =3D "xin32k", "rk808-clkout2";
>              interrupt-parent =3D <&gpio3>;
>              interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
> +            clock-names =3D "mclk";
> +            clocks =3D <&cru SCLK_I2S1_OUT>;
>              pinctrl-names =3D "default";
> -            pinctrl-0 =3D <&pmic_int_l_pin>;
> +            pinctrl-0 =3D <&pmic_int_l_pin>, <&i2s1_2ch_mclk>;
>              rockchip,system-power-controller;
>              wakeup-source;
> +            #sound-dai-cells =3D <0>;
> =20
>              vcc1-supply =3D <&vcc_sysin>;
>              vcc2-supply =3D <&vcc_sysin>;
> @@ -309,5 +313,8 @@ examples:
>                      };
>                  };
>              };

Blank line here please.
I'd squash this with the patch adding the codec as an allowed property
though.

Thanks,
Conor.

> +            rk817_codec: codec {
> +                rockchip,mic-in-differential;
> +            };
>          };
>      };
> --=20
> 2.40.1
>=20

--ZK3izpEatKf2F2cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa4QwAKCRB4tDGHoIJi
0jP3AQDI8jR4sG+u+6VZmJWVJya/eoRO5vJx5Hcoe2PPsDpwHgEAw9URuB4Gt7Mn
vxyyA5dzuCVrr+mT1oK+Rq7RbtxA7gQ=
=CDvt
-----END PGP SIGNATURE-----

--ZK3izpEatKf2F2cp--

