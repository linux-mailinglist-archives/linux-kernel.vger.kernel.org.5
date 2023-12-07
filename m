Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70915808ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjLGRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjLGRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:18:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B20FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:18:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD3C433C8;
        Thu,  7 Dec 2023 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701969513;
        bh=66JMbMuX4AYxelynC3Ne6j5CsaJjJ0MIOrMHqrN63I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbTTwS+LIkADPVMWjvU2TmMwhavexszXtfiV6JPJg3bClqH9I3jcs7kAOnvAhJcjZ
         aSoS0T/3+qHcMUammD4rGONcLFRIy/ykrxdDq77zyZjRPm+EUuKYHjcxNvjMz8yQuI
         efbdW3BBa5oWDzu7wUury7Ya4Zv3882sgjt4BA/2cirTYh+qnbKMuVuK5M/CdI07BN
         Rdl9L8nweP7fYGK2OQq1PhyaqG9AQzbDE2WVg7WWFqgw/q2cobAnf6P16yAeabUva4
         69rXnzBrgkxp+Hm7ziHzGHKxMQ3j7z0AnmhV85k5aCNhbl8cljwIgKapVGJo1kOkfL
         AXlHgjMZt0GXA==
Date:   Thu, 7 Dec 2023 17:18:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel@salutedevices.com
Subject: Re: [PATCH v1 2/2] dt-bindings: leds: aw200xx: add 'interrupts'
 property
Message-ID: <20231207-purple-mulled-776447ea26f3@spud>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-3-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oVyXoo7fHC9IKh7M"
Content-Disposition: inline
In-Reply-To: <20231207125938.175119-3-mmkurbanov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oVyXoo7fHC9IKh7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 03:59:38PM +0300, Martin Kurbanov wrote:
> Added support for interrupt to the LED controller driver, which
> indicates the finished of the auto-breath pattern.
>=20
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b=
/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index 54d6d1f08e24..7ab35b7a3fe6 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -44,6 +44,9 @@ properties:
>    enable-gpios:
>      maxItems: 1
> =20
> +  interrupts:
> +    maxItems: 1
> +
>  patternProperties:
>    "^led@[0-9a-f]+$":
>      type: object
> @@ -137,6 +140,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/leds/common.h>
> =20
>      i2c {
> @@ -149,6 +153,8 @@ examples:
>              #address-cells =3D <1>;
>              #size-cells =3D <0>;
>              enable-gpios =3D <&gpio 3 GPIO_ACTIVE_HIGH>;
> +            interrupt-parent =3D <&gpio_intc>;
> +            interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> =20
>              led@0 {
>                  reg =3D <0x0>;
> --=20
> 2.40.0
>=20

--oVyXoo7fHC9IKh7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXH+ZAAKCRB4tDGHoIJi
0qhtAP47F/B1cUNLeC+Zw8DZQCsevoFvAnB3JIN089SDrE8Q+QD/ZPUbAwPkUDer
6ezZuuXwJuzVYZ/dwLRWpbJpm2jsmQM=
=seS0
-----END PGP SIGNATURE-----

--oVyXoo7fHC9IKh7M--
