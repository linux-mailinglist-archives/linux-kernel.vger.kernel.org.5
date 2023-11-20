Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A07F17B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjKTPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:45:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C361C126
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:45:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645AEC433C8;
        Mon, 20 Nov 2023 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700495143;
        bh=Mf13kzSkExcyvPhnH9lBeXM+1UKNn14DDjcJ3StlIoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXuXXuoyJnfgUCQK1X12FP4JL1Y3eR9/BRp0/MUuTl3MhCF3KK0nFr3436r2pCKXb
         xkQX/ShmAMDV5lDZsBlsCsbVehE+uguaHwGEiArapYyz87IDl+gW3cbZdsfZfZfPx1
         ikbg4W0qxv0Bxvfze7lb/aH9l69mtk0wusvkpVpQcCB/Dg1oU38v5OHzFYgLAweCLS
         3eduYAQKOP/cWI3pb4RulPavh2uTpkHor16JLy2GQ34HS5fOqrMOZEXVUcX7ODvlCo
         0+rfXJJO94HQDKAiKWECUzw36pHa61BUAhuJublU3SeoSBqrWtzr8Xuo+/CvcqvOov
         2OC9I3utaCjQA==
Date:   Mon, 20 Nov 2023 15:45:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
Message-ID: <20231120-grinch-upbeat-05f7a32a99fa@spud>
References: <20231119023454.1591-1-linux.amoon@gmail.com>
 <20231119023454.1591-2-linux.amoon@gmail.com>
 <20231119-phrasing-reverse-bbc1fde515d5@spud>
 <CANAwSgQ6H9FUEBKz7sCf4kUZSMnCfyXG-cpGTMZoT15W9187Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i584DEwwEuaJNfQd"
Content-Disposition: inline
In-Reply-To: <CANAwSgQ6H9FUEBKz7sCf4kUZSMnCfyXG-cpGTMZoT15W9187Kg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i584DEwwEuaJNfQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 08:57:28PM +0530, Anand Moon wrote:
> Hi Conor,
>=20
> On Sun, 19 Nov 2023 at 19:28, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Sun, Nov 19, 2023 at 08:04:50AM +0530, Anand Moon wrote:
> > > Add the binding example for the USB3.1 Genesys Logic GL3523
> > > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > > hub.
> >
> > But no comment in the commit message about the new property for the
> > "peer hub". $subject saying "dt-bindings: usb: Add the binding example
> > for the Genesys Logic GL3523 hub" is misleading when the meaningful
> > parts of the patch are unrelated to the example.
> >
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > V3: fix the dt_binding_check error, added new example for Genesys GL3=
523
> > > v2: added Genesys GL3523 binding
> > > v1: none
> > > ---
> > >  .../bindings/usb/genesys,gl850g.yaml          | 63 +++++++++++++++++=
--
> > >  1 file changed, 59 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yam=
l b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > index ee08b9c3721f..f8e88477fa11 100644
> > > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
> > >  maintainers:
> > >    - Icenowy Zheng <uwu@icenowy.me>
> > >
> > > -allOf:
> > > -  - $ref: usb-device.yaml#
> > > -
> > >  properties:
> > >    compatible:
> > >      enum:
> > > @@ -27,12 +24,44 @@ properties:
> > >
> > >    vdd-supply:
> > >      description:
> > > -      the regulator that provides 3.3V core power to the hub.
> > > +      phandle to the regulator that provides power to the hub.
> > > +
> > > +  peer-hub:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      phandle to the peer hub on the controller.
> >
> > What is this, why is it needed? Please explain it in your commit
> > message.
> >
> Ok, GL3523 integrates Genesys Logic self-developed USB 3.1 Gen 1
> Super Speed transmitter/receiver physical layer (PHY) and USB 2.0
> High-Speed PHY
>=20
> peer-hub is used to cross-connect those phy nodes so that it can help
> hub power on/off simultaneously.

I said please explain it in your commit message, but on reflection I
think that would be insufficient. Extending the description to explain
what the peer-hub is would be great too. "peer hub on the controller"
doesn't seem to make sense to me either, as the peer hub phandle is to
another phy, not to the controller. I think that would probably also be
resolved by explaining what the peer hub is in a more detailed manner.

If this is purely a genesys thing, the property should grow a genesys,
prefix also.

Cheers,
Conor.

--i584DEwwEuaJNfQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVt/IwAKCRB4tDGHoIJi
0l7WAP4jO2VytV+gaR4Fr/4ZJpmrfQ2P5ysd6CPf71fn0gDBSgEA0EeG15JAP0T2
UF4SNHfWgFn93keokaU5a5twE8yTlQA=
=o5XT
-----END PGP SIGNATURE-----

--i584DEwwEuaJNfQd--
