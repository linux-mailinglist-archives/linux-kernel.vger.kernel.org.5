Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436777B5E52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbjJCAmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjJCAmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:42:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80BAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:42:03 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a707bc2397so58648b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696293723; x=1696898523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NUDE2+H89he6BS9I3HNkP9B+FIe1jpB9GTuSekloXo=;
        b=vBL9U+8nnThHF7jmPYJB9EkvqZL2i7Nu1Ayg8VDxn4pNVMnJMlHeRmXe1i0KYdIh5D
         7fpmzF/73jQinW2lL4rG4Sv3HZK4cwDbcYACZxBpOyGWo/R9NlZgMtMy1uKXK+aW+Uew
         aIoE7hzrOtYOxZkEfLLY5MNpr+6iJO10cLkk+OjdnWSmG85GQuHC0ozkXna4HnblhL11
         /iG1jtqIIgHSNjI2ZSkMJ/XumEn84TMNj5bDJ3KFsukcNz493xbfcG3dXpFGHZA7aZRl
         DD/v/fpnOwsQXECQIbcy5FALWHzN3lN1iF2P5+CDQbvhZIFMgnhbu9qnTl10siywpBr9
         K0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293723; x=1696898523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NUDE2+H89he6BS9I3HNkP9B+FIe1jpB9GTuSekloXo=;
        b=e+6kh+nL9rXDSSD8OUgtjpD9Dduzp88shb/gWlsJaIS0TWQ4IPmSNUcjwEKh/Qp4pH
         7dfg83WA7Dwo3JAUXF+X9Q6AdEndGNNknaXPI4U1kgrheTCPAxFN7acNvq2xs96wueTA
         i7CCoVZXD5UKheSUOkqzHO+MKEvExINEBjb4UTm5G0T56pT1uAtLBh917RKo3I09YPMq
         gr92vBK8xizSvyPfjkikmAqEnpUAJZgSG+gp9tRZeLVu4OT8WtF1RflyBu0zHnUvPUCg
         xL2glWfP9Qj6aI2zql/xdZyerB16rWJvTacZpLJ1h+gdgUnWWWqfDfaPkan3alx/N9Ce
         S9nw==
X-Gm-Message-State: AOJu0YwEse/MxO3cq4l8DvDgT8/oel7BfInkgToknJvaSlXEJHNzj0b8
        RembuUS8Oqff5FnWrbWeztxIlQ==
X-Google-Smtp-Source: AGHT+IGlw1kZKdt+UyAH31lC9JsO/OzHGFTE0E91BQ34s5sGYXbhHt7x/H/hFaTuM1t44AIWZKwO6w==
X-Received: by 2002:a05:6808:3614:b0:3ad:f5d8:2da9 with SMTP id ct20-20020a056808361400b003adf5d82da9mr10798904oib.4.1696293722812;
        Mon, 02 Oct 2023 17:42:02 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:783d:e8bb:e013:a869])
        by smtp.gmail.com with ESMTPSA id a20-20020a637f14000000b0057d86bb613esm75006pgd.45.2023.10.02.17.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:42:02 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:41:58 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl based
 gpio
Message-ID: <ZRtjVnWhAK2CZaRM@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-5-takahiro.akashi@linaro.org>
 <20231002144155.GA1675188-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002144155.GA1675188-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 02, 2023 at 09:41:55AM -0500, Rob Herring wrote:
> On Mon, Oct 02, 2023 at 11:16:02AM +0900, AKASHI Takahiro wrote:
> > A dt binding for SCMI pinctrl based gpio driver is defined in this
> > commit. It basically conforms to generic pinctrl-gpio mapping framework.
> 
> What is "generic pinctrl-gpio mapping framework"? DT doesn't have 
> frameworks.

I meant to refer to section 2.1-2.3 in "Documentation/devicetree/bindings/gpio/gpio.txt". The semantics is implemented in drivers/gpio/gpiolib(-of).c.

> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  .../bindings/gpio/arm,scmi-gpio.yaml          | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> > new file mode 100644
> > index 000000000000..2601c5594567
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/arm,scmi-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SCMI pinctrl based generic GPIO controller
> > +
> > +maintainers:
> > +  - AKASHI Takahiro <akashi.takahiro@linaro.org>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^scmi_gpio(@[0-9a-f]+)$"
> 
> Not the correct name.

How not?

> > +
> > +  compatible:
> > +    const: arm,scmi-gpio-generic
> 
> What makes it generic? No such thing. Just drop '-generic'.

I will discuss this issue in following Cristian's comment.

> 
> > +
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio-ranges: true
> > +
> > +  gpio-ranges-group-names: true
> > +
> > +patternProperties:
> > +  "^.+-hog(-[0-9]+)?$":
> > +    type: object
> > +    properties:
> > +      gpio-hog: true
> > +      gpios: true
> > +      input: true
> > +      output-high: true
> > +      output-low: true
> > +      line-name: true
> > +
> > +    required:
> > +      - gpio-hog
> > +      - gpios
> 
> You don't need all this just 'required: [ gpio-hog ]'. Then the hog 
> schema will check the rest.

Okay.

> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +  - gpio-ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    scmi_gpio_0: scmi_gpio@0 {
> 
> gpio {
> 
> But doesn't SCMI have protocol numbers?
> 
> > +        compatible = "arm,scmi-gpio";
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
> > +                      <&scmi_pinctrl 5 0 0>;
> > +        gpio-ranges-group-names = "",
> > +                                  "pinmux_gpio";
> > +    };
> > +
> > +    // Consumer:
> 
> Outside the scope of this binding. Drop this node.

Even though it's in an example?
"#gpio-cells" has a meaning in consumer side.

-Takahiro Akashi


> > +    sdhci0_pwrseq {
> > +        compatible = "mmc-pwrseq-emmc";
> > +        reset-gpios = <&scmi_gpio_0 0 GPIO_ACTIVE_LOW>;
> > +    };
> > -- 
> > 2.34.1
> > 
