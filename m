Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB39A7F24C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjKUEHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUEG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:06:59 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640EA2;
        Mon, 20 Nov 2023 20:06:55 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58ceab7daddso60477eaf.3;
        Mon, 20 Nov 2023 20:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700539615; x=1701144415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uED9ZdQGQxPCqmEiK0LJztM4vTL2jEnpVnm0DVEe5EM=;
        b=l2/3XXJ6VOobGKLNZyAqFc3XQsgLYSvfTZFx43HWGXd0qtJjaXFAWyCNTdINb5/z/Z
         GVgzhBfju1KDyQ1bnbSqLy2BX1lZzXPFxHLkToQFXhYqvZIOHglWYugV9SNml+8o9Ln7
         DoMVsVZZvfwX0sJpE8225IFZYwQ3SnXB/qh7i2AHWiJSjuao6BjcNNuvbm7Z2l3HEvcw
         cGQAlhltcY85XjE813lGZY7emnALapCsyPxUv4+ZDRC9n/cNXdj5tCHFG8pc52QaH0oI
         0oBwdtKaRwI9TUS6DY7U7OJOwcdCSBMfKp3EMeDwQJFsM4nqiOoJ1kCT/UXo+Uegz809
         WaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700539615; x=1701144415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uED9ZdQGQxPCqmEiK0LJztM4vTL2jEnpVnm0DVEe5EM=;
        b=b6PUwn1obWB4GGu9KZ2rC2w9g4fhigqvlfUW/wAxwyt8dORdbS4UQtc6+/ItmWRbve
         UnjG8ye8jXlBEDYZSSLjYrhxstQJNTg3SbmOEcpYj2UUaX1jbkrZYLfu1FVpcYCw3rTe
         oojF+jP9LvOk2bK0S14xWLstafqtH1oYQwWl5ABk/aqGF+8mfhIzsKyBtslRH0i50doQ
         /TK/FL81oGvEKJszNZ0DsJDlv0BJfJ+971EzzKldFPRriomY5gGxy4DnT1tlzMVZHwqx
         qYfTzsIE3G4Vap13BLHf5+8Dsr38dVneInfrA11Gpqthb8lDgLVmNuimGxT4ypsuW8aU
         Mz4Q==
X-Gm-Message-State: AOJu0YzRWO937j1JiRDWy5B6sFVSNAGzr8Yuav/eu4buhxAV6EGvrufr
        SBFuRIYIpc5h47dqdSsacQoZ83XcDsg7IcmKjwfOIOTzFtk=
X-Google-Smtp-Source: AGHT+IGEd1ffV8b215+cvSBI4uGIXsdv+yw5uXnbrjp5GMhPt/B05vpdrYE051i9meuJRhoqbKeBVz4MuD9yHsOXuDk=
X-Received: by 2002:a05:6820:1c85:b0:57b:86f5:701c with SMTP id
 ct5-20020a0568201c8500b0057b86f5701cmr8776555oob.4.1700539614644; Mon, 20 Nov
 2023 20:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20231119023454.1591-1-linux.amoon@gmail.com> <20231119023454.1591-2-linux.amoon@gmail.com>
 <20231119-phrasing-reverse-bbc1fde515d5@spud> <CANAwSgQ6H9FUEBKz7sCf4kUZSMnCfyXG-cpGTMZoT15W9187Kg@mail.gmail.com>
 <20231120-grinch-upbeat-05f7a32a99fa@spud>
In-Reply-To: <20231120-grinch-upbeat-05f7a32a99fa@spud>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 21 Nov 2023 09:36:37 +0530
Message-ID: <CANAwSgQGhDMeHLFpe8gnM2c26CjqX8QHOL1GdHrZJSvnBj39bA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, 20 Nov 2023 at 21:15, Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Nov 19, 2023 at 08:57:28PM +0530, Anand Moon wrote:
> > Hi Conor,
> >
> > On Sun, 19 Nov 2023 at 19:28, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Sun, Nov 19, 2023 at 08:04:50AM +0530, Anand Moon wrote:
> > > > Add the binding example for the USB3.1 Genesys Logic GL3523
> > > > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > > > hub.
> > >
> > > But no comment in the commit message about the new property for the
> > > "peer hub". $subject saying "dt-bindings: usb: Add the binding example
> > > for the Genesys Logic GL3523 hub" is misleading when the meaningful
> > > parts of the patch are unrelated to the example.
> > >
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > V3: fix the dt_binding_check error, added new example for Genesys GL3523
> > > > v2: added Genesys GL3523 binding
> > > > v1: none
> > > > ---
> > > >  .../bindings/usb/genesys,gl850g.yaml          | 63 +++++++++++++++++--
> > > >  1 file changed, 59 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > index ee08b9c3721f..f8e88477fa11 100644
> > > > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
> > > >  maintainers:
> > > >    - Icenowy Zheng <uwu@icenowy.me>
> > > >
> > > > -allOf:
> > > > -  - $ref: usb-device.yaml#
> > > > -
> > > >  properties:
> > > >    compatible:
> > > >      enum:
> > > > @@ -27,12 +24,44 @@ properties:
> > > >
> > > >    vdd-supply:
> > > >      description:
> > > > -      the regulator that provides 3.3V core power to the hub.
> > > > +      phandle to the regulator that provides power to the hub.
> > > > +
> > > > +  peer-hub:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description:
> > > > +      phandle to the peer hub on the controller.
> > >
> > > What is this, why is it needed? Please explain it in your commit
> > > message.
> > >
> > Ok, GL3523 integrates Genesys Logic self-developed USB 3.1 Gen 1
> > Super Speed transmitter/receiver physical layer (PHY) and USB 2.0
> > High-Speed PHY
> >
> > peer-hub is used to cross-connect those phy nodes so that it can help
> > hub power on/off simultaneously.
>
> I said please explain it in your commit message, but on reflection I
> think that would be insufficient. Extending the description to explain
> what the peer-hub is would be great too. "peer hub on the controller"
> doesn't seem to make sense to me either, as the peer hub phandle is to
> another phy, not to the controller. I think that would probably also be
> resolved by explaining what the peer hub is in a more detailed manner.
>
> If this is purely a genesys thing, the property should grow a genesys,
> prefix also.
>
No, some USB Hub have combined phy for USB 3.x and USB 2.0 and have common
reset-gpios and power supply, peer-hub node helps connect the USB controller and
bring up the USB hub.

I was waiting for more feedback on these changes.
Once it's ok I will update with proper the commit message in v4.

Thanks
-Anand

> Cheers,
> Conor.
