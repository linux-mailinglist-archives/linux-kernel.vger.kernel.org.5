Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73B7AAED2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjIVJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIVJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:54:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B36D91;
        Fri, 22 Sep 2023 02:54:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D052EC433C7;
        Fri, 22 Sep 2023 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695376439;
        bh=H7z4fKWwfHt/OpMTNjdv7ohJQ6EH5tvjq3FwutW6QMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwmkFt42xVu1vcM98TDP9FbDvl1kM2xWCZtVpv8PgKCHlYlfZvDAfEFAnvM6pqywJ
         taIA+rHIPPFAh+65Cd1ltQO3dfhPt2udIQ/1/+Am+a/Lm/YtlJSpFT7Bsbzq9mBynk
         UPhT31gBweZjJ6tl/MpTObhk5UtLjATiZjK+dntWZUXRo3MKKF+hQlCiMZaLKDnYIl
         VC2yNCiPuID9kvu9lzxfmnC3x8m5azN2oCgqcbeGqEoFQhAVu6WNZZuNvWHrgB/grZ
         nzLJs0kIKhhGZxUUpeE687ReEp8wbTlBYqbNuJTC2M+gVLGsjGGTOe4IK65LJBXxxc
         M8SRasOXpBmWw==
Date:   Fri, 22 Sep 2023 10:53:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: add MAX31790
Message-ID: <20230922-washday-primer-af8dcf1cde7d@spud>
References: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
 <20230915062926.2460502-3-Delphine_CC_Chiu@wiwynn.com>
 <20230915-quench-left-8fbc1ca3b1da@spud>
 <CAL_JsqKWRfT71k56uMUJtU_abzFuicW01OBo-iScYash4Jrd2w@mail.gmail.com>
 <TYZPR04MB58530C4CB0386DF02D29E216D6FFA@TYZPR04MB5853.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jqR+Wa25B9RWlpjh"
Content-Disposition: inline
In-Reply-To: <TYZPR04MB58530C4CB0386DF02D29E216D6FFA@TYZPR04MB5853.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jqR+Wa25B9RWlpjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 02:33:06AM +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> > > On Fri, Sep 15, 2023 at 02:29:24PM +0800, Delphine CC Chiu wrote:

> > > > +  pwm-as-tach:
> > >
> > > I don't see any other users of this in-tree, so you'd need a vendor
> > > prefix. That said, I'm once bitten, twice shy about fan related
> > > properties in hwmon, so I would definitely like Rob to comment on this
> > > whole binding.
> >
> > Please see this[1] and comment on it to ensure it meets your needs.
> > Otherwise, omit any fan related properties for now.
> >
> This property could only be used in max31790 driver. Would it be ok if we add
> vendor prefix like "maxim, pwm-as-tach"?

I think the answer to this is a pretty straightforward no. The goal is
to create a set of common fan properties that works for multiple
usecases, not create one specifically for each user...

> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +
> > > +      pwm@20 {
> > > +        compatible = "maxim,max31790";
> > > +        reg = <0x20>;
> > > +        pwm-as-tach = <2 5>;
> >
> > This would be <2>, <5>; no?
> >
> I refer to the other binding documents in hwmon and most of them were using
> the format like <2 5> as an array.

Which also makes this moot, since it'll be going away.

> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > c8fdd0d03907..97e13b6bf51d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1371,6 +1371,12 @@ F:
> >       Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> > >  F: Documentation/hwmon/max31760.rst
> > >  F: drivers/hwmon/max31760.c
> > >
> > > +ANALOG DEVICES INC MAX31790 DRIVER
> > > +M: Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
> > > +S: Odd Fixes
> >
> > This is a pretty odd status for something you're newly adding.
> > How come it's not going to be maintained?
> >
> We are not the authors of this driver but we want to add a feature to
> config PWM as TACH that was descripted in the datasheet of MAX31790.
> Should we set the status to maintained?

It's really up to you. I just found it curious & wanted to ask why it
was that way.

Thanks,
Conor.

--jqR+Wa25B9RWlpjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1kMwAKCRB4tDGHoIJi
0lLAAP42Q1Ey8FEtKiZFR8Xg0bWpfzwccwUMfTkgweDQg61O0QEAnpiWqComROc7
bJZJPVn+gHyudSG/DhsxG0NLd8S+Wwk=
=eIDN
-----END PGP SIGNATURE-----

--jqR+Wa25B9RWlpjh--
