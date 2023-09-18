Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471F67A50AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjIRRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjIRRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:11:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA64994;
        Mon, 18 Sep 2023 10:11:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6C2C433C9;
        Mon, 18 Sep 2023 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695057099;
        bh=v5sI31zzPgufOthvXRtj8GfaK7y/0aVuMqOHUUR8dX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHGr+Gdci97U9SKDpKXceaMwQJGv09F++q4dYR4QApD6cAW9V6L6KD5R3/a0+ECwz
         X19MGEFfOIygqJaljDFBVsCfyLrIUIXGXFmiKKfMHuyKookYtOLv3qAKipShnTFPN7
         EYmkRse/dWHZF5uIgrxw7/DCkkXoR1FM2wPulsJhtSkFqXT1YAT3/MM52amVrZDRZD
         zu91H5GGJfS6aVczRtPnI2NyqDwZiVrQ5m4Xr3QtNlmquL3K2tw2LhyTXeKBLSuHSV
         4z6IwqlGP2Tal44T+6EpGgw+8v22fxFYQo+kY/aMk4lVoXksItmii1O9Wc3vh3LIty
         jq3wLKmG59QOw==
Date:   Mon, 18 Sep 2023 18:11:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nik Bune <n3q5u8@yahoo.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert txt
 to yaml
Message-ID: <20230918-5cdb7a21163283ce85a4deb5@fedora>
References: <20230916154826.84925-1-n3q5u8@yahoo.com>
 <20230917195520.11987-1-n3q5u8@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wvEX6caj9KSw1sXP"
Content-Disposition: inline
In-Reply-To: <20230917195520.11987-1-n3q5u8@yahoo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wvEX6caj9KSw1sXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 09:55:20PM +0200, Nik Bune wrote:
>=20
> >On Saturday, 16 September 2023 at 22:38:17 CEST, Krzysztof Kozlowski <kr=
zysztof.kozlowski@linaro.org> wrote:
> >
> >
> >On 16/09/2023 17:48, Nik Bune wrote:
> >
> >> Convert txt file to yaml.
> >> Add reg to the list of required properties.
> >> Add mainteiners from ./scripts/get_maintainer.pl output.
> >
> >
> >...
> >
> >> +---
> >> +$id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Atmel AT91RM9200 System Timer Watchdog
> >> +
> >> +maintainers:
> >> +=A0 - Wim Van Sebroeck <wim@linux-watchdog.org>
> >> +=A0 - Guenter Roeck <linux@roeck-us.net
> >>
> >
> >No, these should be maintainer of device or subarch, not subsystem.
> >
>=20
> Is it a particular way how to determine the mainterners of the device?=20
>=20
> I have checked nearby atmel devices. They have Eugen Hristev <eugen.hrist=
ev@microchip.com> in the list of maintainers.=20
> Also I have found the similar patch, which looks like have never finalise=
d, https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202305251=
25602.640855-5-claudiu.beznea@microchip.com/=20
> it has=20
> maintainers:
>   - Nicolas Ferre <nicolas.ferre@microchip.com>
>   - Alexandre Belloni <alexandre.belloni@bootlin.com>
>   - Claudiu Beznea <claudiu.beznea@microchip.coam>

Neither Claudiu or Eugen work at microchip any more. Nicolas should be
able to volunteer someone to look after it if you don't want to.

--wvEX6caj9KSw1sXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQiEwQAKCRB4tDGHoIJi
0pl/AQD0B6M6a4QQQ0juoaYFPZGVWjyF7mIP5T3eMHfmKeL2RQD8D2oGoWnw0KzJ
q7OLanatDFxBUJ5yeKcHYhmXdKsbxAI=
=63Rj
-----END PGP SIGNATURE-----

--wvEX6caj9KSw1sXP--
