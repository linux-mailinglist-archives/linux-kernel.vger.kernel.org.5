Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA37C71CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379164AbjJLPrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJLPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:46:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312EFC0;
        Thu, 12 Oct 2023 08:46:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CD7C433C7;
        Thu, 12 Oct 2023 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697125617;
        bh=REtBZa8reasxyEfgbRlAa7AZo0WSj8gv4icvTE1IL6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LevFwFpylTDyPIuMI4Jzt/nZXRVMSHT9pnY6QL5k2+EHdeoccGOJFp9AgM8w48saq
         MHg1OtvfhdpP0gy7b1NR7FE/riKA0PKhcu86ibkx4j9sBlpfJ6eQB4TdDnZlUuzjTS
         Tn7rJhKEA1AttdQDJXw4PCTgXKehMPE8TFWhdNBvluK95enI7sJOsTOozH12f3ihFN
         sWCa3gwEx58XlbEPBcMZwoLwaW2BmbQ4bgMYAELkZXKGnuhXX+CgwL9o/39Oi9w3KY
         6LQeuZ2p88j15QBwTVxGacM+jMR+eS/Owp5hLDVJZCunUSYJ30900SKFWGGHqaYlH9
         fbK0kAyDRuoiA==
Date:   Thu, 12 Oct 2023 16:46:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <20231012-woof-fit-8f5c163f07b0@spud>
References: <20231010184827.1213507-1-anshulusr@gmail.com>
 <20231011-powdering-recycled-71608e794eaa@spud>
 <f1796d1a-bcd0-414d-b4e1-806e93eb202b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Ch3KXm3gkqlOD2K"
Content-Disposition: inline
In-Reply-To: <f1796d1a-bcd0-414d-b4e1-806e93eb202b@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Ch3KXm3gkqlOD2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 12:29:58AM +0530, Anshul Dalal wrote:
> Hello,
>=20
> On 10/11/23 21:45, Conor Dooley wrote:
> > Hey,
> >=20
> > On Wed, Oct 11, 2023 at 12:18:23AM +0530, Anshul Dalal wrote:
> >> Adds bindings for the Adafruit Seesaw Gamepad.
> >>
> >> The gamepad functions as an i2c device with the default address of 0x50
> >> and has an IRQ pin that can be enabled in the driver to allow for a ri=
sing
> >> edge trigger on each button press or joystick movement.
> >>
> >> Product page:
> >>   https://www.adafruit.com/product/5743
> >> Arduino driver:
> >>   https://github.com/adafruit/Adafruit_Seesaw
> >>
> >> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> >> ---
> >>
> >> Changes for v4:
> >> - Fixed the URI for the id field
> >> - Added `interrupts` property
> >>
> >> Changes for v3:
> >> - Updated id field to reflect updated file name from previous version
> >> - Added `reg` property
> >>
> >> Changes for v2:
> >> - Renamed file to `adafruit,seesaw-gamepad.yaml`
> >> - Removed quotes for `$id` and `$schema`
> >> - Removed "Bindings for" from the description
> >> - Changed node name to the generic name "joystick"
> >> - Changed compatible to 'adafruit,seesaw-gamepad' instead of
> >>   'adafruit,seesaw_gamepad'
> >>
> >>  .../input/adafruit,seesaw-gamepad.yaml        | 59 +++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/input/adafruit,s=
eesaw-gamepad.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-g=
amepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamep=
ad.yaml
> >> new file mode 100644
> >> index 000000000000..e8e676006d2f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.=
yaml
> >> @@ -0,0 +1,59 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Adafruit Mini I2C Gamepad with seesaw
> >=20
> > Binding mostly looks good to me. My main question is what is a seesaw?
> >=20
>=20
> Seesaw is a universal framework that enables extending I/O capabilities
> of the i2c master devices with a compatible breakout board. As it
> relates to the binding, this gamepad uses an AVR ATtiny816
> microcontroller that reads the data from the buttons and the joystick
> and sends the data to the master over i2c using the Seesaw framework.

Right. Not a framework I was aware of, thanks for explaining.

>=20
> >> +
> >> +maintainers:
> >> +  - Anshul Dalal <anshulusr@gmail.com>
> >> +
> >> +description: |
> >> +  Adafruit Mini I2C Gamepad
> >> +
> >> +    +-----------------------------+
> >> +    |   ___                       |
> >> +    |  /   \               (X)    |
> >> +    | |  S  |  __   __  (Y)   (A) |
> >> +    |  \___/  |ST| |SE|    (B)    |
> >> +    |                             |
> >> +    +-----------------------------+
> >> +
> >> +  S -> 10-bit percision bidirectional analog joystick
> >> +  ST -> Start
> >> +  SE -> Select
> >> +  X, A, B, Y -> Digital action buttons
> >> +
> >> +  Product page: https://www.adafruit.com/product/5743
> >> +  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
> >=20
> > I'm not really sure what the arduino driver has to do with the binding.
> > Why is a link to it more relevant than the freebsd driver, or the linux
> > driver etc? Is there info about how the pad works in the arduino driver
> >=20
> > Otherwise, this seems good to me.

> The Arduino driver I linked was the only resource that had the
> implementation of the seesaw framework as well as the example code
> specific to this device:
> https://github.com/adafruit/Adafruit_Seesaw/tree/master/examples/Mini_I2C=
_Gamepad_QT
> On further thought, a link to the accompanying document from the
> manufacturer (https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf)
> might be more relevant for the binding which includes the hardware
> description as well as links to the above-mentioned Arduino driver.

A link to the manufacturer docs would be nice & if, as you say, the
arduino driver was a useful resource for understanding the hardware then
I suppose it can stay too :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--+Ch3KXm3gkqlOD2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgU7QAKCRB4tDGHoIJi
0qBbAQDkXpWdZQqk8AnLNCXjpHuzqn8N1ak3hT2yNwWlJI5MMAEAgeaWoOrvEHEi
GkHd0KtNDCVE2jKKyCIyF7/N2eOYuwA=
=rbZ4
-----END PGP SIGNATURE-----

--+Ch3KXm3gkqlOD2K--
