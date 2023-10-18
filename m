Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E7D7CDAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjJRLlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjJRLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:41:49 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1890211A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:41:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7b91faf40so81540267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697629306; x=1698234106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wt7hBmTjyhHKxT1iU8w6hvI4yVCQQDXaEm9aRSBcGw=;
        b=e5WzcXpU2fytb9XN+joCyQquPfEHbbmxmTZYnsphwz4tGBfw/uY1+dZa1pLJeAsaWQ
         zBaSGvkkSZiYlF4+gzArH/Eyr4RxfNjIy9VhRXPGrJ6LF5LFc2ePfEth/pywQDlaKC4t
         kLITA9ddJneRhayKWYbgKk5azhhkXA6HNgkWtsFSWZyUkCrUQq0ljXSC/eP/pXTjvsJ0
         S5qFZrGNS0ValRPoh869NYvQZEYj9IbABWnX9J9+KpJDvfO0SCiyva/Hqlqcr2kb9yN2
         Hwjwv3yF+XTNXDh8C6OnBTFduXVgnwWy+TLmQi8qCqJX3op6y6uWx/42zz9qDX9K5YC3
         ebMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629306; x=1698234106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wt7hBmTjyhHKxT1iU8w6hvI4yVCQQDXaEm9aRSBcGw=;
        b=RNlbhX2VHhenyZKaFNwyAAiu2FAAtKLjtV+EkmIPO4AB2qGawC35M/rLyvQHGDZeI5
         ibgKQ+dtM41vad1qicDdJ6l8a7C3EOBiO5FSs00bezvS/vJLtW8HYC9Gry9xP3ZRAkzR
         T+uqEbu6ODx5o2vM1rDy1wSmlrzjNaayr5Spen7TnFuKo9IhkjrD98Csr1OK/eWi1Yup
         QNxuv9sn8uE5hcV0an9cooz/SDVT0YkBESiciagcadzW58dxBnn1I7tyYFqbxkKIYdaG
         VJE/IDlyKB4s5lvKBNujyAZRQXGsAZNkXvsnGrseKXy/LU+G6+64zXGAiLc2NMMFy7oS
         /VUw==
X-Gm-Message-State: AOJu0Yz8Uxrrn0bOiJ2pvw2WmLnFR6F6azg7w4fyNaFrB1gw0xodFMSx
        zXY7v7uADv6rpfpMMWsBvEok5rtZa7vhVgjG4YZTPK0fyKAAb2EW
X-Google-Smtp-Source: AGHT+IH6Ar5ABgryO9a/1CG5P1p4amLNNPBAwWHOK/HFmzy/cNuiZKpFEYqQoBzaYhl7Y/eFSIxDdQy3k/YTcrkku00=
X-Received: by 2002:a81:92c8:0:b0:59f:6675:7771 with SMTP id
 j191-20020a8192c8000000b0059f66757771mr4389883ywg.35.1697629306289; Wed, 18
 Oct 2023 04:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-3-ychuang570808@gmail.com> <7800b2d6-33c4-4c4f-8d0c-c11ff0e47535@linaro.org>
 <17a80031-98bf-48bf-8cea-c0ca4400f142@gmail.com> <254837e5-a0fa-4796-8928-277db4b98bf1@linaro.org>
 <CACRpkdaiihOex19SavWwC+S8o5qp=F=XMNm9+UXh=q2nVbOFkA@mail.gmail.com> <4ca28f03-eb05-4cd7-ace5-8cbc0d108b6c@linaro.org>
In-Reply-To: <4ca28f03-eb05-4cd7-ace5-8cbc0d108b6c@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 13:41:34 +0200
Message-ID: <CACRpkdbXm5f7aCnnQ58=XN6PohviPzab0LRw4f6Jq=JZXiVCqA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
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

On Wed, Oct 18, 2023 at 11:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 18/10/2023 10:18, Linus Walleij wrote:
> > On Mon, Oct 16, 2023 at 9:52=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >
> >>> I noticed that 'xlnx,zynq-pinctrl.yaml' and 'xlnx,zynq-pinctrl.yaml' =
use
> >>> 'power source' to specify the output voltage.  Should I follow their
> >>> approach or define a vendor-specific one?
> >>
> >> Maybe Rob or Linus have here some recommendation, but I would suggest =
to
> >> go either with rtd1319d-pinctrl.yaml approach or add a generic propert=
y
> >> to pincfg-node expressed in real units like "io-microvolt".
> >>
> >> Rob, Linus, any ideas for generic property replacing register-specific
> >> power-source?
> >
> > The existing power-source is generally used to select between (usually
> > two) different chip-internal power rails, such as 1.8V and 3.3V.
> > The format is a driver-specific enumerator.
> >
> > We *could* just patch the documentation for power-source to
> > say that microvolts is the preferred format but legacy users may
> > be using a custom enumerator.
> >
> > io-microvolt seems like a more long-term viable option if a wider
> > range of voltages are to be supported so I'm happy with that if the
> > DT folks think it's nicer. However notice that the power-source
> > property is already being hard-coded into things such as SCMI
> > and ACPI so it's not like it will ever be replaced by io-microvolt
> > and phased out as far as Linux is concerned. Not the next 50
> > years at least.
>
> This I understand.
>
> I think It is better in general if generic properties use units (e.g.
> drive-strength-microamp, output-impedance-ohms), so it could be here
> "io-microvolt". At least for the new bindings.

I agree. Even io-voltage-microvolt perhaps.

Yours,
Linus Walleij
