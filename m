Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECF7D2C52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJWINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjJWIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:12:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3281170F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:12:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so2751864276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698048754; x=1698653554; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOXl3zXklTx9wCua1qCqiebuh4VwsRY3XD6ewu+wjFQ=;
        b=ZioSy2MFMKiDfxY4LAACQLtfERaN46XQrEIqIk7alIHhPrxg4u1+Ru9+hYcN4jK9sm
         sQigmk7m2poHDqdANTEn4tnzHWnbaTW1x6t5tfEmE+mV4mmYcMGXlDY0sUO5ATMPrLno
         Ka5KXtwQqVwwHqUKGVFPjFBmTzoQFQOMsHl6J2eFx3mjLLiksXRfTiownLf6PaHlP5L8
         lORk6QpC+nqwQ7y3TCGM6wI9ZqicRhuwAtc+dLo6L0IU1ewXf43Wtj2vUtPlBcEQhF7r
         cki34jucVJPr1K0DPTI2tlgR27yZYMznirQsypeQr1TpHbnu/GHOjgqbdVI1UKDikgHr
         xG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048754; x=1698653554;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOXl3zXklTx9wCua1qCqiebuh4VwsRY3XD6ewu+wjFQ=;
        b=mScFZl1/VtIZvjNdy5jQxcqM6iXt6++rthHo/2fuzfdvWhe0RVUqXwLCB0O9jwb66q
         tHKhIUnALwwOruKsJn/EVmS3Scb8mAYC35y+Wz1z0qq4og1w1mzdit4/wltBfLHWmBft
         EkBGaTJEYa1jq5UroGxo0mzzOisRxpqyjKsDv/ttLdErqsfSfCZYHDzxPdhavuJmE1WT
         jjnvrfvqs3KxAj2mFAVsX92GS96A6ZnkNEep8VMkyx7uiLtjkNRNhXyHDBMBU3paH1UO
         fZhYdpKHSFKQD9qaGOvgnKA97Mwcr3zGMaoHFwrrbOwn1nI8mOht1JNj5HzjcHUKiuBU
         iGbw==
X-Gm-Message-State: AOJu0YwT2+mnWQQ/Jpi5Z2mMppeytyVn+hkzp4apFsbA1mXZcq0LlbsK
        P9+9P5HZkQWcoPLvt/2cNFxCvxRDTuutH2+ldbixLQ==
X-Google-Smtp-Source: AGHT+IFXX0nvmPQFS5PyZqKJz1HMNh/MzcEwcEmsEUeQld3hNYTdxItm6I8zeBAdbTNsZXsNtjg2DeR9/VfiwNASl7c=
X-Received: by 2002:a25:455:0:b0:d7b:9211:51a5 with SMTP id
 82-20020a250455000000b00d7b921151a5mr7215623ybe.44.1698048753902; Mon, 23 Oct
 2023 01:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org> <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus> <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus>
In-Reply-To: <ZS3yK/f12Mxw9rXe@octopus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Oct 2023 10:12:21 +0200
Message-ID: <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

sorry for slow response :(

On Tue, Oct 17, 2023 at 4:32=E2=80=AFAM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:

> > > > We can probably mandate that this has to be inside a pin controller
> > > > since it is a first.
> > >
> > > Yeah, my U-Boot implementation tentatively supports both (inside and
> > > outside pin controller). But it is not a user's choice, but we should
> > > decide which way to go.
> >
> > OK I have decided we are going to put it inside the pin control node,
> > as a subnode. (I don't expect anyone to object.)
>
> While I'm still thinking of how I can modify my current implementation
> to fit into 'inside' syntax, there are a couple of concerns:
>
> 1) invoke gpiochip_add_data() at probe function
> Probably we no longer need "compatible" property,

The DT binding people made it clear to me that they really
like compatibles for this kind of stuff so we should probably
keep it.

> but instead we need to
> call gpiochip_add_data() explicitly in SCMI pin controller's probe
> as follows:
>
> scmi_pinctrl_probe()
>     ...
>     devm_pinctrl_register_and_init(dev, ..., pctrldev);
>     pinctrl_enable(pctrldev);
>
>     device_for_each_child_node(dev, fwnode)
>         if (fwnode contains "gpio-controller") {
>             /* what pin_control_gpio_probe() does */
>             gc->get_direction =3D ...;
>             ...
>             devm_gpiochip_data_add(dev, gc, ...);
>         }

I think it is better of the pin controller just parse and add any
subdevices (GPIO or other) using of_platform_default_populate()
(just grep for this function and you will see how many device
drivers use that).

What is good with this approach is that if you place this call
last in the probe() we know the GPIO driver has all resources
it needs when it probes so it won't defer.

> 2) gpio-by-pinctrl.c
> While this file is SCMI-independent now, due to a change at (1),
> it would be better to move the whole content inside SCMI pin controller
> driver (because there is no other user for now).

That works, too. I have no strong opinion on this subject.

> 3) Then, pin-control-gpio.yaml may also be put into SCMI binding
> (i.e. firmware/arm,scmi.yaml). Can we leave the gpio binding outside?

There is no clear pattern whether to put subdevice bindings into
the parent device binding or not. Maybe? A lot of MFD devices does
this for sure.

> 4) phandle in "gpio-ranges" property
> (As you mentioned)
> The first element in a tuple of "gpio-ranges" is a phandle to a pin
> controller node. Now that the gpio node is a sub node of pin controller,
> the phandle is trivial. But there is no easier way to represent it
> than using an explicit label:
> (My U-Boot implementation does this.)
>
> scmi {
>     ...
>     scmi_pinctrl: protocol@19 {
>         ...
>         gpio {
>             gpio-controller;
>             ...
>             gpio-ranges =3D <&scmi_pinctrl ... >;
>         }
>     }
> }
>
> I tried:
>     gpio-ranges =3D <0 ...>; // dtc passed, but '0' might be illegal by s=
pec.
>     gpio-ranges =3D <(-1) ...>; // dtc passed, but ...
>     gpio-ranges =3D <&{..} ...>; // dtc error because it's not a full pat=
h.
>
> Do you have any other idea? Otherwise, I will modify my RFC
> with the changes above.

If you have the GPIO node inside the pin controller node
and have all the details of the existing ranges available, there
is no need to put that into the device tree at all, just omit it?

Instead just call gpiochip_add_pin_range() directly in Linux
after adding the pin controller and gpio_chip.
C.f. drivers/pinctrl/pinctrl-sx150x.c for an example of a driver
doing this. In this case the SX150X is hot-plugged (on a slow
bus) so it needs to figure out all ranges at runtime anyway.

Yours,
Linus Walleij
