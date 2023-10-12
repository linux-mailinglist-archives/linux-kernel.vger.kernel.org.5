Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E907C732E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378739AbjJLQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjJLQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:37:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1CA9;
        Thu, 12 Oct 2023 09:37:42 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso577706fac.0;
        Thu, 12 Oct 2023 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128662; x=1697733462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9u1kAvrEac9Qi+MHI/eb0phIPTWwLhAQGTfL68QyLNI=;
        b=LhHD5o7bS7irbCkNgC4qxx/7hGh4y/vqTfI+a8PobWh7tYEev3dTmLV+aAGUmttFCB
         IrQ5a6D4K6CIVxzKK0d2Bc9ryzYQqOGYXIZ0IRrrtv6SpS3xiLmzkPRDktKvyC0fGbz5
         QBlV1CBaNYCI9pF9zUE4kWkxohcydbW33d1DYSJv5AgJ+4vdnlc3ZukHPwaBOG8A2nXN
         vG3+PSOyXt3pVFhxLBJw6FTHl/gPE6BgZzOSsslBuoy8OF4uQ2cZSOn0sVHAIlUwgcBo
         X8QXbELl2HlD+fl2P7VJ2XdJLYa+ARte1uwVHuW9vUsmOmmF68nX87zcmGHcAVXdtDTm
         A6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128662; x=1697733462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9u1kAvrEac9Qi+MHI/eb0phIPTWwLhAQGTfL68QyLNI=;
        b=C8jwOF8Plgzj72Qd1s7PKATs9AQqr36Byp9RKZQ4UtLvCIqa7cRZVFOFZnA3exUPgA
         bYGuojjocWMpfpQMVLzz+pncqBMXQxJEcHTmU5hV3odOnuqnUJzh0ChgDmPy3S4LTWCO
         SdwoJkfQSoAZ2je3JT3iEvD3BWdSH01L/TnPAI4NagsTeyanUKnt3fgCivaBnGbYhRAl
         wvuyFNx+3Esput2TXWtNb+SnMt7WC+N4ZG60ZKc7o41gohCW9g8u384CXp+atXUvmlJX
         bsuyk/tJm7IUZME9oAD+HuVvePwemGriKkYlPjghgv7CSrylreW9XAIc9Pi1kUezaTyy
         FUFQ==
X-Gm-Message-State: AOJu0Yyz39fGwIDcmRSQfHO+a8BUPLGpHqtBpQTd5prBnA3Ku9Wfk8+I
        QKkoCkQ4TOKPEhBq4Q7MPu5//KGlii/DmphP55I=
X-Google-Smtp-Source: AGHT+IF3idoTvk3iQIydZOFUuTHb9X53/KuzrTwT1V/yxZI4ZBgG+GdHFpUOuv/G18GACk/bYhQbBFdOratw7VpY67I=
X-Received: by 2002:a05:6871:d13:b0:1e9:7078:9f3b with SMTP id
 vh19-20020a0568710d1300b001e970789f3bmr3895870oab.10.1697128662009; Thu, 12
 Oct 2023 09:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051152.133257-1-linux.amoon@gmail.com> <abe72aae-c43c-487a-8021-2c0f54319a5b@linaro.org>
In-Reply-To: <abe72aae-c43c-487a-8021-2c0f54319a5b@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 12 Oct 2023 22:07:26 +0530
Message-ID: <CANAwSgQa3_ROnYyDZA958ZvFu0tb7qsVJ0Loij0saYRKEec_xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 12 Oct 2023 at 13:13, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/10/2023 07:11, Anand Moon wrote:
> > Add the binding example for the USB3.1 Genesys Logic GL3523
> > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > hub.
>
> That's not what the patch does.

Ok I have tried to add an example below the original changes
but the device tree complained of duplicate entries. Hence I
modified these changes.

This change was requested to update the peer-hub example below.
[0] https://lore.kernel.org/all/9fe7d0d2-3582-4b62-be9b-aa9134c18023@linaro.org/

>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch.
> > ---
> >  .../bindings/usb/genesys,gl850g.yaml          | 28 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index d0927f6768a4..2f6e0c870e1d 100644
> > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > @@ -22,29 +22,51 @@ properties:
> >    reg: true
> >
> >    reset-gpios:
> > +    maxItems: 1
>
> Why?

Following another example, I added this and will drop this.
>
> >      description: GPIO controlling the RESET# pin.
> >
> >    vdd-supply:
> >      description:
> >        the regulator that provides 3.3V core power to the hub.
> >
> > +  peer-hub:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to the peer hub on the controller.
> > +
> >  required:
> >    - compatible
> >    - reg
> > +  - reset-gpios
>
> Why?
see below.
>
> > +  - vdd-supply
> > +  - peer-hub
> >
> >  additionalProperties: false
> >
> >  examples:
> >    - |
> >      #include <dt-bindings/gpio/gpio.h>
> > +
> >      usb {
> >          dr_mode = "host";
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >
> > -        hub: hub@1 {
> > -            compatible = "usb5e3,608";
> > +        /* 2.0 hub on port 1 */
> > +        hub_2_0: hub@1 {
> > +            compatible = "usb5e3,610";
> >              reg = <1>;
> > -            reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
> > +            vdd-supply = <&vcc_5v>;
> > +            peer-hub = <&hub_3_0>;
> > +            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
> > +        };
> > +
> > +        /* 3.1 hub on port 4 */
> > +        hub_3_0: hub@2 {
> > +            compatible = "usb5e3,620";
> > +            reg = <2>;
> > +            vdd-supply = <&vcc_5v>;
> > +            peer-hub = <&hub_2_0>;
> > +            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
>
> Really, what is happening here?

USB hub GL3523-QFN76 supports two pins CHIP_EN and RST_N pins
so RST_N (GPIOH_4) is used to reset the USB hub,
earlier we were using gpio-hog to reset the hub.

>
> Best regards,
> Krzysztof
>

Thanks
-Anand
