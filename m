Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D478AB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjH1K1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjH1K1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:27:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C8125;
        Mon, 28 Aug 2023 03:27:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso44166021fa.0;
        Mon, 28 Aug 2023 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693218420; x=1693823220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOacA8ojmJi7uydWsnw+vyq5eodj37noaLcY/uneysk=;
        b=jlBsnOB6z4KU50q4rbP0U8Xgd9MChxqe63qS2usMkMX5pgr7oaxFCeNxLuFSo2Av8k
         PCySUWpQ937RovneZq+SX1nMrMVatMzTLxiIYnLmJpCodgmVGhjsqkH357J0G35KJ5jP
         GXboBpyrUqqhYvYl3tPdSsr5V3CkFLA3dfDMZTO8bpURSqPv0rNtCie9Dr2fSPyWRnoE
         jNItO1llflucm0hAjxBnhzPox7A4B1rw6fJeiwu6aQZTg6mrxotAnkUE8ULhDNFhcK0U
         /ONtY6G2VU09s8hzDoJNVNa9CCkKQfIV9dRLsR/1UGzmiLoEIohme9D4XH68n4OcJqbx
         g+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218420; x=1693823220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOacA8ojmJi7uydWsnw+vyq5eodj37noaLcY/uneysk=;
        b=jJMIMg/Am6b9CzBwM2wWCga10srje49mGKk3/W8SvgJtTA8VfvZJotG6J3GmT5KYUK
         REqqo0zGB69AglcwZbFhPUY6hVzYKUaTxKZiuzV0tNPXBfNJ2rJXGHh6iUBdB68OxoPk
         +Z5Zc5Q26bsmTA0C88btOFHjlth6lXWMPKVfC6TFPg3U1u+wzQcLCH6PH7P39CuoGJLM
         tzZZWzEjKxhFLT7LFoC+M6j6bj+16ZtB5TD9esK9igPT0ATOAsM097YXUlWGNPhtLBSn
         7WjDzCuck5+mmqLbVuEQpTtRb/6pp4GLA9OT9Cf106aVAW74nUETS3JCf8fFsCAyfqg9
         pD4g==
X-Gm-Message-State: AOJu0YxuqLIyQZ9XsvaYt4FAMILRLk28jCzQW/tWYBCGLC5eqH64JJX3
        gqAE+MfV3TMKpwaPU0dtSp2JqoBOFIYAL0W+3kU=
X-Google-Smtp-Source: AGHT+IEDrPgEGY0GfDpk0pi8fMwuKJQ0qRtUXLd2M5JPp+MzHCQHn6IogguYmjIzPCiFOBH7gY1VEIc+bFzB4alMpBQ=
X-Received: by 2002:a2e:9210:0:b0:2b7:7c:d5a1 with SMTP id k16-20020a2e9210000000b002b7007cd5a1mr18047149ljg.23.1693218419966;
 Mon, 28 Aug 2023 03:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230827203612.173562-1-tmaimon77@gmail.com> <20230827203612.173562-2-tmaimon77@gmail.com>
 <eccc6a7a-b30f-8c77-77cb-5deef47a1954@linaro.org>
In-Reply-To: <eccc6a7a-b30f-8c77-77cb-5deef47a1954@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 28 Aug 2023 13:26:48 +0300
Message-ID: <CAP6Zq1jj0WDbtL1zhr=tVyh2GPRy6-=oHjVURmJzNRm3n0HBNg@mail.gmail.com>
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

Thanks for your comments

On Mon, 28 Aug 2023 at 10:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/08/2023 22:36, Tomer Maimon wrote:
> > Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> > pinmux and GPIO controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
>
>
> > +  '^pin':
> > +    $ref: pincfg-node.yaml#
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          A list of pins to configure in certain ways, such as enabling
> > +          debouncing
>
> What pin names are allowed?
Do you mean to describe all the allowed pin items?
for example:
      items:
        pattern:
'GPIO0/IOX1_DI/SMB6C_SDA/SMB18_SDA|GPIO1/IOX1_LD/SMB6C_SCL/SMB18_SCL'
or
      items:
        pattern: '^GPIO([0-9]|[0-9][0-9]|[1-2][0-4][0-9]|25[0-6])$'

is good enough?
>
> > +
> > +      bias-disable: true
> > +
> > +      bias-pull-up: true
> > +
> > +      bias-pull-down: true
> > +
> > +      input-enable: true
> > +
> > +      output-low: true
> > +
> > +      output-high: true
> > +
> > +      drive-push-pull: true
> > +
> > +      drive-open-drain: true
> > +
> > +      input-debounce:
> > +        description:
> > +          Debouncing periods in microseconds, one period per interrupt
> > +          bank found in the controller
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 1
> > +        maxItems: 4
> > +
> > +      slew-rate:
> > +        description: |
> > +          0: Low rate
> > +          1: High rate
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1]
> > +
> > +      drive-strength:
> > +        enum: [ 0, 1, 2, 4, 8, 12 ]
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: pinctrl.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - ranges
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - nuvoton,sysgcr
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pinctrl: pinctrl@f0800260 {
>
> Nothing improved here. Test your DTS. This is being reported - I checked.
what do you suggest since the pinctrl doesn't have a reg parameter,
maybe pinctrl: pinctrl@0?
BTW, I have run both dt_binding_check and W=1 dtbs_check, and didn't
see an issue related to the pinctrl: pinctrl@f0800260, do I need to
add another flag to see the issue?
>
> > +        compatible = "nuvoton,npcm845-pinctrl";
> > +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        nuvoton,sysgcr = <&gcr>;
> > +
> > +        gpio0: gpio@0 {
> > +          gpio-controller;
> > +          #gpio-cells = <2>;
> > +          reg = <0x0 0xB0>;
>
> Keep lowercase hex.
will be done in V7
>
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer
