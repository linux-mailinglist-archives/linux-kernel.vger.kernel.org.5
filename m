Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE880EA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjLLLiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:38:05 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73FDCD;
        Tue, 12 Dec 2023 03:38:10 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ba084395d9so1503959b6e.0;
        Tue, 12 Dec 2023 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381090; x=1702985890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+L2kxEHCu62/EVSOcD5zqPnIMCZrQemKF2WuvkQ2BF4=;
        b=Bjn7Fr1/g4Rg38kquG3stvn1yHLCv0gMNYP/hoN0xro7e0kC7SyU+/PxLfE3QMXnPd
         CojxjjECgy63G5EE10/0CTr7Rs3MBVerZkJIbaN6QKcVuiGqiNuk7gnK91GpaV/mLFL/
         0hHwrEjRMHnpP7J1HHkPs+KBm1yE3KDkjizb2bIGyapbvsSf6tuJQKs0AQYafmGke5gK
         iJPTHxYDkhZGnfOfVIeL9HzhNd1N4IiLIJ1MA7aM8idbuSBLgENDMZ50d8WgU5ThqxLa
         ZmsVjh+D2YbijuY80Y9BxlL8ynWWpmgHq/5FWOJ6mVCgZX598aLT0NB/WuuV5cV88/HX
         3LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381090; x=1702985890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L2kxEHCu62/EVSOcD5zqPnIMCZrQemKF2WuvkQ2BF4=;
        b=hV3fNGm5uc/W1pd6JqflFhU+k504+vnvpfVm7f5M2ZHEL2tKaiezei03pko6K8ARWz
         rs5rgqVU0ZI48vOcdGLh6N7xcqVeoGRyoZx7i4AGUlwAxgZE5FPfj6EkFBV9tM5nlqCg
         GjwcVZa3MCY5M1V5b7a4OfGp0P9Y1n3Mwz4Nt8Z2zF9yTWkY8VhUqIQ8vOtJkMgEpgMR
         dp8IMaNIxRWnLz5AW2972tIw2afLK1zGOdFeXpoZICevTwka0PIkb5vamDm+JhEiZ+l5
         FJ3QvFLY7zFAx8rtLGA2FGu1DX99qpgHIpVaJA3BRB9x5ydN5sWb867Os89VBP4JNGLk
         aGeg==
X-Gm-Message-State: AOJu0YzLQFEb4PZWEz8kJW4b45OlJVIbs11iGV6FRlx38ModB+rIQRXs
        VosWB+S4/UYBHRQLXOxpk3jjJ99iA6Eyu4ChnTk=
X-Google-Smtp-Source: AGHT+IF+mLItRlwncGPLaOBSbWrzSF4zO2CcLPzv42Do4B8u1Slt2WF4wMUjE3qjHmiGNMT7cW9QlrmRlFHAq5rq+7I=
X-Received: by 2002:a05:6870:aa97:b0:1fb:75b:99a0 with SMTP id
 gr23-20020a056870aa9700b001fb075b99a0mr7675745oab.79.1702381089856; Tue, 12
 Dec 2023 03:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org> <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
 <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org> <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
 <604e653d-c1e2-45c7-b121-8a6b4be5c6bb@linaro.org> <CANAwSgRB=XWo2-40rDru=Zy277-kgGNjozJ8Lxnxgv_4ABB-kg@mail.gmail.com>
 <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org> <CANAwSgTy4N7Q8e0OQLsFRkRDWksTSbkOetKQGygaqsQ8++U1_g@mail.gmail.com>
 <2e688f4e-11d7-4f8e-b8ec-58f4a97304a8@linaro.org> <CANAwSgQstkS-SDaV2hj0fimt7vgfEgOT_x4efshZ6sZQ0gWSEA@mail.gmail.com>
 <8f28ea77-b3d0-445e-8d8e-80f980775f89@linaro.org>
In-Reply-To: <8f28ea77-b3d0-445e-8d8e-80f980775f89@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 12 Dec 2023 17:07:54 +0530
Message-ID: <CANAwSgRLORHb6qiHWRBR0tMbYB=O=gwatuGhk72SwZyhYMopCw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Krzysztof,

On Tue, 12 Dec 2023 at 14:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/12/2023 07:22, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Fri, 8 Dec 2023 at 17:47, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/12/2023 12:19, Anand Moon wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On Fri, 8 Dec 2023 at 13:14, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 08/12/2023 01:24, Anand Moon wrote:
> >>>>>>>>>
> >>>>>>>>> If I move reset-gpios to required, I observe the below warning.
> >>>>>>>>>
> >>>>>>>>>   DTC_CHK Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb
> >>>>>>>>> /home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> >>>>>>>>> hub@1: 'reset-gpio' is a required property
> >>>>>>>>>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> >>>>>>>>
> >>>>>>>> Where are the properties defined? If you open the binding you see:
> >>>>>>>> nowhere. You cannot define properties in some variant with "true".
> >>>>>>>> Please define all of them in top-level and only narrow/constrain when
> >>>>>>>> applicable.
> >>>>>>>>
> >>>>>>> What I meant is the example below, required meant applicable for both
> >>>>>>> the binding
> >>>>>>> But it shows me the above warning.
> >>>>>>
> >>>>>> My explanation stands... So again:
> >>>>>>
> >>>>>>>> Please define all of them in top-level and only narrow/constrain when
> >>>>>>>> applicable.
> >>>>>>
> >>>>> Apologies, But I have tried this multiple times but have not been able
> >>>>> to fix the device tree warning
> >>>>
> >>>> Did you document all properties in top-level "properties:" block?
> >>>>
> >>> Yes, I have,
> >>>
> >>> Can you suggest a couple of examples to follow?
> >>> I looked at some of the YAML files but could not fix my issue.
> >>
> >> 99% of bindings. Look also at example-schema.
> >>
> >> You can also attach here complete patch for fast look / short review.
> >>
> >
> > Please find the modified patch, I have tried a few things but none
> > resolve the binding warning.
> > I am not able to debug this.
>
> And where is the warning or the issue? Can you describe what problem do
> you have?

Here is the list of warnings I observed with this patch

  DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra186-xusb.example.dtb
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
hub@1: 'vdd-supply' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
hub@1: 'reset-gpios' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
hub@1: 'peer-hub' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/ti,tps6598x.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/xlnx,usb2.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/renesas,usb-xhci.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/renesas,usbhs.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/cypress,cypd4226.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/cdns,usb3.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/ci-hdrc-usb2.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/brcm,usb-pinmap.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/renesas,usb3-peri.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/qcom,pmic-typec.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/smsc,usb3503.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/mediatek,musb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/vialab,vl817.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/richtek,rt1711h.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/usb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/usb-drd.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/ti,j721e-usb.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/ti,am62-usb.example.dtb
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb:
hub@1: 'vdd-supply' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/genesys,gl850g.example.dtb:
hub@1: 'peer-hub' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/usb-hcd.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.example.dtb
  DTC_CHK Documentation/devicetree/bindings/usb/mediatek,mtu3.example.dtb
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb:
hub@1: 'vdd-supply' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb:
hub@1: 'reset-gpios' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb:
hub@1: 'peer-hub' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
  DTC_CHK Documentation/devicetree/bindings/usb/nxp,isp1760.example.dtb

>
> >
> > -Thanks
> > Anand
> > -----8<----------8<----------8<----------8<----------8<----------8<-----
> > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index ee08b9c3721f..7f75fa3c1945 100644
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
> > @@ -27,11 +24,47 @@ properties:
> >
> >    vdd-supply:
> >      description:
> > -      the regulator that provides 3.3V core power to the hub.
> > +      The regulator that provides 3.3V or 5.0V core power to the hub.
> > +
> > +  peer-hub:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs with
> > +      shared resets and power supplies, this property is used to identify the
> > +      hubs with which these are shared.
> >
> >  required:
> >    - compatible
> >    - reg
> > +  - vdd-supply
> > +  - reset-gpios
> > +  - peer-hub
> > +
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +
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
>
> Drop this if:, redundant.
>
No, this does not resolve the above issue.
>

Thanks
-Anand
