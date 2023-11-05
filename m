Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76507E174D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKEWPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:15:46 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2464FDD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:15:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579de633419so46225047b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699222540; x=1699827340; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrqCjnNBchrd9FLn5hEJeuZodiLvnKhusQVXvM/Nn54=;
        b=E0Szbm7N7Iegktaa14GlXFTvfjQubA4PmaE8hKJny12mcr4+Fbd3rqnxL4cPnlfffA
         WlAEowmBmAn6CztIn4QRiluhtM4CtIdzckwZqGj796ATzK0BQ6wzUILS+vU31FNt5waE
         xRjhq8fxO6Fasgvv8Gv+9wrssDiT9YeQ1NOhqcbL6y2HFgp5La/TdlioGQcDHcdxq6/t
         yClNkjk2SF43q3a5Sx6uLHgmJRB7x0b24Q5k1qFbt2kdm8HTYOGeLNsDdXMI9YsaDGr6
         7rknbOyeMbjl3b3La9uJgg3nGk0F/Mv1p8uTomLKOzgzl3ZS45YyVKsGMZp+u4TFuMte
         4KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699222540; x=1699827340;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrqCjnNBchrd9FLn5hEJeuZodiLvnKhusQVXvM/Nn54=;
        b=Gr9aVkEyMMt0EYMfRhLJP9nsF3lxCq1DhgJbjw/pfcWcBKHvcsnD+h+N/dk0Dkl+d+
         yhHv9QDrCMiKhMKfaT9QkgP7tqhzeqEWWzaA2ltF+KNlKXYjrRR7PjPHPZZmbM/aWPIN
         tB+wnbFcRSqFIHImxUhCk4s+PA05P+k1zyajm7ptcPDVUunJg/MZ+JSk2pyyj+BrZl6y
         2vESS3emyWeFxoDcOFFDTCXyFMRRgAypxnf9oyxTG2iKYvfatdcSNfbOTi7gFQUwN6Zd
         p/A6c9/8JWAwM6ikijztZNDiPoCKAPk0pTkGMxDdI01QIyCwzcQ6Aq70aDtdRxDQEXaR
         ot9w==
X-Gm-Message-State: AOJu0YxpZ+u0fb4+U1d/41vjz/HLAQK26wPb6wRs63WElp5bIAjnNNF4
        UbkmQT/HTRGgUlCPlaRjhbv0QwMbm1SyOs2bHhWU+g==
X-Google-Smtp-Source: AGHT+IH4yXKr5aMVYMhvGN4m10IZVbD2G5FmoNaU4DuDBb1msb3GO0RY10mUZGCROsJWs0eOoN711XTj7uTN22WCTwU=
X-Received: by 2002:a0d:df4a:0:b0:5a8:1654:4b6f with SMTP id
 i71-20020a0ddf4a000000b005a816544b6fmr9302434ywe.17.1699222540310; Sun, 05
 Nov 2023 14:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20231006132346.GA3426353-robh@kernel.org> <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus> <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus> <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus> <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
 <ZTemAK/jBtv9b5xP@octopus> <CACRpkdY-5uS9EeXfDFVOiRKiFmwwSn3jRVGhT-n4JMqesHEumw@mail.gmail.com>
 <ZTfJ4b7VdTkA0sxo@octopus>
In-Reply-To: <ZTfJ4b7VdTkA0sxo@octopus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Nov 2023 23:15:29 +0100
Message-ID: <CACRpkdY5R+Jg6c8dOopyyMMur0Vq76u2fgTVgdn-RB2NhHcWZw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takahiro,

On Tue, Oct 24, 2023 at 3:43=E2=80=AFPM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:

> First of all, there is no pre-defined naming convention either for
> pins, groups or functions. SCMI firmware can give them any names.

OK maybe that should be added to the spec?

[NB: I poked the pinctrl implementers in a separate mail, you
are on CC.]

Otherwise I think this is one of those cases where firmware
authors will simply start to use a certain naming convention if
the Linux driver requires it.

> Secondly, What you said in the above is already implemented in
> my RFC patch. Please remember the example that I gave:
>
> >     gpio-ranges =3D <&scmi_pinctrl 6 0 0>;
> >     gpio-ranges-group-names =3D "pinmux_gpio";
> >
> > means that SCMI *group*, "pinmux_gpio", are mapped to this driver's
> > gpio range which starts with 5. If "pinmux_gpio" indicates SCMI *pin*
> > range [20..24],
> >
> >     baa-gpios =3D <&gpio0 7>;
> > will refer to gpio pin#7 that is actually SCMI's 22 (=3D20 + (7-5)).

Right! I am so unused to the gpio-ranges-group-names that
I didn't parse that properly :(

> After all, I still believe we need "gpio-ranges" property in most of
> all use cases (The only exception is, as I mentioned, to unconditionally
> map all pinctrl's pins to GPIO (if possible) when SCMI firmware provides
> only GPIO function for all pins. I think it is a simple and yet likely
> use case.

I suppose it is a bit of placement question.

The device tree GPIO ranges will have to duplicate more information
that the SCMI firmware already knows (what ranges are GPIOs, the
name of the GPIO mux function), that is my main concern.
And when we have information in two places that need to be matched,
invariably we get mismatches.

I'm trying to figure out what is the best way forward here but I think
we need some feedback from the pinctrl driver authors.

Yours,
Linus Walleij
