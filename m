Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200A8135E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjLNQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjLNQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:12:40 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C610A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:12:43 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so104794991fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702570362; x=1703175162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgLd3wB0jQIWdxHpeHgoYJ7Y9WZfKwtfMLFflx+P7WA=;
        b=mNZxsiA/3meM1yhZjRfKJqxXba/j6o85TFggXM+yxsl+XTPnk8AQtRvI/ZH469O+c8
         hIjF5T6m4vUPV7uBwmiDgSl1o+iHbtv7JXc8vrx2grbObvacdRp1ACiT0yq82IMz0xLA
         SeDA7+U7AP4m38L6rXe8sB+ucUySKcI/PuZ76fBvk1JsJGF4JAzHco96EPRtyZEqWtN9
         6R8TFzeL2wTVbmdjwhTv1rfCNK3Ic7mIvCdmNeOmOpmi6C0vyGINWfIA+pfSFWorX/JU
         bJCfHRYvzIx2Ar1nYUWUhTt8c6+7BYwyFFPUpEbxp1u8Hc7wUSA0Xq47OfgycbukDZPs
         V9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570362; x=1703175162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgLd3wB0jQIWdxHpeHgoYJ7Y9WZfKwtfMLFflx+P7WA=;
        b=KNRG4ImlA1sa0VJvCNjAEt0A5BJtshl8/je2cBNzMF5gKQvxDHSxmdP0llT3StmRu8
         OG5BEHy4XhXksSR6Yap360HIinTqHWNwKkutzcfao7aFpifmDbpGj5WNGPBHIeHpladr
         AdBsC9P3/2lJ0YrXuf3MJLQKmUyBfFA019026ZAoxnlrsZohV4sBWn9By5OZCOXRddxe
         vv7aSCOF80sKc3hvKeXTBa1EwZf66QygtRr0kr8VZWMbDBc5Er1KZn3R+Be3zXFc1mXK
         6pxE8WUwU02GkQ9awngRmvG8dN06dxFdQiNhn+9c3Xlq4bfAJ4a04Mw8IR9lHmZshGP4
         Qm0g==
X-Gm-Message-State: AOJu0YzvXqi/UdxOC1WmEPYXsjCke+aSNISFvPjPCjbEh9zcWycubXkO
        QEDos54xCaMMWnzeFLGUiBNZvj8WWVv76hhMNq6JdQ==
X-Google-Smtp-Source: AGHT+IHQs312dUOBx5Ma7ewlNipNdaXg0ZHYPKPXysvpx5x/Rfo9iSSn2F9H0pVWT/hd9w+Jt4dBV+8rIwazDfs5/TE=
X-Received: by 2002:a05:651c:1a24:b0:2cb:28f3:244d with SMTP id
 by36-20020a05651c1a2400b002cb28f3244dmr3432134ljb.6.1702570361698; Thu, 14
 Dec 2023 08:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com> <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
In-Reply-To: <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 14 Dec 2023 17:12:30 +0100
Message-ID: <CAMknhBFQ56SwMvOni6UDqvaq8t0iydHcggiL0biUeLQ6OV1ONA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
To:     Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 1:43=E2=80=AFPM Ceclan Dumitru <mitrutzceclan@gmail=
.com> wrote:
>
>
>
> On 12/12/23 17:09, David Lechner wrote:
> > On Tue, Dec 12, 2023 at 11:45=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@=
gmail.com> wrote:
> >>
> >> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> >> which can be used in high precision, low noise single channel applicat=
ions
> >> or higher speed multiplexed applications. The Sigma-Delta ADC is inten=
ded
> >> primarily for measurement of signals close to DC but also delivers
> >> outstanding performance with input bandwidths out to ~10kHz.
> >
> > As stated in [1], we should try to make complete bindings. I think
> > more could be done here to make this more complete. Most notably, the
> > gpio-controller binding is missing. Also maybe something is needed to
> > describe how the SYNC/ERROR pin is wired up since it can be an input
> > or an output with different functions?
> >
>
> GPIO-controller:
>   '#gpio-cells':
>
>     const: 2
>
>
>   gpio-controller: true
> Like this, in properties?

Yes (with not so many blank lines).

>
> Sync can only be an output, Error is configurable. Are there any
> examples for how something like this is described?
>

Configurable pins sounds like a pinmux. Sounds a bit overkill to
specify everything for a pin-controller for one pin if no one is ever
going to use it. But I will leave it to the DT maintainers to say how
complete the bindings should be.

> ...
>
> >> +  interrupts:
> >> +    maxItems: 1
> >
> > Shouldn't this be 2? The datasheet says there is a "Data Output Ready"
> > signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
> > pin. Although I could see how RDY could be considered part of the SPI
> > bus. In any case, a description explaining what the interrupt is would
> > be useful.
> >
>
> I do not see how there could be 2 interrupts. DOUT/RDY is used as an
> interrupt when waiting for a conversion to finalize.
>
> Sync and Error are sepparate pins, Sync(if enabled) works only as an
> input that resets the modulator and the digital filter.

I only looked at the AD7172-2 datasheet and pin 15 is labeled
SYNC/ERROR. Maybe they are separate pins on other chips?

>
> Error can be configured as input, output or ERROR output (OR between all
> internal error sources).
>
> Would this be alright
>   interrupts:
>
>     description: Conversion completion interrupt.
>                  Pin is shared with SPI DOUT.
>     maxItems: 1

Since ERROR is an output, I would expect it to be an interrupt. The
RDY output, on the other hand, would be wired to a SPI controller with
the SPI_READY feature (I use the Linux flag name here because I'm not
aware of a corresponding devicetree flag). So I don't think the RDY
signal would be an interrupt.

>
> ...
>
> >> +
> >> +patternProperties:
> >> +  "^channel@[0-9a-f]$":
> >> +    type: object
> >> +    $ref: adc.yaml
> >> +    unevaluatedProperties: false
> >> +
> >> +    properties:
> >> +      reg:
> >> +        minimum: 0
> >> +        maximum: 15
> >> +
> >> +      diff-channels:
> >> +        items:
> >> +          minimum: 0
> >> +          maximum: 31
> >
> > Do we need to add overrides to limit the maximums for each compatible s=
tring?
> >
>
> Just to be sure, in the allOf section?
> If yes, is there any other more elegant method to obtain this behavior?

I'm not sure. I would like to know if there is a more elegant way as well. =
;-)

>
> ...
>
> >> +
> >> +    required:
> >> +      - reg
> >> +      - diff-channels
> >
> > Individual analog inputs can be used as single-ended or in pairs as
> > differential, right? If so, diff-channels should not be required to
> > allow for single-ended use.
> >
> > And we would need to add something like a single-ended-channel
> > property to adc.yaml to allow mapping analog input pins to channels
> > similar to how diff-channels works, I think (I don't see anything like
> > that there already)?
> >
> > So maybe something like:
> >
> > oneOf:
> >   - required:
> >       single-ended-channel
> >   - required:
> >       diff-channels
> >
> All channels must specify 2 analog input sources, there is no input
> source wired by default to AVSS.
>
> In my opinion, there is no need to specify channels as single-ended
> because that would require a property that specifies the input that is
> wired to AVSS.

Makes sense to me.
