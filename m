Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4076BEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjHAVJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHAVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925DAE67;
        Tue,  1 Aug 2023 14:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D5961712;
        Tue,  1 Aug 2023 21:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9651EC433C7;
        Tue,  1 Aug 2023 21:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690924172;
        bh=OhgIZ4crQy03az0u1Ty2iSVe+3Bf0ozyWo3yXY1BtDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEyvgMSuBdVcLSSHH2W2r0ZWwNTIoUiA63051je82wuyX7UFGtZACxlCVldAc5sYR
         aPOqhnCf6F/FR0Lh7dN9YdaLygSBs/d3gnOR6VTnHs6kRDUQoK8ZHpE25YEwFYzMK1
         WeYLuHclcck65auMKEg8yJ0+oMPrwYrfmLGseensV+VmQabWU6fz6Ac+v+dtVRffsp
         SYpp8JxLPJHlAw4Mc9uVGnEynaMrd2XJh4yuUNxytkTKK1zsGii/txVTDrUFEzJycA
         J/EMLPdCikWdUhD/MwmC1SrlO1Xuzd+SNIAWBRhyQPzKVCKeA5N14MCUE2mZUBRFsz
         koOHhLanhE7MQ==
Date:   Tue, 1 Aug 2023 22:09:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: admv1013: add vcc regulators
Message-ID: <20230801-rasping-petty-5fca54f6f696@spud>
References: <20230731094455.26742-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MmFimgIzQ0ArwSjO"
Content-Disposition: inline
In-Reply-To: <20230731094455.26742-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MmFimgIzQ0ArwSjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 12:44:54PM +0300, Antoniu Miclaus wrote:
> Add bindings for the VCC regulators of the ADMV1013 microware
> upconverter.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Assuming the driver or regulator core handles the missing regulators on
older devicetrees (which I think it does with dummy regulators?)
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> changes in v3:
>  - add missing spaces in the commit subject.
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013=
=2Eyaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> index fc813bcb6532..f2eb2287ed9e 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> @@ -39,6 +39,46 @@ properties:
>      description:
>        Analog voltage regulator.
> =20
> +  vcc-drv-supply:
> +    description:
> +      RF Driver voltage regulator.
> +
> +  vcc2-drv-supply:
> +    description:
> +      RF predriver voltage regulator.
> +
> +  vcc-vva-supply:
> +    description:
> +      VVA Control Circuit voltage regulator.
> +
> +  vcc-amp1-supply:
> +    description:
> +      RF Amplifier 1 voltage regulator.
> +
> +  vcc-amp2-supply:
> +    description:
> +      RF Amplifier 2 voltage regulator.
> +
> +  vcc-env-supply:
> +    description:
> +      Envelope Detector voltage regulator.
> +
> +  vcc-bg-supply:
> +    description:
> +      Mixer Chip Band Gap Circuit voltage regulator.
> +
> +  vcc-bg2-supply:
> +    description:
> +      VGA Chip Band Gap Circuit voltage regulator.
> +
> +  vcc-mixer-supply:
> +    description:
> +      Mixer voltage regulator.
> +
> +  vcc-quad-supply:
> +    description:
> +      Quadruppler voltage regulator.
> +
>    adi,detector-enable:
>      description:
>        Enable the Envelope Detector available at output pins VENV_P and
> @@ -69,6 +109,16 @@ required:
>    - clocks
>    - clock-names
>    - vcm-supply
> +  - vcc-drv-supply
> +  - vcc2-drv-supply
> +  - vcc-vva-supply
> +  - vcc-amp1-supply
> +  - vcc-amp2-supply
> +  - vcc-env-supply
> +  - vcc-bg-supply
> +  - vcc-bg2-supply
> +  - vcc-mixer-supply
> +  - vcc-quad-supply
> =20
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> @@ -87,6 +137,16 @@ examples:
>          clocks =3D <&admv1013_lo>;
>          clock-names =3D "lo_in";
>          vcm-supply =3D <&vcm>;
> +        vcc-drv-supply =3D <&vcc_drv>;
> +        vcc2-drv-supply =3D <&vcc2_drv>;
> +        vcc-vva-supply =3D <&vcc_vva>;
> +        vcc-amp1-supply =3D <&vcc_amp1>;
> +        vcc-amp2-supply =3D <&vcc_amp2>;
> +        vcc-env-supply =3D <&vcc_env>;
> +        vcc-bg-supply =3D <&vcc_bg>;
> +        vcc-bg2-supply =3D <&vcc_bg2>;
> +        vcc-mixer-supply =3D <&vcc_mixer>;
> +        vcc-quad-supply =3D <&vcc_quad>;
>          adi,quad-se-mode =3D "diff";
>          adi,detector-enable;
>        };
> --=20
> 2.41.0
>=20

--MmFimgIzQ0ArwSjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMl0iAAKCRB4tDGHoIJi
0odZAQDREyu9fGnsq2mMVtQTCuQnqo6DZ6TmTOyC4Loush7LkgD+KzrvcmMN0/h9
XV4lJeNAkVhWHUbVgQ4TNADZLtUCCAk=
=rpba
-----END PGP SIGNATURE-----

--MmFimgIzQ0ArwSjO--
