Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16BB769B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjGaP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjGaP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B61BC9;
        Mon, 31 Jul 2023 08:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06237611E6;
        Mon, 31 Jul 2023 15:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3887C433C7;
        Mon, 31 Jul 2023 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690818948;
        bh=90WbJ1aIX+bQI29zN6TkQtMuxnBz2JmjcxoCOrV3oyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qe7Mf9AxF9u2J0S4FGC3WlvZ+yVQEVyjmcfwEnRPEJly+WeTrm9eS/yDVrRO01psp
         NNuQB5U/W9mnMAUEjbRsfPL8slVBW8lanzkV0Z24XRwA4O9eEh2h7nLYLaV5pTNvjw
         l3aPawFvsUtSKz+XYG6m0BfZ12F9j2aFDZBL4UOuzNssqv+cdSSuQ9sRRTRf8ITnVn
         DnJyt6zfFirvZTWLlGNYXAbkxSUyN8IIbqeH0t7dG8dpuNJKEnwG2S4H//lVfPSph+
         3RClweGwOzEbIwM6a3ydo+eCvIv+GX3t22ZLExvIrv9aXAeNBpX0w1KCzl4wPXoEgu
         +sEHNC7QJa24w==
Date:   Mon, 31 Jul 2023 16:55:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230731-setback-such-61815ee3ef51@spud>
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gEWADMEw6odxIIUX"
Content-Disposition: inline
In-Reply-To: <20230731091059.17323-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gEWADMEw6odxIIUX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 05:10:58PM +0800, Yinbo Zhu wrote:
> Add parsing GPIO configure, input, output, interrupt register offset
> address and GPIO control mode support.

This reeks of insufficient use of SoC specific compatibles. Do GPIO
controllers on the same SoC have different register offsets?
Where are the users for this?

Cheers,
Conor.

>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/gpio/loongson,ls-gpio.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml=
 b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index fb86e8ce6349..cad67f8bfe6e 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -29,6 +29,33 @@ properties:
> =20
>    gpio-ranges: true
> =20
> +  loongson,gpio-conf-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO configuration register offset addre=
ss.
> +
> +  loongson,gpio-out-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO output register offset address.
> +
> +  loongson,gpio-in-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO input register offset address.
> +
> +  loongson,gpio-ctrl-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO control mode, where '0' represents
> +      bit control mode and '1' represents byte control mode.
> +
> +  loongson,gpio-inten-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO interrupt enable register offset
> +      address.
> +
>    interrupts:
>      minItems: 1
>      maxItems: 64
> @@ -39,6 +66,11 @@ required:
>    - ngpios
>    - "#gpio-cells"
>    - gpio-controller
> +  - loongson,gpio-conf-offset
> +  - loongson,gpio-in-offset
> +  - loongson,gpio-out-offset
> +  - loongson,gpio-ctrl-mode
> +  - loongson,gpio-inten-offset
>    - gpio-ranges
>    - interrupts
> =20
> @@ -54,6 +86,11 @@ examples:
>        ngpios =3D <64>;
>        #gpio-cells =3D <2>;
>        gpio-controller;
> +      loongson,gpio-conf-offset =3D <0>;
> +      loongson,gpio-in-offset =3D <0x20>;
> +      loongson,gpio-out-offset =3D <0x10>;
> +      loongson,gpio-ctrl-mode =3D <0>;
> +      loongson,gpio-inten-offset =3D <0x30>;
>        gpio-ranges =3D <&pctrl 0 0 15>,
>                      <&pctrl 16 16 15>,
>                      <&pctrl 32 32 10>,
> --=20
> 2.20.1
>=20

--gEWADMEw6odxIIUX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMfZfwAKCRB4tDGHoIJi
0pD0AQCpsCmyYqC+KCb9tJxSGEy6oeKZsVocCUw1uLHe6Q5xIAEA1CrBVW2zV/q8
zo0cMvfK8r6iCT6xypfwHgpsiV6T7AA=
=LlSr
-----END PGP SIGNATURE-----

--gEWADMEw6odxIIUX--
