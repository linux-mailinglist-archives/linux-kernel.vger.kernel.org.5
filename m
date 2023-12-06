Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE6807633
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378538AbjLFROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjLFROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:14:37 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EECD3;
        Wed,  6 Dec 2023 09:14:41 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d7fa93afe9so3897980a34.2;
        Wed, 06 Dec 2023 09:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882880; x=1702487680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0A3N+96A+1Q1WOKJBTgT0YZdafSP9BVjbGQLT1Px9rg=;
        b=YovOouNgTODG/pzmSMtVeE2GhHjiCAbFomMiTBpEyX3E2JTz4ZXvg/sziWGrci+ul1
         zR75H13sSNcz7luqQar2h5adwDNKuttuviUy88CRzCvuvYdRNCuY9NtljIFDzCjXmXgl
         GDgi83mpgcOnIrZcRN4L88J57fsowE1IjGj7e9HraIJuE9cvC+lmgk39Q9Y48CXiN/0k
         aYuFY/RoUpMMllH19Fj7hWL2zEIP6dyrf2xIbmnxzFlbYzPWCCD4L8LAit5QhGgzNjSy
         GML9OqzF1oRSB8FnMAc4V+bA6U9NmaR1KhGwT4+DxLP7saFZ9URCSCalXVZ2Qfp6LKVW
         awGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882880; x=1702487680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A3N+96A+1Q1WOKJBTgT0YZdafSP9BVjbGQLT1Px9rg=;
        b=mRcfJZeIm8ieqG9EBB5Uf8h5jAgoNJQCZ9Nh9MKk+lmBuE1ZDxnDH/biBqWrHws+V9
         K+UQhRMNmNNttcdu3mX30HWI0ytO4SFr/O5WNxQscoeSmVbyq7gGP49U0zamKxSFGfBe
         3paHhDa3pWkMZn2tG+0RSW5BGHUa2J2XEkqr7hBZqWBK9/fyeR4Gwcd/I544S/TZOlYH
         6ZH0OmUsxbadhC8rH/bqOLWCxtF8uEgOYklslj6VVsgsA3hY/3IIFPId8PGeWWrmg2ZA
         zG4UhSdwTeL4oqFQ2ky5bwPWVgLkJz9Sp46ftTDUnxSaajM4kLdG+28JjZ2hTmasZiq1
         L4yQ==
X-Gm-Message-State: AOJu0YweDf079x/ysGpg+zVzO4LjhKNsC4b45j+dgl6ThQDHsa/HmgK7
        n06/oQMCYbmUsgahnPwbLht2mTmDjDbWdKnSyjA=
X-Google-Smtp-Source: AGHT+IHXBDJwsUWKBFw4DqlEqnhQX9IUX2BaSV8wq52NeyLZimuYnsac+q5/+DjzsdbKheZI6/62489OkjicV+ovZqg=
X-Received: by 2002:a05:6870:970c:b0:1fb:75a:c421 with SMTP id
 n12-20020a056870970c00b001fb075ac421mr1176895oaq.74.1701882880366; Wed, 06
 Dec 2023 09:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org>
In-Reply-To: <20231206135311.GA2043711-robh@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 6 Dec 2023 22:44:24 +0530
Message-ID: <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 6 Dec 2023 at 19:23, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 04, 2023 at 08:14:25PM +0530, Anand Moon wrote:
> > Add the binding example for the USB3.1 Genesys Logic GL3523
> > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > hub.
> >
> > For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> > with shared resets and power supplies, this property is used to identify
> > the hubs with which these are shared.
> >
> > GL3523 has built-in 5V to 3.3V and 5V to 1.2V regulators, which serves
> > power to the USB HUB, it uses 5V power regulator.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V6: fix the description of the regulators
> > Updated the commit message for regulator updates.
> > add reviewed by Conor Dooley
> > [1] https://lore.kernel.org/all/20231130053130.21966-2-linux.amoon@gmail.com/
> > v5: upgrade peer-hub description : Conor Dooley
> > [0] https://www.genesyslogic.com.tw/en/product_view.php?show=67 [Block Diagram]
> > v4: Fix the description of peer-hub and update the commit message.
> > Schematics of the Odroid N2+
> > https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
> > V3: fix the dt_binding_check error, added new example for Genesys GL3523
> > v2: added Genesys GL3523 binding
> > v1: none
> > ---
> >  .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
> >  1 file changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index ee08b9c3721f..c6f63a69396d 100644
> > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
> >  maintainers:
> >    - Icenowy Zheng <uwu@icenowy.me>
> >
> > -allOf:
> > -  - $ref: usb-device.yaml#
> > -
> >  properties:
> >    compatible:
> >      enum:
> > @@ -27,12 +24,46 @@ properties:
> >
> >    vdd-supply:
> >      description:
> > -      the regulator that provides 3.3V core power to the hub.
> > +      The regulator that provides 3.3V or 5.0V core power to the hub.
> > +
> > +  peer-hub:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> > +      with shared resets and power supplies, this property is used to identify
> > +      the hubs with which these are shared.
> >
> >  required:
> >    - compatible
> >    - reg
> >
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - usb5e3,608
> > +    then:
> > +      properties:
> > +        peer-hub: false
> > +        vdd-supply: false
> > +        reset-gpios: true
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - usb5e3,610
> > +              - usb5e3,620
> > +    then:
> > +      properties:
> > +        peer-hub: true
> > +        vdd-supply: true
> > +        reset-gpios: true
>
> No need for this if schema. The default is they are allowed.
>

If I move reset-gpios to required, I observe the below warning.

  DTC_CHK Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb
/home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
hub@1: 'reset-gpio' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/mediatek,musb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/usb251xb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb
/home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb:
hub@1: 'reset-gpio' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/brcm,bdc.example.dtb
/home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb:
hub@1: 'reset-gpio' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/xlnx,usb2.example.dtb
/home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb:
hub@2: 'reset-gpio' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/starfive,jh7110-usb.example.dtb

> Rob

Thanks
-Anand
