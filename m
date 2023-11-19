Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60FB7F072A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjKSP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:27:49 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559C83;
        Sun, 19 Nov 2023 07:27:46 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-586ad15f9aaso1894288eaf.2;
        Sun, 19 Nov 2023 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700407665; x=1701012465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVg6tuBAQxkmNGNJSWkr/sGMIKsv+ywhAtTchPGIaoE=;
        b=XKSNTmnizcY8puqo2pBlx32MJgSXiqNk2VY3S2hbGdS/BQZRwEF1ICt+spRXDL3jpw
         edodHW9r34zoDPtShNyzqFCrxTlaaiYklj34GbT3fEIQqEwtbN03cYQ9sRtomKHb9PP3
         dv7TS0CckmvrQC0K1bYmSqixs+SUo+4M4wuJq/okqc5ljavgS+WqTyDApspBzTcsLmKB
         gT0p/Pt1tlMiKvFx1qYW/wOn7I+k0SnZnpclOWTA8c9s2gMpzlQP29nsW7tuQ1244HX+
         306jh038Bc3MMtq6T2mom5JzJ7Rg8hmWE8mSqVBGixuIgoue/Dg7sJ7/HGyFZ+9xhRkk
         u6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700407665; x=1701012465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVg6tuBAQxkmNGNJSWkr/sGMIKsv+ywhAtTchPGIaoE=;
        b=VnaUBMxWxtRcSDft/eUMXh+DERBG/JucswCfrEokmmQ0Uzrh2LaVMXqsUi0Z7nHg3l
         yaVojj9eDQJHDgREkiLtZIJ1uHL6gJ+3Ry9yC9wHTEbV5fKZ9tIhi/XDOmlPgU75EJGa
         iax3tg1y67nOM0jOD66Y/NBgat5bXzsCOXv72DKtJ1uFfvTdaG1GvYmBPjAujVtBxeSh
         e55sBoYt69kKHVVOnzVOCStnn2NiowS84oIBH/2o9OS/oZD0oENxDdmFn1EZ/2N0Xzt3
         CAElh62rnmuDi0ez3cLUc3K3Z2OJ/u6QlDLOX4GmqBinY5NuaJIfJfbZka1idHN+NSV0
         ao7g==
X-Gm-Message-State: AOJu0YxxiLapdy5MK2c7kno/Z1jHxU/yqlx1KR2QpNjhnDXf/zG5aAsr
        6XKdfoTnu6FaPr8SqCZh3gU4+6awbylmTgZZGK8=
X-Google-Smtp-Source: AGHT+IGDUPNiW0ynsdFghY8VYMcG3VDos2+nvo5Hf4XCfQo6k9gL9MKK5TIEI1F5eoq7dOvaDOd3xqfD4v+xb1rBLnU=
X-Received: by 2002:a05:6820:16ac:b0:58a:128:8ff0 with SMTP id
 bc44-20020a05682016ac00b0058a01288ff0mr4456393oob.5.1700407665238; Sun, 19
 Nov 2023 07:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20231119023454.1591-1-linux.amoon@gmail.com> <20231119023454.1591-2-linux.amoon@gmail.com>
 <20231119-phrasing-reverse-bbc1fde515d5@spud>
In-Reply-To: <20231119-phrasing-reverse-bbc1fde515d5@spud>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 19 Nov 2023 20:57:28 +0530
Message-ID: <CANAwSgQ6H9FUEBKz7sCf4kUZSMnCfyXG-cpGTMZoT15W9187Kg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Sun, 19 Nov 2023 at 19:28, Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Nov 19, 2023 at 08:04:50AM +0530, Anand Moon wrote:
> > Add the binding example for the USB3.1 Genesys Logic GL3523
> > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > hub.
>
> But no comment in the commit message about the new property for the
> "peer hub". $subject saying "dt-bindings: usb: Add the binding example
> for the Genesys Logic GL3523 hub" is misleading when the meaningful
> parts of the patch are unrelated to the example.
>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V3: fix the dt_binding_check error, added new example for Genesys GL3523
> > v2: added Genesys GL3523 binding
> > v1: none
> > ---
> >  .../bindings/usb/genesys,gl850g.yaml          | 63 +++++++++++++++++--
> >  1 file changed, 59 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index ee08b9c3721f..f8e88477fa11 100644
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
> > @@ -27,12 +24,44 @@ properties:
> >
> >    vdd-supply:
> >      description:
> > -      the regulator that provides 3.3V core power to the hub.
> > +      phandle to the regulator that provides power to the hub.
> > +
> > +  peer-hub:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to the peer hub on the controller.
>
> What is this, why is it needed? Please explain it in your commit
> message.
>
Ok, GL3523 integrates Genesys Logic self-developed USB 3.1 Gen 1
Super Speed transmitter/receiver physical layer (PHY) and USB 2.0
High-Speed PHY

peer-hub is used to cross-connect those phy nodes so that it can help
hub power on/off simultaneously.

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 001: Dev 002, If 0, Class=Hub, Driver=hub/4p, 480M
        ID 05e3:0610 Genesys Logic, Inc. Hub
        |__ Port 003: Dev 004, If 0, Class=Vendor Specific Class,
Driver=cp210x, 12M
            ID 10c4:ea60 Silicon Labs CP210x UART Bridge
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 001: Dev 002, If 0, Class=Hub, Driver=hub/4p, 5000M
        ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
        |__ Port 001: Dev 003, If 0, Class=Mass Storage,
Driver=usb-storage, 5000M
            ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA 6Gb/s
bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
ASM1153E SATA 6Gb/s bridge

Thanks
-Anand

> Thanks,
> Conor.
>
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
> > +
> >  additionalProperties: false
> >
> >  examples:
> > @@ -49,3 +78,29 @@ examples:
> >              reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
> >          };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    usb {
> > +        dr_mode = "host";
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        /* 2.0 hub on port 1 */
> > +        hub_2_0: hub@1 {
> > +            compatible = "usb5e3,610";
> > +            reg = <1>;
> > +            peer-hub = <&hub_3_0>;
> > +            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
> > +            vdd-supply = <&vcc_5v>;
> > +        };
> > +
> > +        /* 3.1 hub on port 4 */
> > +        hub_3_0: hub@2 {
> > +            compatible = "usb5e3,620";
> > +            reg = <2>;
> > +            peer-hub = <&hub_2_0>;
> > +            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
> > +            vdd-supply = <&vcc_5v>;
> > +        };
> > +    };
> > --
> > 2.42.0
> >
