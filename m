Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38E475DCA9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGVMnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGVMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2576F10F4;
        Sat, 22 Jul 2023 05:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE05360B3B;
        Sat, 22 Jul 2023 12:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAD5C433C7;
        Sat, 22 Jul 2023 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690029825;
        bh=MggwQRQ9SOVOUL60eVZBHXNGxixHb5ip6KidgI1jCmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjDfbxg8SlBFbpd0J4Pzy0B40QuK4+7gtNjp22NLC8HAgutGu2aQDuYPRs3EpJKdn
         MIWEdexOI8RK5J+JLRItJmB/cZW9nEGdkzHwqpD3OyErGEfNWpKrjuZGGQaWvuePXO
         T+P0RvRdrbPIHwy9IeRtaFal7eJB84GId7oxwiaLjr+wQJI26T2fD9cGEVuAAf2C/r
         R/TDYZlKvRLiMRlIUVTc0yS2Cb+2XoQH33CkXY6dvCpEyK69wj5LT6la0y60xLFEND
         x/tTWdZ1ylMafLQWhOqR8PZu1GjX8Mn5mTURcP6Rzaht5tIinv9HnuJkTgXxLtuLlE
         R37pEcsxWJbCg==
Date:   Sat, 22 Jul 2023 13:43:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: maxim,max8998: Convert to DT schema
Message-ID: <20230722-job-cod-0a501b80e778@spud>
References: <20230721161712.31767-1-krzysztof.kozlowski@linaro.org>
 <20230722-occupant-outflank-bf433bc728c5@spud>
 <8324119a-ac06-da3d-dacb-5b7cc90f22eb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="971vFZo8tH9dJKN/"
Content-Disposition: inline
In-Reply-To: <8324119a-ac06-da3d-dacb-5b7cc90f22eb@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--971vFZo8tH9dJKN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2023 at 02:25:20PM +0200, Krzysztof Kozlowski wrote:
> On 22/07/2023 13:57, Conor Dooley wrote:
> > On Fri, Jul 21, 2023 at 06:17:12PM +0200, Krzysztof Kozlowski wrote:
> >> Convert the bindings for Maxim MAX8998, National/TI LP3974 Power
> >> Management IC to DT schema.  Adjust example to real DTS and make second
> >> interrupt optional (like on s5pv210-aries.dtsi).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../devicetree/bindings/mfd/max8998.txt       | 125 -------
> >>  .../bindings/mfd/maxim,max8998.yaml           | 324 ++++++++++++++++++
> >>  2 files changed, 324 insertions(+), 125 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/mfd/max8998.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max899=
8.yaml
> >=20
> >> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml =
b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
> >> new file mode 100644
> >> index 000000000000..f3c3f64fd012
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
> >> @@ -0,0 +1,324 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mfd/maxim,max8998.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Maxim MAX8998, National/TI LP3974 Power Management IC
> >> +
> >> +maintainers:
> >> +  - Krzysztof Kozlowski <krzk@kernel.org>
> >> +
> >> +description:
> >> +  The Maxim MAX8998 is a Power Management IC which includes voltage/c=
urrent
> >> +  regulators, real time clock, battery charging controller and severa=
l other
> >> +  sub-blocks. It is interfaced using an I2C interface. Each sub-block=
 is
> >> +  addressed by the host system using different i2c slave address.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - maxim,max8998
> >> +      - national,lp3974
> >> +      - ti,lp3974
> >=20
> > Should one of these be marked as deprecated?
>=20
> We could deprecate national, because it was acquired by TI. But the chip
> was actually made by National - the datasheet I found has a National
> brand in product brief page and only the title page was added by TI.

It's probably unimportant, given you say this is unlikely to be used in
new hardware, but it does seem odd to me to have two compatibles for the
same chip.

> >> +  regulators:
> >> +    type: object
> >> +    additionalProperties: false
> >> +
> >> +    properties:
> >> +      CHARGER:
> >> +        type: object
> >> +        $ref: /schemas/regulator/regulator.yaml#
> >> +        unevaluatedProperties: false
> >> +        description:
> >> +          CHARGER is main battery charger current control, wrongly re=
presented
> >> +          as regulator.
> >> +
> >> +        properties:
> >> +          regulator-min-microamp:
> >> +            minimum: 90000
> >> +            maximum: 800000
> >> +
> >> +          regulator-max-microamp:
> >> +            minimum: 90000
> >> +            maximum: 800000
> >=20
> > Did you pull these from the datasheet, or from the dts/example?
>=20
> From the driver.

Ah, thanks. Was just curious really.
Other than the deprecated thing looking odd, this stuff seemed fine to
me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> TBH, this is, very very old device used in very old boards which I don't
> care about. I just want DT schema to be happy, so I don't think the
> bindings should be really correct. It's not like anyone will make any
> device with it.

Hopefully they don't :)


--971vFZo8tH9dJKN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLvO/QAKCRB4tDGHoIJi
0tLfAP44no1em1b5CNZ2wWZL3yujpgl83isbd1jgTEamT++lZAD+MBgvrcm1BHRB
gUjp19Y4PQcbAn2EPHaj0Zj+cs1RKg4=
=+SzQ
-----END PGP SIGNATURE-----

--971vFZo8tH9dJKN/--
