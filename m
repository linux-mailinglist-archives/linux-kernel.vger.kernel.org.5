Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2C77419F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjHHRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjHHRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8722025F;
        Tue,  8 Aug 2023 09:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE3C6249F;
        Tue,  8 Aug 2023 11:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BF3C433C8;
        Tue,  8 Aug 2023 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691493689;
        bh=e8JSSUEtITPhq0JIZhNW72QrDWLk51aA2iMyz+d3IoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gskj/JtqlzaqRkheKEHTymW3IV8FZygZbtB9F9f/IH4+WygzuZZvUqMRmdvqSQg6m
         D929oAyHtmZcegCTsOh025NcQImy8Im5Nk0Gln9HihQfs4CpxRWQ5zSxg7L4vZyOHY
         6BVkOlSSNHhunzy0cU3OKbkRfukOwv+ghLnPkUZz3WPQQl91JbSMKRzt2rfN5LPETy
         JBouZp7ZI7R5xGsqRqN35gcFBrI8Pxf70UenAHsm08kM/zHrBMZzjeZR+ouednh9se
         NL238Q8xF1G+Rrk29spdXvj9ov8H87QqM6I6+KPOzpGhhYzU4tUuunFyOEEf7JV8mS
         XsXcbXgS5owPA==
Date:   Tue, 8 Aug 2023 12:21:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bruno.thomsen@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add properties to set
 battery-related functions
Message-ID: <20230808-capsize-deodorize-5776d3dbb192@spud>
References: <20230802191153.952667-1-hugo@hugovil.com>
 <20230802191153.952667-2-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3UflZlgy4WxKN7bd"
Content-Disposition: inline
In-Reply-To: <20230802191153.952667-2-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3UflZlgy4WxKN7bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Hugo,

On Wed, Aug 02, 2023 at 03:11:52PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> These properties can be defined in the board's device tree to set the
> default power-on values for battery-related functions.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/rtc/rtc.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentati=
on/devicetree/bindings/rtc/rtc.yaml
> index efb66df82782..0217d229e3fa 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> @@ -26,6 +26,25 @@ properties:
>        0: not chargeable
>        1: chargeable
> =20
> +  battery-low-detect:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      For RTC devices supporting a backup battery/supercap, this flag ca=
n be
> +      used to configure the battery low detection reporting function:
> +      0: disabled
> +      1: enabled
> +
> +  battery-switch-over:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      For RTC devices supporting a backup battery/supercap, this flag ca=
n be
> +      used to configure the battery switch over when the main voltage so=
urce is
> +      turned off:
> +      0: disabled
> +      1: enabled

Why are these implemented as enums? This seems to fall into the category
of using DT to determine software policy - why's it not sufficient to
have boolean properties that indicate hardware support and let the software
decide what to do with them?

Thanks,
Conor.

> +
>    quartz-load-femtofarads:
>      description:
>        The capacitive load of the quartz(x-tal), expressed in femto
> --=20
> 2.30.2
>=20

--3UflZlgy4WxKN7bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIlNAAKCRB4tDGHoIJi
0v7jAP9rQLVFgVSILfg0Xk+EmhkACUJNVyd8hQdU1ezTUvBj7AD/Z8+0R8K2LBP2
8GPSlFPex9mmVsq3YSnvJeUGR3KgpA8=
=I2L7
-----END PGP SIGNATURE-----

--3UflZlgy4WxKN7bd--
