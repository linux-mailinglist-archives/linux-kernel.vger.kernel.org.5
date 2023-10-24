Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E277D4CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjJXJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjJXJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:41:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5D10DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:40:13 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7c7262d5eso44021127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698140412; x=1698745212; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrczhLGD57ThZZUAC+aPmJYkJuVGn0gGizSYS9IZ/6k=;
        b=v01xorbj2vmZyjz9Rj3CPHBIV7wt17LnkRj58c/9qqkOTe50XFHd8P4ADFnUKxerpe
         RFmDuMFq4jBB7hxX14M/Q+/55PUVGnuzOUX4ev9I8YauKRjT5ROYX3COc901GAOPV3/0
         2M0/zlmH1AAIrPKja7YymH7a9Ldxfvc/k9P3Jy106hSgsBKwV0XBdVQI0nQTrzoHjyyq
         2bl09BqWn1REMeIRamilUfr2RlfDVXNU4oG2Z1HXmJsSofgXOvepzNdfMVmykCwbA3Q1
         eTR3h84GDKk9V4U4HlB46ufjMhodhzwMtex85Bpqc4YPM99wn+656+hPPl4gVpsQpbP1
         EFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140412; x=1698745212;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrczhLGD57ThZZUAC+aPmJYkJuVGn0gGizSYS9IZ/6k=;
        b=Aei+RUG1zuvAlY5COUOhdXOjxqg3mryh61intflr5Ug4cn2aZSKa2UgrfXo5jz9CUO
         6nqGLTvqhDEAnkGyrw4iZ6zAETanTMzKbeQ5FoeXRkWJV7hT42EbO0FbxguAdiLMfdEn
         6zy5bcmU/hUydcmtjFribeVLuz1HlM+chC9j564LMl8VKagZKV4BPN2Wp9/SrJN2s25S
         4TyC32PUbDqLJB62xjeb4Jp31nOrdhtb2vKnjuRGDZyhHR6/lWnS79qVXAHMKfK7Yw0x
         VrSuY0WdNw81iWoLzbVbhBdSBBwMixdPis4tr+wpc6cCLhexHO0HOhJaNwfpHiN+HtBO
         X6Ig==
X-Gm-Message-State: AOJu0YywQqEfklTOKQAp9uj9CaC8mA1DdN+tUwvuWWfa9cWc8fdKqpNS
        yGPpTT49GjiB1oO1SlrUPOZffnvDHWwbbefVIae/6A==
X-Google-Smtp-Source: AGHT+IEBUnte3cbamxmESNlJIBXSuCRqI8PlmjdcCiUugmIDijJyrb7FLwNcmIUw9OQ4VyjnZgimIJ0DGWbebl3BoME=
X-Received: by 2002:a05:690c:f87:b0:59f:b0d9:5df2 with SMTP id
 df7-20020a05690c0f8700b0059fb0d95df2mr15122020ywb.0.1698140412349; Tue, 24
 Oct 2023 02:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org> <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus> <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus> <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus>
In-Reply-To: <ZTduWx7CH1ifI5Uc@octopus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 11:40:00 +0200
Message-ID: <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takahiro,

On Tue, Oct 24, 2023 at 9:12=E2=80=AFAM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:

> > I think it is better of the pin controller just parse and add any
> > subdevices (GPIO or other) using of_platform_default_populate()
> > (just grep for this function and you will see how many device
> > drivers use that).
>
> IICU, then, we will have to add a "compatible" to pinctrl node
> to make of_platform_default_populate() work as expected. That is:
>
> scmi {
>     ...
>     protocol@19 {
>         compatible =3D "simple-bus"; // <- added

Hm right, but you could also use
of_platform_populate(np, NULL, NULL, dev);

Then the compatible match is of no concern.

Sorry for my lack of attention to details :/

If you want to restrict the population to a few select compatibles
(maybe only "pin-control-gpio") then you can do
that with

const struct of_device_id of_scmi_protocol_19_match_table[] =3D {
        { .compatible =3D "pin-control-gpio", },
        {}
};
of_platform_populate(np, of_scmi_protocol_19_match_table, NULL, dev);

> Is this what you meant?
> In this case, however, "protocol@19" has a mixture of sub-nodes,
> most are pinconf definitions which are the properties of the pin
> controller, while "scmi_gpio" is a separate device.

That looks good to me, it makes sense to have the GPIO as a subnode
here and mandate it with a compatible to match.

> The code will work, but is it sane from DT binding pov?

Let's let the DT people jump in on that.

> > Instead just call gpiochip_add_pin_range() directly in Linux
> > after adding the pin controller and gpio_chip.
> > C.f. drivers/pinctrl/pinctrl-sx150x.c for an example of a driver
> > doing this. In this case the SX150X is hot-plugged (on a slow
> > bus) so it needs to figure out all ranges at runtime anyway.
>
> Are you suggesting implementing a custom function for parsing "gpio-range=
s"
> and calling it in pin_control_gpio_probe() instead of a generic helper?

The generic helper will always be attempted but if there are
no ranges in the device tree, it will just continue without adding
any ranges. I suggest putting *no* ranges into the device tree.

> Or do you want to always map all the pin controller's pins to
> gpio pins as sx150x does?

I think since the SCMI firmware knows about the available line
and pins etc, it makes sense that the driver comes up with the
applicable ranges on its own (derived from the information from
the SCMI firmware) and add them, instead of trying to put that
information into the device tree at all. Just omit it, and make your
own ranges, and add them in the Linux driver with
gpiochip_add_pin_range() without involving DT at all when defining
the ranges.

I'm sorry if I'm unclear sometimes.

Yours,
Linus Walleij
