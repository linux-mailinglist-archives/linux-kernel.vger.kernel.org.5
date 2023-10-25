Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52517D7067
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjJYPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJYPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:08:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A960128;
        Wed, 25 Oct 2023 08:08:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6307C433C8;
        Wed, 25 Oct 2023 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698246502;
        bh=EmGG2bIEHpNFNsbXGuXDFwFfImfIAEmvCH+yu4IiAQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxIJusxgziIeOjGZnH5vgUQdMAVFCU3Tj4YiMTQSqfHAJ/M591Z2FHQ6b5mJZp88o
         CnaiV0kgufr/AUpXcdCPqIEIvWnVX+74FLa9KHS5G1PXI8BKgSWmZrOu+19pK02b1J
         jVPLK1oFfw07klVxvto4kapMw+x8AzJYvv2FXMbp//ArEiY9ORXpAZBMSXn7pk1WGR
         VtKa6awKAp+SsGoNfs/k/7KOrtdUw8xagMC0p4hmpIiWyEc5usyT1O98xG7qA8bv6e
         I5eE8IOSi1iS2MmbZ8/i1sCYgaLtV5gcAuf5agw9TOGfngPO0EK9VKKp16D7wTL61U
         WdQi57npZBnbA==
Date:   Wed, 25 Oct 2023 16:08:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20231025-cheddar-tucking-b2ea777ed4f9@spud>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
 <20231025134404.131485-2-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ActSxKFGitGW1WzK"
Content-Disposition: inline
In-Reply-To: <20231025134404.131485-2-marius.cristea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ActSxKFGitGW1WzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Marius,

On Wed, Oct 25, 2023 at 04:44:03PM +0300, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip PAC193X series of Power Monitors with Accumulator.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1934.yaml   | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,p=
ac1934.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> new file mode 100644
> index 000000000000..837053ed8a71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1934 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +  Bindings for the Microchip family of Power Monitors with Accumulator.
> +  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found h=
ere:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Produ=
ctDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1931
> +      - microchip,pac1932
> +      - microchip,pac1933
> +      - microchip,pac1934
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    description: IRQ line of the ADC
> +    maxItems: 1
> +
> +  drive-open-drain:
> +    description: The IRQ signal is configured as open-drain.
> +    type: boolean
> +    maxItems: 1
> +
> +  microchip,slow-io:
> +    type: boolean
> +    description: |
> +      A GPIO used to trigger a change is sampling rate (lowering the chi=
p power consumption).
> +      In default mode, if this pin is forced high, sampling rate is forc=
ed to eight
> +      samples/second. When it is forced low, the sampling rate is 1024 s=
amples/second unless
> +      a different sample rate has been programmed.

This description doesn't really make sense to me - if a GPIO is used to
drive the pin low or high, why do we need a property? A DT property
implies that this is a static configuration depending on the board, but
reading the description this seems to be something that can be toggled
at runtime.
I do note though, that this GPIO is not documented in the binding, so I
suppose what really needs to happen here is document the gpio so that
the driver can determine at runtime what state this pin is in?

Also, you say "In default mode", but don't mention what the non-default
mode is. What happens in the other mode?

Cheers,
Conor.

--ActSxKFGitGW1WzK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTkvYgAKCRB4tDGHoIJi
0p/jAQC8aTY9tapI5zJAbel/AlSiuunOhpwryaeBOFSHulfBtwD/Qm+HEKQnOX21
IT9MfeRfd0f0YwK+jzSSPQpdWjDaiw0=
=Kxul
-----END PGP SIGNATURE-----

--ActSxKFGitGW1WzK--
