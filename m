Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA18087E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379302AbjLGMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjLGMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:33:38 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB25AD5C;
        Thu,  7 Dec 2023 04:33:43 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58ce8513da1so322975eaf.2;
        Thu, 07 Dec 2023 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952423; x=1702557223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eoyF50C90+byNneOw67lraz5w5fqAkMLns+7xoj94Cw=;
        b=Rz8pi5yVV5X79T1Yez2j0uZYHI/gmkHZkfKOD9ZZlKQcOQpkXYXaB9LlZrKCwgLWdS
         3ivpmDrPmoOwgakbf9qtR1Lwx0tCKTze93ONEyyx+QykcyrtEVA2H6mQ8b9yR27PDdV/
         5NKs1/9ZvnQy8gGfmJOb0mCW31qxE9jekaziOB6by2TO9LR8/KVxnAr9umI6In0cJDio
         OHFT5g3uqu8M0uqkZUdttxfrylqDbdH2mj442dFgC/bTm4m/DmV1SYjn26sOLGEUQg6X
         KVHZrgP9UIlKoadsWoirk7tQoKnNEcG0P7GPsBOzvXbT2tOTbGvyMpS8tv7vxQnKw77U
         qDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952423; x=1702557223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoyF50C90+byNneOw67lraz5w5fqAkMLns+7xoj94Cw=;
        b=Lw1pBjtyeWYT5MaLzlIxQRCai6PvZuaJmdqNolOdTHWuZGpxzIy7Fl18sFBTWWsGMZ
         jzzu8gprciVZ0/ufmLIfRnnOkeH9sylRqiRC+rwmagU7F1zEm5IPiklJIGA/pckHSsjd
         2k1DwfCpD48FFIj/ep89W8d2rRhVmL5v086udBHhGVRCDfa44iydVsWMOTcWM6pEXLcP
         V9NY481Kd0JaboNK01jtCj2CKdA2KKoxKRvvYdDOGQ81sAmrc6OgqCGHmq+U9/N68d77
         VupFXTCMRHI0CA0ItD3Nd5AfW/ul70rMp/cKrJ7grLWLyGCvXU/SLUWaTBC4S6LGad4u
         L7TA==
X-Gm-Message-State: AOJu0YyOpuic+yskJHW0NK6fVC+DY2eebuT2YSyU7VmJExevIQmcxias
        kA6U1fac54T0uHrXWke1z5Dp+i/+iCdVrWrnZ0JvHpi++QZNQQ==
X-Google-Smtp-Source: AGHT+IFS8NwFi5sJw7amN4YsRotWSEY7Uv9GR7UCo3iJnNkSK0NiiYeAUIhB/yWzq4W+sEwWpOCZYlM6kE4su+J5LnI=
X-Received: by 2002:a05:6820:1ac8:b0:58d:6ea3:8fc with SMTP id
 bu8-20020a0568201ac800b0058d6ea308fcmr2905570oob.2.1701952422933; Thu, 07 Dec
 2023 04:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org> <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
 <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org>
In-Reply-To: <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 7 Dec 2023 18:03:25 +0530
Message-ID: <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
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

Hi Krzysztof

On Thu, 7 Dec 2023 at 14:00, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/12/2023 18:14, Anand Moon wrote:
> > Hi Rob,
> >
> > On Wed, 6 Dec 2023 at 19:23, Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Mon, Dec 04, 2023 at 08:14:25PM +0530, Anand Moon wrote:
> >>> Add the binding example for the USB3.1 Genesys Logic GL3523
> >>> integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> >>> hub.
> >>>
> >>> For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> >>> with shared resets and power supplies, this property is used to identify
> >>> the hubs with which these are shared.
> >>>
> >>> GL3523 has built-in 5V to 3.3V and 5V to 1.2V regulators, which serves
> >>> power to the USB HUB, it uses 5V power regulator.
> >>>
> >>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> V6: fix the description of the regulators
> >>> Updated the commit message for regulator updates.
> >>> add reviewed by Conor Dooley
> >>> [1] https://lore.kernel.org/all/20231130053130.21966-2-linux.amoon@gmail.com/
> >>> v5: upgrade peer-hub description : Conor Dooley
> >>> [0] https://www.genesyslogic.com.tw/en/product_view.php?show=67 [Block Diagram]
> >>> v4: Fix the description of peer-hub and update the commit message.
> >>> Schematics of the Odroid N2+
> >>> https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
> >>> V3: fix the dt_binding_check error, added new example for Genesys GL3523
> >>> v2: added Genesys GL3523 binding
> >>> v1: none
> >>> ---
> >>>  .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
> >>>  1 file changed, 61 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> >>> index ee08b9c3721f..c6f63a69396d 100644
> >>> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> >>> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> >>> @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
> >>>  maintainers:
> >>>    - Icenowy Zheng <uwu@icenowy.me>
> >>>
> >>> -allOf:
> >>> -  - $ref: usb-device.yaml#
> >>> -
> >>>  properties:
> >>>    compatible:
> >>>      enum:
> >>> @@ -27,12 +24,46 @@ properties:
> >>>
> >>>    vdd-supply:
> >>>      description:
> >>> -      the regulator that provides 3.3V core power to the hub.
> >>> +      The regulator that provides 3.3V or 5.0V core power to the hub.
> >>> +
> >>> +  peer-hub:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description:
> >>> +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> >>> +      with shared resets and power supplies, this property is used to identify
> >>> +      the hubs with which these are shared.
> >>>
> >>>  required:
> >>>    - compatible
> >>>    - reg
> >>>
> >>> +allOf:
> >>> +  - $ref: usb-device.yaml#
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - usb5e3,608
> >>> +    then:
> >>> +      properties:
> >>> +        peer-hub: false
> >>> +        vdd-supply: false
> >>> +        reset-gpios: true
> >>> +
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - usb5e3,610
> >>> +              - usb5e3,620
> >>> +    then:
> >>> +      properties:
> >>> +        peer-hub: true
> >>> +        vdd-supply: true
> >>> +        reset-gpios: true
> >>
> >> No need for this if schema. The default is they are allowed.
> >>
> >
> > If I move reset-gpios to required, I observe the below warning.
> >
> >   DTC_CHK Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb
> > /home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> > hub@1: 'reset-gpio' is a required property
> >         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
>
> Where are the properties defined? If you open the binding you see:
> nowhere. You cannot define properties in some variant with "true".
> Please define all of them in top-level and only narrow/constrain when
> applicable.
>
What I meant is the example below, required meant applicable for both
the binding
But it shows me the above warning.

required:
  - compatible
  - reg
  - reset-gpio

allOf:
  - $ref: usb-device.yaml#
  - if:
      properties:
        compatible:
          contains:
            enum:
              - usb5e3,608
    then:
      properties:
        peer-hub: false
        vdd-supply: false

  - if:
      properties:
        compatible:
          contains:
            enum:
              - usb5e3,610
              - usb5e3,620
    then:
      properties:
        peer-hub: true
        vdd-supply: true

additionalProperties: false

>
> Best regards,
> Krzysztof
>

Thanks
-Anand
