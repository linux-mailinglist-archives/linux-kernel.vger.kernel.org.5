Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881080A46E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjLHN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:28:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86F10F8;
        Fri,  8 Dec 2023 05:28:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b3b78e6729so89370439f.0;
        Fri, 08 Dec 2023 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702042118; x=1702646918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=twc1QPu9ihF+Hs8YdcNs0/iSwASAhLQkShb/tyRpK1Q=;
        b=C+AX6YN3Hz15fOgz/Cn50BHrojEEO7ku5f7t9zE4o+gBd1FuFYHDFb+FiaY0CcMcMf
         lqcsbfoakyQvrdSj+iwS+AXJg3oqtdMJWxRosgduRpYsBV3kx2Psv7oSTEEotCyLRz1+
         rTWA0Nv0T6m7iC2SBeR83eGCW6RcEpkUjc2KmcoJ7gEcaVTgohYmonxMXsjHheXsFESd
         NUtpwWLy1R6Lf4MY3u6D9S4WLgsy+8VHjPlMsiNfZGY5lukKjt1h5l8931SIz1zmDrW2
         uMiu23VvPwiAuoHKqmucG4R9CTGU6b32OzPYqFNh7xLnQoe1098Qj+sxgoTnZLlwKvWz
         U6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042118; x=1702646918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twc1QPu9ihF+Hs8YdcNs0/iSwASAhLQkShb/tyRpK1Q=;
        b=K2Xax6yV4ealu9on//uSSvC+HU6l09t/B7/rlVhgrUHSvbEjVVn2aYcULQqDKu5c4B
         Uqcl47FlICtWSmFL5PXZbNJeP+qxkAg4h5jmFPF+UuvSsKG/0Pe3GufrsLWSpCC5geMY
         La+Nw47DBgF2ddMPkWxIAjT9pgQah9ItRL7GXj+ufzuf9aAnN7utYLkJRNoqEWu/vaC1
         mX8TAqUHr/xBJNXkfe4qw859MpM7a7izpda2AWWnuyq2HDLaigMaASb/LtKjBEBqwTIt
         RsFvHpnrQ0T0pMNP4ksDXGpwsfggEE12LBk7d0WT8X1eZVfWHQfv6MaoqofnWofQORhQ
         GLWA==
X-Gm-Message-State: AOJu0YzKROWkwVdYruGem0IVFFyWn+pLWXep0rX8KLROaWn4ScRXlnRK
        1ZqYjejn77HenrQUvq54mgQ=
X-Google-Smtp-Source: AGHT+IFdVj1sey6vpWlhbeoUAywRF5AgS3VAPlOF/5rHOPAWU3xxbZUtGZtJuEJqiXobe5chsf+VCw==
X-Received: by 2002:a05:6e02:1beb:b0:35d:61b8:faad with SMTP id y11-20020a056e021beb00b0035d61b8faadmr177592ilv.27.1702042118396;
        Fri, 08 Dec 2023 05:28:38 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id z5-20020aa78885000000b0064fd4a6b306sm1555675pfe.76.2023.12.08.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:28:37 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:28:25 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] dt-bindings: iio: Add AD7091R-8
Message-ID: <ZXMZ-Y18SwIFEIgA@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
 <CAMknhBEFnTUm9FPK-74+GkJs2d80dS+Q9WeGTxd3Ajs-JJGcdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBEFnTUm9FPK-74+GkJs2d80dS+Q9WeGTxd3Ajs-JJGcdA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, thank you for your suggestions.
Comments inline.

On 12/07, David Lechner wrote:
> On Thu, Dec 7, 2023 at 12:42 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Add device tree documentation for AD7091R-8.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7091r8.yaml        | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> > new file mode 100644
> > index 000000000000..02320778f225
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r8.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7091R8 8-Channel 12-Bit ADC
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +
> > +description: |
> > +  Analog Devices AD7091R-8 8-Channel 12-Bit ADC
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7091R-2_7091R-4_7091R-8.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7091r2
> > +      - adi,ad7091r4
> > +      - adi,ad7091r8
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> 
> Missing other supplies? Like vdd-supply and vdrive-supply?
> 

I used the name that would work with ad7091r-base.c.
If I'm not misinterpreting the datasheet, vdd-supply and vdrive-supply are
for powering the ADC and setting SPI lanes logic level, respectively.
They don't have any impact on ADC readings.
By the way, should maybe I extend ad7091r5 dt doc instead of creating this
new one?

> > +  vref-supply: true
> 
> refin-supply might be a better name to match the datasheet pin name.
> 

Agree, though I guess changing the name now would break users of ad7091r5 if
they happen to update the driver without updating their device tree.

> > +
> > +  adi,conversion-start-gpios:
> 
> gpios usually don't get a vendor prefix do they?
> 
> convst-gpios could be a better name to match the pin name on the datasheet.

Ack, will do for v4.

> 
> > +    description:
> > +      GPIO connected to the CONVST pin.
> > +      This logic input is used to initiate conversions on the analog
> > +      input channels.
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> 
> A description of what the interrupt is attached to (ALERT/BUSY/GPO0
> pin) would be helpful.
> 

Ack, will do for v4.

> > +
> > +patternProperties:
> > +  "^channel@[0-7]$":
> > +    $ref: adc.yaml
> > +    type: object
> > +    description: Represents the external channels which are connected to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 7
> 
> Shouldn't this be:
> 
>         items:
>           - minimum: 0
>             maximum: 7
> 

Ack

> > +
> > +    required:
> > +      - reg
> 
> Missing `unevaluatedProperties: false` for channels?
> 
> Bigger picture: since no other properties besides `reg` are included
> here, do we actually need channel nodes?
> 

The channel nodes are not used by the drivers so we can remove them if we want.
I thought they would be required as documentation even if they were not used
in drivers.
Looks like they're not required so will remove them in v4.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - adi,conversion-start-gpios
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +  # AD7091R-2 does not have ALERT/BUSY/GPO pin
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7091r4
> > +              - adi,ad7091r8
> > +    then:
> > +      properties:
> > +        interrupts: true
> 
> Interrupts is already true. Maybe better to only match chips without
> interrupts and set false?
> 

Agree, that should simplify the constrain logic. Will do for v4.

> > +    else:
> > +      properties:
> > +        interrupts: false
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +                compatible = "adi,ad7091r8";
> > +                reg = <0x0>;
> > +                spi-max-frequency = <45454545>;
> > +                vref-supply = <&adc_vref>;
> > +                adi,conversion-start-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
> > +                reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> > +                interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
> > +                interrupt-parent = <&gpio>;
> > +        };
> > +    };
> > +...
> > --
> > 2.42.0
> >
> >
