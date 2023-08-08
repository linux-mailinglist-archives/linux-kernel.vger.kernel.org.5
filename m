Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEF774D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjHHVnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHHVnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3C4AA84;
        Tue,  8 Aug 2023 09:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CB256251D;
        Tue,  8 Aug 2023 12:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B432C433C8;
        Tue,  8 Aug 2023 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691496306;
        bh=FqQvQvWBB7n2O9/25AxZN8jzB3TXyz8cjRE78d7I2dU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4KGOdDYJ/VOTogfgIXofFaCLylKhuyVkYwcXoxkk2rR9JIdZ7D7tl7BUMeiKYBhc
         ITk/FVbygu4H6ZQ+MU5B+uLm2reU/yfCq66kRkiELTEIerynt9hgoC6rTH9++Fm2vZ
         /zUU7lL7fmaGcKWbiXKPBcrSgFaCMcbDQRChHaRLSL2hshZHoObydhOiFcvA/vA8Tc
         o+RSgOoi9HPKXpIcmEQ7NsLFBGCze9t/vRP/DaUQ+v5uebcIa5aMiEz8JjSpSc56Um
         ahJ2sNrNjBvbJ9ip05wcAdo6Bk4ifrqoIoZVj4ApHPDght/z/0i4q7JUhM8DKYhX/9
         2q4bFx8/UV27A==
Date:   Tue, 8 Aug 2023 13:05:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230808-amount-urban-9a6eb09852ca@spud>
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VGo5cwouHM7ppLyX"
Content-Disposition: inline
In-Reply-To: <20230807074043.31288-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VGo5cwouHM7ppLyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:
> Loongson GPIO controllers come in multiple variants that are compatible
> except for certain register offset values. Add support in yaml file for
> device properties allowing to specify them in DT.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/gpio/loongson,ls-gpio.yaml       | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml=
 b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index fb86e8ce6349..fc51cf40fccd 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - loongson,ls2k-gpio
>        - loongson,ls7a-gpio
> +      - loongson,ls2k1000-gpio

If you're adding new compatibles that depend on the new offset
properties to function, they could be set up with the existing
"ls2k-gpio" as a fallback, so that further driver changes are not
required when you add ones for the 2k500 etc.

> =20
>    reg:
>      maxItems: 1
> @@ -29,6 +30,33 @@ properties:
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

How is one supposed to know which of these modes to use?

> +  loongson,gpio-inten-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO interrupt enable register offset
> +      address.
> +

tbh, I want to leave the final say on this stuff to Krzysztof or Rob.
I'm not really sure what the best way to do to support your GPIO
controllers is & I don't understand your hardware sufficiently to come
up with an approach that I would use had I been in your shoes.

Thanks,
Conor.

>    interrupts:
>      minItems: 1
>      maxItems: 64
> @@ -39,6 +67,11 @@ required:
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
> @@ -49,11 +82,16 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
> =20
>      gpio0: gpio@1fe00500 {
> -      compatible =3D "loongson,ls2k-gpio";
> +      compatible =3D "loongson,ls2k1000-gpio";
>        reg =3D <0x1fe00500 0x38>;
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

--VGo5cwouHM7ppLyX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIvbQAKCRB4tDGHoIJi
0qzVAQDTrEYYtXJIrVX+bXzBCAE/J6+5fcyDn7rlFxViMi74hQD9FU+SY3Q39ORK
uac/E7e5SnDO2YKQuf8wwOa0ZLiucwY=
=A9r9
-----END PGP SIGNATURE-----

--VGo5cwouHM7ppLyX--
