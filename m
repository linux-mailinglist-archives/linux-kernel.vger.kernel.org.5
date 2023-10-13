Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A37C865B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjJMNEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjJMNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:04:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EEFE0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:04:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a2536adaf3so27691907b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697202261; x=1697807061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTDB06WuV7DXLenpqB3BP0igc3WK0O/XPFiYBVmb3IU=;
        b=JCy9AsMhCsEJpZNLPuzbxfnYI5o/ucSnolkreMMh8kvmLAYgwppmTzYB8GmjDfSAj0
         2RssITkwLF3FShl5r7I0drYyO++Ea/+CmWaCD8hm/CzQmLqIUJdfKoX0rcivhPs/d+7m
         OWrhdZ5vfCDS99xOUscuzWm8MIlSuc36mdlpTZxeZsWB630kyvHu3T+HSu/cjVos0EYG
         qlQnKnvZp0aYud9mXQKivhC1EQd0On6KDEsxeifr/vy5zXrKBzC3P5rIXteujSHN/8FM
         /JdOdn+A/6j+5rPYWA22KxJ1AqhV858YslVI5S2Hora6ubk+34RFeqwT7A+bbLAFRe33
         xh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697202261; x=1697807061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTDB06WuV7DXLenpqB3BP0igc3WK0O/XPFiYBVmb3IU=;
        b=MQHYtXaSH0TU4epGTmRp5WaLWlkWgKaPiKx0Upv+nQ9l3eNAGMJ93UxPfVnEGcH3aq
         V1B7Tkk6LaUCUvqaVOIV0cFdX+okNadwi9e2QhYciQn4VkrsrYnV9xfi71AACEdwO4sO
         DXX2R1K+qiXMk3AXB5VElf10uzPiW2WNa3PhUgO+zaoQbEEbGCw2+VycB17889WJPc9z
         GLEjRwRZVLh9CXxKmgOn+3YbwTLkxXMLWKC5CnV70GVeo57q4Rc7bSKFvOj8PdbOlIAl
         14Lxm2dn8lCsOOW2X/GjAP1QXyNoCONUnXSh4UdhkXGWZ6kf1iviJFivYpLl4lrMWTxp
         hQeA==
X-Gm-Message-State: AOJu0YzcnvGxozMeaV7+EBq1f8cBQUVJIhLvYfu1bH/pPmmNcET+tUWT
        B8SqI4KWHQUbJ6I+o7BlQiIuGnFZbBxxgsGDCr7i2A==
X-Google-Smtp-Source: AGHT+IH8FM/iWk8oBbKZNdvfP7rzi0aGHHvSU3/uiwbyENQSYy2btpQIq4hLmrd+2uOljN+UDzs8nEi0TOWfys/whVM=
X-Received: by 2002:a0d:d183:0:b0:59b:5170:a0f3 with SMTP id
 t125-20020a0dd183000000b0059b5170a0f3mr30546187ywd.36.1697202261559; Fri, 13
 Oct 2023 06:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org> <d971d7c1-c6b5-44a4-81cf-4f634e760e87@lunn.ch>
In-Reply-To: <d971d7c1-c6b5-44a4-81cf-4f634e760e87@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Oct 2023 15:04:10 +0200
Message-ID: <CACRpkdYocdsrsydHwe_FF--6g-Y_YwxHXF6GUTe3wRY0suSCCg@mail.gmail.com>
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thanks for reviewing!

On Fri, Oct 13, 2023 at 2:43=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - marvell,mv88e6060
>
> The 6060 is a separate driver. Its not part of mv88e6xxx. So it should
> have a binding document of its own.

It really doesn't matter to the DT bindings.
It is not the job of DT to reflect the state of Linux.

In another operating system they might all be the same driver.
Or all four variants have their own driver.

If the hardware is distinctly different so a lot of the properties
are unique then it may be warranted with a separate DT
binding, for the sake of keeping bindings simpler and
coherent.

> > +  '#interrupt-cells':
> > +    description: The internal interrupt controller only supports trigg=
ering
> > +      on IRQ_TYPE_LEVEL_HIGH
> > +      # FIXME: what is this? this should be one cell should it not?
> > +      # the Linux mv88e6xxx driver does not implement .irq_set_type in=
 its irq_chip
> > +      # so at least in that implementation the type is flat out ignore=
d.
> > +    const: 2
>
> This interrupt controller is for the embedded PHYs. Its is hard wired
> active high.

Hmm.... I need feedback from the DT people here. It does have a
polarity, but the polarity cannot be changed. So shall we encode this
always the same polarity in the flags cell or skip it altogether?

I'm uncertain. The currens scheme does reflect a reality.

> > +  mdio1:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description: Older version of mdio-external
> > +    deprecated: true
> > +    properties:
> > +      compatible:
> > +        const: marvell,mv88e6xxx-mdio-external
>
> The driver only looks at the compatible. It does not care what the
> node is called. So you are going to need to change the driver if you
> want this in the schema.

Yeah, thats what patch 3/3 does :D

Yours,
Linus Walleij
