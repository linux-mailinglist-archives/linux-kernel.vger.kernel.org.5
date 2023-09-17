Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EF7A3533
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjIQKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjIQKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:33:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1D12C;
        Sun, 17 Sep 2023 03:33:10 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D93711B3C;
        Sun, 17 Sep 2023 12:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694946695;
        bh=RG3ql9gtMqNW3s9nmLlEu2DheG80j6Lu2WZiShLfDgk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nT2GiYgJC+e3JII7epdakslbBysfWMZrIkk7eu1pmDkDU7vst+1eK0hsDmG9XtI55
         puW+orr+YNvsQKxJQxwjd4dQ35fgvm7l5+DY6mjVXYSDjLQ31nVNDdH4ibebezZ7MB
         ghoR3SA/1oaC0DEm4WJ5LNEUHLUUc1bxjjM7YiGY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <22bc83c7-17c3-f8a0-b1de-5d6b2e1e29b2@linaro.org>
References: <20230915165946.4183839-1-kieran.bingham@ideasonboard.com> <20230915165946.4183839-2-kieran.bingham@ideasonboard.com> <22bc83c7-17c3-f8a0-b1de-5d6b2e1e29b2@linaro.org>
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: media: i2c: Add ROHM BU64754 bindings
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, open list:
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org
Date:   Sun, 17 Sep 2023 11:33:07 +0100
Message-ID: <169494678738.1922990.10472250640303677004@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-09-17 10:37:07)
> On 15/09/2023 18:59, Kieran Bingham wrote:
> > Add YAML device tree bindings for the ROHM BU64754 VCM Motor Driver for
> > Camera Autofocus.
> >=20
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > ---
>=20
> ...
>=20
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - rohm,bu64754
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
>=20
> If the supply is not required, how the driver gets any power?

It may not be controllable. It could be wired to be always on.

The device has a low power mode which is controllable by software, so it
could be always powered on and controlled via software only if desired.
The driver handles that already as if the regulator isn't specified the
power down register bits will be set to put it in low power mode.


>=20
> > +    description:
> > +      Definition of the regulator used as VDD power supply to the driv=
er.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        lens@76 {
> > +            compatible =3D "rohm,bu64754";
> > +            reg =3D <0x76>;
> > +            vdd-supply =3D <&cam1_reg>;
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90f13281d297..f43e0ffcaf56 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18570,6 +18570,13 @@ S:   Supported
> >  F:   drivers/iio/light/rohm-bu27008.c
> >  F:   drivers/iio/light/rohm-bu27034.c
> > =20
> > +ROHM BU64754 MOTOR DRIVER FOR CAMERA AUTOFOCUS
> > +M:   Kieran Bingham <kieran.bingham@ideasonboard.com>
> > +L:   linux-media@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://linuxtv.org/media_tree.git
>=20
> Do you have push rights there? The git entry is for entries where you
> maintain, which means: you accept and apply patches. This does not look
> like the case, so copying subsystem Git entry is pointless. Subsystem
> maintainer defines the git tree, not you.

I'll drop the line.

>=20
> Best regards,
> Krzysztof
>
