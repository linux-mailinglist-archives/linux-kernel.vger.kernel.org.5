Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9E7E5632
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjKHM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHM2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:28:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41D19B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:28:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9872C433C7;
        Wed,  8 Nov 2023 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699446490;
        bh=XB3yqrhkhxeT9M0N0X8n+emnTmZjtkm9F39I+mshKDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvkHgjyliiv31fmFx/H4c4rIscBXniiM2ppee2k8ZEHDPaZ4Q+UOGDC+SGcoVdbni
         NW9SEEjp3TKRoFbk9VqTbEN3iBh5EHbmJwDK7UrdwXCq8IhcjDFieIh0gYBwyUQ+X2
         Bl+fDoC85+fAY6LBRNdITZ/7wpGLi+zEgzSxXUXpNLXGbu4jad+5ki6oAEWdgmeXcA
         +IWYk4tacmWnNLmHvO2Wq6gPWj6gmSLbm2AaD3FKL2tbUO9XD5JBttWmDvZce5GzbZ
         4Rrd72OKCrebBj/erZTZ5+GFEZCb3OCvL1jTuhHo5IyZvfVn2RnlpPj3ZBFQYNulDC
         +2x2QOfE0A/Sw==
Date:   Wed, 8 Nov 2023 12:28:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
        CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
        supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate.
Message-ID: <20231108-ungraded-paddle-93f2102e4f61@spud>
References: <20231107035230.1241683-1-wtli@nuvoton.com>
 <20231107035230.1241683-2-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m+wVLMrEzhVYOsBg"
Content-Disposition: inline
In-Reply-To: <20231107035230.1241683-2-wtli@nuvoton.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m+wVLMrEzhVYOsBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:52:29AM +0800, Seven Lee wrote:
> Add input with DMIC slew rate controls.
>=20
> Signed-off-by: Seven Lee <wtli@nuvoton.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml=
 b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> index 3e54abd4ca74..3380b6aa9542 100644
> --- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> @@ -89,6 +89,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 3072000
> =20
> +  nuvoton,dmic-slew-rate:
> +    description: The range 0 to 7 represents the speed of DMIC slew rate.
> +        The lowest value 0 means the slowest rate and the highest value
> +        7 means the fastest rate.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 7
> +    default: 0
> +
>    nuvoton,left-input-single-end:
>      description: Enable left input with single-ended settings if set.
>          For the headset mic application, the single-ended control is
> @@ -127,6 +135,7 @@ examples:
>              nuvoton,jack-insert-debounce =3D <7>;
>              nuvoton,jack-eject-debounce =3D <0>;
>              nuvoton,dmic-clk-threshold =3D <3072000>;
> +            nuvoton,dmic-slew-rate=3D <0>;
>              #sound-dai-cells =3D <0>;
>          };
>      };
> --=20
> 2.25.1
>=20

--m+wVLMrEzhVYOsBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUt+1QAKCRB4tDGHoIJi
0utcAQCmLM7CTdSg8LB5s/+0Hp1lbmS88sg9SymaMSKjIRplmwEA0b08DRBNoeEJ
iDhhK2QtHSMpHWkckynXbj6qbZyzpAo=
=NnjE
-----END PGP SIGNATURE-----

--m+wVLMrEzhVYOsBg--
