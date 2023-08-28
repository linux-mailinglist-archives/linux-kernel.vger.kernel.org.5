Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A078AF38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjH1LoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjH1Lnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:43:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B2124;
        Mon, 28 Aug 2023 04:43:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso46484631fa.1;
        Mon, 28 Aug 2023 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693223021; x=1693827821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWMkAnkHARKLrLjYo9K/Jkbh5vwqG4k4wgjjUmMU++Q=;
        b=Y/QXfuGKbQURsu2bBEZ7L18vFnui7V4NALcTfSZrJPtVzP54KWpHaTG2yejj0aitCx
         kSw/9xYbmHog+NTVIadcV/cZmCfVFThJuf4sLp9GM4Ky2osHhV7pNkk68yFLKrS8vraq
         4k4SAevob7WPTvLOZllSrnpH9lM3/gkgEDaS2SLGXquGPloNBj+yRNQuTD7P+GY/SyHe
         QcbNXcnSwWFs9FE+oDMLiWap8dn+hT2tnKt6A0KHx7LCLgLVOn7X8Sp2A9SIT3bSQSli
         IsbjSznCFR6baMKzEaDunlMutdnpouhp42KtAhUIwgiv2Q2Jm4Ivf/lYsXhqlTFm08Vr
         tX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693223021; x=1693827821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWMkAnkHARKLrLjYo9K/Jkbh5vwqG4k4wgjjUmMU++Q=;
        b=fFrFP9hmT2t+7eP5TBYvwTYcezD1l54cg7FL6dUVtubaDVahRAWSK4sYw8Qp8eY1rD
         nsEndo7Gph8h0lI8TXov2DPkbA18vIhQH32uZHjMGQtBaSlIyrlrzhtlY0+lA0aj0Jpj
         FwG0C5i181R7Twqhr6yQL+cHXLfiIlREe/XSgjlRkOKLTPU9ugsRgNBlHaerJS3Uwob5
         GXMmiU8GGsYrbDaRhTMkTP69mcjlp+Kh/zFoltO3fTA2satOnVUA8FyKiyBxWSihcyXl
         QjA1DyeAFx9No8CAfXJA3TK344oPgn17nHGq+gw/0ZxoAIEZqGsV3eupQaLNnkSId2NQ
         xNrA==
X-Gm-Message-State: AOJu0YxAmWQKFaR7QW5ktvQ5p6XUXpHYf/aVwN4ICdCfCpA0jhht4w+7
        AGgEnPAWSr4vDvjB8VrygVmYAi4D6LU68h4Kz0M=
X-Google-Smtp-Source: AGHT+IE7+CAh/eklu6NimyMouFYr6FZluNvPOerDm87ZpPYcTVn0J+ppxwEiPDLA2cln0598N1XEnU/Cl9yQBHR05fw=
X-Received: by 2002:a05:651c:10b5:b0:2bd:d34:d98a with SMTP id
 k21-20020a05651c10b500b002bd0d34d98amr1901847ljn.44.1693223020896; Mon, 28
 Aug 2023 04:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230827203612.173562-1-tmaimon77@gmail.com> <20230827203612.173562-2-tmaimon77@gmail.com>
 <eccc6a7a-b30f-8c77-77cb-5deef47a1954@linaro.org> <CAP6Zq1jj0WDbtL1zhr=tVyh2GPRy6-=oHjVURmJzNRm3n0HBNg@mail.gmail.com>
 <c984d558-11b5-d5ea-9819-7641129de584@linaro.org> <5c0d985a-0492-778c-46b9-80899e52134c@linaro.org>
In-Reply-To: <5c0d985a-0492-778c-46b9-80899e52134c@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 28 Aug 2023 14:43:29 +0300
Message-ID: <CAP6Zq1iX4Rqob0SM-F2SuRYa3QxE4KC8wPzTNQVpTN8JBUPFkA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your clarifications

On Mon, 28 Aug 2023 at 13:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/08/2023 12:36, Krzysztof Kozlowski wrote:
> > On 28/08/2023 12:26, Tomer Maimon wrote:
> >> Hi Krzysztof,
> >>
> >> Thanks for your comments
> >>
> >> On Mon, 28 Aug 2023 at 10:10, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 27/08/2023 22:36, Tomer Maimon wrote:
> >>>> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> >>>> pinmux and GPIO controller.
> >>>>
> >>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>> ---
> >>>
> >>>
> >>>> +  '^pin':
> >>>> +    $ref: pincfg-node.yaml#
> >>>> +
> >>>> +    properties:
> >>>> +      pins:
> >>>> +        description:
> >>>> +          A list of pins to configure in certain ways, such as enabling
> >>>> +          debouncing
> >>>
> >>> What pin names are allowed?
> >> Do you mean to describe all the allowed pin items?
> >> for example:
> >>       items:
> >>         pattern:
> >> 'GPIO0/IOX1_DI/SMB6C_SDA/SMB18_SDA|GPIO1/IOX1_LD/SMB6C_SCL/SMB18_SCL'
> >> or
> >>       items:
> >>         pattern: '^GPIO([0-9]|[0-9][0-9]|[1-2][0-4][0-9]|25[0-6])$'
> >>
> >> is good enough?
> >
> > Something like this. Whichever is correct.
> >
> >>>
> >>>> +
> >>>> +      bias-disable: true
> >>>> +
> >
> >>>> +additionalProperties: false
> >>>> +
> >>>> +examples:
> >>>> +  - |
> >>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>> +    #include <dt-bindings/gpio/gpio.h>
> >>>> +
> >>>> +    soc {
> >>>> +      #address-cells = <2>;
> >>>> +      #size-cells = <2>;
> >>>> +
> >>>> +      pinctrl: pinctrl@f0800260 {
> >>>
> >>> Nothing improved here. Test your DTS. This is being reported - I checked.
> >> what do you suggest since the pinctrl doesn't have a reg parameter,
> >> maybe pinctrl: pinctrl@0?
> >
> > It has ranges, so yes @0 looks correct here.
>
> Wait, your address according to ranges is 0xf0010000, not 0x0, not
> 0xf0800260...
I will modify it to pinctrl: pinctrl@f0010000
>
>
> > Which leds to second
> > question - how pinctrl could have @0? It's already taken by SoC! So your
> > DTS here - unit address and ranges - are clearly wrong.
> >
> >
> >> BTW, I have run both dt_binding_check and W=1 dtbs_check, and didn't
> >> see an issue related to the pinctrl: pinctrl@f0800260, do I need to
> >> add another flag to see the issue?
> >
> > Did you read my message last time? I said - it's about DTS, not the binding.
yes, understood doesn't the dtbs_check check the DTS?
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer
