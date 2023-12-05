Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B084805BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjLEQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbjLEQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:25:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD5C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:25:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F1EC433C8;
        Tue,  5 Dec 2023 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701793549;
        bh=l+yMCO/2N3ShBBsyZVkdZcF1uzW3j1QSS3UJ2FkcKQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAk9M7Em7oE9ofYmyvxJZwMQ0oYdN/PKTB6VLJobCr+mwd8A3pFKZ4OpB5mf5jA4S
         lEfuu+E2+vduEx/OWDxvu8/NQLOqhle9nRvHCj8Q0Pb6S1cmtpNAHQ1SHQeBCYomRW
         koBITEzhdXcRj+FYKm06eNOO+o2yw5p60foAxVwVyMPkcOWFtmTM4jIMll0fMDfDP5
         MellRCj8GZ6PwA8NYIPOy1N19MAj0Gjqva9UpPC47Z3LgbFdAMLWZnMrrIIllt0s5w
         F1ozMR/6uCaMEqI+VETarD3cQbvq9uqqCHe/UEcL7UC6WAPixyZuVfFWxtHrqh+Lt2
         YpmZb3ScDo4SA==
Date:   Tue, 5 Dec 2023 16:25:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231205-jockey-chance-bc324d8809f9@spud>
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/ZchycVY0o6z6yFD"
Content-Disposition: inline
In-Reply-To: <20231205134223.17335-1-mitrutzceclan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/ZchycVY0o6z6yFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 03:42:20PM +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7173.yaml          | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> new file mode 100644
> index 000000000000..087820a0cf48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7173 ADC
> +
> +maintainers:
> +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported=
 chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7176-2.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7172-2
> +      - adi,ad7173-8
> +      - adi,ad7175-2
> +      - adi,ad7176-2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  refin-supply:
> +    description: external reference supply, can be used as reference for=
 conversion.
> +
> +  refin2-supply:
> +    description: external reference supply, can be used as reference for=
 conversion.
> +
> +  avdd-supply:
> +    description: avdd supply, can be used as reference for conversion.
> +

> +  required:
> +    - compatible
> +    - reg
> +    - interrupts

This is at the wrong level of indent (as Rob's bot pointed out) and
should come after patternProperties too.

Otherwise, this looks okay to me.
Thanks,
Conor.

--/ZchycVY0o6z6yFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW9PBgAKCRB4tDGHoIJi
0hQJAQDLS/cTqT9ORoSbrXbQtoH978ZVY0+xnOhJDyqmEZK4cwD+M62KCeuB5Kh5
1/k1EQxuWA7Di4h3IlK2+MsqyRfAKwQ=
=F1ne
-----END PGP SIGNATURE-----

--/ZchycVY0o6z6yFD--
