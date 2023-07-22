Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3775DC3E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGVL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGVL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2A30C4;
        Sat, 22 Jul 2023 04:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6531560A64;
        Sat, 22 Jul 2023 11:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D733C433C8;
        Sat, 22 Jul 2023 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690027079;
        bh=entbtTG+sVU0Y/5dV0awSmN44e7uyHdxvMvT02OnQ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njUVaYWdfkHEvRooiMErRdZ7C5Q9j+i5njn98tuejB8ICupSxDhGT32pEl0ojaAv1
         xq/OgM/YHkuzxmssFmT3SOxluYyD/5TjXgnle181l15tclo3QwdX6lAl1jrCsXOg2g
         XDY1w/HwrU7yqs97fOcnGXuSzWDVQjkX8qAAnx9Hib5gwUwdHfhM/joh2ZjSC4keAU
         OWT4Qtcke/Hi3tp9ur6HV8nlxu6gZZi6H7WkIpnOXoBATYrQQ70FgCKo3dLZk++dQR
         m/wIhop/cPSjPyKzpSkJkCk7oZodDBUdHBh/3uJamCgQCqV3FPtB2yxN2XEp4ey3T3
         z1zKFbVWCywrg==
Date:   Sat, 22 Jul 2023 12:57:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: maxim,max8998: Convert to DT schema
Message-ID: <20230722-occupant-outflank-bf433bc728c5@spud>
References: <20230721161712.31767-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tg1qcV7D0eCwizJH"
Content-Disposition: inline
In-Reply-To: <20230721161712.31767-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tg1qcV7D0eCwizJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 06:17:12PM +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Maxim MAX8998, National/TI LP3974 Power
> Management IC to DT schema.  Adjust example to real DTS and make second
> interrupt optional (like on s5pv210-aries.dtsi).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/max8998.txt       | 125 -------
>  .../bindings/mfd/maxim,max8998.yaml           | 324 ++++++++++++++++++
>  2 files changed, 324 insertions(+), 125 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max8998.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8998.y=
aml

> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml b/D=
ocumentation/devicetree/bindings/mfd/maxim,max8998.yaml
> new file mode 100644
> index 000000000000..f3c3f64fd012
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
> @@ -0,0 +1,324 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max8998.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX8998, National/TI LP3974 Power Management IC
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description:
> +  The Maxim MAX8998 is a Power Management IC which includes voltage/curr=
ent
> +  regulators, real time clock, battery charging controller and several o=
ther
> +  sub-blocks. It is interfaced using an I2C interface. Each sub-block is
> +  addressed by the host system using different i2c slave address.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max8998
> +      - national,lp3974
> +      - ti,lp3974

Should one of these be marked as deprecated?

> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      CHARGER:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          CHARGER is main battery charger current control, wrongly repre=
sented
> +          as regulator.
> +
> +        properties:
> +          regulator-min-microamp:
> +            minimum: 90000
> +            maximum: 800000
> +
> +          regulator-max-microamp:
> +            minimum: 90000
> +            maximum: 800000

Did you pull these from the datasheet, or from the dts/example?
> +
> +          regulator-min-microvolt: false
> +          regulator-max-microvolt: false


--Tg1qcV7D0eCwizJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLvEQwAKCRB4tDGHoIJi
0nAxAQCslRQsb+EY0ymsAEdiSDrZROz0Nf3GDcNcZfGUvrqpeQD/YhoDvPHTy+UN
Cqg6GQdIEK1pEmmZV5WWan9xSXkFMgI=
=84Gm
-----END PGP SIGNATURE-----

--Tg1qcV7D0eCwizJH--
